
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
      while (value > 1000.0 and prefixIndex < prefix) do
        value = value / 1000.0
        prefixIndex = prefixIndex + 1
      end
      prefix = LSlib.utils.units.localisedPrefixes[prefixIndex]

      if roundPresicion then -- make sure roundPresicion is a uint value
        roundPresicion = math.floor(roundPresicion + 0.5)
        roundPresicion = roundPresicion > 0 and roundPresicion or nil
      end

      if roundPresicion then -- make sure to not add trailing zeros
        local stringValue = string.format("%."..roundPresicion.."f", value)
        local stringIndex = 0
        while(stringIndex < roundPresicion and string.sub(stringValue, -1 - stringIndex, -1 - stringIndex) == "0") do
          stringIndex = stringIndex + 1
        end
        roundPresicion = roundPresicion - stringIndex
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
