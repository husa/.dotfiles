return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    -- shortcuts
    { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find String" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    {
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    -- find file
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find String" },
    { "<leader>fo", "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Find Old Files" },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Find Buffers" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find Todos" },
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume Last Search" },
    { "<leader>fT", "<cmd>Telescope<cr>", desc = "Telescope" },
    {
      "<leader>fc",
      function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end,
      desc = "Config files",
    },

    { "<leader>ut", "<cmd>Telescope filetypes<cr>", desc = "Filetype" },

    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },
    { "<leader>sG", "<cmd>Telescope grep_string<cr>", desc = "Grep (cwd)" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
    { "<leader>s/", "<cmd>Telescope search_history<cr>", desc = "Quickfix List" },

    -- utils
    { "<leader>uC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme with Preview" },

    -- LSP
    -- {
    --   "<leader>ss",
    --   function()
    --     require("telescope.builtin").lsp_document_symbols({
    --       symbols = LazyVim.config.get_kind_filter(),
    --     })
    --   end,
    --   desc = "Goto Symbol",
    -- },
    -- {
    --   "<leader>sS",
    --   function()
    --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
    --       symbols = LazyVim.config.get_kind_filter(),
    --     })
    --   end,
    --   desc = "Goto Symbol (Workspace)",
    -- },
  },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
        file_ignore_patterns = {
          "package%-lock%.json",
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- show hidden files in results
        },
        colorscheme = {
          enable_preview = true,
        },
      },
    }
  end,
}
