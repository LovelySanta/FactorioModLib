
if not LSlib.technology then require "technology" else

  function LSlib.technology.changeIcon(technologyName, newIconFile, newIconSize)
    if not data.raw["technology"] then return end
    if not data.raw["technology"][technologyName] then return end

    data.raw["technology"][technologyName].icon = newIconFile
    data.raw["technology"][technologyName].icon_size = newIconSize
    data.raw["technology"][technologyName].icons = nil
  end

end
