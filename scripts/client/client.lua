RegisterCommand("givehorse", function()

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


end, false)


RegisterCommand("giveweapon", function(source --[[ this is the player ID (on the server): a number ]], args --[[ this is a table of the arguments provided ]], rawCommand --[[ this is what the user entered ]])

    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Console", "Giving weapons"}
      })

    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), 1000, false, true)

end, false) -- this true bool means that the user cannot execute the command unless they have the 'command.commandName' ACL object allowed to one of their identifiers.

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