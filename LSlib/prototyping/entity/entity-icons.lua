
if not LSlib.entity then require "entity" else

  function LSlib.entity.getIcons(entityType, entityName, layerScale, layerShift, layerTint)
    return LSlib.item.getIcons(entityType, entityName, layerScale, layerShift, layerTint)
  end



  function LSlib.entity.changeIcon(entityType, entityName, newIconFile, newIconSize)
    LSlib.item.changeIcon(entityType, entityName, newIconFile, newIconSize)
  end



  function LSlib.entity.changeIcons(entityType, entityName, newIcons, newIconSize)
    LSlib.item.changeIcons(entityType, entityName, newIcons, newIconSize)
  end

end
