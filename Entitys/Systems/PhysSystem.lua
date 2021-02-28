PhysSystem = tiny.processingSystem()
PhysSystem.filter =  tiny.requireAll("hitbox","pos")


local function collides(e1, e2)
    return
        e1.pos.x + e1.hitbox.w >= e2.pos.x and
        e1.pos.y + e1.hitbox.h >= e2.pos.y and
        e2.pos.x + e2.hitbox.w >= e1.pos.x and
        e2.pos.y + e2.hitbox.h >= e1.pos.y
end

function PhysSystem:process(e,dt)
  e.vel.x = 100
  e.vel.y = 100
  e.collieded = false
  local es = self.entities
  for i, e2 in ipairs(es) do
    if e ~= e2 then
      if collides(e,e2) then
        if e.onCollision then
          e.collieded = true
          e.vel.x = 0
          e.vel.y = 0
          e:onCollision(e2)
        end
      end
    end
  end
end