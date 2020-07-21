
if not LSlib.item then require "item" else

  function LSlib.item.getIcons(itemType, itemName, layerScale, layerShift, layerTint)
    if data.raw[itemType][itemName].icons then -- icons present
      local prototypeIconSize = data.raw[itemType][itemName].icon_size

      local prototypeIcons = {}
      for iconLayerIndex, iconLayer in pairs(data.raw[itemType][itemName].icons) do
        prototypeIcons[iconLayerIndex] = {
          ["icon"     ] = iconLayer.icon,
          ["icon_size"] = iconLayer.icon_size or prototypeIconSize, -- prototypeIconSize if not icon_size specified in layer
          ["tint"     ] = (iconLayer.tint or layerTint) and {
            r = (iconLayer.tint and (iconLayer.tint.r or iconLayer.tint[1] or 0) or 1) * (layerTint and (layerTint.r or layerTint[1] or 0) or 1),
            g = (iconLayer.tint and (iconLayer.tint.g or iconLayer.tint[2] or 0) or 1) * (layerTint and (layerTint.g or layerTint[2] or 0) or 1),
            b = (iconLayer.tint and (iconLayer.tint.b or iconLayer.tint[3] or 0) or 1) * (layerTint and (layerTint.b or layerTint[3] or 0) or 1),
            a = (iconLayer.tint and (iconLayer.tint.a or iconLayer.tint[4] or 1) or 1) * (layerTint and (layerTint.a or layerTint[4] or 1) or 1),
          } or nil,
          ["scale"    ] = (iconLayer.scale or 1) * (layerScale or 1),
          ["shift"    ] = {
            (iconLayer.shift or {0, 0})[1] * (layerScale or 1) + (layerShift or {0,0})[1],
            (iconLayer.shift or {0, 0})[2] * (layerScale or 1) + (layerShift or {0,0})[2],
          },
        }
      end
      return util.table.deepcopy(prototypeIcons)

    else -- icon + icon_size present
      local prototypeIcon = data.raw[itemType][itemName].icon

      return { -- icons table
        { -- single layer
          ["icon"     ] = prototypeIcon,
          ["icon_size"] = data.raw[itemType][itemName].icon_size,
          ["tint"     ] = (    LSlib.utils.table.isTable(layerTint)  and
                          (not LSlib.utils.table.isEmpty(layerTint)) and layerTint) or nil,
          ["scale"    ] = layerScale,
          ["shift"    ] = layerShift,
        }
      }
    end
  end



  function LSlib.item.getIconSize(itemType, itemName)
    if data.raw[itemType][itemName] then
      if data.raw[itemType][itemName].icons then -- icons present
        local prototypeIconSize = {}
        for iconLayerIndex, iconLayer in pairs(data.raw[itemType][itemName].icons) do
          prototypeIconSize[iconLayerIndex] = iconLayer.icon_size or data.raw[itemType][itemName].icon_size
        end
        return prototypeIconSize

      else -- icon + icon_size present
        return {data.raw[itemType][itemName].icon_size}
      end
    else
      return {} -- nothing found, we have to return something
    end
  end



  function LSlib.item.changeIcon(itemType, itemName, newIconFile, newIconSize, newIconMipmap)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    data.raw[itemType][itemName].icon = newIconFile
    data.raw[itemType][itemName].icon_size = newIconSize
    data.raw[itemType][itemName].icon_mipmaps = newIconMipmap
    data.raw[itemType][itemName].icons = nil
  end



  function LSlib.item.changeIcons(itemType, itemName, newIcons, newIconSize, newIconMipmap)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    data.raw[itemType][itemName].icon = nil
    data.raw[itemType][itemName].icon_size = newIconSize -- could be set, or could be nil
    data.raw[itemType][itemName].icon_mipmaps = newIconMipmap
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
