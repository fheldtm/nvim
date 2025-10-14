return {
  -- org bullets
  {
    'akinsho/org-bullets.nvim',
    ft = { 'org' },
    config = function()
      require('org-bullets').setup({
        concealcursor = false,
        symbols = {
          list = "•",
          headlines = { "◉", "○", "✸", "✿" },
          checkboxes = {
            half = { "-", "@org.checkbox.halfchecked" },
            done = { "✓", "@org.keyword.done" },
            todo = { " ", "@org.keyword.todo" },
          },
        }
      })
    end
  },

  -- orgmode
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/notes/**/*',
        org_default_notes_file = '~/notes/inbox.org',
        org_startup_indented = true,
        org_hide_leading_stars = true,
        mappings = {
          org = {
            org_refile = false, -- Disable default refile mapping
          }
        },
        org_capture_templates = {
          t = {
            description = 'Todo',
            template = '* TODO %?',
            target = '~/notes/inbox.org'
          },
          n = {
            description = 'Note',
            template = '* %?\n%U\n%a',
            target = '~/notes/notes.org'
          },
          j = {
            description = 'Journal',
            template = '* %U\n%?',
            target = '~/notes/journal.org'
          }
        },
      })

      -- Custom refile to projects folder
      local function refile_to_project()
        vim.ui.input({ prompt = 'Project name: ' }, function(project_name)
          if not project_name or project_name == '' then
            return
          end

          local target_path = 'projects/' .. project_name .. '.org'
          local target_file = vim.fn.expand('~/notes/' .. target_path)

          -- Create file if it doesn't exist
          if vim.fn.filereadable(target_file) == 0 then
            vim.fn.writefile({}, target_file)
          end

          -- Trigger orgmode's refile with the target path pre-filled
          require('orgmode').action('capture.refile_headline_to_destination')

          -- Auto-fill the path after a short delay
          vim.defer_fn(function()
            vim.api.nvim_feedkeys(target_path .. vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
          end, 100)
        end)
      end

      -- Org mode keymaps
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'org',
        callback = function()
          vim.keymap.set('n', '<leader>oim', '<cmd>Org indent_mode<cr>', {
            desc = 'Toggle org indent mode',
            silent = true,
            buffer = true
          })
          -- Custom refile keymaps
          vim.keymap.set('n', '<leader>or', function()
            require('orgmode').action('capture.refile_headline_to_destination')
          end, {
            desc = 'Org refile',
            silent = true,
            buffer = true
          })
          vim.keymap.set('n', '<leader>orp', refile_to_project, {
            desc = 'Refile to project',
            silent = true,
            buffer = true
          })
          -- Checkbox toggle keymap
          vim.keymap.set('n', '<CR>', function()
            require('orgmode').action('org_mappings.toggle_checkbox')
          end, {
            desc = 'Toggle checkbox',
            silent = true,
            buffer = true
          })
        end
      })

      -- Org Notes Terminal
      vim.keymap.set('n', '<leader>on', '<cmd>lua _notes_toggle()<CR>',
        { noremap = true, silent = true, desc = 'Open notes' }
      )
    end,
  },

  -- org roam
  {
    "chipsenkbeil/org-roam.nvim",
    enabled = false,
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
