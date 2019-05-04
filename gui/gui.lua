
if LSlib then
  if not LSlib.gui then LSlib.gui = {}

    require "layout.layout"

    require "gui-creation"
    require "gui-properties"

  end
else
  require "lib"
end
