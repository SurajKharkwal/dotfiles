---@type Base46Table
local M = {}
-- UI

M.base_30 = {
  white = "{{colors.onSurface.hex}}",

  black = "{{colors.surface.hex}}",
  darker_black = "{{colors.surfaceDim.hex}}",
  black2 = "{{colors.surfaceBright.hex}}",

  one_bg = "{{colors.surfaceContainerLowest.hex}}",
  one_bg2 = "{{colors.surfaceContainerLow.hex}}",
  one_bg3 = "{{colors.surfaceContainer.hex}}",

  grey = "{{colors.surfaceVariant.hex}}",
  grey_fg = "{{colors.onSurfaceVariant.hex}}",
  grey_fg2 = "{{colors.outlineVariant.hex}}",
  light_grey = "{{colors.outline.hex}}",

  red = "{{colors.error.hex}}",
  baby_pink = "{{colors.errorContainer.hex}}",
  pink = "{{colors.onErrorContainer.hex}}",

  line = "{{colors.surfaceContainerHighest.hex}}",

  green = "{{colors.tertiary.hex}}",
  vibrant_green = "{{colors.tertiaryContainer.hex}}",

  nord_blue = "{{colors.secondary.hex}}",
  blue = "{{colors.secondaryContainer.hex}}",
  seablue = "{{colors.onSecondaryContainer.hex}}",

  yellow = "{{colors.primaryContainer.hex}}",
  sun = "{{colors.onPrimaryContainer.hex}}",

  purple = "{{colors.primary.hex}}",
  dark_purple = "{{colors.primaryFixedDim.hex}}",

  teal = "{{colors.tertiaryFixed.hex}}",
  orange = "{{colors.secondaryFixed.hex}}",
  cyan = "{{colors.primaryFixed.hex}}",

  statusline_bg = "{{colors.surfaceContainerLow.hex}}",
  lightbg = "{{colors.surfaceContainerHigh.hex}}",
  pmenu_bg = "{{colors.surfaceContainerHighest.hex}}",
  folder_bg = "{{colors.primary.hex}}"
}


M.base_16 = {
  base00 = "{{colors.background.hex}}",
  base01 = "{{colors.surfaceContainerLowest.hex}}",
  base02 = "{{colors.surfaceContainerLow.hex}}",
  base03 = "{{colors.outline.hex}}",
  base04 = "{{colors.onSurfaceVariant.hex}}",
  base05 = "{{colors.onSurface.hex}}",
  base06 = "{{colors.inverseOnSurface.hex}}",
  base07 = "{{colors.surfaceBright.hex}}",
  base08 = "{{colors.error.hex}}",
  base09 = "{{colors.tertiary.hex}}",
  base0A = "{{colors.secondary.hex}}",
  base0B = "{{colors.primary.hex}}",
  base0C = "{{colors.tertiaryContainer.hex}}",
  base0D = "{{colors.primaryContainer.hex}}",
  base0E = "{{colors.secondaryContainer.hex}}",
  base0F = "{{colors.errorContainer.hex}}",
}


M.type = "dark"

M = require("base46").override_theme(M, "abc")

return M
