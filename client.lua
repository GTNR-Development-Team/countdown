-- Countdown Timer - Client Side
-- Clean and minimalist countdown for FiveM

local isCountdownActive = false

-- Play countdown sound
function PlayCountdownSound(soundType)
    if not Config or not Config.Sounds then return end
    
    local soundName = Config.Sounds[soundType] or Config.Sounds.number
    local soundSet = Config.Sounds.soundSet
    
    if soundName and soundSet then
        PlaySoundFrontend(-1, soundName, soundSet, true)
    end
end

-- Display countdown text
function DisplayCountdownText(text, duration, isGo)
    if not text or not duration or duration <= 0 then return end
    if not Config or not Config.TextScale or not Config.Colors or not Config.TextPosition then return end
    
    local endTime = GetGameTimer() + (duration * 1000)
    local scale = isGo and Config.TextScale.go or Config.TextScale.numbers
    
    local colorConfig = Config.Colors[text] or {255, 255, 255}
    local r, g, b = colorConfig[1] or 255, colorConfig[2] or 255, colorConfig[3] or 255
    
    if not scale or scale <= 0 then scale = 2.0 end
    
    local posX = Config.TextPosition.x or 0.5
    local posY = Config.TextPosition.y or 0.35
    
    while GetGameTimer() < endTime do
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(scale, scale)
        SetTextColour(r, g, b, 255)
        SetTextDropShadow(1, 0, 0, 0, 150)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(posX, posY)
        
        Citizen.Wait(0)
    end
end

-- Start countdown
function StartCountdown()
    if isCountdownActive then return false end
    if not Config or not Config.NumberDisplayTime or not Config.CountdownDuration or not Config.GoDisplayTime then return false end
    
    isCountdownActive = true
    
    Citizen.CreateThread(function()
        local startTime = GetGameTimer()
        
        -- Display "3"
        PlayCountdownSound("number")
        DisplayCountdownText("3", Config.NumberDisplayTime, false)
        
        -- Display "2"
        local elapsed = (GetGameTimer() - startTime) / 1000
        if elapsed < Config.NumberDisplayTime then
            local waitTime = math.floor((Config.NumberDisplayTime - elapsed) * 1000)
            if waitTime > 0 then Citizen.Wait(waitTime) end
        end
        
        PlayCountdownSound("number")
        DisplayCountdownText("2", Config.NumberDisplayTime, false)
        
        -- Display "1"
        elapsed = (GetGameTimer() - startTime) / 1000
        if elapsed < Config.NumberDisplayTime * 2 then
            local waitTime = math.floor((Config.NumberDisplayTime * 2 - elapsed) * 1000)
            if waitTime > 0 then Citizen.Wait(waitTime) end
        end
        
        PlayCountdownSound("number")
        DisplayCountdownText("1", Config.NumberDisplayTime, false)
        
        -- Display "GO!"
        elapsed = (GetGameTimer() - startTime) / 1000
        if elapsed < Config.CountdownDuration then
            local waitTime = math.floor((Config.CountdownDuration - elapsed) * 1000)
            if waitTime > 0 then Citizen.Wait(waitTime) end
        end
        
        PlayCountdownSound("go")
        DisplayCountdownText("GO!", Config.GoDisplayTime, true)
        
        isCountdownActive = false
    end)
    
    return true
end

-- Event handler
RegisterNetEvent('countdown:start', function()
    StartCountdown()
end)

-- Resource cleanup
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        isCountdownActive = false
    end
end)