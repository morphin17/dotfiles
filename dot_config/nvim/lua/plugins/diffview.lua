-- Просмтр diff'ов разных коммитов.
-- TODO: познакомиться поближе, глянуть лучшие практики.
return {
  'sindrets/diffview.nvim', -- optional - Diff integration
  config = function()
    require('diffview').setup {
      diff_binaries = true,
      default_args = { -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = { '--imply-local' },
      },
    }
  end,
  keys = {
    { '<leader>gD', '<cmd>DiffviewOpen master<cr>', mode = { 'n', 'v' }, desc = 'Diff with master' },
    { '<leader>gd', '<cmd>DiffviewOpen HEAD~1<cr>', mode = { 'n', 'v' }, desc = 'Diff with last commit' },
  },
}
