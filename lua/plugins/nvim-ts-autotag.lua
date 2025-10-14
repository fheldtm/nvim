return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "InsertEnter",
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,          -- 태그 자동 닫기
        enable_rename = true,          -- 태그 이름 동기화
        enable_close_on_slash = false, -- '/' 입력 시 자동 닫기 비활성화
      },
      -- 활성화할 파일 타입
      filetypes = {
        "html",
        "xml",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "markdown",
      },
    })
  end,
}
