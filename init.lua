-- ~/.config/nvim/init.lua
-- Main Neovim entry point. The goal is to preserve the workflow from the old
-- Vim config while using native Neovim Lua plugins where they are a better fit.

-- Keep the historical Vim leader key so existing muscle memory still works.
vim.g.mapleader = ","

-- Bootstrap lazy.nvim if it is missing. Everything below this point assumes
-- lazy.nvim is on the runtimepath and can manage plugin installation/loading.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- General behavior
-- Core editor defaults that should be active before plugins load.
vim.opt.compatible = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.encoding = "utf-8"
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

-- Show LSP and linter diagnostics inline by default, while keeping updates out
-- of insert mode so typing does not constantly redraw messages.
vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    source = "if_many",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Vim compatibility aliases for accidental uppercase commands.
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

-- Small keymaps carried over from the Vim config.
vim.keymap.set("v", "<C-c>", ":w !pbcopy<CR><CR>", { silent = true })
vim.keymap.set("n", "z<space>", "za", { silent = true })

-- When opening a buffer, expand folds to the deepest existing fold level so
-- files do not start collapsed unexpectedly.
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    local max_fold = 0
    for i = 1, vim.fn.line("$") do
      max_fold = math.max(max_fold, vim.fn.foldlevel(i))
    end
    vim.opt_local.foldlevel = max_fold
  end,
})

-- UI
-- Display, search, and scrolling preferences. These are intentionally global
-- because they affect basic editing behavior across all filetypes.
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.backspace = "indent,eol,start"
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.scroll = 4
vim.opt.showmatch = true
vim.opt.scrolloff = 5
vim.opt.colorcolumn = "110"
vim.opt.wrap = false

-- Formatting/layout
-- Default indentation style. Language-specific overrides live in FileType
-- autocmds below or in formatter/LSP configuration.
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.g.vim_json_conceal = 0
vim.g.xml_syntax_folding = 0

-- Filetypes
-- Project-specific filenames and extensions that Neovim does not detect
-- correctly on its own.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "Dockerfile.ui",
  command = "set filetype=dockerfile",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.rabl",
  command = "set filetype=ruby",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "vue",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "Jenkinsfile",
  command = "set filetype=groovy",
})

