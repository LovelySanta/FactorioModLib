
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
    local customFrameStyle =
    {
      type               = customFlowSpecifications.type .. "_style"                                         ,
      name               = customFlowSpecifications.name                                                     ,
      top_padding        = customFlowSpecifications.top_padding        or defaultFlowStyle.top_padding       ,
      bottom_padding     = customFlowSpecifications.bottom_padding     or defaultFlowStyle.bottom_padding    ,
      left_padding       = customFlowSpecifications.left_padding       or defaultFlowStyle.left_padding      ,
      right_padding      = customFlowSpecifications.right_padding      or defaultFlowStyle.right_padding     ,
      horizontal_spacing = customFlowSpecifications.horizontal_spacing or defaultFlowStyle.horizontal_spacing,
      vertical_spacing   = customFlowSpecifications.vertical_spacing   or defaultFlowStyle.vertical_spacing  ,
    }

    -- add new frame to data
    guiStyle[customFlowSpecifications.name] = util.table.deepcopy(customFrameStyle)
  end

end
