local  graphics  = require "graphics"

CameraSystem = tiny.processingSystem()
CameraSystem.filter = tiny.requireAny("camera")



function CameraSystem:process(e,dt)










  local w = e.hitbox.w
  local h = e.hitbox.h
  local widthinTile = e.hitbox.w / 25
  local heightInTiles = e.hitbox.h / 25

--Could move this to main would make more sense setting the posstion of the camera outside the camera, 
  e.pos.x = e.map.player.pos.x - w/2
  e.pos.y = e.map.player.pos.y - h/2

  local tx = math.floor(e.pos.x / 25) + 1
  local ty = math.floor(e.pos.y / 25) + 1

  local yy = e.map.data.width * (ty -1)
  local index = yy + tx






  for i = -heightInTiles, heightInTiles do

    local tmpy = i
    for ii = -widthinTile, widthinTile do
      local tmpx = ii
      local newIndex = index + i * e.map.data.width + ii



      if  e.map.groundMap[newIndex] and newIndex > 0 then

        if e.map.groundMap[newIndex].col < 40 then

          love.graphics.draw(getTileByName("water").graphic, (e.map.groundMap[newIndex].x * 25) - e.pos.x , (e.map.groundMap[newIndex].y * 25) -e.pos.y )
        else
          love.graphics.draw(getTileByName("grass").graphic,  (e.map.groundMap[newIndex].x * 25) - e.pos.x , (e.map.groundMap[newIndex].y * 25) -e.pos.y )
        end

      end

    end
  end



  for entityIndex = 1, #e.map.entites do
    local entity = e.map.entites[entityIndex]
    if entity.graphic then
      if entity.pos.x > e.pos.x - 50  and  entity.pos.x < e.pos.x + e.hitbox.w + 50
      and entity.pos.y > e.pos.y - 50 and entity.pos.y > e.pos.y - e.hitbox.h  then
        love.graphics.draw(getTileById(entity.graphic).graphic,  entity.pos.x - e.pos.x , entity.pos.y - e.pos.y)

      end
    end
  end




end
