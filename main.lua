
json        = require "libs/json"
tiny        = require "libs/tiny"
gamestate  = require "libs/gamestate"


playingStateLib = require "gameStates/playingState"
SystemsLib = require "Entitys/Systems/Systems"

worldGen = require "worldGen2"

playerLib = require "Entitys/player"
treeLib = require "Entitys/tree"
world = tiny.world()

--oldcode libs rework
itemLib = require "items"



DEBUG = true

--tmp height map
local map



function love.load()
  w = 1000
  h = 1000
  --tmp height map
  map = worldInit(w,h)

--  tiny.addSystem(world,drawingSystem)
--  tiny.addSystem(world,playerControlSystem)
--  tiny.addSystem(world,PhysSystem)
--  tiny.addSystem(world,savingSystem)


--  tree1 = deepcopy(Tree)
--  tree2 = deepcopy(Tree)
--  tree2.pos.y = 90
--  tiny.addEntity(world,tree2)
--  tiny.addEntity(world,tree1)
--  playerEnt.inventory = inventorySystem:createInventory(7*9,{})
--  tiny.addEntity(world,playerEnt)

--  print("Player: " ..json.encode(playerEnt:export()))
--  print("tree1: " ..json.encode(tree1:export()))

--  gamestate.registerEvents()
--  gamestate.switch(playingState)

end
tileSize = 1


function love.draw()
--tmp height map drawing

  for testS = 1, #map do
    col = map[testS].col
    x = map[testS].x
    y = map[testS].y
    if col < 40 then
      love.graphics.setColor(0, 0, 1, 1)
    else
      love.graphics.setColor(col/100, col/100, col/100, 1)
    end

    love.graphics.rectangle("fill", x*tileSize, y*tileSize, tileSize, tileSize)
  end



  world:update(love.timer.getDelta())
end


function love.mousepressed(x, y, button)

end

function love.keypressed(key, scancode, isrepeat)
  if key == "c" then
      print(json.encode(map))

  end



  if key == "tab" then
    file = io.open ("test.lua", "w")
    io.output(file)
    jsonworld = json.encode(map)
    print(jsonworld)

    io.write(jsonworld)
    io.close(file)
  end

end


function love.update(dt)


end






--Util function to copy a table. Move to Utils?
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
