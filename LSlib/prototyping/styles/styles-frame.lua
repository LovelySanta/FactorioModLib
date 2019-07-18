
if not LSlib.styles then require "styles" else

  function LSlib.styles.addFrameStyle(customFrameSpecifications)
    local guiStyle = data.raw["gui-style"]["default"]
    if not guiStyle then return end

    if (not customFrameSpecifications.name)     or
       guiStyle[customFrameSpecifications.name] then
      return -- already exist
    end

    local defaultFrameStyle = util.table.deepcopy(guiStyle["frame"])
    -- https://github.com/wube/factorio-data/blob/master/core/prototypes/style.lua#L4187
    local customFrameStyle =
    {
      type                  = "frame_style"                                                                             ,
      name                  = customFrameSpecifications.name                                                            ,
      font                  = customFrameSpecifications.font                  or defaultFrameStyle.font                 ,
      font_color            = customFrameSpecifications.font_color            or defaultFrameStyle.font_color           ,
      title_top_padding     = customFrameSpecifications.title_top_padding     or defaultFrameStyle.title_top_padding    ,
      title_bottom_padding  = customFrameSpecifications.title_bottom_padding  or defaultFrameStyle.title_bottom_padding ,
      title_left_padding    = customFrameSpecifications.title_left_padding    or defaultFrameStyle.title_left_padding   ,
      title_right_padding   = customFrameSpecifications.title_right_padding   or defaultFrameStyle.title_right_padding  ,
      padding               = customFrameSpecifications.padding               or defaultFrameStyle.padding              ,
      top_padding           = customFrameSpecifications.top_padding           or defaultFrameStyle.top_padding          ,
      bottom_padding        = customFrameSpecifications.bottom_padding        or defaultFrameStyle.bottom_padding       ,
      left_padding          = customFrameSpecifications.left_padding          or defaultFrameStyle.left_padding         ,
      right_padding         = customFrameSpecifications.right_padding         or defaultFrameStyle.right_padding        ,
      graphical_set         = customFrameSpecifications.graphical_set         or defaultFrameStyle.graphical_set        ,
      flow_style            = customFrameSpecifications.flow_style            or defaultFrameStyle.flow_style           ,
      horizontal_flow_style = customFrameSpecifications.horizontal_flow_style or defaultFrameStyle.horizontal_flow_style,
      vertical_flow_style   = customFrameSpecifications.vertical_flow_style   or defaultFrameStyle.vertical_flow_style  ,
      header_flow_style     = customFrameSpecifications.header_flow_style     or defaultFrameStyle.header_flow_style    ,
      header_filler_style   = customFrameSpecifications.header_filler_style   or defaultFrameStyle.header_filler_style  ,
      use_header_filler     = customFrameSpecifications.use_header_filler     or defaultFrameStyle.use_header_filler    ,
      border                = customFrameSpecifications.border                or defaultFrameStyle.border               ,
    }

    -- add new frame to data
    guiStyle[customFrameSpecifications.name] = util.table.deepcopy(customFrameStyle)
  end

end
