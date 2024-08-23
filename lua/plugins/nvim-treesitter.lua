return {
  "nvim-treesitter/nvim-treesitter",  -- nvim-treesitter 플러그인을 불러옴
  lazy = false,  -- 이 플러그인을 지연 로드하지 않고, Neovim 시작 시 즉시 로드
  config = function ()
    require("nvim-treesitter.configs").setup({
      -- 반드시 설치해야 하는 파서(parser) 목록을 정의합니다.
      -- "all"로 설정하면 모든 지원 언어의 파서를 설치합니다.
      ensure_installed = {
        "c",
        "lua",
        "markdown",
        "markdown_inline",
        "dart",
        "gitignore",
        "gitcommit",
        "go",
        "html",
        "css",
        "javascript",
        "json",
        "python",
        "rust",
        "scss",
        "sql",
        "typescript",
        "vue",
      },
      
      -- `ensure_installed` 목록에 있는 파서를 동기적으로 설치할지 여부를 설정합니다.
      -- false로 설정하면 비동기적으로 설치되며, 설치가 완료될 때까지 Neovim이 잠기지 않습니다.
      sync_install = false,
      
      -- 버퍼에 들어갈 때 자동으로 누락된 파서를 설치할지 여부를 설정합니다.
      -- 로컬에 `tree-sitter` CLI가 설치되지 않은 경우 false로 설정하는 것이 좋습니다.
      auto_install = true,
      
      -- 특정 언어의 파서를 설치하지 않도록 하려면 이 목록에 언어 이름을 추가합니다.
      ignore_install = {},  -- 설치를 무시할 파서 목록입니다.

      highlight = {
        enable = true,  -- Tree-sitter 기반의 구문 강조 기능을 활성화합니다.

        -- 특정 언어에 대해 구문 강조를 비활성화하거나, 조건부로 비활성화할 수 있습니다.
        -- 여기서는 파일 크기가 100 KB를 초과하는 경우 구문 강조를 비활성화하도록 설정되어 있습니다.
        disable = function(lang, buf)
          local max_filesize = 100 * 1024  -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true  -- 파일 크기가 100 KB를 초과하는 경우 구문 강조를 비활성화합니다.
          end
        end,

        -- Tree-sitter와 기존 Vim의 구문 강조(`:h syntax`)를 함께 사용할지 여부를 설정합니다.
        -- true로 설정하면 Tree-sitter와 Vim의 구문 강조가 동시에 동작할 수 있지만, 중복된 강조 표시가 나타날 수 있습니다.
        additional_vim_regex_highlighting = false,
      }
    })
  end
}
