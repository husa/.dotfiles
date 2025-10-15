return {
  "neovim/nvim-lspconfig",
  version = "*",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { "williamboman/mason.nvim", opts = {} }, -- NOTE: Must be loaded before dependants
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- automatically install LSPs and related tools
    "williamboman/mason-lspconfig.nvim", -- used only by "mason-tool-installer" to convert LSP names to mason package names
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
  config = function(_)
    ---@type table<string, vim.lsp.Config>
    local language_servers = {
      -- lua
      lua_ls = {
        settings = {
          lua = {
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
              -- ["https://json.schemastore.org/github-workflow.json"] = {
              --   "/.github/workflows/*.yml",
              --   "/.github/workflows/*.yaml",
              --   "/.gitea/workflows/*.yml",
              --   "/.gitea/workflows/*.yaml",
              -- },
              -- docker compose
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                "*compose.yml",
                "*compose.yaml",
              },
              ["https://raw.githubusercontent.com/lalcebo/json-schema/master/serverless/reference.json"] = {
                "serverless.yml",
                "serverless.yaml",
              },
            },
          },
        },
      },
      -- json schemas validation
      jsonls = {
        capabilities = {
          textDocument = { completion = { completionItem = { snippetSupport = true } } },
        },
        settings = {
          json = {
            schemas = {
              {
                fileMatch = { "package.json" },
                url = "https://json.schemastore.org/package",
              },
              {
                fileMatch = { "tsconfig*.json" },
                url = "https://json.schemastore.org/tsconfig",
              },
            },
          },
        },
      },
      -- js/ts
      vtsls = {},
      eslint = {},
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

    -- Vue
    -- add vue-language-server and add to TS server
    language_servers["vue_ls"] = {}
    language_servers.vtsls = require("utils").deep_extend(language_servers.vtsls, {
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              {
                name = "@vue/typescript-plugin",
                location = vim.fn.stdpath("data")
                  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
              },
            },
          },
        },
      },
    })

    -- additional LSPs that should not be installed via mason
    local additional_language_servers = {
      -- Swift
      sourcekit = {},
    }

    -- additional linters/formatters/DAPs to install
    local tools = {
      -- formatters
      "stylua",
      "prettier",
      -- linters
      -- "eslint_d", -- replaced by eslint LSP
      "tflint",
      -- DAPs
      "js-debug-adapter",
    }

    require("mason").setup({
      ui = {
        border = "rounded",
      },
    })

    local ensure_installed = vim.tbl_keys(language_servers or {})
    vim.list_extend(ensure_installed, tools)

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
    })

    local lsps = vim.tbl_extend("force", language_servers, additional_language_servers)

    -- configure LSPs
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    for server_name, server in pairs(lsps) do
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      vim.lsp.config(server_name, server)
    end
    -- enable all LSPs
    vim.lsp.enable(vim.tbl_keys(lsps))

    -- configure diagnostics
    vim.diagnostic.config({
      float = {
        source = true,
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
        map("gR", function()
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

        map("<leader>ca", function()
          -- force all code actions
          vim.lsp.buf.code_action({
            -- context = {
            --   only = { "quickfix", "source", "refactor", "notebook" },
            -- },
          })
        end, "Code Action", { "n", "x" })
        map("<leader>cs", function()
          require("snacks").picker.lsp_symbols({
            layout = { preset = "vertical", preview = "main" },
            sort = { fields = { "idx" } },
            filter = {
              default = {
                "Class",
                "Constructor",
                "Function",
                "Variable", -- include variables
                "Enum",
                "Field",
                "Interface",
                "Method",
                "Module",
                "Namespace",
                "Package",
                "Property",
                "StaticMethod",
                "Struct",
                "Trait",
              },
            },
          })
        end, "LSP Symbols")
        map("<leader>cS", function()
          require("snacks").picker.lsp_workspace_symbols()
        end, "LSP Workspace Symbols")
        map("<leader>cr", vim.lsp.buf.rename, "Rename")
      end,
    })
  end,
}
