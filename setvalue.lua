local function SetGcValue(str, val)
    local garbage = getgc(true) -- getgc is a powerful and potentially dangerous function, typically only available in specific contexts (e.g., exploits, custom Lua environments).

    for i, Table in next, garbage do
        if type(Table) == "table" and not table.isfrozen(Table) then
            -- Check if the key 'str' exists in the table.
            -- We only care if it's *not nil*, meaning the key is present.
            if rawget(Table, str) ~= nil then
                rawset(Table, str, val)
                print("SetGarbageCollectionValue - Method Completed " .. str .. " Set To " .. tostring(val))
            end
        end
    end
end


local function SetValue(str,val)
SetGcValue(str,val)
local stam = nil

for i,v in pairs(game:GetDescendants()) do
if v.Name == str then
stam = v
break
end
end

if not stam then
warn("Not Found, function SetValue - 2nd method/ if you didnt see first method then that didnt work either")
return
end

local stamh;

stamh = hookmetamethod(game, "__index", function(self, v)

if self == stam and v == "Value" then
print("SetValue - Method 2 (hookmetamethod) Completed " .. str .. "Set To " .. val)
return val
end
return stamh(self, v)
end)

end

local function SetGcValue(str,val)
local garbage = getgc(true)

for i, Table in next, garbage do
if type(Table) == "table" and rawget(Table, str) and not table.isfrozen(Table) then
rawset(Table, str, val)
print("SetGarbageCollectionValue - Method Completed " .. str .. "Set To " .. val)
end
end

end

local function AddProperty(inst,prop)

local NumberValue = Instance.new(inst)
local nv_mt = getrawmetatable(NumberValue)
NumberValue:Destroy()

make_writeable(nv_mt)
local old_nv_index = nv_mt.__index
local old_nv_newindex = nv_mt.__newindex
local customAnchoredStates = setmetatable({}, {__mode = "k"}) -- Weak keys

nv_mt.__index = function(self, key)
    if key == prop then
        return customAnchoredStates[self] or false
    end
    
    if old_nv_index then
        return old_nv_index(self, key)
    else
        return nil
    end
end

nv_mt.__newindex = function(self, key, value)
    if key == prop then
        customAnchoredStates[self] = value
        return
    end

    if old_nv_newindex then
        old_nv_newindex(self, key, value)
    else
        rawset(self, key, value)
    end
end

end

local function LoopSetProperty(str,class,value)
local mt = getrawmetatable(game)
make_writeable(mt)

mt.__index = function(a, b)
if tostring(a) == str then
if tostring(b) == class then
return value
end
end
end

end

local function SetModuleProperty(moduleName, propertyName, newValue)
    local moduleScript = nil

    -- Find the ModuleScript by name
    for i, v in pairs(game:GetDescendants()) do
        if v.Name == moduleName and v:IsA("ModuleScript") then
            moduleScript = v
            break
        end
    end

    if not moduleScript then
        warn("ModuleScript '" .. moduleName .. "' not found!")
        return false -- Indicate failure
    end

    print("Found ModuleScript: " .. moduleScript.Name)

    local loadedModule = require(moduleScript)
    local propertiesAffectedCount = 0 -- To keep track of how many properties were changed

    -- Recursive helper function to search through tables and set all occurrences
    local function recursiveSetAll(currentTable)
        if type(currentTable) ~= "table" then
            return -- Not a table, can't search further
        end

        for key, value in pairs(currentTable) do
            if key == propertyName then
                -- Found an instance of the property!
                currentTable[key] = newValue
                propertiesAffectedCount = propertiesAffectedCount + 1
                print(string.format("  Set '%s' (found at key: '%s') to '%s'", propertyName, key, tostring(newValue)))
            end

            -- Regardless of whether we set the current key, if the value is a table, recurse into it
            if type(value) == "table" then
                recursiveSetAll(value)
            end
        end
    end

    -- Start the recursive search from the loaded module
    recursiveSetAll(loadedModule)

    if propertiesAffectedCount > 0 then
        print(string.format("Finished: Set '%s' for %d occurrences in module '%s'.", propertyName, propertiesAffectedCount, moduleName))
        return true
    else
        warn(string.format("Finished: Property '%s' not found in module '%s' or its nested tables.", propertyName, moduleName))
        return false
    end
end

local function SetEnvironment(Value)
    for i, v in next, Value do
        getgenv()[i] = v
    end
end

SetEnvironment({
SetValue = SetValue,
AddProperty = AddProperty,
LoopSetProperty = LoopSetProperty,
SetProperty = SetProperty,
SetModuleProperty = SetModuleProperty,
SetGcValue = SetGcValue
})

-- END
