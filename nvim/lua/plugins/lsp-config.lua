return {
  "neovim/nvim-lspconfig",
  version = "*",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    local language_servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              kubernetes = { "*.yml", "*.yaml" },
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
          },
        },
      },
      vtsls = {},
    }

    local tools = {
      "stylua",
      "prettier",
      "eslint_d",
      "tflint",
    }

    require("mason").setup({
      ui = {
        border = "rounded",
      },
    })

    local ensure_installed = vim.tbl_keys(language_servers or {})
    vim.list_extend(ensure_installed, tools)

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = language_servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          server.capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities)
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")

        -- Find references for the word under your cursor.
        map("gr", require("telescope.builtin").lsp_references, "Goto References")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("gy", require("telescope.builtin").lsp_type_definitions, "Type Definition")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>cr", vim.lsp.buf.rename, "Rename")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
      end,
    })
  end,
}
