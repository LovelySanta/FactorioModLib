
if LSlib and LSlib.utils then
  if not LSlib.utils.directions then LSlib.utils.directions = {}

    function LSlib.utils.directions.orientationTo4WayDirection(orientation)
      -- Orientation will be a number in range [0, 1[
      -- 0 is north, 0.25 is east, 0.5 is south, 0.75 is west
      if orientation < .125 then
        return defines.direction.north
      elseif orientation < .375 then
        return defines.direction.east
      elseif orientation < .625 then
        return defines.direction.south
      elseif orientation < .875 then
        return defines.direction.west
      else -- >= .875
        return defines.direction.north
      end
    end


    local opositeDirections =
    {
      [defines.direction.north    ] = defines.direction.south    ,
      [defines.direction.northeast] = defines.direction.southwest,
      [defines.direction.east     ] = defines.direction.west     ,
      [defines.direction.southeast] = defines.direction.northwest,
      [defines.direction.south    ] = defines.direction.north    ,
      [defines.direction.southwest] = defines.direction.northeast,
      [defines.direction.west     ] = defines.direction.east     ,
      [defines.direction.northwest] = defines.direction.southeast,
    }
    function LSlib.utils.directions.oposite(direction)
      -- Function will return the oposite direction of the given direction
      return opositeDirections[direction]
    end



    local directionToString =
    {
      [defines.direction.north    ] = "north"    ,
      [defines.direction.northeast] = "northeast",
      [defines.direction.east     ] = "east"     ,
      [defines.direction.southeast] = "southeast",
      [defines.direction.south    ] = "south"    ,
      [defines.direction.southwest] = "southwest",
      [defines.direction.west     ] = "west"     ,
      [defines.direction.northwest] = "northwest",
    }
    function LSlib.utils.directions.toString(direction)
      -- Function will return the string of the direction
      return directionToString[direction]
    end


  end
else
  require "utils"
end
