inventorySystem = tiny.processingSystem()
inventorySystem.filter = tiny.requireAll("inventory")

function inventorySystem:process(e,dt)
  if e.inventory.visable then
    local inventoryCorner = getTileByName("inventoryCorner").graphic
    local inventoryTop = getTileByName("inventoryTop").graphic
    local inventoryTile = getTileByName("inventoryTile").graphic
    local closeButton = getTileByName("closeButton").graphic
    --27 is the size of the inventory tiles I should unhard code this because this is just really poor. 
    love.graphics.draw(inventoryCorner, e.inventory.pos.x+27*2 ,e.inventory.pos.y,0,-1,1)
    love.graphics.draw(inventoryCorner, e.inventory.pos.x + e.inventory.width  * 27,e.inventory.pos.y)
    for x = 2,  e.inventory.width - 1 do
      love.graphics.draw(inventoryTop, e.inventory.pos.x + 27 * x, e.inventory.pos.y)
    end
    local Offset = -12
    for y = 1,  e.inventory.height do
      for x = 1,  e.inventory.width do
        love.graphics.draw(inventoryTile, e.inventory.pos.x + 27 * x, Offset + e.inventory.pos.y + 27 * y, r, sx, sy, ox, oy, kx, ky)
      end
    end

    love.graphics.draw(closeButton,e.inventory.pos.x+15, e.inventory.pos.y - 10)

    love.graphics.print({{120/255, 255/255, 12/255},e.name},e.inventory.pos.x+30,e.inventory.pos.y+2,0,0.8,0.8)


  end
end


function inventorySystem:addItem(e, itemName, amount)
    print(amount)
  for i = 1, e.inventory.size do
    itemInSlot = e.inventory.contents[i]
    itemMaxStack = getItemByName(itemName).maxstack


    if itemInSlot ~= nil then
        if itemInSlot.itemName == itemName then
          if itemInSlot.amount ~= itemMaxStack then

            totalAmount = itemInSlot.amount + amount
            if totalAmount <= itemMaxStack then
              itemInSlot.amount = totalAmount
            elseif totalAmount >= itemMaxStack then
              remainder = totalAmount - itemMaxStack
              itemInSlot.amount = itemMaxStack

              inventorySystem:addItem(e,itemName,remainder)
              break
            end
          end




        end

    else

      itemInSlot = {
        amount = 0,
        itemName = itemName
      }

      e.inventory.contents[i] = itemInSlot
      totalAmount = itemInSlot.amount + amount

      if totalAmount >= itemMaxStack then

        remainder = totalAmount - itemMaxStack
        itemInSlot.amount = itemMaxStack
        inventorySystem:addItem(e,itemName,remainder)
        break

      else
        itemInSlot.amount = totalAmount
        break

      end
    end

  end

end



function inventorySystem:createInventory(width,height,contents)
  if width < 2 then
    width = 2
  end
  if height < 2 then
    height = 2
  end
  local size = width * height
  tmpInv = deepcopy(protoInventory)
  if not contents then
    tmpInv.contents = {}
  elseif contents then
    tmpInv.contents = contents
  end

  tmpInv.width = width
  tmpInv.height = height
  tmpInv.size = size
  return tmpInv
end

protoInventory = {
  size = 0,
  width = 0,
  height = 0,
  visable = false,
  pos = {x = 250, y = 250},
  contents = {

  }

}
