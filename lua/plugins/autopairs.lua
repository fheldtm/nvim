-- 괄호와 쿼테이션 마크(")를 자동으로 쌍을 맞춰주는 플러그인
return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = true
  -- use opts = {} for passing setup options
  -- this is equivalent to setup({}) function
}
