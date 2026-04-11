-- Plugin spec for pi.nvim
-- This file returns a table suitable for plugin managers like 'lazy.nvim' or 'packer'
-- The plugin is configured lazily and its setup is executed in the `config` function,
-- avoiding calling `require("pi").setup()` at module load time.

return {
    {
        "pablopunk/pi.nvim",
        config = function()
            local ok, pi = pcall(require, "pi")
            if not ok or not pi then
                vim.notify("pi.nvim: failed to load module 'pi'", vim.log.levels.WARN)
                return
            end

            pi.setup({
                -- Provider settings
                provider = "github-copilot",
                model = "gpt-5-mini",

                -- Context limits
                max_context_lines = 300,
                max_context_bytes = 24000,
                selection_context_lines = 40,

                -- Logging
                log_path = "/tmp/pi-nvim.log",

                -- Feature toggles
                skills = true,
                extensions = true,
                tools = true,

            })
        end,
    },
}
