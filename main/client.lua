local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for k, v in pairs(Config.Company) do
        if v['blip'] then
            blip = AddBlipForCoord(v['blip'].coords.x, v['blip'].coords.y, v['blip'].coords.z)
            SetBlipColour(blip, v['blip'].color)
            SetBlipSprite(blip, v['blip'].sprite)
            SetBlipScale(blip, 0.6)
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v['label'])
            EndTextCommandSetBlipName(blip)
        end
    end
end)