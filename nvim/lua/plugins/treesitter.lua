return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  lazy = false,
  config = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup()

    local ensure_installed = {
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "xml",
      "html",
      "css",
      "scss",
      "jsdoc",
      "markdown",
      "markdown_inline",
      -- "mermaid",
      "python",
      "toml",
      "bash",
      "fish",
      "lua",
      "vim",
      "vimdoc",
      "dockerfile",
      "gitignore",
      "diff",
      "terraform",
      "hcl",
      "sql",
      "properties",
      "java",
      "rust",
      "ron",
      -- temp
      "graphql",
      "vue",
      "ruby",
      "swift",
      "kotlin",
      "prisma",
    }

    treesitter.install(ensure_installed)
  end,
}
