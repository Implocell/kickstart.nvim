return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    lazygit = { enabled = true },
    git = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    gitbrowse = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    image = { enabled = true },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 75, total = 150 },
      },
    },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'LazyGit',
    },
    {
      '<leader>go',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Blame',
    },
  },
}
