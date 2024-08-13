-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true,                               opts = ... },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- File Tree
    {
      "nvim-tree/nvim-tree.lua",
      lazy = false,
      requires = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup({})
      end,
    },
    { "akinsho/bufferline.nvim",  version = "*",   dependencies = "nvim-tree/nvim-web-devicons" },
    -- install with yarn or npm
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && yarn install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    },
    -- automatic setup of language servers
    {
      {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
      },

      {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
      },

      {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
          local cmp = require("cmp")
          local cmp_action = require("lsp-zero").cmp_action()

          cmp.setup({
            sources = {
              { name = "nvim_lsp" },
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-u>"] = cmp.mapping.scroll_docs(-4),
              ["<C-d>"] = cmp.mapping.scroll_docs(4),
              ["<C-f>"] = cmp_action.vim_snippet_jump_forward(),
              ["<C-b>"] = cmp_action.vim_snippet_jump_backward(),
            }),
            snippet = {
              expand = function(args)
                vim.snippet.expand(args.body)
              end,
            },
          })
        end,
      },

      {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
          { "hrsh7th/cmp-nvim-lsp" },
          { "williamboman/mason.nvim" },
          { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
          local lsp_zero = require("lsp-zero")

          -- lsp_attach is where you enable features that only work
          -- if there is a language server active in the file
          local lsp_attach = function(client, bufnr)
            local opts = { buffer = bufnr }

            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
            vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
            vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
            vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
          end

          lsp_zero.extend_lspconfig({
            sign_text = true,
            lsp_attach = lsp_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })

          require("mason-lspconfig").setup({
            ensure_installed = {},
            handlers = {
              -- this first function is the "default handler"
              -- it applies to every language server without a "custom handler"
              function(server_name)
                require("lspconfig")[server_name].setup({})
              end,

              -- this is the "custom handler" for `lua_ls`
              lua_ls = function()
                -- (Optional) Configure lua language server for neovim
                require("lspconfig").lua_ls.setup({
                  on_init = function(client)
                    lsp_zero.nvim_lua_settings(client, {})
                  end,
                })
              end,
            },
          })
          -- ruff setup
          require("lspconfig").ruff.setup({
            trace = "messages",
            init_options = {
              settings = {
                logLevel = "debug",
              },
            },
          })
        end,
      },
      {
        "rmagatti/auto-session",
        lazy = false,
        dependencies = {
          "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
        },
        config = function()
          require("auto-session").setup({
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
          })
        end,
      },
      {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
      }
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
