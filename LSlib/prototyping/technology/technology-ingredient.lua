
if not LSlib.technology then require "technology" else

  function LSlib.technology.removeIngredient(technologyName, sciencePackName)
    if not data.raw["technology"][technologyName] then
      LSlib.utils.log.log(string.format("WARNING: Tried removing ingredient %q to technology %q, which doesn't exist.", sciencePackName, technologyName))
      return
    end

    if data.raw["technology"][technologyName].unit.ingredients then
      for index, ingredient in pairs(data.raw["technology"][technologyName].unit.ingredients) do
        if (ingredient[1] or ingredient.name) == sciencePackName then
          table.remove(data.raw["technology"][technologyName].unit.ingredients, index)
          if #data.raw["technology"][technologyName].unit.ingredients == 0 then
            data.raw["technology"][technologyName].unit.ingredients = nil
          end
          return
        end
      end
    else
      LSlib.utils.log.log(string.format("WARNING: Tried removing ingredient %q to technology %q, but no ingredients present in the technology.", sciencePackName, technologyName))
      return
    end
  end



  function LSlib.technology.addIngredient(technologyName, sciencePackAmount, sciencePackName)
    if not data.raw["technology"][technologyName] then
      LSlib.utils.log.log(string.format("WARNING: Tried adding ingredient %q to technology %q, which doesn't exist.", sciencePackName, technologyName))
      return
    end

    if data.raw["technology"][technologyName].unit.ingredients then
      for index, ingredient in pairs(data.raw["technology"][technologyName].unit.ingredients) do
        if (ingredient[1] or ingredient.name) == sciencePackName then
          LSlib.utils.log.log(string.format("WARNING: Tried adding ingredient %q to %q which was already present. Updating amount instead.", sciencePackName, technologyName))
          data.raw["technology"][technologyName].unit.ingredients[index][2] = sciencePackAmount
          return
        end
      end
      table.insert(data.raw["technology"][technologyName].unit.ingredients, {sciencePackName, sciencePackAmount})
    else
      LSlib.utils.log.log(string.format("WARNING: Tried adding ingredient %q to technology %q, but no ingredients present in the technology.", sciencePackName, technologyName))
      return
    end
  end



  function LSlib.technology.changeCount(technologyName, amount)
    if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].unit.count then
      data.raw["technology"][technologyName].unit.count = amount
    end
  end

end
