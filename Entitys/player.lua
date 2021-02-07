function playerAct(actingOnChunk, actingOnEntity)

  if actingOnChunk == world.viewedChunk then
    print("chunkID: ".. actingOnChunk .. " entityID: ".. actingOnEntity)
    print(json.encode(world.chunks[actingOnChunk].entitys[actingOnEntity]))
    print("Player acting on "..world.chunks[actingOnChunk].entitys[actingOnEntity].name)

    entity = world.chunks[actingOnChunk].entitys[actingOnEntity]

    if entity.name == "rock" or entity.name == "tree" then



      damageEntity(actingOnChunk,actingOnEntity,world.chunks[world.viewedChunk].entitys[world.playerTile])

    elseif entity.name == "peasant" or entity.name == "goblin" then
      popup = {
        graphics = {}
      }
      print("Wants: ".. json.encode( entity.wants))
      for i = 1, table.maxn(entity.wants) do
        json.encode("TTT" .. getItemByName(entity.wants[i].name))
        table.insert(popup.graphics, getItemByName(entity.wants[i].name).graphic)
      end

      table.insert(popups, popup)
      print(json.encode(popups))

    end
  end
end
