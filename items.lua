items = {
  {
    maxstack = 20,
    name = "tree",
    graphic = love.graphics.newImage("gfx/logs.png"),
    id = 1
  },
  {
    maxstack = 20,
    name = "rock",
    graphic = love.graphics.newImage("gfx/rock.png"),
    id = 2
  },
  {
    maxstack = 1,
    name = "pickaxe",
    graphic = love.graphics.newImage("gfx/pickaxe.png"),
    id = 3,
    amountMade = 1,
    ingredients = {
        {name = "tree" , amount = 2},
        {name = "rock" , amount = 1}

    }
  },
  {
    maxstack = 1,
    name = "axe",
    graphic = love.graphics.newImage("gfx/axe.png"),
    id = 4,
    amountMade = 1,
    ingredients = {
        {name = "tree" , amount = 2},
        {name = "rock" , amount = 1}

    }
  }
}



function getItemByName(itemName)

  for i=1,table.maxn(items) do
    if items[i].name == itemName then
      return  items[i]
    end
  end
end

function getItemByID(itemID)

  for i=1,table.maxn(items) do
    if items[i].id == itemID then
      return  items[i]
    end
  end
end

function canCraft(inventory,ingredients)

  amountOfMatches = 0
  for ingredientIndex=1,table.maxn(ingredients) do



    for inventoryIndex=1,table.maxn(inventory) do

        if inventory[inventoryIndex] ~= 0 then
          if ingredients[ingredientIndex].name == inventory[inventoryIndex].itemName then


            if inventory[inventoryIndex].amount >= ingredients[ingredientIndex].amount then
              amountOfMatches = amountOfMatches + 1

              if amountOfMatches == table.maxn(ingredients) then
                return  true

              end

            end
          end
        end
    end
  end

end
