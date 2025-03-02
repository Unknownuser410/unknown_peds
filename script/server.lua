ESX = exports["es_extended"]:getSharedObject()


--Give Ped--
RegisterCommand("setped", function(source,args,rawcommand)
    local xPlayer = ESX.GetPlayerFromId(args[1])
    local ped = args[2]

    if ped == "male" or ped == "female" then 
        MySQL.Async.execute("UPDATE `users` SET `ped` = NULL WHERE `identifier` = ?", {xPlayer.identifier})

        if ped == "male" then 
            TriggerClientEvent("unknown_peds:setped", args[1], "mp_m_freemode_01")
        else
            TriggerClientEvent("unknown_peds:setped", args[1], "mp_f_freemode_01")
        end
    else
        MySQL.Async.execute('UPDATE `users` SET `ped` = @ped WHERE `identifier` = @identifier', {['@ped'] = ped, ['@identifier'] = xPlayer.identifier})
        TriggerClientEvent("unknown_peds:setped", args[1], ped)
    end
end, true)
--------------------


--Load Ped on Serverestart--
RegisterNetEvent("unknown_peds:getped", function()
    xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT ped FROM users WHERE identifier = @identifier', { ['@identifier'] = xPlayer.identifier}, function(result)
        local ped = result[1].ped
        if ped then 
            TriggerClientEvent("unknown_peds:setped", ped)
        end
    end)
end)
------------------------------