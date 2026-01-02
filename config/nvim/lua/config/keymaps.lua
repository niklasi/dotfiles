if vim.opt.diff:get() then
  vim.keymap.set('n', '<leader>1', '<cmd>diffget LOCAL<CR>', { silent = true })
  vim.keymap.set('n', '<leader>2', '<cmd>diffget BASE<CR>', { silent = true })
  vim.keymap.set('n', '<leader>3', '<cmd>diffget REMOTE<CR>', { silent = true })
end

if not vim.g.loaded_tmux_navigator == 1 or vim.opt.diff:get() then
  vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
  vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
end

vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>', { silent = true })
vim.keymap.set('n', '<C-f>', '<cmd>Telescope live_grep<CR>', { silent = true })
vim.keymap.set('n', '<C-b>', '<cmd>Telescope buffers<CR>', { silent = true })
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { silent = true })
vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<CR>', { silent = true })
vim.keymap.set('n', '<leader>gs', '<cmd>G<CR>', { silent = true })
vim.keymap.set('t', '<leader>c', '<C-\\><C-n>', { silent = true })
vim.keymap.set('n', '<leader>z', '<cmd>UndotreeToggle<CR>', { silent = true })

-- Copy and paste to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { silent = true })
vim.keymap.set('v', '<leader>y', '"+y', { silent = true })
vim.keymap.set('v', '<leader>d', '"+d', { silent = true })
vim.keymap.set('n', '<C-y><C-y>', '"+yy', { silent = true })
vim.keymap.set('x', 'p', '"_dP', { silent = true })

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { silent = true })

-- Move visual blocks up and down
vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { silent = true })
vim.keymap.set("n", "<leader>e", function()
  local git_path = vim.fn.finddir(".git", ".;")
  local cd_git = vim.fn.fnamemodify(git_path, ":h")
  vim.api.nvim_command(string.format("edit %s", cd_git))
  end, { desc = "edit .git root" })
vim.keymap.set('n', '<leader><leader>e', '<cmd>Oil<CR>', { silent = true })

vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { silent = true })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { silent = true })
vim.keymap.set('n', ']Q', '<cmd>clast<CR>', { silent = true })
vim.keymap.set('n', '[Q', '<cmd>cfirst<CR>', { silent = true })

vim.keymap.set('n', '<C-w>m', '<cmd>MaximizerToggle<CR>', { silent = true })
