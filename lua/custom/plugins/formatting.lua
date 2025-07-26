return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  config = function()
    local util = require 'conform.util'
    require('conform').setup {
      formatters = {
        prettier = {
          require_cwd = true,
          cwd = util.root_file {
            '.prettierrc',
            '.prettierrc.json',
            '.prettierrc.yml',
            '.prettierrc.yaml',
            '.prettierrc.json5',
            '.prettierrc.js',
            '.prettierrc.cjs',
            '.prettierrc.mjs',
            '.prettierrc.toml',
            'prettier.config.js',
            'prettier.config.cjs',
            'prettier.config.mjs',
          },
        },
        biome = {
          require_cwd = false,
          cwd = util.root_file {
            'biome.json',
          },
        },
        csharpier = {
          command = 'csharpier',
          -- args = { '--stdin' },
          -- stdin = true,
        },

        stylua = {
          prepend_args = { '--indent-type', 'Spaces', '--indent-width', '2' },
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format', 'ruff_fix', 'ruff_organize_imports' },
        rust = { 'rustfmt' },
        javascript = { 'biome', 'prettier' },
        typescript = { 'biome', 'prettier' },
        svelte = { 'biome', 'prettier' },
        astro = { 'biome', 'prettier' },
        tsx = { 'biome', 'prettier' },
        markdown = { 'prettier' },
        yaml = { 'prettier' },
        typescriptreact = { 'biome', 'prettier' },
        javascriptreact = { 'biome', 'prettier' },
        go = { 'gofmt' },
        jsx = { 'biome', 'prettier' },
        vue = { 'biome', 'prettier' },
        html = { 'biome', 'prettier' },
        sql = { 'sleek' },
        json = { 'biome', 'prettier' },
        cs = { 'csharpier' },
      },
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
    }
  end,
}
