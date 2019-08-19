
if LSlib and LSlib.utils then
  if not LSlib.utils.units then LSlib.utils.units = {}

    LSlib.utils.units.localisedPrefixes = {
      {"si-prefix-symbol-kilo"},
      {"si-prefix-symbol-mega"},
      {"si-prefix-symbol-giga"},
      {"si-prefix-symbol-tera"},
      {"si-prefix-symbol-peta"},
      {"si-prefix-symbol-exa"},
      {"si-prefix-symbol-zetta"},
      {"si-prefix-symbol-yotta"}
    }

    function LSlib.utils.units.getLocalisedUnit(value, localisedUnitSymbol, roundPresicion)
      -- roundPresicion defaults to 0 (aka integer value)

      local prefix = #LSlib.utils.units.localisedPrefixes
      local prefixIndex = 0
      while (value > 1000 and prefixIndex < prefix) do
        value = value / 1000
        prefixIndex = prefixIndex + 1
      end
      prefix = LSlib.utils.units.localisedPrefixes[prefixIndex]

      if roundPresicion then -- make sure it is an uint value
        roundPresicion = math.floor(roundPresicion + 0.5)
        roundPresicion = roundPresicion > 0 and roundPresicion or nil
      end

      return {"",
        string.format(roundPresicion and "%."..roundPresicion.."f " or "%i ", value),
        prefix or localisedUnitSymbol, prefix and localisedUnitSymbol or nil,
      }
    end

  end
else
  require "utils"
end
  