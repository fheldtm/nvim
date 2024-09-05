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
  -- Console log
  s("clg", {
    t("console.log("),
    i(1),
    t(");"),
  }),

  -- Console trace
  s("ctr", {
    t("console.trace("),
    i(1),
    t(");"),
  }),

  -- Console error
  s("cer", {
    t("console.error("),
    i(1),
    t(");"),
  }),

  -- Console warn
  s("cwa", {
    t("console.warn("),
    i(1),
    t(");"),
  }),

  -- Console info
  s("cin", {
    t("console.info("),
    i(1),
    t(");"),
  }),

  -- Console debug
  s("cde", {
    t("console.debug("),
    i(1),
    t(");"),
  }),

  -- Console table
  s("cta", {
    t("console.table("),
    i(1),
    t(");"),
  }),

  -- Console time start
  s("cts", {
    t("console.time('"),
    i(1, "label"),
    t("');"),
  }),

  -- Console time end
  s("cte", {
    t("console.timeEnd('"),
    i(1, "label"),
    t("');"),
  }),
}

ls.add_snippets("javascript", snippets)
ls.add_snippets("typescript", snippets)
ls.add_snippets("javascriptreact", snippets)
ls.add_snippets("typescriptreact", snippets)
ls.add_snippets("vue", snippets)

return M
