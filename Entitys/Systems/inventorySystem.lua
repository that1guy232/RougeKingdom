inventorySystem = tiny.system()
inventorySystem.filter = tiny.requireAll("inventory")




function inventorySystem:addItem(e, itemName, amount)
  print(e.pos.x)
  local inventory =  e.inventory


  for i = 1, inventory.size do
    itemInSlot = inventory.contents[i]
    print(itemName)
    itemMaxStack = getItemByName(itemName).maxstack


  end


  return true
end

function inventorySystem:export()
  return {_type  = "inventory", size = self.size, contents = self.contents}
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
