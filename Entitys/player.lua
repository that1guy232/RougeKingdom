playerEnt = {
  name = "player",
  pos = {x = 10, y = 10},
  vel = {x = 100,y = 100},
  hitbox = {w = 25, h = 25},
  graphic = 99,
  damage = 5,
  collieded = false,
  controlled = true,
  inventory = {

  }
}

function playerEnt:onCollision(e)
  if e.type == "resource" then
    print("player collieded with resource: " .. e.name)
    e.health = e.health - self.damage
    if e.health <= 0 then
      e:die(self)


      print(json.encode(self:export()))
    end
  end
end


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


      createPopUp(x,y)




    end
  end
end

function playerEnt:export()

  return { _type = "playerEnt", pos = self.pos, controlled = self.controlled, inventory = self.inventory }
end
