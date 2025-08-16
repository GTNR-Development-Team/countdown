# Countdown Timer

A clean and minimalist countdown timer for FiveM servers.

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![FiveM](https://img.shields.io/badge/FiveM-Compatible-green.svg)
![License](https://img.shields.io/badge/license-MIT-yellow.svg)

## Features

- **Clean Design** - Minimalist countdown display
- **Sound Effects** - Audio feedback for each step
- **Proximity Mode** - Show countdown to nearby players only (configurable)
- **Spam Protection** - 5-second cooldown per player
- **Easy to Use** - Simple `/count` command
- **Lightweight** - Minimal resource usage

## Installation

1. Download the resource
2. Place in `resources/[mods]/countdown/`
3. Add `ensure countdown` to your server.cfg
4. Restart your server

## Usage

**Command:** `/count`

Displays a 3-2-1-GO countdown with sound effects. By default, only nearby players see the countdown (proximity mode).

## Configuration

Edit `config.lua` to customize:

```lua
-- Timing (seconds)
Config.CountdownDuration = 3.0
Config.NumberDisplayTime = 1.0
Config.GoDisplayTime = 2.0

-- Proximity settings
Config.ProximityMode = true         -- true = nearby players only, false = all players
Config.ProximityDistance = 50.0     -- Distance in meters for proximity mode

-- Colors (RGB 0-255)
Config.Colors = {
    ["3"] = {255, 255, 255},    -- White
    ["2"] = {255, 255, 255},    -- White
    ["1"] = {255, 255, 255},    -- White
    ["GO!"] = {0, 255, 0}       -- Green
}

-- Cooldown
Config.CooldownTime = 5  -- Seconds between uses
```

### Proximity Modes

**Proximity Mode (Default)**: `Config.ProximityMode = true`
- Only players within the specified distance see the countdown
- Perfect for local racing events and drag strips
- Reduces spam for players in other areas

**Global Mode**: `Config.ProximityMode = false`
- All players on the server see the countdown
- Good for server-wide events

## Requirements

- FiveM Server
- Lua 5.4 support

## Perfect For

- Racing events
- Drag racing
- Car meets
- Any timed activity

## Support

- **Repository**: [GitHub](https://github.com/GTNR-Development-Team/countdown)
- **Discord**: [Join our community](http://guttner.xyz/discord)
- **Email**: contact@gtnr.store

## License

MIT License - see LICENSE file for details.

---

**Made by GTNR Development Team**
