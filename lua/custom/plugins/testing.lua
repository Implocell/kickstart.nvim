return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
    'Issafalcon/neotest-dotnet',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-dotnet' {
          dap = {
            -- This allows you to debug tests using the setup we did earlier
            args = { justMyCode = false },
            adapter_name = 'netcoredbg',
          },
          -- Discovery settings
          discovery_root = 'solution', -- "project" is also an option but can be faster
        },
        require 'neotest-vitest' {
          -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
        },
      },
    }
    local map = vim.keymap.set
    map('n', '<leader>tr', function()
      require('neotest').run.run()
    end, { desc = '[T]est [R]un nearest' })
    map('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = '[T]est [F]ile' })
    map('n', '<leader>td', function()
      require('neotest').run.run { strategy = 'dap' }
    end, { desc = '[T]est [D]ebug nearest' })
    map('n', '<leader>ts', function()
      require('neotest').summary.toggle()
    end, { desc = '[T]est [S]ummary' })
    map('n', '<leader>to', function()
      require('neotest').output.open { enter = true }
    end, { desc = '[T]est [O]utput' })
  end,
}
