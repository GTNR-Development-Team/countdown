-- Countdown Timer Configuration
-- Clean and minimalist countdown for FiveM

Config = {}

-- Timing settings (in seconds)
Config.CountdownDuration = 3.0
Config.NumberDisplayTime = 1.0
Config.GoDisplayTime = 2.0

-- Proximity settings
Config.ProximityMode = true         -- true = only nearby players see countdown, false = all players
Config.ProximityDistance = 50.0     -- Distance in meters for proximity mode

-- Visual settings
Config.TextScale = {
    numbers = 2.5,
    go = 2.8
}

Config.Colors = {
    ["3"] = {255, 255, 255},
    ["2"] = {255, 255, 255},
    ["1"] = {255, 255, 255},
    ["GO!"] = {0, 255, 0}
}

-- Sound settings
Config.Sounds = {
    number = "CHECKPOINT_PERFECT",
    go = "CHECKPOINT_UNDER_THE_BRIDGE",
    soundSet = "HUD_MINI_GAME_SOUNDSET"
}

-- Position
Config.TextPosition = {
    x = 0.5,
    y = 0.35
}

-- Cooldown (seconds)
Config.CooldownTime = 5