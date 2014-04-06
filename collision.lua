function intersection(a, b)
  local x11, y11, x12, y12 = a.position.x, a.position.y, a.position.x + a.size, a.position.y + a.size
  local x21, y21, x22, y22 = b.position.x, b.position.y, b.position.x + b.size, b.position.y + b.size
  if not CheckCollision(x11,y11,a.size,a.size,x21,y21,b.size,b.size) then return nil end
  local allX = {x11,x12,x21,x22}
  local allY = {y11,y12,y21,y22}
  table.sort(allX)
  table.sort(allY)
  local xCol = allX[2]
  local yCol = allY[2]
  local wCol = allX[3] - xCol
  local hCol = allY[3] - yCol
  return {position = {x = xCol, y = yCol}, size = {h = hCol, w = wCol}}
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

Collider = {}
function Collider:checkCollisions(boxes)
  local all = {}
  for i, a in ipairs(boxes) do
    for i2, b in ipairs(boxes) do
      if i ~= i2 then
        local inters = intersection(a,b)
        if inters then
          table.insert(all, inters)
          --print('---')
          --for k,v in pairs(a) do print(k,v) end
          --print('===')
          a:informCollision(b, inters)
        end
      end
    end
  end
  --for k,v in pairs(all) do print(k,v) end
  return all
end
