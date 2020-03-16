
if not LSlib.technology then require "technology" else

  function LSlib.technology.isEnabled(technologyName)
    if not data.raw["technology"][technologyName] then return false end
    if data.raw["technology"][technologyName].enabled == nil then return true end
    return data.raw["technology"][technologyName].enabled
  end

  function LSlib.technology.enable(technologyName)
    if not data.raw["technology"][technologyName] then return end
    data.raw["technology"][technologyName].enabled = true
  end

  function LSlib.technology.disable(technologyName)
    if not data.raw["technology"][technologyName] then return end
    data.raw["technology"][technologyName].enabled = false
  end

  function LSlib.technology.isHidden(technologyName)
    if not data.raw["technology"][technologyName] then return true end
    if data.raw["technology"][technologyName].hidden == nil then return false end
    return data.raw["technology"][technologyName].hidden
  end

  function LSlib.technology.setHidden(technologyName)
    if not data.raw["technology"][technologyName] then return end
    data.raw["technology"][technologyName].hidden = true
  end

  function LSlib.technology.setVisible(technologyName)
    if not data.raw["technology"][technologyName] then return end
    data.raw["technology"][technologyName].hidden = false
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
