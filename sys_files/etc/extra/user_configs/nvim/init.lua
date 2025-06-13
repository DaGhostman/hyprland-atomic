require("config.lazy")

vim.defer_fn(function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { 'rust', 'zig', "toml", "lua", "php", "typescript", "javascript", "markdown_inline" },
        auto_install = true,
        sync_install = true,
        ignore_install = {},
        modules = {},
        highlight = { enable = false },
        indent = { enable = true },
        fold = { enable = true },
        git = {
            enable = true,
            ignore = false,
            timeout = 400,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                scope_incremental = "<c-s>",
                node_decremental = "<M-space>",
            }
        },
        textobjects = {
            select = {
                enabled = true,
                lookahead = true,
                keymaps = {
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.innter",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                }
            }
        },
        move = {
            enabled = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            }
        }
    }
end, 0)

vim.diagnostic.config({
    virtual_text = false,
})
vim.cmd [[ source $HOME/.vimrc ]]

