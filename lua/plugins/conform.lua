-- 다양한 코드 포매터를 지원하는 자동 포매팅 플러그인
return {
  "stevearc/conform.nvim",
  -- event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        vue = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 5000,
        lsp_fallback = true,
      },
    })
  end
}
