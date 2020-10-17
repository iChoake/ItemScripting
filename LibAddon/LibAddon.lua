
ADDON     = { }
LIBARY    = { }

print     = d
strformat = zo_strformat
calllater = zo_callLater

local EM = EVENT_MANAGER

function Addon (addon)

  -- Addon Module Managment ---------

  local MODULES = { }

  local function Require (name)
    if MODULES[name] then return MODULES[name] end
    if LIBARY[name] then return LIBARY[name] end
    error(strformat('require "%s" was not found.', name))
  end

  local function Export (name, value, public)
    if public then 
      LIBARY[addon] = LIBARY[addon] or {}
      LIBARY[addon][name] = value
    end MODULES[name] = value
  end

  -- Local Addon Events -------------

  local EVENTS = { }

  local function Register (name, func)
    EVENTS[name] = EVENTS[name] or {}
    table.insert(EVENTS[name], func)
  end

  local function Trigger (name, ...)
    if not EVENTS[name] then return end
    for _, func in pairs(EVENTS[name]) do func(...) end
  end

  -- Game Events --------------------

  local function On (id, func)
    if type(id) == 'string' then Register(id, func)
    else EM:RegisterForEvent(addon, id, func) end
  end

  local function Forget (id)
    EM:UnregisterForEvent(addon, id)
  end

  local function OnUpdate (delay, func)
    EM:RegisterForUpdate(addon, delay, func)
  end

  local function ForgetUpdate ()
    EM:UnregisterForUpdate(addon)
  end

  local function Filter (id, filter, condition)
    EM:AddFilterForEvent(addon, id, filter, condition)
  end

  local function Loaded (func)
    On(EVENT_ADD_ON_LOADED, function(code, name) 
      if not addon == name then return end
      Forget(EVENT_ADD_ON_LOADED); func()
    end)
  end

  -- Create Addon Entry -------------

  if not ADDON[addon] then ADDON[addon] = 
    { Require, Export, 
    { On           = On
    , OnUpdate     = OnUpdate 
    , Trigger      = Trigger
    , Forget       = Forget
    , ForgetUpdate = ForgetUpdate
    , Filter       = Filter
    , Loaded       = Loaded }}
  end

  return unpack(ADDON[addon])
end

function with (object)
  return setmetatable (
  { value = function() return object end }, 
  { __index = function(self, ...)  
      assert(object[func], 'function not found in object')
      object[func](object, ...)
      return self
    end })
end