nmap = function(keys, fn, desc)
    vim.keymap.set("n", keys, fn, { desc = desc, silent = true, noremap = true })
end
tmap = function(keys, fn, desc)
    vim.keymap.set("t", keys, fn, { desc = desc, silent = true, noremap = true })
end
imap = function(keys, fn, desc)
    vim.keymap.set("i", keys, fn, { desc = desc, silent = true, noremap = true })
end
vmap = function(keys, fn, desc)
    vim.keymap.set("v", keys, fn, { desc = desc, silent = true, noremap = true })
end

require("config.lazy")

vim.defer_fn(function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { "toml", "yaml", "json", "lua", "markdown_inline", "markdown", "conf", "ini" },
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        modules = {},
        highlight = { enable = true },
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

