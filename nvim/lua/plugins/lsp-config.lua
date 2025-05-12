return {
  "neovim/nvim-lspconfig",
  version = "*",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
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
  config = function(_)
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
    if false then
      language_servers["volar"] = {
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
      }
      local Utils = require("utils")
      local vuels_package = require("mason-registry").get_package("vue-language-server")
      if vuels_package ~= nil then
        print(vim.inspect(vuels_package))
        local vuels_package_path = vuels_package:get_install_path()
        local vtsls_defaults = require("lspconfig.configs.vtsls").default_config
        local vtsls_with_defaults = Utils.deep_extend(vtsls_defaults, language_servers.vtsls)
        language_servers.vtsls = Utils.deep_extend(vtsls_with_defaults, {
          filetypes = { "vue" },
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = vuels_package_path .. "/node_modules/@vue/language-server",
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
            },
          },
        })
      end
    end

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

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    for server_name, server in pairs(language_servers) do
      capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      server.capabilities = capabilities
      vim.lsp.config(server_name, server)
    end

    local ensure_installed = vim.tbl_keys(language_servers or {})
    vim.list_extend(ensure_installed, tools)

    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
      automatic_installation = true,
      automatic_enable = true,
    })

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
          require("snacks").picker.lsp_symbols({
            layout = { preset = "vertical", preview = "main" },
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
