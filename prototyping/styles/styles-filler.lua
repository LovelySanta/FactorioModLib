
if not LSlib.styles then require "styles" else

  function LSlib.styles.addFillerFrameStyles()
    local guiStyles = data.raw["gui-style"]["default"]
    local fillerStyle = guiStyles["draggable_space"]

    LSlib.styles.addFrameStyle{
      name   = "LSlib_default_filler",
      parent = "frame",

      padding = 0,
      horizontally_stretchable = "on",

      graphical_set = fillerStyle.graphical_set,
      use_header_filler = false,
    }

    LSlib.styles.addFrameStyle{
      name   = "LSlib_default_header_filler",
      parent = "LSlib_default_filler",

      height = guiStyles["frame"]["header_filler_style"].height,
    }

    LSlib.styles.addFrameStyle{
      name   = "LSlib_default_footer_filler",
      parent = "LSlib_default_filler",

      height = guiStyles["dialog_button"].height,

      left_margin  = fillerStyle.left_margin ,
      right_margin = fillerStyle.right_margin,
    }
  end

end
