
json        = require "libs/json"
tiny        = require "libs/tiny"
gamestate  = require "libs/gamestate"

playingStateLib = require "gameStates/playingState"
SystemsLib = require "Entitys/Systems/Systems"
world = tiny.world()


playerEnt = {
  x = 10,
  y = 10,
  graphic = "99",
  controlled = true
}

function love.load()
  tiny.addSystem(world,drawingSystem)
  tiny.addSystem(world,playerControlSystem)
  tiny.addEntity(world,playerEnt)
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
