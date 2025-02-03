-- Тема catppuccin.
return {
  -- fix при установке темы
  -- https://github.com/LazyVim/LazyVim/issues/4756#issuecomment-2468254240
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {},
  },
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    -- you can do it like this with a config function
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
      }
    end,
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
}
