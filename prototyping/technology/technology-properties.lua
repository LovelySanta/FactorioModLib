
if not LSlib.technology then require "technology" else

  function LSlib.technology.enable(technologyName)
    if not data.raw["technology"][technologyName] then return end
    data.raw["technology"][technologyName].enabled = true
  end

  function LSlib.technology.disable(technologyName)
    if not data.raw["technology"][technologyName] then return end
    data.raw["technology"][technologyName].enabled = false
  end

  function LSlib.technology.setLocalisedName(technologyName, localeString)
    if not data.raw["technology"][technologyName] then return end

    LSlib.item.setLocalisedName("technology", technologyName, localeString)
  end

  function LSlib.technology.setOrderstring(technologyName, orderstring)
    if not data.raw["technology"][technologyName] then return end

    LSlib.item.setOrderstring("technology", technologyName, orderstring)
  end

end
