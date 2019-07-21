require "util"

if not (LSlib and LSlib.gui and LSlib.gui.layout) then require "layout" else
  if not (LSlib.utils and LSlib.utils.string) then require "utils-table" end

  function LSlib.gui.layout.getElement(layoutTable, elementPath)
    if elementPath == nil then error("elementPath can't be nil.") end
    
    -- obtain the correct parent element out of the layoutTable
    local parentPath = LSlib.utils.string.split(elementPath, "/")
    local parent = layoutTable
    local nextParentFound = false
    for parentIndex = 2, #parentPath, 1 do
      for childIndex, child in pairs(parent["children"]) do
        if (not nextParentFound) and child.name == parentPath[parentIndex] then
          parent = parent["children"][childIndex]
          nextParentFound = true
        end
      end
      nextParentFound = false
    end

    return parent -- this is the desired element now
  end

  function LSlib.gui.layout.getElementPath(layoutTable, elementName)

    --log(serpent.block(layoutTable))
    for _,elementTable in pairs(layoutTable.children) do
      -- iterate over all elements in this layout layoutTable
      if elementTable.name == elementName then
        -- we found the element
        return elementTable.path

      elseif elementTable.children then
        -- children is also a layoutTable, so we check all the children
        local elementPath = LSlib.gui.layout.getElementPath(elementTable, elementName)
        if elementPath then return elementPath end
      end

    end

    -- we looked at this element and all its children, it is not in this layoutTable
    return nil
  end

end
