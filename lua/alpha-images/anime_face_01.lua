local m = {}

m.get_image = function()
  local header = {
    "⣿⠘⣿⣿⡇⣿⣿⣿⠿⠿⠿⣿⣿⣿⣿⣬⡀⣿⣤⡄⠄⠻⣦⡈⢿⣿⣿⣷⡌⢿",
    "⡟⡇⠻⣿⡇⣿⢉⣥⠄⠄⢀⣀⠙⣟⠻⣿⣿⣿⣿⣿⣷⣤⠍⠓⢄⠛⢻⠿⣷⡈",
    "⠃⡇⢀⢻⡇⢹⣼⡏⠄⠄⠄⠘⢰⣌⣷⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣄⡀⠈⠛⢿",
    "⠄⣿⡜⣧⠙⠘⣿⡇⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠄⠄",
    "⠄⢸⣧⢸⠄⣿⣿⣷⣀⣉⣀⣼⣿⣿⣿⣿⣿⣿⣿⣿⠥⠒⣉⣉⠛⢿⡟⠋⠄⢸",
    "⠄⠘⣿⡏⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾⣿⣿⣷⡾⠃⠄⡄⢠",
    "⠄⠄⣿⣧⠄⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣵⣯⣫⣿⠟⠁⢠⣼⣧⣼",
    "⠄⠄⢻⣿⠄⠄⠉⠛⢿⣿⣿⣯⡻⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⡄⢸⠿⣿⣿",
    "⠄⠄⢸⣿⠄⠄⣤⠄⠄⠉⠛⠻⢿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⢃⠜⠄⣼⣀⣿⣿ ",
  }

  return { header = header }
end

return m
