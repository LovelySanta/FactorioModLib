
if not LSlib.technology then require "technology" else

  function LSlib.technology.disable(technologyName)
    if not data.raw["technology"][technologyName] then return end
    data.raw["technology"][technologyName].enabled = false
  end

end
