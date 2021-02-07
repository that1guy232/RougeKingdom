function makeButton(x,y,width,height,r,g,b)
    button = {
      x = x, y = y,width = width,height = height,r = r,g = g,b = b
    }

    return button
end


function drawButton(button)

    love.graphics.setColor(button.r,button.g,button.b)
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
    love.graphics.setColor(1,1,1, 1)
end
