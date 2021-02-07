popups = {}


function drawPopup()
  for popID = 1, table.maxn(popups) do
  love.graphics.draw(getTileByName("speechBubbleL").graphic,  popups[popID].x * world.width + 8, popups[popID].y )

    for graphicsID = 1, table.maxn(popups[popID].graphics) do


      love.graphics.draw(getItemByID(popups[popID].graphics[graphicsID]).graphic,  popups[popID].x * world.width + 25 + (graphicsID * 20), popups[popID].y ,0.75,0.75)



    end
  end
end
function updatePopup()
end
