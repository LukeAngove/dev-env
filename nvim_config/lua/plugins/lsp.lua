local jit = require('jit')

local to_install = {
    "bashls",
    "dockerls",
    "rust_analyzer",
    "lua_ls",
}

if jit.arch == "x64" then
  table.insert(to_install, "clangd")
end

-- on_attach function to be called on LSP server startup
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to Declaration" })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to Implementation" })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "Add Workspace Folder" })
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = "Remove Workspace Folder" })
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr, desc = "List Workspace Folders" })
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "Go to References" })
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { buffer = bufnr, desc = "Format" })
end


local function config()
  local opts = {
    ensure_installed = {
      "c",
      "cpp",
      "css",
      "devicetree",
      "dockerfile",
      "dot",
      "doxygen",
      "go",
      "groovy",
      "haskell",
      "html",
      "ini",
      "json",
      "jinja",
      "jq",
      "lua",
      "markdown",
      "objdump",
      "pony",
      "python",
      "rust",
      "sql",
      "ssh_config",
      "terraform",
      "typescript",
      "udev",
      "verilog",
      "vhdl",
      "vim",
      "yaml",
      "zig",
    },
    sync_install = true,
  }
  require('nvim-treesitter.configs').setup(opts)
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          {
            "williamboman/mason.nvim",
            opts = {},
          },
        },
        opts = {
          ensure_installed = to_install
        },
      },
    },
    config = function()
      local lspconfig = require('lspconfig')
      for _, server in ipairs(to_install) do
        lspconfig[server].setup {
          on_attach = on_attach,
        }
      end
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = config,
    build = ":TSUpdate",
  },
}
