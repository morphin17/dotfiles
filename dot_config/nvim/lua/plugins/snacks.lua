return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true, -- for hidden files
        ignored = true, -- for .gitignore files
        sources = {
          explorer = {
            layout = {
              auto_hide = { "input" },
            },
          },
        },
      },
      explorer = {
        files = {
          hidden = true,
          ignored = true, -- for .gitignore files
        },
      },
    },
  },
}
