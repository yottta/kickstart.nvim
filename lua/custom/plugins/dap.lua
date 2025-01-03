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
    keys = {
      {
        "<leader>dt",
        function()
          -- require('dap-go').debug_test()
          local test = require("dap-go-ts").closest_test()

          if test.name == "" or test.name == nil then
            vim.notify("no test found")
            return false
          end
          local env = "dummy" -- TODO: remove this
          local msg = string.format("starting debug session '%s : %s'...", test.package, test.name)
          vim.notify(msg)
          local dap = require("dap")
          dap.run({
            type = "go",
            name = test.name,
            request = "launch",
            mode = "test",
            program = test.package,
            args = { "-test.run", "^" .. test.name .. "$", "-stack=" .. env },
          })
        end,
        silent = true,
        desc = "Debug highlighted test",
      }
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "mortepau/codicons.nvim" },
    init = function()
      require("dapui").setup({
        controls = {
          element = "repl",
          enabled = true,
          icons = {
            disconnect = "disc",
            pause = "||",
            play = ">",
            run_last = "run_last",
            step_back = "step_back",
            step_into = "step_into",
            step_out = "step_out",
            step_over = "step_over",
            terminate = "terminate"
          }
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" }
          }
        },
        force_buffers = true,
        icons = {
          collapsed = "",
          current_frame = "",
          expanded = ""
        },
        layouts = { {
          elements = { {
            id = "scopes",
            size = 0.25
          }, {
            id = "breakpoints",
            size = 0.25
          }, {
            id = "stacks",
            size = 0.25
          }, {
            id = "watches",
            size = 0.25
          } },
          position = "left",
          size = 40
        }, {
          elements = { {
            id = "repl",
            size = 1
          } },
          position = "bottom",
          size = 10
        } },
        mappings = {
          edit = "e",
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          repl = "r",
          toggle = "t"
        },
        render = {
          indent = 1,
          max_value_lines = 100
        }
      })
    end,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        silent = true,
        desc = "[D]AP [U]I",
      },
      {
        "<M-k>",
        function()
          require("dapui").eval()
        end,
        silent = true,
        desc = "[D]ap [E]val",
      },
    },
    opts = {},
  },
  {
    "ofirgall/goto-breakpoints.nvim",
    event = "BufReadPre",
    keys = {
      {
        "]b",
        function()
          require('goto-breakpoints').next()
        end,
        silent = true,
        desc = "Next breakpoint",
      },
      {
        "[b",
        function()
          require('goto-breakpoints').prev()
        end,
        silent = true,
        desc = "Previous breakpoint",
      },
    },
    dependencies = "mfussenegger/nvim-dap",
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPre",
    opts = {
      load_breakpoints_event = { "BufReadPost" },
    },
    keys = {
      {
        "<leader>b",
        function()
          require("persistent-breakpoints.api").toggle_breakpoint()
        end,
        silent = true,
        desc = "Toggle breakpoint",
      },
    },
    dependencies = "mfussenegger/nvim-dap",
  }
}
