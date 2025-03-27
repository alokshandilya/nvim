return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For icons in the file explorer
  },
  config = function()
    -- Disable netrw (Vim's built-in file explorer)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Import nvim-tree
    local nvimtree = require("nvim-tree")

    -- Function to calculate dynamic width
    local function calculate_width()
      return math.floor(vim.o.columns * 0.2) -- 20% of the screen width
    end

    -- Default settings for nvim-tree
    nvimtree.setup({
      -- General behavior
      auto_reload_on_write = true,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      open_on_tab = false,
      sort_by = "name", -- Sort files by name
      view = {
        adaptive_size = false, -- Don't adjust size dynamically
        centralize_selection = false,
        cursorline = true, -- Highlight the current line
        debounce_delay = 15,
        side = "left", -- Position the file explorer on the left
        preserve_window_proportions = false,
        number = false, -- Disable line numbers
        relativenumber = false, -- Disable relative line numbers
        signcolumn = "yes", -- Show the sign column
        width = calculate_width(), -- Dynamically calculate width
        float = {
          enable = false, -- Disable floating window mode by default
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false, -- Don't add trailing slashes to directories
        group_empty = false, -- Don't group empty folders
        highlight_git = false, -- Disable Git status highlighting
        highlight_opened_files = "none", -- Don't highlight opened files
        root_folder_label = ":~:s?$?/..?", -- Display root folder label
        indent_markers = {
          enable = true, -- Enable indentation markers
          inline_arrows = true, -- Use inline arrows for indentation
          icons = {
            corner = "└",
            edge = "│",
            item = "─",
          },
        },
        icons = {
          git_placement = "after", -- Place Git indicators after filenames
          modified_placement = "before", -- Place modified indicators before filenames
          padding = " ", -- Add padding between icons and text
          symlink_arrow = " ➛ ", -- Symbol for symlinks
          show = {
            file = true, -- Show file icons
            folder = true, -- Show folder icons
            folder_arrow = true, -- Show folder arrows
            git = true, -- Show Git indicators
            modified = true, -- Show modified indicators
          },
          glyphs = {
            default = "", -- Default file icon
            symlink = "", -- Symlink file icon
            bookmark = "󰆤", -- Bookmark icon
            modified = "●", -- Modified indicator
            folder = {
              arrow_closed = "", -- Closed folder arrow
              arrow_open = "", -- Open folder arrow
              default = "", -- Default folder icon
              open = "", -- Open folder icon
              empty = "", -- Empty folder icon
              empty_open = "", -- Open empty folder icon
              symlink = "", -- Symlink folder icon
              symlink_open = "", -- Open symlink folder icon
            },
            git = {
              unstaged = "✗", -- Unstaged changes
              staged = "✓", -- Staged changes
              unmerged = "", -- Unmerged changes
              renamed = "➜", -- Renamed files
              untracked = "?", -- Untracked files
              deleted = "", -- Deleted files
              ignored = "◌", -- Ignored files
            },
          },
        },
      },
      hijack_directories = {
        enable = true, -- Hijack directory navigation
        auto_open = true, -- Automatically open the file explorer
      },
      update_focused_file = {
        enable = true, -- Update the file explorer when switching buffers
        update_root = false, -- Don't update the root directory
      },
      diagnostics = {
        enable = true, -- Enable diagnostic indicators
        show_on_dirs = true, -- Show diagnostics on directories
        icons = {
          hint = "", -- Hint diagnostic icon
          info = "", -- Info diagnostic icon
          warning = "", -- Warning diagnostic icon
          error = "", -- Error diagnostic icon
        },
      },
      filters = {
        dotfiles = false, -- Don't hide dotfiles
        custom = { "\\.pyc$", "__pycache__", "node_modules" }, -- Custom filters
      },
      git = {
        enable = true, -- Enable Git integration
        ignore = true, -- Ignore Gitignored files
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Don't close the file explorer when opening a file
          resize_window = true, -- Resize the window when opening a file
        },
      },
      trash = {
        cmd = "gio trash", -- Command for deleting files
      },
    })

    -- Keybindings for nvim-tree
    local keymap = vim.keymap.set
    keymap("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    keymap("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
    keymap("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    keymap("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
    keymap("n", "<leader>ew", function()
      require("nvim-tree").toggle({ float = { enable = true } }) -- Toggle floating window
    end, { desc = "Toggle floating file explorer" })
  end,
}

-- return {
--   "nvim-tree/nvim-tree.lua",
--   dependencies = {
--     "nvim-tree/nvim-web-devicons", -- For icons in the file explorer
--   },
--   config = function()
--     -- Disable netrw (Vim's built-in file explorer)
--     vim.g.loaded_netrw = 1
--     vim.g.loaded_netrwPlugin = 1
--
--     -- Import nvim-tree
--     local nvimtree = require("nvim-tree")
--
--     -- Default settings for nvim-tree
--     nvimtree.setup({
--       -- General behavior
--       auto_reload_on_write = true,
--       disable_netrw = false,
--       hijack_cursor = false,
--       hijack_netrw = true,
--       hijack_unnamed_buffer_when_opening = false,
--       open_on_tab = false,
--       sort_by = "name", -- Sort files by name
--       view = {
--         adaptive_size = false, -- Don't adjust size dynamically
--         centralize_selection = false,
--         cursorline = true, -- Highlight the current line
--         debounce_delay = 15,
--         side = "left", -- Position the file explorer on the left
--         preserve_window_proportions = false,
--         number = false, -- Disable line numbers
--         relativenumber = false, -- Disable relative line numbers
--         signcolumn = "yes", -- Show the sign column
--         width = 30, -- Set the width of the file explorer
--         float = {
--           enable = false, -- Disable floating window mode
--           quit_on_focus_loss = true,
--           open_win_config = {
--             relative = "editor",
--             border = "rounded",
--             width = 30,
--             height = 30,
--             row = 1,
--             col = 1,
--           },
--         },
--       },
--       renderer = {
--         add_trailing = false, -- Don't add trailing slashes to directories
--         group_empty = false, -- Don't group empty folders
--         highlight_git = false, -- Disable Git status highlighting
--         highlight_opened_files = "none", -- Don't highlight opened files
--         root_folder_label = ":~:s?$?/..?", -- Display root folder label
--         indent_markers = {
--           enable = true, -- Enable indentation markers
--           inline_arrows = true, -- Use inline arrows for indentation
--           icons = {
--             corner = "└",
--             edge = "│",
--             item = "─",
--           },
--         },
--         icons = {
--           webdev_enable = true, -- Enable web devicons
--           git_placement = "after", -- Place Git indicators after filenames
--           modified_placement = "before", -- Place modified indicators before filenames
--           padding = " ", -- Add padding between icons and text
--           symlink_arrow = " ➛ ", -- Symbol for symlinks
--           show = {
--             file = true, -- Show file icons
--             folder = true, -- Show folder icons
--             folder_arrow = true, -- Show folder arrows
--             git = true, -- Show Git indicators
--             modified = true, -- Show modified indicators
--           },
--           glyphs = {
--             default = "", -- Default file icon
--             symlink = "", -- Symlink file icon
--             bookmark = "󰆤", -- Bookmark icon
--             modified = "●", -- Modified indicator
--             folder = {
--               arrow_closed = "", -- Closed folder arrow
--               arrow_open = "", -- Open folder arrow
--               default = "", -- Default folder icon
--               open = "", -- Open folder icon
--               empty = "", -- Empty folder icon
--               empty_open = "", -- Open empty folder icon
--               symlink = "", -- Symlink folder icon
--               symlink_open = "", -- Open symlink folder icon
--             },
--             git = {
--               unstaged = "✗", -- Unstaged changes
--               staged = "✓", -- Staged changes
--               unmerged = "", -- Unmerged changes
--               renamed = "➜", -- Renamed files
--               untracked = "?", -- Untracked files
--               deleted = "", -- Deleted files
--               ignored = "◌", -- Ignored files
--             },
--           },
--         },
--       },
--       hijack_directories = {
--         enable = true, -- Hijack directory navigation
--         auto_open = true, -- Automatically open the file explorer
--       },
--       update_focused_file = {
--         enable = true, -- Update the file explorer when switching buffers
--         update_root = false, -- Don't update the root directory
--       },
--       diagnostics = {
--         enable = true, -- Enable diagnostic indicators
--         show_on_dirs = true, -- Show diagnostics on directories
--         icons = {
--           hint = "", -- Hint diagnostic icon
--           info = "", -- Info diagnostic icon
--           warning = "", -- Warning diagnostic icon
--           error = "", -- Error diagnostic icon
--         },
--       },
--       filters = {
--         dotfiles = false, -- Don't hide dotfiles
--         custom = {}, -- Custom filters
--       },
--       git = {
--         enable = true, -- Enable Git integration
--         ignore = true, -- Ignore Gitignored files
--       },
--       actions = {
--         open_file = {
--           quit_on_open = false, -- Don't close the file explorer when opening a file
--           resize_window = true, -- Resize the window when opening a file
--         },
--       },
--       trash = {
--         cmd = "gio trash", -- Command for deleting files
--       },
--     })
--
--     -- Keybindings for nvim-tree
--     local keymap = vim.keymap.set
--     keymap("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
--     keymap("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
--     keymap("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
--     keymap("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
--   end,
-- }

-- return {
--   "nvim-tree/nvim-tree.lua",
--   dependencies = {
--     "nvim-tree/nvim-web-devicons",
--     lazy = true,
--   },
--   config = function()
--     local nvimtree = require("nvim-tree")
--
--     -- recommended settings from nvim-tree documentation
--     vim.g.loaded_netrw = 1
--     vim.g.loaded_netrwPlugin = 1
--
--     nvimtree.setup({ -- BEGIN_DEFAULT_OPTS
--       on_attach = "default",
--       hijack_cursor = false,
--       auto_reload_on_write = true,
--       disable_netrw = false,
--       hijack_netrw = true,
--       hijack_unnamed_buffer_when_opening = false,
--       root_dirs = {},
--       prefer_startup_root = false,
--       sync_root_with_cwd = false,
--       reload_on_bufenter = false,
--       respect_buf_cwd = false,
--       select_prompts = false,
--       sort = {
--         sorter = "name",
--         folders_first = true,
--         files_first = false,
--       },
--       view = {
--         centralize_selection = false,
--         cursorline = true,
--         debounce_delay = 15,
--         side = "left",
--         preserve_window_proportions = false,
--         number = false,
--         relativenumber = false,
--         signcolumn = "yes",
--         width = 30,
--         float = {
--           enable = false,
--           quit_on_focus_loss = true,
--           open_win_config = {
--             relative = "editor",
--             border = "rounded",
--             width = 30,
--             height = 30,
--             row = 1,
--             col = 1,
--           },
--         },
--       },
--       renderer = {
--         add_trailing = false,
--         group_empty = false,
--         full_name = false,
--         root_folder_label = ":~:s?$?/..?",
--         indent_width = 2,
--         special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
--         hidden_display = "none",
--         symlink_destination = true,
--         highlight_git = "none",
--         highlight_diagnostics = "none",
--         highlight_opened_files = "none",
--         highlight_modified = "none",
--         highlight_hidden = "none",
--         highlight_bookmarks = "none",
--         highlight_clipboard = "name",
--         indent_markers = {
--           enable = true,
--           inline_arrows = true,
--           icons = {
--             corner = "└",
--             edge = "┊",
--             item = "┊",
--             bottom = "─",
--             none = " ",
--           },
--         },
--         icons = {
--           web_devicons = {
--             file = {
--               enable = true,
--               color = true,
--             },
--             folder = {
--               enable = false,
--               color = true,
--             },
--           },
--           git_placement = "after",
--           modified_placement = "before",
--           hidden_placement = "after",
--           diagnostics_placement = "signcolumn",
--           bookmarks_placement = "signcolumn",
--           padding = " ",
--           symlink_arrow = " ➛ ",
--           show = {
--             file = true,
--             folder = true,
--             folder_arrow = true,
--             git = true,
--             modified = true,
--             hidden = false,
--             diagnostics = true,
--             bookmarks = true,
--           },
--           glyphs = {
--             default = " ",
--             symlink = " ",
--             bookmark = "󰆤 ",
--             modified = "● ",
--             hidden = "󰜌 ",
--             folder = {
--               arrow_closed = " ",
--               arrow_open = " ",
--               default = " ",
--               open = " ",
--               empty = " ",
--               empty_open = " ",
--               symlink = " ",
--               symlink_open = " ",
--             },
--             git = {
--               unstaged = " ",
--               staged = " ",
--               unmerged = " ",
--               renamed = " ",
--               untracked = "󰫢 ",
--               deleted = " ",
--               ignored = " ",
--             },
--           },
--         },
--       },
--       hijack_directories = {
--         enable = true,
--         auto_open = true,
--       },
--       update_focused_file = {
--         enable = false,
--         update_root = {
--           enable = false,
--           ignore_list = {},
--         },
--         exclude = false,
--       },
--       system_open = {
--         cmd = "",
--         args = {},
--       },
--       git = {
--         enable = true,
--         show_on_dirs = true,
--         show_on_open_dirs = true,
--         disable_for_dirs = {},
--         timeout = 400,
--         cygwin_support = false,
--       },
--       diagnostics = {
--         enable = false,
--         show_on_dirs = false,
--         show_on_open_dirs = true,
--         debounce_delay = 50,
--         severity = {
--           min = vim.diagnostic.severity.HINT,
--           max = vim.diagnostic.severity.ERROR,
--         },
--         icons = {
--           hint = "",
--           info = "",
--           warning = "",
--           error = "",
--         },
--       },
--       modified = {
--         enable = false,
--         show_on_dirs = true,
--         show_on_open_dirs = true,
--       },
--       filters = {
--         enable = true,
--         git_ignored = true,
--         dotfiles = false,
--         git_clean = false,
--         no_buffer = false,
--         no_bookmark = false,
--         custom = {},
--         exclude = {},
--       },
--       live_filter = {
--         prefix = "[FILTER]: ",
--         always_show_folders = true,
--       },
--       filesystem_watchers = {
--         enable = true,
--         debounce_delay = 50,
--         ignore_dirs = {},
--       },
--       actions = {
--         use_system_clipboard = true,
--         change_dir = {
--           enable = true,
--           global = false,
--           restrict_above_cwd = false,
--         },
--         expand_all = {
--           max_folder_discovery = 300,
--           exclude = {},
--         },
--         file_popup = {
--           open_win_config = {
--             col = 1,
--             row = 1,
--             relative = "cursor",
--             border = "shadow",
--             style = "minimal",
--           },
--         },
--         open_file = {
--           quit_on_open = false,
--           eject = true,
--           resize_window = true,
--           window_picker = {
--             enable = true,
--             picker = "default",
--             chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
--             exclude = {
--               filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
--               buftype = { "nofile", "terminal", "help" },
--             },
--           },
--         },
--         remove_file = {
--           close_window = true,
--         },
--       },
--       trash = {
--         cmd = "gio trash",
--       },
--       tab = {
--         sync = {
--           open = false,
--           close = false,
--           ignore = {},
--         },
--       },
--       notify = {
--         threshold = vim.log.levels.INFO,
--         absolute_path = true,
--       },
--       help = {
--         sort_by = "key",
--       },
--       ui = {
--         confirm = {
--           remove = true,
--           trash = true,
--           default_yes = false,
--         },
--       },
--       experimental = {
--         actions = {
--           open_file = {
--             relative_path = false,
--           },
--         },
--       },
--       log = {
--         enable = false,
--         truncate = false,
--         types = {
--           all = false,
--           config = false,
--           copy_paste = false,
--           dev = false,
--           diagnostics = false,
--           git = false,
--           profile = false,
--           watcher = false,
--         },
--       },
--     }) -- END_DEFAULT_OPTS
--
--     -- set keymaps
--     local keymap = vim.keymap -- for conciseness
--
--     keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
--     keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
--     keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
--     keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
--   end,
-- }
