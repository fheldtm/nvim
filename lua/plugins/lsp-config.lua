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
          "vtsls",                     -- typescript language server
          "vue_ls",                    -- vue language server
          "tailwindcss",               -- tailwindcss-language-server
        },
        automatic_installation = true, -- 자동 설치 활성화
      }
    end
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "prettierd",
        },
        auto_update = false,
        run_on_start = true,
      }
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require('blink.cmp').get_lsp_capabilities()


      -- Lua 언어 서버 설정
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
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

      -- Nuxt 프로젝트 감지
      local function is_nuxt_project(root_dir)
        return vim.fn.filereadable(root_dir .. '/nuxt.config.js') == 1 or
            vim.fn.filereadable(root_dir .. '/nuxt.config.ts') == 1 or
            vim.fn.isdirectory(root_dir .. '/.nuxt') == 1
      end

      -- VTSLS 설정 (Vue TypeScript 지원)
      lspconfig.vtsls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
            },
          },
        },
      })

      -- JavaScript 및 TypeScript ESLint 설정
      lspconfig.eslint.setup({
        capabilities = capabilities,
        -- ESLint 관련 추가 설정이 필요한 경우 여기에 추가
      })

      -- Emmet Language Server 설정
      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
        filetypes = { "html", "css", "javascript", "typescript", "vue", "markdown" }, -- Emmet 지원 파일 유형
      })

      -- HTML LSP 서버 설정
      lspconfig.html.setup({
        capabilities = capabilities,
        -- HTML LSP 관련 추가 설정이 필요한 경우 여기에 추가
      })

      -- Tailwind CSS Language Server 설정
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = {
          "html", "css", "scss", "sass", "postcss", "javascript", "javascriptreact",
          "typescript", "typescriptreact", "vue", "svelte"
        },
      })

      -- Vue Language Server (Volar) 설정
      lspconfig.volar.setup({
        capabilities = capabilities,
        filetypes = { "vue" },
        root_dir = lspconfig.util.root_pattern("nuxt.config.js", "nuxt.config.ts", "vue.config.js", "package.json"),
        init_options = {
          vue = {
            hybridMode = false,
          },
          typescript = {
            tsdk = ""
          },
          languageFeatures = {
            implementation = true,
            references = true,
            definition = true,
            typeDefinition = true,
            callHierarchy = true,
            hover = true,
            rename = true,
            renameFileRefactoring = true,
            signatureHelp = true,
            codeAction = true,
            workspaceSymbol = true,
            completion = {
              defaultTagNameCase = "both",
              defaultAttrNameCase = "kebabCase",
            },
          },
        },
        on_new_config = function(new_config, new_root_dir)
          local tsdk_path = find_typescript_sdk(new_root_dir)
          if tsdk_path then
            new_config.init_options.typescript.tsdk = tsdk_path
          end

          -- Nuxt 프로젝트인 경우 추가 설정
          if is_nuxt_project(new_root_dir) then
            -- Nuxt 특화 설정
            new_config.init_options.vue = vim.tbl_deep_extend("force", new_config.init_options.vue or {}, {
              hybridMode = false,
              -- Nuxt auto-imports 지원
              additionalExtensions = { ".vue" },
            })

            -- .nuxt/tsconfig.json 경로 명시적 지정
            local nuxt_tsconfig = new_root_dir .. "/.nuxt/tsconfig.json"
            if vim.fn.filereadable(nuxt_tsconfig) == 1 then
              new_config.init_options.typescript = vim.tbl_deep_extend("force", new_config.init_options.typescript or {}, {
                tsdk = tsdk_path,
                -- Nuxt의 생성된 tsconfig 사용
                preferences = {
                  includePackageJsonAutoImports = "auto",
                },
              })
            end
          end
        end
      })
    end
  }
}
