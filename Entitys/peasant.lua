function updatePeasant(peasant)
  for i = 1, table.maxn(peasant.wants) do

    itemName = peasant.wants[i].itemName
    item = getItemByName(itemName)
    if item.ingredients ~= nil then
      print("has stuff")

      if canCraft(peasant.inventory, item.ingredients,true) then
        print("can craft")
      end
    end
  end

end
