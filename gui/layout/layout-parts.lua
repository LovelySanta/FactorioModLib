require "util"

if not (LSlib and LSlib.gui and LSlib.gui.layout) then require "layout" else
  require "layout-elements"

  function LSlib.gui.layout.addTabs(layoutTable, parentPath, tabName, tabPages, tabOptions)

    -- frame for the tab
    local tabFrame = LSlib.gui.layout.addFrame(layoutTable, parentPath, tabName, "vertical")

    -- tab button flow
    local tabButtonFlow  = LSlib.gui.layout.addFlow(layoutTable, tabFrame, tabName.."buttons", "horizontal", {
      style = tabOptions.buttonFlowStyle,
    })
    -- adding tab buttons to the tab button flow
    for _,tabPage in pairs(tabPages or {}) do
      LSlib.gui.layout.addButton(layoutTable, tabButtonFlow , tabName..tabPage.name, {
        caption = tabPage.caption,
        style   = tabPage.style
      })
      if tabPage.enabled then
        LSlib.gui.layout.addFrame (layoutTable, tabContentFlow, tabName..tabPage.name, "vertical")
      end
    end

    -- tab content flow
    local tabContentFlow = LSlib.gui.layout.addFlow(layoutTable, tabFrame, tabName.."content", "vertical"  )

    return tabContentFlow
  end

end
