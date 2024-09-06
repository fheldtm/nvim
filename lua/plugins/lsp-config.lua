return {
  {
    "williamboman/mason.nvim",
    run = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "emmet_language_server",     -- emmet-language-server
          "eslint",                    -- eslint-lsp
          "html",                      -- html-lsp
          "lua_ls",                    -- lua-language-server
          "tsserver",                  -- typescript-language-server
          "volar",                     -- vue-language-server
        },
        automatic_installation = true, -- 자동 설치 활성화
      }
    end
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua 언어 서버 설정
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Neovim API에서 사용되는 "vim"을 전역 변수로 인식하도록 설정
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true), -- Neovim의 런타임 파일을 LSP 서버에 라이브러리로 제공
              checkThirdParty = false
            },
            telemetry = {
              enable = false, -- Telemetry 비활성화
            },
          },
        },
      })

      -- vue_language_server mason registry path
      local vue_language_server_path = require('mason-registry')
          .get_package("vue-language-server")
          :get_install_path() .. "/node_modules/@vue/language-server"

      -- 현재 프로젝트 폴더의 typescript 경로를 찾기
      local function find_typescript_sdk(root_dir)
        -- 1. .pnpm 내부의 TypeScript 경로 찾기
        local tsdk_pnpm = vim.fn.glob(root_dir .. '/node_modules/.pnpm/typescript@*/node_modules/typescript/lib')

        -- 2. 일반 node_modules 내부의 TypeScript 경로 찾기
        local tsdk_node_modules = root_dir .. '/node_modules/typescript/lib'

        -- 3. TypeScript 경로가 존재하면 반환, 없으면 nil 반환
        if vim.fn.isdirectory(tsdk_node_modules) == 1 then
          return tsdk_node_modules
        elseif vim.fn.isdirectory(tsdk_pnpm) == 1 then
          return tsdk_pnpm
        else
          return nil
        end
      end

      -- JavaScript/TypeScript 언어 서버 설정
      lspconfig.ts_ls.setup({
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        settings = {
          -- JavaScript/TypeScript 설정 (필요에 따라 추가적인 설정 가능)
        },
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "vue" },
            },
          },
        },
        on_new_config = function(new_config, new_root_dir)
          -- TypeScript SDK 경로 지정
          local tsdk_path = find_typescript_sdk(new_root_dir)
          if tsdk_path then
            new_config.init_options.typescript.tsdk = tsdk_path
          end
        end,
      })

      -- JavaScript 및 TypeScript ESLint 설정
      lspconfig.eslint.setup({
        -- ESLint 관련 추가 설정이 필요한 경우 여기에 추가
      })

      -- Emmet Language Server 설정
      lspconfig.emmet_language_server.setup({
        filetypes = { "html", "css", "javascript", "typescript", "vue", "markdown" }, -- Emmet 지원 파일 유형
      })

      -- HTML LSP 서버 설정
      lspconfig.html.setup({
        -- HTML LSP 관련 추가 설정이 필요한 경우 여기에 추가
      })

      lspconfig.volar.setup({
        on_new_config = function(new_config, new_root_dir)
          -- TypeScript SDK 경로 지정
          local tsdk_path = find_typescript_sdk(new_root_dir)
          if tsdk_path then
            new_config.init_options.typescript.tsdk = tsdk_path
          end
        end
      })
    end
  }
}
