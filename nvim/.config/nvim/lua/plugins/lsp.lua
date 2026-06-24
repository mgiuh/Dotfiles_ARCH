return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls" },
      })

      -- Configuración estándar al conectar un LSP
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end

      -- CAMBIO AQUÍ: Usamos el nuevo estándar de configuración
      if vim.lsp.config then
        vim.lsp.config("clangd", { on_attach = on_attach })
        vim.lsp.config("lua_ls", { on_attach = on_attach })
      else
        -- Fallback por si acaso para compatibilidad activa
        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup({ on_attach = on_attach })
        lspconfig.lua_ls.setup({ on_attach = on_attach })
      end
    end,
  },

  -- Resaltado de sintaxis ultra preciso y rápido
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- CAMBIO AQUÍ: Ahora se usa directamente el require de main
      require("nvim-treesitter").setup({
        ensure_installed = { "lua", "cpp", "c", "bash" },
        highlight = { enable = true },
      })
    end,
  },
}
