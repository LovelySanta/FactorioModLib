
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
    if not data.raw["technology"][technologyName]               then return end
    if not data.raw["technology"][technologyName].prerequisites then return end

    if LSlib.technology.prereqcache[technologyName] then
      return LSlib.technology.prereqcache[technologyName]
    else
      -- temporary fill in the prerequisites to prevent stack overflow due to loops in technology tree
      LSlib.technology.prereqcache[technologyName] = {}

      local prerequisites = {} -- all prerequisites for this tech
      for _, prerequisiteName in pairs(data.raw["technology"][technologyName].prerequisites) do
        LSlib.technology.prereqcache[technologyName][prerequisiteName] = true

        -- now get the prerequisite of all the prerequisites and add those as well
        local prePrerequisites = LSlib.technology.getAllPrerequisites(prerequisiteName)
        for prePrerequisiteName,_ in pairs(prePrerequisites or {}) do
          LSlib.technology.prereqcache[technologyName][prePrerequisiteName] = true
        end
      end

      -- now we have all prerequisites
      return LSlib.technology.prereqcache[technologyName]
    end
  end



  function LSlib.technology.removeDuplicatePrerequisites(technologyName)
    if not data.raw["technology"][technologyName]               then return end
    if not data.raw["technology"][technologyName].prerequisites then return end

    -- STEP 1: obtain all the prerequisites once (so no duplicates)
    local prerequisites = {}
    local containDuplicates = false
    for _,prerequisiteName in pairs(data.raw["technology"][technologyName].prerequisites) do
      if prerequisites[prerequisiteName] then -- already contains one, we found a duplicate
        containDuplicates = true
        LSlib.utils.log.log(string.format("TechTreeCleanup: Removing duplicate prerequisite %q from technology %q.", prerequisiteName, technologyName))
      else
        prerequisites[prerequisiteName] = true
      end
    end

    if containDuplicates then
      -- STEP 2: if we have duplicates, we create a new prerequisite table without duplicates
      local newPrerequisites = {}
      for prerequisiteName,_ in pairs(prerequisites) do
        table.insert(newPrerequisites, prerequisiteName)
      end

      -- STEP 3: we use this newly created prerequisite table in the technology tree
      data.raw["technology"][technologyName].prerequisites = util.table.deepcopy(newPrerequisites)
    end
  end



  function LSlib.technology.removeHiddenPrerequisites(technologyName)
    if not data.raw["technology"][technologyName]               then return end
    if not data.raw["technology"][technologyName].prerequisites then return end

    -- STEP 1: obtain all the valid prerequisites (no hidden ones)
    local newPrerequisites = {}
    local containHidden = false
    for _,prerequisiteName in pairs(data.raw["technology"][technologyName].prerequisites) do
      if LSlib.technology.isHidden(prerequisiteName) or (not LSlib.technology.isEnabled(prerequisiteName)) then
        containHidden = true
        LSlib.utils.log.log(string.format("TechTreeCleanup: Removing hidden prerequisite %q from technology %q.", prerequisiteName, technologyName))
      else
        table.insert(newPrerequisites, prerequisiteName)
      end
    end

    if containHidden then
      -- STEP 2: if we have hidden duplicates, we leave only the non-hidden ones
      data.raw["technology"][technologyName].prerequisites = util.table.deepcopy(newPrerequisites)
    end
  end



  function LSlib.technology.removeRedundantPrerequisites(technologyName)
    if not data.raw["technology"][technologyName]               then return end
    if not data.raw["technology"][technologyName].prerequisites then return end

    -- we will check for all prerequisites
    local oldPrerequisites = util.table.deepcopy(data.raw["technology"][technologyName].prerequisites) -- make it read only
    local removedPrerequisites = {}
    for _,prerequisiteName in pairs(oldPrerequisites) do

      -- STEP 1: obtain the prerequisites of a prerequisite
      local prePrerequisites = LSlib.technology.getAllPrerequisites(prerequisiteName) or {}

      -- STEP 2a: now we check if any prerequisite of the tech is redundant because
      --          it could be a prerequisite of this prerequisite
      for redundantPrerequisiteIndex,redundantPrerequisiteName in pairs(oldPrerequisites) do
        if redundantPrerequisiteName ~= prerequisiteName         and -- no need to check itself
           (not removedPrerequisites[redundantPrerequisiteName]) and -- not already deleted
           prePrerequisites[redundantPrerequisiteName]           then -- must be redundant

          -- STEP 2b: remove the technology prerequisite if the prerequisite is a prerequisite of another technology prerequisite
          --data.raw["technology"][technologyName].prerequisites[redundantPrerequisiteIndex] = nil -- remove it
          LSlib.technology.removePrerequisite(technologyName, redundantPrerequisiteName) -- remove it
          removedPrerequisites[redundantPrerequisiteName] = true
          LSlib.utils.log.log(string.format("TechTreeCleanup: Removing redundant prerequisite %q from technology %q.", redundantPrerequisiteName, technologyName))
        end
      end

    end
  end



  function LSlib.technology.removeAllRedundantPrerequisites()
    --LSlib.utils.log.enable()

    if not LSlib.technology.prereqcache then
      LSlib.technology.prereqcache = {}
    end

    -- STEP 1: we remove duplicate entries in the technology table
    for technologyName, technology in pairs(data.raw["technology"]) do
      LSlib.technology.removeDuplicatePrerequisites(technologyName)
    end

    -- STEP 2: we remove hidden entries in the technology table
    for technologyName, technology in pairs(data.raw["technology"]) do
      LSlib.technology.removeHiddenPrerequisites(technologyName)
    end

    -- STEP 3: remove the redundant entries
    for technologyName, technology in pairs(data.raw["technology"]) do
      LSlib.technology.removeRedundantPrerequisites(technologyName)
    end

    LSlib.technology.prereqcache = nil
  end

end
