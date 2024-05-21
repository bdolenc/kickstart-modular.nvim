-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      -- make a group to be able to delete it later
      group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
      callback = function()
        local f = vim.fn.expand '%:p'
        if vim.fn.isdirectory(f) ~= 0 then
          vim.cmd('Neotree current dir=' .. f)
          -- neo-tree is loaded now, delete the init autocmd
          vim.api.nvim_clear_autocmds { group = 'NeoTreeInit' }
        end
      end,
    })
  end,
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db"
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
