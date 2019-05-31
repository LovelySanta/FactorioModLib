
if not LSlib.styles then require "styles" else

  function LSlib.styles.addFillerFrameStyles()
    local guiStyles = data.raw["gui-style"]["default"]
    local fillerStyle = guiStyles["draggable_space"]

    -- basic filler ------------------------------------------------------------
    LSlib.styles.addFrameStyle{
      name   = "LSlib_default_filler",
      parent = "frame",

      padding = 0,
      horizontally_stretchable = "on",

      left_margin  = fillerStyle.left_margin ,
      right_margin = fillerStyle.right_margin,

      graphical_set = fillerStyle.graphical_set,
      use_header_filler = false,
    }



    -- header filler -----------------------------------------------------------
    LSlib.styles.addFlowStyle{ -- header flow
      name   = "LSlib_default_header",
      parent = "flow",

      vertical_align = guiStyles["frame"].header_flow_style.vertical_align,
      top_margin     = -2,
      bottom_padding = guiStyles["frame"].header_flow_style.bottom_padding,
    }

    LSlib.styles.addLabelStyle{ -- title label
      name   = "LSlib_default_frame_title",
      parent = "frame_title",

      horizontally_squashable = "on",
    }

    LSlib.styles.addFrameStyle{ -- filler itself
      name   = "LSlib_default_header_filler",
      parent = "LSlib_default_filler",

      height = guiStyles["frame"]["header_filler_style"].height,
    }

    LSlib.styles.addButtonStyle{ -- header buttons
      name = "LSlib_default_header_button",
      parent = "mini_button",

      size = guiStyles["search_button"].size
    }



    -- footer filler -----------------------------------------------------------
    LSlib.styles.addFlowStyle{ -- header flow
      name   = "LSlib_default_footer",
      parent = "flow",

      vertical_align = guiStyles["frame"].header_flow_style.vertical_align,
      bottom_margin  = -2,
      top_padding    = guiStyles["frame"].header_flow_style.bottom_padding,
    }

    LSlib.styles.addFrameStyle{
      name   = "LSlib_default_footer_filler",
      parent = "LSlib_default_filler",

      height = guiStyles["dialog_button"].height,
    }
  end

end
