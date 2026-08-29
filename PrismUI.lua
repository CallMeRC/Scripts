--!nocheck
-- PrismUI - single-file Roblox UI library + example
-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.
-- Theme presets are listed in PrismUI.ThemeNames and can be changed live.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local PrismUI = {}
PrismUI.__index = PrismUI

local THEME_PRESETS = {
	Graphite = {
		Background = Color3.fromRGB(12, 13, 16),
		Surface = Color3.fromRGB(19, 21, 25),
		SurfaceHover = Color3.fromRGB(25, 28, 33),
		SurfaceRaised = Color3.fromRGB(30, 33, 39),
		Border = Color3.fromRGB(48, 52, 61),
		Text = Color3.fromRGB(244, 246, 248),
		Muted = Color3.fromRGB(151, 157, 168),
		Accent = Color3.fromRGB(112, 126, 255),
		AccentDark = Color3.fromRGB(75, 87, 205),
		Success = Color3.fromRGB(65, 201, 139),
		Danger = Color3.fromRGB(241, 91, 116),
	},
	DarkBlue = {
		Background = Color3.fromRGB(7, 12, 22),
		Surface = Color3.fromRGB(13, 22, 37),
		SurfaceHover = Color3.fromRGB(19, 32, 52),
		SurfaceRaised = Color3.fromRGB(22, 38, 61),
		Border = Color3.fromRGB(42, 63, 91),
		Text = Color3.fromRGB(239, 246, 255),
		Muted = Color3.fromRGB(139, 160, 188),
		Accent = Color3.fromRGB(57, 139, 255),
		AccentDark = Color3.fromRGB(35, 94, 199),
		Success = Color3.fromRGB(52, 211, 153),
		Danger = Color3.fromRGB(248, 101, 121),
	},
	Cobalt = {
		Background = Color3.fromRGB(8, 13, 28),
		Surface = Color3.fromRGB(15, 23, 43),
		SurfaceHover = Color3.fromRGB(22, 33, 59),
		SurfaceRaised = Color3.fromRGB(27, 40, 70),
		Border = Color3.fromRGB(48, 67, 104),
		Text = Color3.fromRGB(241, 246, 255),
		Muted = Color3.fromRGB(145, 161, 190),
		Accent = Color3.fromRGB(70, 113, 255),
		AccentDark = Color3.fromRGB(43, 75, 202),
		Success = Color3.fromRGB(53, 208, 149),
		Danger = Color3.fromRGB(246, 94, 122),
	},
	Amethyst = {
		Background = Color3.fromRGB(14, 10, 22),
		Surface = Color3.fromRGB(24, 18, 35),
		SurfaceHover = Color3.fromRGB(34, 25, 49),
		SurfaceRaised = Color3.fromRGB(40, 30, 57),
		Border = Color3.fromRGB(68, 51, 88),
		Text = Color3.fromRGB(248, 244, 255),
		Muted = Color3.fromRGB(173, 158, 191),
		Accent = Color3.fromRGB(162, 101, 255),
		AccentDark = Color3.fromRGB(112, 62, 204),
		Success = Color3.fromRGB(76, 215, 154),
		Danger = Color3.fromRGB(247, 99, 129),
	},
	Emerald = {
		Background = Color3.fromRGB(8, 17, 15),
		Surface = Color3.fromRGB(14, 28, 24),
		SurfaceHover = Color3.fromRGB(20, 39, 33),
		SurfaceRaised = Color3.fromRGB(24, 46, 38),
		Border = Color3.fromRGB(42, 76, 63),
		Text = Color3.fromRGB(238, 252, 247),
		Muted = Color3.fromRGB(143, 177, 164),
		Accent = Color3.fromRGB(53, 210, 145),
		AccentDark = Color3.fromRGB(30, 150, 101),
		Success = Color3.fromRGB(75, 224, 157),
		Danger = Color3.fromRGB(246, 99, 116),
	},
	Ember = {
		Background = Color3.fromRGB(20, 12, 10),
		Surface = Color3.fromRGB(34, 20, 17),
		SurfaceHover = Color3.fromRGB(47, 27, 22),
		SurfaceRaised = Color3.fromRGB(56, 32, 26),
		Border = Color3.fromRGB(88, 53, 42),
		Text = Color3.fromRGB(255, 247, 241),
		Muted = Color3.fromRGB(195, 161, 143),
		Accent = Color3.fromRGB(255, 128, 72),
		AccentDark = Color3.fromRGB(203, 78, 39),
		Success = Color3.fromRGB(76, 207, 137),
		Danger = Color3.fromRGB(248, 82, 92),
	},
	Rose = {
		Background = Color3.fromRGB(20, 11, 17),
		Surface = Color3.fromRGB(34, 19, 29),
		SurfaceHover = Color3.fromRGB(47, 26, 40),
		SurfaceRaised = Color3.fromRGB(56, 31, 48),
		Border = Color3.fromRGB(88, 50, 75),
		Text = Color3.fromRGB(255, 244, 250),
		Muted = Color3.fromRGB(198, 156, 181),
		Accent = Color3.fromRGB(246, 104, 165),
		AccentDark = Color3.fromRGB(191, 66, 124),
		Success = Color3.fromRGB(70, 206, 142),
		Danger = Color3.fromRGB(249, 81, 108),
	},
	Aurora = {
		Background = Color3.fromRGB(8, 15, 20),
		Surface = Color3.fromRGB(14, 25, 32),
		SurfaceHover = Color3.fromRGB(20, 36, 45),
		SurfaceRaised = Color3.fromRGB(24, 43, 53),
		Border = Color3.fromRGB(42, 70, 82),
		Text = Color3.fromRGB(238, 251, 252),
		Muted = Color3.fromRGB(139, 175, 181),
		Accent = Color3.fromRGB(72, 211, 195),
		AccentDark = Color3.fromRGB(41, 151, 143),
		Success = Color3.fromRGB(73, 218, 150),
		Danger = Color3.fromRGB(245, 96, 121),
	},
	Frost = {
		Background = Color3.fromRGB(236, 241, 248),
		Surface = Color3.fromRGB(248, 250, 253),
		SurfaceHover = Color3.fromRGB(239, 244, 250),
		SurfaceRaised = Color3.fromRGB(228, 235, 244),
		Border = Color3.fromRGB(194, 205, 219),
		Text = Color3.fromRGB(25, 35, 49),
		Muted = Color3.fromRGB(99, 113, 132),
		Accent = Color3.fromRGB(57, 121, 224),
		AccentDark = Color3.fromRGB(36, 85, 169),
		Success = Color3.fromRGB(28, 159, 105),
		Danger = Color3.fromRGB(210, 62, 87),
	},
	MidnightGold = {
		Background = Color3.fromRGB(13, 12, 10),
		Surface = Color3.fromRGB(23, 21, 17),
		SurfaceHover = Color3.fromRGB(32, 29, 23),
		SurfaceRaised = Color3.fromRGB(39, 35, 27),
		Border = Color3.fromRGB(65, 57, 41),
		Text = Color3.fromRGB(250, 247, 238),
		Muted = Color3.fromRGB(178, 168, 142),
		Accent = Color3.fromRGB(219, 177, 85),
		AccentDark = Color3.fromRGB(161, 121, 48),
		Success = Color3.fromRGB(65, 194, 132),
		Danger = Color3.fromRGB(232, 89, 106),
	},
}

local COLORS = table.clone(THEME_PRESETS.Amethyst)
PrismUI.Themes = THEME_PRESETS
PrismUI.ThemeNames = {
	"Graphite", "DarkBlue", "Cobalt", "Amethyst", "Emerald",
	"Ember", "Rose", "Aurora", "Frost", "MidnightGold",
}

local function resolveTheme(requestedTheme, fallbackTheme)
	local fallback = fallbackTheme or THEME_PRESETS.Amethyst
	local chosen = table.clone(fallback)
	local name = "Custom"
	if type(requestedTheme) == "string" then
		for presetName, preset in pairs(THEME_PRESETS) do
			if string.lower(presetName) == string.lower(requestedTheme) then
				return table.clone(preset), presetName
			end
		end
		warn("[PrismUI] Unknown theme '" .. requestedTheme .. "'; using Amethyst.")
		return table.clone(THEME_PRESETS.Amethyst), "Amethyst"
	elseif type(requestedTheme) == "table" then
		for key, value in pairs(requestedTheme) do
			if chosen[key] ~= nil and typeof(value) == "Color3" then
				chosen[key] = value
			end
		end
		return chosen, name
	end
	return table.clone(THEME_PRESETS.Amethyst), "Amethyst"
end

local THEME_ATTRIBUTE = "PrismTheme_"

local function themeKeyForColor(color)
	if typeof(color) ~= "Color3" then return nil end
	for key, themeColor in pairs(COLORS) do
		if color == themeColor then return key end
	end
	return nil
end

local function bindThemeValue(object, property, value)
	if typeof(value) == "Color3" then
		local key = themeKeyForColor(value)
		if key then object:SetAttribute(THEME_ATTRIBUTE .. property, key) end
	elseif typeof(value) == "ColorSequence" then
		local keys = {}
		local hasBinding = false
		for _, keypoint in ipairs(value.Keypoints) do
			local key = themeKeyForColor(keypoint.Value)
			table.insert(keys, key or "_")
			if key then hasBinding = true end
		end
		if hasBinding then
			object:SetAttribute(THEME_ATTRIBUTE .. "Sequence_" .. property, table.concat(keys, ","))
		end
	end
end

local function setThemeBinding(object, property, key)
	if key and COLORS[key] then
		object:SetAttribute(THEME_ATTRIBUTE .. property, key)
	end
end

local FAST = TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local SMOOTH = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local function make(className, properties, children)
	local object = Instance.new(className)
	for property, value in pairs(properties or {}) do
		object[property] = value
		bindThemeValue(object, property, value)
	end
	for _, child in ipairs(children or {}) do
		child.Parent = object
	end
	return object
end

local function corner(radius)
	return make("UICorner", { CornerRadius = UDim.new(0, radius) })
end

