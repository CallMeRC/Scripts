
# Getting Started
[← Documentation Home](index.md)
## Load PrismUI

```lua
local PrismUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/CallMeRC/Scripts/refs/heads/main/PrismUI.lua"
))()
```

Because the script returns `PrismUI`, the variable now contains the entire library.

## Create a Window

```lua
local Window = PrismUI:CreateWindow({
    Title = "My Experience",
    Subtitle = "Control center",
    Theme = "Amethyst",
})
```

## Create a Tab

```lua
local Main = Window:CreateTab({
    Name = "Main",
    Icon = "layout-dashboard",
})
```

## Create a Section

```lua
Main:CreateSection("Controls")
```

## Add a Control

```lua
Main:CreateToggle({
    Name = "Enabled",
    CurrentValue = false,

    Callback = function(value)
        print(value)
    end,
})
```

You can now continue adding controls to the tab.

## Next

- [Example Window](example.md)
- [Window API](window.md)
- [Controls](controls.md)
- [Themes](themes.md)
- [Icons](icons.md)
