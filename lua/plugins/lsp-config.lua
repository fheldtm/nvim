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
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Lua 언어 서버 설정 (modern vim.lsp.config API)
      vim.lsp.config.lua_ls = {
        cmd = { 'lua-language-server' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
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
      }


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
      vim.lsp.config.vtsls = {
        cmd = { 'vtsls', '--stdio' },
        root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
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
      }

      -- JavaScript 및 TypeScript ESLint 설정
      vim.lsp.config.eslint = {
        cmd = { 'vscode-eslint-language-server', '--stdio' },
        root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', 'package.json', '.git' },
        capabilities = capabilities,
      }

      -- Emmet Language Server 설정
      vim.lsp.config.emmet_language_server = {
        cmd = { 'emmet-language-server', '--stdio' },
        root_markers = { 'package.json', '.git' },
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "sass", "javascript", "typescript", "vue", "svelte", "markdown" },
        init_options = {
          includeLanguages = {
            vue = "html",
            ["vue-html"] = "html",
          }
        }
      }

      -- HTML LSP 서버 설정
      vim.lsp.config.html = {
        cmd = { 'vscode-html-language-server', '--stdio' },
        root_markers = { 'package.json', '.git' },
        capabilities = capabilities,
        filetypes = { "html" },
      }

      -- Tailwind CSS Language Server 설정
      vim.lsp.config.tailwindcss = {
        cmd = { 'tailwindcss-language-server', '--stdio' },
        root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.ts', 'package.json', '.git' },
        capabilities = capabilities,
        filetypes = {
          "html", "css", "scss", "sass", "postcss", "javascript", "javascriptreact",
          "typescript", "typescriptreact", "vue", "svelte"
        },
      }

      -- Vue Language Server (Volar) 설정
      vim.lsp.config.volar = {
        cmd = { 'vue-language-server', '--stdio' },
        capabilities = capabilities,
        filetypes = { "vue" },
        root_markers = { "nuxt.config.js", "nuxt.config.ts", "vue.config.js", "package.json", ".git" },
        init_options = function()
          local root_dir = vim.fs.root(0, { "package.json", ".git" }) or vim.fn.getcwd()
          local tsdk_path = find_typescript_sdk(root_dir)

          local init_opts = {
            vue = {
              hybridMode = false,
            },
            typescript = {
              tsdk = tsdk_path or ""
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
          }

          -- Nuxt 프로젝트인 경우 추가 설정
          if is_nuxt_project(root_dir) then
            -- Nuxt 특화 설정 (vim.tbl_extend replaces vim.tbl_deep_extend)
            init_opts.vue = vim.tbl_extend("force", init_opts.vue or {}, {
              hybridMode = false,
              -- Nuxt auto-imports 지원
              additionalExtensions = { ".vue" },
            })

            -- .nuxt/tsconfig.json 경로 명시적 지정
            local nuxt_tsconfig = root_dir .. "/.nuxt/tsconfig.json"
            if vim.fn.filereadable(nuxt_tsconfig) == 1 then
              init_opts.typescript = vim.tbl_extend("force", init_opts.typescript or {}, {
                tsdk = tsdk_path,
                -- Nuxt의 생성된 tsconfig 사용
                preferences = {
                  includePackageJsonAutoImports = "auto",
                },
              })
            end
          end

          return init_opts
        end,
      }
    end
  }
}
