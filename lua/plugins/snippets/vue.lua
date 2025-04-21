local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local M = {}

local snippets = {
  s("vuets", {
    t("<script setup lang=\"ts\"></script>"),
    t(""),
    t("<template>"),
    t("  <div></div>"),
    t("</template>"),
    t(""),
    t("<style scoped></style>"),
    t(""),
  }),
}

ls.add_snippets("vue", snippets)

return M
