--tmp world init
local waterdepth = 0;
function worldInit(width,height,waterdepth)

  local map = {}


  local start = love.timer.getTime()
  map.heightMap = genHeightMap(w,h)

  map.data = {}

  map.waterpools = {}
  map.data.waterdepth = waterdepth
  map.data.width = width
  map.data.height = height


  for i = 1, 7 do
    print("SmoothPass #" .. i)
    map.heightMap  = smoothHeightMap(map.heightMap , w, h)
  end

  smallest = 1000


  for i = 1, #map.heightMap do
    if map.heightMap[i].col < smallest then
      smallest = map.heightMap[i].col
    end
  end



  for i = 1, #map.heightMap do
    map.heightMap[i].col = map.heightMap[i].col  - smallest
    if map.heightMap[i].col/100  > 1 then
      subamount = map.heightMap[i].col - 100
      map.heightMap[i].col = map.heightMap[i].col - subamount
    end

  end

  map = genWaterBiome(map)

  local result = love.timer.getTime() - start
  print( string.format( "It took %.3f milliseconds ", result * 1000 ))

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




function genWaterBiome (map)
  print("Making water biome")
  local map = map
  nWaterPoolID = 1


  --give each water it's own ID
  for i = 1, #map.heightMap do
    if map.heightMap[i].col < map.data.waterdepth then
      map.heightMap[i].WPID = nWaterPoolID
      nWaterPoolID = nWaterPoolID + 1
    end
  end

--Reduces id's to lowest connecting ones
print("water biome")
for s = 1, 40 do
  for i = 1, #map.heightMap do
    if map.heightMap[i].WPID then
      local aroundTiles = getTilesAroundTile(map.heightMap,i,map.data.width)

        for ii = 1, #aroundTiles do
          if aroundTiles[ii].WPID then
            if map.heightMap[i].WPID < aroundTiles[ii].WPID then
              map.heightMap[aroundTiles[ii].index].WPID = map.heightMap[i].WPID
            elseif map.heightMap[i].WPID > aroundTiles[ii].WPID then
              map.heightMap[i].WPID = aroundTiles[ii].WPID
            end
          end
        end
    end
  end
end

--making waterpool id's start at 1

wpidCount = {}
for t = 1, 5 do
for i = 1, #map.heightMap do
    if map.heightMap[i].WPID then
      if not wpidCount[1] then
        print("sd")
        table.insert(wpidCount,map.heightMap[i].WPID)
      end
      contained = false
      for ii = 1, #wpidCount do

        if map.heightMap[i].WPID == wpidCount[ii] then
          contained = true
        end
      end
      if not contained then
        table.insert(wpidCount,map.heightMap[i].WPID)
      end


    end
end
end
print(json.encode(wpidCount))




map.waterPoolIds = wpidCount
return  map

end
