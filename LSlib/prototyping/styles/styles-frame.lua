
if not LSlib.styles then require "styles" else

  function LSlib.styles.addFrameStyle(customFrameSpecifications)
    local guiStyle = data.raw["gui-style"]["default"]
    if not guiStyle then return end

    if (not customFrameSpecifications.name)     or
       guiStyle[customFrameSpecifications.name] then
      return -- already exist
    end

    local defaultFrameStyle = customFrameSpecifications.parent and {} or util.table.deepcopy(guiStyle["frame"])
    -- https://github.com/wube/factorio-data/blob/master/core/prototypes/style.lua#L4187
    local customFrameStyle =
    {
      type                     = "frame_style"                                                                                                                                     ,
      name                     = customFrameSpecifications.name                                                                                                                    ,
      parent                   = customFrameSpecifications.parent                                                                                                                  ,

      font                     = customFrameSpecifications.font                     or defaultFrameStyle.font                                                                      ,
      font_color               = customFrameSpecifications.font_color               or defaultFrameStyle.font_color                                                                ,

      size                     = customFrameSpecifications.size                     or defaultFrameStyle.size                                                                      ,
      minimal_size             = customFrameSpecifications.minimal_size             or ((not customFrameSpecifications.size)               and defaultFrameStyle.minimal_size     ),
      maximal_size             = customFrameSpecifications.maximal_size             or ((not customFrameSpecifications.size)               and defaultFrameStyle.maximal_size     ),

      width                    = customFrameSpecifications.width                    or defaultFrameStyle.width                                                                     ,
      minimal_width            = customFrameSpecifications.minimal_width            or ((not customFrameSpecifications.width)              and defaultFrameStyle.minimal_width    ),
      maximal_width            = customFrameSpecifications.maximal_width            or ((not customFrameSpecifications.width)              and defaultFrameStyle.maximal_width    ),

      height                   = customFrameSpecifications.height                   or defaultFrameStyle.height                                                                    ,
      minimal_height           = customFrameSpecifications.minimal_height           or ((not customFrameSpecifications.height)             and defaultFrameStyle.minimal_height   ),
      maximal_height           = customFrameSpecifications.maximal_height           or ((not customFrameSpecifications.height)             and defaultFrameStyle.maximal_height   ),

      margin                   = customFrameSpecifications.margin                   or defaultFrameStyle.margin                                                                    ,
      left_margin              = customFrameSpecifications.left_margin              or ((not customFrameSpecifications.margin)             and defaultFrameStyle.left_margin      ),
      right_margin             = customFrameSpecifications.right_margin             or ((not customFrameSpecifications.margin)             and defaultFrameStyle.right_margin     ),
      top_margin               = customFrameSpecifications.top_margin               or ((not customFrameSpecifications.margin)             and defaultFrameStyle.top_margin       ),
      bottom_margin            = customFrameSpecifications.bottom_margin            or ((not customFrameSpecifications.margin)             and defaultFrameStyle.bottom_margin    ),

      padding                  = customFrameSpecifications.padding                  or defaultFrameStyle.padding                                                                   ,
      top_padding              = customFrameSpecifications.top_padding              or ((not customFrameSpecifications.padding)            and defaultFrameStyle.top_padding      ),
      bottom_padding           = customFrameSpecifications.bottom_padding           or ((not customFrameSpecifications.padding)            and defaultFrameStyle.bottom_padding   ),
      left_padding             = customFrameSpecifications.left_padding             or ((not customFrameSpecifications.padding)            and defaultFrameStyle.left_padding     ),
      right_padding            = customFrameSpecifications.right_padding            or ((not customFrameSpecifications.padding)            and defaultFrameStyle.right_padding    ),

      graphical_set            = customFrameSpecifications.graphical_set            or defaultFrameStyle.graphical_set                                                             ,

      flow_style               = customFrameSpecifications.flow_style               or defaultFrameStyle.flow_style                                                                ,
      horizontal_flow_style    = customFrameSpecifications.horizontal_flow_style    or defaultFrameStyle.horizontal_flow_style                                                     ,
      vertical_flow_style      = customFrameSpecifications.vertical_flow_style      or defaultFrameStyle.vertical_flow_style                                                       ,

      header_flow_style        = customFrameSpecifications.header_flow_style        or defaultFrameStyle.header_flow_style                                                         ,
      header_filler_style      = customFrameSpecifications.header_filler_style      or defaultFrameStyle.header_filler_style                                                       ,
      use_header_filler        = customFrameSpecifications.use_header_filler        or (customFrameSpecifications.use_header_filler == nil and defaultFrameStyle.use_header_filler),

      horizontally_stretchable = customFrameSpecifications.horizontally_stretchable or defaultFrameStyle.horizontally_stretchable                                                  ,
      vertically_stretchable   = customFrameSpecifications.vertically_stretchable   or defaultFrameStyle.vertically_stretchable                                                    ,

      border                   = customFrameSpecifications.border                   or defaultFrameStyle.border                                                                    ,
    }

    -- add new frame to data
    guiStyle[customFrameSpecifications.name] = util.table.deepcopy(customFrameStyle)
  end

  function LSlib.styles.addWidgetStyle(customWidgetSpecifications)
    local guiStyle = data.raw["gui-style"]["default"]
    if not guiStyle then return end

    if (not customWidgetSpecifications.name)     or
       guiStyle[customWidgetSpecifications.name] then
      return -- already exist
    end

    local defaultWidgetStyle = customWidgetSpecifications.parent and {} or util.table.deepcopy(guiStyle["empty_widget"])
    -- https://github.com/wube/factorio-data/blob/master/core/prototypes/style.lua#L9714
    local customWidgetStyle =
    {
      type                     = "empty_widget_style"                                                                                                                                 ,
      name                     = customWidgetSpecifications.name                                                                                                                      ,
      parent                   = customWidgetSpecifications.parent                                                                                                                    ,

      height                   = customWidgetSpecifications.height                   or defaultWidgetStyle.height                                                                     ,
      minimal_height           = customWidgetSpecifications.minimal_height           or ((not customWidgetSpecifications.height)             and defaultWidgetStyle.minimal_height   ),
      maximal_height           = customWidgetSpecifications.maximal_height           or ((not customWidgetSpecifications.height)             and defaultWidgetStyle.maximal_height   ),

      margin                   = customWidgetSpecifications.margin                   or defaultWidgetStyle.margin                                                                    ,
      left_margin              = customWidgetSpecifications.left_margin              or ((not customWidgetSpecifications.margin)             and defaultWidgetStyle.left_margin      ),
      right_margin             = customWidgetSpecifications.right_margin             or ((not customWidgetSpecifications.margin)             and defaultWidgetStyle.right_margin     ),
      top_margin               = customWidgetSpecifications.top_margin               or ((not customWidgetSpecifications.margin)             and defaultWidgetStyle.top_margin       ),
      bottom_margin            = customWidgetSpecifications.bottom_margin            or ((not customWidgetSpecifications.margin)             and defaultWidgetStyle.bottom_margin    ),

      padding                  = customWidgetSpecifications.padding                  or defaultWidgetStyle.padding                                                                   ,
      top_padding              = customWidgetSpecifications.top_padding              or ((not customWidgetSpecifications.padding)            and defaultWidgetStyle.top_padding      ),
      bottom_padding           = customWidgetSpecifications.bottom_padding           or ((not customWidgetSpecifications.padding)            and defaultWidgetStyle.bottom_padding   ),
      left_padding             = customWidgetSpecifications.left_padding             or ((not customWidgetSpecifications.padding)            and defaultWidgetStyle.left_padding     ),
      right_padding            = customWidgetSpecifications.right_padding            or ((not customWidgetSpecifications.padding)            and defaultWidgetStyle.right_padding    ),


      horizontally_stretchable = customWidgetSpecifications.horizontally_stretchable or defaultWidgetStyle.horizontally_stretchable                                                   ,
      vertically_stretchable   = customWidgetSpecifications.vertically_stretchable   or defaultWidgetStyle.vertically_stretchable                                                     ,
    }

    -- add new frame to data
    guiStyle[customWidgetSpecifications.name] = util.table.deepcopy(customWidgetStyle)
  end
end
