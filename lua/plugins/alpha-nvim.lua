-- https://github.com/goolord/alpha-nvim/discussions/16#discussioncomment-10127079

local function darken(col, value)
  local new_color = tonumber(string.sub(col, 2), 16) - 21 * value
  new_color = math.max(new_color, 0)

  return '#' .. string.format('%x', new_color)
end

local function getNyanCatImage()
  local mocha = require("catppuccin.palettes").get_palette("mocha")
  local nyanCatImage = {
    colors = {
      ["W"] = { fg = vim.api.nvim_get_hl_by_name("Normal", true).background },
      ["C"] = { fg = mocha.text },
      ["B"] = { fg = mocha.crust },
      ["R"] = { fg = mocha.red },
      ["O"] = { fg = mocha.peach },
      ["Y"] = { fg = mocha.yellow },
      ["G"] = { fg = mocha.green },
      ["U"] = { fg = mocha.blue },
      ["P"] = { fg = mocha.yellow },
      ["H"] = { fg = mocha.pink },
      ["F"] = { fg = mocha.red },
      ["M"] = { fg = mocha.overlay0 },
      ["V"] = { fg = mocha.lavender },
    },
    map = {
      [[                                                       BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB               ]],
      [[ RRRR                RRRRRRRRRRRRRRRR                BBPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPBB             ]],
      [[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPPPHHHHHHHHHHHHHHHHHHHHHHHHHHPPPPPPBB           ]],
      [[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPHHHHHHHHHHHHFFHHHHFFHHHHHHHHHHPPPPBB           ]],
      [[ OOOORRRRRRRRRRRRRRRROOOOOOOOOOOOOOOORRRRRRRRRRRRRRBBPPHHHHFFHHHHHHHHHHHHHHHHHHHHHHHHHHHHPPBB           ]],
      [[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHHHBBBBHHHHFFHHHHPPBB  BBBB     ]],
      [[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMBBHHHHHHHHPPBBBBMMMMBB   ]],
      [[ YYYYOOOOOOOOOOOOOOOOYYYYYYYYYYYYYYYYOOBBBBBBBBOOOOBBPPHHHHHHHHHHHHFFHHHHBBMMMMMMBBHHHHHHPPBBMMMMMMBB   ]],
      [[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBMMMMBBBBOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMMMMMBBBBBBBBMMMMMMMMBB   ]],
      [[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBBBMMMMBBBBBBPPHHHHHHFFHHHHHHHHHHBBMMMMMMMMMMMMMMMMMMMMMMMMBB   ]],
      [[ GGGGYYYYYYYYYYYYYYYYGGGGGGGGGGGGGGGGYYYYBBBBMMMMBBBBPPHHHHHHHHHHHHHHFFBBMMMMMMMMMMMMMMMMMMMMMMMMMMMMBB ]],
      [[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBMMMMBBPPHHFFHHHHHHHHHHHHBBMMMMMMCCBBMMMMMMMMMMCCBBMMMMBB ]],
      [[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBBBBBPPHHHHHHHHHHHHHHHHBBMMMMMMBBBBMMMMMMBBMMBBBBMMMMBB ]],
      [[ UUUUGGGGGGGGGGGGGGGGUUUUUUUUUUUUUUUUGGGGGGGGGGGGBBBBPPHHHHHHHHHHFFHHHHBBMMRRRRMMMMMMMMMMMMMMMMMMRRRRBB ]],
      [[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPHHFFHHHHHHHHHHBBMMRRRRMMBBMMMMBBMMMMBBMMRRRRBB ]],
      [[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPPPHHHHHHHHHHHHHHBBMMMMMMBBBBBBBBBBBBBBMMMMBB   ]],
      [[ VVVVUUUUUUUUUUUUUUUUVVVVVVVVVVVVVVVVUUUUUUUUUUUUBBBBBBPPPPPPPPPPPPPPPPPPPPBBMMMMMMMMMMMMMMMMMMMMBB     ]],
      [[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMMMBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB       ]],
      [[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMBBBB  BBMMMMBB          BBMMMMBB  BBMMMMBB         ]],
      [[     VVVVVVVVVVVVVVVV                VVVVVVVVVVBBBBBBBB    BBBBBB              BBBBBB    BBBB           ]],
    }
  }

  return nyanCatImage
end

