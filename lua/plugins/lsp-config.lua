return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- Lua 언어 서버 설정
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },  -- Neovim API에서 사용되는 "vim"을 전역 변수로 인식하도록 설정
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),  -- Neovim의 런타임 파일을 LSP 서버에 라이브러리로 제공
          },
          telemetry = {
            enable = false,  -- Telemetry 비활성화
          },
        },
      },
    })

    -- JavaScript/TypeScript 언어 서버 설정
    lspconfig.tsserver.setup({
      settings = {
        -- JavaScript/TypeScript 설정 (필요에 따라 추가적인 설정 가능)
      },
    })

    -- JavaScript 및 TypeScript ESLint 설정
    lspconfig.eslint.setup({
      -- ESLint 관련 추가 설정이 필요한 경우 여기에 추가
    })

    -- Emmet Language Server 설정
    lspconfig.emmet_language_server.setup({
      filetypes = { "html", "css", "javascript", "typescript", "vue", "markdown" }, -- Emmet 지원 파일 유형
    })

    -- HTML LSP 서버 설정
    lspconfig.html.setup({
      -- HTML LSP 관련 추가 설정이 필요한 경우 여기에 추가
    })

    -- Vue Language Server 설정
    lspconfig.vuels.setup({
      -- Vue LSP 관련 추가 설정이 필요한 경우 여기에 추가
    })
  end
}
