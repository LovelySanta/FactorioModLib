
if LSlib and LSlib.utils then
  if not LSlib.utils.table then require "utils-table" end
  if not LSlib.utils.log   then LSlib.utils.log = {}

    function LSlib.utils.log.enable()  LSlib.utils.log.enabled = true  end
    function LSlib.utils.log.disable() LSlib.utils.log.enabled = false end
    LSlib.utils.log.disable() -- disable logging by default

    function LSlib.utils.log.isEnabled()
      return LSlib.utils.log.enabled or false
    end

    function LSlib.utils.log.log(variableToLog)
      if LSlib.utils.log.isEnabled() then
        if LSlib.utils.table.isTable(variableToLog) then
          log(serpent.block(variableToLog))
        else
          log(variableToLog)
        end
      end
    end

    function LSlib.utils.log.getStackTraceback()
      -- https://www.lua.org/manual/5.2/manual.html#pdf-debug.traceback
      return debug.traceback()
    end

    function LSlib.utils.log.logStackTraceback()
      LSlib.utils.log.log(LSlib.utils.log.getStackTraceback())
    end

  end
else
  require "utils"
end
