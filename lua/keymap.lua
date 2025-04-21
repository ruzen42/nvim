local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'h', '<Left>', opts) 
vim.keymap.set('n', 't', '<Down>', opts) 
vim.keymap.set('n', 'n', '<Up>', opts) 
vim.keymap.set('n', 's', '<Right>', opts) 

vim.keymap.set('n', 'j', '<Nop>', opts) 
vim.keymap.set('n', 'k', '<Nop>', opts) 
vim.keymap.set('n', 'l', '<Nop>', opts) 

vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

