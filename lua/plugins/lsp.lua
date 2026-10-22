local servers = { "vtsls", "pyright" }

-- vim.lsp.enable이 열린 버퍼 attach와 false일 때 client 정지까지 처리한다 (:help vim.lsp.enable())
local function toggle_lsp()
  if vim.lsp.is_enabled(servers[1]) then
    vim.lsp.enable(servers, false)
    vim.notify("LSP off", vim.log.levels.INFO)
  else
    vim.lsp.enable(servers)
    vim.notify("LSP on", vim.log.levels.INFO)
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-tool-installer").setup({
        ensure_installed = servers,
        run_on_start = true,
      })

      vim.keymap.set("n", "<leader>l", toggle_lsp, { desc = "Toggle LSP" })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
        callback = function(args)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or not client:supports_method("textDocument/completion") then
            return
          end
          -- 'autocomplete'(키워드)와 LSP 완성은 둘 다 vim.fn.complete()로 메뉴를 덮어써서 충돌하므로 LSP 버퍼에서는 LSP만 쓴다.
          -- LSP autotrigger는 triggerCharacters에서만 뜨므로 글자 입력마다 뜨도록 확장한다 (:help lsp-autocompletion).
          vim.bo[args.buf].autocomplete = false
          local provider = client.server_capabilities.completionProvider
          local triggers = provider.triggerCharacters or {}
          for char in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"):gmatch(".") do
            triggers[#triggers + 1] = char
          end
          provider.triggerCharacters = triggers
          vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp_detach_autocomplete", { clear = true }),
        callback = function(args)
          if #vim.lsp.get_clients({ bufnr = args.buf }) <= 1 and vim.api.nvim_buf_is_valid(args.buf) then
            vim.api.nvim_buf_call(args.buf, function() vim.cmd("setlocal autocomplete<") end)
          end
        end,
      })
    end,
  },
}
