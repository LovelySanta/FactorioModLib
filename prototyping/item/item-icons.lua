
if not LSlib.item then require "item" else

  function LSlib.item.getIcons(prototypeType, prototypeName, layerScale, layerShift, layerTint)
    local prototypeIcon = data.raw[prototypeType][prototypeName].icon

    if prototypeIcon then
      return { -- icons table
        { -- single layer
          ["icon"     ] = prototypeIcon,
          ["icon_size"] = data.raw[prototypeType][prototypeName].icon_size,
          ["tint"     ] = layerTint,
          ["scale"    ] = layerScale,
          ["shift"    ] = layerShift,
        }
      }
    else

      local prototypeIconSize = data.raw[prototypeType][prototypeName].icon_size

      local prototypeIcons = {}
      for iconLayerIndex, iconLayer in pairs(data.raw[prototypeType][prototypeName].icons) do
        prototypeIcons[iconLayerIndex] = {
          ["icon"     ] = iconLayer.icon,
          ["icon_size"] = iconLayer.icon_size or prototypeIconSize, -- prototypeIconSize if not icon_size specified in layer
          ["tint"     ] = (iconLayer.tint or layerTint) and {
            r = (iconLayer.tint and (iconLayer.tint.r or iconLayer.tint[1]) or .5) * (layerTint and (layerTint.r or layerTint[1]) or 1),
            g = (iconLayer.tint and (iconLayer.tint.g or iconLayer.tint[2]) or .5) * (layerTint and (layerTint.g or layerTint[2]) or 1),
            b = (iconLayer.tint and (iconLayer.tint.b or iconLayer.tint[3]) or .5) * (layerTint and (layerTint.b or layerTint[3]) or 1),
            a = (iconLayer.tint and (iconLayer.tint.a or iconLayer.tint[4]) or  0) * (layerTint and (layerTint.a or layerTint[4]) or 0),
          } or nil,
          ["scale"    ] = (iconLayer.scale or 1) * layerScale, -- 1            if not scale     specified in layer
          ["shift"    ] = {
            (iconLayer.shift or {0, 0})[1] + layerShift[1],    -- {0,0}        if not shift     specified in layer
            (iconLayer.shift or {0, 0})[2] + layerShift[2],
          },
        }
      end
      return util.table.deepcopy(prototypeIcons)

    end
  end



  function LSlib.item.changeIcon(itemType, itemName, newIconFile, newIconSize)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    data.raw[itemType][itemName].icon = newIconFile
    data.raw[itemType][itemName].icon_size = newIconSize
    data.raw[itemType][itemName].icons = nil
  end



  function LSlib.item.changeIcons(itemType, itemName, newIcons, newIconSize)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    data.raw[itemType][itemName].icon = nil
    data.raw[itemType][itemName].icon_size = newIconSize -- could be set, or could be nil
    data.raw[itemType][itemName].icons = util.table.deepcopy(newIcons)
  end



  function LSlib.item.addIconTint(itemType, itemName, tint)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    if tint.r > 1 or tint.g > 1 or tint.b > 1 then
      tint = LSlib.util.convertRGB(tint)
    end

    if data.raw[itemType][itemName].icon then
      data.raw[itemType][itemName].icons = {{
        icon = data.raw[itemType][itemName].icon,
        icon_size = data.raw[itemType][itemName].icon_size or 32,
      }}
      data.raw[itemType][itemName].icon = nil
      data.raw[itemType][itemName].icon_size = nil
    end

    if data.raw[itemType][itemName].icons then
      for _,iconLayer in pairs(data.raw[itemType][itemName].icons) do
        iconLayer.tint = util.table.deepcopy(tint)
      end
    end
  end

end
