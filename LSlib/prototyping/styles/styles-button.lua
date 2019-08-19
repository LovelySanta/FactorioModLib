
if not LSlib.styles then require "styles" else

  function LSlib.styles.addButtonStyle(customButtonSpecifications)
    local guiStyle = data.raw["gui-style"]["default"]
    if not guiStyle then return end

    if (not customButtonSpecifications.name)     or
       guiStyle[customButtonSpecifications.name] then
      return -- already exist
    end

    local defaultButtonStyle = customButtonSpecifications.parent and {} or util.table.deepcopy(guiStyle["button"])

    -- https://github.com/wube/factorio-data/blob/master/core/prototypes/style.lua#L745
    local customButtonStyle =
    {
      type                           = "button_style"                                                                                                                       ,
      name                           = customButtonSpecifications.name                                                                                                      ,
      parent                         = customButtonSpecifications.parent                                                                                                    ,

      font                           = customButtonSpecifications.font                           or defaultButtonStyle.font                                                 ,
      horizontal_align               = customButtonSpecifications.horizontal_align               or defaultButtonStyle.horizontal_align                                     ,
      vertical_align                 = customButtonSpecifications.vertical_align                 or defaultButtonStyle.vertical_align                                       ,
      icon_horizontal_align          = customButtonSpecifications.icon_horizontal_align          or defaultButtonStyle.icon_horizontal_align                                ,

      horizontally_stretchable       = customButtonSpecifications.horizontally_stretchable       or defaultButtonStyle.horizontally_stretchable                             ,
      vertically_stretchable         = customButtonSpecifications.vertically_stretchable         or defaultButtonStyle.vertically_stretchable                               ,

      padding                        = customButtonSpecifications.padding                        or defaultButtonStyle.padding                                              ,
      top_padding                    = customButtonSpecifications.top_padding                    or ((not defaultButtonStyle.padding) and defaultButtonStyle.top_padding   ),
      bottom_padding                 = customButtonSpecifications.bottom_padding                 or ((not defaultButtonStyle.padding) and defaultButtonStyle.bottom_padding),
      left_padding                   = customButtonSpecifications.left_padding                   or ((not defaultButtonStyle.padding) and defaultButtonStyle.left_padding  ),
      right_padding                  = customButtonSpecifications.right_padding                  or ((not defaultButtonStyle.padding) and defaultButtonStyle.right_padding ),

      size                           = customButtonSpecifications.size                           or defaultButtonStyle.size                                                 ,
      minimal_width                  = customButtonSpecifications.minimal_width                  or defaultButtonStyle.minimal_width                                        ,
      minimal_height                 = customButtonSpecifications.minimal_height                 or defaultButtonStyle.minimal_height                                       ,

      default_font_color             = customButtonSpecifications.default_font_color             or defaultButtonStyle.default_font_color                                   ,
      default_graphical_set          = customButtonSpecifications.default_graphical_set          or defaultButtonStyle.default_graphical_set                                ,

      hovered_font_color             = customButtonSpecifications.hovered_font_color             or defaultButtonStyle.hovered_font_color                                   ,
      hovered_graphical_set          = customButtonSpecifications.hover_graphical_set            or defaultButtonStyle.hover_graphical_set                                  ,

      clicked_font_color             = customButtonSpecifications.clicked_font_color             or defaultButtonStyle.clicked_font_color                                   ,
      clicked_vertical_offset        = customButtonSpecifications.clicked_vertical_offset        or defaultButtonStyle.clicked_vertical_offset                              ,
      clicked_graphical_set          = customButtonSpecifications.clicked_graphical_set          or defaultButtonStyle.clicked_graphical_set                                ,

      disabled_font_color            = customButtonSpecifications.disabled_font_color            or defaultButtonStyle.disabled_font_color                                  ,
      disabled_graphical_set         = customButtonSpecifications.disabled_graphical_set         or defaultButtonStyle.disabled_graphical_set                               ,

      selected_font_color            = customButtonSpecifications.selected_font_color            or defaultButtonStyle.selected_font_color                                  ,
      selected_graphical_set         = customButtonSpecifications.selected_graphical_set         or defaultButtonStyle.selected_graphical_set                               ,
      selected_hovered_font_color    = customButtonSpecifications.selected_hovered_font_color    or defaultButtonStyle.selected_hovered_font_color                          ,
      selected_hovered_graphical_set = customButtonSpecifications.selected_hovered_graphical_set or defaultButtonStyle.selected_hovered_graphical_set                       ,
      selected_clicked_font_color    = customButtonSpecifications.selected_clicked_font_color    or defaultButtonStyle.selected_clicked_font_color                          ,
      selected_clicked_graphical_set = customButtonSpecifications.selected_clicked_graphical_set or defaultButtonStyle.selected_clicked_graphical_set                       ,

      strikethrough_color            = customButtonSpecifications.strikethrough_color            or defaultButtonStyle.strikethrough_color                                  ,
      pie_progress_color             = customButtonSpecifications.pie_progress_color             or defaultButtonStyle.pie_progress_color                                   ,
      left_click_sound               = customButtonSpecifications.left_click_sound               or defaultButtonStyle.left_click_sound                                     ,
    }

    -- add new button to data
    guiStyle[customButtonSpecifications.name] = util.table.deepcopy(customButtonStyle)

    if customButtonSpecifications.createSelectedStyle then
      customButtonSpecifications.name = customButtonSpecifications.name .. "_selected"
      customButtonStyle.default_font_color    = customButtonStyle.selected_font_color
      customButtonStyle.default_graphical_set = customButtonStyle.selected_graphical_set
      customButtonStyle.hovered_font_color    = customButtonStyle.selected_hovered_font_color
      customButtonStyle.hovered_graphical_set = customButtonStyle.selected_hovered_graphical_set
      customButtonStyle.clicked_font_color    = customButtonStyle.selected_clicked_font_color
      customButtonStyle.clicked_graphical_set = customButtonStyle.selected_clicked_graphical_set

      -- add new button to data
      guiStyle[customButtonSpecifications.name] = util.table.deepcopy(customButtonStyle)
    end
  end

end
