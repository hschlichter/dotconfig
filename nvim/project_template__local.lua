function p4_edit_current_file()
    local filepath = vim.fn.expand('%:p')
    if vim.bo.readonly then
        vim.api.nvim_buf_set_option(0, 'readonly', false)
        vim.cmd('silent !p4 edit ' .. filepath)
        vim.cmd('checktime')
        vim.api.nvim_buf_set_option(0, 'modifiable', true)
    end
end

vim.api.nvim_create_augroup('P4EditOnInsert', { clear = true })
vim.api.nvim_create_autocmd('InsertEnter', {
    group = 'P4EditOnInsert',
    pattern = '*',
    callback = p4_edit_current_file,
})
