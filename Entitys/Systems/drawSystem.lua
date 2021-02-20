local graphic = require "graphics"
drawingSystem = tiny.processingSystem()
drawingSystem.filter = tiny.requireAll("graphic")
function drawingSystem:process(e,dt)

   sprite = getTileById(99)
   x = e.x
   y = e.y

   love.graphics.draw(sprite.graphic,x,y)
end
