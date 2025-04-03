local m = {}

m.get_image = function()
  local mocha = require("catppuccin.palettes").get_palette("mocha")
  local map = {
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

  local c = require('utils/colors')

  local yellow = "#FAC87C"
  local orange = "#BF854E"
  local maroon = "#502E2B"
  local brown = "#38291B"
  local colors = {
    ["A"] = { fg = mocha.rosewater },
    ["Y"] = { fg = yellow },
    ["B"] = { fg = c.darken(yellow, 5) },
    ["X"] = { fg = c.darken(yellow, 20) },
    ["U"] = { fg = c.darken(yellow, 25) },
    ["F"] = { fg = c.darken(yellow, 35) },
    ["O"] = { fg = c.darken(yellow, 45) },
    ["K"] = { fg = maroon },
    ["H"] = { fg = c.darken(maroon, 10) },
    ["Z"] = { fg = mocha.crust },
    ["G"] = { fg = c.darken(yellow, 25) },
    ["R"] = { fg = orange },
    ["Q"] = { fg = c.darken(orange, 20) },
    ["E"] = { fg = c.darken(orange, 35) },
    ["I"] = { fg = brown },
    ["C"] = { fg = mocha.mantle },
    ["S"] = { fg = mocha.subtext1 },
  }

  local header = c.build_header_from_color_map(map)

  return {
    header = header,
    hl = c.colorize(header, map, colors)
  }
end

return m
