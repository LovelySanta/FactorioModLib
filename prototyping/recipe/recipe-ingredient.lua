
if not LSlib.recipe then require "recipe" else

  function LSlib.recipe.addIngredient(recipeName, ingredientName, ingredientAmount, ingredientType)
    if not data.raw["recipe"][recipeName] then return end

    if data.raw["recipe"][recipeName].ingredients then
      table.insert(data.raw["recipe"][recipeName].ingredients, {
        ["type"] = ingredientType,
        ["name"] = ingredientName,
        ["amount"] = ingredientAmount
      })
    end

    if data.raw["recipe"][recipeName].normal then
      table.insert(data.raw["recipe"][recipeName].normal.ingredients, {
        ["type"] = ingredientType,
        ["name"] = ingredientName,
        ["amount"] = ingredientAmount
      })
    end

    if data.raw["recipe"][recipeName].expensive then
      table.insert(data.raw["recipe"][recipeName].expensive.ingredients, {
        ["type"] = ingredientType,
        ["name"] = ingredientName,
        ["amount"] = ingredientAmount
      })
    end

  end



  function LSlib.recipe.removeIngredient(recipeName, ingredientName)
    if not data.raw["recipe"][recipeName] then return end

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

    if data.raw["recipe"][recipeName].ingredients then
      for index, ingredient in pairs(data.raw["recipe"][recipeName].ingredients) do
        if ingredient.name and ingredient.name == oldIngredientName then
          data.raw["recipe"][recipeName].ingredients[index].name = newIngredientName
          data.raw["recipe"][recipeName].ingredients[index].amount = math.floor(.5 + data.raw["recipe"][recipeName].ingredients[index].amount * amountMultiplier)
          break
        elseif ingredient[1] and ingredient[1] == oldIngredientName then
          data.raw["recipe"][recipeName].ingredients[index][1] = newIngredientName
          data.raw["recipe"][recipeName].ingredients[index][2] = math.floor(.5 + data.raw["recipe"][recipeName].ingredients[index][2] * amountMultiplier)
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].normal then
      for index, ingredient in pairs(data.raw["recipe"][recipeName].normal.ingredients) do
        if ingredient.name and ingredient.name == oldIngredientName then
          data.raw["recipe"][recipeName].normal.ingredients[index].name = newIngredientName
          data.raw["recipe"][recipeName].normal.ingredients[index].amount = math.floor(.5 + data.raw["recipe"][recipeName].normal.ingredients[index].amount * amountMultiplier)
          break
        elseif ingredient[1] and ingredient[1] == oldIngredientName then
          data.raw["recipe"][recipeName].normal.ingredients[index][1] = newIngredientName
          data.raw["recipe"][recipeName].normal.ingredients[index][2] = math.floor(.5 + data.raw["recipe"][recipeName].normal.ingredients[index][2] * amountMultiplier)
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].expensive then
      for index, ingredient in pairs(data.raw["recipe"][recipeName].expensive.ingredients) do
        if ingredient.name and ingredient.name == oldIngredientName then
          data.raw["recipe"][recipeName].expensive.ingredients[index].name = newIngredientName
          data.raw["recipe"][recipeName].expensive.ingredients[index].amount = math.floor(.5 + data.raw["recipe"][recipeName].expensive.ingredients[index].amount * amountMultiplier)
          break
        elseif ingredient[1] and ingredient[1] == oldIngredientName then
          data.raw["recipe"][recipeName].expensive.ingredients[index][1] = newIngredientName
          data.raw["recipe"][recipeName].expensive.ingredients[index][2] = math.floor(.5 + data.raw["recipe"][recipeName].expensive.ingredients[index][2] * amountMultiplier)
          break
        end
      end
    end
  end



  function LSlib.recipe.setEngergyRequired(recipeName, energyRequired)
    if not data.raw["recipe"][recipeName] then return end

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



  function LSlib.recipe.editEngergyRequired(recipeName, amountMultiplier)
    if not data.raw["recipe"][recipeName] then return end

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



  function LSlib.recipe.getEngergyRequired(recipeName)
    if not data.raw["recipe"][recipeName] then return end

    return data.raw["recipe"][recipeName]          .energy_required or
           data.raw["recipe"][recipeName].normal   .energy_required or
           data.raw["recipe"][recipeName].expensive.energy_required
  end

end
