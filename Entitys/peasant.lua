function updatePeasant(peasant)

  for i = 1, table.maxn(peasant.wants) do

    if peasant.wants[i] ~= nil and table.maxn(peasant.wants) > 0 then
      itemName = peasant.wants[i].itemName
      item = getItemByName(itemName)

      if hasItem(peasant.inventory,peasant.wants[i].itemName) then
        peasant.wants[i] = nil
      else

        if item.ingredients ~= nil then
          if canCraft(peasant.inventory, item.ingredients,true) then
            print("can craft")
            table.remove(peasant.wants,i)
          end
        end

      end




    end
  end

end
