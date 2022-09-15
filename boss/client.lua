local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for key, value in pairs(Config.Company) do
        exports['qb-target']:AddBoxZone('boss_'..key, value['coords']['boss']['target'].center, value['coords']['boss']['target'].lenght, value['coords']['boss']['target'].width, {
            name = 'boss_'..key,
            heading = value['coords']['boss']['target'].heading,
            debugPoly = Config.DebugMode,
            minZ = value['coords']['boss']['target'].center.z-0.5,
            maxZ = value['coords']['boss']['target'].center.z+0.5,
        }, {
            options = {
                {
                    icon = 'fas fa-person',
                    label = 'Patron İşlemleri',
                    canInteract = function()
                        local PlayerData = QBCore.Functions.GetPlayerData()
                        if PlayerData.job.name == key and QBCore.Shared.Jobs[PlayerData.job.name].grades[tostring(PlayerData.job.grade.level)].isboss then
                            return true
                        end
                        return false
                    end, 
                    action = function()
                        local menu = {
                            {
                                header = 'Patron İşlemleri',
                                isMenuHeader = true,
                            },
                            {
                                header = 'Personel Al',
                                txt = ('%s işletmesine yeni personel al.'):format(value['label']),
                                params = {
                                    event = 'nCompany:client:JoinPersonal'..key,
                                    args = {}
                                }
                            },
                            {
                                header = 'Çalışan Listesi',
                                txt = ('%s işletmesinde çalışan personel listesi.'):format(value['label']),
                                params = {
                                    event = 'nCompany:client:OpenPersonalList'..key,
                                    args = {}
                                }
                            },
                        }
                        exports['nUi']:openMenu(menu)
                    end,
                },
            },
            distance = 2.0
        })

        RegisterNetEvent('nCompany:client:OpenPersonalList'..key, function()
            QBCore.Functions.TriggerCallback('nCompany:server:GetPersonalList', function(result)
                if result then
                    exports['nUi']:openMenu(result)
                end
            end, key)
        end)

        RegisterNetEvent('nCompany:client:SetPersonal'..key, function(args)
            local menu = {
                {
                    header = args.name,
                    isMenuHeader = true,
                },
                {
                    header = 'Çalışanı Kov',
                    txt = 'Çalışanı işletmeden kov.',
                    params = {
                        event = 'nCompany:client:KickPersonal'..key,
                        args = args
                    }
                },
                {
                    header = 'Terfi Et',
                    txt = 'Çalışanın yetkisini yükselt.',
                    params = {
                        event = 'nCompany:client:PromotePersonal'..key,
                        args = args
                    }
                },
            }
            exports['nUi']:openMenu(menu)
        end)

        RegisterNetEvent('nCompany:client:KickPersonal'..key, function(args)
            local keyboard = exports['nh-keyboard']:Keyboard({
                header = args.name..' Kovulacak',
                rows = {}
            })
        
            if keyboard then
                TriggerServerEvent('nCompany:server:SetJob', {
                    src = args.src,
                    job = 'unemployed',
                    grade = 0,
                })
                QBCore.Functions.Notify(('%s kişisi %s işletmesinden kovuldu.'):format(args.name, value['label']), 'error')
            else
                QBCore.Functions.Notify('İşlem iptal edildi.', 'error')
            end
        end)

        RegisterNetEvent('nCompany:client:PromotePersonal'..key, function(args)
            local menu = {
                {
                    header = 'Rütbeler',
                    isMenuHeader = true,
                },
            }
            for k, v in pairs(QBCore.Shared.Jobs[key].grades) do
                menu[#menu+1] = {
                    header = v.name,
                    txt = ('%s yetkisine yükselt.'):format(v.name),
                    params = {
                        event = 'nCompany:client:SetJob'..key,
                        args = {
                            src = args.src,
                            name = args.name,
                            grade = k,
                        }
                    }
                }
            end
            exports['nUi']:openMenu(menu)
        end)

        RegisterNetEvent('nCompany:client:SetJob'..key, function(args)
            local keyboard = exports['nh-keyboard']:Keyboard({
                header = args.name..' Terfi Edilecek',
                rows = {}
            })
        
            if keyboard then
                TriggerServerEvent('nCompany:server:SetJob', {
                    src = args.src,
                    job = key,
                    grade = args.grade,
                })
                QBCore.Functions.Notify(('%s kişisi %s konumuna terfi edildi.'):format(args.name, QBCore.Shared.Jobs[key].grades[args.grade].name), 'success')
            else
                QBCore.Functions.Notify('İşlem iptal edildi.', 'error')
            end
        end)

        RegisterCommand('31'..key, function()
            TriggerEvent('nCompany:client:JoinPersonal'..key)
        end)

        RegisterNetEvent('nCompany:client:JoinPersonal'..key, function()
            local keyboard, citizenid = exports['nh-keyboard']:Keyboard({
                header = 'Personel Al',
                rows = {'State ID'}
            })
        
            if keyboard then
                if citizenid then
                    TriggerServerEvent('nCompany:server:SetJobWithCitizenid', {
                        citizenid = citizenid,
                        job = key,
                        grade = 1,
                    })
                else
                    QBCore.Functions.Notify('Tüm alanlar dolu değil.', 'error')
                end
            end
        end)
    end
end)