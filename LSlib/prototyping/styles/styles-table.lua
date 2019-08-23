
if not LSlib.styles then require "styles" else

  function LSlib.styles.addTableStyle(customTableSpecifications)
    local guiStyle = data.raw["gui-style"]["default"]
    if not guiStyle then return end

    if (not customTableSpecifications.name)     or
       guiStyle[customTableSpecifications.name] then
      return -- already exist
    end

    local defaultTableStyle = customTableSpecifications.parent and {} or util.table.deepcopy(guiStyle["table"])

    local customTableStyle =
    {
      type               = "table_style"                                                                                                         ,
      name               = customTableSpecifications.name                                                                                        ,
      parent             = customTableSpecifications.parent                                                                                      ,

      column_alignments  = customTableSpecifications.column_alignments  or defaultTableStyle.column_alignments                                   ,
      column_widths      = customTableSpecifications.column_widths      or defaultTableStyle.column_widths                                       ,

      horizontal_spacing = customTableSpecifications.horizontal_spacing or defaultTableStyle.horizontal_spacing                                  ,
      vertical_spacing   = customTableSpecifications.vertical_spacing   or defaultTableStyle.vertical_spacing                                    ,

      padding            = customTableSpecifications.padding            or defaultTableStyle.padding                                             ,
      top_padding        = customTableSpecifications.top_padding        or ((not defaultTableStyle.padding) and defaultTableStyle.top_padding   ),
      bottom_padding     = customTableSpecifications.bottom_padding     or ((not defaultTableStyle.padding) and defaultTableStyle.bottom_padding),
      left_padding       = customTableSpecifications.left_padding       or ((not defaultTableStyle.padding) and defaultTableStyle.left_padding  ),
      right_padding      = customTableSpecifications.right_padding      or ((not defaultTableStyle.padding) and defaultTableStyle.right_padding ),

      size               = customTableSpecifications.size               or defaultTableStyle.size                                                ,
      minimal_width      = customTableSpecifications.minimal_width      or defaultTableStyle.minimal_width                                       ,
      minimal_height     = customTableSpecifications.minimal_height     or defaultTableStyle.minimal_height                                      ,
    }

    -- add new button to data
    guiStyle[customTableSpecifications.name] = util.table.deepcopy(customTableStyle)
  end

end
