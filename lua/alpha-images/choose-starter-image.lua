local m = {}

m.choose_starter_image = function()
  local images = {
    require('alpha-images/bee'),
    require('alpha-images/nyan-cat'),
    require('alpha-images/anime_face_01'),
    require('alpha-images/at_01'),
    require('alpha-images/at_02'),
    require('alpha-images/at_03'),
    require('alpha-images/neovim-logo'),
    require('alpha-images/waddle'),
  }
  -- local selected_image = math.random(#images)
  local time = vim.fn.localtime()
  local selected_image_idx = time - #images * math.floor(time / #images) + 1

  return images[selected_image_idx].get_image()
end

return m
