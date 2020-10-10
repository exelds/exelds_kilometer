ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
	end
end)

RegisterCommand("km",function(source)
	local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, true), -1) == playerPed then
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		local plate = GetVehicleNumberPlateText(vehicle)
		ESX.TriggerServerCallback('ExeLds:getKilometer', function(kilometre)
			kilometre = 500
			if kilometre > Config.asama4km then		
				exports['mythic_notify']:SendAlert('inform', 'Aracın toplam gittiği yol: '..kilometre..'km', 5000, { ['background-color'] = '#CC0000', ['color'] = '#FFFFFF' })
			elseif kilometre > Config.asama3km then		
				exports['mythic_notify']:SendAlert('inform', 'Aracın toplam gittiği yol: '..kilometre..'km', 5000, { ['background-color'] = '#FF6666', ['color'] = '#000000' })
			elseif kilometre > Config.asama2km then		
				exports['mythic_notify']:SendAlert('inform', 'Aracın toplam gittiği yol: '..kilometre..'km', 5000, { ['background-color'] = '#FF9999', ['color'] = '#000000' })
			elseif kilometre > Config.asama1km then		
				exports['mythic_notify']:SendAlert('inform', 'Aracın toplam gittiği yol: '..kilometre..'km', 5000, { ['background-color'] = '#FFCCCC', ['color'] = '#000000' })
			elseif kilometre <= Config.asama1km then		
				exports['mythic_notify']:SendAlert('inform', 'Aracın toplam gittiği yol: '..kilometre..'km', 5000, { ['background-color'] = '#FFFFFF', ['color'] = '#000000' })
			end
		end, plate)	
	else
		exports['mythic_notify']:SendAlert('error', 'Şoför koltuğunda oturduğun bir araç bulunamadı!', 5000)
	end	
end,false)

