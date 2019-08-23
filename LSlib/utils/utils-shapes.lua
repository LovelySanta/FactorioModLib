
if LSlib and LSlib.utils then
  if not LSlib.utils.shapes then LSlib.utils.shapes = {}

    function LSlib.utils.shapes.createCircleContour(radius)
      -- creating a circle around (0,0)
      if radius <= 0 then return end
      if LSlib.utils.shapes["circle"][radius] then return end

      local contour = {}
      if radius == 1 then
        contour = {
          {x =  1, y =  0},
          {x =  1, y =  1},
          {x =  0, y =  1},
          {x = -1, y =  1},
          {x = -1, y =  0},
          {x = -1, y = -1},
          {x =  0, y = -1},
          {x =  1, y = -1},
        }

      elseif radius == 2 then
        contour = {
          {x =  2, y =  0},
          {x =  2, y =  1},
          {x =  1, y =  1},
          {x =  1, y =  2},
          {x =  0, y =  2},
          {x = -1, y =  2},
          {x = -1, y =  1},
          {x = -2, y =  1},
          {x = -2, y =  0},
          {x = -2, y = -1},
          {x = -1, y = -1},
          {x = -1, y = -2},
          {x =  0, y = -2},
          {x =  1, y = -2},
          {x =  1, y = -1},
          {x =  2, y = -1},
        }

      else
        -- Using midpoint circle algorithm
        -- https://en.wikipedia.org/wiki/Midpoint_circle_algorithm

        -- initialisation
        local index = 1
        contour[index] = {x = radius, y = 0}
        local lastXSquared = radius * radius

        -- calculate points from 0 degrees to 45 degrees (CCW)
        while (contour[index].x > contour[index].y) do -- less than 45 degrees
          local lastY = contour[index].y
          lastXSquared = lastXSquared - 2 * lastY - 1
          local thisX = math.floor(math.sqrt(lastXSquared) + 0.5)

          if thisX ~= contour[index].x then -- creating a 'thick circle'
            -- we are moving diagonal (O: old; N:new)  -->   N
            -- inserting another point (A) to close cirlce   A O
            index = index + 1
            contour[index] = {
              x = thisX,
              y = lastY
            }
          end

          -- inserting our freshly created point
          if thisX > lastY then
            index = index + 1
            contour[index] = {
              x = thisX,
              y = lastY + 1
            }
          end
        end

        -- mirror points from (0-45) degrees to (45-90) degrees (CCW)
        -- => mirroring around equation y = x
        for mirrorIndex = index - 1, 1, -1 do
          index = index + 1
          contour[index] = {
            x = contour[mirrorIndex].y,
            y = contour[mirrorIndex].x
          }
        end

        -- mirror points from (0-90) degrees to (90-180) degrees (CCW)
        -- => mirroring around equation x = 0
        for mirrorIndex = index - 1, 1, -1 do
          index = index + 1
          contour[index] = {
            x = -contour[mirrorIndex].x,
            y =  contour[mirrorIndex].y
          }
        end

        -- mirror points from (0-180) degrees to (180-360) degrees (CCW)
        -- => mirroring around equation y = 0
        for mirrorIndex = index - 1, 2, -1 do
          index = index + 1
          contour[index] = {
            x =  contour[mirrorIndex].x,
            y = -contour[mirrorIndex].y
          }
        end
      end
      -- store the result
      LSlib.utils.shapes["circle"][radius] = contour
    end

    function LSlib.utils.shapes.getCircleContour(centerPos, radius)
      if (not radius) or (radius == 0) then return {centerPos} end
      if radius < 0 then
        return LSlib.utils.shapes.getCircleContour(centerPos, -radius)
      end

      -- make sure input is valid
      radius = math.floor(radius + 0.5)
      centerPos = {
        x = math.floor((centerPos.x or centerPos[1] or 0) + 0.5),
        y = math.floor((centerPos.y or centerPos[2] or 0) + 0.5)
      }

      -- get the perfect circle
      if not LSlib.utils.shapes["circle"] then LSlib.utils.shapes["circle"] = {} end
      if not LSlib.utils.shapes["circle"][radius] then
        LSlib.utils.shapes.createCircleContour(radius)
      end
      local circleContour = util.table.deepcopy(LSlib.utils.shapes["circle"][radius])

      -- translate it to centerPos
      for k,v in pairs(circleContour) do
        circleContour[k] = {
          x = v.x + centerPos.x,
          y = v.y + centerPos.y
        }
      end

      return circleContour
    end

  end
else
  require "utils"
end
