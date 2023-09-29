-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }
local commander = require("commander")

function map_opts(desc)
return {
    silent = true,
    desc = desc
  }
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Commander
commander.add({
  {
    cmd = "<CMD>Telescope commander<CR>",
    keys = {"n", "<C-S-P>", opts},
    show = false
  },
  {
    desc = "Projects",
    cmd = ":lua require('telescope').extensions.projects.projects()<CR>",
    keys = {{"n", "i", "v",}, "<leader>p", opts},
    cat = "General"
  },
  {
    desc = "File Explorer",
    cmd = ":NvimTreeToggle<CR>",
    keys = {{"n", "i", "v",}, "<leader>e", map_opts("File Explorer")},
    cat = "General"
  },
})


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

commander.add({
 {
    desc = "Navigate Window - Left",
    cmd = "<C-w>h",
    keys = {"n", "<C-h>"},
  },
  {
    desc = "Navigate Window - down",
    cmd = "<C-w>j",
    keys = {"n", "<C-j>"},
  },
  {
    desc = "Navigate Window - up",
    cmd = "<C-w>k",
    keys = {"n", "<C-k>"},
  },
  {
    desc = "Navigate Window - right",
    cmd = "<C-w>l",
    keys = {"n", "<C-l>"},
  },
  {
    desc = "Navigate buffers - Next",
    cmd = ":bnext<CR>",
    keys = {"n", "<S-l>","<S-Left>"},
  },
  {
    desc = "Navigate buffers - Previous",
    cmd = ":bprevious<CR>",
    keys = {"n", "<S-h>","<S-Right>"},
  },
{
    desc = "Clear highlights",
    cmd = "<cmd>nohlsearch<CR>",
    keys = {"n", "<leader>h"},
  },
  {
    desc = "Close buffers",
    cmd = "<cmd>Bdelete!<CR>",
    keys = {"n", "<S-q>"},
  },
  {
    desc = "Quit",
    cmd = ":qa!<CR>",
    keys = {"n", "<C-q>"},
    cat = "General"
  },
  {
    desc = "Better paste",
    cmd = "P",
    keys = {"v", "p"},
  },
})
--
-- -- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)
--
-- -- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-Left>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- keymap("n", "<S-Right>", ":bprevious<CR>", opts)
--
-- -- Clear highlights
-- keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)
--
-- -- Close buffers
-- keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)
--
-- -- Quit
-- keymap("n", "<C-q>", ":qa!<CR>", opts)
--
-- -- Better paste
-- keymap("v", "p", "P", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
-- keymap("n", "<leader>g", )
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", map_opts("Git Client"))

local mapping = {
    {"n", "<leader>gs", ":!git status<cr>", {silent = true, noremap = true, nowait = true, desc = "Status"}},
    {"n", "<leader>ga", ":!git add .<cr>", {silent = true, noremap = true, nowait = true, desc = "Add All"}},
    {"n", "<leader>gc", ":!git commit<cr>", {silent = true, noremap = true, nowait = true, desc = "Commit"}},
    {"n", "<leader>gp", ":!git push<cr>", {silent = true, noremap = true, nowait = true, desc = "Push"}},
    {"n", "<leader>gf", ":!git fetch<cr>", {silent = true, noremap = true, nowait = true, desc = "Fetch"}}
}

for _, map in ipairs(mapping) do
    vim.keymap.set(map[1], map[2], map[3], map[4])
end

-- Register the descriptions for which-key
require("which-key").register({
    g = {
        name = "+git",
        s = 'Status',
        a = 'Add All',
        c = 'Commit',
        p = 'Push',
        f = 'Fetch',
      }
}, {prefix = "<leader>"})

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)

-- Copy all
vim.keymap.set("n", "<C-c>", '"+y')

-- Copy in visual mode and maintain position
vim.keymap.set("v", "<C-c>", [["+y`']], { noremap = true, silent = true })

-- Copy current line
vim.keymap.set("n", "<C-Shift-c>", '"+yy')

-- Copy and paste current line
vim.keymap.set("n", "<C-c>", ':let @+=expand("%")<CR>o<C-r>+<Esc>', { expr = true })

-- Paste
vim.keymap.set("n", "<C-v>", '"+p')
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true })

-- Paste above current line
vim.keymap.set("n", "<C-Shift-v>", '"+P')

-- Select all in normal mode
vim.keymap.set("n", "<C-a>", "gg<S-v>G", { noremap = true })

-- Select all in visual mode
vim.keymap.set("v", "<C-a>", "<Esc>ggVG", { noremap = true })

-- Select all in insert mode
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { noremap = true })

