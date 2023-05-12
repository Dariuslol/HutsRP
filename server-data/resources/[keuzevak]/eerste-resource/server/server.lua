QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('eerste-resource:server:betaalBorg', function(source, cb, hoeveelheid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('test', -1, src)
    if Player ~= nil then
        TriggerClientEvent('test', -1, 'passed check')
        TriggerClientEvent('test', -1, hoeveelheid)
        local removedMoney = Player.Functions.RemoveMoney('cash', hoeveelheid, 'neon-borg')
        TriggerClientEvent('test', -1, removedMoney)
        
        if removedMoney then
            cb(true)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have no mooneeyyyyyyyy', 'error')
        end
    end
end)

QBCore.Functions.CreateCallback('eerste-resource:server:krijgBorg', function(hoeveelheid)
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


