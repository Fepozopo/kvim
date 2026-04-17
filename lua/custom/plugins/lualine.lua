return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
            'arkav/lualine-lsp-progress', -- optional, for lsp progress
        },
        config = function()
            -- try to require sidekick.status safely; if not available we'll still configure lualine
            local has_sidekick, sidekick_status = pcall(require, "sidekick.status")

            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                    globalstatus = false,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = {
                        'filename',
                        -- Sidekick Copilot NES / status indicator
                        {
                            function()
                                -- show a small icon; the color will reflect status
                                return " "
                            end,
                            color = function()
                                if not has_sidekick then return nil end
                                local status = sidekick_status.get and sidekick_status.get() or nil
                                if status then
                                    if status.kind == "Error" then
                                        return "DiagnosticError"
                                    end
                                    if status.busy then
                                        return "DiagnosticWarn"
                                    end
                                    return "DiagnosticInfo"
                                end
                                return nil
                            end,
                            cond = function()
                                if not has_sidekick then return false end
                                return sidekick_status.get and sidekick_status.get() ~= nil
                            end,
                        },
                    },
                    lualine_x = {
                        -- Sidekick CLI sessions indicator
                        {
                            function()
                                if not has_sidekick then return "" end
                                local cli = {}
                                if sidekick_status.cli then
                                    cli = sidekick_status.cli() or {}
                                end
                                -- if there are multiple sessions show the count, otherwise show a single icon
                                return " " .. ((#cli > 1) and tostring(#cli) or "")
                            end,
                            cond = function()
                                if not has_sidekick then return false end
                                if not sidekick_status.cli then return false end
                                local cli = sidekick_status.cli() or {}
                                return #cli > 0
                            end,
                            color = function()
                                -- keep a consistent highlight for the CLI indicator
                                return "DiagnosticInfo"
                            end,
                        },
                        'encoding',
                        'fileformat',
                        'filetype',
                    },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            }
        end,
    }
}
