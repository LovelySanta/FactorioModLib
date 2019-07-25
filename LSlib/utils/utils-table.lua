
if LSlib and LSlib.utils then
  if not LSlib.utils.table then LSlib.utils.table = {}

    function LSlib.utils.table.isTable(t) return type(t) == "table" end
    function LSlib.utils.table.isEmpty(t) return not next(t)        end

    function LSlib.utils.table.size(t)
      local size = 0
      for _,_ in pairs(t or {}) do
        size = size + 1
      end
      return size
    end

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

    function LSlib.utils.table.orderedPairs(t)
      -- Ordered table iterator, allow to iterate on the natural
      -- order of the keys of a table. Equivalent of the pairs()
      -- function on tables. Allows to iterate in order.
      --
      -- More info: http://lua-users.org/wiki/SortedIteration

      local function orderedNext(t, state)
        -- Equivalent of the next function, but returns the keys in the alphabetic
        -- order. We use a temporary ordered key table that is stored in the
        -- table being iterated.

        local function __genOrderedIndex(t)
          -- generate the index
          local orderedIndex = {}
          local n = 1
          for key in pairs(t) do
            -- table.insert(orderedIndex, key)
            orderedIndex[n] = key
            n = n + 1
          end
          table.sort(orderedIndex)
          return orderedIndex
        end

        local key = nil
        --print("orderedNext: state = "..tostring(state) )
        if state == nil then
          -- the first time, generate the index
          t.__orderedIndex = __genOrderedIndex(t)
          key = t.__orderedIndex[1]
        else
          -- fetch the next value
          for i = 1, #t.__orderedIndex do
            if t.__orderedIndex[i] == state then
              key = t.__orderedIndex[i+1]
            end
          end
        end

        if key then
          return key, t[key]
        end

        -- no more value to return, cleanup
        t.__orderedIndex = nil
        return
      end

      return orderedNext, t, nil
    end

  end
else
  require "utils"
end
