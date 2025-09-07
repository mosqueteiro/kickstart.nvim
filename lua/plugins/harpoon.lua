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
  keys = function()
    local harpoon = require 'harpoon'
    local keys = {
      -- { '<leader>H', group = '[H]arpoon group' },
      {
        '<leader>Hl',
        function()
          -- local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon [l]ist',
      },
      {
        '<leader>HD',
        function()
          -- local harpoon = require 'harpoon'
          harpoon:list():clear()
        end,
        desc = 'Harpoon [D]elete list',
      },
      {
        '<leader>Hd',
        function()
          vim.ui.input({ prompt = 'Delete which index? ' }, function(input)
            -- local harpoon = require 'harpoon'
            local idx = tonumber(input)
            if idx then
              if idx == 0 then
                idx = 10
              end
              harpoon:list():remove_at(idx)
            else
              harpoon:list():remove()
            end
          end)
        end,
        desc = '[d]elete item [#] from harpoon list',
      },
      {
        '<leader>Ha',
        function()
          vim.ui.input({ prompt = 'Add to which index? ' }, function(input)
            -- local harpoon = require 'harpoon'
            local idx = tonumber(input)
            if idx then
              if idx == 0 then
                idx = 10
              end
              harpoon:list():replace_at(idx)
            else
              harpoon:list():add()
            end
          end)
        end,
        desc = '[a]dd to harpoon list [#]',
      },
      -- Maybe add keys for prev and next
    }

    for i = 0, 9 do
      local num = i
      table.insert(keys, {
        '<leader>' .. num,
        function()
          if num == 0 then
            num = 10
          end
          harpoon:list():select(num)
        end,
        desc = 'harpoon list[' .. (num ~= 0 and num or 10) .. ']',
      })
    end

    return keys
  end,
}
