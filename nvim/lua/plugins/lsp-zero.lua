return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = true,
  },

  -- snippets
  {
  	"L3MON4D3/LuaSnip",
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets' },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        formatting = lsp_zero.cmp_format({details = true}),
        sources = {
          {name = 'nvim_lsp'},
          {name = 'luasnip'},
          },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      --- if you want to know more about lsp-zero and mason.nvim
      --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
      --  lsp_zero.default_keymaps({buffer = bufnr})
	lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false
        })
      end)


    require('mason-lspconfig').setup({
        ensure_installed = {  -- Language servers to auto-install
          'clangd',          -- C/C++
          'pyright',         -- Python
          'intelephense',    -- PHP
          'marksman',        -- Markdown
          'lua_ls'           -- Lua (for Neovim config)
        },
        handlers = {
          -- Default handler for all servers
          function(server_name)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Server-specific configurations
            local server_opts = {
              capabilities = capabilities
            }

            if server_name == 'clangd' then
              server_opts.cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=never",
                "--completion-style=detailed",
                "--query-driver=/usr/bin/clang++",  -- Path to your actual compiler
                "--compile-commands-dir=./"         -- Explicitly point to project root
              }

              -- Add fallback flags for single-file projects
              server_opts.init_options = {
                clangdFileStatus = true,
                fallbackFlags = { "-std=c++20", "-Wall", "-Wextra" }
              }
            end

            -- Python Configuration (pyright)
            if server_name == 'pyright' then
              server_opts.settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                  }
                }
              }
            end

            -- PHP Configuration (intelephense)
            if server_name == 'intelephense' then
              server_opts.settings = {
                intelephense = {
                  files = {
                    maxSize = 5000000  -- Increase for large PHP files
                  }
                }
              }
            end

            -- Lua Configuration (lua_ls)
            if server_name == 'lua_ls' then
              server_opts.settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  workspace = { checkThirdParty = false },
                  telemetry = { enable = false }
                }
              }
            end

            require('lspconfig')[server_name].setup(server_opts)
          end
        }
      })
    end
  }
}
