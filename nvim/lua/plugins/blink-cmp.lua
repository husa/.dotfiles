return {
  "saghen/blink.cmp",
  version = "*",
  lazy = false, -- lazy loading handled internally
  dependencies = {
    "rafamadriz/friendly-snippets",
    "giuxtaposition/blink-cmp-copilot",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = {
      preset = "super-tab",
      -- ["<Esc>"] = { "cancel", "fallback" },
      -- ["<CR>"] = { "accept", "fallback" }
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      -- nerd_font_variant = "mono",
    },

    -- experimental auto-brackets support
    completion = {
      -- accept = { auto_brackets = { enabled = true } },

      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
        draw = {
          treesitter = { "lsp" },
          -- https://cmp.saghen.dev/recipes.html#mini-icons
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                if ctx.source_name == "copilot" then
                  ctx.kind = "copilot"
                end
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon .. " " .. ctx.kind
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                if ctx.source_name == "copilot" then
                  ctx.kind = "copilot"
                end
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
        -- border = "rounded",
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        -- window = { border = "rounded" },
      },
      ghost_text = {
        enabled = true,
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot" },
      cmdline = {},

      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },

    -- experimental signature help support
    signature = {
      enabled = true,
      -- window = {
      --   border = "rounded",
      --   treesitter_highlighting = false,
      -- },
    },
  },
}
