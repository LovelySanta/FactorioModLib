
if not (LSlib and LSlib.gui) then require "gui" else

  function LSlib.gui.getRootName(layoutTable)
    -- returns the name of the guiElement of the base game (center, top, ...)
    return layoutTable.name
  end

  function LSlib.gui.getRootElementName(layoutTable)
    -- returns the name of the base parent element
    local _,child = next(layoutTable.children or {})
    return (child and child.name or "unknownRootElementName")
  end

end
