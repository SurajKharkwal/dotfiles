require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "clangd", "tailwindcss", "prismals", "pyright", "qmlls", "bashls" }
vim.lsp.enable(servers)
