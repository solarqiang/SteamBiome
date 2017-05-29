return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 3,
  height = 3,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "ground",
      firstgid = 1,
      filename = "C:/Users/Lukas/Desktop/tileset/ground.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "C:/Users/Lukas/Desktop/tileset/tiles.png",
      imagewidth = 512,
      imageheight = 128,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "BG_TILES",
      x = 0,
      y = 0,
      width = 3,
      height = 3,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        37, 37, 37,
        37, 37, 37,
        37, 37, 37
      }
    },
    {
      type = "objectgroup",
      name = "FG_OBJECTS",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "orangecrystal",
          shape = "rectangle",
          x = 98,
          y = 92,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
