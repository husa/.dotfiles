return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>ee", "<cmd>Neotree reveal toggle<CR>", desc = "Neotree" }, -- toggle file explorer
    { "<leader>eg", "<cmd>Neotree git_status toggle<CR>", desc = "Neotree Git" }, -- toggle file explorer
    { "<leader>eb", "<cmd>Neotree buffers toggle<CR>", desc = "Neotree Buffers" },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
        },
        never_show = {
          ".DS_Store",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
    },
    window = {
      mappings = {
        ["<Right>"] = "open",
        ["<Left>"] = "close_node",
        ["<space>"] = "none",
        -- ["P"] = { "toggle_preview" },
      },
    },
    hijack_netrw_behavior = "disabled",
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      git_status = {
        symbols = {
          unstaged = "󰄱",
          staged = "󰱒",
        },
      },
    },
  },
}
