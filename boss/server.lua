local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('nCompany:server:GetPersonalList', function(source, cb, args)
    local Players = QBCore.Functions.GetPlayers()
    local table = {
        {
            header = 'Çalışan Listesi',
            isMenuHeader = true,
        },
    }
    for k, v in pairs(Players) do
        local Player = QBCore.Functions.GetPlayer(k)
        if Player then
            if Player.PlayerData.job.name == args then
                table[#table+1] = {
                    header = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname,
                    txt = Player.PlayerData.job.grade.name,
                    params = {
                        event = 'nCompany:client:SetPersonal'..args,
                        args = {
                            name = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname,
                            grade = Player.PlayerData.job.grade.name,
                            src = k,
                        }
                    }
                }
            end
        end
    end
    cb(table)
end)

RegisterNetEvent('nCompany:server:SetJob', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(tonumber(data.src))
    if Player then
        Player.Functions.SetJob(tostring(data.job), tonumber(data.grade))
        TriggerClientEvent('QBCore:Notify', src, 'Kişi işe alındı.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Oyuncu çevrimiçi değil.', 'error')
    end
end)

RegisterNetEvent('nCompany:server:SetJobWithCitizenid', function(data)
    local Player = QBCore.Functions.GetPlayerByCitizenId(data.citizenid)
    if Player then
        Player.Functions.SetJob(tostring(data.job), tonumber(data.grade))
        TriggerClientEvent('QBCore:Notify', src, 'Kişi işe alındı.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Oyuncu çevrimiçi değil veya yanlış State ID.', 'error')
    end
end)

RegisterCommand('sickyg', function(source, args)
    local txt = ''
    for k, v in pairs(args) do
        txt = txt..' '..args[k]
    end
    TriggerClientEvent('QBCore:Notify', -1, txt, 'inform')
end)