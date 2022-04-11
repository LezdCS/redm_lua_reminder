--[[
  Spawn Vehicules & Peds
  Peds list : https://github.com/femga/rdr3_discoveries/blob/master/peds/peds_list.lua
  Vehicules hashes : https://github.com/femga/rdr3_discoveries/blob/master/vehicles/vehicles_list.lua
]]--

RegisterCommand("spawnhorse", function()

    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Console", "Horse spawned"}
    })

    local playerPedId = PlayerPedId()
    local pos = GetEntityCoords(playerPedId)
    local forwardPos = GetEntityForwardVector(playerPedId)
    pos = pos + forwardPos*5
    local hash = GetHashKey("coach2")
    RequestModel(hash)
    CreateVehicle(hash, pos.x, pos.y, pos.x, GetEntityHeading(playerPedId), false, false, false, false)

end, false)

RegisterCommand("createped", function()

  TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = true,
      args = {"Console", "Creating ped"}
  })

  local playerPedId = PlayerPedId()
  local pos = GetEntityCoords(playerPedId)
  local forwardPos = GetEntityForwardVector(playerPedId)
  pos = pos + forwardPos*5

-- PED
  local hash = GetHashKey("A_F_M_ARMCHOLERACORPSE_01")
  RequestModel(hash)
  local ped = CreatePed(hash, pos.x, pos.y, pos.z, GetEntityHeading(playerPedId), false, false, false, false)
  Citizen.InvokeNative(0x283978A15512B2FE, ped, true)

-- PED BLIP
  -- attaché au ped
  local blip = Citizen.InvokeNative(0x23F74C2FDA6E7C61, 1664425300, ped)
  -- attaché à des coords
  -- local blip = N_0x554d9d53f696d002(1664425300, pos.x, pos.y, pos.z)
  SetBlipSprite(blip, -1025216818, 1) -- Sprite of the Blip
  SetBlipScale(blip, 0.2) -- Scale of the Blip
  Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Test title") -- Name of the Blip

end, false)

--[[
  Scenarios & Animations
  Scenarios list : https://github.com/femga/rdr3_discoveries/blob/master/animations/scenarios/scenario_types_with_conditional_anims.lua
]]--

RegisterCommand("startscenario", function()

    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Console", "Starting scenario"}
      })

    local hash = GetHashKey("WORLD_HUMAN_SMOKE")
    RequestModel(hash)

    TaskStartScenarioInPlace(PlayerPedId(),hash, -1 ,true, false, false, false)

end, false)


RegisterCommand("stopscenario", function()

    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Console", "Stoping scenario"}
    })

    local playerPedId = PlayerPedId()
    ClearPedTasks(playerPedId)
    -- ClearPedTasksImmediately(playerPedId, false, false) -- ne joue pas l'animation de fin


end, false)

--[[
  Give weapons
  Weapons list : https://github.com/femga/rdr3_discoveries/blob/master/weapons/weapons.lua
  Components list : https://github.com/femga/rdr3_discoveries/blob/master/weapons/weapon_components.lua
  Ammo types list: https://github.com/femga/rdr3_discoveries/blob/master/weapons/ammo_types.lua
]]--

RegisterCommand("giveweapon", function(source --[[ this is the player ID (on the server): a number ]], args --[[ this is a table of the arguments provided ]], rawCommand --[[ this is what the user entered ]])

    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Console", "Giving weapons"}
    })

    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), 1000, false, true)

end, false) -- this true bool means that the user cannot execute the command unless they have the 'command.commandName' ACL object allowed to one of their identifiers.


--[[
  Weather & Time
  Weather types list : https://github.com/femga/rdr3_discoveries/blob/master/weather/weather_types.lua
]]--

