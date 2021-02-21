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

   if e.health then

     love.graphics.setColor(1, 0, 0)
     love.graphics.rectangle("fill", x-5, y+25, 5,  -e.health)

     love.graphics.setColor(0, 0, 1)
     love.graphics.rectangle("line", x-5, y,5,25)

   end
love.graphics.setColor(1, 1, 1, 1)
end
