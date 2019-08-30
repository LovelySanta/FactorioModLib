
if not LSlib.styles then require "styles" else

  function LSlib.styles.addFlowStyle(customFlowSpecifications)
    local guiStyle = data.raw["gui-style"]["default"]
    if not guiStyle then return end

    if (not customFlowSpecifications.name)     or
       guiStyle[customFlowSpecifications.name] then
      return -- already exist
    end

    customFlowSpecifications.type = (customFlowSpecifications.direction or "horizontal") .. "_flow"
    local defaultFlowStyle = util.table.deepcopy(guiStyle[customFlowSpecifications.type])

    -- https://github.com/wube/factorio-data/blob/master/core/prototypes/style.lua#L4187
    local customFlowStyle =
    {
      type                     = customFlowSpecifications.type .. "_style"                                                                                        ,
      name                     = customFlowSpecifications.name                                                                                                    ,

      margin                   = customFlowSpecifications.margin                   or defaultFlowStyle.margin                                                     ,
      left_margin              = customFlowSpecifications.left_margin              or ((not customFlowSpecifications.margin)  and defaultFlowStyle.left_margin   ),
      right_margin             = customFlowSpecifications.right_margin             or ((not customFlowSpecifications.margin)  and defaultFlowStyle.right_margin  ),
      top_margin               = customFlowSpecifications.top_margin               or ((not customFlowSpecifications.margin)  and defaultFlowStyle.top_margin    ),
      bottom_margin            = customFlowSpecifications.bottom_margin            or ((not customFlowSpecifications.margin)  and defaultFlowStyle.bottom_margin ),

      padding                  = customFlowSpecifications.padding                  or defaultFlowStyle.padding                                                    ,
      top_padding              = customFlowSpecifications.top_padding              or ((not customFlowSpecifications.padding) and defaultFlowStyle.top_padding   ),
      bottom_padding           = customFlowSpecifications.bottom_padding           or ((not customFlowSpecifications.padding) and defaultFlowStyle.bottom_padding),
      left_padding             = customFlowSpecifications.left_padding             or ((not customFlowSpecifications.padding) and defaultFlowStyle.left_padding  ),
      right_padding            = customFlowSpecifications.right_padding            or ((not customFlowSpecifications.padding) and defaultFlowStyle.right_padding ),

      horizontal_spacing       = customFlowSpecifications.horizontal_spacing       or defaultFlowStyle.horizontal_spacing                                         ,
      vertical_spacing         = customFlowSpecifications.vertical_spacing         or defaultFlowStyle.vertical_spacing                                           ,

      horizontally_stretchable = customFlowSpecifications.horizontally_stretchable or defaultFlowStyle.horizontally_stretchable                                   ,
      vertically_stretchable   = customFlowSpecifications.vertically_stretchable   or defaultFlowStyle.vertically_stretchable                                     ,

      horizontal_align         = customFlowSpecifications.horizontal_align         or defaultFlowStyle.horizontal_align                                           ,
      vertical_align           = customFlowSpecifications.vertical_align           or defaultFlowStyle.vertical_align                                             ,
    }

    -- add new frame to data
    guiStyle[customFlowSpecifications.name] = util.table.deepcopy(customFlowStyle)
  end

end
