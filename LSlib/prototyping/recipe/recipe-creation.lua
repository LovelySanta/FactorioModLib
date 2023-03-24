
if not LSlib.recipe then require "recipe" else

  function LSlib.recipe.create(recipeName)
    data:extend{{
      type = "recipe",
      name = recipeName,
      ingredients = {},
      results = {}
    }}
  end



  function LSlib.recipe.duplicate(recipeName, newRecipeName)
    if not data.raw["recipe"][recipeName] then
      return LSlib.recipe.create(newRecipeName)
    end
    LSlib.recipe.recipePrototypeCleanup(recipeName)

    local copy = util.table.deepcopy(data.raw["recipe"][recipeName])
    copy.name = newRecipeName
    data:extend{copy}
  end



  function LSlib.recipe.recipePrototypeCleanup(recipeName)
    -- cleans the normal/expensive part of a recipe
    if not data.raw["recipe"][recipeName] then return end

    local recipe = util.table.deepcopy(data.raw["recipe"][recipeName])
    local recipeDefined = {
      normal = (LSlib.utils.table.isTable(recipe.normal) or recipe.normal == false) and true or false,
      expensive = (LSlib.utils.table.isTable(recipe.expensive) or recipe.expensive == false) and true or false
    }

    local function setProperty(propertyName, propertyDefault)
      if recipeDefined.normal and recipeDefined.expensive then -- use normal/expensive declaration
        if LSlib.utils.table.isTable(recipe.normal) then
          if recipe.normal[propertyName] ~= nil then
            data.raw["recipe"][recipeName].normal[propertyName] = recipe.normal[propertyName]
          elseif recipe[propertyName] ~= nil then
            data.raw["recipe"][recipeName].normal[propertyName] = recipe[propertyName]
          else
            data.raw["recipe"][recipeName].normal[propertyName] = propertyDefault
          end
          --data.raw["recipe"][recipeName].normal[propertyName] = recipe.normal[propertyName] or recipe[propertyName] or propertyDefault
        end
        if LSlib.utils.table.isTable(recipe.expensive) then
          if recipe.expensive[propertyName] ~= nil then
            data.raw["recipe"][recipeName].expensive[propertyName] = recipe.expensive[propertyName]
          elseif recipe[propertyName] ~= nil then
            data.raw["recipe"][recipeName].expensive[propertyName] = recipe[propertyName]
          else
            data.raw["recipe"][recipeName].expensive[propertyName] = propertyDefault
          end
        end
        data.raw["recipe"][recipeName][propertyName] = nil

      else -- use default declaration as there is no need for normal/expensive
        if LSlib.utils.table.isTable(recipe.normal) then
          if recipe.normal[propertyName] ~= nil then
            data.raw["recipe"][recipeName][propertyName] = recipe.normal[propertyName]
          elseif recipe[propertyName] ~= nil then
            data.raw["recipe"][recipeName][propertyName] = recipe[propertyName]
          else
            data.raw["recipe"][recipeName][propertyName] = propertyDefault
          end
          data.raw["recipe"][recipeName].normal[propertyName] = nil
        end
        if LSlib.utils.table.isTable(recipe.expensive) then
          if recipe.normal[propertyName] ~= nil then
            data.raw["recipe"][recipeName][propertyName] = recipe.expensive[propertyName]
          elseif recipe[propertyName] ~= nil then
            data.raw["recipe"][recipeName][propertyName] = recipe[propertyName]
          else
            data.raw["recipe"][recipeName][propertyName] = propertyDefault
          end
          data.raw["recipe"][recipeName].expensive[propertyName] = nil
        end
      end
    end

    for _, recipeDataProperty in pairs{
      "ingredients", "energy_required", "emissions_multiplier", "enabled",
      "result", "result_count", "results", "main_product", "always_show_products",
      "requester_paste_multiplier",
      "overload_multiplier", "show_amount_in_title",
      "hidden", "hide_from_stats", "hide_from_player_crafting",
      "allow_decomposition", "always_show_made_in",
      "allow_as_intermediate", "allow_intermediates",
    } do
      setProperty(recipeDataProperty)
    end

    if LSlib.utils.table.isTable(data.raw["recipe"][recipeName].normal) and
      LSlib.utils.table.isEmpty(data.raw["recipe"][recipeName].normal) then
      data.raw["recipe"][recipeName].normal = nil
    end
    if LSlib.utils.table.isTable(data.raw["recipe"][recipeName].expensive) and
      LSlib.utils.table.isEmpty(data.raw["recipe"][recipeName].normal) then
      data.raw["recipe"][recipeName].expensive = nil
    end

    -- cleans the ingredients/products list of a recipe
    for _, propertyList in pairs{"ingredients", "results"} do
      if data.raw["recipe"][recipeName][propertyList] then
        for i, property in pairs(data.raw["recipe"][recipeName][propertyList]) do
          data.raw["recipe"][recipeName][propertyList][i] = {
            name = property["name"] or property[1],
            amount = property["amount"] or property[2] or 1,
            type = property["type"] or "item",
          }
        end
      end
      if data.raw["recipe"][recipeName].normal and data.raw["recipe"][recipeName].normal[propertyList] then
        for i, property in pairs(data.raw["recipe"][recipeName].normal[propertyList]) do
          data.raw["recipe"][recipeName].normal[propertyList][i] = {
            name = property["name"] or property[1],
            amount = property["amount"] or property[2] or 1,
            type = property["type"] or "item",
          }
        end
      end
      if data.raw["recipe"][recipeName].expensive and data.raw["recipe"][recipeName].expensive[propertyList] then
        for i, property in pairs(data.raw["recipe"][recipeName].expensive[propertyList]) do
          data.raw["recipe"][recipeName].expensive[propertyList][i] = {
            name = property["name"] or property[1],
            amount = property["amount"] or property[2] or 1,
            type = property["type"] or "item",
          }
        end
      end
    end

  end

end
