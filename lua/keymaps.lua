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

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Commander
commander.add({
  {
    cmd = "<CMD>Telescope commander<CR>",
    keys = {{"n", "i", "v"}, "<C-S-P>", opts},
    show = false
  },
  {
    desc = "Recent Files",
    cmd = ":Telescope oldfiles <CR>",
    keys = {{"n", "i", "v",}, "<leader>r", map_opts("Recent Files")},
    cat = "General"
  },
  {
    desc = "Projects",
    cmd = ":lua require('telescope').extensions.projects.projects()<CR>",
    keys = {{"n", "i", "v",}, "<leader>p", map_opts("Projects")},
    cat = "General"
  },
  {
    desc = "File Explorer",
    cmd = ":NvimTreeToggle<CR>",
    keys = {{"n", "i", "v",}, "<leader>e", map_opts("File Explorer")},
    cat = "General"
  },
})

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
    keys = {"n", "<S-Left>"},
  },
  {
    desc = "Navigate buffers - Previous",
    cmd = ":bprevious<CR>",
    keys = {"n", "<S-Right>"},
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
    desc = "Paste",
    cmd = "P",
    keys = {"v", "p"},
  },
})

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

commander.add({
 {
        desc = "Status",
        cmd = ":!git status<cr>",
        keys = {"n", "<leader>gs"},
        cat = "Git"
    },
    {
        desc = "Add All",
        cmd = ":!git add .<cr>",
        keys = {"n", "<leader>ga"},
        cat = "Git"
    },
    {
        desc = "Commit",
        cmd = ":!git commit<cr>",
        keys = {"n", "<leader>gc"},
        cat = "Git"
    },
    {
        desc = "Push",
        cmd = ":!git push<cr>",
        keys = {"n", "<leader>gp"},
        cat = "Git"
    },
    {
        desc = "Fetch",
        cmd = ":!git fetch<cr>",
        keys = {"n", "<leader>gf"},
        cat = "Git"
    },
{
        desc = "LazyGit Client",
      cmd = "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
        keys = {"n", "<leader>gf"},
        cat = "Git"
    }

})


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
commander.add({
  {
    desc = "Indent line or selection",
    cmd = ">>",
    keys = {"n", "<C-]>"},
    cat = "Indenting"
  },
  {
    desc = "Indent visual selection and reselect",
    cmd = ">gv",
    keys = {"v", "<C-]>"},
    cat = "Indenting"
  },
  {
    desc = "Dedent line or selection",
    cmd = "<<",
    keys = {"n", "<C-[>"},
    cat = "Indenting"
  },
  {
    desc = "Dedent visual selection and reselect",
    cmd = "<gv",
    keys = {"v", "<C-[>"},
    cat = "Indenting"
  },
})

-- Buffers
vim.keymap.set("n", "<A-,>", "<C-^>", { noremap = true })
vim.keymap.set("n", "<A-.>", "<C-6>", { noremap = true })
vim.keymap.set("n", "<A-w>", ":bdelete<CR>", { noremap = true })
