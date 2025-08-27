-- Harpoon, custom jump lists for NeoVim
--
-- ToDo:
--  - add functionality to save specific lines to jump to
--  - Change UI to Telescope

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-telescope/telescope.nvim',
  },
  opts = {},
  keys = {
    {
      '<leader>j',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Harpoon [j]ump list',
    },
    {
      '<leader>aj',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():add()
      end,
      desc = 'Harpoon [a]dd to [j]ump list',
    },
    {
      '<leader>1',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(1)
      end,
      desc = 'Jump list [1]',
    },
    {
      '<leader>2',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(2)
      end,
      desc = 'Jump list [2]',
    },
    {
      '<leader>3',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(3)
      end,
      desc = 'Jump list [3]',
    },
    {
      '<leader>4',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(4)
      end,
      desc = 'Jump list [4]',
    },
    -- Maybe add keys for prev and next
  },
}
