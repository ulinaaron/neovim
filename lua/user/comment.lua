local M =	{ 
  'echasnovski/mini.comment',
  version = '*',
  event = "VeryLazy",
}

function M.config()
   require('mini.comment').setup()
end

return M
