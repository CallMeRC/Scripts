# Icons

PrismUI includes embedded Lucide icons.

## Use a Lucide Icon

```lua
Icon = "settings"
```

Other examples:

```lua
Icon = "rocket"
Icon = "shield-check"
Icon = "palette"
Icon = "activity"
Icon = "triangle-alert"
```

## Get All Icon Names

```lua
print(PrismUI.IconNames)
```

## Direct Roblox Assets

You can also use a Roblox asset ID.

```lua
Icon = 123456789
```

or:

```lua
Icon = "rbxassetid://123456789"
```

## Supported Icon Formats

PrismUI can resolve:

- Lucide icon names
- Numeric Roblox asset IDs
- Numeric ID strings
- `rbxassetid://`
- `rbxasset://`
- `rbxthumb://`
- HTTP image values
- Custom icon provider results

## Custom Icon Provider

```lua
PrismUI:SetIconProvider(customProvider)
```

You can also provide an icon provider when creating the window.

```lua
local Window = PrismUI:CreateWindow({
    Title = "My UI",
    IconProvider = customProvider,
})
```
---

**Next:** [Back to Documentation Home →](index.md)
