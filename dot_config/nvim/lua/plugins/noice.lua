-- Красивый UI
-- TODO: пофиксить ошибку
-- Highlight group 'NotifyBackground' has no background highlight
-- Please provide an RGB hex value or highlight group with a background value for 'background_colour' option.
-- This is the colour that will be used for 100% transparency.
-- ```lua
-- require("notify").setup({
--   background_colour = "#000000",
-- })
-- ```
-- Defaulting to #000000
--
-- TODO: оптимизировать конфиг м
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- add any options here
    background_colour = '#000000',
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
}
