return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {
          enabled = true,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "astro",
      })
    end,
  },
}
