
if not LSlib.technology then require "technology" else

  function LSlib.technology.removePrerequisite(technologyName, prerequisiteToRemove)
    if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].prerequisites then
      for index, prerequisite in pairs(data.raw["technology"][technologyName].prerequisites) do
        if prerequisite == prerequisiteToRemove then
          table.remove(data.raw["technology"][technologyName].prerequisites, index)
          if table_size(data.raw["technology"][technologyName].prerequisites) == 0 then
            data.raw["technology"][technologyName].prerequisites = nil
          end
          break
        end
      end
    end
  end



  function LSlib.technology.addPrerequisite(technologyName, prerequisiteToAdd)
    if data.raw["technology"][technologyName] then
      if not data.raw["technology"][technologyName].prerequisites then
        data.raw["technology"][technologyName].prerequisites = {}
      end
      for index, prerequisite in pairs(data.raw["technology"][technologyName].prerequisites) do
        if prerequisite == prerequisiteToAdd then
          LSlib.utils.log.log(string.format("WARNING: Tried adding prerequisite %q to %q, which was already present.", prerequisiteToAdd, technologyName))
          return
        end
      end
      table.insert(data.raw["technology"][technologyName].prerequisites, prerequisiteToAdd)
    end
  end



  function LSlib.technology.movePrerequisite(technologyName, oldPrerequisite, newPrerequisite)
    if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].prerequisites then
      local moved = false
      for index, prerequisite in pairs(data.raw["technology"][technologyName].prerequisites) do
        if prerequisite == oldPrerequisite then
          data.raw["technology"][technologyName].prerequisites[index] = newPrerequisite
          moved = true
          break
        end
      end
      if not moved then
        LSlib.utils.log.log(string.format("WARNING: Could not move prerequisite %q from technology %q to %q. Adding it instead.", oldPrerequisite, technologyName, newPrerequisite))
        LSlib.technology.addPrerequisite(technologyName, newPrerequisite)
      end
    end
  end



  function LSlib.technology.getAllPrerequisites(technologyName)
    if not data.raw["technology"][technologyName] then return nil end
    if not data.raw["technology"][technologyName].prerequisites then return nil end

    if LSlib.technology.prereqcache[technologyName] then return LSlib.technology.prereqcache[technologyName] end

    -- temporary till we find all prerequisites (this is to prevent loop, stack overflow)
    LSlib.technology.prereqcache[technologyName] = util.table.deepcopy(data.raw["technology"][technologyName].prerequisites)

    -- get all none-reduntant prerequisites now
    local prerequisites = util.table.deepcopy(data.raw["technology"][technologyName].prerequisites)
    for _,prerequisiteName in pairs(data.raw["technology"][technologyName].prerequisites) do
      local prerequisiteTable = LSlib.technology.getAllPrerequisites(prerequisiteName)
      if prerequisiteTable then
        for _, prerequisite in pairs(prerequisiteTable) do
          table.insert(prerequisites, prerequisite)
        end
      end
    end

    -- save all the none-redundant prerequisites now
    LSlib.technology.prereqcache[technologyName] = prerequisites
    return prerequisites
  end



  function LSlib.technology.removeRedundantPrerequisites(technologyName)
    if not data.raw["technology"][technologyName].prerequisites then return end

    -- iterate over all prerequisites to check if they are redundant
    for _,prerequisiteName in pairs(util.table.deepcopy(data.raw["technology"][technologyName].prerequisites)) do

      -- STEP 1: obtain the prerequisites of a prerequisite
      local prerequisites = LSlib.technology.getAllPrerequisites(prerequisiteName)
      if prerequisites then

        -- STEP 2a: check for all the other prerequisites of the technology
        for _,prerequisite in pairs(util.table.deepcopy(data.raw["technology"][technologyName].prerequisites)) do
          if prerequisite ~= prerequisiteName then -- no need to check itself

            -- STEP 2b: remove the technology prerequisite if the prerequisite is a prerequisite of another technology prerequisite
            for _, name in pairs(prerequisites) do
              if name == prerequisite then
                --remove prerequisite
                for k,v in pairs(data.raw["technology"][technologyName].prerequisites) do
                  if v == prerequisite then
                    table.remove(data.raw["technology"][technologyName].prerequisites, k)
                    LSlib.utils.log.log(string.format("TechTreeCleanup: Removing prerequisite %q from technology %q.", prerequisite, technologyName))
                  end
                end
              end
            end
          end
        end
      end
    end
  end



  function LSlib.technology.removeAllRedundantPrerequisites()
    if not LSlib.technology.prereqcache then
      LSlib.technology.prereqcache = {}
    end

    for _, technology in pairs(data.raw["technology"]) do
      LSlib.technology.removeRedundantPrerequisites(technology.name)
    end

    LSlib.technology.prereqcache = nil
  end

end
