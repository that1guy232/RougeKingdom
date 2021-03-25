BumpPhysicsSystem = tiny.processingSystem()
BumpPhysicsSystem.filter = tiny.requireAll("pos", "vel","hitbox")



function BumpPhysicsSystem:process(e,dt)
  local entx
  local enty
  local cols
  local len

  if e.vel.x ~= 0 or  e.vel.y ~= 0 then

    entx, enty, cols, len = self.bumpWorld:move(e, e.pos.x + e.vel.x * dt  ,e.pos.y + e.vel.y * dt)

    e.pos.x = entx
    e.pos.y = enty


    if cols then
      for i=1,#cols do
        cols[i].item:onCollision(cols[i].other,dt)
        if cols[i].other.markdead then
          self.bumpWorld:remove(cols[i].other)
        end
        --print(cols[i].item.name .. "  collieded with " .. cols[i].other.name)
      end
    end
  end


end
