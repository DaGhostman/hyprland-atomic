return {
    {
        "onsails/lspkind.nvim"
    },
    {
        "hrsh7th/nvim-cmp", dependencies  = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
        }, 
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            cmp.setup {
                enabled    = true,
                symbol_map = {
                    Copilot = "",
                },
                completion = {
                    autocomplete = false,
                },
                preselect  = cmp.PreselectMode.None,
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        show_labelDetails = true,
                    }),
                },
                snippet    = {
                    expand = function(args) require("luasnip").lsp_expand(args.body) end,
                },
                window     = {
                    completeion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping    = cmp.mapping.preset.insert {
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        -- select = true,
                    }),
                    ["<esc>"] = cmp.mapping.abort(),
                },
                sources    = cmp.config.sources({
                    { name = "nvim_lsp", },
                    { name = "copilot", },
                }),
            }
        end
    }
}
