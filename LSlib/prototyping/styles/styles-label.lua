
if not LSlib.styles then require "styles" else

  function LSlib.styles.addLabelStyle(customLabelSpecifications)
    local guiStyle = data.raw["gui-style"]["default"]
    if not guiStyle then return end

    if (not customLabelSpecifications.name)     or
       guiStyle[customLabelSpecifications.name] then
      return -- already exist
    end

    local defaultLabelStyle = customLabelSpecifications.parent and {} or util.table.deepcopy(guiStyle["label"])

    -- https://github.com/wube/factorio-data/blob/master/core/prototypes/style.lua#L469
    local customButtonStyle =
    {
      type                              = "label_style"                                                                                                                                ,
      name                              = customLabelSpecifications.name                                                                                                               ,
      parent                            = customLabelSpecifications.parent                                                                                                             ,

      font                              = customLabelSpecifications.font                              or defaultLabelStyle.font                                                        ,

      font_color                        = customLabelSpecifications.font_color                        or defaultLabelStyle.font_color                                                  ,
      disabled_font_color               = customLabelSpecifications.disabled_font_color               or defaultLabelStyle.disabled_font_color                                         ,

      size                              = customLabelSpecifications.size                              or defaultLabelStyle.size                                                        ,
      minimal_size                      = customLabelSpecifications.minimal_size                      or ((not customLabelSpecifications.size) and defaultLabelStyle.minimal_size     ),
      maximal_size                      = customLabelSpecifications.maximal_size                      or ((not customLabelSpecifications.size) and defaultLabelStyle.maximal_size     ),

      width                             = customLabelSpecifications.width                             or defaultLabelStyle.width                                                       ,
      minimal_width                     = customLabelSpecifications.minimal_width                     or ((not customLabelSpecifications.width) and defaultLabelStyle.minimal_width   ),
      maximal_width                     = customLabelSpecifications.maximal_width                     or ((not customLabelSpecifications.width) and defaultLabelStyle.maximal_width   ),

      height                            = customLabelSpecifications.height                            or defaultLabelStyle.height                                                      ,
      minimal_height                    = customLabelSpecifications.minimal_height                    or ((not customLabelSpecifications.height) and defaultLabelStyle.minimal_height ),
      maximal_height                    = customLabelSpecifications.maximal_height                    or ((not customLabelSpecifications.height) and defaultLabelStyle.maximal_height ),

      signle_line                       = customLabelSpecifications.signle_line                       or defaultLabelStyle.signle_line                                                 ,
      want_ellipsis                     = customLabelSpecifications.want_ellipsis                     or defaultLabelStyle.want_ellipsis                                               ,

      rich_text_setting                 = customLabelSpecifications.rich_text_setting                 or defaultLabelStyle.rich_text_setting                                           ,
      rich_text_highlight_error_color   = customLabelSpecifications.rich_text_highlight_error_color   or defaultLabelStyle.rich_text_highlight_error_color                             ,
      rich_text_highlight_warning_color = customLabelSpecifications.rich_text_highlight_warning_color or defaultLabelStyle.rich_text_highlight_warning_color                           ,
      rich_text_highlight_ok_color      = customLabelSpecifications.rich_text_highlight_ok_color      or defaultLabelStyle.rich_text_highlight_ok_color                                ,

      padding                           = customLabelSpecifications.padding                           or defaultLabelStyle.padding                                                     ,
      top_padding                       = customLabelSpecifications.top_padding                       or ((not customLabelSpecifications.padding) and defaultLabelStyle.top_padding   ),
      bottom_padding                    = customLabelSpecifications.bottom_padding                    or ((not customLabelSpecifications.padding) and defaultLabelStyle.bottom_padding),
      left_padding                      = customLabelSpecifications.left_padding                      or ((not customLabelSpecifications.padding) and defaultLabelStyle.left_padding  ),
      right_padding                     = customLabelSpecifications.right_padding                     or ((not customLabelSpecifications.padding) and defaultLabelStyle.right_padding ),

      horizontally_squashable           = customLabelSpecifications.horizontally_squashable           or defaultLabelStyle.horizontally_squashable                                     ,
    }

    -- add new button to data
    guiStyle[customLabelSpecifications.name] = util.table.deepcopy(customButtonStyle)
  end

end
