RegisterNetEvent("reminder:broadcast")

AddEventHandler("reminder:broadcast", function(args)
	TriggerClientEvent("reminder:broadcast", -1, args[1])
end)