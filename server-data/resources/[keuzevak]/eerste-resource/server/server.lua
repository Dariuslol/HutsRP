QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('eerste-resource:server:betaalBorg', function(hoeveelheid)
    print('hello there', hoeveelheid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('test', -1, Player)
    if Player ~= nil then
        TriggerClientEvent('test', -1, 'neon-borg')
        local removedMoney = Player.Functions.RemoveMoney('cash', hoeveelheid, 'neon-borg')
        TriggerClientEvent('test', -1, 'lukt')
        
        if removedMoney then
            TriggerClientEvent('QBCore:Notify', src, 'Removed ' + hoeveelheid + ' knaken of you', 'success', 20000)
            TriggerClientEvent('eerste-resource:client:spawnNeon', -1)
        else
            TriggerClientEvent('test', -1, 'welloe')
            TriggerClientEvent('QBCore:Notify', src, 'You have no mooneeyyyyyyyy', 'error')
        end
    end
end)

RegisterNetEvent('eerste-resource:server:krijgBorg', function(hoeveelheid)
    print('hello there', hoeveelheid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('test', -1, Player)
    if Player ~= nil then
        TriggerClientEvent('test', -1, 'neon-borg')
        local givenMoney = Player.Functions.AddMoney('cash', hoeveelheid, 'neon-borg')
        TriggerClientEvent('test', -1, givenMoney)
        
        if givenMoney then
            TriggerClientEvent('eerste-resource:client:despawnNeon', -1)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Can not place in garage', 'error')
        end
    end
end)


