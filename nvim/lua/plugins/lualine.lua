return {
  "nvim-lualine/lualine.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local function format_brachname(branchname)
      local limit = 20
      if #branchname <= limit then
        return branchname
      end
      return branchname:sub(1, limit - 3) .. "..."
    end

    local function lsp_name()
      ---@type vim.lsp.Client[]
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

    local function ai_status()
      -- TODO: check for codeium status, icons could be 󱙺 and 󱙻
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

    local diagnostic_signs = vim.diagnostic.config().signs
    local has_diagnostic_signs = diagnostic_signs and diagnostic_signs.text
    local diagnostic_symbols = {
      error = has_diagnostic_signs and diagnostic_signs.text[vim.diagnostic.severity.ERROR] or "",
      warn = has_diagnostic_signs and diagnostic_signs.text[vim.diagnostic.severity.WARN] or "",
      info = has_diagnostic_signs and diagnostic_signs.text[vim.diagnostic.severity.INFO] or "",
      hint = has_diagnostic_signs and diagnostic_signs.text[vim.diagnostic.severity.HINT] or "",
    }

    local opts = {
      options = {
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { left = "", right = "" },
            padding = { left = 0, right = 0 },
          },
        },
        lualine_b = { { "branch", fmt = format_brachname, icon = "", padding = { left = 1, right = 0 } } },
        lualine_c = {
          { "filetype", separator = "", icon_only = true, padding = { left = 1, right = 0 } },
          {
            "filename",
            path = 1,
            separator = "",
            file_status = true,
            symbols = {
              modified = "",
              readonly = "",
              unnamed = "[No Name]",
            },
            padding = { left = 0, right = 0 },
            color = function()
              if vim.bo.modified then
                return "WarningMsg"
              else
                return "lualine_c_normal"
              end
            end,
          },
          "diff",
          {
            "diagnostics",
            symbols = diagnostic_symbols,
          },
        },
        lualine_x = { "searchcount", ai_status, "encoding", "fileformat" },
        lualine_y = {
          formatter_name,
          linter_name,
          lsp_name,
        },
        lualine_z = {
          {
            "progress",
            separator = "",
            padding = { left = 0, right = 0 },
          },
          {
            "location",
            separator = { left = "", right = "" },
            padding = { left = 1, right = 0 },
          },
        },
      },
    }
    require("lualine").setup(opts)
  end,
}
