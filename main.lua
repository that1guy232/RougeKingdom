
json        = require "libs/json"
tiny        = require "libs/tiny"
gamestate  = require "libs/gamestate"


playingStateLib = require "gameStates/playingState"
SystemsLib = require "Entitys/Systems/Systems"

worldGen = require "worldGen2"

playerLib = require "Entitys/player"
treeLib = require "Entitys/tree"
rockLib = require "Entitys/rock"
cameraLib =  require "Entitys/camera"
world = tiny.world()

--oldcode libs rework
itemLib = require "items"



DEBUG = true

--tmp height map
local map


local waterdepth = 40
function love.load()




  w = 1000
  h = 1000
  --tmp height map
  --Make the map a Entity
  map = worldInit(w,h,waterdepth)

  tiny.addSystem(world,CameraSystem)
  --tiny.addSystem(world,drawingSystem)
  tiny.addSystem(world,playerControlSystem)
  tiny.addSystem(world,savingSystem)
  tiny.addSystem(world,PhysSystem)
  tiny.addSystem(world,inventorySystem)
  camera = deepcopy(cameraEnt)

  camera.map = map
  playerEnt.pos.x = 100
  playerEnt.pos.y = 100
  camera.pos = deepcopy(playerEnt.pos)
  cw, ch = love.graphics.getDimensions()
  camera.hitbox = {w = cw, h = ch}


  tree1 = deepcopy(Tree)
  tree2 = deepcopy(Tree)
  tree3 = deepcopy(Tree)
  rock1 = deepcopy(Rock)

  rock1.pos.x = 310
  rock1.pos.y = 340
  tree2.pos.y = 90
  tree3.pos = {x = 500, y = 250}
  tiny.addEntity(world,tree3)
  tiny.addEntity(world,tree2)
  tiny.addEntity(world,tree1)
  tiny.addEntity(world,rock1)
  playerEnt.inventory = inventorySystem:createInventory(5,5,{})
  tiny.addEntity(world,playerEnt)
  tiny.addEntity(world,camera)

--  print("Player: " ..json.encode(playerEnt:export()))
--  print("tree1: " ..json.encode(tree1:export()))

  gamestate.registerEvents()
  gamestate.switch(playingState)

end


tileSize = 25
water = love.graphics.newImage("gfx/water.png")
grass = love.graphics.newImage("gfx/grs1.png")
psel = 1


function love.draw()



--tmp height map drawing





world:update(love.timer.getDelta())


love.graphics.print(love.timer.getFPS())
love.graphics.print("PlayerPos: ".. json.encode(playerEnt.pos),0,25)

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