RegisterCommand("setweather", function(source, args)

  TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = true,
      args = {"Console", "Setting weather to " .. tostring(args[1])}
  })

  local transition_time_in_seconds = 2.0
  local next_weather_type = tostring(args[1])
  local next_weather_type_hash = GetHashKey(next_weather_type)

  -- Citizen.InvokeNative(0x80A398F16FFE3CC3)  -- CLEAR_OVERRIDE_WEATHER ClearOverrideWeather()
  -- Citizen.InvokeNative(0x3373779BAF7CAF48, "THUNDERSTORM", "THUNDERSTORM_MP_Pred")  -- override weather variation
  Citizen.InvokeNative(0x59174F1AFE095B5A, next_weather_type_hash, true, true, true, transition_time_in_seconds, false)  -- SET_WEATHER_TYPE

end, false)

RegisterCommand("clearweather", function()

  TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = true,
      args = {"Console", "Clearing weather"}
  })

  -- to clear weather variation (in this case, THUNDERSTORM will return to the default state):
  ClearOverrideWeather()
  -- Citizen.InvokeNative(0x0E71C80FA4EC8147, "THUNDERSTORM", true)

end, false)

RegisterCommand("day", function()

  TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = true,
      args = {"Console", "Setting time to day"}
  })


  Citizen.InvokeNative(0x669E223E64B1903C, 12, 00, 00, 6, true)

end, false)

RegisterCommand("night", function()

  TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = true,
      args = {"Console", "Setting time to night"}
  })


  Citizen.InvokeNative(0x669E223E64B1903C, 00, 00, 00, 6, true)

end, false)

--[[
  Teleportation
]]--

RegisterCommand("tpm", function()

  TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = true,
      args = {"Console", "Teleporting to marker"}
  })
  local player = PlayerPedId()
  local waypoint = GetWaypointCoords()
  -- SetEntityCoords(player, waypoint.x, waypoint.y, 1)
  for height = 1, 1000.0 do
    SetEntityCoords(player, waypoint.x, waypoint.y, height + 0.0)

    local foundground, groundZ, normal = GetGroundZAndNormalFor_3dCoord(waypoint.x, waypoint.y, height + 0.0)
    if foundground then
      SetEntityCoords(player, waypoint.x, waypoint.y, height + 0.0)
      break
    end
    Wait(25)
  end

end, false)

-- Citizen.CreateThread(function()
--   local player = PlayerPedId()
--   while true do
--     print("okl")
--     print(GetEntityCoords(player, true, true))
--     Citizen.Wait(100)
--   end
-- end)

--[[
  Communication client -> server & server -> client
]]--

RegisterCommand("broadcast", function(source, args)

  TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = true,
      args = {"Console", "Sending message to everyone"}
  })

  TriggerServerEvent("reminder:broadcast", args)

end, false)

RegisterNetEvent("reminder:broadcast")
AddEventHandler("reminder:broadcast", function(message)

  TriggerEvent('chat:addMessage', {
    color = { 150, 0, 0},
    multiline = true,
    args = {"BROADCAST", message}
})

end)



--[[
  UI display & callbacks client
]]--

RegisterNUICallback("exit", function()
  print("exited")
  SetDisplay(false)
end)

RegisterCommand("opentestui", function(source, args)

  TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = true,
      args = {"Console", "Opening test UI"}
  })

  SetDisplay(true)

end, false)

local display = false
function SetDisplay(bool)
  display = bool
  SetNuiFocus(bool, bool)
  SendNUIMessage({
      type="ui",
      status = bool,
  })
end

Citizen.CreateThread(function()
  while display do
      Citizen.Wait(0)
      -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
      --[[ 
          inputGroup -- integer , 
        control --integer , 
          disable -- boolean 
      ]]
      DisableControlAction(0, 1, display) -- LookLeftRight
      DisableControlAction(0, 2, display) -- LookUpDown
      DisableControlAction(0, 142, display) -- MeleeAttackAlternate
      DisableControlAction(0, 18, display) -- Enter
      DisableControlAction(0, 322, display) -- ESC
      DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
  end
end)