require("lazy").setup({
  -- Theme
  -- Keep previous themes nearby as commented references while trying newer
  -- Lua-native themes.
  --{ "junegunn/seoul256.vim", priority = 1000 },
  -- { "NLKNguyen/papercolor-theme" },
  -- { "sainnhe/everforest" },
  --{ "ellisonleao/gruvbox.nvim" },
  --{ "lifepillar/vim-solarized8" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "rebelot/kanagawa.nvim", name = "kanagawa", priority = 1000 },

  -- File tree: NERDTree replacement
  -- Neo-tree provides the old NERDTree workflows: toggle the tree and reveal
  -- the current file, while showing dotfiles and hiding noisy directories.
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>nt", "<cmd>Neotree toggle<cr>" },
      { "<leader>nf", "<cmd>Neotree reveal<cr>" },
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",
      commands = {
        open_file_and_close_tree = function(state)
          local node = state.tree:get_node()
          require("neo-tree.sources.filesystem.commands").open(state)

          if node.type == "file" then
            require("neo-tree.sources.common.commands").close_window(state)
          end
        end,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = { "node_modules" },
        },
      },
      window = {
        width = 42,
        mappings = {
          ["<2-LeftMouse>"] = "open_file_and_close_tree",
          ["<cr>"] = "open_file_and_close_tree",
        },
      },
    },
  },

  -- Fuzzy finder: fzf/fzf.vim replacement
  -- Telescope backs Ctrl-P and related pickers. The bottom-pane layout keeps
  -- the file list close to the command area and leaves room for a preview.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
    },
    opts = {
      defaults = {
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 0.5,
          preview_width = 0.4,
        },
        path_display = { "smart" },
      },
    },
  },

  -- Comments: NERDCommenter replacement
  -- Comment.nvim's defaults are `gcc`/`gc`, with an extra mapping for the old
  -- NERDCommenter `<leader>c<space>` toggle muscle memory.
  {
    "numToStr/Comment.nvim",
    keys = {
      { "<leader>c<space>", "<Plug>(comment_toggle_linewise_current)", mode = "n", desc = "Toggle comment line" },
      { "<leader>c<space>", "<Plug>(comment_toggle_linewise_visual)", mode = "x", desc = "Toggle comment selection" },
    },
    opts = {
      padding = true,
      sticky = true,
    },
  },

  -- Statusline: vim-airline replacement
  -- Lualine keeps the statusline lightweight and shows the current project
  -- directory where airline previously showed custom section text.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
      },
      sections = {
        lualine_b = {
          function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
        },
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "branch" },
      },
    },
  },

  -- Git
  { "tpope/vim-fugitive" },

  -- Tmux split navigation
  { "christoomey/vim-tmux-navigator" },

  -- Indent guides: indentline replacement
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "┊",
      },
    },
  },

  -- Whitespace trimming: vim-better-whitespace replacement
  -- Strip trailing whitespace automatically before writes instead of only
  -- highlighting it. This mirrors the old StripWhitespace save hook.
  {
    "echasnovski/mini.trailspace",
    version = false,
    config = function()
      require("mini.trailspace").setup()
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          require("mini.trailspace").trim()
        end,
      })
    end,
  },

  -- Treesitter syntax
  -- nvim-treesitter's current API separates parser installation from enabling
  -- editor features, so install parsers here and enable highlighting/indent per
  -- supported filetype below.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local treesitter_languages = {
        "javascript",
        "typescript",
        "tsx",
        "json",
        "html",
        "css",
        "vue",
        "ruby",
        "dockerfile",
        "terraform",
        "hcl",
        "groovy",
        "lua",
        "vim",
      }

      -- Install is a no-op for languages that are already present.
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install(treesitter_languages)

      -- Start Treesitter only for filetypes with known parser support. The
      -- pcall avoids surfacing an error if a parser is not installed yet.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "json",
          "html",
          "css",
          "vue",
          "ruby",
          "dockerfile",
          "terraform",
          "hcl",
          "groovy",
          "lua",
          "vim",
        },
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- LSP + completion: coc.nvim replacement
  -- Mason installs language-server executables, mason-lspconfig bridges Mason
  -- package names to lspconfig server names, and blink.cmp provides completion
  -- capabilities to every configured language server.
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("mason").setup()

      -- These packages are installed/kept available by Mason. If a package fails
      -- to install, Mason will report the underlying toolchain problem.
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "jsonls",
          "ruby_lsp",
          "terraformls",
          "vuels",
        },
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Servers enabled at startup. Each receives the same completion
      -- capabilities; server-specific customizations can be added in this loop.
      local servers = {
        "ts_ls",
        "eslint",
        "jsonls",
        "ruby_lsp",
        "terraformls",
        "vuels",
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
        vim.lsp.enable(server)
      end

      vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
      vim.keymap.set("n", "gr", vim.lsp.buf.references)

      -- Highlight references under the cursor when the current LSP supports it.
      -- The capability guard prevents errors in buffers like netrw.
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          local clients = vim.lsp.get_clients({
            bufnr = 0,
            method = "textDocument/documentHighlight",
          })

          if #clients > 0 then
            vim.lsp.buf.document_highlight()
          end
        end,
      })
      -- Clear highlights on cursor move to avoid stale highlights after moving away from a symbol.
      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
          local clients = vim.lsp.get_clients({
            bufnr = 0,
            method = "textDocument/documentHighlight",
          })

          if #clients > 0 then
            vim.lsp.buf.clear_references()
          end
        end,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      completion = {
        documentation = { auto_show = true },
      },
    },
  },

  -- Formatting: vim-prettier/coc-prettier replacement
  -- Conform owns formatting-on-save. For JS/TS/Vue, ESLint LSP fixes run first
  -- when available, then Prettier handles formatting.
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = function()
        if vim.fn.exists(":LspEslintFixAll") == 2 then
          vim.cmd("LspEslintFixAll")
        end

        return {
          timeout_ms = 3000,
          lsp_fallback = true,
        }
      end,
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        ruby = { "rubocop" },
      },
    },
  },

  -- Linting: syntastic replacement
  -- nvim-lint is used only for filetypes not already covered by LSP diagnostics.
  -- The executable filter keeps missing optional tools from producing popups.
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        ruby = { "rubocop" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint(nil, {
            filter = function(linter)
              local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
              return cmd ~= nil and vim.fn.executable(cmd) == 1
            end,
          })
        end,
      })
    end,
  },

  -- Language/framework helpers
  { "mattn/emmet-vim" },
  { "tpope/vim-rails" },
  { "briancollins/vim-jst" },
  { "amadeus/vim-mjml" },
  { "github/copilot.vim" },

  -- Terraform helpers
  { "hashivim/vim-terraform" },
})

-- Apply the colorscheme after lazy.nvim has loaded theme plugins.
vim.cmd.colorscheme("kanagawa")
--vim.g.seoul256_background = 233

-- Keep the cursor line styling from the old Vim config.
vim.cmd("highlight CursorLine cterm=NONE ctermbg=16 ctermfg=NONE")
