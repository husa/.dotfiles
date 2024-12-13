return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
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
          ".DS_Store",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      use_libuv_file_watcher = true,
    },
    hijack_netrw_behavior = "open_current",
    window = {
      position = "left",
      mappings = {
        ["<space>"] = "none",
        ["<Right>"] = "open",
        ["<Left>"] = "close_node",
        ["l"] = "open",
        ["h"] = "close_node",
        ["P"] = { "toggle_preview", config = { use_float = false } },
      },
    },
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
  keys = {
    { "<leader>ee", "<cmd>Neotree reveal toggle<CR>", desc = "File explorer" }, -- toggle file explorer
    { "<leader>eg", "<cmd>Neotree git_status toggle<CR>", desc = "Git explorer" }, -- toggle file explorer
    { "<leader>eb", "<cmd>Neotree buffers toggle<CR>", desc = "Buffers explorer" },
  },
}
