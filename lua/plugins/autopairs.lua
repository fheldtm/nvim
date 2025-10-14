-- 괄호와 쿼테이션 마크(")를 자동으로 쌍을 맞춰주는 플러그인
return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    require('nvim-autopairs').setup({
      check_ts = true,  -- Tree-sitter를 사용하여 괄호 쌍 추가 확인
      ts_config = {
        lua = { 'string' },  -- Lua의 문자열 내부에서는 괄호 쌍을 추가하지 않음
        javascript = { 'template_string' },
        python = { 'string' },  -- Python 문자열 내부에서도 비활성화
      },
      enable_check_bracket_line = true,  -- 같은 줄에 괄호가 있으면 추가하지 않음
    })
  end
}
