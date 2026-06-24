-- Cargar opciones y atajos de teclado iniciales
require("configs.options")
require("configs.keymaps")

-- Instalar lazy.nvim automáticamente si no está instalado
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configurar plugins desde la carpeta lua/plugins
require("lazy").setup({
    spec ={
        { import = "plugins" },
    },
})
