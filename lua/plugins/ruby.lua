return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          enabled = true,
          cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        },
        solargraph = {
          enabled = false,
        },
        rubocop = {
          -- If Solargraph and Rubocop are both enabled as an LSP,
          -- diagnostics will be duplicated because Solargraph
          -- already calls Rubocop if it is installed
          enabled = true,
          cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), "--lsp" },
        },
      },
    },
  },
}
