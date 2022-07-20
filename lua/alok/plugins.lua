local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  -- My plugins here
  -- updated
  use({ "wbthomason/packer.nvim", commit = "494fd5999b19e29992eb0978c4fa8988d2023ad8" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim", commit = "986ad71ae930c7d96e812734540511b4ca838aa2" }) -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs", commit = "972a7977e759733dd6721af7bcda7a67e40c010e" }) -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim", commit = "7c49fb2ac01a9f03410100c8e78f647bbea857e8" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" })
  use({ "kyazdani42/nvim-web-devicons", commit = "2d02a56189e2bde11edd4712fea16f08a6656944" })
  use({ "kyazdani42/nvim-tree.lua", commit = "06e48c29c4543331eee41753e69e3bd2235bf430" })
  use({ "akinsho/bufferline.nvim", commit = "d7b775a35be9c80ed591d3335b35ec84e5c5d81e" })
  use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
  use({ "nvim-lualine/lualine.nvim", commit = "655411fb7aa3cf4d46094132d684d815453f5043" })
  use({ "akinsho/toggleterm.nvim", commit = "3f9d383f1f89eb5a1558ee612061eccaca385680" })
  use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
  use({ "lewis6991/impatient.nvim", commit = "2aa872de40dbbebe8e2d3a0b8c5651b81fe8b235" })
  use({ "lukas-reineke/indent-blankline.nvim", commit = "4a58fe6e9854ccfe6c6b0f59abb7cb8301e23025" })
  use({ "goolord/alpha-nvim", commit = "79187fdf8f2a08a7174f237423198f6e75ae213a" })
  use({ "folke/which-key.nvim", commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71" })
  
  -- Fugitive is the premier Vim plugin for Git
  use({ "tpope/vim-fugitive", commit = "ff04324bffd86f9c146cc5fc2c0a2f95a1509643" })

  -- Colorschemes
  use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
  use({ "sainnhe/gruvbox-material", commit = "3db676452dcbcc75bcad2de49fb9855dc0113933" })
  use({ "joshdick/onedark.vim", commit = "1fe54f212f09a03c2b5e277f0fe5b7b9d0b0a4ed" })

  -- Colorizer
  use({ "norcalli/nvim-colorizer.lua", commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6" })

  -- Markdown preview
  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  -- Icon picker
  use({ "stevearc/dressing.nvim", commt = "1e60c07ae9a8557ac6395144606c3a5335ad47e0" })
  use({
    "ziontee113/icon-picker.nvim", commit = "4f373fbb99ddd7f1a76c6b5a4b08be93aca6891f",
    config = function()
      require("icon-picker")
    end,
  })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
  use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions
  use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
  use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

  -- snippets
  use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine
  use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" }) -- enable LSP
  use({ "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" }) -- simple to use language server installer
  use({ "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" }) -- for formatters and linters

  -- Telescope
  use({ "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    commit = "518e27589c0463af15463c9d675c65e464efc2fe",
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
