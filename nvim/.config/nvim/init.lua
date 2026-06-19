-- ========================================================================== --
-- 1. ASIGNACIÓN DE TECLA LÍDER (DEBE IR AL PRINCIPIO)
-- ========================================================================== --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ========================================================================== --
-- 2. CONFIGURACIONES GENERALES Y OPTIMIZACIONES DE RENDIMIENTO
-- ========================================================================== --
vim.opt.number = true            -- Mostrar números de línea estáticos
vim.opt.relativenumber = true    -- Números relativos para saltos rápidos con teclado
vim.opt.ignorecase = true        -- Ignorar mayúsculas al buscar texto
vim.opt.swapfile = false         -- Desactivar archivos .swp para agilizar operaciones en disco
vim.opt.backup = false           -- Desactivar backups duplicados (corregido de nobackup=false)
vim.opt.scrolloff = 4            -- Mantener 4 líneas de contexto visible al hacer scroll
vim.opt.hlsearch = true          -- Mantener el resaltado activo de forma nativa

-- Limpiar el brillo visual de la búsqueda presionando Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Limpiar resaltado" })

-- ========================================================================== --
-- 3. FUNCIÓN DE SEGURIDAD (LECTURA DESDE MODEL.ENV)
-- ========================================================================== --
local function load_secure_api_key()
  local env_file = vim.fn.expand("~/.config/nvim/modulos/model.env")

  if vim.fn.filereadable(env_file) == 1 then
    for line in io.lines(env_file) do
      local key = line:match("^%s*OPENROUTER_API_KEY%s*=%s*\"([^\"]+)\"")
      if key then
        return key
      end
    end
  end
  return nil
end

-- ========================================================================== --
-- 4. INICIALIZACIÓN DE PLUGINS E INTEGRACIÓN DE OPENROUTER
-- ========================================================================== --
-- Bootstrap automático de lazy.nvim en caso de no estar presente
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "robitx/gp.nvim",
    config = function()
      local openrouter_key = load_secure_api_key()

      if not openrouter_key then
        vim.notify("Seguridad: No se pudo cargar la clave desde secrets/model.env", vim.log.levels.WARN)
      end

      require("gp").setup({
        providers = {
          openai = {
            endpoint = "https://openrouter.ai/api/v1/chat/completions",
            secret = openrouter_key,
          },
        },
        agents = {
          {
            provider = "openai",
            name = "OpenRouterFlash",
            chat = true,
            command = true,
            model = { model = "google/gemini-2.5-flash" },
            system_prompt = "Eres un asistente de programación experto en entornos ligeros, Arch Linux y C++. Sé muy conciso.",
          },
        },
        chat_shortcut_respond = { desc = "Enviar consulta a IA", mapping = "<C-g><C-g>" },
      })

      -- MAPEOS DE TECLADO CORREGIDOS (Sintaxis nativa Lua para Neovim)
      -- Modo Normal: Espacio -> g -> n (Abrir Chat de IA)
      vim.keymap.set("n", "<leader>gn", "<cmd>GpChatNew<CR>", { desc = "Nuevo Chat de IA" })
      
      -- Modo Visual: Selección -> Espacio -> g -> r (Reescribir de forma limpia)
      vim.keymap.set("v", "<leader>gr", ":<C-u>GpRewrite<CR>", { desc = "Reescribir con IA" })
    end,
  },
})
