-- 에이전트가 파일을 바깥에서 수정하므로 포커스/이동 시점마다 변경을 감지한다
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("checktime", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "c" and vim.bo.buftype == "" then
      vim.cmd("checktime")
    end
  end,
  desc = "외부 변경 감지",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = vim.api.nvim_create_augroup("external_change_notify", { clear = true }),
  callback = function()
    vim.notify("파일이 외부에서 변경되어 다시 읽었습니다", vim.log.levels.WARN)
  end,
  desc = "외부 변경 알림",
})
