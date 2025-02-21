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
        local names = vim.tbl_map(function(client)
          return client.name
        end, clients)
        return table.concat(names, " ") .. " 󰘧"
      end
      return "-"
    end

    local function copilot_status()
      if package.loaded["copilot"] and not require("copilot.client").is_disabled() then
        return " "
      end
      return " "
    end

    local function formatter_name()
      local has_conform, conform = pcall(require, "conform")
      local current_formatter = nil
      if not has_conform then
        return ""
      end
      local formatter_for_current_buffer = conform.list_formatters_to_run()
      if #formatter_for_current_buffer >= 1 then
        current_formatter = formatter_for_current_buffer[1].name
      end
      if not current_formatter then
        return ""
      end
      if vim.g.autoformat then
        return current_formatter .. "  "
      else
        return current_formatter .. "  "
      end
    end

    local function linter_name()
      local lint = require("lint")
      local linters = lint._resolve_linter_by_ft(vim.bo.filetype)
      if #linters == 0 then
        return ""
      end
      local linters_str = table.concat(linters, " ")
      local running_linters = require("lint").get_running()
      if #running_linters == 0 then
        return linters_str .. " 󰦕"
      end
      return linters_str .. " 󱉶"
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
          {
            "diagnostics",
            symbols = {
              error = vim.diagnostic.config().signs.text[vim.diagnostic.severity.ERROR],
              warn = vim.diagnostic.config().signs.text[vim.diagnostic.severity.WARN],
              info = vim.diagnostic.config().signs.text[vim.diagnostic.severity.INFO],
              hint = vim.diagnostic.config().signs.text[vim.diagnostic.severity.HINT],
            },
          },
        },
        lualine_x = { "searchcount", copilot_status, "encoding", "fileformat" },
        lualine_y = {
          formatter_name,
          linter_name,
          lsp_name,
          { "filetype", icon_only = true, padding = { left = 1, right = 0 } },
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
