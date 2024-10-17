return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPre", "BufNewFile" },
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'windwp/nvim-ts-autotag'
    },
    opts = {
        highlight = {
            enable = true,
        },
        indent = { enable = true },
        auto_install = true, -- automatically install syntax support when entering new file type buffer
        autotag = {
            enable = true,
        },
        ensure_installed = {
            "json",
            "javascript",
            "typescript",
            "tsx",
            "yaml",
            "html",
            "css",
            "prisma",
            "markdown",
            "markdown_inline",
            "svelte",
            "graphql",
            "bash",
            "lua",
            "vim",
            "dockerfile",
            "gitignore",
            "query",
            "vimdoc",
            "c",
        },
    },
    config = function (_, opts)
        local configs = require("nvim-treesitter.configs")
        configs.setup(opts)
    end
}
