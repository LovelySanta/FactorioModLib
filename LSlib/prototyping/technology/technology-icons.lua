
if not LSlib.technology then require "technology" else

  function LSlib.technology.getIcons(technologyName, layerScale, layerShift, layerTint)
    return LSlib.item.getIcons("technology", technologyName, layerScale, layerShift, layerTint)
  end

  function LSlib.technology.changeIcon(technologyName, newIconFile, newIconSize)
    LSlib.item.changeIcon("technology", technologyName, newIconFile, newIconSize)
  end

  function LSlib.technology.changeIcons(technologyName, newIcons, newIconSize)
    LSlib.item.changeIcons("technology", technologyName, newIcons, newIconSize)
  end

end
