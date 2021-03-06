--tmp world init
function worldInit(width,height)

  local map = {}

  local start = love.timer.getTime()
  map = genHeightMap(w,h)




  for i = 1, 7 do
    print("SmoothPass #" .. i)
    map = smoothHeightMap(map, w, h)
  end

  smallest = 1000
  biggest = 0

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



function getTilesAroundTile(tiles, tile,width,height)

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
