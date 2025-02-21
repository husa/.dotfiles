return {
  "nvim-lualine/lualine.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local function lsp_name()
      local clients = vim.tbl_filter(function(client)
        return client.name ~= "copilot"
      end, vim.lsp.get_clients({ bufnr = 0 }))
      if clients ~= nil and #clients >= 1 then
        return clients[1].name
      end
      return "-"
    end

    local function autoformat_enabled()
      if vim.g.autoformat then
        return ""
      end
      return ""
    end

    local function copilot_status()
      if package.loaded["copilot"] and not require("copilot.client").is_disabled() then
        return " "
      end
      return " "
    end

    local opts = {
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = {
          { "filename", path = 1, separator = "", padding = { left = 1, right = 0 } },
          "diff",
          "diagnostics",
        },
        lualine_x = { "searchcount", copilot_status, autoformat_enabled, "encoding", "fileformat" },
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
    }
    require("lualine").setup(opts)
  end,
}
