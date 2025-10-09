-- JSON 파일 저장 시 연속된 빈 줄 제거
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.json",
  callback = function()
    -- 현재 커서 위치 저장
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    
    -- 연속된 빈 줄을 하나로 압축
    vim.cmd([[silent! %s/\n\n\+/\r/g]])
    
    -- 커서 위치 복원 (변경사항으로 인해 위치가 바뀔 수 있음)
    pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
  end,
})
