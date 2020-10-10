ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ExeLds:updateCar')
AddEventHandler('ExeLds:updateCar', function(plate)
	MySQL.Sync.execute('UPDATE owned_vehicles SET kilometre = kilometre + @kilometre WHERE plate = @plate',
				{
					['@kilometre'] = 1,
					['@plate'] = plate
				})
end)

ESX.RegisterServerCallback('ExeLds:getKilometer', function(source, cb, plate)
    MySQL.Async.fetchAll("SELECT kilometre FROM owned_vehicles WHERE plate = @plate", { ["@plate"] = plate }, function(result)
        if result[1] then
            cb(result[1].kilometre)
        end    
    end)
end)

ESX.RegisterServerCallback('ExeLds:getOwnedCarInfo', function(source, cb, plate)
    MySQL.Async.fetchAll("SELECT owner FROM owned_vehicles WHERE plate = @plate", { ["@plate"] = plate }, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)