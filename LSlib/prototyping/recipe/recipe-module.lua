
if not LSlib.recipe then require "recipe" else

  function LSlib.recipe.allowModuleEffect(moduleNames, recipeToAdd)
    if moduleNames == nil then
      moduleNames = LSlib.item.getAllModuleNames(true)
    end

    if LSlib.utils.table.isTable(moduleNames) then
      for _,moduleName in pairs(moduleNames) do
        LSlib.recipe.allowModuleEffect(moduleName, recipeToAdd)
      end

    else
      if not data.raw["recipe"][recipeToAdd] then
        LSlib.utils.log.log(string.format("WARNING: Tried allowing %q on recipe %q, but the recipe doesn't exist.", moduleNames, recipeToAdd))
        return
      end

      if not data.raw["module"][moduleNames] then
        LSlib.utils.log.log(string.format("WARNING: Tried adding recipe %q to %q, but that module doesn't exist.", recipeToAdd, moduleNames))
        return
      end

      data.raw["module"][moduleNames].limitation = data.raw["module"][moduleNames].limitation or {}
      for _,recipeName in pairs(data.raw["module"][moduleNames].limitation) do
        if recipeName == recipeToAdd then
          LSlib.utils.log.log(string.format("WARNING: Tried adding recipe %q to %q, but that recipe was already present.", recipeToAdd, moduleNames))
          return
        end
      end

      table.insert(data.raw["module"][moduleNames].limitation, recipeToAdd)
    end
  end



  function LSlib.recipe.canUseModuleEffect(recipeToCheck, moduleNames)
    if moduleNames == nil then
      moduleNames = LSlib.item.getAllModuleNames()
    end

    if LSlib.utils.table.isTable(moduleNames) then
      local allowsEffects = {}
      for _,moduleName in pairs(moduleNames) do
        allowsEffects[moduleName] = LSlib.recipe.canUseModuleEffect(recipeToCheck, moduleName)
      end
      return allowsEffects

    else
      if not data.raw["recipe"][recipeToCheck] then
        LSlib.utils.log.log(string.format("WARNING: Tried checking if %q on recipe %q is allowed, but the recipe doesn't exist.", moduleNames, recipeToCheck))
        return nil
      end

      if not data.raw["module"][moduleNames] then
        LSlib.utils.log.log(string.format("WARNING: Tried checking if %q on recipe %q is allowed, but that module doesn't exist.", recipeToCheck, moduleNames))
        return nil
      end

      if not data.raw["module"][moduleNames].limitation then return true end

      for _,recipeName in pairs(data.raw["module"][moduleNames].limitation) do
        if recipeName == recipeToCheck then
          return true
        end
      end
      return false
    end
  end



  function LSlib.recipe.removeModuleEffect(moduleNames, recipeToRemove)
    if moduleNames == nil then
      moduleNames = LSlib.item.getAllModuleNames(true)
    end

    if LSlib.utils.table.isTable(moduleNames) then
      for _,moduleName in pairs(moduleNames) do
        LSlib.recipe.removeModuleEffect(moduleName, recipeToRemove)
      end

    else
      if not data.raw["recipe"][recipeToRemove] then
        LSlib.utils.log.log(string.format("WARNING: Tried removing %q on recipe %q, but the recipe doesn't exist.", moduleNames, recipeToRemove))
        return
      end

      if not data.raw["module"][moduleNames] then
        LSlib.utils.log.log(string.format("WARNING: Tried removing recipe %q to %q, but that module doesn't exist.", recipeToRemove, moduleNames))
        return
      end

      data.raw["module"][moduleNames].limitation = data.raw["module"][moduleNames].limitation or {}
      for recipeIndex,recipeName in pairs(data.raw["module"][moduleNames].limitation) do
        if recipeName == recipeToRemove then
          table.remove(data.raw["module"][moduleNames].limitation, recipeIndex)
          return -- return if removed
        end
      end

      LSlib.utils.log.log(string.format("WARNING: Tried removing recipe %q to %q, but that recipe was not present.", recipeToRemove, moduleNames))

    end
  end

end
