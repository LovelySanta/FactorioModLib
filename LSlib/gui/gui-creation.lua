
if not (LSlib and LSlib.gui) then require "gui" else
  if not (LSlib.utils and LSlib.utils.table) then require "utils-table" end

  function LSlib.gui.create(playerIndex, layoutTable)

    --log(serpent.block(layoutTable))
    local root = game.players[playerIndex].gui[layoutTable.name]
    LSlib.gui.addChildren(root, layoutTable.children)
    return nil
  end

  function LSlib.gui.addChildren(parentElement, childrenLayoutTable)

    for childIndex, child in pairs(childrenLayoutTable) do
      log(serpent.block(child.name))
      local childElementTable = {} -- create argument list for this element
      for childElementIndex, childElement in pairs(child) do
        if elementIndex ~= "children" then
          childElementTable[childElementIndex] = childElement
        end
      end

      log(serpent.block(childElementTable))
      local childElement = parentElement.add(childElementTable) -- add child

      if not LSlib.utils.table.isEmpty(child.children) then
        -- recursive call for children of child element
        LSlib.gui.addChildren(childElement, child.children)
      end
    end
  end

end
