local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for key, value in pairs(Config.Company) do
        for k, v in pairs(value['coords']['craft']) do
            exports['qb-target']:AddBoxZone('craft_'..key, v['target'].center, v['target'].lenght, v['target'].width, {
                name = 'craft_'..key,
                heading = v['target'].heading,
                debugPoly = Config.DebugMode,
                minZ = v['target'].center.z-0.5,
                maxZ = v['target'].center.z+0.5,
            }, {
                options = {
                    {
                        icon = v['icon'],
                        label = v['label'],
                        canInteract = function()
                            local PlayerData = QBCore.Functions.GetPlayerData()
                            if PlayerData.job.name == key then
                                return true
                            end
                            return false
                        end, 
                        action = function()
                            local menu = {
                                {
                                    header = v['label'],
                                    isMenuHeader = true,
                                },
                            }
                            for _, i in pairs(v['items']) do
                                local txt = ''
                                for j, c in pairs(i) do
                                    txt = txt..c..'x '..QBCore.Shared.Items[j].label..', '
                                end
                                menu[#menu+1] = {
                                    header = QBCore.Shared.Items[_].label,
                                    txt = txt,
                                    params = {
                                        event = 'nCompany:client:CraftItem'..key,
                                        args = {
                                            item = _,
                                            require = i,
                                        }
                                    }
                                }
                            end
                            exports['nUi']:openMenu(menu)
                        end,
                    },
                },
                distance = 2.0
            })
        end

        RegisterNetEvent('nCompany:client:CraftItem'..key, function(data)
            retval = true
            for k, v in pairs(data.require) do
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    if result then
                        TriggerServerEvent('QBCore:Server:RemoveItem', k, v)
                    else
                        QBCore.Functions.Notify(('Üzerinde %s adet %s yok.'):format(v, QBCore.Shared.Items[k].label), 'error')
                        retval = false
                    end
                end, k, tonumber(v))
            end
            if retval then

                QBCore.Functions.Progressbar('craft_item', 'İşlem yapılıyor...', 5000, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = 'anim@gangops@facility@servers@',
                    anim = 'hotwire',
                    flags = 16,
                }, {}, {}, function()
                    TriggerServerEvent('QBCore:Server:AddItem', data.item, 1)
                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[data.item], 1, 'add')
                end, function()
                end)
            end
        end)
    end
end)