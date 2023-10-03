local utils = require "utils"
local get_icon = utils.get_icon
local is_available = utils.is_available

local maps = require("utils").empty_map_table()

local sections = {
  f = { desc = get_icon("Search", 1, true) .. "Find" },
  p = { desc = get_icon("Package", 1, true) .. "Packages" },
  l = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" },
  u = { desc = get_icon("Window", 1, true) .. "UI/UX" },
  b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
  bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
  d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
  g = { desc = get_icon("Git", 1, true) .. "Git" },
  S = { desc = get_icon("Session", 1, true) .. "Session" },
  t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
}

-- Normal --
-- Standard Operations
maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" }
maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" }
maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>q"] = { "<cmd>confirm q<cr>", desc = "Quit" }
maps.n["<leader>n"] = { "<cmd>enew<cr>", desc = "New File" }
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.n["<C-q>"] = { "<cmd>qa!<cr>", desc = "Force quit" }
maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }


-- Plugin Manager
maps.n["<leader>p"] = sections.p
maps.n["<leader>pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
maps.n["<leader>ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
maps.n["<leader>pS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
maps.n["<leader>pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
maps.n["<leader>pU"] = { function() require("lazy").update() end, desc = "Plugins Update" }

-- Comment
if is_available "Comment.nvim" then
  maps.n["<leader>/"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Toggle comment line",
  }
  maps.v["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = "Toggle comment for selection",
  }
end

-- Session Manager
if is_available "neovim-session-manager" then
  maps.n["<leader>S"] = sections.S
  maps.n["<leader>Sl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" }
  maps.n["<leader>Ss"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" }
  maps.n["<leader>Sd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" }
  maps.n["<leader>Sf"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" }
  maps.n["<leader>S."] =
  { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" }
end
if is_available "resession.nvim" then
  maps.n["<leader>S"] = sections.S
  maps.n["<leader>Sl"] = { function() require("resession").load "Last Session" end, desc = "Load last session" }
  maps.n["<leader>Ss"] = { function() require("resession").save() end, desc = "Save this session" }
  maps.n["<leader>St"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" }
  maps.n["<leader>Sd"] = { function() require("resession").delete() end, desc = "Delete a session" }
  maps.n["<leader>Sf"] = { function() require("resession").load() end, desc = "Load a session" }
  maps.n["<leader>S."] = {
    function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
    desc = "Load current directory session",
  }
end

-- Package Manager
if is_available "mason.nvim" then
  maps.n["<leader>pm"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
  maps.n["<leader>pM"] = { "<cmd>MasonUpdateAll<cr>", desc = "Mason Update" }
end

-- Smart Splits
if is_available "smart-splits.nvim" then
  maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

-- SymbolsOutline
if is_available "aerial.nvim" then
  maps.n["<leader>l"] = sections.l
  maps.n["<leader>lS"] = { function() require("aerial").toggle() end, desc = "Symbols outline" }
end

-- Telescope
if is_available "telescope.nvim" then
  maps.n["<leader>f"] = sections.f
  maps.n["<leader>g"] = sections.g
  maps.n["<leader>gb"] =
  { function() require("telescope.builtin").git_branches { use_file_path = true } end, desc = "Git branches" }
  maps.n["<leader>gc"] = {
    function() require("telescope.builtin").git_commits { use_file_path = true } end,
    desc = "Git commits (repository)",
  }
  maps.n["<leader>gC"] = {
    function() require("telescope.builtin").git_bcommits { use_file_path = true } end,
    desc = "Git commits (current file)",
  }
  maps.n["<leader>gt"] =
  { function() require("telescope.builtin").git_status { use_file_path = true } end, desc = "Git status" }
  maps.n["<leader>f<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
  maps.n["<leader>f'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
  maps.n["<leader>f/"] =
  { function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Find words in current buffer" }
end

-- Terminal
if is_available "toggleterm.nvim" then
  maps.n["<leader>t"] = sections.t
  if vim.fn.executable "lazygit" == 1 then
    maps.n["<leader>g"] = sections.g
    maps.n["<leader>gg"] = {
      function()
        local worktree = require("utils.git").file_worktree()
        local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
        utils.toggle_term_cmd("lazygit " .. flags)
      end,
      desc = "ToggleTerm lazygit",
    }
    maps.n["<leader>tl"] = maps.n["<leader>gg"]
  end
  if vim.fn.executable "node" == 1 then
    maps.n["<leader>tn"] = { function() utils.toggle_term_cmd "node" end, desc = "ToggleTerm node" }
  end
  if vim.fn.executable "gdu" == 1 then
    maps.n["<leader>tu"] = { function() utils.toggle_term_cmd "gdu" end, desc = "ToggleTerm gdu" }
  end
  if vim.fn.executable "btm" == 1 then
    maps.n["<leader>tt"] = { function() utils.toggle_term_cmd "btm" end, desc = "ToggleTerm btm" }
  end
  maps.n["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" }
  maps.n["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" }
  maps.n["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" }
  maps.n["<F7>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }
  maps.t["<F7>"] = maps.n["<F7>"]
  maps.n["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
  maps.t["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
end

utils.set_mappings(maps)


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
    keys = { { "n", "i", "v" }, "<C-S-P>", opts },
    show = false
  },
  {
    desc = "File Explorer",
    cmd = ":NvimTreeToggle<CR>",
    keys = { "n", "<leader>e", map_opts("File Explorer") },
    cat = "General"
  },
}, {})

-- Normal --

commander.add({
  {
    desc = "Navigate Window - Left",
    cmd = "<C-w>h",
    keys = { "n", "<C-h>" },
  },
  {
    desc = "Navigate Window - down",
    cmd = "<C-w>j",
    keys = { "n", "<C-j>" },
  },
  {
    desc = "Navigate Window - up",
    cmd = "<C-w>k",
    keys = { "n", "<c-k>" },
  },
  {
    desc = "navigate window - right",
    cmd = "<c-w>l",
    keys = { "n", "<c-l>" },
  },
  {
    desc = "navigate buffers - next",
    cmd = ":bnext<cr>",
    keys = { "n", "<s-left>" },
  },
  {
    desc = "Navigate buffers - Previous",
    cmd = ":bprevious<CR>",
    keys = { "n", "<S-Right>" },
  },
  {
    desc = "Close buffers",
    cmd = "<cmd>Bdelete!<CR>",
    keys = { "n", "<S-q>" },
  },
  {
    desc = "Quit",
    cmd = ":qa!<CR>",
    keys = { "n", "<C-q>" },
    cat = "General"
  },
  {
    desc = "Paste",
    cmd = "P",
    keys = { "v", "p" },
  },
}, {})

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- Telescope
-- commander.add({
--   {
--     desc = "Find Files",
--     cmd = ":Telescope find_files<CR>",
--     keys = { "n", "<leader>ff", map_opts("Find Files") },
--     cat = "Find"
--   },
--   {
--     desc = "Find Keyword Globally",
--     cmd = ":Telescope live_grep<CR>",
--     keys = { "n", "<leader>ft", map_opts("Find Keyword Globally") },
--     cat = "Find"
--   },
--   {
--     desc = "Projects",
--     cmd = ":Telescope projects<CR>",
--     keys = { "n", "<leader>fp", map_opts("Find Projects") },
--     cat = "Find"
--   },
--   {
--     desc = "Buffers",
--     cmd = ":Telescope buffers<CR>",
--     keys = { "n", "<leader>fb", map_opts("Find Buffers") },
--     cat = "Find"
--   },
--   {
--     cmd = ":Telescope find_files<CR>", -- Replace this with the default action you want for "<leader>f"
--     keys = { "n", "<leader>f", map_opts("+ Find") },
--     cat = "Find",
--     show = false
--   }
-- }, {})

-- Git
-- keymap("n", "<leader>g", )
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", map_opts("Git Client"))

-- commander.add({
--   {
--     desc = "Status",
--     cmd = ":!git status<cr>",
--     keys = { "n", "<leader>gs", map_opts("Status") },
--     cat = "Git"
--   },
--   {
--     desc = "Add All",
--     cmd = ":!git add .<cr>",
--     keys = { "n", "<leader>ga", map_opts("Add All") },
--     cat = "Git"
--   },
--   {
--     desc = "Commit",
--     cmd = ":!git commit<cr>",
--     keys = { "n", "<leader>gc", map_opts("Commit") },
--     cat = "Git"
--   },
--   {
--     desc = "Push",
--     cmd = ":!git push<cr>",
--     keys = { "n", "<leader>gp", map_opts("Push") },
--     cat = "Git"
--   },
--   {
--     desc = "Fetch",
--     cmd = ":!git fetch<cr>",
--     keys = { "n", "<leader>gf", map_opts("Fetch") },
--     cat = "Git"
--   },
--   {
--     desc = "LazyGit Client",
--     cmd = "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
--     keys = { "n", "<leader>gf", map_opts("LazyGit Client") },
--     cat = "Git"
--   },
-- }, {})

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
    keys = { "n", "<C-]>" },
    cat = "Indenting"
  },
  {
    desc = "Indent visual selection and reselect",
    cmd = ">gv",
    keys = { "v", "<C-]>" },
    cat = "Indenting"
  },
  {
    desc = "Dedent line or selection",
    cmd = "<<",
    keys = { "n", "<C-[>" },
    cat = "Indenting"
  },
  {
    desc = "Dedent visual selection and reselect",
    cmd = "<gv",
    keys = { "v", "<C-[>" },
    cat = "Indenting"
  },
}, {})

-- Buffers
vim.keymap.set("n", "<A-,>", "<C-^>", { noremap = true })
vim.keymap.set("n", "<A-.>", "<C-6>", { noremap = true })
vim.keymap.set("n", "<A-w>", ":bdelete<CR>", { noremap = true })

-- Util
vim.api.nvim_set_keymap('n', '<esc>', '<esc>', { noremap = true })
-- For Visual mode
vim.api.nvim_set_keymap('v', '<esc>', '<esc>', { noremap = true })
-- For Select mode
vim.api.nvim_set_keymap('s', '<esc>', '<esc>', { noremap = true })
