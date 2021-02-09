function updatePeasant(peasant)
  for i = 1, table.maxn(peasant.wants) do
    if peasant.wants[i] ~= nil then
      itemName = peasant.wants[i].itemName
      item = getItemByName(itemName)
      for i = 1, table.maxn(peasant) do
      end
      if item.ingredients ~= nil then

        if canCraft(peasant.inventory, item.ingredients,true) then
          print("can craft")
          table.remove(peasant.wants,i)
        end
      end
    end
  end

end
