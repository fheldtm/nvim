-- LuaSnip을 불러옴
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Lua 파일을 위한 스니펫 정의
ls.add_snippets('lua', {
  -- 스니펫 'func'를 입력하면 자동으로 함수 템플릿이 생성됨
  s('func', {
    t('function '), i(1, 'name'), t({ '(', ')', '', '\t' }), i(0), t({ '', 'end' }),
  }),
})
