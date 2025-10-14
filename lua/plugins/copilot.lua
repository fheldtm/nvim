-- GitHub Copilot AI 코드 자동완성
return {
  'github/copilot.vim',
  event = "InsertEnter",
  config = function()
    -- Copilot 기본 설정
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true

    -- 키맵 설정
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      desc = "Copilot Accept"
    })

    vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)', {
      desc = "Copilot Accept Word"
    })

    vim.keymap.set('i', '<C-H>', '<Plug>(copilot-dismiss)', {
      desc = "Copilot Dismiss"
    })

    vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)', {
      desc = "Copilot Next Suggestion"
    })

    vim.keymap.set('i', '<C-[>', '<Plug>(copilot-previous)', {
      desc = "Copilot Previous Suggestion"
    })
  end
}
