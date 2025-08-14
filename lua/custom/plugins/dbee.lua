-- dbee database client for NeoVim

return {
  'kndndrj/nvim-dbee',
  -- 'mosqueteiro/nvim-dbee',
  -- dir = '~/Projects/nvim-dbee'
  -- event = 'VeryLazy'
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  build = function()
    -- Install tries to automatically detect the install method
    -- If it fails, try calling it with one of these parameters:
    --   "curl", "wget", "bitsadmin", "go"
    require('dbee').install 'go'
  end,
  config = function()
    require('dbee').setup {}
  end,
}
