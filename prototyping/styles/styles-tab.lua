
if not LSlib.styles then require "styles" else

  function LSlib.styles.addTabStyle(customTabSpecifications)
    -- button
    local tabButtonSpecifications               = customTabSpecifications.button or {}
    tabButtonSpecifications.name                = (customTabSpecifications.name or "unknown") .. "_button"
    tabButtonSpecifications.createSelectedStyle = customTabSpecifications.createSelectedStyle or true
    LSlib.styles.addButtonStyle(tabButtonSpecifications)

    -- buttonFrame
    local tabButtonFlowSpecifications          = customTabSpecifications.buttonFrame or {}
    tabButtonFlowSpecifications.name           = (customTabSpecifications.name or "unknown") .. "_buttonFlow"
    LSlib.styles.addFlowStyle(tabButtonFlowSpecifications)
  end

  function LSlib.styles.getVanillaTabStyleSpecification()
    -- this function adds the vanilla tab elements required that are not available by default
    local defaultStyles = data.raw["gui-style"]["default"]

    local tabStyleSpecification =
    {
      name                = "LSlib_default_tab", -- base name for the tab styles
      createSelectedStyle = true               , -- create seperate style for selected button
      button              = {}                 , -- tab button
      buttonFrame         = {}
    }

    -- Button ------------------------------------------------------------------
    ----------------------------------------------------------------------------
    local tabButton = defaultStyles["tab"] -- vanilla style
    local tabButtonStyleSpecification = tabStyleSpecification.button

    -- alignment of the button
    tabButtonStyleSpecification.horizontal_align = tabButton.horizontal_align
    tabButtonStyleSpecification.vertical_align   = tabButton.vertical_align
    tabButtonStyleSpecification.top_padding      = tabButton.top_padding
    tabButtonStyleSpecification.bottom_padding   = tabButton.bottom_padding
    tabButtonStyleSpecification.left_padding     = tabButton.left_padding
    tabButtonStyleSpecification.right_padding    = tabButton.right_padding
    tabButtonStyleSpecification.minimal_width    = tabButton.minimal_width
    tabButtonStyleSpecification.minimal_height   = nil

    -- default appearance (not viewed tabs)
    tabButtonStyleSpecification.font                    = tabButton.font
    tabButtonStyleSpecification.default_font_color      = tabButton.default_font_color
    tabButtonStyleSpecification.default_graphical_set   = tabButton.default_graphical_set
    tabButtonStyleSpecification.hovered_font_color      = tabButtonStyleSpecification.default_font_color
    tabButtonStyleSpecification.hovered_graphical_set   = tabButton.hover_graphical_set

    tabButtonStyleSpecification.clicked_vertical_offset = 0
    tabButtonStyleSpecification.clicked_font_color      = tabButtonStyleSpecification.hovered_font_color
    tabButtonStyleSpecification.clicked_graphical_set   = tabButton.press_graphical_set

    -- selected appearance (viewed tab)
    tabButtonStyleSpecification.selected_font_color            = tabButton.selected_font_color
    tabButtonStyleSpecification.selected_graphical_set         = tabButton.selected_graphical_set
    tabButtonStyleSpecification.selected_hovered_font_color    = tabButtonStyleSpecification.selected_font_color
    tabButtonStyleSpecification.selected_hovered_graphical_set = tabButtonStyleSpecification.selected_graphical_set

    tabButtonStyleSpecification.selected_clicked_font_color    = tabButtonStyleSpecification.selected_hovered_font_color
    tabButtonStyleSpecification.selected_clicked_graphical_set = tabButtonStyleSpecification.selected_hovered_graphical_set

    -- disabled tab (not selectable)
    tabButtonStyleSpecification.disabled_font_color    = tabButton.disabled_font_color
    tabButtonStyleSpecification.disabled_graphical_set = tabButton.disabled_graphical_set

    -- other elements
    tabButtonStyleSpecification.strikethrough_color = nil
    tabButtonStyleSpecification.pie_progress_color  = nil
    tabButtonStyleSpecification.left_click_sound    = nil

    -- Button frame ------------------------------------------------------------
    ----------------------------------------------------------------------------
    local tabButtonFrame = defaultStyles["tabbed_pane"] -- vanilla style
    local tabButtonFrameStyleSpecification = tabStyleSpecification.buttonFrame

    tabButtonFrameStyleSpecification.direction          = "horizontal"

    tabButtonFrameStyleSpecification.top_padding        = tabButtonFrame.tab_container.top_padding
    tabButtonFrameStyleSpecification.bottom_padding     = tabButtonFrame.tab_container.bottom_padding
    tabButtonFrameStyleSpecification.left_padding       = tabButtonFrame.tab_container.left_padding
    tabButtonFrameStyleSpecification.right_padding      = tabButtonFrame.tab_container.right_padding

    tabButtonFrameStyleSpecification.horizontal_spacing = tabButtonFrame.tab_container.horizontal_spacing or tabButtonFrame.horizontal_spacing
    tabButtonFrameStyleSpecification.vertical_spacing   = tabButtonFrame.tab_container.vertical_spacing   or tabButtonFrame.vertical_spacing

    -- return the vanillaTabStyleSpecification
    return tabStyleSpecification

  end

end
