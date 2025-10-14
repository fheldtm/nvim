-- hurl 함수 정의
local function run_hurl_entry()
  if vim.fn.executable("hurl") == 0 then
    vim.notify("hurl is not installed", vim.log.levels.ERROR)
    return
  end

  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")

  -- HTTP 메서드로 entry 번호 계산 (빈 줄이 연속으로 여러개 있어도 정확함)
  local entry_num = 0
  local current_entry_start = nil

  -- 커서 위치까지 HTTP 메서드 라인 카운트
  for i = 1, line do
    local current_line = vim.fn.getline(i)
    -- HTTP 메서드로 시작하는 라인 감지
    if current_line:match("^%s*[A-Z]+%s+https?://") then
      entry_num = entry_num + 1
      current_entry_start = i
    end
  end

  -- HTTP 메서드 라인을 찾지 못한 경우 (주석이나 빈 줄에 커서가 있는 경우)
  if entry_num == 0 then
    entry_num = 1
  end

  -- hurl 실행 (stderr는 /dev/null로 보냄)
  local output = vim.fn.systemlist(string.format("hurl --from-entry %d --to-entry %d %s 2>/dev/null", entry_num, entry_num, file))

  -- JSON인지 확인하고 jq로 포맷팅 시도
  if vim.fn.executable("jq") == 1 and #output > 0 then
    local raw_output = table.concat(output, "\n")
    local formatted = vim.fn.systemlist("jq '.'", raw_output)
    -- jq가 성공하면 포맷팅된 결과 사용
    if vim.v.shell_error == 0 then
      output = formatted
    end
  end

  vim.cmd("vsplit")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  vim.bo[buf].filetype = "json"
  vim.bo[buf].buftype = "nofile"
end

local function run_hurl_all()
  if vim.fn.executable("hurl") == 0 then
    vim.notify("hurl is not installed", vim.log.levels.ERROR)
    return
  end

  local file = vim.fn.expand("%:p")

  -- hurl 실행 (stderr는 /dev/null로 보냄)
  local output = vim.fn.systemlist(string.format("hurl %s 2>/dev/null", file))

  -- JSON인지 확인하고 jq로 포맷팅 시도
  if vim.fn.executable("jq") == 1 and #output > 0 then
    local raw_output = table.concat(output, "\n")
    local formatted = vim.fn.systemlist("jq '.'", raw_output)
    -- jq가 성공하면 포맷팅된 결과 사용
    if vim.v.shell_error == 0 then
      output = formatted
    end
  end

  vim.cmd("vsplit")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  vim.bo[buf].filetype = "json"
  vim.bo[buf].buftype = "nofile"
end

local function run_hurl_verbose()
  if vim.fn.executable("hurl") == 0 then
    vim.notify("hurl is not installed", vim.log.levels.ERROR)
    return
  end

  local file = vim.fn.expand("%:p")
  vim.cmd("split | terminal hurl --verbose " .. file)
end

-- .hurl 파일에 키맵 설정
vim.api.nvim_create_autocmd("FileType", {
  pattern = "hurl",
  callback = function(args)
    vim.keymap.set("n", "<leader>hr", run_hurl_entry, { buffer = args.buf, desc = "Run current Hurl entry" })
    vim.keymap.set("n", "<leader>ha", run_hurl_all, { buffer = args.buf, desc = "Run all Hurl entries" })
    vim.keymap.set("n", "<leader>hv", run_hurl_verbose, { buffer = args.buf, desc = "Run Hurl verbose" })
  end,
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "hurl" })
      end
    end,
  },
}
