
Tree = {
  name = "tree",
  pos = {x = 50, y = 50},
  vel = {x = 0 , y = 0},
  hitbox = {w = 25, h = 25},
  health = 25,
  type = "resource",
  graphic = 6,
  export = true
}



function Tree:die(e)
  if e.inventory then
    tiny.remove(world,self)
    inventorySystem:addItem(e,"tree",21)
  end
end



function Tree:export()
  return {
    _type = "Tree",
    pos = self.pos,
    health = self.health
  }
end
