
if not LSlib.technology then require "technology" else

  function LSlib.technology.removeRecipeUnlock(technologyName, recipeToRemove)
    if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].effects then
      local removed = false
      for index, effect in pairs(data.raw["technology"][technologyName].effects) do
        if effect.type == "unlock-recipe" and effect.recipe == recipeToRemove then
          table.remove(data.raw["technology"][technologyName].effects, index)
          removed = true
          if table_size(data.raw["technology"][technologyName].effects) == 0 then
            data.raw["technology"][technologyName].effects = nil
          end
          break
        end
      end
      if not removed then
        LSlib.utils.log.log(string.format("WARNING: Could not remove recipe-unlock %q from technology %q.", recipeToRemove, technologyName))
      end
    end
  end



  function LSlib.technology.addRecipeUnlock(technologyName, recipeToAdd)
    if not data.raw["recipe"][recipeToAdd] then
      LSlib.utils.log.log(string.format("WARNING: Tried adding recipe-unlock %q to %q, but the recipe doesn't exist.", recipeToAdd, technologyName))
      return
    end

    if data.raw["technology"][technologyName] then
      if not data.raw["technology"][technologyName].effects then
        data.raw["technology"][technologyName].effects = {}
      end
      for index, effect in pairs(data.raw["technology"][technologyName].effects) do
        if effect.type == "unlock-recipe" and effect.recipe == recipeToAdd then
          LSlib.utils.log.log(string.format("WARNING: Tried adding recipe-unlock %q to %q, which was already present.", recipeToAdd, technologyName))
          return
        end
      end
      table.insert(data.raw["technology"][technologyName].effects, {type = "unlock-recipe", recipe = recipeToAdd})
    end
  end



  function LSlib.technology.moveRecipeUnlock(oldTechnologyName, newTechnologyName, recipeToMove)
    if not data.raw["technology"][newTechnologyName] then
      LSlib.utils.log.log(string.format("WARNING: Tried moving recipe-unlock %q to technology %q, which doesn't exist, removing it from %q anyway.", recipeToMove, newTechnologyName, oldTechnologyName))
      LSlib.technology.removeRecipeUnlock(oldTechnologyName, recipeToMove)
      return
    end

    if data.raw["technology"][oldTechnologyName] then
      local removed = false
      for index, effect in pairs(data.raw["technology"][oldTechnologyName].effects) do
        if effect.type == "unlock-recipe" and effect.recipe == recipeToMove then
          table.remove(data.raw["technology"][oldTechnologyName].effects, index)
          removed = true
          break
        end
      end
      if not removed then
        LSlib.utils.log.log(string.format("WARNING: Tried moving recipe-unlock %q from %q, which wasn't present, adding it to %q instead.", recipeToMove, oldTechnologyName, newTechnologyName))
      end
    else
      LSlib.utils.log.log(string.format("WARNING: Tried moving recipe-unlock %q from none existing technology %q, adding it to %q instead.", recipeToMove, oldTechnologyName, newTechnologyName))
    end
    LSlib.technology.addRecipeUnlock(newTechnologyName, recipeToMove)
  end

end
