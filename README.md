
# Configuración de Neovim

Este documento explica cómo configurar Neovim con varios complementos útiles para mejorar tu experiencia de desarrollo. La configuración incluye herramientas como NvimTree, Telescope, Lualine, Treesitter, y LSP para autocompletado y resaltado de sintaxis.

## **Archivo de Configuración Completo (`init.lua`)**

Este es el archivo de configuración que debes colocar en `~/.config/nvim/init.lua`.

```lua
-- Configuración de Neovim por David

-- Opciones básicas
vim.opt.number = true  -- Habilitar numeración de líneas
-- vim.opt.relativenumber = true  -- Líneas relativas
vim.opt.tabstop = 4  -- Tamaño de tabulación
vim.opt.shiftwidth = 4  -- Tamaño de indentación
vim.opt.expandtab = true  -- Usar espacios en lugar de tabulaciones
vim.opt.clipboard = "unnamedplus"  -- Usar portapapeles del sistema
vim.opt.hlsearch = true  -- Resaltar búsqueda
vim.opt.incsearch = true  -- Actualización en tiempo real al buscar

-- Atajos personalizados
-- Mapear Ctrl+z para deshacer
vim.api.nvim_set_keymap('n', '<C-z>', 'u', { noremap = true, silent = true })
-- Mapear Ctrl+y para rehacer
vim.api.nvim_set_keymap('n', '<C-y>', '<C-r>', { noremap = true, silent = true })
-- Modo de inserción: Ctrl+z para deshacer y Ctrl+y para rehacer
vim.api.nvim_set_keymap('i', '<C-z>', '<Esc>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-y>', '<Esc><C-r>', { noremap = true, silent = true })

-- Autoguardado
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
    pattern = "*",
    callback = function()
        if vim.bo.modified then
            vim.cmd("write")
        end
    end,
})

-- Plugins
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer se gestiona a sí mismo
    use 'nvim-treesitter/nvim-treesitter' -- Coloreado avanzado
    use 'nvim-lualine/lualine.nvim' -- Barra de estado
    use 'neovim/nvim-lspconfig' -- Configuración de LSP
    use 'hrsh7th/nvim-cmp' -- Autocompletado
    use 'nvim-telescope/telescope.nvim' -- Búsqueda avanzada
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- Opcional, para íconos
        },
        tag = 'nightly' -- Versión estable
    }
end)

-- Configuración de plugins
-- Explorador de archivos NvimTree
require('nvim-tree').setup {
    view = {
        width = 30,
        side = 'left',
    },
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
}

-- Barra de estado Lualine
require('lualine').setup {
    options = {
        theme = 'gruvbox',
    },
}

-- Configuración de Telescope
require('telescope').setup {}

-- Abrir NvimTree automáticamente al iniciar Neovim
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        require("nvim-tree.api").tree.open()
    end,
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

