inventory = {
  inventorySize = 7*9,
  inventoryID = 0,
  contents = {

  }
}

function removeFromInventory(inventory, items)
  print(json.encode(inventory))
  amountOfMatches = 0
  tmpinv = inventory

  for itemsIndex=1,table.maxn(items) do



    for inventoryIndex=1,table.maxn(inventory) do

        if items[itemsIndex].name == tmpinv[inventoryIndex].itemName then


          if tmpinv[inventoryIndex].amount >= items[itemsIndex].amount then
            amountOfMatches = amountOfMatches + 1
            tmpinv[inventoryIndex].amount = tmpinv[inventoryIndex].amount - items[itemsIndex].amount
            if amountOfMatches == table.maxn(items) then
              x = 0
              for i = 1, table.maxn(tmpinv) do
                  print(json.encode(inventory))
                  print(i - x)
                  if tmpinv[i - x].amount == 0 then

                    table.remove(tmpinv, i - x)
                    x = x + 1


                end
              end
              inventory = tmpinv
              print(json.encode(inventory))
              return  true

            end

          end
        end

    end
  end

end
function addToInventory(inventory, itemName, amount)
  remainder = 0
  print(json.encode(inventory))
  for i=1,inventory.inventorySize do

    itemInSlot = inventory.contents[i]
    itemMaxStack = getItemByName(itemName).maxstack

    if itemInSlot ~= nil then

      if itemInSlot.itemName == itemName then

        if itemInSlot.amount <  itemMaxStack then

          totalAmount = itemInSlot.amount + amount
          if totalAmount <= itemMaxStack then


            itemInSlot.amount = totalAmount
            print("added "..itemName.." to inventory X: " .. amount .. " for a total of: " .. totalAmount .. "  in slot: " .. i)
            break

          else

              remainder = totalAmount - itemMaxStack

              if remainder > 0 then
                  itemInSlot.amount = itemMaxStack
                  print("added "..itemName.." to inventory X: " .. remainder .. " for a total of: " .. itemMaxStack .. "  in slot: " .. i)
                addToInventory(inventory,itemName,remainder)
              end
              break
          end



        end
      end

    else

      itemInSlot = {
        amount = 0,
        itemName = ""
      }


      if amount > itemMaxStack then
        remainder = amount - itemMaxStack

        itemInSlot.amount = itemMaxStack
      else
        itemInSlot.amount = amount
      end


      itemInSlot.itemName = itemName

      inventory.contents[i] = itemInSlot
      print(" A added "..itemName.." to inventory X: " .. itemInSlot.amount .. " for a total of: " .. itemInSlot.amount .. "  in slot: " .. i)
      if remainder > 0 then
        addToInventory(inventory,itemName,remainder)
      end


      break
    end
  end
end


function drawInventory()

  love.graphics.setColor(0.65, 0.65, 0.65,1)
  love.graphics.rectangle("fill", 25, 25, love.graphics.getWidth()-50, love.graphics.getHeight()-50)
  --left side "inventory slots"
  love.graphics.setColor(0.55, 0.55, 0.55, 1)
  love.graphics.rectangle("fill", 50, 50, love.graphics.getWidth()-400, love.graphics.getHeight()-100)
  x = 60
  y = 55
  inventoryIndex = 1




  for i=1,playerInventoryHeight do
    for ii = 1, playerInventoryWidth do




      love.graphics.setColor(0.40, 0.40, 0.40, 1)
      love.graphics.rectangle("fill", x, y, 50, 50)

      playerinv = world.chunks[world.viewedChunk].entitys[world.playerTile].inventory
      if playerinv.contents[inventoryIndex] ~= nil then
        if playerinv.contents[inventoryIndex] ~= 0 then

          love.graphics.setColor(1, 1, 1, 1)
          tmpp = world.chunks[world.viewedChunk].entitys[world.playerTile]

          item = getItemByName(tmpp.inventory.contents[inventoryIndex].itemName)

          love.graphics.draw(item.graphic,x + 25/2,y + 25/2)
          love.graphics.print("".. tmpp.inventory.contents[inventoryIndex].amount ,x,y+35)

        end
      end

      inventoryIndex = inventoryIndex + 1

      x = x + 55
    end
    x = 60
    y = y + 55
  end


  --right side

  love.graphics.setColor(0.15, 0.15, 0.15, 1)
  love.graphics.rectangle("fill", 50+410, 50, love.graphics.getWidth()-500, love.graphics.getHeight()-100)
  love.graphics.setColor(1, 1, 1, 1)

   x = 50+410
   y = 50

  for i = 1, table.maxn(craftingButtons) do

    drawCraftingButton(craftingButtons[i])
  end

end


function drawCraftingButton(craftingButton)
  drawButton(craftingButton.button)
  y = craftingButton.button.y
  love.graphics.draw(craftingButton.item.graphic, x+20, y+10)
  love.graphics.print("X"..craftingButton.item.amountMade,x+40,y+10)
  love.graphics.print(craftingButton.item.name,x + 150, y)
  tmpX = x

  for ii = 1, table.maxn(craftingButton.item.ingredients) do

    tmp = getItemByName(craftingButton.item.ingredients[ii].name).graphic
    love.graphics.draw(tmp,tmpX+60,y + 20)
    love.graphics.print("X"..craftingButton.item.ingredients[ii].amount,tmpX+85,y + 20)


    tmpX = tmpX + ii * 50

  end


end
