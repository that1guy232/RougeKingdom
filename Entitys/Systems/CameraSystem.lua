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



      if  e.map.groundMap[newIndex] and newIndex > 0 then

        if e.map.groundMap[newIndex].col < 40 then
          love.graphics.draw(water, (e.map.groundMap[newIndex].x * 25) - e.pos.x , (e.map.groundMap[newIndex].y * 25) -e.pos.y )
        else
          love.graphics.draw(grass,  (e.map.groundMap[newIndex].x * 25) - e.pos.x , (e.map.groundMap[newIndex].y * 25) -e.pos.y )
        end

      end

    end
  end



  if e.drawableSprites  then



    if #e.drawableSprites > 0 then
      for s = 1, #e.drawableSprites do
        --hacker to keep camera on player
        if e.drawableSprites[s].name == "player" then
          camera.pos.x = e.drawableSprites[s].pos.x
          camera.pos.y = e.drawableSprites[s].pos.y
          camera.pos.x = camera.pos.x - w/2
          camera.pos.y = camera.pos.y - h/2
        end

        local sprite = getTileById(e.drawableSprites[s].graphic)
        local entX = e.drawableSprites[s].pos.x
        local entY = e.drawableSprites[s].pos.y
        love.graphics.draw(sprite.graphic,entX - e.pos.x ,entY - e.pos.y)




      end
    end
  end




 e.drawableSprites = {}




end
