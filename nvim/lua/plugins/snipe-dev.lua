return {
  dir = "~/Projects/snipe.nvim",
  name = "snipe-dev",
  version = "*",
  enabled = false,
  keys = {
    {
      "<leader>v",
      function()
        require("snipe").open_buffer_menu()
      end,
      desc = "Snipe [dev]",
    },
  },
  config = function()
    require("snipe").setup({
      ui = {
        text_align = "file-first",
        open_win_override = {
          border = "rounded",
        },
        -- buffer_format = {
        --   function()
        --     return "->", "Comment"
        --   end,
        --   function(buf)
        --     local full_name = vim.fn.bufname(buf.id)
        --     if vim.fn.isdirectory(full_name) and vim.uv.cwd() == full_name then
        --       return "", "String"
        --     end
        --     if buf.dirname == "." then
        --       return nil
        --     end
        --     return buf.dirname, "Comment"
        --   end,
        --   function(buf)
        --     if vim.fn.isdirectory(vim.fn.bufname(buf.id)) == 1 then
        --       return buf.basename
        --     end
        --     local dot_index = string.find(buf.basename, "%.") --[[@as integer]]
        --     return string.sub(buf.basename, 1, dot_index - 1)
        --   end,
        --   function(buf)
        --     if vim.fn.isdirectory(vim.fn.bufname(buf.id)) == 1 then
        --       return nil
        --     end
        --     return MiniIcons.get("file", buf.basename)
        --   end,
        -- },
        preselect = require("snipe").preselect_by_classifier("#"),
      },
    })
  end,
}
