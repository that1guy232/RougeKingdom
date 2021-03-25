playerControlSystem = tiny.processingSystem()
playerControlSystem.filter = tiny.requireAll("controlled")



function playerControlSystem:process(e,dt)






  --25000 magic number is widht of 1000 tiles
  --I should have a collider box on the front of the player and check if the player can move that way.
  --It would be a system that would take, a "facingbox" tag, a pos(x,y) , It would take the x,y convert them to tiled x,y  then get the array index of the map from that
  -- return the tile type?name? if possable.

    local l, r, u,d = love.keyboard.isDown('a'), love.keyboard.isDown('d'), love.keyboard.isDown('w'),love.keyboard.isDown('s')



    --export out to like CameraControllerSystem????





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


        e.vel.x = 0
        e.vel.y = 0
      if l and not r then
        local aa = e.pos.x < 25
    
        if not aa then
          e.vel.x = -150
        end
      elseif r and not l then
        --if not greater then world widht - 25
        local bb = e.pos.x > 250000  - 25
        if not  bb then
          e.vel.x =  150
        end
      else


      end

      if u and not d then
        local aa = e.pos.y < 25
        if not  aa then
          e.vel.y = -150
        end
      elseif d and not u then
        local bb = e.pos.y > 250000  - 25
        if not  bb then
          e.vel.y = 150
        end

      else

      end



end
