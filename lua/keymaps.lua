-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true,   -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

-- vim: ts=2 sts=2 sw=2 et

-- better movement in wrapped text
vim.keymap.set('n', 'j', function()
    return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true, desc = 'Down (wrap-aware)' })
vim.keymap.set('n', 'k', function()
    return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true, desc = 'Up (wrap-aware)' })

vim.keymap.set('n', '<C-Up>', '<C-w>+', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<C-w>-', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<C-w><', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<C-w>>', { desc = 'Increase window width' })

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor position' })

vim.keymap.set({ 'n' }, '<D-s>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set({ 'i' }, '<D-s>', '<ESC>:w<CR>i', { desc = 'Save file' })

vim.keymap.set('n', '<C-n>', ':tabe<CR>', { desc = 'Create new tab' })

-- ================= Make keymaps =================
-- Make terminal splits
vim.api.nvim_set_keymap('n', '<leader>mtv', ':vsplit | terminal<CR>',
    { noremap = true, silent = true, desc = '[M]ake [T]erminal ([V]ertical Split)' })
vim.api.nvim_set_keymap('n', '<leader>mth', ':split | terminal<CR>',
    { noremap = true, silent = true, desc = '[M]ake [T]erminal ([H]orizontal Split)' })
-- Make splits
vim.api.nvim_set_keymap('n', '<leader>msv', ':vsplit<CR>',
    { noremap = true, silent = true, desc = '[M]ake [S]plit [V]ertical' })
vim.api.nvim_set_keymap('n', '<leader>msh', ':split<CR>',
    { noremap = true, silent = true, desc = '[M]ake [S]plit [H]orizontal' })

-- ================= Toggle keymaps =================
-- Toggle Markdown preview
vim.keymap.set('n', '<leader>tm', ':MarkdownPreviewToggle<CR>', { desc = '[T]oggle [M]arkdown Preview' })

-- Oil file explorer
vim.keymap.set('n', '<leader>e', ':Oil --float<CR>', { desc = '[E]xplore files' })

-- -- pi AI keymaps
-- -- Ask pi with the current buffer as context
-- vim.keymap.set("n", "<leader>ai", ":PiAsk<CR>", { desc = "Ask pi" })
-- -- Ask pi with visual selection as context
-- vim.keymap.set("v", "<leader>ai", ":PiAskSelection<CR>", { desc = "Ask pi (selection)" })

-- Copilot AI keymaps
vim.keymap.set('n', '<leader>ct', ':Copilot toggle<CR>', { desc = '[A]I Copilot [T]oggle Buffer Status' })
vim.keymap.set('n', '<leader>cs', ':Copilot status<CR>', { desc = '[A]I Copilot [S]tatus' })
vim.keymap.set('n', '<leader>cl', ':Copilot model list<CR>', { desc = '[A]I Copilot [L]ist Models' })
vim.keymap.set('n', '<leader>cp', ':Copilot panel<CR>', { desc = '[A]I Copilot [P]anel' })
vim.keymap.set('n', '<leader>ca', ':Copilot suggestion toggle_auto_trigger<CR>',
    { desc = '[A]I Copilot Toggle [A]uto Trigger' })
vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = '[A]I Copilot [D]isable' })
vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = '[A]I Copilot [E]nable' })
