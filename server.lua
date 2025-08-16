-- Countdown Timer - Server Side
-- Clean and minimalist countdown for FiveM

local playerCooldowns = {}

-- Check if player is on cooldown
function IsPlayerOnCooldown(playerId)
    if not playerId or playerId <= 0 then return false, 0 end
    
    local currentTime = os.time()
    local lastUsed = playerCooldowns[playerId]
    local cooldownTime = Config.CooldownTime or 5
    
    if lastUsed and (currentTime - lastUsed) < cooldownTime then
        return true, cooldownTime - (currentTime - lastUsed)
    end
    
    return false, 0
end

-- Set player cooldown
function SetPlayerCooldown(playerId)
    if not playerId or playerId <= 0 then return false end
    playerCooldowns[playerId] = os.time()
    return true
end

-- Get nearby players
function GetNearbyPlayers(sourcePlayer, distance)
    local sourcePed = GetPlayerPed(sourcePlayer)
    local sourceCoords = GetEntityCoords(sourcePed)
    local nearbyPlayers = {}
    
    for _, playerId in ipairs(GetPlayers()) do
        local targetPed = GetPlayerPed(playerId)
        local targetCoords = GetEntityCoords(targetPed)
        local dist = #(sourceCoords - targetCoords)
        
        if dist <= distance then
            table.insert(nearbyPlayers, playerId)
        end
    end
    
    return nearbyPlayers
end

-- Main command
RegisterCommand('count', function(source, args, rawCommand)
    local playerId = source
    
    if not playerId or playerId <= 0 then return end
    
    -- Check cooldown
    local onCooldown, timeLeft = IsPlayerOnCooldown(playerId)
    if onCooldown then
        local waitTime = math.ceil(timeLeft)
        local message = 'Please wait ' .. waitTime .. ' seconds before using countdown again'
        
        if QBCore then
            TriggerClientEvent('QBCore:Notify', playerId, message, 'error')
        elseif ESX then
            TriggerClientEvent('esx:showNotification', playerId, message)
        else
            TriggerClientEvent('chat:addMessage', playerId, {
                color = {255, 165, 0},
                args = {'[COUNTDOWN]', message}
            })
        end
        return
    end
    
    -- Set cooldown
    SetPlayerCooldown(playerId)
    
    -- Start countdown based on proximity mode
    if Config.ProximityMode then
        -- Get nearby players
        local nearbyPlayers = GetNearbyPlayers(playerId, Config.ProximityDistance)
        
        -- Trigger countdown for nearby players only
        for _, nearbyPlayerId in ipairs(nearbyPlayers) do
            TriggerClientEvent('countdown:start', nearbyPlayerId)
        end
    else
        -- Trigger countdown for all players
        TriggerClientEvent('countdown:start', -1)
    end
end, false)

-- Cleanup on player disconnect
AddEventHandler('playerDropped', function(reason)
    local playerId = source
    if playerCooldowns[playerId] then
        playerCooldowns[playerId] = nil
    end
end)

-- Periodic cleanup
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        
        local currentTime = os.time()
        local cooldownTime = Config.CooldownTime or 5
        
        for playerId, lastUsed in pairs(playerCooldowns) do
            if (currentTime - lastUsed) > cooldownTime then
                playerCooldowns[playerId] = nil
            end
        end
    end
end)

-- Resource cleanup
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        playerCooldowns = {}
    end
end)