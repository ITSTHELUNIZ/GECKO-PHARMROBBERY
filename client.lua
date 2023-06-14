local QBCore = exports['qb-core']:GetCoreObject()
local copsCalled = false
local CurrentCops = 0

CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData().job ~= nil and next(QBCore.Functions.GetPlayerData().job) then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

CreateThread(function()
    while true do
        Wait(1000 * 60 * 5)
        if copsCalled then
            copsCalled = false
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)


RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)


--
local function PoliceCall()
    exports['ps-dispatch']:PharmacyRobbery()
end

function startPharmRobbery()
    local hasItem = QBCore.Functions.HasItem('weapon_crowbar')
    QBCore.Functions.TriggerCallback('luniz-pharmacy:CooldownCB', function(cooldown)
    QBCore.Functions.TriggerCallback('luniz-pharmacy:CountdownCB', function(countdown)

    if CurrentCops >= 1 then
        if hasItem then
        if not cooldown then
            if not countdown then
            TriggerServerEvent('luniz-pharmacy:server:startCountdown')
            PoliceCall()
            QBCore.Functions.Progressbar("random_task", "Scavenging for loot", 120000, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@heists@ornate_bank@grab_cash_heels",
                anim = "grab",
                flags = 49,
            }, {
                model = "prop_cs_heist_bag_02",
                bone = 57005,
                coords = { x = -0.004, y = 0.00, z = -0.14 },
                rotation = { x = 235.0, y = -25.0, z = 0.0 },
            }, {}, function() -- Done
                TriggerServerEvent('luniz-pharmacy:server:startCooldown')
                TriggerServerEvent('luniz-pharmacy:rewardPlayer')
                StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
            end)
            else
                QBCore.Functions.Notify('You are currently robbing the store, have some patience!', 'info')
            end
        else
        QBCore.Functions.Notify('This store has recently been robbed, come back another time', 'info')
        end
    else
        QBCore.Functions.Notify('You\'re missing something to start this robbery!', 'error')
    end
    else
        QBCore.Functions.Notify('Not enough police on duty!', 'info')
    end
end)
end)
end


exports['qb-target']:AddBoxZone("PharmRobbery", vector3(-176.37, 6388.78, 32.24), 2, 2, {
    name="PharmRobbery2",
    heading=43.85,
    debugPoly=false,
    minZ = 30.5,
    maxZ = 32.5,
    }, {
        options = {
            {
                icon = "fas fa-circle",
                label = "Start Pharm Robbery",
                action = function()
                    startPharmRobbery()
                end,
            },
        },
        distance = 1
  })
