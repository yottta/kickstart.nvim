vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local config = {
  filesystem = {
    follow_current_file = {
      enabled = false, -- This will find and focus the file in the active buffer every time
    },
  }
}
return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup { config }
  end,
}
