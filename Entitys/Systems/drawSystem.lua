local graphic = require "graphics"
drawingSystem = tiny.processingSystem()
drawingSystem.filter = tiny.requireAll("graphic")
function drawingSystem:process(e,dt)

   sprite = getTileById(99)
   x = e.pos.x
   y = e.pos.y

   love.graphics.draw(sprite.graphic,x,y)
end
