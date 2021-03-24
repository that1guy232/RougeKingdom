cameraEnt   = {
    name = "camera",
    pos = {x = 100, y = 100},
    hitbox = {w = 31, h = 23},
    map = {},
    vel = {x = 250,y = 250},
    camera = true,
    controlled = true,
    drawableSprites = {}

}

function cameraEnt:onCollision(e)

  table.insert(self.drawableSprites,e)


end
function cameraEnt:updatePos(e)


end

function cameraEnt:export()

  return { _type = "cameraEnt", pos = self.pos, hitbox = self.hitbox}
end
