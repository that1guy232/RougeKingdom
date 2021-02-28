inventorySystem = tiny.system()
inventorySystem.filter = tiny.requireAll("inventory")




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



function inventorySystem:createInventory(size,contents)

  tmpInv = deepcopy(protoInventory)
  if not contents then
    tmpInv.contents = {}
  elseif contents then
    tmpInv.contents = contents
  end

  tmpInv.size = size
  return tmpInv
end

protoInventory = {
  size = 0,
  contents = {

  }

}
