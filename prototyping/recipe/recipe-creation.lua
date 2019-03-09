
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
      LSlib.recipe.create(newRecipeName)
    end

    local copy = util.table.deepcopy(data.raw["recipe"][recipeName])
    copy.name = newRecipeName
    data:extend{copy}
  end

end
