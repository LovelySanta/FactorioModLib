
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

    LSlib.styles.addWidgetStyle{
      name   = "LSlib_default_draggable_filler",
      parent = "draggable_space",

      left_margin  = fillerStyle.left_margin ,
      right_margin = fillerStyle.right_margin,

      horizontally_stretchable = "on",
    }

    -- header filler -----------------------------------------------------------
    LSlib.styles.addFlowStyle{ -- header flow
      name   = "LSlib_default_header",
      parent = "flow",

      vertical_align = guiStyles["frame"].header_flow_style.vertical_align,
      vertically_stretchable = false,
      --top_margin     = -2,
      bottom_padding = guiStyles["frame"].header_flow_style.bottom_padding - 2,
      horizontal_spacing = guiStyles["frame"].header_flow_style.horizontal_spacing,
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

    LSlib.styles.addWidgetStyle{ -- filler itself
      name   = "LSlib_default_draggable_header",
      parent = "LSlib_default_draggable_filler",
      
      height = guiStyles["frame"]["header_filler_style"].height
    }

    LSlib.styles.addButtonStyle{ -- header buttons
      name = "LSlib_default_header_button",
      parent = "mini_button",

      size = guiStyles["frame_action_button"].size,

      default_graphical_set = guiStyles["frame_button"].default_graphical_set,
      hovered_graphical_set = guiStyles["frame_button"].hovered_graphical_set,
      clicked_graphical_set = guiStyles["frame_button"].clicked_graphical_set,
      disabled_graphical_set = guiStyles["frame_button"].disabled_graphical_set,
      selected_graphical_set = guiStyles["frame_button"].selected_graphical_set,
      selected_hovered_graphical_set = guiStyles["frame_button"].selected_hovered_graphical_set
    }



    -- footer filler -----------------------------------------------------------
    LSlib.styles.addFlowStyle{ -- header flow
      name   = "LSlib_default_footer",
      parent = "flow",

      vertical_align = guiStyles["frame"].header_flow_style.vertical_align,
      bottom_margin  = -2,
      top_padding    = guiStyles["frame"].header_flow_style.bottom_padding,
    }

    LSlib.styles.addFrameStyle{ -- filler itself
      name   = "LSlib_default_footer_filler",
      parent = "LSlib_default_filler",

      height = guiStyles["dialog_button"].height,
    }

    LSlib.styles.addWidgetStyle{ -- filler itself
    name   = "LSlib_default_draggable_footer",
    parent = "LSlib_default_draggable_filler",
    
    height = guiStyles["frame"]["header_filler_style"].height
  }
  end

end
