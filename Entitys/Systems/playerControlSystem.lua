playerControlSystem = tiny.processingSystem()
playerControlSystem.filter = tiny.requireAll("controlled")



function playerControlSystem:process(e,dt)




    local l, r, u,d = love.keyboard.isDown('a'), love.keyboard.isDown('d'), love.keyboard.isDown('w'),love.keyboard.isDown('s')

    if e.camera then

      if l and not r then
          e.pos.x = e.pos.x -e.vel.x*dt
      elseif r and not l then
          e.pos.x = e.pos.x + e.vel.x*dt
      end


      if u and not d then
          e.pos.y = e.pos.y - e.vel.y*dt
      elseif d and not u then
        e.pos.y = e.pos.y + e.vel.y*dt

      end


    elseif not e.camera then
      if l and not r then
        if not e.collieded  then
          e.pos.x = e.pos.x -e.vel.x*dt
        elseif e.collieded then
          e.pos.x = e.pos.x +15+e.vel.x*dt
        end

      elseif r and not l then
          if not e.collieded then
            e.pos.x = e.pos.x + e.vel.x*dt
          elseif e.collieded then
            e.pos.x = e.pos.x - 15 - e.vel.x*dt
          end

      end

      if u and not d then
        if not e.collieded then
          e.pos.y = e.pos.y - e.vel.y*dt
        elseif e.collieded then
          e.pos.y = e.pos.y + 15 + e.vel.y*dt
        end
      elseif d and not u then
        if not e.collieded then
          e.pos.y = e.pos.y + e.vel.y*dt
        elseif e.collieded  then
          e.pos.y = e.pos.y - 15 - e.vel.y*dt
        end
      end
    end



end
