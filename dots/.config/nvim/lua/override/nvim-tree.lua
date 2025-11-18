require("nvim-tree").setup {
  view = {
    side = "right",
    width = 50,
  },
  renderer = {
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
    decorators = { "Open", "Hidden", "Modified", "Bookmark", "Diagnostics", "Copied", "Cut" }, --Removed git for clean
    group_empty = true,
    root_folder_label = false, -- Disable showing root folder at the top
  },
}
