-- Плагин автоформатирования
--
local formatters_global_args = {
  stylua = '',
  markdownlint = '-fix',
}

local function get_unique_filetypes()
  local filetypes = {}
  local handle = io.popen 'find . -type f' -- Find all files in the current directory and subdirectories
  if handle then
    for filename in handle:lines() do
      local ft = vim.filetype.match { filename = filename }
      if ft and not filetypes[ft] then
        filetypes[ft] = true
      end
    end
    handle:close()
  end
  return vim.tbl_keys(filetypes)
end

local format_working_directory = function()
  local filetypes = get_unique_filetypes()
  local conform = require 'conform'
  local formatters_by_ft = conform.formatters_by_ft

  local filter_formatters = function(ft, fs)
    local f = fs[ft]

    if not f then
      return
    end

    if type(f) == 'function' then
      return
    end

    for _, fi in ipairs(f) do
      if type(fi) == 'string' then
        return fi
      end
    end
  end

  for _, ft in ipairs(filetypes) do
    local formatter = filter_formatters(ft, formatters_by_ft)
    if formatter then
      local msg = require('fidget.progress').handle.create {
        title = 'fmt: ' .. formatter,
        message = '.',
        lsp_client = { name = '>>' }, -- the fake lsp client name
        percentage = nil, -- skip percentage field
      }

      local cmd = '!' .. vim.fn.exepath(formatter) .. ' ' .. formatters_global_args[formatter] .. ' ' .. vim.fn.getcwd()

      vim.cmd(cmd)

      msg:finish()
    end
  end
end

local init_msg_progress = function()
  local formatters = require('conform').list_formatters_to_run()
  local fmt_names = vim.tbl_map(function(f)
    return f.name
  end, formatters)
  local fmt_info = 'fmt: ' .. table.concat(fmt_names, '/')

  return require('fidget.progress').handle.create {
    title = fmt_info,
    message = vim.fn.expand '%',
    lsp_client = { name = '>>' }, -- the fake lsp client name
    percentage = nil, -- skip percentage field
  }
end

return { -- Autoformat
  'stevearc/conform.nvim',
  -- event = { 'BufWritePre' },
  event = 'VimEnter',
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        local msg_handle = init_msg_progress()

        require('conform').format({ async = true, lsp_format = 'fallback' }, function(err)
          msg_handle:finish()
        end)
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>F',
      format_working_directory,
      mode = '',
      desc = '[F]ormat working directory',
    },
    {
      '<leader>fi',
      function()
        require('conform.health').show_window()
      end,
      mode = '',
      desc = '[F]ormat [I]nfo',
    },
    {
      '<leader>tf',
      function()
        -- If autoformat is currently disabled for this buffer,
        -- then enable it, otherwise disable it
        if vim.b.disable_autoformat then
          vim.cmd 'FormatEnable'
          vim.notify 'Enabled autoformat for current buffer'
        else
          vim.cmd 'FormatDisable!'
          vim.notify 'Disabled autoformat for current buffer'
        end
      end,
      desc = '[T]oggle auto[f]ormat for current buffer',
    },
    {
      '<leader>tF',
      function()
        -- If autoformat is currently disabled globally,
        -- then enable it globally, otherwise disable it globally
        if vim.g.disable_autoformat then
          vim.cmd 'FormatEnable'
          vim.notify 'Enabled autoformat globally'
        else
          vim.cmd 'FormatDisable'
          vim.notify 'Disabled autoformat globally'
        end
      end,
      desc = '[T]oggle auto[F]ormat globally',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end

      local msg_handle = init_msg_progress()

      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }, function(err)
        msg_handle:finish()
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      markdown = { 'markdownlint' },
      -- python = { "black" },
      -- javascript = { { "prettierd", "prettier" } },
      -- typescript = { { "prettierd", "prettier" } },
      -- typescriptreact = { { "prettierd", "prettier" } },
      -- javascriptreact = { { "prettierd", "prettier" } },
      -- css = { { "prettierd", "prettier" } },
      -- cs = { "csharpier" },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- :FormatDisable! disables autoformat for this buffer only
        vim.b.disable_autoformat = true
      else
        -- :FormatDisable disables autoformat globally
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true, -- allows the ! variant
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end,
}
