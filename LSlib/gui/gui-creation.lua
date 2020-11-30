
if not (LSlib and LSlib.gui) then require "gui" else
  if not (LSlib.utils and LSlib.utils.table) then require "utils-table" end

  function LSlib.gui.create(playerIndex, layoutTable)

    --log(serpent.block(layoutTable))
    local root = game.players[playerIndex].gui[layoutTable.name]
    LSlib.gui.addChildren(root, layoutTable.children)

    if layoutTable.name == "screen" then
      root[LSlib.gui.getRootElementName(layoutTable)].force_auto_center()
    end

    -- return reference to first child added to the root
    return root[LSlib.gui.getRootElementName(layoutTable)]
  end

  function LSlib.gui.destroy(playerIndex, layoutTable)

    --log(serpent.block(layoutTable))
    local root = game.players[playerIndex].gui[layoutTable.name]

      for childIndex, child in pairs(layoutTable.children or {}) do
        local child = root[child.name]
        if child then child.destroy() end
      end

    return nil
  end

  function LSlib.gui.addChildren(parentElement, childrenLayoutTable)
    for childIndex, child in pairs(childrenLayoutTable or {}) do
      local childElementTable = {} -- create argument list for this element
      for childElementIndex, childElement in pairs(child) do
        if elementIndex ~= "children" then
          childElementTable[childElementIndex] = childElement
        end
      end

      if parentElement[childElementTable.name] then
        game.players[parentElement.player_index].print(
          string.format("LSlib error: LuaGuiElement %q already has a child named %q.",
            parentElement.name, childElementTable.name
          )
        )
        return -- not creating child and children of this child
      end
      
      local childElement = parentElement.add(childElementTable) -- add child
      if childElementTable.drag_target then
        childElement.drag_target = LSlib.gui.getElement(parentElement.player_index, childElementTable.drag_target)
      end

      if childElementTable.visible == false or
         childElementTable.hidden  == true  then
        --game.print(string.format("hiding element %q", childElement.name))
        childElement.visible = false
      end

      if childElement and (not LSlib.utils.table.isEmpty(child.children)) then
        -- recursive call for children of child element
        LSlib.gui.addChildren(childElement, child.children)
      end
    end
  end

end
