
if not LSlib.recipe then require "recipe" else

  function LSlib.recipe.addIngredient(recipeName, ingredientName, ingredientAmount, ingredientType)
    if not data.raw["recipe"][recipeName] then return end
    LSlib.recipe.recipePrototypeCleanup(recipeName)

    if data.raw["recipe"][recipeName].ingredients then
      local alreadyPresent = false
      for _,ingredient in pairs(data.raw["recipe"][recipeName].ingredients) do
        if ingredient.name == ingredientName and
           (ingredient.type or "item") == (ingredientType or "item") then
          alreadyPresent = true
          LSlib.utils.log.log(string.format("WARNING: Tried adding ingredient %q to recipe %q, which was already present. Updating amount instead", ingredientName, recipeName))
          ingredient.amount = ingredientAmount or 1
        end
      end
      if not alreadyPresent then
        table.insert(data.raw["recipe"][recipeName].ingredients, {
          ["type"] = ingredientType,
          ["name"] = ingredientName,
          ["amount"] = ingredientAmount or 1,
        })
      end
    end

    if data.raw["recipe"][recipeName].normal then
      local alreadyPresent = false
      for _,ingredient in pairs(data.raw["recipe"][recipeName].normal.ingredients) do
        if ingredient.name == ingredientName and
           (ingredient.type or "item") == (ingredientType or "item") then
          alreadyPresent = true
          LSlib.utils.log.log(string.format("WARNING: Tried adding ingredient %q to recipe %q (normal), which was already present. Updating amount instead", ingredientName, recipeName))
          ingredient.amount = ingredientAmount or 1
        end
      end
      if not alreadyPresent then
        table.insert(data.raw["recipe"][recipeName].normal.ingredients, {
          ["type"] = ingredientType,
          ["name"] = ingredientName,
          ["amount"] = ingredientAmount or 1,
        })
      end
    end

    if data.raw["recipe"][recipeName].expensive then
      local alreadyPresent = false
      for _,ingredient in pairs(data.raw["recipe"][recipeName].expensive.ingredients) do
        if ingredient.name == ingredientName and
           (ingredient.type or "item") == (ingredientType or "item") then
          alreadyPresent = true
          LSlib.utils.log.log(string.format("WARNING: Tried adding ingredient %q to recipe %q (expensive), which was already present. Updating amount instead", ingredientName, recipeName))
          ingredient.amount = ingredientAmount or 1
        end
      end
      if not alreadyPresent then
        table.insert(data.raw["recipe"][recipeName].expensive.ingredients, {
          ["type"] = ingredientType,
          ["name"] = ingredientName,
          ["amount"] = ingredientAmount or 1,
        })
      end
    end

  end



  function LSlib.recipe.removeIngredient(recipeName, ingredientName)
    if not data.raw["recipe"][recipeName] then return end
    LSlib.recipe.recipePrototypeCleanup(recipeName)

    if data.raw["recipe"][recipeName].ingredients then
      for index, ingredient in pairs(data.raw["recipe"][recipeName].ingredients) do
        if (ingredient.name and ingredient.name == ingredientName) or (ingredient[1] and ingredient[1] == ingredientName) then
          table.remove(data.raw["recipe"][recipeName].ingredients, index)
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].normal then
      for index, ingredient in pairs(data.raw["recipe"][recipeName].normal.ingredients) do
        if (ingredient.name and ingredient.name == ingredientName) or (ingredient[1] and ingredient[1] == ingredientName) then
          table.remove(data.raw["recipe"][recipeName].normal.ingredients, index)
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].expensive then
      for index, ingredient in pairs(data.raw["recipe"][recipeName].expensive.ingredients) do
        if (ingredient.name and ingredient.name == ingredientName) or (ingredient[1] and ingredient[1] == ingredientName) then
          table.remove(data.raw["recipe"][recipeName].expensive.ingredients, index)
          break
        end
      end
    end

  end



  function LSlib.recipe.editIngredient(recipeName, oldIngredientName, newIngredientName, amountMultiplier)
    if not data.raw["recipe"][recipeName] then return end
    LSlib.recipe.recipePrototypeCleanup(recipeName)

    if data.raw["recipe"][recipeName].ingredients then
      for index, ingredient in pairs(data.raw["recipe"][recipeName].ingredients) do
        if ingredient.name and ingredient.name == oldIngredientName then
          data.raw["recipe"][recipeName].ingredients[index].name = newIngredientName
          data.raw["recipe"][recipeName].ingredients[index].amount = math.floor(.5 + data.raw["recipe"][recipeName].ingredients[index].amount * (amountMultiplier or 1))
          break
        elseif ingredient[1] and ingredient[1] == oldIngredientName then
          data.raw["recipe"][recipeName].ingredients[index][1] = newIngredientName
          data.raw["recipe"][recipeName].ingredients[index][2] = math.floor(.5 + data.raw["recipe"][recipeName].ingredients[index][2] * (amountMultiplier or 1))
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].normal then
      for index, ingredient in pairs(data.raw["recipe"][recipeName].normal.ingredients) do
        if ingredient.name and ingredient.name == oldIngredientName then
          data.raw["recipe"][recipeName].normal.ingredients[index].name = newIngredientName
          data.raw["recipe"][recipeName].normal.ingredients[index].amount = math.floor(.5 + data.raw["recipe"][recipeName].normal.ingredients[index].amount * (amountMultiplier or 1))
          break
        elseif ingredient[1] and ingredient[1] == oldIngredientName then
          data.raw["recipe"][recipeName].normal.ingredients[index][1] = newIngredientName
          data.raw["recipe"][recipeName].normal.ingredients[index][2] = math.floor(.5 + data.raw["recipe"][recipeName].normal.ingredients[index][2] * (amountMultiplier or 1))
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].expensive then
      for index, ingredient in pairs(data.raw["recipe"][recipeName].expensive.ingredients) do
        if ingredient.name and ingredient.name == oldIngredientName then
          data.raw["recipe"][recipeName].expensive.ingredients[index].name = newIngredientName
          data.raw["recipe"][recipeName].expensive.ingredients[index].amount = math.floor(.5 + data.raw["recipe"][recipeName].expensive.ingredients[index].amount * (amountMultiplier or 1))
          break
        elseif ingredient[1] and ingredient[1] == oldIngredientName then
          data.raw["recipe"][recipeName].expensive.ingredients[index][1] = newIngredientName
          data.raw["recipe"][recipeName].expensive.ingredients[index][2] = math.floor(.5 + data.raw["recipe"][recipeName].expensive.ingredients[index][2] * (amountMultiplier or 1))
          break
        end
      end
    end
  end



  function LSlib.recipe.getIngredientsCount(recipeName, countFluidsAsAnIngredient)
    -- countFluidsAsAnIngredient can be nil, defaults to false
    if not data.raw["recipe"][recipeName] then return {0 ,0} end
    LSlib.recipe.recipePrototypeCleanup(recipeName)

    local ingredientsCount = 0
    if data.raw["recipe"][recipeName].ingredients then
      for _,ingredient in pairs(data.raw["recipe"][recipeName].ingredients) do
        if not (countFluidsAsAnIngredient and ingredient.type and ingredient.type == "fluid") then
          ingredientsCount = ingredientsCount + 1
        end
      end
    end

    local ingredientsCounts = nil
    if data.raw["recipe"][recipeName].normal then
      ingredientsCounts = ingredientsCounts or {}
      ingredientsCounts[1] = 0
      for index, ingredient in pairs(data.raw["recipe"][recipeName].normal.ingredients) do
        if not (countFluidsAsAnIngredient and ingredient.type and ingredient.type == "fluid") then
          ingredientsCounts[1] = ingredientsCounts[1] + 1
        end
      end
    end

    if data.raw["recipe"][recipeName].expensive then
      ingredientsCounts = ingredientsCounts or {}
      ingredientsCounts[2] = 0
      for index, ingredient in pairs(data.raw["recipe"][recipeName].expensive.ingredients) do
        if not (countFluidsAsAnIngredient and ingredient.type and ingredient.type == "fluid") then
          ingredientsCounts[2] = ingredientsCounts[2] + 1
        end
      end
    end

    return (ingredientsCounts or {ingredientsCount, ingredientsCount})
  end



  function LSlib.recipe.setEnergyRequired(recipeName, energyRequired)
    if not data.raw["recipe"][recipeName] then return end
    LSlib.recipe.recipePrototypeCleanup(recipeName)

    if data.raw["recipe"][recipeName].ingredients then
      data.raw["recipe"][recipeName].energy_required = energyRequired
    end

    if data.raw["recipe"][recipeName].normal then
      data.raw["recipe"][recipeName].normal.energy_required = energyRequired
    end

    if data.raw["recipe"][recipeName].expensive then
      data.raw["recipe"][recipeName].expensive.energy_required = energyRequired
    end

  end



  function LSlib.recipe.editEnergyRequired(recipeName, amountMultiplier)
    if not data.raw["recipe"][recipeName] then return end
    LSlib.recipe.recipePrototypeCleanup(recipeName)

    if data.raw["recipe"][recipeName].ingredients then
      data.raw["recipe"][recipeName].energy_required = data.raw["recipe"][recipeName].energy_required * amountMultiplier
    end

    if data.raw["recipe"][recipeName].normal then
      data.raw["recipe"][recipeName].normal.energy_required = data.raw["recipe"][recipeName].normal.energy_required * amountMultiplier
    end

    if data.raw["recipe"][recipeName].expensive then
      data.raw["recipe"][recipeName].expensive.energy_required = data.raw["recipe"][recipeName].expensive.energy_required  * amountMultiplier
    end

  end



  function LSlib.recipe.getEnergyRequired(recipeName)
    if not data.raw["recipe"][recipeName] then return end
    LSlib.recipe.recipePrototypeCleanup(recipeName)

    return data.raw["recipe"][recipeName]          .energy_required or
           data.raw["recipe"][recipeName].normal   .energy_required or
           data.raw["recipe"][recipeName].expensive.energy_required
  end



  -- Legacy stuff. Refrain from using it as this might get removed at some point...
  LSlib.recipe.setEngergyRequired = LSlib.recipe.setEnergyRequired
  LSlib.recipe.editEngergyRequired = LSlib.recipe.editEnergyRequired
  LSlib.recipe.getEngergyRequired = LSlib.recipe.getEnergyRequired

end
