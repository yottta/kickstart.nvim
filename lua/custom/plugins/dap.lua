return {
  {
    "mfussenegger/nvim-dap", -- debug addapter protocol
    init = function()
      vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
    end,
    keys = {
      {
        "<F9>",
        function()
          require("dap").continue()
        end,
        silent = true,
        desc = "Resume debugging session",
      },
      {
        "<F8>",
        function()
          require("dap").step_over()
        end,
        silent = true,
        desc = "Step over",
      },
      {
        "<F7>",
        function()
          require("dap").step_into()
        end,
        silent = true,
        desc = "Step into",
      },
      {
        "<S-F8>",
        function()
          require("dap").step_out()
        end,
        silent = true,
        desc = "Step out",
      },
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
        silent = true,
        desc = "Toggle breakpoint",
      },
    },
  },

  {
    "leoluz/nvim-dap-go", -- debug adapter for go/dlv
    init = function()
      require("dap-go").setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        silent = true,
        desc = "[D]AP [U]I",
      },
    },
    opts = {},
  },
  -- TODO figure it out why this is not working
  -- vim.keymap.set('v', 'C-r', '<cmd>lua require("dapui").eval()<CR>', { desc = '[D]apUI [E]val' })
}
