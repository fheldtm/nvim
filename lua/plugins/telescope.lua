return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      ";f",
      function ()
        require('telescope.builtin').find_files()
      end,
      "Find Files"
    },
    {
      ";g",
      function ()
        require('telescope.builtin').live_grep()
      end,
      "Live Grep"
    },
    {
      ";b",
      function ()
        require('telescope.builtin').buffers()
      end,
      "Find From Buffers"
    },
    {
      ";t",
      function ()
        require('telescope.builtin').help_tags()
      end,
      "help tags"
    }
  }
}
