return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "bundled_build.lua",  -- Bundles `mcp-hub` binary along with the neovim plugin
    config = function()
        require("mcphub").setup({
            use_bundled_binary = true,  -- Use local `mcp-hub` binary
        })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    config = function()
	require("copilot").setup()

    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    keys = {
      { "<leader>ac", "<cmd>CopilotChatChat<cr>", desc = "Copilot - Chat" },
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Copilot - Explain" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Copilot - Generate Tests" },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "zbirenbaum/copilot.lua",
    },
    config = function()
      require("codecompanion").setup({
        -- Configure for your free LLM (Ollama)
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "ollama",
          },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "ollama",
              schema = {
                model = {
                  --default = "llama3.1:8b",
                  default = "qwen3:8b",
                },
              },
            })
          end,
        },
        -- Register MCP Hub as an extension
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true, -- Show mcp tool results in chat
              make_vars = true, -- Convert resources to #variables
              make_slash_commands = true, -- Add prompts as /slash commands
              requires_approval = true,
            }
          }
        }
      })
    end,
  }
}
