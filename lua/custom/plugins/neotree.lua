vim.keymap.set('n', '<leader>ts', '<Cmd>Neotree toggle<CR>', { desc = 'Open [N]eo[t]ree' })

return {
  "nvim-neo-tree/neo-tree.nvim",
  -- version = "*",
  branch = "main",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  init = function ()
    vim.g.neo_tree_remove_legacy_commands = true
  end,
  opts = function ()
    return {
      filesystem = {
        follow_current_file = { enabled = true },
      },
    }
  end
  -- config = function()
  --   require('neo-tree').setup { config }
  -- end,
}

