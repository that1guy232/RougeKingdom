gameTiles = {
  {
    name   = "grass",
    id     = 1,
    graphic = love.graphics.newImage("gfx/grs1.png"),
    Xoff   = 0,
    Yoff   = 0
  },
  {
    name   = "wall",
    id     = 2,
    graphic = love.graphics.newImage("gfx/wall.png"),
    Xoff   = 0,
    Yoff   = 0
  },
  {
    name   = "floor",
    id     = 3,
    graphic = love.graphics.newImage("gfx/floor.png"),
    Xoff   = 0,
    Yoff   = 0
  },
  {
    name   = "road",
    id     = 4,
    graphic = love.graphics.newImage("gfx/road.png"),
    Xoff   = 0,
    Yoff   = 0
  },
  {
    name   = "water",
    id     = 5,
    graphic = love.graphics.newImage("gfx/water.png"),
    Xoff   = 0,
    Yoff   = 0
  },
  {
    name   = "tree",
    id     = 6,
    graphic = love.graphics.newImage("gfx/tree.png"),
    Xoff   = 0,
    Yoff   = -25
  },
  {
    name   = "rock",
    id     = 7,
    graphic = love.graphics.newImage("gfx/rock.png"),
    Xoff   = 0,
    Yoff   = 0
  },
  {
    name   = "sign",
    id     = 8,
    graphic = love.graphics.newImage("gfx/sign.png"),
    Xoff   = 0,
    Yoff   = 0
  },
  {
    name = "player",
    id = 99,
    graphic = love.graphics.newImage("gfx/player.png"),
    Xoff   = 0,
    Yoff   = 0
  },
  {
    name = "goblin",
    id = 9,
    graphic = love.graphics.newImage("gfx/goblin.png"),
    Xoff = 0,
    Yoff = -8
  },
  {
    name = "peasant",
    id = 10,
    graphic = love.graphics.newImage("gfx/peasant.png"),
    Xoff = 0,
    Yoff = -8
  }
}


function  getTileNameById(id)
  for i = 1, table.maxn(gameTiles) do
    if gameTiles[i].id == id then
      return gameTiles[i].name
    end
  end
end


function  getTileByName(name)
  for i = 1, table.maxn(gameTiles) do
    if gameTiles[i].name == name then
      return gameTiles[i]
    end
  end
end
