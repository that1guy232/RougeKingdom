playerControlSystem = tiny.processingSystem()
playerControlSystem.filter = tiny.requireAll("controlled")



function playerControlSystem:process(e,dt)






  --25000 magic number is widht of 1000 tiles
  --I should have a collider box on the front of the player and check if the player can move that way.
  --It would be a system that would take, a "facingbox" tag, a pos(x,y) , It would take the x,y convert them to tiled x,y  then get the array index of the map from that
  -- return the tile type?name? if possable.

    local l, r, u,d = love.keyboard.isDown('a'), love.keyboard.isDown('d'), love.keyboard.isDown('w'),love.keyboard.isDown('s')



    --export out to like CameraControllerSystem????
    if e.camera then

      if l and not r then
          if e.pos.x < 5 then
          e.pos.x = e.pos.x -e.vel.x*dt
        end
      elseif r and not l then
          e.pos.x = e.pos.x + e.vel.x*dt
      end


      if u and not d then
          e.pos.y = e.pos.y - e.vel.y*dt
      elseif d and not u then
        e.pos.y = e.pos.y + e.vel.y*dt

      end


    elseif not e.camera then




        function love.keypressed(key, scancode, isrepeat)
          if key == 'e' then
            if e.inventory then
              if e.inventory.visable then
                e.inventory.visable = false
              else
                e.inventory.visable = true
              end
            end
          end
        end



      if l and not r then
        local lessThen5 = e.pos.x < 5
        if not e.collieded  and  not lessThen5 then
          e.pos.x = e.pos.x -e.vel.x*dt
        elseif e.collieded then
          e.pos.x = e.pos.x +15+e.vel.x*dt
        end

      elseif r and not l then
          local lessThen24995 = e.pos.x < 25000 - 25

          if not e.collieded  and   lessThen24995 then
            e.pos.x = e.pos.x + e.vel.x*dt
          elseif e.collieded then
            e.pos.x = e.pos.x - 15 - e.vel.x*dt
          end

      end

      if u and not d then
        local lessThen5 = e.pos.y < 5
        if not e.collieded and  not lessThen5 then
          e.pos.y = e.pos.y - e.vel.y*dt
        elseif e.collieded then
          e.pos.y = e.pos.y + 15 + e.vel.y*dt
        end
      elseif d and not u then
        local greaterThen24995 = e.pos.y > 25000 - 25
        if not e.collieded and  not greaterThen24995 then
          e.pos.y = e.pos.y + e.vel.y*dt
        elseif e.collieded  then
          e.pos.y = e.pos.y - 15 - e.vel.y*dt
        end
      end
    end



end
