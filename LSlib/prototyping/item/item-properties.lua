
if not LSlib.item then require "item" else

  function LSlib.item.getLocalisedName(itemType, itemName)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    return util.table.deepcopy(data.raw[itemType][itemName].localised_name)
  end

  function LSlib.item.setLocalisedName(itemType, itemName, localeString)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    data.raw[itemType][itemName].localised_name = util.table.deepcopy(localeString)
  end



  function LSlib.item.getSubgroup(itemType, itemName)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    return data.raw[itemType][itemName].subgroup
  end

  function LSlib.item.setSubgroup(itemType, itemName, subgroup)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    data.raw[itemType][itemName].subgroup = subgroup
  end



  function LSlib.item.getOrderstring(itemType, itemName)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    return data.raw[itemType][itemName].order
  end

  function LSlib.item.setOrderstring(itemType, itemName, orderstring)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    data.raw[itemType][itemName].order = orderstring
  end



  function LSlib.item.setHidden(itemType, itemName)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end
    if not data.raw[itemType][itemName].flags then data.raw[itemType][itemName].flags = {} end

    if next(data.raw[itemType][itemName].flags) then
      for _,flag in pairs(data.raw[itemType][itemName].flags) do
        if flag == "hidden" then
          return -- already hidden
        end
      end
    end

    table.insert(data.raw[itemType][itemName].flags, "hidden")
  end



  function LSlib.item.setStackSize(itemType, itemName, stackSize)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    data.raw[itemType][itemName].stack_size = stack_size
  end



  function LSlib.item.editStackSize(itemType, itemName, amountMultiplier)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    data.raw[itemType][itemName].stack_size = data.raw[itemType][itemName].stack_size * amountMultiplier
  end



  function LSlib.item.getFluidColors(fluidName)
    if not data.raw.fluid then return {} end
    if not data.raw.fluid[fluidName] then return {} end
    
    return {
      data.raw.fluid[fluidName].base_color,
      data.raw.fluid[fluidName].flow_color,
    }
  end

end
