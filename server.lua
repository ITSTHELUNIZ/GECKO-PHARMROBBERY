local QBCore = exports['qb-core']:GetCoreObject()
local cooldown = false
local countdown = false
--

RegisterServerEvent('luniz-pharmacy:rewardPlayer')
AddEventHandler('luniz-pharmacy:rewardPlayer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local reward = Config.Loot[math.random(1, #Config.Loot)]
    local reward2 = Config.Loot[math.random(1, #Config.Loot)]
    local reward3 = Config.RareLoot[math.random(1, #Config.RareLoot)]
    local amount = math.random(1, 8)
    local amount2 = math.random(1, 6)
    local amount3 = math.random(1, 10)
    exports.ox_inventory:AddItem(src, reward, amount, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[reward], "add", amount)
    exports.ox_inventory:AddItem(src, reward2, amount2, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[reward2], "add", amount2)
    exports.ox_inventory:AddItem(src, reward3, amount3, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[reward3], "add", amount3)

end)

RegisterServerEvent('luniz-pharmacy:server:startCountdown')
AddEventHandler('luniz-pharmacy:server:startCountdown',function()
    countdown = true
    local timer = 120000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            countdown = false
        end
    end
end)

RegisterServerEvent('luniz-pharmacy:server:startCooldown')
AddEventHandler('luniz-pharmacy:server:startCooldown',function()
    cooldown = true
    local timer = 5400000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            cooldown = false
        end
    end
end)

QBCore.Functions.CreateCallback('luniz-pharmacy:CountdownCB',function(source, cb)
    if countdown then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('luniz-pharmacy:CooldownCB',function(source, cb)
    if cooldown then
        cb(true)
    else
        cb(false)
    end
end)