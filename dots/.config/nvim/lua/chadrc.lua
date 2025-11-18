---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "aquarium",
  transparency = true,
	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}
M.ui = {
  cmp = {
    icons_left = true,
    format_colors = {
      tailwind = true
    }
  },
  tabufline = {
    enabled = true,
    lazyload = false,
    order = { "buffers", "tabs" },
    modules = nil,
  },

}

M.nvdash = {
  header = function()
    return {" ", " "}
  end,
  load_on_startup = true
}

return M
