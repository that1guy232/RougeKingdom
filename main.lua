
worldgen  = require "worldgen"
graphics  = require "graphics"
entitys   = require "Entitys/entitys"
playerMod = require "Entitys/player"
itemsMod     = require "items"
inventory = require "inventory"
buttons = require "buttons"
json = require "json"
popup = require "popups"
peasant = require "Entitys/peasant"






--magic nubers based on the cells in the inventory graphic
playerInventoryWidth = 7
playerInventoryHeight = 9
playerInventorySize = playerInventoryWidth * playerInventoryHeight



  normalState = 0
  invState = 1
  gameState = normalState






function love.load()



  -- Load the world file
  print("Loading world file.")
  file = io.open ("map.lua", "r")

  -- if the file is there
  if file ~= nil then

    -- set the file to the inupt
    print("World file found setting it as input")
    io.input(file)
    -- decode the file from json and set it to world.
    print("setting 'world' == world file.")

    world = json.decode(io.read())
    -- close the file.
    print("Closing world file")
    io.close(file)


  end
  -- if the world file is not there.
  if file == nil then
    print("world file not found, Making new one.")

    --Make the world.

    -- world = {
    --   player = {
    --     chunkID = 0,
    --     tileID = 0,
    --     health = 100,
    --     inventorySize = playerInventorySize,
    --     inventory = []
    --   },
    --    entitys = {
    --      entity.cx,cy,chunkID
    --    },
    --   chunks = {
    --    {
    --    entitys = [0 or entityID],
    --    ground = [0..100]
    --    }
    --   }
    --
    --
    -- }



    world = {}
    world.width = 25
    world.height = 20
    world.chunks = {}

    world.ticks = 0
    world.actionque = {}
    world.viewedChunk = 1
    world.playerTile = 1


    print("Genning chunk 1")





    tmpChunk = genChunk2(0,0,1)
    tmpChunk.entitys[1] = deepcopy(entityProtos.player)





    world.chunks[1] = tmpChunk


  end


  print("registering items")

  craftingButtons = {}

  cx = 50+410
  cy = 50

  for i  = 1,  table.maxn(items) do
    if items[i].ingredients ~= nil then

      craftingButton = {
        item = items[i],
        button = makeButton( cx+10, cy+10, love.graphics.getWidth()-520, 45,0, 0.3137, 0)
      }


        table.insert(craftingButtons, craftingButton)
          cy = cy + i * 20
          print("registered item: ".. craftingButton.item.name)
    end
  end




  print("end of loading")




end




function love.draw()
  x = 0
  y = 0
  for i = 1, world.width * world.height do
    if ( x % world.width == 0) then
      y = y + 1
      x = 0
    end
    x=x+1



    drawGround( x  * world.width,y  * world.height,world.chunks[world.viewedChunk].ground[i])

    drawEntity( x  * world.width,y  * world.height,world.chunks[world.viewedChunk].entitys[i])

  end



  drawPopup()

  if gameState ==  invState then
    drawInventory()
  end



  love.graphics.setColor(1, 1, 1, 1)


end




function drawEntity(x,y,entity)

  if entity  ~= 0 then
      tile = getTileByName(entity.name)
      love.graphics.draw(tile.graphic, tile.Xoff + x, tile.Yoff + y - 5)
      if entity.health < 100 then
        love.graphics.setColor(96, 1, 0, 229)
        love.graphics.rectangle("fill", x, y+20, 7, 20  * -entity.health / 100)
        love.graphics.setColor(0, 0, 0,1)
        love.graphics.rectangle("line", x, y, 7 , 20)
        love.graphics.setColor(1, 1, 1, 1)
      end


  end





end





function drawGround(x,y,tileId)
  if tileId == 1 then
    tile = getTileByName("grass")
    love.graphics.draw(tile.graphic, tile.Xoff + x, tile.Yoff + y)
  elseif tileId == 0 then
    tile = getTileByName("water")
    love.graphics.draw(tile.graphic, tile.Xoff + x , tile.Yoff + y)
  end
end



--Move to inside a world file?
function findWorldChunkByXY(x,y,genChunks)

  for i=1,table.maxn(world.chunks) do
    if world.chunks[i].x == x then
      if world.chunks[i].y == y then
        return world.chunks[i].id
      end
    end
  end

  if genChunks then
    table.insert(world.chunks,genChunk2(x,y,table.maxn(world.chunks) + 1))
  end
  print("chunk size: ".. table.maxn(world.chunks))
  return table.maxn(world.chunks)
end


--Util function to copy a table. Move to Utils?
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end



--Probably have to redo this.
function damageEntity(worldPos, tileID,damageDoer)

  entity = world.chunks[worldPos].entitys[tileID]
  inventory = damageDoer.inventory
  if entity ~= 0 then


    if entity.health  > 0 then
      --toggle this off if the next tile has helth so the player can not hold button to insta mine.
      love.keyboard.setKeyRepeat(false)

      entity.health = entity.health - 25

      print("Did damage to entity: " .. tileID)

        if entity.health ==  0 then
          addToInventory(inventory,entity.name,1)

          world.chunks[worldPos].entitys[tileID] = 0


        end

    end
  end
end


mouseTileID = 0
px = 0
py = 0
function love.mousepressed(x, y, button)
  px, py = love.window.toPixels( x-20, y-20)

  mouseTileID = (math.floor(px / world.width ) + math.floor(py /world.height   ) * 25) + 1



if gameState == normalState then
if  mouseTileID  <= world.width * world.height and world.chunks[world.viewedChunk].entitys[mouseTileID] ~= 0  then

  playerAct(world.viewedChunk,mouseTileID)
  print(math.floor(px/world.width) + 1)
  print(math.floor(py/world.height) + 1)
