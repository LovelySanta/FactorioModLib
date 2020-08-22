
if not LSlib.item then require "item" else

  function LSlib.item.getAllModuleNames(limitationOnly)
    local moduleNames = {}
    for moduleName, moduleData in pairs(data.raw["module"] or {}) do
      if (not limitationOnly) or next(moduleData.limitation or {}) then
        table.insert(moduleNames, moduleName)
      end
    end
    return moduleNames
  end

end
