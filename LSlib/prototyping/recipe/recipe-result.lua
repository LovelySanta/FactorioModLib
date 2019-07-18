
if not LSlib.recipe then require "recipe" else

  function LSlib.recipe.addResult(recipeName, resultName, resultAmount, resultType)
    if not data.raw["recipe"][recipeName] then return end

    if data.raw["recipe"][recipeName].result then
      data.raw["recipe"][recipeName].results = {{
        ["name"] = data.raw["recipe"][recipeName].result,
        ["amount"] = data.raw["recipe"][recipeName].result_count or 1,
      }}
      data.raw["recipe"][recipeName].result = nil
      data.raw["recipe"][recipeName].result_count = nil
    end

    if data.raw["recipe"][recipeName].results then
      local alreadyPresent = false
      for _, result in pairs(data.raw["recipe"][recipeName].results) do
        if result.name == resultName then
          result.amount = result.amount + resultAmount
          LSlib.utils.log.log(string.format("WARNING: Tried adding result %q to recipe %q which was already present, increasing count instead.", resultName, recipeName))
          alreadyPresent = true
          break
        end
      end
      if not alreadyPresent then
        table.insert(data.raw["recipe"][recipeName].results, {
          ["type"] = resultType,
          ["name"] = resultName,
          ["amount"] = resultAmount,
        })
      end
    end

    if data.raw["recipe"][recipeName].normal then
      if data.raw["recipe"][recipeName].normal.result then
        data.raw["recipe"][recipeName].normal.results = {{
          ["name"] = data.raw["recipe"][recipeName].normal.result,
          ["amount"] = data.raw["recipe"][recipeName].normal.result_count or 1,
        }}
        data.raw["recipe"][recipeName].normal.result = nil
        data.raw["recipe"][recipeName].normal.result_count = nil
      end

      if data.raw["recipe"][recipeName].normal.results then
        local alreadyPresent = false
        for _, result in pairs(data.raw["recipe"][recipeName].normal.results) do
          if result.name == resultName then
            result.amount = result.amount + resultAmount
            LSlib.utils.log.log(string.format("WARNING: Tried adding result %q to recipe %q which was already present, increasing count instead.", resultName, recipeName))
            alreadyPresent = true
            break
          end
        end
        if not alreadyPresent then
          table.insert(data.raw["recipe"][recipeName].normal.results, {
            ["type"] = resultType,
            ["name"] = resultName,
            ["amount"] = resultAmount,
          })
        end
      end
    end

    if data.raw["recipe"][recipeName].expensive then
      if data.raw["recipe"][recipeName].expensive.result then
        data.raw["recipe"][recipeName].expensive.results = {{
          ["name"] = data.raw["recipe"][recipeName].expensive.result,
          ["amount"] = data.raw["recipe"][recipeName].expensive.result_count or 1,
        }}
        data.raw["recipe"][recipeName].expensive.result = nil
        data.raw["recipe"][recipeName].expensive.result_count = nil
      end

      if data.raw["recipe"][recipeName].expensive.results then
        local alreadyPresent = false
        for _, result in pairs(data.raw["recipe"][recipeName].expensive.results) do
          if result.name == resultName then
            result.amount = result.amount + resultAmount
            LSlib.utils.log.log(string.format("WARNING: Tried adding result %q to recipe %q which was already present, increasing count instead.", resultName, recipeName))
            alreadyPresent = true
            break
          end
        end
        if not alreadyPresent then
          table.insert(data.raw["recipe"][recipeName].expensive.results, {
            ["type"] = resultType,
            ["name"] = resultName,
            ["amount"] = resultAmount,
          })
        end
      end
    end

  end



  function LSlib.recipe.editResult(recipeName, oldResultName, newResultName, amountMultiplier)
    if not data.raw["recipe"][recipeName] then return end

    if data.raw["recipe"][recipeName].result and data.raw["recipe"][recipeName].result == oldResultName then
      data.raw["recipe"][recipeName].result = newResultName
      data.raw["recipe"][recipeName].result_count = (data.raw["recipe"][recipeName].result_count or 1) * amountMultiplier
    end

    if data.raw["recipe"][recipeName].results then
      for index, result in pairs(data.raw["recipe"][recipeName].results) do
        if result.name == oldResultName then
          result.name = newResultName

          if result.amount then
            result.amount = result.amount * amountMultiplier
          end
          if result.amount_min then
            result.amount_min = result.amount_min * amountMultiplier
          end
          if result.amount_max then
            result.amount_max = result.amount_max * amountMultiplier
          end

          break
        end
      end
    end

    if data.raw["recipe"][recipeName].normal then
      if data.raw["recipe"][recipeName].normal.results then
        for index, result in pairs(data.raw["recipe"][recipeName].normal.results) do
          if result.name == oldResultName then
            result.name = newResultName

            if result.amount then
              result.amount = result.amount * amountMultiplier
            end
            if result.amount_min then
              result.amount_min = result.amount_min * amountMultiplier
            end
            if result.amount_max then
              result.amount_max = result.amount_max * amountMultiplier
            end

            break
          end
        end
      end
    end

    if data.raw["recipe"][recipeName].expensive then
      if data.raw["recipe"][recipeName].expensive.results then
        for index, result in pairs(data.raw["recipe"][recipeName].expensive.results) do
          if result.name == oldResultName then
            result.name = newResultName

            if result.amount then
              result.amount = result.amount * amountMultiplier
            end
            if result.amount_min then
              result.amount_min = result.amount_min * amountMultiplier
            end
            if result.amount_max then
              result.amount_max = result.amount_max * amountMultiplier
            end

            break
          end
        end
      end
    end

  end



  function LSlib.recipe.getResultCount(recipeName, resultName)
    if not data.raw["recipe"][recipeName] then return end

    if data.raw["recipe"][recipeName].result then
      return data.raw["recipe"][recipeName].result_count or 1
    elseif data.raw["recipe"][recipeName].results then
      for resultIndex, result in pairs(data.raw["recipe"][recipeName].results) do
        return data.raw["recipe"][recipeName].results[resultIndex].amount or 1
      end

    elseif data.raw["recipe"][recipeName].normal then
      if data.raw["recipe"][recipeName].normal.result then
        return data.raw["recipe"][recipeName].normal.result_count or 1
      elseif data.raw["recipe"][recipeName].normal.results then
        for resultIndex, result in pairs(data.raw["recipe"][recipeName].normal.results) do
          return data.raw["recipe"][recipeName].normal.results[resultIndex].amount or 1
        end
      end

    elseif data.raw["recipe"][recipeName].expensive then
      if data.raw["recipe"][recipeName].expensive.result then
        return data.raw["recipe"][recipeName].expensive.result_count or 1
      elseif data.raw["recipe"][recipeName].expensive.results then
        for resultIndex, result in pairs(data.raw["recipe"][recipeName].expensive.results) do
          return data.raw["recipe"][recipeName].expensive.results[resultIndex].amount or 1
        end
      end
    end
  end



  function LSlib.recipe.setResultCount(recipeName, resultName, resultAmount)
    if not data.raw["recipe"][recipeName] then return end

    if data.raw["recipe"][recipeName].result then
      data.raw["recipe"][recipeName].result_count = resultAmount
    end

    if data.raw["recipe"][recipeName].results then
      for index, result in pairs(data.raw["recipe"][recipeName].results) do
        if result.name == resultName then
          result.amount = resultAmount
          result.amount_min = nil
          result.amount_max = nil
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].normal then
      if data.raw["recipe"][recipeName].normal.results then
        for index, result in pairs(data.raw["recipe"][recipeName].normal.results) do
          if result.name == resultName then
            result.amount = resultAmount
            result.amount_min = nil
            result.amount_max = nil
            break
          end
        end
      end
    end

    if data.raw["recipe"][recipeName].expensive then
      if data.raw["recipe"][recipeName].expensive.results then
        for index, result in pairs(data.raw["recipe"][recipeName].expensive.results) do
          if result.name == resultName then
            result.amount = resultAmount
            result.amount_min = nil
            result.amount_max = nil
            break
          end
        end
      end
    end

  end



  function LSlib.recipe.setResultProbability(recipeName, resultName, resultProbability)
    if not data.raw["recipe"][recipeName] then return end

    resultProbability = ((resultProbability~=1) and resultProbability)

    if data.raw["recipe"][recipeName].result then
      data.raw["recipe"][recipeName].results = {{
        name = data.raw["recipe"][recipeName].result,
        amount = data.raw["recipe"][recipeName].result_count or 1,
      }}
      data.raw["recipe"][recipeName].result = nil
      data.raw["recipe"][recipeName].result_count = nil
    end

    if data.raw["recipe"][recipeName].results then
      for index, result in pairs(data.raw["recipe"][recipeName].results) do
        if result.name == resultName then
          result.probability = resultProbability
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].normal then
      if data.raw["recipe"][recipeName].normal.result then
        data.raw["recipe"][recipeName].normal.results = {{
          name = data.raw["recipe"][recipeName].normal.result,
          amount = data.raw["recipe"][recipeName].normal.result_count or 1,
        }}
        data.raw["recipe"][recipeName].normal.result = nil
        data.raw["recipe"][recipeName].normal.result_count = nil
      end

      if data.raw["recipe"][recipeName].normal.results then
        for index, result in pairs(data.raw["recipe"][recipeName].normal.results) do
          if result.name == resultName then
            result.probability = resultProbability
            break
          end
        end
      end
    end

    if data.raw["recipe"][recipeName].expensive then
      if data.raw["recipe"][recipeName].expensive.result then
        data.raw["recipe"][recipeName].expensive.results = {{
          name = data.raw["recipe"][recipeName].expensive.result,
          amount = data.raw["recipe"][recipeName].expensive.result_count or 1,
        }}
        data.raw["recipe"][recipeName].expensive.result = nil
        data.raw["recipe"][recipeName].expensive.result_count = nil
      end

      if data.raw["recipe"][recipeName].expensive.results then
        for index, result in pairs(data.raw["recipe"][recipeName].expensive.results) do
          if result.name == resultName then
            result.probability = resultProbability
            break
          end
        end
      end
    end

  end



  function LSlib.recipe.setMainResult(recipeName, mainResultName)
    if not data.raw["recipe"][recipeName] then return end
    LSlib.recipe.recipePrototypeCleanup(recipeName)

    if data.raw["recipe"][recipeName].results then
      for index, result in pairs(data.raw["recipe"][recipeName].results) do
        if result.name == mainResultName then
          data.raw["recipe"][recipeName].main_product = mainResultName
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].normal and data.raw["recipe"][recipeName].normal.results then
      for index, result in pairs(data.raw["recipe"][recipeName].normal.results) do
        if result.name == mainResultName then
          data.raw["recipe"][recipeName].normal.main_product = mainResultName
          break
        end
      end
    end

    if data.raw["recipe"][recipeName].expensive and data.raw["recipe"][recipeName].expensive.results then
      for index, result in pairs(data.raw["recipe"][recipeName].expensive.results) do
        if result.name == mainResultName then
          data.raw["recipe"][recipeName].expensive.main_product = mainResultName
          break
        end
      end
    end

  end

end
