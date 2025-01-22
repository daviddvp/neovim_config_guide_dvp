
# Configuración de Neovim

Este documento explica cómo configurar Neovim con varios complementos útiles para mejorar tu experiencia de desarrollo. La configuración incluye herramientas como NvimTree, Telescope, Lualine, Treesitter, y LSP para autocompletado y resaltado de sintaxis.

## **Archivo de Configuración Completo (`init.lua`)**

Este es el archivo de configuración que debes colocar en `~/.config/nvim/init.lua`.

```lua
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
vim.opt.termguicolors = true        -- Colores 24 bits
vim.opt.splitbelow = true           -- Dividir ventanas hacia abajo
vim.opt.splitright = true           -- Dividir ventanas hacia la derecha

-- Mapeos de teclas
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

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
require('lualine').setup({
    options = {
        theme = 'gruvbox', -- Cambia el tema según tu preferencia
    },
})

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
```

---

## **Pasos para la Instalación Correcta**

### 1. **Instalar Neovim (si no lo tienes instalado)**

Asegúrate de tener la versión más reciente de Neovim instalada. Si no la tienes, puedes instalarla de esta manera:

- **En Ubuntu:**
  ```bash
  sudo apt update
  sudo apt install neovim
  ```

- **En Fedora:**
  ```bash
  sudo dnf update
  sudo dnf install neovim
  ```

- **En Arch:**
  ```bash
  sudo pacman -S neovim
  ```

- **Usando el instalador oficial (en cualquier sistema):**
  - Descarga desde [aquí](https://github.com/neovim/neovim/releases).
  
### 2. **Instalar Packer (gestor de complementos)**

Packer es un gestor de complementos para Neovim. Si aún no lo tienes, instala Packer con los siguientes pasos:

- Clona el repositorio de Packer:
  ```bash
  git clone --depth 1 https://github.com/wbthomason/packer.nvim   ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  ```

### 3. **Coloca el archivo `init.lua` en la ubicación correcta**

- Abre Neovim:
  ```bash
  nvim
  ```
- Si no existe la carpeta de configuración, créala:
  ```bash
  mkdir -p ~/.config/nvim
  ```
- Crea el archivo de configuración `init.lua`:
  ```bash
  nano ~/.config/nvim/init.lua
  ```
  Copia y pega el contenido del archivo de configuracion.

### 4. **Instalar los complementos**

- Después de guardar el archivo `init.lua`, abre Neovim y ejecuta:
  ```vim
  :PackerSync
  ```
  Esto instalará todos los complementos definidos en el archivo de configuración.

---

## **Resumen de Cómo Usar Todo lo Instalado**

### 1. **NvimTree (Explorador de Archivos)**

- **Abrir/Cerrar NvimTree:**  
  Usa `Ctrl+n` para abrir o cerrar el explorador de archivos.  
  - Navega por las carpetas con las teclas de dirección y abre archivos con `Enter`.
  
- **Otras acciones útiles:**
  - `a` para crear un archivo o carpeta.
  - `d` para eliminar un archivo o carpeta.
  - `r` para renombrar un archivo o carpeta.

### 2. **Telescope (Búsqueda Avanzada)**

`Telescope` es una herramienta para buscar archivos, texto y otros elementos dentro de tu proyecto.

- **Buscar archivos:**  
  Usa `:Telescope find_files` o el atajo `Ctrl+p`.
  
- **Buscar texto dentro de los archivos:**  
  Usa `:Telescope live_grep`.
  
- **Listar todos los buffers abiertos:**  
  Usa `:Telescope buffers`.

- **Buscar en el historial de comandos:**  
  Usa `:Telescope command_history`.

- **Buscar entre proyectos Git:**  
  Usa `:Telescope git_commits` si estás trabajando en un proyecto Git.

### 3. **Lualine (Barra de Estado)**

`Lualine` se muestra automáticamente en la parte inferior de la ventana de Neovim.  
Muestra información útil como:
- El archivo actual.
- El estado del archivo (si está modificado o no).
- El modo en que te encuentras (normal, inserción, etc.).

### 4. **Treesitter (Resaltado Avanzado)**

`Treesitter` mejora el resaltado de sintaxis en Neovim.

- **Ver el resaltado:**  
  El resaltado se activa automáticamente cuando escribes código. Los colores y la sintaxis son más precisos que con el resaltado básico.

- **Explorar el análisis sintáctico de tu código:**  
  Usa el comando `:TSPlaygroundToggle` para abrir un panel lateral con el análisis de sintaxis.

### 5. **LSP (Language Server Protocol) - Autocompletado y Errores**

`nvim-lspconfig` y `nvim-cmp` proporcionan autocompletado y sugerencias inteligentes.

- **Autocompletado:**  
  A medida que escribes, aparecerán sugerencias de código. Usa las teclas de flecha para seleccionar y presiona `Enter` para autocompletar.

- **Ver errores de sintaxis:**  
  Los errores se marcarán con colores de acuerdo a la gravedad (rojo para errores, amarillo para advertencias).

- **Ir a la definición de una función o variable:**  
  Usa `:lua vim.lsp.buf.definition()` o asigna un atajo para saltar a la definición.

---

### **Atajos más importantes:**

- **`Ctrl+n`**: Abrir/cerrar el explorador de archivos `NvimTree`.
- **`:Telescope find_files`** o `Ctrl+p`: Buscar archivos.
- **`:Telescope live_grep`**: Buscar texto en los archivos.
- **`Ctrl+Space`**: Activar autocompletado de código con `nvim-cmp`.
- **`:TSPlaygroundToggle`**: Ver el análisis sintáctico del código.
- **`:`**: Ejecutar comandos dentro de Neovim
- **`:split`** dividir la ventana horizontalmente
- **`:terminal`**: Abrir una terminal integrada

