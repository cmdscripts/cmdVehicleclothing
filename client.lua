local function T(key)
    local lang = Config.Locale or 'en'
    return Config.Text[key] and (Config.Text[key][lang] or Config.Text[key]['en']) or key
end

local LastSkin = {}

-- Vorwärtsdeklaration lokaler Funktionen
local setPedClothing, openTrunk, closeTrunk, getIsVehicleAllowed, getIsJobAndRankAllowed, openClothingMenu

-- Kleidung anwenden
setPedClothing = function(skin)
    TriggerEvent('skinchanger:getSkin', function(playerSkin)
        local playerId = GetPlayerServerId(PlayerId())
        if not LastSkin[playerId] then
            LastSkin[playerId] = playerSkin
        end

        local targetSkin = playerSkin.sex == 0 and skin.male or skin.female

        local vehicle = ESX.Game.GetVehicleInDirection()
        if DoesEntityExist(vehicle) then
            openTrunk(vehicle)
        end

        local dict, anim = 'missheistfbisetup1', 'hassle_intro_loop_f'
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do Wait(10) end
        TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8, 2000, 1, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(PlayerPedId())

        for k, v in pairs(targetSkin) do
            TriggerEvent('skinchanger:change', k, v)
        end

        if DoesEntityExist(vehicle) then
            Wait(1000)
            closeTrunk(vehicle)
        end
    end)
end

openTrunk = function(vehicle)
    SetVehicleDoorOpen(vehicle, 5, false, false)
end

closeTrunk = function(vehicle)
    SetVehicleDoorShut(vehicle, 5, false)
end

getIsVehicleAllowed = function(vehicle)
    local hash = GetEntityModel(vehicle)
    local name = GetDisplayNameFromVehicleModel(hash):lower()

    for model, _ in pairs(Config.Settings) do
        if model == name then
            return model
        end
    end

    return false
end

getIsJobAndRankAllowed = function(vehicleModel, jobName, gradeName)
    return Config.Settings[vehicleModel]
        and Config.Settings[vehicleModel][jobName]
        and Config.Settings[vehicleModel][jobName][gradeName]
end

openClothingMenu = function(vehicle)
    local vehicleModel = getIsVehicleAllowed(vehicle)
    if not vehicleModel then return end

    local jobName = ESX.PlayerData.job.name
    local gradeName = ESX.PlayerData.job.grade_name
    local config = Config.Settings[vehicleModel]

    if not config or not config[jobName] or not config[jobName][gradeName] then return end

    local options = {
        {
            title = T('own_clothing'),
            description = T('own_clothing'),
            icon = 'user',
            event = 'change_clothing:default'
        }
    }

    for _, v in ipairs(config[jobName][gradeName]) do
        options[#options + 1] = {
            title = v.label,
            icon = 'tshirt',
            event = 'change_clothing:apply',
            args = { skin = v.skin }
        }
    end

    lib.registerContext({
        id = 'job_clothing_menu',
        title = T('open_menu'),
        options = options
    })

    lib.showContext('job_clothing_menu')
end

RegisterNetEvent('change_clothing:default', function()
    local playerId = GetPlayerServerId(PlayerId())
    if LastSkin[playerId] then
        setPedClothing({ male = LastSkin[playerId], female = LastSkin[playerId] })
    end
end)

RegisterNetEvent('change_clothing:apply', function(data)
    local skin = data and data.skin or (data.args and data.args.skin)
    if not skin then
        print('[Clothing] Ungültige Auswahl.')
        return
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = ESX.Game.GetVehicleInDirection()
    if not DoesEntityExist(vehicle) then
        lib.notify({ type = 'error', description = T('no_vehicle_near') })
        return
    end

    local vehicleModel = getIsVehicleAllowed(vehicle)
    local jobName = ESX.PlayerData.job.name
    local gradeName = ESX.PlayerData.job.grade_name

    if not getIsJobAndRankAllowed(vehicleModel, jobName, gradeName) then
        lib.notify({ type = 'error', description = T('no_permission') })
        return
    end

    TriggerServerEvent('clothing:applySkinSafe', skin, vehicleModel)
end)

RegisterNetEvent('clothing:applySkinSafe', function(skin)
    setPedClothing(skin)
end)

local function initClothingSystem()
    Wait(1000)

    if Config.UseOxTarget then
        local options = {
            {
                icon = 'fas fa-tshirt',
                label = T('open_menu'),
                onSelect = function(data)
                    openClothingMenu(data.entity)
                end,
                canInteract = function(entity)
                    local vehicleModel = getIsVehicleAllowed(entity)
                    if not vehicleModel then return false end
                    return getIsJobAndRankAllowed(vehicleModel, ESX.PlayerData.job.name, ESX.PlayerData.job.grade_name)
                end
            }
        }

        for model, _ in pairs(Config.Settings) do
            exports.ox_target:addModel(GetHashKey(model), options)
        end
    else
        CreateThread(function()
            while true do
                Wait(0)
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetVehicleInDirection()

                if vehicle and DoesEntityExist(vehicle) then
                    local pos = GetEntityCoords(vehicle)
                    if #(coords - pos) < 2.0 then
                        local vehicleModel = getIsVehicleAllowed(vehicle)
                        if vehicleModel and getIsJobAndRankAllowed(vehicleModel, ESX.PlayerData.job.name, ESX.PlayerData.job.grade_name) then
                            lib.showTextUI('[Z] ' .. T('open_menu'))
                        else
                            ::continue::
                            lib.hideTextUI()
                        end
                    else
                        ::continue::
                        lib.hideTextUI()
                    end
                else
                    ::continue::
                    lib.hideTextUI()
                end
            end
        end)
    end
end

CreateThread(initClothingSystem)

RegisterCommand('openJobTrunk', function()
    if Config.UseOxTarget then return end

    local vehicle = ESX.Game.GetVehicleInDirection()
    if not DoesEntityExist(vehicle) then return end

    local vehicleModel = getIsVehicleAllowed(vehicle)
    if not vehicleModel then return end

    local jobName = ESX.PlayerData.job.name
    local gradeName = ESX.PlayerData.job.grade_name
    if not getIsJobAndRankAllowed(vehicleModel, jobName, gradeName) then return end

    openClothingMenu(vehicle)
end)

RegisterKeyMapping('openJobTrunk', T('open_key_desc'), 'keyboard', Config.Hotkey)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        local playerId = GetPlayerServerId(PlayerId())
        if LastSkin[playerId] then
            TriggerEvent('skinchanger:loadSkin', LastSkin[playerId])
        end
    end
end)
