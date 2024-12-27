return {
  'nvim-telescope/telescope.nvim', -- Plugin repository
  dependencies = { 'nvim-lua/plenary.nvim' }, -- Telescope dependency
  config = function()
    require('telescope').setup({
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden', -- Include hidden files
          '--glob=!.git/**', -- Exclude `.git` directory and its contents
          '--glob=!node_modules/**', -- Exclude `node_modules` and its subdirectories
          '--glob=!dist/**', -- Add other generated folders to exclude
        },
        file_ignore_patterns = { "node_modules", "dist", "%.lock", "%.min.js", "%.git" },
      },
      pickers = {
        find_files = {
          hidden = true, -- Show hidden files in `find_files`
          file_ignore_patterns = { "node_modules", "dist", "%.lock", "%.git" },
        },
        live_grep = {
          additional_args = function(opts)
            return { "--hidden", "--glob=!.git/**", "--glob=!node_modules/**" }
          end,
        },
      },
    })
  end,
}
