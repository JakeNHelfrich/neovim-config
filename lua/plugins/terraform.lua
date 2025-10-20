return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {
          enabled = true,
        },
      },
    },
  },
}
