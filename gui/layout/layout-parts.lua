require "util"

if not (LSlib and LSlib.gui and LSlib.gui.layout) then require "layout" else
  require "layout-elements"

  function LSlib.gui.layout.addTabs(layoutTable, parentPath, tabName, tabPages, tabOptions)

    -- frame for the tab
    local tabFrame = LSlib.gui.layout.addFrame(layoutTable, parentPath, tabName, "vertical", {
      style = tabOptions.tabInsideFrameStyle or "inside_deep_frame_for_tabs",
    })
    --local tabFrame = LSlib.gui.layout.addFlow(layoutTable, tabFrame, tabName.."-flow", "vertical", {
    --  style = "packed_vertical_flow",
    --})

    -- tab button flow
    local tabButtonFlow  = LSlib.gui.layout.addFlow(layoutTable, tabFrame, tabName.."-buttons", "horizontal", {
      style = tabOptions.buttonFlowStyle,
    })
    -- content flows
    local tabContentFrame = LSlib.gui.layout.addFrame(layoutTable, tabFrame, tabName.."-content", "vertical", {
      style = tabOptions.tabContentFrameStyle,
    })

    -- adding tab buttons to the tab button flow and content frame
    for _,tabPage in pairs(tabPages or {}) do
      LSlib.gui.layout.addButton(layoutTable, tabButtonFlow , tabName..tabPage.name, {
        caption = tabPage.caption,
        style   = tabPage.style
      })
      if not (tabPage.enabled == false) then
        LSlib.gui.layout.addFlow(layoutTable, tabContentFrame, tabName..tabPage.name, "vertical")
      end
    end

    return tabContentFrame
  end

  function LSlib.gui.layout.getTabContentFrameFlow(layoutTable, tabContentPath, tabIndex)
    local tabContentFrame = LSlib.gui.layout.getElement(layoutTable, tabContentPath).children
    if not tabContentFrame then return end

    return tabContentFrame[tabIndex].path
  end

end
