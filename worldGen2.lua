--tmp world init
local waterdepth = 0;
function worldInit(width,height,waterdepth)

  local map = {}



  map.groundMap = genHeightMap(w,h)

  map.data = {}
  map.entites = {}
  map.waterpools = {}
  map.data.waterdepth = waterdepth
  map.data.width = width
  map.data.height = height


  for i = 1, 7 do
    print("SmoothPass #" .. i)
    map.groundMap  = smoothHeightMap(map.groundMap , w, h)
  end






  local resourceMap = genHeightMap(w,h)

  resourceMap = normalizeMap(resourceMap)


  map.groundMap = normalizeMap(map.groundMap)





  map = genBiomes(map)


print("resourceMap: " .. #resourceMap)
print("groundMap: " .. #map.groundMap)

  --Genning resources.
  local entx = 0
  local enty = 0
  print("Genning resources" )
  for i = 1, #resourceMap do
    if   resourceMap[i].col < 10 then
      if  map.groundMap[i].col > 45 then

        local entSelect = love.math.random(1,2)
        local tmpent
        if entSelect == 1 then
           tmpent = deepcopy(Rock)
        elseif entSelect == 2 then
           tmpent = deepcopy(Tree)
        end

        local entx = (resourceMap[i].x * 25)
        local enty = ( 1 + resourceMap[i].y * 25)


        tmpent.pos =  {x = entx, y = enty}

      

        table.insert(map.entites,deepcopy(tmpent))
      end
    end



    entx = entx + 1

  end



  return map
end

--tmp height map gen
function genHeightMap(width,height)

  local map = {}

  for h = 0, height-1 do
    for w = 0, width-1 do
      tmpTile = {}
      tmpTile.x = w
      tmpTile.y = h
      tmpTile.index = #map + 1
      tmpTile.col = love.math.random(0,100)

      table.insert(map,tmpTile)

    end

  end

  return map
end




function normalizeMap(map)
  smallest = 1000


  for i = 1, #map do
    if map[i].col < smallest then
      smallest = map[i].col
    end
  end



  for i = 1, #map do
    map[i].col = map[i].col  - smallest
    if map[i].col/100  > 1 then
      subamount = map[i].col - 100
      map[i].col = map[i].col - subamount
    end

  end
  return map
end




--tmp smooth height map
function smoothHeightMap(map,height,width)
  local smoothed = deepcopy(map)


  for i = 1, #smoothed do
    avgcol = smoothed[i].col
    aroundTiles = getTilesAroundTile(smoothed, i,width,height)

    count  = 0
    for ii = 1, #aroundTiles do
      avgcol = avgcol + aroundTiles[ii].col
    end
    avgcol = avgcol / #aroundTiles

     smoothed[i].col = avgcol
  end

  return smoothed
end



function getTilesAroundTile(tiles, tile,width)

  local aroundTiles = {}

  UL = tile - width - 1
  U  = tile - width
  UR = tile - width + 1
  L  = tile - 1
  R  = tile + 1
  DL = tile + width  - 1
  D  = tile + width
  DR = tile + width + 1

  table.insert(aroundTiles,  tiles[UL])
  table.insert(aroundTiles, tiles[U])
  table.insert(aroundTiles, tiles[UR])
  table.insert(aroundTiles, tiles[L])
  table.insert(aroundTiles, tiles[R])
  table.insert(aroundTiles, tiles[DL])
  table.insert(aroundTiles, tiles[D])
  table.insert(aroundTiles, tiles[DR])

  return aroundTiles

end




function genBiomes (map)

  local map = map
  nBID = 1


  --give each water it's own ID
  for i = 1, #map.groundMap do
    if map.groundMap[i].col < map.data.waterdepth then
      map.groundMap[i].BID = nBID
      nBID = nBID + 1
    end
  end

--Reduces id's to lowest connecting ones

  for s = 1, 40 do
    for i = 1, #map.groundMap do
      if map.groundMap[i].BID then
        local aroundTiles = getTilesAroundTile(map.groundMap,i,map.data.width)

          for ii = 1, #aroundTiles do
            if aroundTiles[ii].BID then
              if map.groundMap[i].BID < aroundTiles[ii].BID then
                map.groundMap[aroundTiles[ii].index].BID = map.groundMap[i].BID
              elseif map.groundMap[i].BID > aroundTiles[ii].BID then
                map.groundMap[i].BID = aroundTiles[ii].BID
              end
            end
          end
      end
    end
  end

--making waterpool id's start at 1

  bIDCount = {}
  for t = 1, 5 do
  for i = 1, #map.groundMap do
      if map.groundMap[i].BID then
        if not bIDCount[1] then
          table.insert(bIDCount,map.groundMap[i].BID)
        end
        contained = false
        for ii = 1, #bIDCount do

          if map.groundMap[i].BID == bIDCount[ii] then
            contained = true
          end
        end
        if not contained then
          table.insert(bIDCount,map.groundMap[i].BID)
        end


      end
  end
  end




  map.waterPoolIds = bIDCount
  return map

end
