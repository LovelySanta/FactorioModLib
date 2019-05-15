
if not (LSlib and LSlib.gui) then require "gui" else

  function LSlib.gui.getElement(playerIndex, elementPath)
    local guielementPath = LSlib.utils.string.split(elementPath, "/")
    local guiElement = game.players[playerIndex].gui[LSlib.utils.string.split(LSlib.utils.string.split(guielementPath[1], "(")[2], ")")[1]]
    for pathIndex = 2, #guielementPath, 1 do
      if not guiElement then return nil end
      guiElement = guiElement[guielementPath[pathIndex]]
    end
    return guiElement
  end

end
