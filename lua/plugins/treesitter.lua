local parsers = {
  "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
  "javascript", "typescript", "tsx", "python", "json", "yaml", "toml",
  "html", "css", "bash", "diff", "gitcommit",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Windows에서 tree-sitter가 MSVC를 고르면 gitcommit 파서 컴파일이 멈추므로 gcc를 쓴다
    if vim.fn.has("win32") == 1 then
      vim.env.CC = "gcc"
    end
    require("nvim-treesitter").install(parsers)

    local filetypes = {}
    for _, lang in ipairs(parsers) do
      vim.list_extend(filetypes, vim.treesitter.language.get_filetypes(lang))
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
      pattern = filetypes,
      callback = function(args)
        -- 큰 파일은 하이라이트가 느려지므로 끈다
        local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(args.buf))
        if stats and stats.size > 100 * 1024 then
          return
        end
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
