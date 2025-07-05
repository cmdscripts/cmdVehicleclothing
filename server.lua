RegisterNetEvent('clothing:applySkinSafe', function(skin, vehicleModel)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local job = xPlayer.job.name
    local grade = xPlayer.job.grade_name

    if not (Config.Settings[vehicleModel] and Config.Settings[vehicleModel][job] and Config.Settings[vehicleModel][job][grade]) then
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'Keine Berechtigung.' })
        return
    end

    if Config.EnableClothingLog then
        print(('[ClothingLog] %s (%s) hat Kleidung für %s/%s angezogen.'):format(
            xPlayer.getName(),
            xPlayer.identifier,
            job,
            grade
        ))
    end

    TriggerClientEvent('clothing:applySkinSafe', src, skin)
end)
