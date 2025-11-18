require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules", -- Example: ignore node_modules
      "*.lock",
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
      },
    },
  },
}
