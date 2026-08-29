# Themes

PrismUI includes **40 built-in themes**.

## Change Theme

```lua
Window:ChangeTheme("Cyberpunk")
```

## Get All Theme Names

```lua
print(PrismUI.ThemeNames)
```

## Included Themes

- Graphite
- DarkBlue
- Cobalt
- Amethyst
- Emerald
- Ember
- Rose
- Aurora
- Frost
- MidnightGold
- Obsidian
- Oceanic
- Crimson
- Sakura
- Solar
- Cyberpunk
- Nord
- Dracula
- Monokai
- Forest
- Coffee
- Slate
- Lavender
- Sunset
- Arctic
- Mint
- Coral
- Neon
- Royal
- Sandstone
- VioletStorm
- DeepSea
- RubyNight
- Galactic
- Inferno
- Tundra
- Matrix
- Candy
- Navy
- Champagne

## Theme Colors

Themes use the following semantic values:

```lua
Background
Surface
SurfaceHover
SurfaceRaised
Border
Text
Muted
Accent
AccentDark
Success
Danger
```

## Custom Theme

You can also pass a custom theme table.

```lua
Window:ChangeTheme({
    Background = Color3.fromRGB(10, 10, 10),
    Surface = Color3.fromRGB(20, 20, 20),
    Accent = Color3.fromRGB(120, 80, 255),
})
```

Missing values continue using PrismUI's existing theme values.

## Locked Accent

A custom window accent can be preserved across theme changes with:

```lua
local Window = PrismUI:CreateWindow({
    Theme = "Graphite",
    Accent = Color3.fromRGB(255, 80, 120),
    LockAccent = true,
})
```
