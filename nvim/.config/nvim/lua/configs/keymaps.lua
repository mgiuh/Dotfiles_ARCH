local map = vim.keymap.set

-- Moverse entre ventanas con Control + dirección
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Limpiar el resaltado de búsqueda con Esc
map("n", "<Esc>", "<cmd>noh<CR>")
