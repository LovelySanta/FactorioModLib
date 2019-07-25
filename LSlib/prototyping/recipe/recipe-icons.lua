
if not LSlib.recipe then require "recipe" else

  function LSlib.recipe.getIcons(recipeName, layerScale, layerShift, layerTint)
    return LSlib.item.getIcons("recipe", recipeName, layerScale, layerShift, layerTint)
  end



  function LSlib.recipe.getIconSize(recipeName)
    return LSlib.item.getIconSize("recipe", recipeName)
  end



  function LSlib.recipe.changeIcon(recipeName, newIconFile, newIconSize)
    LSlib.item.changeIcon("recipe", recipeName, newIconFile, newIconSize)
  end



  function LSlib.recipe.changeIcons(recipeName, newIcons, newIconSize)
    LSlib.item.changeIcons("recipe", recipeName, newIcons, newIconSize)
  end



  function LSlib.recipe.addIconTint(recipeName, tint)
    LSlib.item.addIconTint("recipe", recipeName, tint)
  end

end
