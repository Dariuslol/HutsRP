QBCore = exports['qb-core']:GetCoreObject()

local TakePoint = vector3(121.83, -1063.15, 29.19)
local SpawnPoint = vector3(127.03, -1074.83, 29.19)
local Borg = 2000


RegisterCommand('+drukOpE', function() -- Function called when key is pressed
	-- print('Je hebt E ingedrukt')
    
end, false)

RegisterCommand('-drukOpE', function() -- Function called when key is released
	-- print('Je hebt E losgelaten')
end, false)

RegisterCommand('+explode', function() -- Function called when key is released
	local id = PlayerPedId();
    local coords = GetEntityCoords(id, true)
    print(coords.x, coords.y,  coords.z)
    AddExplosion(coords.x, coords.y, coords.z, 9, 0.9, true, true, 1065353216)
end, false)

-- vector3(197.03, -932.71, 30.69)


--					Command     Description  Input      Key
RegisterKeyMapping('+drukOpE', 'Druk E in', 'keyboard', 'e')
RegisterKeyMapping('+explode', 'Explosie', 'keyboard', 'n')


function DrawText3D(x, y, z, text) -- Draw text in 3D space
	local onScreen, worldX, worldY = GetScreenCoordFromWorldCoord(x, y, z)
	local camCoords = GetFinalRenderedCamCoord()
	local scale = 200 / (GetGameplayCamFov() * #(camCoords - vector3(x, y, z)))
	if onScreen then
		SetTextScale(1.0, 0.5 * scale)
		SetTextFont(4)
		SetTextColour(255, 255, 255, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextProportional(true)
		SetTextOutline()
		SetTextCentre(true)
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringPlayerName(text)
		EndTextCommandDisplayText(worldX, worldY)
	end
end

CreateThread(function() 									-- We don't want to block the main thread, create a new thread for this loop.
	while true do
		Wait(0)                                 			-- Don't crash the game
		if LocalPlayer.state.isLoggedIn then    			-- Wait for player to be logged in
			local myPos = GetEntityCoords(PlayerPedId())	-- Get player position
			local dist = #(myPos - TakePoint)   			-- Calculate distance between player and take point

			if dist < 5.0 then                 			 	-- Check if player is near the take point
				-- Draw marker at take point
				DrawMarker(2, TakePoint.x, TakePoint.y, TakePoint.z, 0.0, 0.0, 0.0, 0.0,
					0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false, true, false, false, false)

				if dist < 1.0 then -- Only show text if player is close enough
					DrawText3D(TakePoint.x, TakePoint.y, TakePoint.z, "~g~E~s~ - Pak Neon")
                    if IsControlJustPressed(0, 38) then
                        print(IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId())
                        if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId()  then
                            TriggerServerEvent('eerste-resource:server:krijgBorg', Borg)
                        else
                            TriggerServerEvent('eerste-resource:server:betaalBorg', Borg)
                        end
                    end
				end
			else 
				Wait(100) -- Wait a tenth of a second if player is not near the take point
			end
		else
			Wait(1000) -- Wait a second if player is not logged in
		end
	end
end)


RegisterNetEvent('eerste-resource:client:spawnNeon', function()
    print("hello client")
    QBCore.Functions.SpawnVehicle('neon', function(veh)                    			-- Spawn vehicle
        exports['LegacyFuel']:SetFuel(veh, 100.0)                         			-- Set fuel to 100%
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh)) -- Set vehicle owner
        SetVehicleEngineOn(veh, true, true, false)                         			-- Turn engine on
    end, SpawnPoint, true, true)  

end)

RegisterNetEvent('eerste-resource:client:despawnNeon', function()
    print("hello client")
    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
end)

RegisterNetEvent('test')
AddEventHandler('test', function(var)
    print(var, 'hello')
end)