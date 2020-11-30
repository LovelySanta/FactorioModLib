require "util"

if not (LSlib and LSlib.gui and LSlib.gui.layout) then require "layout" else
  if not (LSlib.utils and LSlib.utils.string) then require "utils-string" end
  require "layout-properties"

  function LSlib.gui.layout.create(rootElement)
    if not(rootElement == "top"      or
           rootElement == "left"     or
           rootElement == "center"   or
           rootElement == "relative" or
           rootElement == "screen"   or
           rootElement == "goal"     ) then
      rootElement = "center"
    end

    return {
      ["path"    ] = string.format("root(%s)", rootElement),
      ["name"    ] = rootElement,
      ["children"] = {nil}      ,
    }
  end

  function LSlib.gui.layout.addElement(layoutTable, parentPath, childProperties)
    -- obtain the correct parent element out of the layoutTable
    parent = LSlib.gui.layout.getElement(layoutTable, parentPath)

    table.insert(parent.children, util.table.deepcopy(childProperties))
    local childIndex = #parent.children
    local childPath = parent.path .. "/" .. childProperties.name
    parent.children[childIndex]["path"    ] = childPath
    parent.children[childIndex]["children"] = {nil}

    return childPath
  end


end
