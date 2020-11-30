
if not LSlib.styles then require "styles" else

  function LSlib.styles.addTabStyle(customTabSpecifications)
    -- button
    local tabButtonSpecifications               = customTabSpecifications.button or {}
    tabButtonSpecifications.name                = (customTabSpecifications.name or "unknown") .. "_button"
    tabButtonSpecifications.createSelectedStyle = customTabSpecifications.createSelectedStyle or true
    LSlib.styles.addButtonStyle(tabButtonSpecifications)

    -- buttonFlow
    local tabButtonFlowSpecifications          = customTabSpecifications.buttonFlow or {}
    tabButtonFlowSpecifications.name           = (customTabSpecifications.name or "unknown") .. "_buttonFlow"
    LSlib.styles.addFlowStyle(tabButtonFlowSpecifications)

    -- innerFrame
    local tabInsideFrameSpecification          = customTabSpecifications.tabInsideFrame or {}
    tabInsideFrameSpecification.name           = (customTabSpecifications.name or "unknown") .. "_insideDeepFrame"
    LSlib.styles.addFrameStyle(tabInsideFrameSpecification)

    -- contentFrame
    local tabContentFrameSpecification         = customTabSpecifications.contentFrame or {}
    tabContentFrameSpecification.name          = (customTabSpecifications.name or "unknown") .. "_contentFrame"
    LSlib.styles.addFrameStyle(tabContentFrameSpecification)

  end

  function LSlib.styles.getVanillaTabStyleSpecification()
    -- this function adds the vanilla tab elements required that are not available by default
    local defaultStyles = data.raw["gui-style"]["default"]

    local tabStyleSpecification =
    {
      name                = "LSlib_default_tab", -- base name for the tab styles
      createSelectedStyle = true               , -- create seperate style for selected button
      button              = {}                 , -- tab button
      buttonFlow          = {}                 , -- tab flow for the buttons
      tabInsideFrame      = {}                 , -- tab outer frame behind the buttons
      contentFrame        = {}                 , -- tab inner frame below the buttons
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
    local tabButtonFlow = defaultStyles["tabbed_pane"] -- vanilla style
    local tabButtonFlowStyleSpecification = tabStyleSpecification.buttonFlow

    tabButtonFlowStyleSpecification.direction          = "horizontal"

    tabButtonFlowStyleSpecification.top_padding        = tabButtonFlow.tab_container.top_padding
    tabButtonFlowStyleSpecification.bottom_padding     = tabButtonFlow.tab_container.bottom_padding
    tabButtonFlowStyleSpecification.left_padding       = tabButtonFlow.tab_container.left_padding
    tabButtonFlowStyleSpecification.right_padding      = tabButtonFlow.tab_container.right_padding

    tabButtonFlowStyleSpecification.horizontal_spacing = tabButtonFlow.tab_container.horizontal_spacing or tabButtonFlow.horizontal_spacing
    tabButtonFlowStyleSpecification.vertical_spacing   = tabButtonFlow.tab_container.vertical_spacing   or tabButtonFlow.vertical_spacing

    -- tab inner deep frame (the root background of the tab) -------------------
    ----------------------------------------------------------------------------
    local tabInsideDeepFrame1 = defaultStyles["inside_deep_frame_for_tabs"    ]       -- vanilla style
    local tabInsideDeepFrame2 = defaultStyles[tabInsideDeepFrame1.parent or ""] or {} -- vanilla style
    local tabInsideDeepFrameStyleSpecification = tabStyleSpecification.tabInsideFrame

    tabInsideDeepFrameStyleSpecification.top_padding         = tabInsideDeepFrame1.top_padding         or tabInsideDeepFrame2.top_padding
    tabInsideDeepFrameStyleSpecification.bottom_padding      = tabInsideDeepFrame1.bottom_padding      or tabInsideDeepFrame2.bottom_padding
    tabInsideDeepFrameStyleSpecification.left_padding        = tabInsideDeepFrame1.left_padding        or tabInsideDeepFrame2.left_padding
    tabInsideDeepFrameStyleSpecification.right_padding       = tabInsideDeepFrame1.right_padding       or tabInsideDeepFrame2.right_padding
    tabInsideDeepFrameStyleSpecification.padding             = tabInsideDeepFrame1.padding             or tabInsideDeepFrame2.padding

    tabInsideDeepFrameStyleSpecification.graphical_set       = tabInsideDeepFrame1.graphical_set       or tabInsideDeepFrame2.graphical_set
    tabInsideDeepFrameStyleSpecification.vertical_flow_style = tabInsideDeepFrame1.vertical_flow_style or tabInsideDeepFrame2.vertical_flow_style

    -- tab inner upper frame (the root background of the tab) -------------------
    ----------------------------------------------------------------------------
    local tabInsideUpperFrame = defaultStyles[defaultStyles["tabbed_pane"].tab_content_frame.parent] -- vanilla style
    local tabContentFrameStyleSpecification = tabStyleSpecification.contentFrame
    
    tabContentFrameStyleSpecification.top_padding      = tabInsideUpperFrame.top_padding
    tabContentFrameStyleSpecification.bottom_padding   = tabInsideUpperFrame.bottom_padding
    tabContentFrameStyleSpecification.left_padding     = tabInsideUpperFrame.left_padding
    tabContentFrameStyleSpecification.right_padding    = tabInsideUpperFrame.right_padding
    --tabContentFrameStyleSpecification.padding          = tabInsideUpperFrame.padding

    tabContentFrameStyleSpecification.graphical_set    = tabInsideUpperFrame.graphical_set

    tabContentFrameStyleSpecification.horizontally_stretchable = "on"

    -- return the vanillaTabStyleSpecification
    return tabStyleSpecification

  end

end
