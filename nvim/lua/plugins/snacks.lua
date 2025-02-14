return {
  "folke/snacks.nvim",
  version = "*",
  -- priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bufdelete = { enabled = true },
    statuscolumn = { enabled = true },
    zen = { enabled = true },
    explorer = {
      replace_netrw = false, -- Replace netrw with the snacks explorer
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".DS_Store" },
          win = {
            list = {
              keys = {
                ["<Left>"] = "explorer_close",
                ["<Right>"] = "confirm",
              },
            },
          },
        },
      },
    },
  },
  keys = {
    -- buf delete
    { "<leader>bd", "<cmd>:lua Snacks.bufdelete()<cr>", mode = "n", desc = "Delete Buffer" },
    { "<leader>bo", "<cmd>:lua Snacks.bufdelete.other()<cr>", mode = "n", desc = "Delete Other Buffers" },
    { "<leader>ba", "<cmd>:lua Snacks.bufdelete.all()<cr>", mode = "n", desc = "Delete All Buffers" },
    { "<leader>bD", "<cmd>:bdelete<cr>", mode = "n", desc = "Delete Buffer and Window" },

    -- zen
    {
      "<leader>uz",
      function()
        Snacks.zen.zen()
      end,
      desc = "Zen Mode",
    },
    {
      "<leader>uZ",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Zoom Mode",
    },

    -- explorer
    {
      "\\",
      function()
        Snacks.explorer.open()
      end,
      mode = "n",
      desc = "Explorer",
    },
    {
      "|",
      function()
        Snacks.explorer.open({ focus = "input" })
      end,
      mode = "n",
      desc = "Explorer (Find)",
    },

    -- pickers
    -- most used
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>n",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    -- find
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>fl",
      function()
        Snacks.picker.files({
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
        })
      end,
      desc = "Find Plugin file",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search History",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = "Search for Plugin Spec",
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    -- utils
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>ut",
      function()
        local filetypes = vim.fn.getcompletion("", "filetype")
        vim.ui.select(filetypes, {
          title = "Select Filetype",
        }, function(selected)
          vim.bo.filetype = selected
        end)
      end,
      desc = "Set filetype",
    },
  },
}
