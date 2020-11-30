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

      visible                = frameOptions.visible               ,
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
      visible                = flowOptions.visible               ,
      style                  = flowOptions.style                 ,
      ignored_by_interaction = flowOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addScrollPane(layoutTable, parentPath, scrollPaneName, scrollPaneOptions)
    scrollPaneOptions = scrollPaneOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                     = "scroll-pane"                             ,
      name                     = scrollPaneName                            ,

      -- optional options specified in table (or nil)

      horizontal_scroll_policy = scrollPaneOptions.horizontal_scroll_policy,
      vertical_scroll_policy   = scrollPaneOptions.vertical_scroll_policy  ,

      visible                  = scrollPaneOptions.visible                 ,
      style                    = scrollPaneOptions.style                   ,
      ignored_by_interaction   = scrollPaneOptions.ignored_by_interaction  ,
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
      mouse_button_filter    = buttonOptions.mouse_button_filter   ,

      visible                = buttonOptions.visible               ,
      style                  = buttonOptions.style                 ,
      enabled                = buttonOptions.enabled               ,
      ignored_by_interaction = buttonOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addSpriteButton(layoutTable, parentPath, spriteButtonName, spriteButtonOptions)
    spriteButtonOptions = spriteButtonOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                           = "sprite-button"                                   ,
      name                           = spriteButtonName                                  ,

      -- optional options specified in table (or nil)
      caption                        = spriteButtonOptions.caption                       ,
      tooltip                        = spriteButtonOptions.tooltip                       ,

      sprite                         = spriteButtonOptions.sprite                        ,
      hovered_sprite                 = spriteButtonOptions.hovered_sprite                ,
      clicked_sprite                 = spriteButtonOptions.clicked_sprite                ,

      number                         = spriteButtonOptions.number                        ,
      show_percent_for_small_numbers = spriteButtonOptions.show_percent_for_small_numbers,
      mouse_button_filter            = spriteButtonOptions.mouse_button_filter           ,

      visible                        = spriteButtonOptions.visible                       ,
      style                          = spriteButtonOptions.style                         ,
      enabled                        = spriteButtonOptions.enabled                       ,
      ignored_by_interaction         = spriteButtonOptions.ignored_by_interaction        ,
    })
  end

  function LSlib.gui.layout.addLabel(layoutTable, parentPath, labelName, labelOptions)
    labelOptions = labelOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "label"                            ,
      name                   = labelName                          ,

      -- optional options specified in table (or nil)
      caption                = labelOptions.caption               ,
      tooltip                = labelOptions.tooltip               ,

      style                  = labelOptions.style                 ,
      visible                = labelOptions.visible               ,
      enabled                = labelOptions.enabled               ,
      ignored_by_interaction = labelOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addTextfield(layoutTable, parentPath, textfieldName, textfieldOptions)
    textfieldOptions = textfieldOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "textfield"                            ,
      name                   = textfieldName                          ,

      -- optional options specified in table (or nil)
      text                   = textfieldOptions.text                  ,
      tooltip                = textfieldOptions.tooltip               ,

      numeric                = textfieldOptions.numeric               ,
      allow_decimal          = textfieldOptions.allow_decimal         ,
      is_password            = textfieldOptions.is_password           ,

      style                  = textfieldOptions.style                 ,
      visible                = textfieldOptions.visible               ,
      enabled                = textfieldOptions.enabled               ,
      ignored_by_interaction = textfieldOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addListbox(layoutTable, parentPath, listboxName, listboxOptions)
    listboxOptions = listboxOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "list-box"                           ,
      name                   = listboxName                          ,
      -- optional options specified in table (or nil)
      items                  = listboxOptions.items                 ,
      selected_index         = listboxOptions.selected_index        ,

      style                  = listboxOptions.style                 ,
      visible                = listboxOptions.visible               ,
      enabled                = listboxOptions.enabled               ,
      ignored_by_interaction = listboxOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addTable(layoutTable, parentPath, tableName, numberOfColumns, tableOptions)
    tableOptions = tableOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                               = "table"                                        ,
      name                               = tableName                                      ,
      column_count                       = numberOfColumns                                ,

      -- optional options specified in table (or nil)
      draw_vertical_lines                = tableOptions.draw_vertical_lines               ,
      draw_horizontal_lines              = tableOptions.draw_horizontal_lines             ,
      draw_horizontal_line_after_headers = tableOptions.draw_horizontal_line_after_headers,

      style                              = tableOptions.style                             ,
      visible                            = tableOptions.visible                           ,
      enabled                            = tableOptions.enabled                           ,
      ignored_by_interaction             = tableOptions.ignored_by_interaction            ,
    })
  end

  function LSlib.gui.layout.addSlider(layoutTable, parentPath, sliderName, sliderOptions)
    sliderOptions = sliderOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "slider"                            ,
      name                   = sliderName                          ,

      -- optional options specified in table (or nil)
      minimum_value          = sliderOptions.minimum_value         ,
      maximum_value          = sliderOptions.maximum_value         ,
      value                  = sliderOptions.value                 ,

      style                  = sliderOptions.style                 ,
      visible                = sliderOptions.visible               ,
      enabled                = sliderOptions.enabled               ,
      ignored_by_interaction = sliderOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addEntityPreview(layoutTable, parentPath, entityPreviewName, entityPreviewOptions)
    entityPreviewOptions = entityPreviewOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "entity-preview"                           ,
      name                   = entityPreviewName                          ,

      -- optional options specified in table (or nil)
      style                  = entityPreviewOptions.style                 ,
      visible                = entityPreviewOptions.visible               ,
      enabled                = entityPreviewOptions.enabled               ,
      ignored_by_interaction = entityPreviewOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addSprite(layoutTable, parentPath, spriteName, spriteOptions)
    spriteOptions = spriteOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "sprite"                            ,
      name                   = spriteName                          ,

      -- optional options specified in table (or nil)
      sprite                 = spriteOptions.sprite                ,

      style                  = spriteOptions.style                 ,
      visible                = spriteOptions.visible               ,
      enabled                = spriteOptions.enabled               ,
      ignored_by_interaction = spriteOptions.ignored_by_interaction,
    })
  end

  function LSlib.gui.layout.addEmptyWidget(layoutTable, parentPath, widgetName, widgetOptions)
    widgetOptions = widgetOptions or {}

    return LSlib.gui.layout.addElement(layoutTable, parentPath, {
      type                   = "empty-widget",
      name                   = widgetName    ,

      -- optional options specified in table (or nil)
      drag_target            = layoutTable.name == "screen" and widgetOptions.drag_target or nil,

      style                  = widgetOptions.style  ,
      visible                = widgetOptions.visible,
      enabled                = widgetOptions.enabled,
    })
  end

end