local function stroke(color, transparency, thickness)
	return make("UIStroke", {
		Color = color or COLORS.Border,
		Transparency = transparency or 0,
		Thickness = thickness or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
end

local function tween(object, properties, tweenInfo)
	local animation = TweenService:Create(object, tweenInfo or FAST, properties)
	animation:Play()
	return animation
end

local function clamp(value, minimum, maximum)
	return math.max(minimum, math.min(maximum, value))
end

local function callback(fn, ...)
	if type(fn) ~= "function" then
		return
	end

	local arguments = table.pack(...)
	task.spawn(function()
		local ok, message = pcall(function()
			fn(table.unpack(arguments, 1, arguments.n))
		end)
		if not ok then
			warn("[PrismUI callback] " .. tostring(message))
		end
	end)
end

local function label(parent, text, size, color, font)
	return make("TextLabel", {
		Parent = parent,
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = color or COLORS.Text,
		TextSize = size or 14,
		Font = font or Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	})
end

local function addHover(button, restingColor, hoverColor)
	local restingKey
	local hoverKey
	for key, themeColor in pairs(COLORS) do
		if themeColor == restingColor then restingKey = key end
		if themeColor == hoverColor then hoverKey = key end
	end
	button.MouseEnter:Connect(function()
		setThemeBinding(button, "BackgroundColor3", hoverKey)
		tween(button, { BackgroundColor3 = hoverKey and COLORS[hoverKey] or hoverColor }, FAST)
	end)
	button.MouseLeave:Connect(function()
		setThemeBinding(button, "BackgroundColor3", restingKey)
		tween(button, { BackgroundColor3 = restingKey and COLORS[restingKey] or restingColor }, FAST)
	end)
end

local function createCard(parent, height)
	local card = make("Frame", {
		Parent = parent,
		Active = true,
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Size = UDim2.new(1, 0, 0, height),
	}, { corner(12) })
	local cardStroke = stroke(COLORS.Border, 0.48, 1)
	cardStroke.Parent = card
	card.MouseEnter:Connect(function()
		setThemeBinding(card, "BackgroundColor3", "SurfaceHover")
		setThemeBinding(cardStroke, "Color", "Accent")
		tween(card, { BackgroundColor3 = COLORS.SurfaceHover }, FAST)
		tween(cardStroke, { Color = COLORS.Accent, Transparency = 0.72 }, FAST)
	end)
	card.MouseLeave:Connect(function()
		setThemeBinding(card, "BackgroundColor3", "Surface")
		setThemeBinding(cardStroke, "Color", "Border")
		tween(card, { BackgroundColor3 = COLORS.Surface }, FAST)
		tween(cardStroke, { Color = COLORS.Border, Transparency = 0.48 }, FAST)
	end)
	return card
end

local function addCardText(card, titleText, descriptionText)
	local hasDescription = descriptionText ~= nil and tostring(descriptionText) ~= ""
	local title = label(card, titleText, 14, COLORS.Text, Enum.Font.GothamMedium)
	title.Position = UDim2.fromOffset(18, hasDescription and 10 or 0)
	title.Size = UDim2.new(1, -138, 0, hasDescription and 21 or 70)
	title.TextYAlignment = Enum.TextYAlignment.Center

	if hasDescription then
		local description = label(card, descriptionText, 11, COLORS.Muted, Enum.Font.Gotham)
		description.Position = UDim2.fromOffset(18, 33)
		description.Size = UDim2.new(1, -138, 0, 18)
	end

	return title
end

function PrismUI:CreateWindow(config)
	config = config or {}

	local chosenTheme, chosenThemeName = resolveTheme(config.Theme or "Amethyst")
	COLORS = chosenTheme
	if typeof(config.Accent) == "Color3" then
		COLORS.Accent = config.Accent
	end

	local guiParent = playerGui
	local usingRobloxGui = false
	local parentProbe
	local coreParentOk = pcall(function()
		local robloxGui = CoreGui:FindFirstChild("RobloxGui")
		if not robloxGui then error("RobloxGui is unavailable") end
		parentProbe = Instance.new("Folder")
		parentProbe.Parent = robloxGui
		guiParent = robloxGui
		usingRobloxGui = true
	end)
	if parentProbe then parentProbe:Destroy() end
	if not coreParentOk then
		guiParent = playerGui
		usingRobloxGui = false
	end

	local previous = guiParent:FindFirstChild("PrismUI")
	if previous then previous:Destroy() end
	if guiParent ~= playerGui then
		local previousFallback = playerGui:FindFirstChild("PrismUI")
		if previousFallback then previousFallback:Destroy() end
	end

	local window = {
		Tabs = {},
		Connections = {},
		ActiveTab = nil,
		OpenPopup = nil,
		Minimized = false,
		Destroyed = false,
	}

	local function connect(signal, fn)
		local connection = signal:Connect(fn)
		table.insert(window.Connections, connection)
		return connection
	end

	local screen
	if usingRobloxGui then
		screen = make("Frame", {
			Name = "PrismUI",
			Parent = guiParent,
			Active = false,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ZIndex = config.DisplayOrder or 50,
		})
	else
		screen = make("ScreenGui", {
			Name = "PrismUI",
			Parent = playerGui,
			ResetOnSpawn = false,
			IgnoreGuiInset = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			DisplayOrder = config.DisplayOrder or 50,
		})
	end
	local guiHitTestRoot = usingRobloxGui and CoreGui or playerGui
	local camera = workspace.CurrentCamera
	local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
	local wantedSize = config.Size or Vector2.new(840, 560)
	local initialMinWidth = math.max(300, math.min(440, viewport.X - 16))
	local initialMinHeight = math.max(260, math.min(320, viewport.Y - 16))
	local initialSize = Vector2.new(
		clamp(wantedSize.X, initialMinWidth, math.max(initialMinWidth, viewport.X - 16)),
		clamp(wantedSize.Y, initialMinHeight, math.max(initialMinHeight, viewport.Y - 16))
	)

	local shadow = make("Frame", {
		Name = "Shadow",
		Parent = screen,
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.58,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(
			math.floor((viewport.X - initialSize.X) / 2) + 7,
			math.floor((viewport.Y - initialSize.Y) / 2) + 9
		),
		Size = UDim2.fromOffset(initialSize.X, initialSize.Y),
	}, { corner(16) })
	local shadowScale = make("UIScale", {
		Parent = shadow,
		Scale = 1,
	})

	local main = make("Frame", {
		Name = "Window",
		Parent = screen,
		BackgroundColor3 = COLORS.Background,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.fromOffset(
			math.floor((viewport.X - initialSize.X) / 2),
			math.floor((viewport.Y - initialSize.Y) / 2)
		),
		Size = UDim2.fromOffset(initialSize.X, initialSize.Y),
	}, {
		corner(16),
		stroke(COLORS.Border, 0, 1),
	})
	local mainScale = make("UIScale", {
		Parent = main,
		Scale = 1,
	})

	local topBar = make("Frame", {
		Name = "TopBar",
		Parent = main,
		Active = true,
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 64),
	}, { corner(16) })
	make("UIGradient", {
		Parent = topBar,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, COLORS.SurfaceRaised),
			ColorSequenceKeypoint.new(1, COLORS.Surface),
		}),
		Rotation = 8,
	})

	make("Frame", {
		Parent = topBar,
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -16),
		Size = UDim2.new(1, 0, 0, 16),
	})

	local brandDot = make("Frame", {
		Parent = topBar,
		BackgroundColor3 = COLORS.Accent,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(20, 22),
		Size = UDim2.fromOffset(20, 20),
	}, { corner(7) })
	make("UIGradient", {
		Parent = brandDot,
		Color = ColorSequence.new(COLORS.Accent, COLORS.AccentDark),
		Rotation = 35,
	})
	make("Frame", {
		Parent = brandDot,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		Rotation = 45,
		Size = UDim2.fromOffset(7, 7),
	}, { corner(2) })

	local title = label(topBar, config.Title or "Prism UI", 16, COLORS.Text, Enum.Font.GothamBold)
	title.Position = UDim2.fromOffset(52, 8)
	title.Size = UDim2.new(1, -155, 0, 21)
	title.TextYAlignment = Enum.TextYAlignment.Center

	local subtitle = label(topBar, config.Subtitle or "Interface Library", 11, COLORS.Muted, Enum.Font.Gotham)
	subtitle.Position = UDim2.fromOffset(52, 29)
	subtitle.Size = UDim2.new(1, -155, 0, 16)
	subtitle.TextYAlignment = Enum.TextYAlignment.Center

	local themeBadge = make("Frame", {
		Parent = topBar,
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = COLORS.SurfaceRaised,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -102, 0.5, 0),
		Size = UDim2.fromOffset(94, 26),
	}, {
		corner(8),
		stroke(COLORS.Accent, 0.58, 1),
	})
	local badgeText = label(themeBadge, string.upper(config.Badge or chosenThemeName), 9, COLORS.Accent, Enum.Font.GothamBold)
	badgeText.Size = UDim2.fromScale(1, 1)
	badgeText.TextXAlignment = Enum.TextXAlignment.Center
	badgeText.TextYAlignment = Enum.TextYAlignment.Center

	local function topButton(xOffset, hoverColor)
		local button = make("TextButton", {
			Parent = topBar,
			AnchorPoint = Vector2.new(0.5, 0.5),
			AutoButtonColor = false,
			BackgroundColor3 = COLORS.SurfaceRaised,
			BorderSizePixel = 0,
			Position = UDim2.new(1, xOffset, 0.5, 0),
			Size = UDim2.fromOffset(32, 32),
			Text = "",
		}, { corner(9) })
		addHover(button, COLORS.SurfaceRaised, hoverColor)
		return button
	end

	local minimizeButton = topButton(-72, COLORS.SurfaceHover)
	local closeButton = topButton(-32, COLORS.Danger)
	make("Frame", {
		Parent = minimizeButton,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = COLORS.Muted,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(12, 2),
	}, { corner(1) })
	for _, rotation in ipairs({ 45, -45 }) do
		make("Frame", {
			Parent = closeButton,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = COLORS.Muted,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.5, 0.5),
			Rotation = rotation,
			Size = UDim2.fromOffset(2, 13),
		}, { corner(1) })
	end

	local body = make("Frame", {
		Name = "Body",
		Parent = main,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 64),
		Size = UDim2.new(1, 0, 1, -64),
	})

	local sidebar = make("Frame", {
		Name = "Sidebar",
		Parent = body,
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Size = UDim2.new(0, 200, 1, 0),
	}, { corner(16) })

	-- Keep the sidebar's shared edges square while preserving the window's
	-- rounded lower-left silhouette.
	make("Frame", {
		Parent = sidebar,
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 18),
	})
	make("Frame", {
		Parent = sidebar,
		AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(1, 0),
		Size = UDim2.new(0, 18, 1, 0),
	})
	local sidebarBottomFill = make("Frame", {
		Parent = sidebar,
		AnchorPoint = Vector2.new(0, 1),
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.fromOffset(18, 18),
		Visible = false,
	})

	local sidebarDivider = make("Frame", {
		Parent = sidebar,
		AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = COLORS.Border,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(0, 1, 1, 0),
	})

	local tabLayout = make("UIListLayout", {
		Padding = UDim.new(0, 7),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local tabList = make("ScrollingFrame", {
		Name = "TabList",
		Parent = sidebar,
		Active = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(),
		ScrollBarImageColor3 = COLORS.Border,
		ScrollBarThickness = 2,
		Position = UDim2.fromOffset(12, 16),
		Size = UDim2.new(1, -24, 1, -98),
	}, { tabLayout })

	local sidebarFooter = make("Frame", {
		Parent = sidebar,
		AnchorPoint = Vector2.new(0, 1),
		BackgroundColor3 = COLORS.Background,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 12, 1, -12),
		Size = UDim2.new(1, -24, 0, 58),
	}, {
		corner(9),
		stroke(COLORS.Border, 0.45, 1),
	})
	local readyDot = make("Frame", {
		Parent = sidebarFooter,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = COLORS.Accent,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.fromOffset(34, 34),
	}, { corner(10) })
	local initialLabel = label(readyDot, string.upper(string.sub(localPlayer.DisplayName, 1, 1)), 13, COLORS.Text, Enum.Font.GothamBold)
	initialLabel.Size = UDim2.fromScale(1, 1)
	initialLabel.TextXAlignment = Enum.TextXAlignment.Center
	initialLabel.TextYAlignment = Enum.TextYAlignment.Center
	local footerTitle = label(sidebarFooter, localPlayer.DisplayName, 11, COLORS.Text, Enum.Font.GothamMedium)
	footerTitle.Position = UDim2.fromOffset(54, 10)
	footerTitle.Size = UDim2.new(1, -64, 0, 18)
	local footerStatus = label(sidebarFooter, config.Profile or ("@" .. localPlayer.Name), 9, COLORS.Muted, Enum.Font.Gotham)
	footerStatus.Position = UDim2.fromOffset(54, 28)
	footerStatus.Size = UDim2.new(1, -64, 0, 16)

	local content = make("Frame", {
		Name = "Content",
		Parent = body,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(200, 0),
		Size = UDim2.new(1, -200, 1, 0),
	})

	local pageHeading = label(content, "Overview", 15, COLORS.Text, Enum.Font.GothamBold)
	pageHeading.Position = UDim2.fromOffset(20, 14)
	pageHeading.Size = UDim2.new(1, -330, 0, 22)
	local pageHint = label(content, "Browse and configure controls", 10, COLORS.Muted, Enum.Font.Gotham)
	pageHint.Position = UDim2.fromOffset(20, 36)
	pageHint.Size = UDim2.new(1, -330, 0, 17)
	local contentDivider = make("Frame", {
		Parent = content,
		BackgroundColor3 = COLORS.Border,
		BackgroundTransparency = 0.58,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(18, 66),
		Size = UDim2.new(1, -36, 0, 1),
	})

	local searchFrame = make("Frame", {
		Name = "Search",
		Parent = content,
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -18, 0, 16),
		Size = UDim2.fromOffset(272, 40),
	}, {
		corner(10),
		stroke(COLORS.Border, 0.3, 1),
	})
	local searchIcon = label(searchFrame, "⌕", 18, COLORS.Muted, Enum.Font.GothamBold)
	searchIcon.Position = UDim2.fromOffset(12, 0)
	searchIcon.Size = UDim2.fromOffset(24, 38)
	searchIcon.TextXAlignment = Enum.TextXAlignment.Center
	searchIcon.TextYAlignment = Enum.TextYAlignment.Center
	local searchBox = make("TextBox", {
		Parent = searchFrame,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		Font = Enum.Font.Gotham,
		PlaceholderColor3 = COLORS.Muted,
		PlaceholderText = "Search controls...",
		Position = UDim2.fromOffset(42, 0),
		Size = UDim2.new(1, -142, 1, 0),
		Text = "",
		TextColor3 = COLORS.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	local searchResults = label(searchFrame, "ALL", 8, COLORS.Muted, Enum.Font.GothamBold)
	searchResults.AnchorPoint = Vector2.new(1, 0.5)
	searchResults.Position = UDim2.new(1, -38, 0.5, 0)
	searchResults.Size = UDim2.fromOffset(60, 22)
	searchResults.TextXAlignment = Enum.TextXAlignment.Right
	local clearSearch = make("TextButton", {
		Parent = searchFrame,
		AnchorPoint = Vector2.new(1, 0.5),
		AutoButtonColor = false,
		BackgroundColor3 = COLORS.SurfaceRaised,
		BorderSizePixel = 0,
		Font = Enum.Font.GothamBold,
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.fromOffset(22, 22),
		Text = "×",
		TextColor3 = COLORS.Muted,
		TextSize = 12,
		Visible = false,
	}, { corner(7) })

	local resizeGrip = make("TextButton", {
		Name = "ResizeGrip",
		Parent = main,
		AnchorPoint = Vector2.new(1, 1),
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(1, 0, 1, 0),
		Size = UDim2.fromOffset(28, 28),
		Text = "",
		ZIndex = 20,
	})

	for index = 0, 2 do
		make("Frame", {
			Parent = resizeGrip,
			AnchorPoint = Vector2.new(1, 1),
			BackgroundColor3 = COLORS.Muted,
			BackgroundTransparency = 0.15 + index * 0.18,
			BorderSizePixel = 0,
			Position = UDim2.new(1, -5, 1, -5 - index * 5),
			Rotation = -45,
			Size = UDim2.fromOffset(2, 9 + index * 5),
		})
	end

	local reopenButton = make("TextButton", {
		Name = "Reopen",
		Parent = screen,
		AnchorPoint = Vector2.new(0, 1),
		AutoButtonColor = false,
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 16, 1, -16),
		Size = UDim2.fromOffset(42, 42),
		Text = "",
		Visible = false,
	}, {
		corner(13),
		stroke(COLORS.Border, 0, 1),
	})
	if config.Logo then
		local logoSource = tostring(config.Logo)
		if tonumber(logoSource) then logoSource = "rbxassetid://" .. logoSource end
		make("ImageLabel", {
			Parent = reopenButton,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Image = logoSource,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(24, 24),
			ZIndex = 2,
		})
	else
		local logoMark = make("Frame", {
			Parent = reopenButton,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = COLORS.Accent,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.5, 0.5),
			Rotation = 45,
			Size = UDim2.fromOffset(19, 19),
			ZIndex = 2,
		}, { corner(6) })
		make("UIGradient", {
			Parent = logoMark,
			Color = ColorSequence.new(COLORS.Accent, COLORS.AccentDark),
			Rotation = 45,
		})
		make("Frame", {
			Parent = logoMark,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = COLORS.Surface,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(7, 7),
			ZIndex = 3,
		}, { corner(2) })
	end
	local reopenScale = make("UIScale", {
		Parent = reopenButton,
		Scale = 0.7,
	})
	addHover(reopenButton, COLORS.Surface, COLORS.SurfaceHover)

	local notificationRoot = make("Frame", {
		Name = "Notifications",
		Parent = screen,
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -16, 0, 16),
		Size = UDim2.new(1, -32, 1, -32),
		ZIndex = 200,
	}, {
		make("UISizeConstraint", {
			MaxSize = Vector2.new(350, 10000),
		}),
		make("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			Padding = UDim.new(0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Top,
		}),
	})
	local notificationOrder = 0

	local closeOverlay = make("TextButton", {
		Name = "CloseConfirmation",
		Parent = main,
		Active = true,
		AutoButtonColor = false,
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		Visible = false,
		ZIndex = 100,
	})
	local closeDialog = make("Frame", {
		Parent = closeOverlay,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = COLORS.Surface,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, -32, 0, 188),
		ZIndex = 101,
	}, {
		corner(14),
		stroke(COLORS.Border, 0, 1),
		make("UISizeConstraint", {
			MinSize = Vector2.new(250, 188),
			MaxSize = Vector2.new(340, 188),
		}),
	})
	local closeDialogScale = make("UIScale", {
		Parent = closeDialog,
		Scale = 0.82,
	})
	local warningMark = label(closeDialog, "!", 15, COLORS.Danger, Enum.Font.GothamBold)
	warningMark.BackgroundColor3 = COLORS.SurfaceRaised
	warningMark.BackgroundTransparency = 0
	warningMark.Position = UDim2.fromOffset(18, 17)
	warningMark.Size = UDim2.fromOffset(30, 30)
	warningMark.TextXAlignment = Enum.TextXAlignment.Center
	warningMark.TextYAlignment = Enum.TextYAlignment.Center
	warningMark.ZIndex = 102
	corner(9).Parent = warningMark
	local closeTitle = label(closeDialog, "Close " .. tostring(config.Title or "Prism UI") .. "?", 16, COLORS.Text, Enum.Font.GothamBold)
	closeTitle.Position = UDim2.fromOffset(60, 16)
	closeTitle.Size = UDim2.new(1, -78, 0, 24)
	closeTitle.ZIndex = 102
	local closeDescription = label(closeDialog, "Are you sure? The interface and its client callbacks will be unloaded.", 11, COLORS.Muted, Enum.Font.Gotham)
	closeDescription.Position = UDim2.fromOffset(20, 58)
	closeDescription.Size = UDim2.new(1, -40, 0, 44)
	closeDescription.TextWrapped = true
	closeDescription.TextYAlignment = Enum.TextYAlignment.Top
	closeDescription.ZIndex = 102
	local cancelClose = make("TextButton", {
		Parent = closeDialog,
		AnchorPoint = Vector2.new(1, 1),
		AutoButtonColor = false,
		BackgroundColor3 = COLORS.SurfaceRaised,
		BorderSizePixel = 0,
		Font = Enum.Font.GothamMedium,
		Position = UDim2.new(1, -118, 1, -18),
		Size = UDim2.fromOffset(94, 36),
		Text = "Cancel",
		TextColor3 = COLORS.Text,
		TextSize = 11,
		ZIndex = 102,
	}, { corner(9) })
	local confirmClose = make("TextButton", {
		Parent = closeDialog,
		AnchorPoint = Vector2.new(1, 1),
		AutoButtonColor = false,
		BackgroundColor3 = COLORS.Danger,
		BorderSizePixel = 0,
		Font = Enum.Font.GothamBold,
		Position = UDim2.new(1, -18, 1, -18),
		Size = UDim2.fromOffset(94, 36),
		Text = "Close UI",
		TextColor3 = COLORS.Text,
		TextSize = 11,
		ZIndex = 102,
	}, { corner(9) })
	addHover(cancelClose, COLORS.SurfaceRaised, COLORS.SurfaceHover)
	addHover(confirmClose, COLORS.Danger, Color3.fromRGB(199, 65, 91))

	window.Gui = screen
	window.Main = main
	window.Shadow = shadow
	window.Accent = COLORS.Accent
	window.ThemeName = chosenThemeName

	local expandedSize = main.Size
	local expandedPosition = main.Position
	local function syncShadow()
		shadow.Visible = main.Visible
		shadow.Position = UDim2.fromOffset(main.Position.X.Offset + 7, main.Position.Y.Offset + 9)
		shadow.Size = main.Size
	end

	local function getViewport()
		local currentCamera = workspace.CurrentCamera
		return currentCamera and currentCamera.ViewportSize or Vector2.new(1280, 720)
	end

	local reopenDragging = false
	local reopenMoved = false
	local reopenDragStart = Vector2.zero
	local reopenPositionStart = Vector2.zero
	connect(reopenButton.InputBegan, function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		reopenDragging = true
		reopenMoved = false
		reopenDragStart = Vector2.new(input.Position.X, input.Position.Y)
		reopenPositionStart = reopenButton.AbsolutePosition
		reopenButton.AnchorPoint = Vector2.zero
		reopenButton.Position = UDim2.fromOffset(reopenPositionStart.X, reopenPositionStart.Y)
	end)
	connect(UserInputService.InputChanged, function(input)
		if not reopenDragging then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local current = Vector2.new(input.Position.X, input.Position.Y)
		local delta = current - reopenDragStart
		if delta.Magnitude > 5 then reopenMoved = true end
		local currentViewport = getViewport()
		reopenButton.Position = UDim2.fromOffset(
			clamp(reopenPositionStart.X + delta.X, 8, currentViewport.X - reopenButton.AbsoluteSize.X - 8),
			clamp(reopenPositionStart.Y + delta.Y, 8, currentViewport.Y - reopenButton.AbsoluteSize.Y - 8)
		)
	end)
	connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			reopenDragging = false
		end
	end)

	local function clampWindow()
		local currentViewport = getViewport()
		local size = Vector2.new(main.Size.X.Offset, main.Size.Y.Offset)
		local x = clamp(main.Position.X.Offset, 8, math.max(8, currentViewport.X - size.X - 8))
		main.Position = UDim2.fromOffset(x, main.Position.Y.Offset)
		syncShadow()
	end

	local function updateResponsiveLayout(layoutSize)
		local measuredSize = layoutSize or main.Size
		local width = measuredSize.X.Offset
		local height = measuredSize.Y.Offset
		local compactHeight = height < 440
		local pageLeft = width < 560 and 14 or 18
		local pageTop = compactHeight and 60 or 76

		if width < 560 then
			themeBadge.Visible = false
			sidebarFooter.Visible = false
			sidebarBottomFill.Visible = true
			pageHeading.Visible = false
			pageHint.Visible = false
			contentDivider.Visible = false
			title.Size = UDim2.new(1, -155, 0, 21)
			subtitle.Size = UDim2.new(1, -155, 0, 16)
			sidebar.Position = UDim2.fromOffset(0, 0)
			sidebar.Size = UDim2.new(1, 0, 0, 58)
			sidebarDivider.AnchorPoint = Vector2.new(0, 1)
			sidebarDivider.Position = UDim2.new(0, 0, 1, 0)
			sidebarDivider.Size = UDim2.new(1, 0, 0, 1)
			tabList.AutomaticCanvasSize = Enum.AutomaticSize.X
			tabList.Position = UDim2.fromOffset(10, 8)
			tabList.Size = UDim2.new(1, -16, 0, 42)
			tabLayout.FillDirection = Enum.FillDirection.Horizontal
			content.Position = UDim2.fromOffset(0, 58)
			content.Size = UDim2.new(1, 0, 1, -58)
			searchFrame.AnchorPoint = Vector2.new(0, 0)
			searchFrame.Position = UDim2.fromOffset(pageLeft, 10)
			searchFrame.Size = UDim2.new(1, -(pageLeft * 2), 0, 40)
			pageTop = 60
			for _, tab in ipairs(window.Tabs) do
				tab.Button.Size = UDim2.fromOffset(118, 42)
			end
		else
			local sidebarWidth = width < 720 and 168 or 200
			themeBadge.Visible = width >= 760
			sidebarFooter.Visible = true
			sidebarBottomFill.Visible = false
			pageHeading.Visible = width >= 720 and not compactHeight
			pageHint.Visible = width >= 720 and not compactHeight
			contentDivider.Visible = not compactHeight
			title.Size = UDim2.new(1, width >= 760 and -270 or -165, 0, 21)
			subtitle.Size = UDim2.new(1, width >= 760 and -270 or -165, 0, 16)
			sidebar.Position = UDim2.fromOffset(0, 0)
			sidebar.Size = UDim2.new(0, sidebarWidth, 1, 0)
			sidebarDivider.AnchorPoint = Vector2.new(1, 0)
			sidebarDivider.Position = UDim2.new(1, 0, 0, 0)
			sidebarDivider.Size = UDim2.new(0, 1, 1, 0)
			tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
			tabList.Position = UDim2.fromOffset(12, 16)
			tabList.Size = UDim2.new(1, -24, 1, -98)
			tabLayout.FillDirection = Enum.FillDirection.Vertical
			content.Position = UDim2.fromOffset(sidebarWidth, 0)
			content.Size = UDim2.new(1, -sidebarWidth, 1, 0)
			searchFrame.AnchorPoint = Vector2.new(1, 0)
			searchFrame.Position = UDim2.new(1, -18, 0, compactHeight and 10 or 16)
			searchFrame.Size = width < 720 and UDim2.new(1, -36, 0, 40) or UDim2.fromOffset(272, 40)
			for _, tab in ipairs(window.Tabs) do
				tab.Button.Size = UDim2.new(1, 0, 0, 42)
			end
		end

		window.PageLeft = pageLeft
		window.PageTop = pageTop
		for _, tab in ipairs(window.Tabs) do
			tab.Page.Position = UDim2.fromOffset(pageLeft, pageTop)
			tab.Page.Size = UDim2.new(1, -(pageLeft * 2), 1, -(pageTop + 12))
		end
	end

	local dragging = false
	local dragStart = Vector2.zero
	local startPosition = Vector2.zero
	local dragBlockingObjects = setmetatable({}, { __mode = "k" })

	local function pointInside(guiObject, point)
		local position = guiObject.AbsolutePosition
		local size = guiObject.AbsoluteSize
		return point.X >= position.X and point.X <= position.X + size.X
			and point.Y >= position.Y and point.Y <= position.Y + size.Y
	end

	local function isInteractiveAtPoint(point)
		for _, object in ipairs(guiHitTestRoot:GetGuiObjectsAtPosition(point.X, point.Y)) do
			if object:IsDescendantOf(notificationRoot) then
				return true
			end

			local current = object
			while current and current ~= guiHitTestRoot do
				if current:IsA("GuiButton") or current:IsA("TextBox") then
					return true
				end
				if dragBlockingObjects[current] then
					return true
				end
				if current:IsA("ScrollingFrame") then
					local scrollWidth = math.max(9, current.ScrollBarThickness + 5)
					if point.X >= current.AbsolutePosition.X + current.AbsoluteSize.X - scrollWidth then
						return true
					end
				end
				current = current.Parent
			end
		end
		return false
	end

	local function setPageScrollingEnabled(enabled)
		if not enabled then tabList:ResetScrollVelocity() end
		tabList.ScrollingEnabled = enabled
		for _, tab in ipairs(window.Tabs) do
			if not enabled then tab.Page:ResetScrollVelocity() end
			tab.Page.ScrollingEnabled = enabled
		end
	end

	local function beginWindowDrag(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		dragging = true
		dragStart = Vector2.new(input.Position.X, input.Position.Y)
		startPosition = Vector2.new(main.Position.X.Offset, main.Position.Y.Offset)
		setPageScrollingEnabled(false)
	end

	connect(UserInputService.InputBegan, function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		if window.Minimized or window.VisibilityBusy or not main.Visible then
			return
		end

		local point = Vector2.new(input.Position.X, input.Position.Y)
		if not pointInside(main, point) and not pointInside(shadow, point) then
			return
		end
		if isInteractiveAtPoint(point) then
			return
		end

		beginWindowDrag(input)
	end)

	connect(UserInputService.InputChanged, function(input)
		if not dragging then
			return
		end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local currentViewport = getViewport()
		local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
		local maxX = math.max(8, currentViewport.X - main.AbsoluteSize.X - 8)
		main.Position = UDim2.fromOffset(
			clamp(startPosition.X + delta.X, 8, maxX),
			startPosition.Y + delta.Y
		)
		syncShadow()
	end)

	connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			if dragging then
				dragging = false
				setPageScrollingEnabled(true)
			end
		end
	end)

	local resizing = false
	local resizeStart = Vector2.zero
	local startSize = Vector2.zero

	connect(resizeGrip.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			resizeStart = Vector2.new(input.Position.X, input.Position.Y)
			startSize = main.AbsoluteSize
		end
	end)

	connect(UserInputService.InputChanged, function(input)
		if not resizing or window.Minimized then
			return
		end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local currentViewport = getViewport()
		local delta = Vector2.new(input.Position.X, input.Position.Y) - resizeStart
		local minWidth = math.max(300, math.min(440, currentViewport.X - 16))
		local minHeight = math.max(260, math.min(320, currentViewport.Y - 16))
		local maxWidth = math.max(minWidth, currentViewport.X - main.Position.X.Offset - 8)
		local maxHeight = math.max(minHeight, currentViewport.Y - main.Position.Y.Offset - 8)
		local width = clamp(startSize.X + delta.X, minWidth, maxWidth)
		local height = clamp(startSize.Y + delta.Y, minHeight, maxHeight)
		main.Size = UDim2.fromOffset(width, height)
		expandedSize = main.Size
		expandedPosition = main.Position
		if reopenButton.AnchorPoint == Vector2.zero then
			reopenButton.Position = UDim2.fromOffset(
				clamp(reopenButton.Position.X.Offset, 8, currentViewport.X - reopenButton.AbsoluteSize.X - 8),
				clamp(reopenButton.Position.Y.Offset, 8, currentViewport.Y - reopenButton.AbsoluteSize.Y - 8)
			)
		end
		updateResponsiveLayout()
		syncShadow()
	end)

	connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			resizing = false
		end
	end)

	function window:SetVisible(visible)
		if self.Destroyed or self.VisibilityBusy then
			return
		end
		if visible == main.Visible then
			return
		end

		self.VisibilityBusy = true
		self.Minimized = not visible
		local morphInfo = TweenInfo.new(0.34, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
		mainScale.Scale = 1
		shadowScale.Scale = 1

		if visible then
			local origin = reopenButton.AbsolutePosition
			main.Position = UDim2.fromOffset(origin.X, origin.Y)
			main.Size = UDim2.fromOffset(42, 42)
			shadow.Position = UDim2.fromOffset(origin.X + 2, origin.Y + 3)
			shadow.Size = UDim2.fromOffset(42, 42)
			main.Visible = true
			shadow.Visible = true
			reopenScale.Scale = 1
			tween(reopenScale, { Scale = 0.8 }, FAST)
			tween(main, { Position = expandedPosition, Size = expandedSize }, morphInfo)
			tween(shadow, {
				Position = UDim2.fromOffset(expandedPosition.X.Offset + 7, expandedPosition.Y.Offset + 9),
				Size = expandedSize,
			}, morphInfo)
			task.delay(0.06, function()
				if self.Destroyed then return end
				reopenButton.Visible = false
			end)
			task.delay(0.35, function()
				if self.Destroyed then return end
				main.Position = expandedPosition
				main.Size = expandedSize
				updateResponsiveLayout(expandedSize)
				syncShadow()
				self.VisibilityBusy = false
			end)
		else
			expandedPosition = main.Position
			expandedSize = main.Size
			closeOverlay.Visible = false
			if self.OpenPopup then
				self.OpenPopup()
				self.OpenPopup = nil
			end
			local target = reopenButton.AbsolutePosition
			tween(main, {
				Position = UDim2.fromOffset(target.X, target.Y),
				Size = UDim2.fromOffset(42, 42),
			}, morphInfo)
			tween(shadow, {
				Position = UDim2.fromOffset(target.X + 2, target.Y + 3),
				Size = UDim2.fromOffset(42, 42),
			}, morphInfo)
			task.delay(0.34, function()
				if self.Destroyed then return end
				main.Visible = false
				shadow.Visible = false
				reopenButton.Visible = true
				reopenScale.Scale = 0.82
				tween(reopenScale, { Scale = 1 }, SMOOTH)
				self.VisibilityBusy = false
			end)
		end
	end

	function window:ToggleVisible()
		self:SetVisible(not main.Visible)
	end

	connect(minimizeButton.Activated, function()
		window:SetVisible(false)
	end)

	function window:Destroy()
		if self.Destroyed then
			return
		end
		self.Destroyed = true
		for _, connection in ipairs(self.Connections) do
			connection:Disconnect()
		end
		screen:Destroy()
	end

	connect(screen.Destroying, function()
		if window.Destroyed then return end
		window.Destroyed = true
		for _, connection in ipairs(window.Connections) do
			connection:Disconnect()
		end
	end)

	local function showClosePrompt()
		if closeOverlay.Visible then return end
		if window.OpenPopup then
			window.OpenPopup()
			window.OpenPopup = nil
		end
		closeOverlay.Visible = true
		closeOverlay.BackgroundTransparency = 1
		closeDialogScale.Scale = 0.82
		tween(closeOverlay, { BackgroundTransparency = 0.32 }, SMOOTH)
		tween(closeDialogScale, { Scale = 1 }, SMOOTH)
	end

	local function hideClosePrompt()
		if not closeOverlay.Visible then return end
		tween(closeOverlay, { BackgroundTransparency = 1 }, FAST)
		tween(closeDialogScale, { Scale = 0.86 }, FAST)
		task.delay(0.16, function()
			if not window.Destroyed then
				closeOverlay.Visible = false
			end
		end)
	end

	connect(closeButton.Activated, function()
		showClosePrompt()
	end)
	connect(cancelClose.Activated, hideClosePrompt)
	connect(closeOverlay.Activated, hideClosePrompt)
	connect(confirmClose.Activated, function()
		window:Destroy()
	end)

	connect(reopenButton.Activated, function()
		if reopenMoved then
			reopenMoved = false
			return
		end
		window:SetVisible(true)
	end)

	connect(UserInputService.InputBegan, function(input, processed)
		if processed then
			return
		end
		if input.KeyCode == (config.ToggleKey or Enum.KeyCode.RightShift) then
			window:ToggleVisible()
		end
	end)

	local function fitToViewport()
		if window.Destroyed then
			return
		end

		local currentViewport = getViewport()
		local preserveExpandedState = window.Minimized or window.VisibilityBusy
		local sourceSize = preserveExpandedState and expandedSize or main.Size
		local width = math.min(sourceSize.X.Offset, math.max(300, currentViewport.X - 16))
		local height = math.min(sourceSize.Y.Offset, math.max(260, currentViewport.Y - 16))
		expandedSize = UDim2.fromOffset(width, height)
		expandedPosition = UDim2.fromOffset(
			clamp(expandedPosition.X.Offset, 8, math.max(8, currentViewport.X - width - 8)),
			expandedPosition.Y.Offset
		)
		updateResponsiveLayout(expandedSize)

		if not preserveExpandedState then
			main.Size = expandedSize
			clampWindow()
			expandedPosition = main.Position
		elseif reopenButton.AnchorPoint == Vector2.zero then
			reopenButton.Position = UDim2.fromOffset(
				clamp(reopenButton.Position.X.Offset, 8, currentViewport.X - reopenButton.AbsoluteSize.X - 8),
				clamp(reopenButton.Position.Y.Offset, 8, currentViewport.Y - reopenButton.AbsoluteSize.Y - 8)
			)
		end
	end

	if camera then
		connect(camera:GetPropertyChangedSignal("ViewportSize"), fitToViewport)
	end
	connect(workspace:GetPropertyChangedSignal("CurrentCamera"), function()
		camera = workspace.CurrentCamera
		fitToViewport()
	end)

	function window:ChangeTheme(theme)
		if self.Destroyed then return false end
		local previousColors = table.clone(COLORS)
		local nextColors, nextName = resolveTheme(theme, COLORS)
		if typeof(config.Accent) == "Color3" and config.LockAccent == true then
			nextColors.Accent = config.Accent
		end

		local function remapColor(color)
			for key, previousColor in pairs(previousColors) do
				if color == previousColor then
					return nextColors[key]
				end
			end
			return nil
		end

		COLORS = nextColors
		self.Accent = nextColors.Accent
		self.ThemeName = nextName
		if not config.Badge then
			badgeText.Text = string.upper(nextName)
		end

		local colorProperties = {
			"BackgroundColor3", "BorderColor3", "TextColor3",
			"ImageColor3", "ScrollBarImageColor3",
		}
		for _, object in ipairs(screen:GetDescendants()) do
			if object:IsA("UIGradient") then
				local keypoints = {}
				local changed = false
				local encodedKeys = object:GetAttribute(THEME_ATTRIBUTE .. "Sequence_Color")
				local boundKeys = encodedKeys and string.split(encodedKeys, ",") or {}
				for index, keypoint in ipairs(object.Color.Keypoints) do
					local boundKey = boundKeys[index]
					local mapped = boundKey and boundKey ~= "_" and nextColors[boundKey]
						or remapColor(keypoint.Value)
					if mapped then changed = true end
					table.insert(keypoints, ColorSequenceKeypoint.new(keypoint.Time, mapped or keypoint.Value))
				end
				if changed then
					object.Color = ColorSequence.new(keypoints)
				end
			elseif object:IsA("UIStroke") then
				local boundKey = object:GetAttribute(THEME_ATTRIBUTE .. "Color")
				local mapped = boundKey and nextColors[boundKey] or remapColor(object.Color)
				if mapped then tween(object, { Color = mapped }, SMOOTH) end
			else
				for _, property in ipairs(colorProperties) do
					local ok, current = pcall(function()
						return object[property]
					end)
					if ok and typeof(current) == "Color3" then
						local boundKey = object:GetAttribute(THEME_ATTRIBUTE .. property)
						local mapped = boundKey and nextColors[boundKey] or remapColor(current)
						if mapped then
							tween(object, { [property] = mapped }, SMOOTH)
						end
					end
				end
			end
		end
		for _, tab in ipairs(self.Tabs) do
			for _, element in ipairs(tab.Elements) do
				if element.FollowTheme and element.Set then
					element:Set(self.Accent, true)
				end
			end
		end
		return true
	end

	function window:Notify(notification)
		if self.Destroyed then return nil end
		notification = notification or {}
		local titleText = tostring(notification.Title or config.Title or "Notification")
		local contentText = tostring(notification.Content or notification.Text or "")
		local duration = math.max(1, tonumber(notification.Duration) or 5)
		local actions = {}
		if notification.Button1 then table.insert(actions, tostring(notification.Button1)) end
		if notification.Button2 then table.insert(actions, tostring(notification.Button2)) end
		local hasActions = #actions > 0

		notificationOrder = notificationOrder - 1
		local toast = make("CanvasGroup", {
			Name = "Toast",
			Parent = notificationRoot,
			Active = true,
			BackgroundColor3 = COLORS.Surface,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			GroupTransparency = 1,
			LayoutOrder = notificationOrder,
			Size = UDim2.new(1, 0, 0, hasActions and 134 or 96),
			ZIndex = 201,
		}, {
			corner(13),
			stroke(COLORS.Border, 0.12, 1),
		})
		local toastScale = make("UIScale", {
			Parent = toast,
			Scale = 0.94,
		})

		make("Frame", {
			Parent = toast,
			BackgroundColor3 = COLORS.Accent,
			BorderSizePixel = 0,
			Size = UDim2.new(0, 3, 1, 0),
			ZIndex = 202,
		})
		local iconPlate = make("Frame", {
			Parent = toast,
			BackgroundColor3 = COLORS.SurfaceRaised,
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(16, 15),
			Size = UDim2.fromOffset(32, 32),
			ZIndex = 202,
		}, { corner(9) })
		if notification.Icon and tostring(notification.Icon) ~= "" then
			local iconSource = tostring(notification.Icon)
			if tonumber(iconSource) then iconSource = "rbxassetid://" .. iconSource end
			make("ImageLabel", {
				Parent = iconPlate,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = iconSource,
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(20, 20),
				ZIndex = 203,
			})
		else
			local toastMark = make("Frame", {
				Parent = iconPlate,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = COLORS.Accent,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.5),
				Rotation = 45,
				Size = UDim2.fromOffset(14, 14),
				ZIndex = 203,
			}, { corner(4) })
			make("Frame", {
				Parent = toastMark,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = COLORS.SurfaceRaised,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(5, 5),
				ZIndex = 204,
			}, { corner(2) })
		end

		local toastTitle = label(toast, titleText, 13, COLORS.Text, Enum.Font.GothamBold)
		toastTitle.Position = UDim2.fromOffset(60, 13)
		toastTitle.Size = UDim2.new(1, -104, 0, 22)
		toastTitle.TextYAlignment = Enum.TextYAlignment.Center
		toastTitle.ZIndex = 202

		local toastContent = label(toast, contentText, 11, COLORS.Muted, Enum.Font.Gotham)
		toastContent.Position = UDim2.fromOffset(60, 35)
		toastContent.Size = UDim2.new(1, -82, 0, hasActions and 43 or 45)
		toastContent.TextTruncate = Enum.TextTruncate.None
		toastContent.TextWrapped = true
		toastContent.TextYAlignment = Enum.TextYAlignment.Top
		toastContent.ZIndex = 202

		local dismissButton = make("TextButton", {
			Parent = toast,
			AnchorPoint = Vector2.new(1, 0),
			AutoButtonColor = false,
			BackgroundColor3 = COLORS.SurfaceRaised,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(1, -10, 0, 10),
			Size = UDim2.fromOffset(26, 26),
			Text = "",
			ZIndex = 203,
		}, { corner(8) })
		addHover(dismissButton, COLORS.SurfaceRaised, COLORS.Danger)
		for _, rotation in ipairs({ 45, -45 }) do
			make("Frame", {
				Parent = dismissButton,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = COLORS.Muted,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.5),
				Rotation = rotation,
				Size = UDim2.fromOffset(2, 11),
				ZIndex = 204,
			}, { corner(1) })
		end

		local progressTrack = make("Frame", {
			Parent = toast,
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = COLORS.SurfaceRaised,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0, 1),
			Size = UDim2.new(1, 0, 0, 3),
			ZIndex = 202,
		})
		local progress = make("Frame", {
			Parent = progressTrack,
			BackgroundColor3 = COLORS.Accent,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 203,
		})

		local closed = false
		local function dismiss()
			if closed or not toast.Parent then return end
			closed = true
			tween(toast, { GroupTransparency = 1 }, FAST)
			tween(toastScale, { Scale = 0.95 }, FAST)
			task.delay(0.17, function()
				if toast.Parent then toast:Destroy() end
			end)
		end
		connect(dismissButton.Activated, dismiss)

		for index, actionText in ipairs(actions) do
			local actionButton = make("TextButton", {
				Parent = toast,
				AnchorPoint = Vector2.new(1, 1),
				AutoButtonColor = false,
				BackgroundColor3 = index == 1 and COLORS.Accent or COLORS.SurfaceRaised,
				BorderSizePixel = 0,
				Font = Enum.Font.GothamBold,
				Position = UDim2.new(1, -16 - ((index - 1) * 90), 1, -12),
				Size = UDim2.fromOffset(82, 30),
				Text = actionText,
				TextColor3 = COLORS.Text,
				TextSize = 10,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				ZIndex = 203,
			}, { corner(8) })
			addHover(actionButton, index == 1 and COLORS.Accent or COLORS.SurfaceRaised,
				index == 1 and COLORS.AccentDark or COLORS.SurfaceHover)
			connect(actionButton.Activated, function()
				callback(notification.Callback, actionText)
				dismiss()
			end)
		end

		task.defer(function()
			if closed or not toast.Parent then return end
			tween(toast, { GroupTransparency = 0 }, SMOOTH)
			tween(toastScale, { Scale = 1 }, SMOOTH)
			tween(progress, { Size = UDim2.fromScale(0, 1) },
				TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out))
		end)
		task.delay(duration, dismiss)

		local handle = { Instance = toast }
		function handle:Close()
			dismiss()
		end
		return handle
	end

	function window:CreateTab(tabConfig)
		tabConfig = type(tabConfig) == "table" and tabConfig or { Name = tostring(tabConfig) }
		local tab = {
			Window = window,
			Elements = {},
			Sections = {},
			Name = tabConfig.Name or "Tab",
			Description = tabConfig.Description or "Browse and configure controls",
		}

		local tabButton = make("TextButton", {
			Parent = tabList,
			AutoButtonColor = false,
			BackgroundColor3 = COLORS.Surface,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Font = Enum.Font.GothamMedium,
			Size = UDim2.new(1, 0, 0, 42),
			Text = "",
		}, { corner(9) })

		local tabAccent = make("Frame", {
			Parent = tabButton,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = window.Accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 7, 0.5, 0),
			Size = UDim2.fromOffset(3, 20),
		}, { corner(2) })

		local tabText = label(tabButton, tostring(tabConfig.Icon and (tabConfig.Icon .. "  " .. tab.Name) or tab.Name), 12, COLORS.Muted, Enum.Font.GothamMedium)
		tabText.Position = UDim2.fromOffset(17, 0)
		tabText.Size = UDim2.new(1, -23, 1, 0)
		tabText.TextYAlignment = Enum.TextYAlignment.Center

		local page = make("ScrollingFrame", {
			Name = tab.Name,
			Parent = content,
			Active = true,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(),
			ScrollBarImageColor3 = COLORS.Border,
			ScrollBarThickness = 3,
			Position = UDim2.fromOffset(18, 76),
			Size = UDim2.new(1, -36, 1, -88),
			Visible = false,
		}, {
			make("UIListLayout", {
				Padding = UDim.new(0, 12),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			make("UIPadding", {
				PaddingBottom = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 5),
			}),
		})

		tab.Button = tabButton
		tab.Page = page

		function tab:ApplySearch(query)
			local normalized = string.lower(tostring(query or ""))
			local found = 0
			for _, element in ipairs(self.Elements) do
				local matches = normalized == ""
					or string.find(element.SearchText or "", normalized, 1, true) ~= nil
				element.Instance.Visible = matches
				if matches then found = found + 1 end
				if not matches and element.OpenState and element.Close then
					element:Close()
				end
			end
			for _, section in ipairs(self.Sections) do
				section.Visible = normalized == ""
			end
			searchResults.Text = normalized == "" and "ALL" or tostring(found) .. " FOUND"
			clearSearch.Visible = normalized ~= ""
		end

		local function registerElement(handle, elementConfig)
			elementConfig = elementConfig or {}
			handle.SearchText = string.lower(
				tostring(elementConfig.Name or "") .. " " .. tostring(elementConfig.Description or "")
			)
			table.insert(tab.Elements, handle)
			if window.ActiveTab == tab then
				tab:ApplySearch(searchBox.Text)
			end
			return handle
		end

		function tab:SetActive()
			if window.ActiveTab == self then
				return
			end

			if window.OpenPopup then
				window.OpenPopup()
				window.OpenPopup = nil
			end

			for _, other in ipairs(window.Tabs) do
				local active = other == self
				other.Page.Visible = active
				setThemeBinding(other.Button, "BackgroundColor3", active and "SurfaceRaised" or "Surface")
				setThemeBinding(other.Text, "TextColor3", active and "Text" or "Muted")
				tween(other.Button, {
					BackgroundTransparency = active and 0 or 1,
					BackgroundColor3 = active and COLORS.SurfaceRaised or COLORS.Surface,
				}, FAST)
				tween(other.Accent, { BackgroundTransparency = active and 0 or 1 }, FAST)
				tween(other.Text, { TextColor3 = active and COLORS.Text or COLORS.Muted }, FAST)
			end

			window.ActiveTab = self
			pageHeading.Text = self.Name
			pageHint.Text = self.Description
			local targetX = window.PageLeft or 18
			local targetY = window.PageTop or 76
			self.Page.Position = UDim2.fromOffset(targetX + 10, targetY)
			tween(self.Page, { Position = UDim2.fromOffset(targetX, targetY) }, SMOOTH)
			self:ApplySearch(searchBox.Text)
		end

		tab.Accent = tabAccent
		tab.Text = tabText
		table.insert(window.Tabs, tab)
		updateResponsiveLayout()
		connect(tabButton.Activated, function()
			tab:SetActive()
		end)

		if #window.Tabs == 1 then
			tab:SetActive()
		end

		function tab:CreateSection(sectionConfig)
			local sectionName = type(sectionConfig) == "table" and sectionConfig.Name or sectionConfig
			local section = label(page, tostring(sectionName or "Section"), 11, COLORS.Muted, Enum.Font.GothamBold)
			section.Size = UDim2.new(1, 0, 0, 32)
			section.TextYAlignment = Enum.TextYAlignment.Bottom
			table.insert(self.Sections, section)
			return section
		end

		function tab:CreateButton(buttonConfig)
			buttonConfig = buttonConfig or {}
			local card = createCard(page, 70)
			addCardText(card, buttonConfig.Name or "Button", buttonConfig.Description)

			local button = make("TextButton", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0.5),
				AutoButtonColor = false,
				BackgroundColor3 = window.Accent,
				BorderSizePixel = 0,
				Font = Enum.Font.GothamBold,
				Position = UDim2.new(1, -13, 0.5, 0),
				Size = UDim2.fromOffset(88, 34),
				RichText = false,
				Text = buttonConfig.ButtonText or "Run",
				TextColor3 = COLORS.Text,
				TextSize = 11,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
			}, { corner(9) })
			addHover(button, window.Accent, COLORS.AccentDark)

			local handle = { Instance = card }
			function handle:Press()
				callback(buttonConfig.Callback)
			end
			function handle:SetVisible(visible)
				card.Visible = visible
			end

			connect(button.Activated, function()
				tween(button, { Size = UDim2.fromOffset(82, 31) }, FAST)
				task.delay(0.1, function()
					if button.Parent then
						tween(button, { Size = UDim2.fromOffset(88, 34) }, FAST)
					end
				end)
				handle:Press()
			end)

			return registerElement(handle, buttonConfig)
		end

		function tab:CreateToggle(toggleConfig)
			toggleConfig = toggleConfig or {}
			local card = createCard(page, 70)
			addCardText(card, toggleConfig.Name or "Toggle", toggleConfig.Description)

			local button = make("TextButton", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0.5),
				AutoButtonColor = false,
				BackgroundColor3 = COLORS.SurfaceRaised,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -15, 0.5, 0),
				Size = UDim2.fromOffset(48, 27),
				Text = "",
			}, { corner(14), stroke(COLORS.Border, 0.2, 1) })

			local knob = make("Frame", {
				Parent = button,
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = COLORS.Muted,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 4, 0.5, 0),
				Size = UDim2.fromOffset(19, 19),
			}, { corner(10) })

			local handle = {
				Instance = card,
				Value = toggleConfig.CurrentValue == true,
			}

			local function render(instant)
				setThemeBinding(button, "BackgroundColor3", handle.Value and "Accent" or "SurfaceRaised")
				setThemeBinding(knob, "BackgroundColor3", handle.Value and "Text" or "Muted")
				local properties = {
					BackgroundColor3 = handle.Value and window.Accent or COLORS.SurfaceRaised,
				}
				local knobProperties = {
					Position = handle.Value and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
					BackgroundColor3 = handle.Value and COLORS.Text or COLORS.Muted,
				}
				if instant then
					for property, value in pairs(properties) do button[property] = value end
					for property, value in pairs(knobProperties) do knob[property] = value end
				else
					tween(button, properties, FAST)
					tween(knob, knobProperties, FAST)
				end
			end

			function handle:Set(value, silent)
				self.Value = value == true
				render(false)
				if not silent then
					callback(toggleConfig.Callback, self.Value)
				end
			end
			function handle:Get()
				return self.Value
			end
			function handle:SetVisible(visible)
				card.Visible = visible
			end

			render(true)
			connect(button.Activated, function()
				handle:Set(not handle.Value)
			end)

			return registerElement(handle, toggleConfig)
		end

		function tab:CreateSlider(sliderConfig)
			sliderConfig = sliderConfig or {}
			local range = sliderConfig.Range or { 0, 100 }
			local minimum = tonumber(range[1]) or 0
			local maximum = tonumber(range[2]) or 100
			if maximum < minimum then
				minimum, maximum = maximum, minimum
			end
			if maximum == minimum then
				maximum = minimum + 1
			end
			local increment = math.abs(tonumber(sliderConfig.Increment) or 1)
			if increment == 0 then increment = 1 end
			local suffix = tostring(sliderConfig.Suffix or "")
			local incrementText = tostring(increment)
			local decimalText = string.match(incrementText, "%.(%d+)")
			local decimalPlaces = decimalText and #decimalText or 0

			local card = createCard(page, 94)
			local titleLabel = addCardText(card, sliderConfig.Name or "Slider", sliderConfig.Description)
			local hasDescription = sliderConfig.Description ~= nil and tostring(sliderConfig.Description) ~= ""
			titleLabel.Size = UDim2.new(1, -145, 0, hasDescription and 21 or 54)

			local valuePill = make("Frame", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = COLORS.SurfaceRaised,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -16, 0, 15),
				Size = UDim2.fromOffset(112, 28),
			}, {
				corner(8),
				stroke(COLORS.Border, 0.45, 1),
			})
			local valueLabel = label(valuePill, "", 11, window.Accent, Enum.Font.GothamBold)
			valueLabel.Size = UDim2.fromScale(1, 1)
			valueLabel.TextXAlignment = Enum.TextXAlignment.Center
			valueLabel.TextYAlignment = Enum.TextYAlignment.Center

			local track = make("Frame", {
				Parent = card,
				BackgroundColor3 = COLORS.SurfaceRaised,
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(18, 74),
				Size = UDim2.new(1, -36, 0, 6),
			}, { corner(3) })
			local fill = make("Frame", {
				Parent = track,
				BackgroundColor3 = window.Accent,
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0, 1),
			}, { corner(3) })
			make("UIGradient", {
				Parent = fill,
				Color = ColorSequence.new(COLORS.AccentDark, window.Accent),
			})
			local knob = make("Frame", {
				Parent = track,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = COLORS.Text,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0, 0.5),
				Size = UDim2.fromOffset(16, 16),
				ZIndex = 4,
			}, {
				corner(8),
				stroke(window.Accent, 0, 2),
			})
			local hitbox = make("TextButton", {
				Parent = card,
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(12, 58),
				Size = UDim2.new(1, -24, 0, 34),
				Text = "",
				ZIndex = 5,
			})

			local handle = {
				Instance = card,
				Value = minimum,
				CurrentValue = minimum,
				Range = { minimum, maximum },
				Increment = increment,
			}

			local function snapValue(value)
				value = clamp(tonumber(value) or minimum, minimum, maximum)
				if value <= minimum then return minimum end
				if value >= maximum then return maximum end
				local snapped = minimum + math.floor(((value - minimum) / increment) + 0.5) * increment
				snapped = clamp(snapped, minimum, maximum)
				if decimalPlaces > 0 then
					snapped = tonumber(string.format("%." .. decimalPlaces .. "f", snapped)) or snapped
				end
				return snapped
			end

			local function displayValue(value)
				local formatted = decimalPlaces > 0
					and string.format("%." .. decimalPlaces .. "f", value)
					or string.format("%.0f", value)
				return formatted .. suffix
			end

			local function render(instant)
				local percent = (handle.Value - minimum) / (maximum - minimum)
				valueLabel.Text = displayValue(handle.Value)
				local fillSize = UDim2.fromScale(percent, 1)
				local knobPosition = UDim2.fromScale(percent, 0.5)
				if instant then
					fill.Size = fillSize
					knob.Position = knobPosition
				else
					tween(fill, { Size = fillSize }, TweenInfo.new(0.09, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
					tween(knob, { Position = knobPosition }, TweenInfo.new(0.09, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
				end
			end

			function handle:Set(value, silent)
				local nextValue = snapValue(value)
				local changed = nextValue ~= self.Value
				self.Value = nextValue
				self.CurrentValue = self.Value
				render(false)
				if not silent and changed then
					callback(sliderConfig.Callback, self.Value)
				end
			end
			function handle:Get()
				return self.Value
			end
			function handle:SetVisible(visible)
				card.Visible = visible
			end

			local draggingSlider = false
			local function updateFromInput(input)
				local percent = clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
				handle:Set(minimum + (maximum - minimum) * percent)
			end

			connect(hitbox.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
					draggingSlider = true
					tween(knob, { Size = UDim2.fromOffset(20, 20) }, FAST)
					updateFromInput(input)
				end
			end)
			connect(UserInputService.InputChanged, function(input)
				if not draggingSlider then return end
				if input.UserInputType == Enum.UserInputType.MouseMovement
					or input.UserInputType == Enum.UserInputType.Touch then
					updateFromInput(input)
				end
			end)
			connect(UserInputService.InputEnded, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
					draggingSlider = false
					tween(knob, { Size = UDim2.fromOffset(16, 16) }, FAST)
				end
			end)

			handle.Value = snapValue(sliderConfig.CurrentValue ~= nil and sliderConfig.CurrentValue or minimum)
			handle.CurrentValue = handle.Value
			render(true)
			return registerElement(handle, sliderConfig)
		end

		function tab:CreateDropdown(dropdownConfig)
			dropdownConfig = dropdownConfig or {}
			local card = createCard(page, 70)
			local titleLabel = addCardText(card, dropdownConfig.Name or "Dropdown", dropdownConfig.Description)
			local hasDescription = dropdownConfig.Description ~= nil and tostring(dropdownConfig.Description) ~= ""
			titleLabel.Size = UDim2.new(1, -190, 0, hasDescription and 21 or 70)

			local selectionLabel = label(card, "Select", 11, COLORS.Muted, Enum.Font.Gotham)
			selectionLabel.AnchorPoint = Vector2.new(1, 0.5)
			selectionLabel.Position = UDim2.new(1, -44, 0, 35)
			selectionLabel.Size = UDim2.fromOffset(125, 28)
			selectionLabel.TextXAlignment = Enum.TextXAlignment.Right

			local arrow = label(card, "⌄", 16, COLORS.Muted, Enum.Font.GothamBold)
			arrow.AnchorPoint = Vector2.new(0.5, 0.5)
			arrow.Position = UDim2.new(1, -24, 0, 35)
			arrow.Size = UDim2.fromOffset(22, 22)
			arrow.TextXAlignment = Enum.TextXAlignment.Center
			arrow.TextYAlignment = Enum.TextYAlignment.Center

			local headerButton = make("TextButton", {
				Parent = card,
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 70),
				Text = "",
				ZIndex = 3,
			})

			local optionsFrame = make("ScrollingFrame", {
				Parent = card,
				Active = true,
				BackgroundColor3 = COLORS.Background,
				BorderSizePixel = 0,
				CanvasSize = UDim2.new(),
				Position = UDim2.fromOffset(12, 70),
				ScrollBarImageColor3 = COLORS.Border,
				ScrollBarThickness = 2,
				Size = UDim2.new(1, -24, 0, 0),
			}, {
				corner(8),
				make("UIListLayout", {
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				make("UIPadding", {
					PaddingBottom = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
					PaddingTop = UDim.new(0, 6),
				}),
			})
			dragBlockingObjects[optionsFrame] = true

			local handle = {
				Instance = card,
				Options = table.clone(dropdownConfig.Options or {}),
				Multiple = dropdownConfig.MultipleOptions == true,
				Selected = {},
				OpenState = false,
			}

			local function selectedArray()
				local result = {}
				for _, option in ipairs(handle.Options) do
					if handle.Selected[tostring(option)] then
						table.insert(result, option)
					end
				end
				return result
			end

			local function updateSelectionText()
				local values = selectedArray()
				if #values == 0 then
					selectionLabel.Text = dropdownConfig.Placeholder or "Select"
				else
					local textValues = {}
					for _, value in ipairs(values) do
						table.insert(textValues, tostring(value))
					end
					selectionLabel.Text = table.concat(textValues, ", ")
				end
			end

			local rebuildOptions
			local function setOpen(open)
				handle.OpenState = open
				local visibleHeight = math.min(#handle.Options * 38 + 12, 202)
				local targetHeight = open and 70 + visibleHeight + 12 or 70
				optionsFrame.Size = UDim2.new(1, -24, 0, open and visibleHeight or 0)
				tween(card, { Size = UDim2.new(1, 0, 0, targetHeight) }, SMOOTH)
				tween(arrow, { Rotation = open and 180 or 0 }, SMOOTH)

				if open then
					if window.OpenPopup and window.OpenPopup ~= handle.Close then
						window.OpenPopup()
					end
					window.OpenPopup = handle.Close
				elseif window.OpenPopup == handle.Close then
					window.OpenPopup = nil
				end
			end

			function handle:Close()
				setOpen(false)
			end
			function handle:Open()
				setOpen(true)
			end
			function handle:Get()
				local values = selectedArray()
				return self.Multiple and values or values[1]
			end

			function handle:Set(value, silent)
				table.clear(self.Selected)
				local values = type(value) == "table" and value or { value }
				for _, chosen in ipairs(values) do
					for _, option in ipairs(self.Options) do
						if tostring(option) == tostring(chosen) then
							self.Selected[tostring(option)] = true
							if not self.Multiple then break end
						end
					end
					if not self.Multiple and next(self.Selected) then break end
				end
				updateSelectionText()
				rebuildOptions()
				if not silent then
					callback(dropdownConfig.Callback, self:Get())
				end
			end

			function handle:Refresh(options, keepSelection)
				local oldValue = self:Get()
				self.Options = table.clone(options or {})
				if keepSelection then
					self:Set(oldValue, true)
				else
					table.clear(self.Selected)
					updateSelectionText()
					rebuildOptions()
				end
				if self.OpenState then
					setOpen(true)
				end
			end

			rebuildOptions = function()
				for _, child in ipairs(optionsFrame:GetChildren()) do
					if child:IsA("TextButton") then
						child:Destroy()
					end
				end

				for order, option in ipairs(handle.Options) do
					local key = tostring(option)
					local selected = handle.Selected[key] == true
					local optionButton = make("TextButton", {
						Parent = optionsFrame,
						AutoButtonColor = false,
						BackgroundColor3 = selected and window.Accent or COLORS.Surface,
						BorderSizePixel = 0,
						Font = Enum.Font.Gotham,
						LayoutOrder = order,
						Size = UDim2.new(1, 0, 0, 34),
						Text = "  " .. key,
						TextColor3 = selected and COLORS.Text or COLORS.Muted,
						TextSize = 12,
						TextXAlignment = Enum.TextXAlignment.Left,
					}, { corner(7) })
					addHover(optionButton, selected and window.Accent or COLORS.Surface, selected and COLORS.AccentDark or COLORS.SurfaceHover)

					connect(optionButton.Activated, function()
						if handle.Multiple then
							handle.Selected[key] = not handle.Selected[key] or nil
						else
							table.clear(handle.Selected)
							handle.Selected[key] = true
						end
						updateSelectionText()
						rebuildOptions()
						callback(dropdownConfig.Callback, handle:Get())
						if not handle.Multiple then
							setOpen(false)
						end
					end)
				end

				optionsFrame.CanvasSize = UDim2.fromOffset(0, #handle.Options * 38 + 12)
			end

			connect(headerButton.Activated, function()
				setOpen(not handle.OpenState)
			end)

			local startingValue = dropdownConfig.CurrentOption
			if startingValue ~= nil then
				handle:Set(startingValue, true)
			else
				updateSelectionText()
				rebuildOptions()
			end

			return registerElement(handle, dropdownConfig)
		end

		function tab:CreateColorPicker(pickerConfig)
			pickerConfig = pickerConfig or {}
			local card = createCard(page, 70)
			local titleLabel = addCardText(card, pickerConfig.Name or "Color Picker", pickerConfig.Description)
			local hasDescription = pickerConfig.Description ~= nil and tostring(pickerConfig.Description) ~= ""
			titleLabel.Size = UDim2.new(1, -106, 0, hasDescription and 21 or 70)

			local swatch = make("TextButton", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0.5),
				AutoButtonColor = false,
				BackgroundColor3 = pickerConfig.CurrentColor or window.Accent,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -18, 0, 35),
				Size = UDim2.fromOffset(46, 30),
				Text = "",
				ZIndex = 4,
			}, { corner(8), stroke(Color3.new(1, 1, 1), 0.65, 1) })

			local panel = make("Frame", {
				Parent = card,
				BackgroundColor3 = COLORS.Background,
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(12, 70),
				Size = UDim2.new(1, -24, 0, 186),
			}, { corner(8) })

			local sv = make("Frame", {
				Parent = panel,
				Active = true,
				BackgroundColor3 = Color3.fromHSV(0, 1, 1),
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Position = UDim2.fromOffset(12, 12),
				Size = UDim2.new(1, -126, 0, 132),
			}, { corner(7) })
			dragBlockingObjects[sv] = true

			local whiteOverlay = make("Frame", {
				Parent = sv,
				BackgroundColor3 = Color3.new(1, 1, 1),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(1, 1),
			})
			make("UIGradient", {
				Parent = whiteOverlay,
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(1, 1),
				}),
			})

			local blackOverlay = make("Frame", {
				Parent = sv,
				BackgroundColor3 = Color3.new(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(1, 1),
			})
			make("UIGradient", {
				Parent = blackOverlay,
				Rotation = 90,
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(1, 0),
				}),
			})

			local svMarker = make("Frame", {
				Parent = sv,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BorderSizePixel = 0,
				Size = UDim2.fromOffset(11, 11),
				ZIndex = 5,
			}, { corner(6), stroke(Color3.new(0, 0, 0), 0.25, 2) })

			local hue = make("Frame", {
				Parent = panel,
				Active = true,
				BackgroundColor3 = Color3.new(1, 1, 1),
				BorderSizePixel = 0,
				Position = UDim2.new(1, -102, 0, 12),
				Size = UDim2.fromOffset(16, 132),
			}, { corner(6) })
			dragBlockingObjects[hue] = true
			make("UIGradient", {
				Parent = hue,
				Rotation = 90,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
					ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.17, 1, 1)),
					ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.33, 1, 1)),
					ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
					ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.67, 1, 1)),
					ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.83, 1, 1)),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1)),
				}),
			})

			local hueMarker = make("Frame", {
				Parent = hue,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0),
				Size = UDim2.new(1, 6, 0, 4),
				ZIndex = 5,
			}, { corner(2), stroke(Color3.new(0, 0, 0), 0.35, 1) })

			local preview = make("Frame", {
				Parent = panel,
				BackgroundColor3 = pickerConfig.CurrentColor or window.Accent,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -72, 0, 12),
				Size = UDim2.fromOffset(58, 58),
			}, { corner(9), stroke(Color3.new(1, 1, 1), 0.7, 1) })

			local hexLabel = label(panel, "#FFFFFF", 10, COLORS.Muted, Enum.Font.Code)
			hexLabel.Position = UDim2.new(1, -80, 0, 76)
			hexLabel.Size = UDim2.fromOffset(74, 22)
			hexLabel.TextXAlignment = Enum.TextXAlignment.Center

			local rgbLabel = label(panel, "255\n255\n255", 10, COLORS.Muted, Enum.Font.Code)
			rgbLabel.Position = UDim2.new(1, -80, 0, 100)
			rgbLabel.Size = UDim2.fromOffset(74, 48)
			rgbLabel.TextXAlignment = Enum.TextXAlignment.Center
			rgbLabel.TextYAlignment = Enum.TextYAlignment.Top

			local hint = label(panel, "Drag to choose a color", 10, COLORS.Muted, Enum.Font.Gotham)
			hint.Position = UDim2.fromOffset(12, 153)
			hint.Size = UDim2.new(1, -24, 0, 20)

			local startingColor = pickerConfig.CurrentColor or window.Accent
			local h, s, v = startingColor:ToHSV()
			local handle = {
				Instance = card,
				Value = startingColor,
				OpenState = false,
				FollowTheme = pickerConfig.FollowTheme == true,
			}

			local function render(fireCallback)
				local color = Color3.fromHSV(h, s, v)
				handle.Value = color
				sv.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
				svMarker.Position = UDim2.fromScale(s, 1 - v)
				hueMarker.Position = UDim2.fromScale(0.5, h)
				swatch.BackgroundColor3 = color
				preview.BackgroundColor3 = color

				local red = math.floor(color.R * 255 + 0.5)
				local green = math.floor(color.G * 255 + 0.5)
				local blue = math.floor(color.B * 255 + 0.5)
				hexLabel.Text = string.format("#%02X%02X%02X", red, green, blue)
				rgbLabel.Text = string.format("R %d\nG %d\nB %d", red, green, blue)

				if fireCallback then
					callback(pickerConfig.Callback, color)
				end
			end

			local function setOpen(open)
				handle.OpenState = open
				tween(card, { Size = UDim2.new(1, 0, 0, open and 268 or 70) }, SMOOTH)
				if open then
					if window.OpenPopup and window.OpenPopup ~= handle.Close then
						window.OpenPopup()
					end
					window.OpenPopup = handle.Close
				elseif window.OpenPopup == handle.Close then
					window.OpenPopup = nil
				end
			end

			function handle:Close()
				setOpen(false)
			end
			function handle:Open()
				setOpen(true)
			end
			function handle:Get()
				return self.Value
			end
			function handle:Set(color, silent)
				if typeof(color) ~= "Color3" then
					warn("[PrismUI] ColorPicker:Set expects a Color3 value.")
					return
				end
				h, s, v = color:ToHSV()
				render(not silent)
			end

			connect(swatch.Activated, function()
				setOpen(not handle.OpenState)
			end)

			local draggingSV = false
			local draggingHue = false

			local function updateSV(input)
				s = clamp((input.Position.X - sv.AbsolutePosition.X) / sv.AbsoluteSize.X, 0, 1)
				v = 1 - clamp((input.Position.Y - sv.AbsolutePosition.Y) / sv.AbsoluteSize.Y, 0, 1)
				render(true)
			end

			local function updateHue(input)
				h = clamp((input.Position.Y - hue.AbsolutePosition.Y) / hue.AbsoluteSize.Y, 0, 1)
				render(true)
			end

			connect(sv.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
					draggingSV = true
					updateSV(input)
				end
			end)

			connect(hue.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
					draggingHue = true
					updateHue(input)
				end
			end)

			connect(UserInputService.InputChanged, function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseMovement
					and input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end
				if draggingSV then updateSV(input) end
				if draggingHue then updateHue(input) end
			end)

			connect(UserInputService.InputEnded, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
					draggingSV = false
					draggingHue = false
				end
			end)

			render(false)
			return registerElement(handle, pickerConfig)
		end

		function tab:CreateStat(statConfig)
			statConfig = statConfig or {}
			local card = createCard(page, 70)
			addCardText(card, statConfig.Name or "Stat", statConfig.Description)

			local valueLabel = label(card, "", 14, statConfig.Color or window.Accent, Enum.Font.GothamBold)
			valueLabel.AnchorPoint = Vector2.new(1, 0.5)
			valueLabel.Position = UDim2.new(1, -16, 0.5, 0)
			valueLabel.Size = UDim2.fromOffset(128, 30)
			valueLabel.TextXAlignment = Enum.TextXAlignment.Right

			local handle = {
				Instance = card,
				Value = statConfig.Value or 0,
				Suffix = statConfig.Suffix or "",
			}

			function handle:Set(value)
				self.Value = value
				valueLabel.Text = tostring(value) .. tostring(self.Suffix)
			end
			function handle:Get()
				return self.Value
			end
			function handle:SetSuffix(suffix)
				self.Suffix = suffix or ""
				self:Set(self.Value)
			end

			handle:Set(handle.Value)
			return registerElement(handle, statConfig)
		end

		return tab
	end

	local searchStroke = searchFrame:FindFirstChildOfClass("UIStroke")
	connect(searchBox:GetPropertyChangedSignal("Text"), function()
		if window.ActiveTab then
			window.ActiveTab:ApplySearch(searchBox.Text)
		end
	end)
	connect(searchBox.Focused, function()
		if searchStroke then
			setThemeBinding(searchStroke, "Color", "Accent")
			tween(searchStroke, { Color = window.Accent, Transparency = 0.05 }, FAST)
		end
		setThemeBinding(searchFrame, "BackgroundColor3", "SurfaceRaised")
		tween(searchFrame, { BackgroundColor3 = COLORS.SurfaceRaised }, FAST)
	end)
	connect(searchBox.FocusLost, function()
		if searchStroke then
			setThemeBinding(searchStroke, "Color", "Border")
			tween(searchStroke, { Color = COLORS.Border, Transparency = 0.3 }, FAST)
		end
		setThemeBinding(searchFrame, "BackgroundColor3", "Surface")
		tween(searchFrame, { BackgroundColor3 = COLORS.Surface }, FAST)
	end)
	connect(clearSearch.Activated, function()
		searchBox.Text = ""
		searchBox:ReleaseFocus()
	end)

	updateResponsiveLayout()
	syncShadow()
	return window
end

return PrismUI
