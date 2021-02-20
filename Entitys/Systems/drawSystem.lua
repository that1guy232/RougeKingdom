local graphic = require "graphics"
drawingSystem = tiny.processingSystem()
drawingSystem.filter = tiny.requireAll("graphic")
function drawingSystem:process(e,dt)

   local sprite = getTileById(e.graphic)
   x = e.pos.x
   y = e.pos.y

   if e.hitbox and DEBUG then
     love.graphics.rectangle("line", e.pos.x, e.pos.y, e.hitbox.w, e.hitbox.h)
   end
   love.graphics.draw(sprite.graphic,x+sprite.Xoff,y+sprite.Yoff)
end
