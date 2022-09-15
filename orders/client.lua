local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for key, value in pairs(Config.Company) do
        exports['qb-target']:AddBoxZone('order_'..key, value['coords']['orders']['target'].center, value['coords']['orders']['target'].lenght, value['coords']['orders']['target'].width, {
            name = 'order_'..key,
            heading = value['coords']['orders']['target'].heading,
            debugPoly = Config.DebugMode,
            minZ = value['coords']['orders']['target'].center.z-0.5,
            maxZ = value['coords']['orders']['target'].center.z+0.5,
        }, {
            options = {
                {
                    icon = 'fas fa-money-bill',
                    label = 'Siparişler',
                    action = function()
                        local PlayerData = QBCore.Functions.GetPlayerData()
                        local menu = {
                            {
                                header = value['label'],
                                isMenuHeader = true,
                            },
                            {
                                header = 'Siparişler',
                                txt = 'Siparişleri görüntüle.',
                                params = {
                                    event = 'nCompany:client:OpenOrdersMenu'..key,
                                    args = {}
                                }
                            },
                        }
                        if PlayerData.job.name == key then
                            menu[#menu+1] = {
                                header = 'Sipariş Oluştur',
                                txt = 'Yeni sipariş oluştur.',
                                params = {
                                    event = 'nCompany:client:AddNewOrders'..key,
                                    args = {}
                                }
                            }
                        end
                        exports['nUi']:openMenu(menu)
                    end,
                },
            },
            distance = 2.0
        })

        RegisterNetEvent('nCompany:client:OpenOrdersMenu'..key, function()
            QBCore.Functions.TriggerCallback('nCompany:server:GetCompanyOrders', function(result)
                if result then
                    local menu = {
                        {
                            header = 'Siparişler',
                            isMenuHeader = true,
                        },
                    }
                    for k, v in pairs(result) do
                        menu[#menu+1] = {
                            header = v.name,
                            txt = ('Sahip: %s, Ücret: $%s'):format(v.owner, v.price),
                            params = {
                                event = 'nCompany:client:BuyOrder'..key,
                                args = v
                            }
                        }
                    end
                    exports['nUi']:openMenu(menu)
                else
                    QBCore.Functions.Notify('Hiç sipariş yok.', 'error')
                end
            end, key)
        end)

        RegisterNetEvent('nCompany:client:BuyOrder'..key, function(args)
            local PlayerData = QBCore.Functions.GetPlayerData()
            if PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname == args.owner then
                if PlayerData.money['cash'] >= args.price then
                    local keyboard = exports['nh-keyboard']:Keyboard({
                        header = 'Siparişi Al',
                        rows = {}
                    })
                
                    if keyboard then
                        TriggerServerEvent('nCompany:server:RemoveMoney', {
                            type = 'cash',
                            amount = args.price
                        })
                        TriggerServerEvent('nCompany:server:RemoveOrder', args.id)
                        TriggerEvent('nCompany:client:OpenStash'..key, 'ORDER_'..key..'_'..args.id)
                    end
                else
                    QBCore.Functions.Notify('Üzerinde yeterli nakit yok.', 'error')
                end
            else
                QBCore.Functions.Notify('Bu sipariş senin değil.', 'error')
            end
        end)

        RegisterNetEvent('nCompany:client:AddNewOrders'..key, function()
            local keyboard, name, owner, price = exports['nh-keyboard']:Keyboard({
                header = 'Sipariş Ekle',
                rows = {'Etiket', 'Alıcı', 'Ücret'}
            })
        
            if keyboard then
                if name and owner and tonumber(price) then
                    local id = math.random(1, 9999)
                    TriggerServerEvent('nCompany:server:AddOrder', {
                        company = key,
                        id = id,
                        name = name,
                        price = tonumber(price),
                        owner = owner,
                    })
                    TriggerEvent('nCompany:client:OpenStash'..key, 'ORDER_'..key..'_'..id)
                end
            end
        end)
        
        RegisterNetEvent('nCompany:client:OpenStash'..key, function(name)
            TriggerServerEvent('inventory:server:OpenInventory', 'stash', name)
            TriggerEvent('inventory:client:SetCurrentStash', name)
        end)
    end
end)