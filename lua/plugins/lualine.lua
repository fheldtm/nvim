-- macro recording시에 lualine에 표시
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")

    -- lualine은 1초마다 갱신하므로 recoding에 들어갈 때 lualine 갱신하도록 수정
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        lualine.refresh({
          place = { "statusline" },
        })
      end,
    })

    -- recording 종료시에도 바로 갱신되도록
    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        ---@diagnostic disable-next-line: undefined-field
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            lualine.refresh({
              place = { "statusline" },
            })
          end)
        )
      end,
    })

    lualine.setup({
      sections = {
        lualine_c = {
          {
            "macro-recording",
            fmt = show_macro_recording,
          },
        },
      },
      options = {
        theme = "onedark",
      },
    })
  end
}
