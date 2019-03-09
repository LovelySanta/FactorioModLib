
if LSlib and LSlib.utils then
  if not LSlib.utils.table then LSlib.utils.table = {}

    function LSlib.utils.table.isTable(t) return type(t) == "table" end
    function LSlib.utils.table.isEmpty(t) return not next(t)        end

    function LSlib.utils.table.hasValue(table, value)
      for _,val in pairs(table) do
        if value == val then return true end
      end
      return false
    end

    function LSlib.utils.table.areEqual(t1, t2)
      if (not LSlib.utils.table.isTable(t1)) or
         (not LSlib.utils.table.isTable(t2)) then
        return t1 == t2
      end
      for k,v in pairs(t1) do
        if not LSlib.utils.table.areEqual(v, t2[k]) then return false end
      end
      for k,v in pairs(t2) do
        -- only check if t1 has that value, if not, it is not equal.
        if not (t1[k] ~= nil)               then return false end
      end
      return true
    end

    function LSlib.utils.table.convertRGBA(color)
      for key,default in pairs(color) do
        color[key] = color[key] / 255
      end
      return color
    end

  end
else
  require "utils"
end
