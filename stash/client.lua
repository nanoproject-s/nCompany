local QBCore = exports['qb-core']:GetCoreObject()
CreateThread(function()
    for key, value in pairs(Config.Company) do
        exports['qb-target']:AddBoxZone('stash_'..key, value['coords']['stash']['target'].center, value['coords']['stash']['target'].lenght, value['coords']['stash']['target'].width, {
            name = 'stash_'..key,
            heading = value['coords']['stash']['target'].heading,
            debugPoly = Config.DebugMode,
            minZ = value['coords']['stash']['target'].center.z-value['coords']['stash']['target'].zOffs,
            maxZ = value['coords']['stash']['target'].center.z+value['coords']['stash']['target'].zOffs,
        }, {
            options = {
                {
                    icon = 'fas fa-box-archive',
                    label = 'Depo',
                    canInteract = function()
                        local PlayerData = QBCore.Functions.GetPlayerData()
                        if PlayerData.job.name == key then
                            return true
                        end
                        return false
                    end, 
                    action = function()
                        TriggerEvent('nCompany:client:OpenStash'..key, key..'_STASH_1')
                    end,
                },
            },
            distance = 2.0
        })
    end
end)