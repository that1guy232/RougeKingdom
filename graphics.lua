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
  },
  {
    name = "speechBubbleR",
    id = 11,
    graphic = love.graphics.newImage("gfx/speech/speechr.png"),
    Xoff = 0,
    Yoff = 0
  },
  {
      name = "speechBubbleM",
      id = 12,
      graphic = love.graphics.newImage("gfx/speech/speechm.png"),
      Xoff = 0,
      Yoff = 0
    },
    {
        name = "speechBubbleL",
        id = 13,
        graphic = love.graphics.newImage("gfx/speech/speechl.png"),
        Xoff = 0,
        Yoff = 0
    },
    {
      name = "inventoryTop",
      id = 14,
      graphic = love.graphics.newImage("gfx/Inventory/InventoryTopLength.png"),
      Xoff = 0,
      Yoff = 0
    },
    {
        name = "inventoryCorner",
        id = 15,
        graphic = love.graphics.newImage("gfx/Inventory/inventoryCorner.png"),
        Xoff = 0,
        Yoff = 0
      },
      {
          name = "inventoryTile",
          id = 16,
          graphic = love.graphics.newImage("gfx/Inventory/inventoryTile.png"),
          Xoff = 0,
          Yoff = 0
      },
      {
          name = "closeButton",
          id = 17,
          graphic = love.graphics.newImage("gfx/UI/exit.png"),
          Xoff = 0,
          Yoff = 0
      },
      {
        name = "woodCuttersHut",
        id = 18,
        graphic = love.graphics.newImage("gfx/Buildings/woodCuttersHut.png"),
        Xoff = 0,
        Yoff = 0
      },
      {
        name = "woodHut",
        id = 19,
        graphic = love.graphics.newImage("gfx/Buildings/woodHut.png"),
        Xoff = 0,
        Yoff = 0
      },
      {
        name = "craftButton",
        id = 20,
        graphic = love.graphics.newImage("gfx/UI/craft.png"),
        Xoff = 0,
        Yoff = 0
      }


}


function  getTileNameById(id)
  for i = 1, table.maxn(gameTiles) do
    if gameTiles[i].id == id then
      return gameTiles[i].name
    end
  end
end

function  getTileById(id)
  for i = 1, table.maxn(gameTiles) do
    if gameTiles[i].id == id then

      return gameTiles[i]
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
