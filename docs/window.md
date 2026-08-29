# Window API

## Create a Window

```lua
local Window = PrismUI:CreateWindow({
    Title = "My Experience",
    Subtitle = "Control center",
    Size = Vector2.new(920, 600),
    Theme = "Amethyst",
    Profile = "Player settings",
    ToggleKey = Enum.KeyCode.RightShift,
})
```

## Configuration

| Property | Description |
|---|---|
| `Title` | Main window title |
| `Subtitle` | Secondary title text |
| `Size` | Window size as a `Vector2` |
| `Theme` | Theme preset or custom theme |
| `Profile` | Profile/footer text |
| `ToggleKey` | Keyboard key used to toggle the window |
| `DisplayOrder` | ScreenGui display order |
| `ShowDiscordButton` | Shows or hides the Discord button |
| `Badge` | Optional badge text |
| `Accent` | Optional custom accent color |
| `LockAccent` | Prevents theme changes from replacing the custom accent |
| `IconProvider` | Optional custom icon provider |
| `Lucide` | Optional icon provider override |
| `Logo` | Optional logo icon |
| `DiscordIcon` | Optional Discord icon |

## Methods

### `Window:CreateTab(config)`

Creates a new tab.

```lua
local Main = Window:CreateTab({
    Name = "Main",
    Icon = "layout-dashboard",
})
```

### `Window:ChangeTheme(theme)`

Changes the current theme.

```lua
Window:ChangeTheme("Cyberpunk")
```

### `Window:Notify(config)`

Shows a notification.

```lua
Window:Notify({
    Title = "Saved",
    Content = "Settings updated.",
})
```

### `Window:SetVisible(visible)`

Shows or hides the window.

```lua
Window:SetVisible(false)
Window:SetVisible(true)
```

### `Window:ToggleVisible()`

Toggles window visibility.

```lua
Window:ToggleVisible()
```

### `Window:Center()`

Centers the window.

```lua
Window:Center()
```

### `Window:Destroy()`

Removes PrismUI and disconnects its window connections.

```lua
Window:Destroy()
```

## Built-In Behavior

PrismUI windows support:

- Dragging
- Resizing
- Minimize and reopen
- Close confirmation
- Responsive layouts
- Viewport-aware sizing
- Keyboard toggling
- Theme switching
---

**Next:** [Tabs →](tabs.md)
