# Tabs

[← Documentation Home](index.md)

Tabs organize controls into separate pages.


## Create a Tab

```lua
local Main = Window:CreateTab({
    Name = "Main",
    Icon = "layout-dashboard",
    Description = "General controls",
})
```

## Configuration

| Property | Description |
|---|---|
| `Name` | Tab name |
| `Icon` | Lucide icon or other supported icon value |
| `Description` | Optional tab description |

## Methods

### `Tab:SetActive()`

Makes the tab active.

```lua
Main:SetActive()
```

### `Tab:ApplySearch(query)`

Applies a search query to registered elements.

```lua
Main:ApplySearch("speed")
```

### `Tab:RenderNavigation(instant)`

Refreshes the tab's navigation appearance.

```lua
Main:RenderNavigation(true)
```

## Create Elements

Tabs can create:

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

**Next:** [Controls →](controls.md)
