require "util"

if not (LSlib and LSlib.gui and LSlib.gui.layout) then require "layout" else
  require "layout-creation"

  function LSlib.gui.layout.addFrame(layoutTable, parentPath, frameName, frameDirection, frameOptions)
    frameOptions = frameOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "frame"                            ,
      name                   = frameName                          ,
      direction              = frameDirection                     ,
      -- optional options specified in table (or nil)
      caption                = frameOptions.caption               ,
      style                  = frameOptions.style                 ,
      ignored_by_interaction = frameOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addFlow(layoutTable, parentPath, flowName, flowDirection, flowOptions)
    flowOptions = flowOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "flow"                            ,
      name                   = flowName                          ,
      direction              = flowDirection                     ,
      -- optional options specified in table (or nil)
      style                  = flowOptions.style                 ,
      ignored_by_interaction = flowOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addButton(layoutTable, parentPath, buttonName, buttonOptions)
    buttonOptions = buttonOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "button"                            ,
      name                   = buttonName                          ,
      -- optional options specified in table (or nil)
      caption                = buttonOptions.caption               ,
      tooltip                = buttonOptions.tooltip               ,
      style                  = buttonOptions.style                 ,
      enabled                = buttonOptions.enabled               ,
      ignored_by_interaction = buttonOptions.ignored_by_interaction,
      mouse_button_filter    = buttonOptions.mouse_button_filter   ,
    })
  end
end
