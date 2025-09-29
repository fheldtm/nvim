return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'markdown', 'Avante' },
  opts = {},
  config = function()
    require('render-markdown').setup {
      heading = {
        enabled = false,
        backgrounds = {},
      },
      indent = {
        -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
        -- level of the heading. Indenting starts from level 2 headings onward by default.

        -- Turn on / off org-indent-mode.
        enabled = true,
        -- Additional modes to render indents.
        render_modes = false,
        -- Amount of additional padding added for each heading level.
        per_level = 1,
        -- Heading levels <= this value will not be indented.
        -- Use 0 to begin indenting from the very first level.
        skip_level = 0,
        -- Do not indent heading titles, only the body.
        skip_heading = false,
        -- Prefix added when indenting, one per level.
        icon = '-',
        -- Priority to assign to extmarks.
        priority = 0,
        -- Applied to icon.
        highlight = 'RenderMarkdownIndent',
      },
    }
  end
}

