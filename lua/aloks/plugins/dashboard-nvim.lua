return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      -- theme = "hyper", --  theme is doom and hyper default is hyper
      disable_move = false, --  default is false disable move keymap for hyper
      shortcut_type = "letter", --  shorcut type 'letter' or 'number'
      shuffle_letter = false, --  default is true, shortcut 'letter' will be randomize, set to false to have ordered letter.
      change_to_vcs_root = true, -- default is false,for open file in hyper mru. it will change to the root of vcs
      config = {
        shortcut = {
          {
            icon = " ",
            desc = "Github",
            group = "Label",
            action = "silent !xdg-open https://github.com/alokshandilya &",
            key = "f",
          },
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            desc = "󰛉 Close",
            group = "Label",
            action = "silent :q",
            key = "q",
          },
        },
      },
      hide = {
        statusline = true, -- hide statusline default is true
        tabline = true, -- hide the tabline
        winbar = true, -- hide winbar
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
