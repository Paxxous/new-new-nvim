return {
  {
    -- (gx opens it)
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    {
      'williamboman/mason.nvim',
      priority = 1000,

      config = function()
        require('mason').setup()
      end,
    },

    {
      'williamboman/mason-lspconfig.nvim',


      config = function()
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local default_setup = function(server)
          require('lspconfig')[server].setup({
            capabilities = lsp_capabilities,
          })
        end

        require("mason-lspconfig").setup({
          ensure_installed = {
            'lua_ls',
            'rust_analyzer',
            'gopls',
            'tsserver',
            'emmet_ls',
            'html',
            'marksman',
            'clangd',
          },
          handlers = {
            default_setup,
          }
        })
      end,
    },

    -- setup the lsp
    {
      'neovim/nvim-lspconfig',

      config = function()
        local lspconfig = require('lspconfig')


        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            local opts = { buffer = ev.buf }

            -- change how you want
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

            vim.keymap.set('n', '<leader>ft', function()
              vim.lsp.buf.format { async = true }
            end, opts)
          end,
        })
      end,
    },
  },
  }
