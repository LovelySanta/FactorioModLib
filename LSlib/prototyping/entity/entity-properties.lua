
if not LSlib.entity then require "entity" else

  function LSlib.entity.getLocalisedName(entityType, entityName)
    if not data.raw[entityType] then return end
    if not data.raw[entityType][entityName] then return end

    return LSlib.item.getLocalisedName(entityType, entityName)
  end



  function LSlib.entity.setLocalisedName(entityType, entityName, localeString)
    LSlib.item.setLocalisedName(entityType, entityName, localeString)
  end



  function LSlib.entity.addCraftingCategory(entityType, entityName, craftingCategory)
    if not data.raw[entityType][entityName].crafting_categories then
      data.raw[entityType][entityName].crafting_categories = {}
    end

    table.insert(data.raw[entityType][entityName].crafting_categories, craftingCategory)
  end

end
