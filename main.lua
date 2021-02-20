
json        = require "libs/json"
tiny        = require "libs/tiny"
gamestate  = require "libs/gamestate"


playingStateLib = require "gameStates/playingState"
SystemsLib = require "Entitys/Systems/Systems"
world = tiny.world()

DEBUG = true
playerEnt = {

  pos = {x = 10, y = 10},
  hitbox = {w = 25, h = 25},
  graphic = 99,
  controlled = true
}


tmpTreeEnt = {
  pos = {x = 50, y = 50},
  hitbox = {w = 25, h = 25},
  graphic = 6
}

function love.load()


  tiny.addSystem(world,drawingSystem)
  tiny.addSystem(world,playerControlSystem)




  tiny.addEntity(world,playerEnt)
  tiny.addEntity(world,tmpTreeEnt)



  gamestate.registerEvents()
  gamestate.switch(playingState)

end

function love.draw()
  world:update(love.timer.getDelta())
  print(tiny.getSystemCount(world))
end


function love.mousepressed(x, y, button)

end

function love.keypressed(key, scancode, isrepeat)

end


function love.update(dt)


end
