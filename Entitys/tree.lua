
Tree = {
  name = "tree",
  pos = {x = 50, y = 50},
  vel = {x = 0 , y = 0},
  hitbox = {w = 25, h = 50},
  health = 25,
  type = "resource",
  graphic = 6,
  export = true
}



function Tree:die(e)

  if e.inventory then

    tiny.remove(world,self)
    self.markdead  = true
    inventorySystem:addItem(e,"tree",1)
  end
end



function Tree:export()
  return {
    _type = "Tree",
    pos = self.pos,
    health = self.health
  }
end
