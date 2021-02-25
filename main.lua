
json        = require "libs/json"
tiny        = require "libs/tiny"
gamestate  = require "libs/gamestate"


playingStateLib = require "gameStates/playingState"
SystemsLib = require "Entitys/Systems/Systems"

playerLib = require "Entitys/player"
treeLib = require "Entitys/tree"
world = tiny.world()




DEBUG = true



function love.load()


  tiny.addSystem(world,drawingSystem)
  tiny.addSystem(world,playerControlSystem)
  tiny.addSystem(world,PhysSystem)
  tiny.addSystem(world,savingSystem)

  tree1 = deepcopy(Tree)
  tiny.addEntity(world,tree1)
  tiny.addEntity(world,playerEnt)

  print(json.encode(playerEnt:export()))
  print(json.encode(tree1:export()))

  gamestate.registerEvents()
  gamestate.switch(playingState)

end

function love.draw()
  world:update(love.timer.getDelta())

end


function love.mousepressed(x, y, button)

end

function love.keypressed(key, scancode, isrepeat)

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
