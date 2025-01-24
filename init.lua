-- Configuraciones básicas
vim.opt.number = true               -- Habilitar numeración
-- vim.opt.relativenumber = true       -- Numeración relativa
vim.opt.wildmenu = true             -- Habilitar autocompletado de comandos
vim.opt.hlsearch = true             -- Resaltar búsqueda
vim.opt.incsearch = true            -- Actualización en tiempo real al escribir
vim.opt.tabstop = 4                 -- Tamaño de tabulación
vim.opt.shiftwidth = 4              -- Espaciado al usar indentación
vim.opt.expandtab = true            -- Convertir tabs en espacios
vim.opt.clipboard = "unnamedplus"   -- Copiar al portapapeles del sistema
-- vim.opt.termguicolors = true        -- Colores 24 bits
vim.opt.splitbelow = true           -- Dividir ventanas hacia abajo
vim.opt.splitright = true           -- Dividir ventanas hacia la derecha

-- Activar autoguardado
vim.opt.autowrite = true            -- Guardado automático antes de ciertos comandos
vim.opt.autowriteall = true         -- Guardar todo automáticamente al salir

-- Mapeos de teclas
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-z>', ':undo<CR>', { noremap = true, silent = true })  -- Deshacer
vim.api.nvim_set_keymap('n', '<C-y>', ':redo<CR>', { noremap = true, silent = true })  -- Rehacer
vim.api.nvim_create_autocmd("TextChanged", {
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "" then -- Verifica si el buffer es escribible
            vim.cmd("write")
        end
    end,
})
-- Configuración de complementos usando Packer
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer se gestiona a sí mismo
    use 'nvim-treesitter/nvim-treesitter' -- Coloreado avanzado
    use 'nvim-lualine/lualine.nvim' -- Barra de estado
    use 'neovim/nvim-lspconfig' -- Configuración de LSP
    use 'hrsh7th/nvim-cmp' -- Autocompletado
    use 'nvim-tree/nvim-tree.lua' -- Explorador de archivos
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }, -- Añadir dependencia plenary.nvim
    }
end)

-- Configuración de NvimTree
require("nvim-tree").setup({
    view = {
        width = 30, -- Ancho del explorador
        side = "left", -- Mostrar a la izquierda
    },
    renderer = {
        icons = {
            show = {
                folder = true, -- Mostrar íconos de carpetas
                file = true,   -- Mostrar íconos de archivos
            },
        },
    },
    actions = {
        open_file = {
            quit_on_open = true, -- Cierra el explorador al abrir un archivo
        },
    },
})

-- Apertura automática de NvimTree al iniciar Neovim
local function open_nvim_tree(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
        return
    end
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Configuración de Treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = { "lua", "python", "javascript", "html", "css" }, -- Idiomas soportados
    highlight = {
        enable = true, -- Activar resaltado
    },
})

-- Configuración de Lualine
-- require('lualine').setup({
--    options = {
--    theme = 'gruvbox', -- Cambia el tema según tu preferencia
--    },
--})

-- Configuración básica de Telescope
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false, -- Desactivar scroll hacia arriba
                ["<C-d>"] = false, -- Desactivar scroll hacia abajo
            },
        },
    },
})
