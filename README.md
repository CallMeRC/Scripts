# PrismUI

PrismUI is a Roblox UI library with a clean modern interface, responsive layouts, built-in themes, Lucide icons, notifications, search, locking, and reusable controls.

## Features

- 40 built-in themes
- Embedded Lucide icons
- Responsive desktop and mobile layouts
- Draggable and resizable window
- Minimize and reopen support
- Searchable controls
- Lockable controls
- Buttons
- Toggles
- Inputs
- Sliders
- Dropdowns
- Color pickers
- Labels
- Warnings
- Stats
- Notifications
- Mouse and touch support

## Load PrismUI

```lua
local PrismUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/CallMeRC/Scripts/refs/heads/main/PrismUI.lua"
))()
```

Because `PrismUI.lua` returns the library table, `PrismUI` contains the full API.

## Documentation

- [Example Window](docs/example.md)
- [Getting Started](docs/getting-started.md)
- [Window API](docs/window.md)
- [Tabs](docs/tabs.md)
- [Controls](docs/controls.md)
- [Notifications](docs/notifications.md)
- [Themes](docs/themes.md)
- [Icons](docs/icons.md)
- [Full API Reference](docs/api-reference.md)

## Quick Example

```lua
local PrismUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/CallMeRC/Scripts/refs/heads/main/PrismUI.lua"
))()

local Window = PrismUI:CreateWindow({
    Title = "My Experience",
    Theme = "Amethyst",
})

local Main = Window:CreateTab({
    Name = "Main",
    Icon = "layout-dashboard",
})

Main:CreateToggle({
    Name = "Enabled",
    CurrentValue = false,

    Callback = function(value)
        print(value)
    end,
})
```

> [!NOTE]
> PrismUI is client-side UI code. Important gameplay actions should still be validated on the server.
