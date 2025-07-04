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
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = config,
    build = ":TSUpdate",
  },
}

