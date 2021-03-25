playerEnt = {
  name = "player",
  pos = {x = 0, y = 0},
  vel = {x = 0,y = 0},
  hitbox = {w = 25, h = 25},
  graphic = 99,
  damage = 25,
  collieded = false,
  controlled = true,
  inventory = {

  }
}




function playerEnt:onCollision(e,dt)

  if e.type == "resource" then
    print("player collieded with resource: " .. e.name)

    e.health = e.health - self.damage * dt
    if e.health <= 0 then
      e:die(self)


      --print(json.encode(self:export()))
    end
  end
end



function playerEnt:export()

  return { _type = "playerEnt", pos = self.pos, controlled = self.controlled, inventory = self.inventory }
end
