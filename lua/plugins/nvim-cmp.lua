return {
  -- nvim-cmp 플러그인
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",  -- LSP 자동 완성 소스
    "neovim/nvim-lspconfig", -- LSP 서버 설정
    "L3MON4D3/LuaSnip"       -- 스니펫 플러그인 (선택사항)
  },
  config = function()
    local cmp = require('cmp')

    -- nvim-cmp 설정
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)  -- LuaSnip을 사용하는 경우
        end,
      },
      sources = {
        { name = 'nvim_lsp' },  -- LSP 자동 완성 소스
        { name = 'path' },      -- 파일 경로 자동 완성 소스
        { name = 'buffer' },    -- 버퍼에서 자동 완성 항목 가져오기
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(), -- 자동 완성 항목 다음으로 이동
        ['<C-p>'] = cmp.mapping.select_prev_item(), -- 자동 완성 항목 이전으로 이동
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 항목 선택
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
    })
  end
}
