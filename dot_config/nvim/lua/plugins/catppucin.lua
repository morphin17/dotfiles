return {
  -- fix
  -- https://github.com/LazyVim/LazyVim/issues/4756#issuecomment-2468254240
  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   opts = {},
  -- },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = {
      colorscheme = "catppuccin",
      transparent_background = true,
      float = {
        transparent = true, -- enable transparent floating windows
        solid = true, -- use solid styling for floating windows, see |winborder|
      },
    },
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
