
if LSlib and LSlib.utils then
  if not LSlib.utils.table then require "utils-table" end
  if not LSlib.utils.string then LSlib.utils.string = {}

    function LSlib.utils.string.isString(s) return type(t) == "string" end

    function LSlib.utils.string.split(inputstring, sep)
      if sep == nil then sep = "%s" end
      local t = {}
      local i = 1
      for str in string.gmatch(inputstring, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
      end
      return t
    end

    function LSlib.utils.string.equal(s1, s2)
      -- this support localised strings as well
      if LSlib.utils.string.isString(s1) then s1 = {"", s1} end
      if LSlib.utils.string.isString(s2) then s2 = {"", s2} end
      return LSlib.utils.table.areEqual(s1, s2)
    end

  end
else
  require "utils"
end
