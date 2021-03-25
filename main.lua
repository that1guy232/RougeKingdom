
json        = require "libs/json"
tiny        = require "libs/tiny"
gamestate   = require "libs/gamestate"
bump        = require "libs/bump"
bump_debug = require "libs/BumpDebug"

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
local start = love.timer.getTime()



  w = 1000
  h = 1000
  --tmp height map
  --Make the map a Entity
  map = worldInit(w,h,waterdepth)

  tiny.addSystem(world,CameraSystem)





  tiny.addSystem(world,playerControlSystem)
  tiny.addSystem(world,savingSystem)

  bumpSystem = BumpPhysicsSystem
  bumpSystem.bumpWorld = bump.newWorld()
  tiny.addSystem(world,bumpSystem)

  tiny.addSystem(world,inventorySystem)
  camera = deepcopy(cameraEnt)

  camera.map = map
  playerEnt.pos.x = 100
  playerEnt.pos.y = 100
  camera.pos = deepcopy(playerEnt.pos)
  cw, ch = love.graphics.getDimensions(50)
  camera.hitbox = {w = cw, h = ch}


  playerEnt.inventory = inventorySystem:createInventory(5,5,{})
  --tiny.addEntity(world,playerEnt)
  table.insert(map.entites,playerEnt)
  map.player = playerEnt




  print("Map entities: " ..#map.entites)
  for i = 1, #map.entites do

    tiny.addEntity(world,map.entites[i])
    bumpSystem.bumpWorld:add(map.entites[i],map.entites[i].pos.x,map.entites[i].pos.y,25,25)

  end
  print("Done adding map Entites")






  tiny.addEntity(world,camera)

--  print("Player: " ..json.encode(playerEnt:export()))
--  print("tree1: " ..json.encode(tree1:export()))

  gamestate.registerEvents()
  gamestate.switch(playingState)



    local result = love.timer.getTime() - start
    print( string.format( "It took %.3f milliseconds ", result * 1000 ))

end





function love.draw()



--tmp height map drawing


for i = 1, #map.entites do
  if map.entites[i] then
    if map.entites[i].markdead then
      table.remove(map.entites, i)
    end
  end
end


world:update(love.timer.getDelta())

 --bump_debug.draw(bumpSystem.bumpWorld)
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
