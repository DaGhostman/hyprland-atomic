return {
    {
        "nvim-lualine/lualine.nvim",
        config = function() 
            require("lualine").setup {
                options = {
                    theme = "auto",
                    icons_enabled = false,
                    disabled_filetupes = { "NvimTree" },
                }, 
                extensions = { "nvim-tree", "nvim-dap-ui", "mason", "lazy", "symbols-outline", "fzf" },
            }
        end
    }
}
