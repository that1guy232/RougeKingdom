CameraSystem = tiny.processingSystem()
CameraSystem.filter = tiny.requireAny("camera")



function CameraSystem:process(e,dt)



  local w = e.hitbox.w
  local h = e.hitbox.h
  local widthinTile = e.hitbox.w / 25
  local heightInTiles = e.hitbox.h / 25


  local tx = math.floor(e.pos.x / 25) + 1
  local ty = math.floor(e.pos.y / 25) + 1

  local yy = e.map.data.width * (ty -1)
  local index = yy + tx





  for i = -heightInTiles, heightInTiles do

    local tmpy = i
    for ii = -widthinTile, widthinTile do
      local tmpx = ii
      local newIndex = index + i * e.map.data.width + ii



      if  e.map.heightMap[newIndex] and newIndex > 0 then

        if e.map.heightMap[newIndex].col < 40 then
          love.graphics.draw(water, (tmpx * 25) + w/2, (tmpy * 25) + h/2 )
        else
          love.graphics.draw(grass, (tmpx * 25) + w/2, (tmpy * 25) + h/2)
        end

      end

    end
  end



  if e.drawableSprites  then



    if #e.drawableSprites > 0 then
      for s = 1, #e.drawableSprites do


        local sprite = getTileById(e.drawableSprites[s].graphic)
        local entX = e.drawableSprites[s].pos.x
        local entY = e.drawableSprites[s].pos.y
        love.graphics.draw(sprite.graphic,entX - e.pos.x + w/2,entY - e.pos.y + h/2)




      end
    end
  end




 e.drawableSprites = {}




end
