# Controls

## Button

```lua
local Button = Main:CreateButton({
    Name = "Run Action",
    Description = "Runs an action.",
    ButtonText = "Run",
    Icon = "play",

    Callback = function()
        print("Pressed")
    end,
})
```

### Config

| Property | Description |
|---|---|
| `Name` | Control name |
| `Description` | Optional secondary text |
| `ButtonText` | Text displayed inside the button |
| `Icon` | Optional icon |
| `ButtonWidth` | Fixed button width |
| `MaxButtonWidth` | Maximum button width |
| `Callback` | Function called when pressed |

### Methods

```lua
Button:Press()
Button:SetVisible(false)
Button:SetVisible(true)
```

---

# Toggle

```lua
local Toggle = Main:CreateToggle({
    Name = "Enabled",
    CurrentValue = false,

    Callback = function(value)
        print(value)
    end,
})
```

### Config

| Property | Description |
|---|---|
| `Name` | Toggle name |
| `Description` | Optional secondary text |
| `CurrentValue` | Starting boolean value |
| `Callback(value)` | Runs when the value changes |

### Methods

```lua
Toggle:Set(true)
Toggle:Get()
Toggle:SetVisible(false)
```

---

# Text Input

```lua
local Input = Main:CreateInput({
    Name = "Message",
    Placeholder = "Type here...",
    MaxLength = 60,

    Callback = function(text, enterPressed)
        print(text, enterPressed)
    end,
})
```

### Config

| Property | Description |
|---|---|
| `Name` | Input name |
| `Description` | Optional secondary text |
| `Placeholder` | Placeholder text |
| `CurrentValue` | Initial text |
| `Default` | Alternative initial value |
| `MaxLength` | Maximum number of characters |
| `NumbersOnly` | Filters non-number-style characters |
| `MultiLine` | Enables multiple lines |
| `ClearTextOnFocus` | Clears when focused |
| `ControlWidth` | Input width |
| `ChangedCallback(text)` | Runs as text changes |
| `Callback(text, enterPressed)` | Runs when focus is lost |
| `RemoveTextAfterFocusLost` | Clears after focus is lost |

### Methods

```lua
Input:Set("Hello")
Input:Get()
Input:Clear()
Input:Focus()
Input:SetVisible(false)
```

Aliases:

```lua
CreateTextbox()
CreateTextBox()
```

---

# Slider

```lua
local Slider = Main:CreateSlider({
    Name = "Field of View",
    Range = {70, 120},
    Increment = 1,
    Suffix = "°",
    CurrentValue = 90,

    Callback = function(value)
        print(value)
    end,
})
```

### Config

| Property | Description |
|---|---|
| `Name` | Slider name |
| `Description` | Optional secondary text |
| `Range` | Minimum and maximum |
| `Increment` | Step size |
| `Suffix` | Text shown after the value |
| `CurrentValue` | Starting value |
| `Callback(value)` | Runs when the value changes |

### Methods

```lua
Slider:Set(100)
Slider:Get()
Slider:SetVisible(false)
```

---

# Dropdown

```lua
local Dropdown = Main:CreateDropdown({
    Name = "Quality",

    Options = {
        {Name = "Low", Icon = "battery-low"},
        {Name = "High", Icon = "zap"},
        {Name = "Ultra", Icon = "rocket"},
    },

    CurrentOption = "High",

    Callback = function(value)
        print(value)
    end,
})
```

### Config

| Property | Description |
|---|---|
| `Name` | Dropdown name |
| `Description` | Optional secondary text |
| `Options` | Options list |
| `CurrentOption` | Starting option |
| `MultipleOptions` | Enables multi-select |
| `Placeholder` | Text shown when nothing is selected |
| `ControlWidth` | Preferred width |
| `MaxControlWidth` | Maximum width |
| `Callback(value)` | Runs when selection changes |

Options may also use:

```lua
{
    Name = "High",
    Value = "high",
    Icon = "zap",
}
```

### Methods

```lua
Dropdown:Open()
Dropdown:Close()

Dropdown:Set("Ultra")
Dropdown:Get()

Dropdown:Refresh({
    "Low",
    "Medium",
    "High",
}, true)
```

---

# Color Picker

```lua
local Picker = Main:CreateColorPicker({
    Name = "Accent Color",
    CurrentColor = Window.Accent,
    FollowTheme = true,

    Callback = function(color)
        print(color)
    end,
})
```

### Config

| Property | Description |
|---|---|
| `Name` | Picker name |
| `Description` | Optional secondary text |
| `CurrentColor` | Starting `Color3` |
| `FollowTheme` | Follows the current theme accent |
| `Callback(color)` | Runs when the color changes |

### Methods

```lua
Picker:Open()
Picker:Close()

Picker:Set(Color3.fromRGB(255, 0, 0))
Picker:Get()
```

---

# Label

```lua
local Label = Main:CreateLabel({
    Text = "PrismUI is ready.",
    Icon = "check",
})
```

### Config

| Property | Description |
|---|---|
| `Text` | Display text |
| `Content` | Alternative text field |
| `Name` | Alternative text field |
| `Icon` | Optional icon |
| `Height` | Card height |
| `BackgroundTransparency` | Background transparency |
| `Color` | Text/icon color |
| `TextSize` | Text size |
| `Bold` | Uses bold text |
| `Wrap` | Enables text wrapping |

### Methods

```lua
Label:Set("Updated")
Label:Get()
Label:SetVisible(false)
```

---

# Warning

```lua
local Warning = Main:CreateWarning({
    Name = "Warning",
    Description = "Review this before continuing.",
    Icon = "triangle-alert",
})
```

### Config

| Property | Description |
|---|---|
| `Name` | Warning title |
| `Description` | Warning text |
| `Content` | Alternative warning text |
| `Color` | Warning accent color |
| `Height` | Card height |
| `Icon` | Warning icon |

### Methods

```lua
Warning:SetText(
    "New Warning",
    "Something changed."
)

Warning:SetVisible(false)
```

---

# Stat

```lua
local Stat = Main:CreateStat({
    Name = "Walk Speed",
    Value = 16,
    Suffix = " studs/s",
    Icon = "activity",
})
```

### Config

| Property | Description |
|---|---|
| `Name` | Stat name |
| `Description` | Optional secondary text |
| `Value` | Displayed value |
| `Suffix` | Text appended to the value |
| `Icon` | Optional icon |
| `Color` | Optional accent color |
| `ControlWidth` | Preferred value width |
| `MaxControlWidth` | Maximum value width |

### Methods

```lua
Stat:Set(20)
Stat:Get()

Stat:SetSuffix(" studs/s")
```

---

# Sections

Sections separate groups of controls.

```lua
Main:CreateSection("Controls")
```

or:

```lua
Main:CreateSection({
    Name = "Controls",
})
```

---

# Locking Controls

Registered controls can be locked.

```lua
Toggle:SetLocked(
    true,
    "Complete the tutorial first."
)
```

Check whether it is locked:

```lua
print(Toggle:IsLocked())
```

Unlock:

```lua
Toggle:SetLocked(false)
```

### Lock Config

| Property | Description |
|---|---|
| `Locked` | Initial lock state |
| `LockTitle` | Lock overlay title |
| `LockReason` | Reason displayed |
| `LockedCallback(reason)` | Called when a locked control is clicked |
