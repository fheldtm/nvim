return {
  "kkoomen/vim-doge",
  build = ":call doge#install()",
  event = "BufReadPost",
  config = function()
    -- vim-doge 설정
    vim.g.doge_enable_mappings = 1
    
    -- 언어별 문서 표준 설정
    vim.g.doge_doc_standard_python = 'numpy'
    vim.g.doge_doc_standard_javascript = 'jsdoc'
    vim.g.doge_doc_standard_typescript = 'jsdoc'
    vim.g.doge_doc_standard_lua = 'ldoc'
    
    -- JavaScript/TypeScript 설정
    vim.g.doge_javascript_settings = {
      destructuring_props = 1,
      omit_redundant_param_types = 0
    }
    
    -- 키매핑
    vim.keymap.set('n', '<leader>d', '<Plug>(doge-generate)', { desc = "Generate documentation" })
    vim.keymap.set('i', '<Tab>', '<Plug>(doge-comment-jump-forward)', { desc = "Jump to next TODO" })
    vim.keymap.set('i', '<S-Tab>', '<Plug>(doge-comment-jump-backward)', { desc = "Jump to prev TODO" })
    vim.keymap.set('n', '<Tab>', '<Plug>(doge-comment-jump-forward)', { desc = "Jump to next TODO" })
    vim.keymap.set('n', '<S-Tab>', '<Plug>(doge-comment-jump-backward)', { desc = "Jump to prev TODO" })
  end
}