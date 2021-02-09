popups = {}


function drawPopup()


  for popID = 1, table.maxn(popups) do

    if popups[popID].chunkID == world.viewedChunk then
      x = popups[popID].x * world.width
      y = popups[popID].y  * 20

      fadePercent = popups[popID].fadeTime / popups[popID].fadeStartTime
      love.graphics.setColor(1, 1, 1, fadePercent)

      love.graphics.draw(getTileByName("speechBubbleL").graphic,  x + 8, y )


      for graphicsID = 1, table.maxn(popups[popID].graphics) do
        tmpx = x + 22 + ((graphicsID-1) * 20)

          for i = 1, 20 do

            love.graphics.draw(getTileByName("speechBubbleM").graphic,tmpx, y)
            tmpx = tmpx + 1




        end
        love.graphics.draw(getItemByID(popups[popID].graphics[graphicsID]).graphic,  x + 24 + ((graphicsID-1) * 24), y - 3 ,0.75,0.75)


      end

      love.graphics.draw(getTileByName("speechBubbleR").graphic, tmpx , y)

    end
  end


  love.graphics.setColor(1, 1, 1, 1)
end


function updatePopups()
  for i = 1, table.maxn(popups) do
    if popups[i] ~= nil then
       popups[i].fadeTime =   popups[i].fadeTime - 1
       if popups[i].fadeTime < 0 or popups[i].chunkID ~= world.viewedChunk then
         table.remove(popups,i)
       end
    end
    if table.maxn(popups) >  0 then


    end
  end
end

function createPopUp(x,y)
  if y == 0 then
    y = world.height
  end

  if x == 0 then
    x = world.width
  end


  popup = {
    graphics = {},
    fadeStartTime = 20,
    fadeTime = 20,
    chunkID = world.viewedChunk,
    x = x,
    y = y
  }

  if table.maxn(entity.wants) > 0 then
    for i = 1, table.maxn(entity.wants) do
      itemGID = getItemByName(entity.wants[i].itemName).id


      table.insert(popup.graphics, itemGID)

    end

    table.insert(popups, popup)
  end
end
