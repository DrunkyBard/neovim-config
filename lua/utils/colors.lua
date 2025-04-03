-- https://github.com/goolord/alpha-nvim/discussions/16#discussioncomment-10127079

local m = {}

local function get_len(str, start_pos)
  local byte = string.byte(str, start_pos)
  if not byte then
    return nil
  end

  return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

m.darken = function(col, value)
  local new_color = tonumber(string.sub(col, 2), 16) - 21 * value
  new_color = math.max(new_color, 0)

  return '#' .. string.format('%x', new_color)
end

m.build_header_from_color_map = function(colorMap)
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

m.colorize = function(header, header_color_map, colors)
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
      pos = pos + get_len(header[i], start + 1)

      local color_name = colors[line:sub(j, j)]
      if color_name then
        table.insert(colorized_line, { color_name, start, pos })
      end
    end

    table.insert(colorized, colorized_line)
  end

  return colorized
end

return m