end

elseif gameState == invState then
    px, py = love.window.toPixels(x,y)
   if button == 1  then
     print("clicked in inv")
      for i = 1, table.maxn(craftingButtons) do
        b  = craftingButtons[i]
        item = craftingButtons[i].item
        bx = craftingButtons[i].button.x
        by = craftingButtons[i].button.y
        bh = craftingButtons[i].button.height
        bw = craftingButtons[i].button.width


        if py > by and py < by + bh and px > bx and px < bx + bw then
          tmpp = world.chunks[world.viewedChunk].entitys[world.playerTile]
          if canCraft(tmpp.inventory.contents, item.ingredients,true) == true then
            
            print("Can craft:".. item.name)
          else
            print("Can't craft:".. item.name)
          end
        end


      end
   end
 end


  px = (math.floor(px / 25) + 1)
  py = (math.floor(py / 20) + 1)

end


function moveplayer(key)


  love.keyboard.setKeyRepeat(true)


  ntid = world.playerTile
  ncx = world.chunks[world.viewedChunk].x
  ncy = world.chunks[world.viewedChunk].y

  if key == 'd' then
    ntid = world.playerTile + 1
    if world.playerTile % world.width == 0 then
      ntid = world.playerTile + 1 - world.width
      ncx = ncx + 1
    end

  elseif  key == 'a' then
    ntid = world.playerTile - 1

    if world.playerTile % world.width == 1 then
      ntid = world.width + world.playerTile - 1
      ncx = ncx - 1
    end

  elseif key == 's' then

    ntid = world.playerTile + world.width
    if world.playerTile + world.width > world.height * world.width then
      ntid = world.playerTile + world.width - world.height *world.width
      ncy = ncy - 1
    end

  elseif key == 'w'then
    ntid = world.playerTile - world.width
    if ntid < 1 then
      ntid = ntid + world.height*world.width
      ncy = ncy + 1
    end


  end


  if moveEnt(world.viewedChunk,ncx,ncy, world.playerTile, ntid) then
    world.viewedChunk = findWorldChunkByXY(ncx,ncy,false)
    world.playerTile = ntid
  else
    if world.chunks[world.viewedChunk].ground[ntid] ~= 0 then
      if ntid ~= world.playerTile then
        action = {
          chunkID = findWorldChunkByXY(ncx,ncy,false),
          sender = world.chunks[world.viewedChunk].entitys[world.playerTile],
          sendingTile = world.playerTile,
          recivingTile  = ntid}
        table.insert(world.actionque,action)

      end
    end
  end



end


function moveEnt(currecntChunkID,chunkX,chunkY,tileFrom,TileTo)



    chunkIDTo = findWorldChunkByXY(chunkX,chunkY,true)

    print("Moving ent at ChunkID: ".. currecntChunkID .. " (x,y) " ..world.chunks[currecntChunkID].x..","..world.chunks[currecntChunkID].y.. " & TileID of: " .. tileFrom)
    print("To ChunkID: ".. chunkIDTo .. "(x,y) " .. chunkX .. "," .. chunkY .. " to TileID of: ".. TileTo)



    oldpos = world.chunks[currecntChunkID].entitys[tileFrom]


    newpos = world.chunks[chunkIDTo].entitys[TileTo]

    if newpos ~= 0 then return false
    elseif world.chunks[chunkIDTo].ground[TileTo] == 0 then return false
    elseif newpos == 0 then
      world.chunks[chunkIDTo].entitys[TileTo] = world.chunks[currecntChunkID].entitys[tileFrom]
      world.chunks[currecntChunkID].entitys[tileFrom] = 0
      return  true
    end
end


function love.keypressed(key, scancode, isrepeat)
  love.keyboard.setKeyRepeat(true)
  moveplayer(key)

  if key == 'tab' then
    file = io.open ("map.lua", "w")
    io.output(file)
    jsonworld = json.encode(world)
    print(jsonworld)

    io.write(jsonworld)
    io.close(file)
  elseif key == 'e' then
    print("gameState: " .. gameState)
    if gameState == normalState then

      gameState = invState
    elseif gameState == invState then
      gameState = normalState
    end
  end

end



function updateChunk(chunkID)
  chunk = world.chunks[chunkID]
  for i = 1, table.maxn(chunk.entitys) do
    if chunk.entitys[i] ~= 0 then
      if chunk.entitys[i].name == "peasant" then
        updatePeasant(chunk.entitys[i])
      end
    end
  end

end



oldtick = 0
rate = 1
function love.update(dt)
  newtick =  oldtick + (dt * rate)

  if newtick + oldtick > 0.3 then
    newtick = 0
    oldtick = 0

    world.ticks = world.ticks + 1

    if world.ticks % 30 == 1 then
      --TODO UPDATE OTHER CHUNKS
    end

    for cx = -2, 2 do
      for cy = -2, 2 do
        chunkID = findWorldChunkByXY(world.viewedChunk-cx, world.viewedChunk + cy,true)
        updateChunk(chunkID)

      end
    end

    updatePopups()


    if table.maxn(world.actionque) > 0 then
      action = world.actionque[1]

      if world.chunks[action.chunkID].entitys[action.sendingTile] ~= 0 then
        if world.chunks[action.chunkID].entitys[action.sendingTile].name == action.sender.name then
          if action.sender.name == "player" then

            playerAct(world.viewedChunk,action.recivingTile)
            table.remove(world.actionque,1)
          end
        end
      end
        table.remove(world.actionque,1)
    end

  end

  oldtick = newtick

end
