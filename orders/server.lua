local QBCore = exports['qb-core']:GetCoreObject()
local Orders = {
    -- ['uwu'] = {},
    -- ['pizzeria'] = {},
}

QBCore.Functions.CreateCallback('nCompany:server:GetCompanyOrders', function(source, cb, args)
    cb(Orders[args])
end)

RegisterNetEvent('nCompany:server:RemoveMoney', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveMoney(data.type, data.amount)
end)

RegisterNetEvent('nCompany:server:AddOrder', function(data)
    print(json.encode(data))
    local src = source
    Orders[data.company][#Orders[data.company]+1] = data
    TriggerClientEvent('nCompany:client:OpenStash', src, 'ORDER_'..data.company..data.id)
end)

RegisterNetEvent('nCompany:server:RemoveOrder', function(id)
    for key, value in pairs(Orders) do
        for k, v in pairs(value) do
            if v.id == id then
                Orders[key][k] = nil
            end
        end
    end
end)