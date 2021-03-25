
Rock = {
  name = "rock",
  pos = {x = 50, y = 50},
  vel = {x = 0 , y = 0},
  hitbox = {w = 25, h = 25},
  health = 25,
  type = "resource",
  graphic = 7,
  export = true
}



function Rock:die(e)
  if e.inventory then
    tiny.remove(world,self)
    self.markdead  = true
    inventorySystem:addItem(e,"rock",1)
  end
end



function Rock:export()
  return {
    _type = "Tree",
    pos = self.pos,
    health = self.health
  }
end
