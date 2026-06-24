vim.g.mapleader = " " -- Tu barra espaciadora ahora es el centro del universo
vim.opt.number = true
vim.opt.relativenumber = true -- Vital para saltar líneas rápido
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus" -- Compartir portapapeles con el sistema

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function ()
        vim.opt_local.wrap = true -- Activa el ajuste de línea visual
        vim.opt_local.linebreak = true -- Corta las líneas en palabras, no en medio de una letra
    vim.opt_local.spell = true -- Activa el corrector ortográfico si lo usas
    vim.opt_local.conceallevel = 2 --OCULTAR SINTAXIS CRUDA
  end,
})
