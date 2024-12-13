return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  event = "VeryLazy",
  config = function()
    local function lsp_name()
      local clients = vim.lsp.get_clients({ bufnr = 0 })

      if clients ~= nil and #clients >= 1 then
        return clients[1].name
      end
      return "-"
    end

    local opts = {
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "diagnostics" },
        lualine_x = { "searchcount", "encoding", "fileformat" },
        lualine_y = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { lsp_name, separator = "" },
        },
        lualine_z = {
          {
            "progress",
            separator = "",
            padding = { left = 1, right = 0 },
          },
          {
            "location",
            padding = { left = 0 },
          },
        },
      },
      tabline = {
        lualine_b = { { "filename", path = 1, symbols = { modified = " " } } },
      },
    }
    require("lualine").setup(opts)
  end,
}
