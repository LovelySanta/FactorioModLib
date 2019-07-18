
if not LSlib.item then require "item" else

  function LSlib.item.duplicate(itemType, itemName, newItemName)
    if not data.raw[itemType] then return end
    if not data.raw[itemType][itemName] then return end

    local copy = util.table.deepcopy(data.raw[itemType][itemName])
    copy.name = newItemName
    data:extend{copy}
  end

end
