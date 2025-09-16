return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      -- lua snip keymaps
      require('plugins.snippets.keymap')

      -- lua snippets
      require("plugins.snippets.lua")

      -- javascript, typescript snippets
      require("plugins.snippets.common-js")
    end
  },
  {
    'saghen/blink.cmp',
    dependencies = { 
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip'
    },
    version = '1.*',
    opts = {
      keymap = { 
        preset = 'default',
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' }
      },
      appearance = { 
        nerd_font_variant = 'mono' 
      },
      sources = { 
        default = { 'lsp', 'path', 'snippets', 'buffer' }
      },
      fuzzy = { 
        implementation = "prefer_rust_with_warning" 
      },
      snippets = {
        expand = function(snippet) 
          require('luasnip').lsp_expand(snippet) 
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) 
          require('luasnip').jump(direction) 
        end,
      },
    }
  }
}