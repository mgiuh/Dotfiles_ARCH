return {
  -- El mejor tema moderno
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- Buscador difuso (Fuzzy Finder) hiperveloz
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Buscar Archivos" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Buscar Texto (Grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Ver Buffers" },
    },
  },

  -- Explorador de archivos moderno
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorador" },
    },
  },
}
