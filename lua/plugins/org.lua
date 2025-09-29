return {
  -- orgmode
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/notes/**/*',
        org_default_notes_file = '~/notes/inbox.org',
        org_capture_templates = {
          t = {
            description = 'Todo',
            template = '* TODO %?\n  %u\n  %a',
            target = '~/notes/inbox.org'
          },
          n = {
            description = 'Note',
            template = '* %?\n  %U\n  %a',
            target = '~/notes/notes.org'
          },
          j = {
            description = 'Journal',
            template = '* %U\n  %?',
            target = '~/notes/journal.org'
          }
        }
      })

      -- Org mode keymaps
      vim.keymap.set('n', '<leader>oim', '<cmd>Org indent_mode<cr>', {
        desc = 'Toggle org indent mode',
        silent = true
      })
    end,
  },

  -- org roam
  {
    "chipsenkbeil/org-roam.nvim",
    tag = "0.1.1",
    dependencies = {
      {
        "nvim-orgmode/orgmode",
      },
    },
    config = function()
      require("org-roam").setup({
        directory = "~/notes",
      })
    end
  }
}
