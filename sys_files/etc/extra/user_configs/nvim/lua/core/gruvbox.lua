return {
    {
        "ellisonleao/gruvbox.nvim", priority = 1000, config = function()
            require("gruvbox").setup {
                transparent_mode = true,
                dim_inactive = false,
                invert_tabline = true,
            }

            vim.o.background = "dark"
            vim.cmd("colorscheme gruvbox");
        end,
    }
}
