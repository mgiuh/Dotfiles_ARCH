-- lua/plugins/markdown.lua
return {
  -- Renderizado estético de encabezados, tablas y checkboxes
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { "markdown", "Avante" }, -- Se carga solo cuando abres estos tipos de archivo
    opts = {
      -- Configuración básica por defecto
      checkbox = {
        enabled = true,
      },
    },
  },

  -- Gestión de notas estilo Obsidian (opcional, si quieres enlaces [[Nota]])
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "notas",
          path = "~/Documentos/obsidian", -- Ajusta esta ruta a donde guardes tus .md
        },
      },
    },
  },
}
