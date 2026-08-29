# Complete Example Window

This example demonstrates most PrismUI features in one interface.

```lua
local PrismUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/CallMeRC/Scripts/refs/heads/main/PrismUI.lua"
))()

local Window = PrismUI:CreateWindow({
    Title = "PrismUI Demo",
    Subtitle = "All major features",
    Size = Vector2.new(920, 600),
    Theme = "Amethyst",
    Profile = "Player settings",
    ToggleKey = Enum.KeyCode.RightShift,
})

local Main = Window:CreateTab({
    Name = "Main",
    Icon = "layout-dashboard",
    Description = "General controls",
})

local Player = Window:CreateTab({
    Name = "Player",
    Icon = "user",
    Description = "Player settings",
})

local Appearance = Window:CreateTab({
    Name = "Appearance",
    Icon = "palette",
    Description = "Interface customization",
})

Main:CreateSection("Information")

Main:CreateWarning({
    Name = "Demo Warning",
    Description = "This is an example warning element.",
    Icon = "triangle-alert",
})

Main:CreateLabel({
    Text = "PrismUI is loaded and ready.",
    Icon = "check",
})

Main:CreateSection("Controls")

local Input = Main:CreateInput({
    Name = "Display Message",
    Placeholder = "Type something...",
    MaxLength = 60,

    Callback = function(text, enterPressed)
        print(text, enterPressed)
    end,
})

Main:CreateButton({
    Name = "Example Button",
    Description = "Shows a notification.",
    ButtonText = "Run",
    Icon = "play",

    Callback = function()
        Window:Notify({
            Title = "Button",
            Content = "The button was pressed.",
            Icon = "check",
            Duration = 4,
        })
    end,
})

local Toggle = Main:CreateToggle({
    Name = "Example Toggle",
    CurrentValue = false,

    Callback = function(value)
        print("Toggle:", value)
    end,
})

local Slider = Main:CreateSlider({
    Name = "Field of View",
    Range = {70, 120},
    Increment = 1,
    Suffix = "°",
    CurrentValue = 90,

    Callback = function(value)
        workspace.CurrentCamera.FieldOfView = value
    end,
})

local Quality = Main:CreateDropdown({
    Name = "Quality",

    Options = {
        {Name = "Low", Icon = "battery-low"},
        {Name = "Medium", Icon = "gauge"},
        {Name = "High", Icon = "zap"},
        {Name = "Ultra", Icon = "rocket"},
    },

    CurrentOption = "High",

    Callback = function(value)
        print("Quality:", value)
    end,
})

local Effects = Main:CreateDropdown({
    Name = "Enabled Effects",
    MultipleOptions = true,

    Options = {
        "Bloom",
        "Blur",
        "ColorCorrection",
    },

    Callback = function(values)
        print(values)
    end,
})

local AccentPicker = Main:CreateColorPicker({
    Name = "Accent Color",
    CurrentColor = Window.Accent,
    FollowTheme = true,

    Callback = function(color)
        print("Accent:", color)
    end,
})

Player:CreateSection("Live Stats")

local SpeedStat = Player:CreateStat({
    Name = "Walk Speed",
    Value = 16,
    Suffix = " studs/s",
    Icon = "activity",
})

Player:CreateButton({
    Name = "Refresh Stat",
    Icon = "refresh-cw",

    Callback = function()
        local character = game.Players.LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            SpeedStat:Set(humanoid.WalkSpeed)
        end
    end,
})

Player:CreateButton({
    Name = "Custom Notification",
    Icon = "bell",

    Callback = function()
        Window:Notify({
            Title = "PrismUI",
            Content = "Choose an action.",
            Icon = "bell",

            Button1 = "Continue",
            Button2 = "Cancel",

            Callback = function(button)
                print("Pressed:", button)
            end,
        })
    end,
})

Appearance:CreateSection("Interface")

local ThemeDropdown = Appearance:CreateDropdown({
    Name = "Theme Preset",
    Options = PrismUI.ThemeNames,
    CurrentOption = "Amethyst",

    Callback = function(theme)
        Window:ChangeTheme(theme)
    end,
})

Appearance:CreateStat({
    Name = "Included Themes",
    Value = #PrismUI.ThemeNames,
    Icon = "palette",
})

Appearance:CreateLabel({
    Text = "Press RightShift to toggle the window.",
    Icon = "keyboard",
})

Toggle:SetLocked(
    true,
    "Complete the tutorial to unlock this setting."
)

-- Unlock later:
-- Toggle:SetLocked(false)

Window:Notify({
    Title = "PrismUI Loaded",
    Content = "The demo interface is ready.",
    Icon = "shield-check",
    Duration = 5,
})
```

## Included Features

This example includes:

- Multiple tabs
- Sections
- Warning cards
- Labels
- Buttons
- Toggles
- Inputs
- Sliders
- Single-select dropdowns
- Multi-select dropdowns
- Color picker
- Stats
- Notifications

---

**Next:** [Getting Started →](getting-started.md)
- Theme switching
- Control locking
- Lucide icons
- Keyboard window toggle
