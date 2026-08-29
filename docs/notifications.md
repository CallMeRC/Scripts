# Notifications

Use `Window:Notify()` to show toast notifications.

## Basic Notification

```lua
Window:Notify({
    Title = "PrismUI",
    Content = "Interface loaded.",
    Icon = "check",
    Duration = 5,
})
```

## Notification With Buttons

```lua
Window:Notify({
    Title = "Confirm",
    Content = "Choose an action.",

    Button1 = "Continue",
    Button2 = "Cancel",

    Callback = function(button)
        print(button)
    end,
})
```

## Configuration

| Property | Description |
|---|---|
| `Title` | Notification title |
| `Content` | Notification body |
| `Text` | Alternative body field |
| `Duration` | Duration in seconds |
| `Icon` | Optional icon |
| `Button1` | First action button |
| `Button2` | Second action button |
| `Callback(buttonText)` | Runs when an action is selected |

## Close Manually

`Window:Notify()` returns a notification handle.

```lua
local Notice = Window:Notify({
    Title = "Saved",
    Content = "Settings updated.",
})

Notice:Close()
```

## Features

Notifications support:

- Icons
- Progress timers
- Animations
- One or two buttons
- Manual close
- Theme-aware styling
