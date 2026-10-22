-- herdr 밖에서 실행될 수 있으므로 pcall로 감싼다
local function herdr_status()
  local ok, herdr = pcall(require, "herdr-nvim")
  if not ok then
    return ""
  end
  local ok_status, text = pcall(herdr.statusline)
  return ok_status and text or ""
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  opts = {
    options = { theme = "catppuccin-nvim" },
    sections = {
      lualine_c = {
        { "filename", path = 1 },
        { herdr_status, cond = function() return herdr_status() ~= "" end },
      },
      lualine_x = { "lsp_status", "filetype" },
    },
  },
}
