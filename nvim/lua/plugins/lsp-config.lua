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
  config = function(opts)
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
              ["https://json.schemastore.org/github-workflow.json"] = {
                "**/.github/workflows/*.yml",
                "**/.github/workflows/*.yaml",
                "**/.gitea/workflows/*.yml",
                "**/.gitea/workflows/*.yaml",
              },
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
      -- terraform
      terraformls = {},
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

          -- add rounded borders for hover/signature Help/diagnostics
          vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
          })
          vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
          })
          vim.diagnostic.config({
            float = {
              border = "rounded",
              source = "if_many",
            },
            virtual_text = {
              spacing = 4,
              -- source = "if_many",
              prefix = "●",
            },
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.HINT] = " ",
                [vim.diagnostic.severity.INFO] = " ",
              },
            },
          })
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

        map("gd", function()
          Snacks.picker.lsp_definitions()
        end, "Goto Definition")
        map("gD", function()
          Snacks.picker.lsp_declarations()
        end, "Goto Declaration")
        map("gr", function()
          Snacks.picker.lsp_references()
        end, "References")
        map("gI", function()
          Snacks.picker.lsp_implementations()
        end, "Goto Implementation")
        map("gy", function()
          Snacks.picker.lsp_type_definitions()
        end, "Goto T[y]pe Definition")
        map("gK", function()
          return vim.lsp.buf.signature_help()
        end, "Signature Help")

        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("<leader>cs", function()
          Snacks.picker.lsp_symbols()
        end, "LSP Symbols")
        map("<leader>cS", function()
          Snacks.picker.lsp_workspace_symbols()
        end, "LSP Workspace Symbols")
        map("<leader>cr", vim.lsp.buf.rename, "Rename")
      end,
    })
  end,
}
