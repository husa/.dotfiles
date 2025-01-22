return {
  "neovim/nvim-lspconfig",
  version = "*",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      cmd = "LazyDev",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local language_servers = {
      -- lua
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      -- yaml
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              -- default to kubernetes
              kubernetes = { "*.yml", "*.yaml" },
              -- github workflows
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              -- docker compose
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                "*compose.yml",
                "*compose.yaml",
              },
            },
          },
        },
      },
      -- js/ts
      vtsls = {},
      -- vue
      volar = {
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
      },
      -- python
      pyright = {},
      -- dockerfile
      dockerls = {},
      -- css
      cssls = {},
      somesass_ls = {},
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
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
        map("gr", require("telescope.builtin").lsp_references, "Goto References")
        map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
        map("gy", require("telescope.builtin").lsp_type_definitions, "Type Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gK", function()
          return vim.lsp.buf.signature_help()
        end, "Signature Help")

        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        map("<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
        map("<leader>cr", vim.lsp.buf.rename, "Rename")
      end,
    })
  end,
}
