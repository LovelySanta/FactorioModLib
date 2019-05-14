
if LSlib then
  if LSlib.gui then
    if not LSlib.gui.layout then LSlib.gui.layout = {}

      require "layout-properties"
      require "layout-creation"
      require "layout-elements"
      require "layout-parts"

    end
  else
    require "gui"
  end
else
  require "LSlib/lib"
end
