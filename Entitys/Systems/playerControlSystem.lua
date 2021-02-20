playerControlSystem = tiny.processingSystem()
playerControlSystem.filter = tiny.requireAll("controlled")



function playerControlSystem:process(e,dt)
    local l, r, u,d = love.keyboard.isDown('a'), love.keyboard.isDown('d'), love.keyboard.isDown('w'),love.keyboard.isDown('s')
    if l and not r then

      e.x = e.x -100*dt
    elseif r and not l then
      e.x = e.x + 100*dt
    end
    if u and not d then
      e.y = e.y - 100*dt
    elseif d and not u then
      e.y = e.y + 100*dt
    end
end
