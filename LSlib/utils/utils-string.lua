
if LSlib and LSlib.utils then
  if not LSlib.utils.string then LSlib.utils.string = {}

    function LSlib.utils.string.split(inputstring, sep)
      if inputstring == nil then return {} end
      
      if sep == nil then sep = "%s" end
      local t = {}
      local i = 1
      for str in string.gmatch(inputstring, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
      end
      return t
    end

  end
else
  require "utils"
end
