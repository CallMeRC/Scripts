# Full API Reference
[← Documentation Home](index.md)
## PrismUI

```lua
PrismUI:CreateWindow(config)
PrismUI:SetIconProvider(provider)
```

### Public Values

```lua
PrismUI.ThemeNames
PrismUI.Themes

PrismUI.IconNames
PrismUI.Lucide
PrismUI.IconProvider
PrismUI.Icons
```

---

# Window

```lua
Window:CreateTab(config)

Window:ChangeTheme(theme)

Window:Notify(config)

Window:SetVisible(visible)

Window:ToggleVisible()

Window:Center()

Window:ResolveIcon(icon, size)

Window:Destroy()
```

---

# Tab

```lua
Tab:SetActive()

Tab:ApplySearch(query)

Tab:RenderNavigation(instant)
```

## Element Creation

```lua
Tab:CreateSection(config)

Tab:CreateButton(config)

Tab:CreateToggle(config)

Tab:CreateInput(config)

Tab:CreateTextbox(config)

Tab:CreateTextBox(config)

Tab:CreateSlider(config)

Tab:CreateDropdown(config)

Tab:CreateColorPicker(config)

Tab:CreateLabel(config)

Tab:CreateWarning(config)

Tab:CreateStat(config)
```

---

# Button

```lua
Button:Press()

Button:SetVisible(visible)

Button:SetLocked(locked, reason)

Button:IsLocked()
```

---

# Toggle

```lua
Toggle:Set(value, silent)

Toggle:Get()

Toggle:SetVisible(visible)

Toggle:SetLocked(locked, reason)

Toggle:IsLocked()
```

---

# Input

```lua
Input:Set(value, silent)

Input:Get()

Input:Clear(silent)

Input:Focus()

Input:SetVisible(visible)

Input:SetLocked(locked, reason)

Input:IsLocked()
```

Public value:

```lua
Input.TextBox
```

---

# Slider

```lua
Slider:Set(value, silent)

Slider:Get()

Slider:SetVisible(visible)

Slider:SetLocked(locked, reason)

Slider:IsLocked()
```

Public values:

```lua
Slider.Value
Slider.CurrentValue
Slider.Range
Slider.Increment
```

---

# Dropdown

```lua
Dropdown:Open()

Dropdown:Close()

Dropdown:Set(value)

Dropdown:Get()

Dropdown:Refresh(options, keepSelection)

Dropdown:SetLocked(locked, reason)

Dropdown:IsLocked()
```

Public values:

```lua
Dropdown.Options
Dropdown.Multiple
Dropdown.Selected
Dropdown.OpenState
```

---

# Color Picker

```lua
Picker:Open()

Picker:Close()

Picker:Set(color, silent)

Picker:Get()

Picker:SetLocked(locked, reason)

Picker:IsLocked()
```

Public values:

```lua
Picker.Value
Picker.FollowTheme
Picker.OpenState
```

---

# Label

```lua
Label:Set(value)

Label:Get()

Label:SetVisible(visible)

Label:SetLocked(locked, reason)

Label:IsLocked()
```

---

# Warning

```lua
Warning:SetText(name, description)

Warning:SetVisible(visible)

Warning:SetLocked(locked, reason)

Warning:IsLocked()
```

---

# Stat

```lua
Stat:Set(value)

Stat:Get()

Stat:SetSuffix(suffix)

Stat:SetLocked(locked, reason)

Stat:IsLocked()
```

---

# Notification

```lua
local Notice = Window:Notify(config)

Notice:Close()
```

---

# Search

Search automatically checks:

- Control names
- Descriptions
- Lock reasons

Search applies to the currently active tab.

---

# Themes

```lua
Window:ChangeTheme("Cyberpunk")

print(PrismUI.ThemeNames)
```

---

# Icons

```lua
Icon = "settings"

print(PrismUI.IconNames)
```

---

# Locking

```lua
Control:SetLocked(
    true,
    "Reason here"
)

Control:IsLocked()

Control:SetLocked(false)
```

Common locking configuration:

```lua
Locked = true
LockTitle = "Locked"
LockReason = "Complete the tutorial first."

LockedCallback = function(reason)
    print(reason)
end
```

---

# Loading PrismUI

```lua
local PrismUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/CallMeRC/Scripts/refs/heads/main/PrismUI.lua"
))()
```

> [!IMPORTANT]
> PrismUI controls run on the client. Important game state changes should be validated by the server.