-- Save file
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- Save file as
vim.keymap.set("n", "<C-Shift-s>", ":w!<CR>")

-- Close active buffer (like closing a tab)
vim.keymap.set("n", "<C-w>", ":bd<CR>")

-- Open file
vim.keymap.set("n", "<C-o>", ":e <C-r>=expand('%:p:h').'/'<CR>")

-- Undo
vim.keymap.set("i", "<C-z>", "<C-u>", { noremap = true })
vim.keymap.set("v", "<C-z>", "<C-u>", { noremap = true })
vim.keymap.set("n", "<C-z>", "u", { noremap = true })

-- Redo
vim.keymap.set("n", "<C-Shift-z>", "<C-r>")

-- Select current line
vim.keymap.set("n", "x", "V", { noremap = true })

-- Quit
vim.keymap.set("n", "<C-q>", ":qa!<CR>", { noremap = true })

-- Toggle Comments
vim.keymap.set("n", "<C-/>", "gcc", { noremap = true })
vim.keymap.set("v", "<C-/>", "gc", { noremap = true })

-- Enter and exit Insert mode
vim.keymap.set("n", "<BS>", "i")
vim.keymap.set("n", "i", "i")

-- Go to start of line
vim.keymap.set("i", "<A-S-Left>", "<ESC>I", { noremap = true })
vim.keymap.set("n", "<A-S-Left>", "^", { noremap = true })
vim.keymap.set("v", "<A-S-Left>", "^", { noremap = true })

-- Go to end of line
vim.keymap.set("i", "<A-S-Right>", "<ESC>A", { noremap = true })
vim.keymap.set("n", "<A-S-Right>", "$", { noremap = true })
vim.keymap.set("v", "<A-S-Right>", "$", { noremap = true })

-- Go to top of screen
vim.keymap.set("n", "<A-S-Up>", "<C-u>", { noremap = true })
vim.keymap.set("v", "<A-S-Up>", "<C-u>", { noremap = true })
vim.keymap.set("i", "<A-S-Up>", "<C-o><C-u>", { noremap = true })

-- Go to bottom of screen
vim.keymap.set("n", "<A-S-Down>", "<C-d>", { noremap = true })
vim.keymap.set("v", "<A-S-Down>", "<C-d>", { noremap = true })
vim.keymap.set("i", "<A-S-Down>", "<C-o><C-d>", { noremap = true })

-- Keybinding to move up 5 lines in all modes
vim.keymap.set("n", "<S-Up>", "5k", { noremap = true, silent = true })
vim.keymap.set("i", "<S-Up>", "<Esc>5ki", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Up>", "<Esc>5k", { noremap = true, silent = true })

-- Keybinding to move down 5 lines in all modes
vim.keymap.set("n", "<S-Down>", "5j", { noremap = true, silent = true })
vim.keymap.set("i", "<S-Down>", "<Esc>5ji", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Down>", "<Esc>5j", { noremap = true, silent = true })

-- Keybinding to move the current line up one in all modes
-- vim.keymap.set("n", "<A-S-Up>", ":<C-u>move-2<CR>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<A-S-Up>", "<Esc>:<C-u>move-2<CR>==gi", { noremap = true, silent = true })
-- vim.keymap.set("v", "<A-S-Up>", ":<C-u>move-2<CR>gv=gv", { noremap = true, silent = true })

-- Indenting
vim.keymap.set("n", "<C-]>", ">>")
vim.keymap.set("v", "<C-]>", ">gv")

vim.keymap.set("n", "<C-[>", "<<")
vim.keymap.set("v", "<C-[>", "<gv")

-- Buffers
vim.keymap.set("n", "<A-,>", "<C-^>", { noremap = true })
vim.keymap.set("n", "<A-.>", "<C-6>", { noremap = true })
vim.keymap.set("n", "<A-w>", ":bdelete<CR>", { noremap = true })


-- Search and replace
vim.keymap.set("n", "<C-f>", "<leader>sb")
vim.keymap.set("n", "<C-Shift-f>", ":%s//g<Left><Left>") -- Function to check if Neotree is open

vim.keymap.set("v", "<ESC>", ":<C-u>nohlsearch<CR>", { noremap = true, silent = true })
