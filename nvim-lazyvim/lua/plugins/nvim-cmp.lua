return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    -- add emoji support in markdown only
    cmp.setup.filetype({ "markdown" }, {
      sources = vim.tbl_extend("force", opts.sources, { { name = "emoji" } }),
    })

    -- complete with Tab(like usual IDEs)
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          end
          cmp.confirm()
        else
          fallback()
        end
      end, { "i" }),
    })
  end,
}
