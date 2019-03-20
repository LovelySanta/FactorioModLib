require "util"

if not (LSlib and LSlib.gui and LSlib.gui.layout) then require "layout" else
  if not (LSlib.utils and LSlib.utils.string) then require "utils-string" end

  function LSlib.gui.layout.create(rootElement)
    if not(rootElement == "top"    or
           rootElement == "left"   or
           rootElement == "center" or
           rootElement == "goal"   ) then
      rootElement = "center"
    end

    return {
      ["path"    ] = "root",
      ["name"    ] = rootElement,
      ["children"] = {nil}      ,
    }
  end

  function LSlib.gui.layout.addElement(layoutTable, parentPath, childProperties)
    -- obtain the correct parent element out of the layoutTable
    parentPath = LSlib.utils.string.split(parentPath, "/")
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

    table.insert(parent.children, util.table.deepcopy(childProperties))
    local childIndex = #parent.children
    local childPath = parent.path .. "/" .. childProperties.name
    parent.children[childIndex]["path"    ] = childPath
    parent.children[childIndex]["children"] = {nil}

    return childPath
  end


end
