---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everblush",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  override = {
    ["nvim-tree"] = {
      require("nvim-tree").setup {
        view = {
          side = "right",
          width = 40,
        },
        renderer = {
          special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
          symlink_destination = true,
          decorators = { "Open", "Hidden", "Modified", "Bookmark", "Diagnostics", "Copied", "Cut", }, --Removed git for clean
          group_empty = true,
          root_folder_label = false,                                                                  -- Disable showing root folder at the top
        },
      },
    },
  },
}


M.nvdash = {
  header = function()
    return {
      "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWMMMMMMMMMMMMMMMMMMM",
      "MMMMMMMMMMMMMMMMMMMMNNMMMMMW0dooxXWMMMMMMMMMMMMMMM",
      "MMMMMMMMMMMMMMMMMMMWdoNMMMMO;....cKMMMMMMMMMMMMMMM",
      "MMMMMMMMMMMMMMMMMMMWo'lKWWM0:'..'oXMWNNNMMMMMMMMMM",
      "MMMMMMMMMMMMMMMMMMMMKc.,lox00kxkOXKkl:;:kNMMMMMMMM",
      "MMMMMMMMMWMMMMMWWWWMMXd;...';cllc:,.....oNMMMMMMMM",
      "MMMMMMMMMWN0xolcc:cldOXXOxoc;,''.''',:lkNMMMMMMMMM",
      "MMMMMMMW0o;'..........:kWMMWXK000O0KXNWMMMMMMMMMMM",
      "MMMMMMWk,...':oxOOxo;..,kWWMMMMMMWX0kxxxkKWMMMMMMM",
      "MMMMMMNd'';o0NMMMMMWO,..xWWMMMMXkl;'',;,',cxXMMMMM",
      "MMMMMMMN00XWMMMMMMWXd'.:0MMMWNk:..,lOXNXOl'.:0WMMM",
      "MMMMMMMMMMMMMMWKkdl,.'l0WWMW0c'..cOWMMMMMNo..:0MMM",
      "MMMWWMMMMMMMMXo'..':d0WMMWXd,..,dXMMMMMMMM0;..oNMM",
      "MMNOKMMMMMMMMW0dc,';lx0Odl:..'l0WMMMMMMMMMK:..cKMM",
      "MMKldWMMMMMMMMMWNKkc'.''.',:d0NWMMMMMMMMMMK:..:KMM",
      "MMXc,kWMMMMMMMMMMMMNO:..',oNMM0ONMMMMMMMMWk,..lNMM",
      "MMWd.,kNMMMMMMMMMMMMMO,...,OMWd,dNMMMMMMWO:..,kWMM",
      "MMMK:.'l0NMMMMMWMMMMM0;....dWWx''cx0KXKOo,..,dNMMM",
      "MMMWO;..,cx0NWWMMMWNOc.....dWMXo'..',;,...'cOWMMMM",
      "MMMMWKl'...';cloool:'.....:0MMMNOl:,'',;cdONMMMMMM",
      "MMMMMMNkc,.............'lx0WMMMMMWNXK0KXWMMMMMMMMM",
      "MMMMMMMMWKkoc;,'''',;cd0NMMMMMMMMMMMMMMMMMMMMMMMMM",
      "MMMMMMMMMMMWNXK0000KXWMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
      "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
      "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
    }
  end,
  buttons = {},
  load_on_startup = true,
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

return M
