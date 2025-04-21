-- https://github.com/nvim-telescope/telescope.nvim
-- telescope를 사용하여 파일 찾기, 새 파일 찾기, 버퍼 찾기, 도움말 태그 찾기, 오래된 파일 찾기 등을 사용할 수 있습니다.
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      ";f",
      function()
        require('telescope.builtin').find_files()
      end,
      "Find Files"
    },
    {
      ";g",
      function()
        require('telescope.builtin').live_grep()
      end,
      "Live Grep"
    },
    {
      ";b",
      function()
        require('telescope.builtin').buffers({
          sort_lastused = true
        })
      end,
      "Find From Buffers"
    },
    {
      ";t",
      function()
        require('telescope.builtin').help_tags()
      end,
      "help tags"
    },
    {
      ";e",
      function()
        require('telescope.builtin').diagnostics({
          severity = vim.diagnostic.severity.ERROR
        })
      end,
      "Diagnostic"
    },
    {
      ";r",
      function()
        require('telescope.builtin').oldfiles({
          cwd_only = true
        })
      end,
      "Old files"
    }
  }
}