local function getBeeImage()
  local mocha = require("catppuccin.palettes").get_palette("mocha")
  local color_map = {
    [[      AAAA]],
    [[AAAAAA  AAAA]],
    [[AA    AAAA  AAAA        KKHHKKHHHH]],
    [[AAAA    AAAA  AA    HHBBKKKKKKKKKKKKKK]],
    [[  AAAAAA      AAKKBBHHKKBBYYBBKKKKHHKKKKKK]],
    [[      AAAA  BBAAKKHHBBBBKKKKBBYYBBHHHHKKKKKK]],
    [[        BBAABBKKYYYYHHKKYYYYKKKKBBBBBBZZZZZZ]],
    [[    YYBBYYBBKKYYYYYYYYYYKKKKBBKKAAAAZZOOZZZZ]],
    [[    XXXXYYYYBBYYYYYYYYBBBBBBKKKKBBBBAAAAZZZZ]],
    [[    XXXXUUUUYYYYBBYYYYYYBBKKBBZZOOAAZZOOAAAAAA]],
    [[  ZZZZZZXXUUXXXXYYYYYYYYBBAAAAZZOOOOAAOOZZZZAAAA]],
    [[  ZZUUZZXXUUUUXXXXUUXXFFFFFFFFAAAAOOZZAAZZZZ  AA]],
    [[    RRRRUUUUZZZZZZZZXXOOFFFFOOZZOOAAAAAAZZZZAA]],
    [[    CCSSUUUUZZXXXXZZXXOOFFFFOOZZOOOOZZOOAAAA]],
    [[    CCCCUUUUUUUUUURRRROOFFFFOOZZOOOOZZOOZZZZ]],
    [[    CCCCUUUUUUUUSSCCCCEEQQQQOOZZOOOOZZOOZZZZ]],
    [[    CCCCUUGGUUUUCCCCCCEEQQQQOOZZOOOOZZEEZZ]],
    [[    RRRRGGGGUUGGCCCCCCOOOOOOOOZZOOEEZZII]],
    [[      IIRRGGGGGGCCCCCCOOOOOOOOZZEEII]],
    [[            GGRRCCCCCCOOOOEEEEII  II]],
    [[                RRRRRREEEE  IIII]],
    [[                      II]],
    [[]],
  }


  local yellow = "#FAC87C"
  local orange = "#BF854E"
  local maroon = "#502E2B"
  local brown = "#38291B"
  local colors = {
    ["A"] = { fg = mocha.rosewater },
    ["Y"] = { fg = yellow },
    ["B"] = { fg = darken(yellow, 5) },
    ["X"] = { fg = darken(yellow, 20) },
    ["U"] = { fg = darken(yellow, 25) },
    ["F"] = { fg = darken(yellow, 35) },
    ["O"] = { fg = darken(yellow, 45) },
    ["K"] = { fg = maroon },
    ["H"] = { fg = darken(maroon, 10) },
    ["Z"] = { fg = mocha.crust },
    ["G"] = { fg = darken(yellow, 25) },
    ["R"] = { fg = orange },
    ["Q"] = { fg = darken(orange, 20) },
    ["E"] = { fg = darken(orange, 35) },
    ["I"] = { fg = brown },
    ["C"] = { fg = mocha.mantle },
    ["S"] = { fg = mocha.subtext1 },
  }

  return {
    colors = colors,
    map = color_map
  }
end

local function getLen(str, start_pos)
  local byte = string.byte(str, start_pos)
  if not byte then
    return nil
  end

  return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

local function buildHeaderFromColorMap(colorMap)
  local header = {}
  for _, line in ipairs(colorMap) do
    local header_line = [[]]
    for i = 1, #line do
      if line:sub(i, i) ~= " " then
        header_line = header_line .. "█"
      else
        header_line = header_line .. " "
      end
    end
    table.insert(header, header_line)
  end

  return header
end

local function colorize(header, header_color_map, colors)
  for letter, color in pairs(colors) do
    local color_name = "AlphaThemeLetterColor" .. letter
    vim.api.nvim_set_hl(0, color_name, color)
    colors[letter] = color_name
  end

  local colorized = {}

  for i, line in ipairs(header_color_map) do
    local colorized_line = {}
    local pos = 0

    for j = 1, #line do
      local start = pos
      pos = pos + getLen(header[i], start + 1)

      local color_name = colors[line:sub(j, j)]
      if color_name then
        table.insert(colorized_line, { color_name, start, pos })
      end
    end

    table.insert(colorized, colorized_line)
  end

  return colorized
end

local alpha_c = function(color_map, colors)
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  local header = buildHeaderFromColorMap(color_map)

  -----
  -- header = {}
  -----

  dashboard.section.header.val = header
  dashboard.section.header.opts = {
    hl = colorize(header, color_map, colors),
    position = "center",
  }

  dashboard.section.buttons.val = {
    dashboard.button("SPC e e", "  New file", "<Cmd>ene <CR>"),
    dashboard.button("SPC f f", "  Find file"),
    dashboard.button("SPC S l", "  Load session"),
    dashboard.button("SPC q q", "  Quit", "<Cmd>qa<CR>"),
  }
  for _, a in ipairs(dashboard.section.buttons.val) do
    a.opts.width = 49
    a.opts.cursor = -2
  end

  alpha.setup(dashboard.config)
end

return {
  'goolord/alpha-nvim',
  dependencies = {
    "catppuccin/nvim"
  },
  config = function()
    local dashboard = require('alpha.themes.dashboard')

    dashboard.section.header.opts.position = "left"
    dashboard.section.header.val = require('alpha-themes/adventure_01').header

    require('alpha').setup(dashboard.config)

    -- local image = getNyanCatImage()
    local image = getBeeImage()
    alpha_c(image.map, image.colors)
  end
}