local ownedVehicles = {}
local lastCoords
local currentKilometer

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, true), -1) == playerPed then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			local plate = GetVehicleNumberPlateText(vehicle)
			if ownedVehicles[plate] == nil then
				ESX.TriggerServerCallback('ExeLds:getOwnedCarInfo', function(result)
					if result then
						ownedVehicles[plate] = 1
					else
						ownedVehicles[plate] = 0
					end
				end, plate)									
			end	
			
			if ownedVehicles[plate] and ownedVehicles[plate] > 0 then
				local currentCoords = GetEntityCoords(playerPed)
				if lastCoords == nil then
					lastCoords = currentCoords
				end
				local distance = GetDistanceBetweenCoords(currentCoords, lastCoords, true)
				lastCoords = currentCoords			
				ownedVehicles[plate] = ownedVehicles[plate] + distance
				if ownedVehicles[plate] > 1000 then
					TriggerServerEvent('ExeLds:updateCar', plate)
					ownedVehicles[plate] = 1
				end
			end
		else
			lastCoords = nil
			currentKilometer = nil
			ownedVehicles = {}
		end	
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, true), -1) == playerPed then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			local plate = GetVehicleNumberPlateText(vehicle)
			ESX.TriggerServerCallback('ExeLds:getKilometer', function(kilometre)		
				currentKilometer = kilometre
			end, plate)	
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)		
		local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, true), -1) == playerPed then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())	
			if currentKilometer == nil then
				local plate = GetVehicleNumberPlateText(vehicle)
				ESX.TriggerServerCallback('ExeLds:getKilometer', function(kilometre)		
					currentKilometer = kilometre
				end, plate)	
			else
				if currentKilometer and currentKilometer > Config.asama1km then
					if GetVehicleDirtLevel(vehicle) < 5 then
						SetVehicleDirtLevel(vehicle, 5.0)
					end	
					local health = GetVehicleEngineHealth(vehicle)
					if health > 800 then
						SetVehicleEngineHealth(vehicle, 800.0)
					end					
				end

				if currentKilometer and currentKilometer > Config.asama2km then
					if GetVehicleDirtLevel(vehicle) < 7 then
						SetVehicleDirtLevel(vehicle, 7.0)
					end	
					local health = GetVehicleEngineHealth(vehicle)
					if health > 700 then
						SetVehicleEngineHealth(vehicle, 700.0)
					end	
					local hiz = GetEntitySpeed(vehicle) * 3.6
					if hiz > Config.kritikHiz then
						local sans = math.random(1, Config.asama2sansHizli[2])
						if sans <= Config.asama2sansHizli[1] then
							local lastFuel = GetVehicleFuelLevel(vehicle)  
							SetVehicleFuelLevel(vehicle, 2.0)
							Citizen.Wait(0)
							SetVehicleFuelLevel(vehicle, lastFuel)						
						end
					else
						local sans = math.random(1, Config.asama2sans[2])
						if sans <= Config.asama2sans[1] then
							local lastFuel = GetVehicleFuelLevel(vehicle)  
							SetVehicleFuelLevel(vehicle, 5.0)
							Citizen.Wait(0)
							SetVehicleFuelLevel(vehicle, lastFuel)						
						end
					end
				end

				if currentKilometer and currentKilometer > Config.asama3km then
					if GetVehicleDirtLevel(vehicle) < 10 then
						SetVehicleDirtLevel(vehicle, 10.0)
					end	
					local health = GetVehicleEngineHealth(vehicle)
					if health > 600 then
						SetVehicleEngineHealth(vehicle, 600.0)
					end	
					local hiz = GetEntitySpeed(vehicle) * 3.6
					if hiz > Config.kritikHiz then
						local sans = math.random(1, Config.asama3sansHizli[2])
						if sans <= Config.asama3sansHizli[1] then
							exports['mythic_notify']:SendAlert('error', 'Arabanın motoru aşırı hızın etkisiyle stop etti!', 2500)
							local counter = 0
							while counter < 1500 do
								SetVehicleEngineOn(vehicle,false,false,false)
								SetVehicleUndriveable(vehicle,true)
								counter = counter + 1
								Citizen.Wait(10)
							end					
							exports['mythic_notify']:SendAlert('success', 'Arabanın motoru tekrar çalışır durumda!', 2500)
							SetVehicleUndriveable(vehicle,false)
							SetVehicleEngineOn(vehicle,true,false,false)
						end
					else
						local sans = math.random(1, Config.asama3sans[2])
						if sans <= Config.asama3sans[1] then
							exports['mythic_notify']:SendAlert('error', 'Arabanın motoru stop etti!', 2500)
							local counter = 0
							while counter < 700 do
								SetVehicleEngineOn(vehicle,false,false,false)
								SetVehicleUndriveable(vehicle,true)
								counter = counter + 1
								Citizen.Wait(10)
							end					
							exports['mythic_notify']:SendAlert('success', 'Arabanın motoru tekrar çalışır durumda!', 2500)
							SetVehicleUndriveable(vehicle,false)
							SetVehicleEngineOn(vehicle,true,false,false)
						end
					end
				end
				

				if currentKilometer and currentKilometer > Config.asama4km then
					if GetVehicleDirtLevel(vehicle) < 15 then
						SetVehicleDirtLevel(vehicle, 15.0)
					end	
					local health = GetVehicleEngineHealth(vehicle)
					if health > 500 then
						SetVehicleEngineHealth(vehicle, 500.0)
					end	
					local hiz = GetEntitySpeed(vehicle) * 3.6
					if hiz > Config.kritikHiz then
						local sans = math.random(1, Config.asama4sansHizli[2])
						if sans <= Config.asama4sansHizli[1] then
							local tekerler = {1,4,5,6}
							local random = math.random(1,4)
							SetVehicleTyreBurst(vehicle, tekerler[random], true, 1000)
							exports['mythic_notify']:SendAlert('error', 'Araba tekerlerinden biri eski olduğu ve hızlı gittiğin için patladı!', 8000)
						end	
					else
						local sans = math.random(1, Config.asama4sans[2])
						if sans <= Config.asama4sans[1] then
							local tekerler = {1,4,5,6}
							local random = math.random(1,4)
							SetVehicleTyreBurst(vehicle, tekerler[random], true, 1000)
							exports['mythic_notify']:SendAlert('error', 'Arabanın tekerlerinden biri eski olduğu için patladı!', 6000)
						end				
					end	
				end
			end				
		end
	end
end)