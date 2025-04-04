return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "asm_lsp",
          "bashls",
          "clangd",
          "cmake",
          "glsl_analyzer",
          "html",
          "jsonls",
          "ltex",
          "grammarly",
          "pylsp",
          "vuels"
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities
      })
      lspconfig.asm_lsp.setup({
        capabilities = capabilities
      })
      lspconfig.bashls.setup({
        capabilities = capabilities
      })
      lspconfig.clangd.setup({
        capabilities = capabilities
      })
      lspconfig.cmake.setup({
        capabilities = capabilities
      })
      lspconfig.glsl_analyzer.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities
      })
      lspconfig.ltex.setup({
        capabilities = capabilities
      })
      lspconfig.grammarly.setup({
        capabilities = capabilities
      })
      lspconfig.pylsp.setup({
        capabilities = capabilities,
      })
      lspconfig.vuels.setup({
        capabilities = capabilities
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

    end
  }
}
