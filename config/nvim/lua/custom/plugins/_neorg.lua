return {
  "nvim-neorg/neorg",
  event = "VeryLazy",
  build = ":Neorg sync-parsers",
  opts = {
    load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.norg.concealer"] = {
        config = {
          folds = false
        }
      },                           -- Adds pretty icons to your documents
          ["core.norg.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            root = "~/workspace/notes",
          },
          default_workspace = "root",
        },
      },
          ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
          ["core.integrations.telescope"] = {},
    },
  },
  dependencies = { { "nvim-lua/plenary.nvim" }, "nvim-neorg/neorg-telescope" },
}
