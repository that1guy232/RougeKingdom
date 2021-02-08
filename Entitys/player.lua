function playerAct(actingOnChunk, actingOnEntity)

  if actingOnChunk == world.viewedChunk then
    print("chunkID: ".. actingOnChunk .. " entityID: ".. actingOnEntity)
    print(json.encode(world.chunks[actingOnChunk].entitys[actingOnEntity]))
    print("Player acting on "..world.chunks[actingOnChunk].entitys[actingOnEntity].name)

    entity = world.chunks[actingOnChunk].entitys[actingOnEntity]

    if entity.name == "rock" or entity.name == "tree" then



      damageEntity(actingOnChunk,actingOnEntity,world.chunks[world.viewedChunk].entitys[world.playerTile])

    elseif entity.name == "peasant" or entity.name == "goblin" then



      x = math.floor(actingOnEntity % world.width )

      y = math.floor(actingOnEntity / world.width)

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

      for i = 1, table.maxn(entity.wants) do
        itemGID = getItemByName(entity.wants[i].itemName).id


        table.insert(popup.graphics, itemGID)

      end

      table.insert(popups, popup)

      table.insert(entity.popupIDs, table.maxn(popups))

    end
  end
end
