
if not LSlib.styles then require "styles" else

  function LSlib.styles.addImageStyle(customImageSpecifications)
    local guiStyle = data.raw["gui-style"]["default"]
    if not guiStyle then return end

    if (not customImageSpecifications.name)     or
       guiStyle[customImageSpecifications.name] then
      return -- already exist
    end

    local defaultImageStyle = customImageSpecifications.parent and {} or util.table.deepcopy(guiStyle[customImageSpecifications.type])

    -- https://github.com/wube/factorio-data/blob/master/core/prototypes/style.lua#L4187
    local customFrameStyle =
    {
      type                         = "image_style"                                                                                                                           ,
      name                         = customImageSpecifications.name                                                                                                          ,
      parent                       = customImageSpecifications.parent                                                                                                        ,

      stretch_image_to_widget_size = customImageSpecifications.stretch_image_to_widget_size or defaultImageStyle.stretch_image_to_widget_size                                ,

      margin                       = customImageSpecifications.margin                       or defaultImageStyle.margin                                                      ,
      left_margin                  = customImageSpecifications.left_margin                  or ((not customImageSpecifications.margin)  and defaultImageStyle.left_margin   ),
      right_margin                 = customImageSpecifications.right_margin                 or ((not customImageSpecifications.margin)  and defaultImageStyle.right_margin  ),
      top_margin                   = customImageSpecifications.top_margin                   or ((not customImageSpecifications.margin)  and defaultImageStyle.top_margin    ),
      bottom_margin                = customImageSpecifications.bottom_margin                or ((not customImageSpecifications.margin)  and defaultImageStyle.bottom_margin ),

      padding                      = customImageSpecifications.padding                      or defaultImageStyle.padding                                                     ,
      top_padding                  = customImageSpecifications.top_padding                  or ((not customImageSpecifications.padding) and defaultImageStyle.top_padding   ),
      bottom_padding               = customImageSpecifications.bottom_padding               or ((not customImageSpecifications.padding) and defaultImageStyle.bottom_padding),
      left_padding                 = customImageSpecifications.left_padding                 or ((not customImageSpecifications.padding) and defaultImageStyle.left_padding  ),
      right_padding                = customImageSpecifications.right_padding                or ((not customImageSpecifications.padding) and defaultImageStyle.right_padding ),

      horizontal_spacing           = customImageSpecifications.horizontal_spacing           or defaultImageStyle.horizontal_spacing                                          ,
      vertical_spacing             = customImageSpecifications.vertical_spacing             or defaultImageStyle.vertical_spacing                                            ,

      horizontal_align             = customImageSpecifications.horizontal_align             or defaultImageStyle.horizontal_align                                            ,
      vertical_align               = customImageSpecifications.vertical_align               or defaultImageStyle.vertical_align                                              ,
    }

    -- add new frame to data
    guiStyle[customImageSpecifications.name] = util.table.deepcopy(customFrameStyle)
  end

end
