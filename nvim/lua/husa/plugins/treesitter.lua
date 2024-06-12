return { 
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function () 
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },  
      autotag = { enable = true },
      ensure_installed = { 
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "xml",
        "html",
        "css",
        "graphql",
        "jsdoc",
        "markdown",
        "markdown_inline",
        "python",
        "toml",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "diff",
      },
    })
  end
}
