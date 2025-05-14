vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", {desc="Open Parent Directory in Oil"})
-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)
-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)
