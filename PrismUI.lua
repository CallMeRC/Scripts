--!nocheck
-- PrismUI - single-file Roblox UI library + example
-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.
-- Theme presets are listed in PrismUI.ThemeNames and can be changed live.

-- Roblox services ----------------------------------------------------------
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local PrismUI = {}
PrismUI.__index = PrismUI

-- Theme catalog ------------------------------------------------------------
-- Every palette uses the same semantic tokens, so text contrast and hover
-- states remain readable when themes change at runtime.
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
	Obsidian = {
		Background = Color3.fromRGB(7, 8, 11),
		Surface = Color3.fromRGB(14, 16, 21),
		SurfaceHover = Color3.fromRGB(22, 25, 31),
		SurfaceRaised = Color3.fromRGB(27, 30, 38),
		Border = Color3.fromRGB(45, 50, 61),
		Text = Color3.fromRGB(244, 247, 250),
		Muted = Color3.fromRGB(145, 153, 166),
		Accent = Color3.fromRGB(76, 215, 205),
		AccentDark = Color3.fromRGB(42, 151, 149),
		Success = Color3.fromRGB(68, 207, 140),
		Danger = Color3.fromRGB(240, 88, 111),
	},
	Oceanic = {
		Background = Color3.fromRGB(6, 17, 27),
		Surface = Color3.fromRGB(10, 29, 43),
		SurfaceHover = Color3.fromRGB(15, 42, 59),
		SurfaceRaised = Color3.fromRGB(19, 50, 69),
		Border = Color3.fromRGB(35, 76, 96),
		Text = Color3.fromRGB(236, 249, 252),
		Muted = Color3.fromRGB(133, 174, 187),
		Accent = Color3.fromRGB(47, 197, 214),
		AccentDark = Color3.fromRGB(25, 133, 157),
		Success = Color3.fromRGB(54, 211, 147),
		Danger = Color3.fromRGB(244, 94, 115),
	},
	Crimson = {
		Background = Color3.fromRGB(18, 8, 11),
		Surface = Color3.fromRGB(31, 14, 18),
		SurfaceHover = Color3.fromRGB(45, 20, 25),
		SurfaceRaised = Color3.fromRGB(54, 24, 30),
		Border = Color3.fromRGB(86, 42, 50),
		Text = Color3.fromRGB(255, 244, 246),
		Muted = Color3.fromRGB(199, 153, 161),
		Accent = Color3.fromRGB(239, 70, 93),
		AccentDark = Color3.fromRGB(180, 39, 61),
		Success = Color3.fromRGB(70, 202, 137),
		Danger = Color3.fromRGB(255, 119, 74),
	},
	Sakura = {
		Background = Color3.fromRGB(25, 15, 22),
		Surface = Color3.fromRGB(39, 23, 34),
		SurfaceHover = Color3.fromRGB(53, 31, 46),
		SurfaceRaised = Color3.fromRGB(63, 37, 55),
		Border = Color3.fromRGB(96, 57, 81),
		Text = Color3.fromRGB(255, 246, 251),
		Muted = Color3.fromRGB(207, 166, 190),
		Accent = Color3.fromRGB(255, 135, 187),
		AccentDark = Color3.fromRGB(201, 82, 139),
		Success = Color3.fromRGB(80, 207, 151),
		Danger = Color3.fromRGB(247, 91, 109),
	},
	Solar = {
		Background = Color3.fromRGB(17, 18, 16),
		Surface = Color3.fromRGB(28, 29, 24),
		SurfaceHover = Color3.fromRGB(40, 41, 32),
		SurfaceRaised = Color3.fromRGB(48, 48, 37),
		Border = Color3.fromRGB(76, 73, 51),
		Text = Color3.fromRGB(252, 249, 232),
		Muted = Color3.fromRGB(186, 179, 141),
		Accent = Color3.fromRGB(239, 193, 64),
		AccentDark = Color3.fromRGB(177, 133, 29),
		Success = Color3.fromRGB(77, 202, 127),
		Danger = Color3.fromRGB(238, 88, 91),
	},
	Cyberpunk = {
		Background = Color3.fromRGB(8, 7, 15),
		Surface = Color3.fromRGB(17, 14, 29),
		SurfaceHover = Color3.fromRGB(29, 23, 45),
		SurfaceRaised = Color3.fromRGB(36, 28, 55),
		Border = Color3.fromRGB(67, 52, 91),
		Text = Color3.fromRGB(251, 250, 255),
		Muted = Color3.fromRGB(164, 151, 191),
		Accent = Color3.fromRGB(245, 229, 67),
		AccentDark = Color3.fromRGB(191, 169, 27),
		Success = Color3.fromRGB(48, 229, 176),
		Danger = Color3.fromRGB(255, 64, 151),
	},
	Nord = {
		Background = Color3.fromRGB(35, 41, 54),
		Surface = Color3.fromRGB(46, 52, 68),
		SurfaceHover = Color3.fromRGB(59, 66, 84),
		SurfaceRaised = Color3.fromRGB(67, 75, 94),
		Border = Color3.fromRGB(83, 94, 116),
		Text = Color3.fromRGB(236, 239, 244),
		Muted = Color3.fromRGB(176, 186, 204),
		Accent = Color3.fromRGB(136, 192, 208),
		AccentDark = Color3.fromRGB(91, 146, 165),
		Success = Color3.fromRGB(163, 190, 140),
		Danger = Color3.fromRGB(191, 97, 106),
	},
	Dracula = {
		Background = Color3.fromRGB(30, 31, 45),
		Surface = Color3.fromRGB(40, 42, 59),
		SurfaceHover = Color3.fromRGB(51, 53, 72),
		SurfaceRaised = Color3.fromRGB(59, 61, 82),
		Border = Color3.fromRGB(79, 82, 105),
		Text = Color3.fromRGB(248, 248, 242),
		Muted = Color3.fromRGB(181, 179, 196),
		Accent = Color3.fromRGB(189, 147, 249),
		AccentDark = Color3.fromRGB(126, 91, 185),
		Success = Color3.fromRGB(80, 250, 123),
		Danger = Color3.fromRGB(255, 85, 85),
	},
	Monokai = {
		Background = Color3.fromRGB(25, 25, 23),
		Surface = Color3.fromRGB(38, 38, 34),
		SurfaceHover = Color3.fromRGB(51, 51, 45),
		SurfaceRaised = Color3.fromRGB(59, 59, 52),
		Border = Color3.fromRGB(83, 83, 73),
		Text = Color3.fromRGB(248, 248, 242),
		Muted = Color3.fromRGB(183, 182, 163),
		Accent = Color3.fromRGB(166, 226, 46),
		AccentDark = Color3.fromRGB(111, 161, 25),
		Success = Color3.fromRGB(102, 217, 157),
		Danger = Color3.fromRGB(249, 38, 114),
	},
	Forest = {
		Background = Color3.fromRGB(9, 16, 12),
		Surface = Color3.fromRGB(16, 28, 21),
		SurfaceHover = Color3.fromRGB(23, 40, 30),
		SurfaceRaised = Color3.fromRGB(28, 48, 36),
		Border = Color3.fromRGB(48, 77, 59),
		Text = Color3.fromRGB(240, 250, 243),
		Muted = Color3.fromRGB(148, 178, 157),
		Accent = Color3.fromRGB(108, 196, 112),
		AccentDark = Color3.fromRGB(66, 139, 72),
		Success = Color3.fromRGB(77, 219, 142),
		Danger = Color3.fromRGB(239, 96, 100),
	},
	Coffee = {
		Background = Color3.fromRGB(22, 16, 13),
		Surface = Color3.fromRGB(35, 26, 21),
		SurfaceHover = Color3.fromRGB(48, 36, 29),
		SurfaceRaised = Color3.fromRGB(57, 43, 34),
		Border = Color3.fromRGB(89, 68, 54),
		Text = Color3.fromRGB(253, 246, 238),
		Muted = Color3.fromRGB(197, 171, 149),
		Accent = Color3.fromRGB(209, 151, 100),
		AccentDark = Color3.fromRGB(151, 99, 61),
		Success = Color3.fromRGB(92, 199, 133),
		Danger = Color3.fromRGB(235, 91, 92),
	},
	Slate = {
		Background = Color3.fromRGB(17, 21, 27),
		Surface = Color3.fromRGB(26, 32, 40),
		SurfaceHover = Color3.fromRGB(36, 43, 53),
		SurfaceRaised = Color3.fromRGB(43, 51, 62),
		Border = Color3.fromRGB(66, 76, 91),
		Text = Color3.fromRGB(244, 247, 251),
		Muted = Color3.fromRGB(155, 166, 181),
		Accent = Color3.fromRGB(96, 165, 250),
		AccentDark = Color3.fromRGB(57, 111, 190),
		Success = Color3.fromRGB(65, 204, 140),
		Danger = Color3.fromRGB(240, 88, 111),
	},
	Lavender = {
		Background = Color3.fromRGB(239, 237, 248),
		Surface = Color3.fromRGB(250, 249, 254),
		SurfaceHover = Color3.fromRGB(236, 232, 246),
		SurfaceRaised = Color3.fromRGB(226, 220, 240),
		Border = Color3.fromRGB(194, 184, 218),
		Text = Color3.fromRGB(43, 34, 60),
		Muted = Color3.fromRGB(105, 92, 129),
		Accent = Color3.fromRGB(133, 92, 202),
		AccentDark = Color3.fromRGB(92, 57, 153),
		Success = Color3.fromRGB(35, 159, 103),
		Danger = Color3.fromRGB(207, 59, 91),
	},
	Sunset = {
		Background = Color3.fromRGB(24, 12, 20),
		Surface = Color3.fromRGB(38, 20, 31),
		SurfaceHover = Color3.fromRGB(52, 27, 41),
		SurfaceRaised = Color3.fromRGB(62, 32, 48),
		Border = Color3.fromRGB(96, 50, 72),
		Text = Color3.fromRGB(255, 246, 248),
		Muted = Color3.fromRGB(206, 159, 176),
		Accent = Color3.fromRGB(255, 127, 80),
		AccentDark = Color3.fromRGB(201, 77, 47),
		Success = Color3.fromRGB(71, 207, 139),
		Danger = Color3.fromRGB(244, 72, 127),
	},
	Arctic = {
		Background = Color3.fromRGB(233, 244, 248),
		Surface = Color3.fromRGB(247, 252, 253),
		SurfaceHover = Color3.fromRGB(228, 241, 246),
		SurfaceRaised = Color3.fromRGB(215, 234, 241),
		Border = Color3.fromRGB(179, 208, 219),
		Text = Color3.fromRGB(24, 49, 61),
		Muted = Color3.fromRGB(83, 119, 134),
		Accent = Color3.fromRGB(39, 155, 192),
		AccentDark = Color3.fromRGB(24, 107, 138),
		Success = Color3.fromRGB(25, 158, 108),
		Danger = Color3.fromRGB(204, 60, 83),
	},
	Mint = {
		Background = Color3.fromRGB(233, 247, 241),
		Surface = Color3.fromRGB(248, 253, 251),
		SurfaceHover = Color3.fromRGB(227, 242, 235),
		SurfaceRaised = Color3.fromRGB(215, 234, 225),
		Border = Color3.fromRGB(177, 209, 192),
		Text = Color3.fromRGB(25, 52, 39),
		Muted = Color3.fromRGB(83, 123, 103),
		Accent = Color3.fromRGB(45, 164, 112),
		AccentDark = Color3.fromRGB(27, 113, 75),
		Success = Color3.fromRGB(31, 160, 93),
		Danger = Color3.fromRGB(205, 63, 82),
	},
	Coral = {
		Background = Color3.fromRGB(22, 13, 15),
		Surface = Color3.fromRGB(36, 22, 25),
		SurfaceHover = Color3.fromRGB(49, 30, 34),
		SurfaceRaised = Color3.fromRGB(58, 36, 40),
		Border = Color3.fromRGB(91, 56, 62),
		Text = Color3.fromRGB(255, 247, 245),
		Muted = Color3.fromRGB(202, 163, 160),
		Accent = Color3.fromRGB(255, 120, 104),
		AccentDark = Color3.fromRGB(198, 70, 63),
		Success = Color3.fromRGB(68, 202, 137),
		Danger = Color3.fromRGB(244, 72, 98),
	},
	Neon = {
		Background = Color3.fromRGB(7, 10, 9),
		Surface = Color3.fromRGB(13, 20, 17),
		SurfaceHover = Color3.fromRGB(20, 31, 26),
		SurfaceRaised = Color3.fromRGB(25, 38, 31),
		Border = Color3.fromRGB(42, 66, 52),
		Text = Color3.fromRGB(244, 255, 248),
		Muted = Color3.fromRGB(139, 174, 151),
		Accent = Color3.fromRGB(99, 255, 130),
		AccentDark = Color3.fromRGB(50, 182, 81),
		Success = Color3.fromRGB(65, 233, 139),
		Danger = Color3.fromRGB(255, 77, 124),
	},
	Royal = {
		Background = Color3.fromRGB(24, 7, 9),
		Surface = Color3.fromRGB(40, 12, 15),
		SurfaceHover = Color3.fromRGB(55, 18, 21),
		SurfaceRaised = Color3.fromRGB(65, 23, 26),
		Border = Color3.fromRGB(103, 46, 43),
		Text = Color3.fromRGB(255, 248, 228),
		Muted = Color3.fromRGB(206, 169, 141),
		Accent = Color3.fromRGB(232, 184, 74),
		AccentDark = Color3.fromRGB(169, 118, 35),
		Success = Color3.fromRGB(73, 196, 125),
		Danger = Color3.fromRGB(239, 68, 76),
	},
	Sandstone = {
		Background = Color3.fromRGB(244, 239, 229),
		Surface = Color3.fromRGB(253, 250, 244),
		SurfaceHover = Color3.fromRGB(237, 229, 215),
		SurfaceRaised = Color3.fromRGB(226, 215, 196),
		Border = Color3.fromRGB(199, 182, 154),
		Text = Color3.fromRGB(54, 43, 29),
		Muted = Color3.fromRGB(124, 104, 80),
		Accent = Color3.fromRGB(181, 116, 58),
		AccentDark = Color3.fromRGB(129, 77, 35),
		Success = Color3.fromRGB(50, 151, 91),
		Danger = Color3.fromRGB(196, 64, 69),
	},
	VioletStorm = {
		Background = Color3.fromRGB(13, 11, 25),
		Surface = Color3.fromRGB(23, 19, 41),
		SurfaceHover = Color3.fromRGB(34, 28, 57),
		SurfaceRaised = Color3.fromRGB(41, 34, 68),
		Border = Color3.fromRGB(66, 56, 99),
		Text = Color3.fromRGB(248, 246, 255),
		Muted = Color3.fromRGB(169, 159, 198),
		Accent = Color3.fromRGB(145, 106, 255),
		AccentDark = Color3.fromRGB(94, 65, 195),
		Success = Color3.fromRGB(71, 207, 145),
		Danger = Color3.fromRGB(244, 89, 123),
	},
	DeepSea = {
		Background = Color3.fromRGB(5, 14, 19),
		Surface = Color3.fromRGB(9, 25, 32),
		SurfaceHover = Color3.fromRGB(14, 37, 47),
		SurfaceRaised = Color3.fromRGB(18, 44, 56),
		Border = Color3.fromRGB(31, 69, 83),
		Text = Color3.fromRGB(237, 251, 252),
		Muted = Color3.fromRGB(130, 173, 181),
		Accent = Color3.fromRGB(36, 190, 169),
		AccentDark = Color3.fromRGB(21, 129, 119),
		Success = Color3.fromRGB(55, 211, 143),
		Danger = Color3.fromRGB(240, 89, 111),
	},
	RubyNight = {
		Background = Color3.fromRGB(19, 8, 16),
		Surface = Color3.fromRGB(33, 14, 26),
		SurfaceHover = Color3.fromRGB(47, 20, 37),
		SurfaceRaised = Color3.fromRGB(56, 24, 44),
		Border = Color3.fromRGB(87, 40, 67),
		Text = Color3.fromRGB(255, 244, 250),
		Muted = Color3.fromRGB(198, 151, 179),
		Accent = Color3.fromRGB(232, 75, 139),
		AccentDark = Color3.fromRGB(174, 40, 96),
		Success = Color3.fromRGB(70, 205, 140),
		Danger = Color3.fromRGB(255, 101, 78),
	},
	Galactic = {
		Background = Color3.fromRGB(7, 9, 27),
		Surface = Color3.fromRGB(13, 18, 45),
		SurfaceHover = Color3.fromRGB(24, 27, 63),
		SurfaceRaised = Color3.fromRGB(31, 33, 76),
		Border = Color3.fromRGB(56, 57, 111),
		Text = Color3.fromRGB(244, 245, 255),
		Muted = Color3.fromRGB(153, 157, 204),
		Accent = Color3.fromRGB(122, 104, 255),
		AccentDark = Color3.fromRGB(68, 73, 202),
		Success = Color3.fromRGB(66, 211, 157),
		Danger = Color3.fromRGB(244, 87, 137),
	},
	Inferno = {
		Background = Color3.fromRGB(22, 8, 5),
		Surface = Color3.fromRGB(38, 14, 9),
		SurfaceHover = Color3.fromRGB(53, 21, 12),
		SurfaceRaised = Color3.fromRGB(64, 27, 15),
		Border = Color3.fromRGB(101, 48, 26),
		Text = Color3.fromRGB(255, 246, 235),
		Muted = Color3.fromRGB(205, 159, 128),
		Accent = Color3.fromRGB(255, 104, 46),
		AccentDark = Color3.fromRGB(194, 55, 21),
		Success = Color3.fromRGB(75, 201, 126),
		Danger = Color3.fromRGB(255, 56, 62),
	},
	Tundra = {
		Background = Color3.fromRGB(232, 241, 245),
		Surface = Color3.fromRGB(248, 252, 253),
		SurfaceHover = Color3.fromRGB(224, 236, 241),
		SurfaceRaised = Color3.fromRGB(211, 227, 234),
		Border = Color3.fromRGB(173, 199, 210),
		Text = Color3.fromRGB(28, 48, 58),
		Muted = Color3.fromRGB(88, 116, 129),
		Accent = Color3.fromRGB(71, 154, 190),
		AccentDark = Color3.fromRGB(43, 105, 135),
		Success = Color3.fromRGB(34, 155, 102),
		Danger = Color3.fromRGB(200, 65, 81),
	},
	Matrix = {
		Background = Color3.fromRGB(3, 10, 5),
		Surface = Color3.fromRGB(7, 20, 10),
		SurfaceHover = Color3.fromRGB(11, 32, 16),
		SurfaceRaised = Color3.fromRGB(14, 39, 20),
		Border = Color3.fromRGB(28, 67, 37),
		Text = Color3.fromRGB(231, 255, 237),
		Muted = Color3.fromRGB(124, 174, 136),
		Accent = Color3.fromRGB(69, 232, 101),
		AccentDark = Color3.fromRGB(35, 159, 61),
		Success = Color3.fromRGB(91, 255, 128),
		Danger = Color3.fromRGB(246, 74, 96),
	},
	Candy = {
		Background = Color3.fromRGB(247, 235, 245),
		Surface = Color3.fromRGB(255, 250, 254),
		SurfaceHover = Color3.fromRGB(241, 226, 240),
		SurfaceRaised = Color3.fromRGB(232, 214, 232),
		Border = Color3.fromRGB(209, 178, 205),
		Text = Color3.fromRGB(61, 35, 57),
		Muted = Color3.fromRGB(127, 89, 121),
		Accent = Color3.fromRGB(225, 91, 177),
		AccentDark = Color3.fromRGB(167, 54, 126),
		Success = Color3.fromRGB(39, 166, 116),
		Danger = Color3.fromRGB(211, 62, 90),
	},
	Navy = {
		Background = Color3.fromRGB(5, 11, 24),
		Surface = Color3.fromRGB(10, 21, 40),
		SurfaceHover = Color3.fromRGB(16, 31, 55),
		SurfaceRaised = Color3.fromRGB(20, 38, 66),
		Border = Color3.fromRGB(38, 63, 96),
		Text = Color3.fromRGB(238, 246, 255),
		Muted = Color3.fromRGB(132, 158, 190),
		Accent = Color3.fromRGB(48, 142, 231),
		AccentDark = Color3.fromRGB(28, 93, 170),
		Success = Color3.fromRGB(54, 205, 143),
		Danger = Color3.fromRGB(239, 87, 108),
	},
	Champagne = {
		Background = Color3.fromRGB(241, 235, 221),
		Surface = Color3.fromRGB(253, 249, 239),
		SurfaceHover = Color3.fromRGB(235, 226, 207),
		SurfaceRaised = Color3.fromRGB(224, 211, 187),
		Border = Color3.fromRGB(197, 177, 139),
		Text = Color3.fromRGB(57, 45, 28),
		Muted = Color3.fromRGB(126, 105, 74),
		Accent = Color3.fromRGB(184, 133, 57),
		AccentDark = Color3.fromRGB(130, 88, 33),
		Success = Color3.fromRGB(47, 149, 92),
		Danger = Color3.fromRGB(192, 63, 70),
	},
}

local COLORS = table.clone(THEME_PRESETS.Amethyst)
PrismUI.Themes = THEME_PRESETS

-- Built-in themes (40 total). Use any of these strings in CreateWindow:
-- Graphite, DarkBlue, Cobalt, Amethyst, Emerald, Ember, Rose, Aurora,
-- Frost, MidnightGold, Obsidian, Oceanic, Crimson, Sakura, Solar,
-- Cyberpunk, Nord, Dracula, Monokai, Forest, Coffee, Slate, Lavender,
-- Sunset, Arctic, Mint, Coral, Neon, Royal, Sandstone, VioletStorm,
-- DeepSea, RubyNight, Galactic, Inferno, Tundra, Matrix, Candy, Navy,
-- Champagne.
PrismUI.ThemeNames = {
	"Graphite", "DarkBlue", "Cobalt", "Amethyst", "Emerald",
	"Ember", "Rose", "Aurora", "Frost", "MidnightGold",
	"Obsidian", "Oceanic", "Crimson", "Sakura", "Solar",
	"Cyberpunk", "Nord", "Dracula", "Monokai", "Forest",
	"Coffee", "Slate", "Lavender", "Sunset", "Arctic",
	"Mint", "Coral", "Neon", "Royal", "Sandstone",
	"VioletStorm", "DeepSea", "RubyNight",
	"Galactic", "Inferno", "Tundra", "Matrix", "Candy", "Navy", "Champagne",
}

-- Embedded from latte-soft/lucide-roblox 0.1.3 (Lucide 0.363.0).
-- lucide-roblox is MIT licensed; Lucide Icons is ISC licensed.
-- Source: https://github.com/latte-soft/lucide-roblox
-- The sprite lookup stays minified so full Lucide support does not make the
-- readable part of this single-file build unnecessarily longer.
local EMBEDDED_LUCIDE_DATA = {["48px"]={rewind={16898613699,{48,48},{563,967}},fuel={16898613353,{48,48},{196,967}},["square-arrow-out-up-right"]={16898613777,{48,48},{967,514}},["table-cells-split"]={16898613777,{48,48},{771,955}},gavel={16898613353,{48,48},{967,808}},["dna-off"]={16898613044,{48,48},{453,967}},["refresh-ccw-dot"]={16898613699,{48,48},{869,404}},bean={16898612629,{48,48},{967,906}},["arrow-up-right-from-circle"]={16898612629,{48,48},{563,967}},["table-columns-split"]={16898613777,{48,48},{967,808}},bolt={16898612819,{48,48},{306,820}},["square-asterisk"]={16898613777,{48,48},{710,771}},feather={16898613353,{48,48},{771,98}},["align-horizontal-distribute-center"]={16898612629,{48,48},{771,355}},["align-center"]={16898612629,{48,48},{0,869}},["grip-vertical"]={16898613509,{48,48},{0,869}},["person-standing"]={16898613699,{48,48},{563,771}},["badge-swiss-franc"]={16898612629,{48,48},{771,857}},["between-horizontal-end"]={16898612819,{48,48},{771,306}},["rotate-cw"]={16898613699,{48,48},{869,453}},framer={16898613353,{48,48},{661,967}},["bus-front"]={16898612819,{48,48},{869,612}},["shield-ellipsis"]={16898613777,{48,48},{771,306}},["file-lock-2"]={16898613353,{48,48},{257,918}},["between-vertical-end"]={16898612819,{48,48},{257,820}},["globe-lock"]={16898613509,{48,48},{820,514}},["toggle-left"]={16898613869,{48,48},{869,49}},["concierge-bell"]={16898613044,{48,48},{869,147}},video={16898613869,{48,48},{355,967}},["arrow-left-square"]={16898612629,{48,48},{196,820}},["file-down"]={16898613353,{48,48},{98,820}},["picture-in-picture"]={16898613699,{48,48},{257,869}},["messages-square"]={16898613613,{48,48},{306,869}},grab={16898613509,{48,48},{514,820}},["phone-call"]={16898613699,{48,48},{514,820}},["chevron-up-circle"]={16898612819,{48,48},{820,808}},["server-crash"]={16898613699,{48,48},{918,955}},["heading-3"]={16898613509,{48,48},{869,306}},squircle={16898613777,{48,48},{820,759}},["wifi-off"]={16898613869,{48,48},{918,759}},["sun-medium"]={16898613777,{48,48},{661,967}},ungroup={16898613869,{48,48},{257,967}},["cloud-download"]={16898613044,{48,48},{612,820}},["sigma-square"]={16898613777,{48,48},{869,514}},["folder-plus"]={16898613353,{48,48},{661,918}},["hard-drive-download"]={16898613509,{48,48},{918,0}},["scatter-chart"]={16898613699,{48,48},{196,967}},pointer={16898613699,{48,48},{661,771}},ligature={16898613509,{48,48},{612,967}},["chevrons-up-down"]={16898612819,{48,48},{918,759}},["iteration-cw"]={16898613509,{48,48},{869,147}},["rail-symbol"]={16898613699,{48,48},{967,514}},["square-stack"]={16898613777,{48,48},{453,869}},parentheses={16898613613,{48,48},{869,906}},["book-up-2"]={16898612819,{48,48},{306,869}},flame={16898613353,{48,48},{967,306}},["chevrons-up"]={16898612819,{48,48},{869,808}},["chevron-right-square"]={16898612819,{48,48},{918,710}},["square-mouse-pointer"]={16898613777,{48,48},{869,661}},superscript={16898613777,{48,48},{918,759}},signal={16898613777,{48,48},{918,0}},["file-warning"]={16898613353,{48,48},{967,514}},hexagon={16898613509,{48,48},{967,0}},["navigation-2-off"]={16898613613,{48,48},{918,612}},unlock={16898613869,{48,48},{771,710}},["arrows-up-from-line"]={16898612629,{48,48},{918,404}},["square-gantt-chart"]={16898613777,{48,48},{453,820}},["square-chevron-left"]={16898613777,{48,48},{967,49}},scaling={16898613699,{48,48},{967,661}},["inspection-panel"]={16898613509,{48,48},{563,918}},["arrow-left-from-line"]={16898612629,{48,48},{869,147}},ship={16898613777,{48,48},{771,98}},["ticket-percent"]={16898613869,{48,48},{257,869}},["arrow-right-square"]={16898612629,{48,48},{869,404}},["calendar-clock"]={16898612819,{48,48},{918,98}},x={16898613869,{48,48},{869,906}},voicemail={16898613869,{48,48},{869,710}},presentation={16898613699,{48,48},{771,196}},["tree-palm"]={16898613869,{48,48},{820,612}},popsicle={16898613699,{48,48},{563,869}},["captions-off"]={16898612819,{48,48},{661,869}},["align-vertical-justify-center"]={16898612629,{48,48},{49,869}},theater={16898613869,{48,48},{98,771}},tent={16898613869,{48,48},{49,771}},["repeat-1"]={16898613699,{48,48},{918,612}},stethoscope={16898613777,{48,48},{147,967}},["screen-share-off"]={16898613699,{48,48},{771,906}},["arrow-big-up"]={16898612629,{48,48},{918,306}},["volume-x"]={16898613869,{48,48},{710,869}},["mouse-pointer-click"]={16898613613,{48,48},{771,710}},["square-m"]={16898613777,{48,48},{306,967}},["hard-drive"]={16898613509,{48,48},{820,98}},["package-minus"]={16898613613,{48,48},{771,808}},cloud={16898613044,{48,48},{918,306}},["mouse-pointer-square-dashed"]={16898613613,{48,48},{710,771}},["flip-horizontal"]={16898613353,{48,48},{306,967}},["alert-circle"]={16898612629,{48,48},{869,0}},unplug={16898613869,{48,48},{710,771}},["badge-cent"]={16898612629,{48,48},{612,967}},["check-square-2"]={16898612819,{48,48},{820,759}},["monitor-check"]={16898613613,{48,48},{196,771}},trello={16898613869,{48,48},{612,820}},["paintbrush-2"]={16898613613,{48,48},{967,404}},["bar-chart-horizontal"]={16898612629,{48,48},{710,967}},["book-plus"]={16898612819,{48,48},{771,404}},torus={16898613869,{48,48},{147,771}},["panel-right-close"]={16898613613,{48,48},{453,967}},["heart-handshake"]={16898613509,{48,48},{869,563}},trees={16898613869,{48,48},{661,771}},ham={16898613509,{48,48},{355,771}},text={16898613869,{48,48},{771,98}},["nut-off"]={16898613613,{48,48},{98,967}},["bean-off"]={16898612629,{48,48},{869,955}},rat={16898613699,{48,48},{869,612}},["separator-horizontal"]={16898613699,{48,48},{918,906}},["square-arrow-up-right"]={16898613777,{48,48},{820,661}},["signal-zero"]={16898613777,{48,48},{514,869}},citrus={16898613044,{48,48},{306,820}},["phone-missed"]={16898613699,{48,48},{771,98}},["user-round-check"]={16898613869,{48,48},{869,404}},["battery-medium"]={16898612629,{48,48},{869,906}},["square-minus"]={16898613777,{48,48},{918,612}},hotel={16898613509,{48,48},{98,869}},["folder-output"]={16898613353,{48,48},{771,808}},["ice-cream"]={16898613509,{48,48},{869,355}},menu={16898613613,{48,48},{49,820}},["arrow-up-left-square"]={16898612629,{48,48},{710,820}},lightbulb={16898613509,{48,48},{918,196}},["badge-help"]={16898612629,{48,48},{147,967}},angry={16898612629,{48,48},{257,918}},outdent={16898613613,{48,48},{918,661}},["circle-dot-dashed"]={16898613044,{48,48},{771,514}},speech={16898613777,{48,48},{820,147}},["cake-slice"]={16898612819,{48,48},{661,820}},["git-graph"]={16898613509,{48,48},{0,771}},armchair={16898612629,{48,48},{820,147}},["qr-code"]={16898613699,{48,48},{967,257}},copy={16898613044,{48,48},{918,612}},goal={16898613509,{48,48},{563,771}},["trending-down"]={16898613869,{48,48},{563,869}},haze={16898613509,{48,48},{98,820}},nfc={16898613613,{48,48},{612,918}},["receipt-russian-ruble"]={16898613699,{48,48},{514,967}},disc={16898613044,{48,48},{661,967}},["notebook-tabs"]={16898613613,{48,48},{967,98}},["panels-left-bottom"]={16898613613,{48,48},{820,906}},videotape={16898613869,{48,48},{967,612}},["sun-moon"]={16898613777,{48,48},{967,196}},calendar={16898612819,{48,48},{355,918}},["minus-circle"]={16898613613,{48,48},{869,98}},sunset={16898613777,{48,48},{967,710}},["navigation-2"]={16898613613,{48,48},{869,661}},["message-square-heart"]={16898613613,{48,48},{771,147}},["rectangle-ellipsis"]={16898613699,{48,48},{820,196}},["badge-plus"]={16898612629,{48,48},{918,710}},["indian-rupee"]={16898613509,{48,48},{710,771}},["monitor-dot"]={16898613613,{48,48},{147,820}},delete={16898613044,{48,48},{661,918}},["clipboard-pen-line"]={16898613044,{48,48},{918,0}},["folder-search"]={16898613353,{48,48},{918,196}},["utensils-crossed"]={16898613869,{48,48},{918,147}},dices={16898613044,{48,48},{918,710}},reply={16898613699,{48,48},{612,918}},["flask-round"]={16898613353,{48,48},{404,869}},pause={16898613699,{48,48},{0,771}},shrub={16898613777,{48,48},{306,820}},flag={16898613353,{48,48},{98,918}},underline={16898613869,{48,48},{820,404}},["align-horizontal-distribute-end"]={16898612629,{48,48},{355,771}},newspaper={16898613613,{48,48},{661,869}},table={16898613777,{48,48},{820,955}},["move-vertical"]={16898613613,{48,48},{820,453}},["file-pen-line"]={16898613353,{48,48},{612,820}},["badge-russian-ruble"]={16898612629,{48,48},{820,808}},radius={16898613699,{48,48},{257,967}},["loader-2"]={16898613509,{48,48},{820,857}},pilcrow={16898613699,{48,48},{612,771}},["scan-face"]={16898613699,{48,48},{820,808}},spade={16898613777,{48,48},{514,918}},["book-user"]={16898612819,{48,48},{918,514}},["flip-vertical"]={16898613353,{48,48},{918,612}},["square-arrow-down"]={16898613777,{48,48},{453,771}},["circle-plus"]={16898613044,{48,48},{869,0}},view={16898613869,{48,48},{918,661}},cctv={16898612819,{48,48},{355,967}},["more-horizontal"]={16898613613,{48,48},{257,967}},["file-key-2"]={16898613353,{48,48},{404,771}},["pause-octagon"]={16898613699,{48,48},{771,0}},["circle-arrow-out-down-left"]={16898612819,{48,48},{771,955}},volume={16898613869,{48,48},{661,918}},facebook={16898613353,{48,48},{563,771}},["octagon-alert"]={16898613613,{48,48},{918,404}},["panel-bottom-dashed"]={16898613613,{48,48},{918,710}},["book-a"]={16898612819,{48,48},{820,563}},["align-end-vertical"]={16898612629,{48,48},{820,306}},["user-x-2"]={16898613869,{48,48},{771,759}},chrome={16898612819,{48,48},{820,857}},["receipt-japanese-yen"]={16898613699,{48,48},{612,869}},rabbit={16898613699,{48,48},{869,355}},["scissors-square"]={16898613699,{48,48},{869,808}},["check-square"]={16898612819,{48,48},{771,808}},["train-front-tunnel"]={16898613869,{48,48},{771,404}},["panel-left-dashed"]={16898613613,{48,48},{661,967}},fish={16898613353,{48,48},{869,147}},slack={16898613777,{48,48},{0,918}},sliders={16898613777,{48,48},{404,771}},["message-circle-warning"]={16898613613,{48,48},{771,612}},map={16898613613,{48,48},{306,771}},route={16898613699,{48,48},{404,918}},["arrow-up-left"]={16898612629,{48,48},{661,869}},award={16898612629,{48,48},{918,661}},["message-square-plus"]={16898613613,{48,48},{49,869}},["unfold-horizontal"]={16898613869,{48,48},{355,869}},["area-chart"]={16898612629,{48,48},{869,98}},["music-4"]={16898613613,{48,48},{306,967}},["shield-x"]={16898613777,{48,48},{514,820}},["plane-landing"]={16898613699,{48,48},{771,147}},["disc-3"]={16898613044,{48,48},{771,857}},["columns-4"]={16898613044,{48,48},{710,771}},["archive-x"]={16898612629,{48,48},{967,0}},["square-dashed-kanban"]={16898613777,{48,48},{98,918}},["users-2"]={16898613869,{48,48},{612,918}},["shield-off"]={16898613777,{48,48},{820,514}},compass={16898613044,{48,48},{514,967}},vegan={16898613869,{48,48},{967,355}},["message-circle-plus"]={16898613613,{48,48},{257,869}},["stop-circle"]={16898613777,{48,48},{453,918}},nut={16898613613,{48,48},{967,355}},search={16898613699,{48,48},{918,857}},files={16898613353,{48,48},{771,710}},["send-to-back"]={16898613699,{48,48},{820,955}},["alarm-clock"]={16898612629,{48,48},{257,820}},["shopping-basket"]={16898613777,{48,48},{0,869}},send={16898613699,{48,48},{967,857}},["chevron-left-square"]={16898612819,{48,48},{453,918}},["terminal-square"]={16898613869,{48,48},{0,820}},wifi={16898613869,{48,48},{869,808}},["skip-back"]={16898613777,{48,48},{147,771}},["wrap-text"]={16898613869,{48,48},{869,857}},["file-scan"]={16898613353,{48,48},{820,147}},["message-square-dashed"]={16898613613,{48,48},{918,0}},trophy={16898613869,{48,48},{820,147}},umbrella={16898613869,{48,48},{869,355}},touchpad={16898613869,{48,48},{49,869}},["clipboard-copy"]={16898613044,{48,48},{820,563}},pentagon={16898613699,{48,48},{771,306}},["arrow-up-from-line"]={16898612629,{48,48},{820,710}},["circle-chevron-up"]={16898613044,{48,48},{771,0}},worm={16898613869,{48,48},{918,808}},["lamp-desk"]={16898613509,{48,48},{355,918}},["circle-arrow-up"]={16898612819,{48,48},{967,857}},zap={16898613869,{48,48},{918,906}},boxes={16898612819,{48,48},{196,771}},["swiss-franc"]={16898613777,{48,48},{820,857}},["move-left"]={16898613613,{48,48},{98,918}},["chevron-up"]={16898612819,{48,48},{710,918}},instagram={16898613509,{48,48},{514,967}},["pen-tool"]={16898613699,{48,48},{820,0}},["pencil-ruler"]={16898613699,{48,48},{0,820}},["grid-2x2"]={16898613509,{48,48},{771,98}},["arrow-big-down-dash"]={16898612629,{48,48},{771,196}},["clipboard-edit"]={16898613044,{48,48},{771,612}},mic={16898613613,{48,48},{820,612}},["file-minus-2"]={16898613353,{48,48},{869,563}},gitlab={16898613509,{48,48},{820,257}},["rotate-3d"]={16898613699,{48,48},{147,918}},["spell-check"]={16898613777,{48,48},{196,771}},popcorn={16898613699,{48,48},{612,820}},blocks={16898612819,{48,48},{49,820}},["washing-machine"]={16898613869,{48,48},{918,710}},siren={16898613777,{48,48},{771,147}},["cloud-sun"]={16898613044,{48,48},{0,967}},circle={16898613044,{48,48},{771,355}},["shield-alert"]={16898613777,{48,48},{49,771}},rainbow={16898613699,{48,48},{918,563}},["separator-vertical"]={16898613699,{48,48},{869,955}},ampersands={16898612629,{48,48},{355,820}},["user-search"]={16898613869,{48,48},{918,612}},fence={16898613353,{48,48},{98,771}},["square-user-round"]={16898613777,{48,48},{355,967}},sunrise={16898613777,{48,48},{453,967}},strikethrough={16898613777,{48,48},{869,759}},["calendar-days"]={16898612819,{48,48},{869,147}},["dollar-sign"]={16898613044,{48,48},{820,857}},["message-square-quote"]={16898613613,{48,48},{0,918}},["list-minus"]={16898613509,{48,48},{820,808}},["cloud-hail"]={16898613044,{48,48},{967,0}},upload={16898613869,{48,48},{612,869}},["app-window-mac"]={16898612629,{48,48},{661,771}},ellipsis={16898613353,{48,48},{771,49}},["copy-check"]={16898613044,{48,48},{453,820}},history={16898613509,{48,48},{869,98}},satellite={16898613699,{48,48},{147,967}},["bookmark-plus"]={16898612819,{48,48},{612,820}},["folder-key"]={16898613353,{48,48},{355,967}},["lamp-ceiling"]={16898613509,{48,48},{404,869}},["circle-power"]={16898613044,{48,48},{820,49}},hourglass={16898613509,{48,48},{49,918}},keyboard={16898613509,{48,48},{453,820}},triangle={16898613869,{48,48},{869,98}},["layers-2"]={16898613509,{48,48},{196,869}},["battery-full"]={16898612629,{48,48},{967,808}},["user-minus"]={16898613869,{48,48},{49,967}},["x-octagon"]={16898613869,{48,48},{967,808}},["folder-tree"]={16898613353,{48,48},{967,404}},command={16898613044,{48,48},{563,918}},["badge-dollar-sign"]={16898612629,{48,48},{918,196}},["align-start-vertical"]={16898612629,{48,48},{820,98}},["chevrons-down"]={16898612819,{48,48},{967,196}},["bluetooth-off"]={16898612819,{48,48},{869,257}},cannabis={16898612819,{48,48},{710,820}},book={16898612819,{48,48},{820,612}},hammer={16898613509,{48,48},{306,820}},["circle-minus"]={16898613044,{48,48},{771,306}},["audio-waveform"]={16898612629,{48,48},{967,612}},["moon-star"]={16898613613,{48,48},{355,869}},["arrow-right"]={16898612629,{48,48},{453,820}},sparkle={16898613777,{48,48},{967,0}},wand={16898613869,{48,48},{404,967}},["calendar-minus-2"]={16898612819,{48,48},{147,869}},["copy-minus"]={16898613044,{48,48},{404,869}},["folder-input"]={16898613353,{48,48},{453,869}},["book-image"]={16898612819,{48,48},{771,147}},shirt={16898613777,{48,48},{98,771}},["server-off"]={16898613699,{48,48},{967,955}},["move-up"]={16898613613,{48,48},{869,404}},["plug-2"]={16898613699,{48,48},{869,306}},radio={16898613699,{48,48},{306,918}},brackets={16898612819,{48,48},{98,869}},["calendar-heart"]={16898612819,{48,48},{196,820}},["list-ordered"]={16898613509,{48,48},{710,918}},["mic-off"]={16898613613,{48,48},{918,514}},["arrow-big-left"]={16898612629,{48,48},{98,869}},["square-split-horizontal"]={16898613777,{48,48},{918,404}},["tree-deciduous"]={16898613869,{48,48},{869,563}},["sun-snow"]={16898613777,{48,48},{196,967}},["user-2"]={16898613869,{48,48},{514,967}},["help-circle"]={16898613509,{48,48},{563,869}},["clock-2"]={16898613044,{48,48},{771,404}},["calendar-fold"]={16898612819,{48,48},{820,196}},["fish-off"]={16898613353,{48,48},{967,49}},baby={16898612629,{48,48},{771,808}},leaf={16898613509,{48,48},{918,661}},["fold-vertical"]={16898613353,{48,48},{661,869}},hop={16898613509,{48,48},{196,771}},paperclip={16898613613,{48,48},{918,857}},cigarette={16898612819,{48,48},{967,759}},minus={16898613613,{48,48},{771,196}},["smile-plus"]={16898613777,{48,48},{918,514}},["chevron-right-circle"]={16898612819,{48,48},{967,661}},["star-off"]={16898613777,{48,48},{612,967}},["git-pull-request-closed"]={16898613509,{48,48},{771,514}},["badge-check"]={16898612629,{48,48},{967,147}},["test-tube-2"]={16898613869,{48,48},{771,306}},["kanban-square"]={16898613509,{48,48},{98,918}},["plug-zap"]={16898613699,{48,48},{771,404}},["heading-4"]={16898613509,{48,48},{820,355}},["git-pull-request-create"]={16898613509,{48,48},{820,0}},["replace-all"]={16898613699,{48,48},{771,759}},["receipt-swiss-franc"]={16898613699,{48,48},{967,49}},["square-dashed-bottom-code"]={16898613777,{48,48},{196,820}},["clock-7"]={16898613044,{48,48},{918,514}},["scan-text"]={16898613699,{48,48},{661,967}},["shower-head"]={16898613777,{48,48},{771,355}},["equal-not"]={16898613353,{48,48},{49,771}},["move-down"]={16898613613,{48,48},{196,820}},["ticket-slash"]={16898613869,{48,48},{820,563}},ruler={16898613699,{48,48},{710,869}},["circle-user-round"]={16898613044,{48,48},{0,869}},subscript={16898613777,{48,48},{820,808}},["alarm-minus"]={16898612629,{48,48},{820,514}},["layout-grid"]={16898613509,{48,48},{918,404}},cog={16898613044,{48,48},{918,563}},dog={16898613044,{48,48},{869,808}},swords={16898613777,{48,48},{967,759}},["panel-right-dashed"]={16898613613,{48,48},{967,710}},["ship-wheel"]={16898613777,{48,48},{820,49}},bot={16898612819,{48,48},{869,98}},["trash-2"]={16898613869,{48,48},{257,918}},["chevron-down-square"]={16898612819,{48,48},{918,196}},dot={16898613044,{48,48},{918,808}},["file-symlink"]={16898613353,{48,48},{967,257}},["clipboard-paste"]={16898613044,{48,48},{514,869}},plug={16898613699,{48,48},{404,771}},["book-heart"]={16898612819,{48,48},{820,98}},["circle-parking"]={16898613044,{48,48},{820,514}},["volume-1"]={16898613869,{48,48},{820,759}},["circle-chevron-right"]={16898612819,{48,48},{967,955}},speaker={16898613777,{48,48},{869,98}},timer={16898613869,{48,48},{918,0}},forward={16898613353,{48,48},{771,857}},["file-up"]={16898613353,{48,48},{453,771}},["between-vertical-start"]={16898612819,{48,48},{820,514}},database={16898613044,{48,48},{710,869}},["panel-right"]={16898613613,{48,48},{820,857}},["log-out"]={16898613509,{48,48},{820,955}},["git-branch-plus"]={16898613353,{48,48},{967,857}},["clipboard-minus"]={16898613044,{48,48},{563,820}},["file-text"]={16898613353,{48,48},{869,355}},["arrow-right-circle"]={16898612629,{48,48},{49,967}},["table-rows-split"]={16898613777,{48,48},{869,906}},watch={16898613869,{48,48},{869,759}},["cloud-upload"]={16898613044,{48,48},{967,257}},banknote={16898612629,{48,48},{453,967}},["folder-up"]={16898613353,{48,48},{918,453}},["list-checks"]={16898613509,{48,48},{404,967}},bug={16898612819,{48,48},{257,967}},["circle-chevron-left"]={16898612819,{48,48},{918,955}},["arrow-down"]={16898612629,{48,48},{967,49}},["arrow-up-down"]={16898612629,{48,48},{918,612}},["file-audio"]={16898613353,{48,48},{771,355}},["whole-word"]={16898613869,{48,48},{967,710}},monitor={16898613613,{48,48},{404,820}},["flag-off"]={16898613353,{48,48},{820,196}},["align-right"]={16898612629,{48,48},{918,0}},["circle-stop"]={16898613044,{48,48},{49,820}},infinity={16898613509,{48,48},{661,820}},["arrow-big-down"]={16898612629,{48,48},{196,771}},["circle-parking-off"]={16898613044,{48,48},{257,820}},["calendar-x-2"]={16898612819,{48,48},{453,820}},["user-plus"]={16898613869,{48,48},{918,355}},["move-diagonal-2"]={16898613613,{48,48},{967,49}},["gallery-horizontal-end"]={16898613353,{48,48},{967,710}},["panel-top-dashed"]={16898613613,{48,48},{710,967}},["tram-front"]={16898613869,{48,48},{306,869}},podcast={16898613699,{48,48},{820,612}},["image-minus"]={16898613509,{48,48},{771,453}},["flip-vertical-2"]={16898613353,{48,48},{967,563}},github={16898613509,{48,48},{0,820}},pocket={16898613699,{48,48},{869,563}},printer={16898613699,{48,48},{196,771}},["megaphone-off"]={16898613613,{48,48},{514,820}},["file-bar-chart-2"]={16898613353,{48,48},{869,514}},["arrow-big-right"]={16898612629,{48,48},{0,967}},replace={16898613699,{48,48},{710,820}},["toy-brick"]={16898613869,{48,48},{918,257}},["square-chevron-down"]={16898613777,{48,48},{514,967}},["dice-1"]={16898613044,{48,48},{147,967}},["scan-search"]={16898613699,{48,48},{710,918}},["sticky-note"]={16898613777,{48,48},{918,453}},["shield-check"]={16898613777,{48,48},{820,257}},["hand-metal"]={16898613509,{48,48},{771,612}},["x-circle"]={16898613869,{48,48},{771,955}},["spell-check-2"]={16898613777,{48,48},{771,196}},["minus-square"]={16898613613,{48,48},{820,147}},["box-select"]={16898612819,{48,48},{820,147}},sprout={16898613777,{48,48},{918,306}},waypoints={16898613869,{48,48},{771,857}},["ice-cream-cone"]={16898613509,{48,48},{918,306}},["text-quote"]={16898613869,{48,48},{514,820}},wind={16898613869,{48,48},{820,857}},["layout-panel-left"]={16898613509,{48,48},{453,869}},["circle-percent"]={16898613044,{48,48},{563,771}},["circle-arrow-out-down-right"]={16898612819,{48,48},{967,808}},["square-x"]={16898613777,{48,48},{918,661}},italic={16898613509,{48,48},{967,49}},["step-forward"]={16898613777,{48,48},{196,918}},["a-arrow-down"]={16898612629,{48,48},{771,0}},container={16898613044,{48,48},{967,306}},sticker={16898613777,{48,48},{967,404}},["parking-circle-off"]={16898613613,{48,48},{820,955}},import={16898613509,{48,48},{967,514}},vault={16898613869,{48,48},{98,967}},["square-terminal"]={16898613777,{48,48},{404,918}},["file-music"]={16898613353,{48,48},{771,661}},beef={16898612819,{48,48},{0,771}},["route-off"]={16898613699,{48,48},{453,869}},["timer-reset"]={16898613869,{48,48},{514,869}},["monitor-stop"]={16898613613,{48,48},{820,404}},smile={16898613777,{48,48},{869,563}},["signpost-big"]={16898613777,{48,48},{869,49}},["folder-lock"]={16898613353,{48,48},{967,612}},["square-percent"]={16898613777,{48,48},{661,869}},["navigation-off"]={16898613613,{48,48},{820,710}},["arrow-left"]={16898612629,{48,48},{98,918}},["car-taxi-front"]={16898612819,{48,48},{967,98}},laugh={16898613509,{48,48},{869,196}},["x-square"]={16898613869,{48,48},{918,857}},["step-back"]={16898613777,{48,48},{918,196}},equal={16898613353,{48,48},{0,820}},megaphone={16898613613,{48,48},{869,0}},["calendar-x"]={16898612819,{48,48},{404,869}},egg={16898613353,{48,48},{514,771}},["video-off"]={16898613869,{48,48},{404,918}},["japanese-yen"]={16898613509,{48,48},{820,196}},library={16898613509,{48,48},{710,869}},["file-terminal"]={16898613353,{48,48},{918,306}},quote={16898613699,{48,48},{918,306}},accessibility={16898612629,{48,48},{257,771}},["square-library"]={16898613777,{48,48},{355,918}},salad={16898613699,{48,48},{967,147}},["tally-2"]={16898613869,{48,48},{771,0}},sheet={16898613777,{48,48},{820,0}},["circle-check-big"]={16898612819,{48,48},{918,906}},["map-pinned"]={16898613613,{48,48},{771,306}},["corner-down-left"]={16898613044,{48,48},{771,759}},dribbble={16898613044,{48,48},{918,857}},["pilcrow-square"]={16898613699,{48,48},{771,612}},["lamp-wall-up"]={16898613509,{48,48},{918,612}},["book-dashed"]={16898612819,{48,48},{514,869}},["unfold-vertical"]={16898613869,{48,48},{306,918}},["tree-pine"]={16898613869,{48,48},{771,661}},["receipt-indian-rupee"]={16898613699,{48,48},{661,820}},["check-circle-2"]={16898612819,{48,48},{918,661}},["flask-conical"]={16898613353,{48,48},{453,820}},["package-search"]={16898613613,{48,48},{612,967}},columns={16898613044,{48,48},{661,820}},["folder-sync"]={16898613353,{48,48},{147,967}},fingerprint={16898613353,{48,48},{563,918}},["arrow-up-narrow-wide"]={16898612629,{48,48},{612,918}},frame={16898613353,{48,48},{710,918}},["clock-12"]={16898613044,{48,48},{820,355}},images={16898613509,{48,48},{257,967}},lollipop={16898613509,{48,48},{967,857}},["folder-root"]={16898613353,{48,48},{612,967}},["arrow-left-circle"]={16898612629,{48,48},{918,98}},["lamp-floor"]={16898613509,{48,48},{306,967}},image={16898613509,{48,48},{306,918}},["baggage-claim"]={16898612629,{48,48},{967,196}},bike={16898612819,{48,48},{771,563}},option={16898613613,{48,48},{355,967}},["scroll-text"]={16898613699,{48,48},{967,759}},["toggle-right"]={16898613869,{48,48},{820,98}},["ferris-wheel"]={16898613353,{48,48},{49,820}},["camera-off"]={16898612819,{48,48},{306,967}},["function-square"]={16898613353,{48,48},{453,967}},group={16898613509,{48,48},{820,306}},codesandbox={16898613044,{48,48},{257,967}},["message-circle-question"]={16898613613,{48,48},{869,514}},["tent-tree"]={16898613869,{48,48},{771,49}},["rectangle-horizontal"]={16898613699,{48,48},{196,820}},subtitles={16898613777,{48,48},{771,857}},mail={16898613613,{48,48},{820,0}},["brain-cog"]={16898612819,{48,48},{0,967}},["hand-platter"]={16898613509,{48,48},{612,771}},club={16898613044,{48,48},{771,453}},twitch={16898613869,{48,48},{49,918}},pipette={16898613699,{48,48},{869,49}},user={16898613869,{48,48},{661,869}},["align-vertical-space-around"]={16898612629,{48,48},{869,306}},["test-tubes"]={16898613869,{48,48},{820,514}},wheat={16898613869,{48,48},{453,967}},["axis-3d"]={16898612629,{48,48},{820,759}},folders={16898613353,{48,48},{967,661}},diff={16898613044,{48,48},{869,759}},puzzle={16898613699,{48,48},{49,918}},["package-2"]={16898613613,{48,48},{869,710}},indent={16898613509,{48,48},{771,710}},tangent={16898613869,{48,48},{771,514}},["power-circle"]={16898613699,{48,48},{967,0}},["badge-pound-sterling"]={16898612629,{48,48},{869,759}},["mail-minus"]={16898613509,{48,48},{967,955}},["circle-slash"]={16898613044,{48,48},{98,771}},["app-window"]={16898612629,{48,48},{612,820}},["move-down-right"]={16898613613,{48,48},{820,196}},["parking-square-off"]={16898613613,{48,48},{869,955}},["clipboard-pen"]={16898613044,{48,48},{869,49}},["notepad-text"]={16898613613,{48,48},{147,918}},["signal-low"]={16898613777,{48,48},{612,771}},home={16898613509,{48,48},{820,147}},list={16898613509,{48,48},{869,808}},plus={16898613699,{48,48},{257,918}},["square-arrow-right"]={16898613777,{48,48},{918,563}},["scissors-square-dashed-bottom"]={16898613699,{48,48},{918,759}},["remove-formatting"]={16898613699,{48,48},{967,563}},["bookmark-check"]={16898612819,{48,48},{771,661}},["send-horizontal"]={16898613699,{48,48},{869,906}},["chevrons-left-right"]={16898612819,{48,48},{196,967}},["folder-kanban"]={16898613353,{48,48},{404,918}},["a-arrow-up"]={16898612629,{48,48},{0,771}},["list-restart"]={16898613509,{48,48},{967,196}},["cloud-moon"]={16898613044,{48,48},{820,147}},["book-audio"]={16898612819,{48,48},{771,612}},["vibrate-off"]={16898613869,{48,48},{869,453}},["mail-check"]={16898613509,{48,48},{918,955}},["panel-top-inactive"]={16898613613,{48,48},{967,759}},["file-type-2"]={16898613353,{48,48},{820,404}},["file-code"]={16898613353,{48,48},{869,49}},donut={16898613044,{48,48},{771,906}},["list-todo"]={16898613509,{48,48},{967,453}},dna={16898613044,{48,48},{967,710}},["monitor-down"]={16898613613,{48,48},{98,869}},["cassette-tape"]={16898612819,{48,48},{918,404}},["battery-low"]={16898612629,{48,48},{918,857}},flashlight={16898613353,{48,48},{869,404}},wine={16898613869,{48,48},{710,967}},signpost={16898613777,{48,48},{820,98}},["creative-commons"]={16898613044,{48,48},{147,918}},["globe-2"]={16898613509,{48,48},{257,820}},landmark={16898613509,{48,48},{771,759}},["map-pin"]={16898613613,{48,48},{820,257}},["clipboard-x"]={16898613044,{48,48},{98,820}},loader={16898613509,{48,48},{710,967}},bold={16898612819,{48,48},{355,771}},["dice-2"]={16898613044,{48,48},{967,404}},["file-type"]={16898613353,{48,48},{771,453}},utensils={16898613869,{48,48},{869,196}},beer={16898612819,{48,48},{257,771}},["file-video-2"]={16898613353,{48,48},{404,820}},["chef-hat"]={16898612819,{48,48},{661,918}},rocket={16898613699,{48,48},{918,147}},bird={16898612819,{48,48},{869,0}},["file-x"]={16898613353,{48,48},{869,612}},["move-diagonal"]={16898613613,{48,48},{918,98}},["folder-minus"]={16898613353,{48,48},{918,661}},["door-closed"]={16898613044,{48,48},{710,967}},["bluetooth-connected"]={16898612819,{48,48},{0,869}},["layout-template"]={16898613509,{48,48},{355,967}},["air-vent"]={16898612629,{48,48},{820,0}},["rows-2"]={16898613699,{48,48},{967,612}},["pen-square"]={16898613699,{48,48},{514,771}},["panel-bottom-close"]={16898613613,{48,48},{967,661}},["hand-heart"]={16898613509,{48,48},{869,514}},["file-code-2"]={16898613353,{48,48},{918,0}},["arrow-down-wide-narrow"]={16898612629,{48,48},{563,918}},["clock-10"]={16898613044,{48,48},{918,257}},drumstick={16898613044,{48,48},{869,955}},["disc-2"]={16898613044,{48,48},{820,808}},["skip-forward"]={16898613777,{48,48},{98,820}},skull={16898613777,{48,48},{49,869}},["chevron-left"]={16898612819,{48,48},{404,967}},["split-square-vertical"]={16898613777,{48,48},{49,918}},snowflake={16898613777,{48,48},{771,661}},key={16898613509,{48,48},{869,404}},["clock-11"]={16898613044,{48,48},{869,306}},["sliders-horizontal"]={16898613777,{48,48},{820,355}},["ticket-plus"]={16898613869,{48,48},{869,514}},["square-dashed-bottom"]={16898613777,{48,48},{147,869}},["mic-vocal"]={16898613613,{48,48},{869,563}},["activity-square"]={16898612629,{48,48},{771,514}},["monitor-pause"]={16898613613,{48,48},{0,967}},["book-open-check"]={16898612819,{48,48},{918,257}},projector={16898613699,{48,48},{147,820}},["lasso-select"]={16898613509,{48,48},{967,98}},["folder-open-dot"]={16898613353,{48,48},{869,710}},["align-justify"]={16898612629,{48,48},{563,820}},["log-in"]={16898613509,{48,48},{869,906}},tag={16898613777,{48,48},{967,906}},bus={16898612819,{48,48},{820,661}},["locate-fixed"]={16898613509,{48,48},{967,759}},["bed-single"]={16898612629,{48,48},{967,955}},["dice-4"]={16898613044,{48,48},{453,918}},["file-spreadsheet"]={16898613353,{48,48},{49,918}},["sun-dim"]={16898613777,{48,48},{710,918}},["clipboard-list"]={16898613044,{48,48},{612,771}},gamepad={16898613353,{48,48},{967,759}},["contact-round"]={16898613044,{48,48},{98,918}},["align-horizontal-space-around"]={16898612629,{48,48},{771,612}},["music-2"]={16898613613,{48,48},{404,869}},["hard-hat"]={16898613509,{48,48},{771,147}},["file-badge"]={16898613353,{48,48},{257,869}},["battery-warning"]={16898612629,{48,48},{820,955}},rows={16898613699,{48,48},{820,759}},["arrow-down-from-line"]={16898612629,{48,48},{404,820}},["rows-4"]={16898613699,{48,48},{869,710}},biohazard={16898612819,{48,48},{514,820}},["book-up"]={16898612819,{48,48},{257,918}},["heading-6"]={16898613509,{48,48},{404,771}},["scale-3d"]={16898613699,{48,48},{453,918}},["chevron-down-circle"]={16898612819,{48,48},{967,147}},["mail-x"]={16898613613,{48,48},{514,771}},["square-dashed-mouse-pointer"]={16898613777,{48,48},{49,967}},["user-cog"]={16898613869,{48,48},{147,869}},["satellite-dish"]={16898613699,{48,48},{196,918}},["alarm-clock-minus"]={16898612629,{48,48},{820,257}},pizza={16898613699,{48,48},{820,98}},["pc-case"]={16898613699,{48,48},{257,771}},["move-down-left"]={16898613613,{48,48},{869,147}},school={16898613699,{48,48},{453,967}},orbit={16898613613,{48,48},{967,612}},["file-minus"]={16898613353,{48,48},{820,612}},["rotate-ccw"]={16898613699,{48,48},{967,355}},["align-horizontal-justify-center"]={16898612629,{48,48},{257,869}},["phone-incoming"]={16898613699,{48,48},{820,49}},antenna={16898612629,{48,48},{869,563}},["memory-stick"]={16898613613,{48,48},{771,98}},["scan-eye"]={16898613699,{48,48},{869,759}},["align-center-vertical"]={16898612629,{48,48},{49,820}},["square-check"]={16898613777,{48,48},{563,918}},["align-end-horizontal"]={16898612629,{48,48},{869,257}},["message-square-off"]={16898613613,{48,48},{98,820}},["folder-open"]={16898613353,{48,48},{820,759}},["contact-2"]={16898613044,{48,48},{147,869}},["parking-circle"]={16898613613,{48,48},{967,857}},["menu-square"]={16898613613,{48,48},{98,771}},["hand-coins"]={16898613509,{48,48},{257,869}},["message-circle-code"]={16898613613,{48,48},{869,257}},["arrow-up-wide-narrow"]={16898612629,{48,48},{147,918}},["copy-x"]={16898613044,{48,48},{967,563}},clock={16898613044,{48,48},{771,661}},["file-pen"]={16898613353,{48,48},{563,869}},["git-compare-arrows"]={16898613353,{48,48},{918,955}},["square-arrow-down-right"]={16898613777,{48,48},{771,453}},joystick={16898613509,{48,48},{196,820}},["align-vertical-space-between"]={16898612629,{48,48},{820,355}},["file-pie-chart"]={16898613353,{48,48},{514,918}},gem={16898613353,{48,48},{918,857}},["calendar-plus"]={16898612819,{48,48},{918,355}},["bell-electric"]={16898612819,{48,48},{514,771}},["arrow-down-z-a"]={16898612629,{48,48},{514,967}},bath={16898612629,{48,48},{820,906}},anvil={16898612629,{48,48},{820,612}},["unlink-2"]={16898613869,{48,48},{918,563}},["archive-restore"]={16898612629,{48,48},{514,918}},archive={16898612629,{48,48},{918,49}},["folder-check"]={16898613353,{48,48},{563,967}},["arrow-big-left-dash"]={16898612629,{48,48},{147,820}},["book-key"]={16898612819,{48,48},{147,771}},ribbon={16898613699,{48,48},{967,98}},["package-open"]={16898613613,{48,48},{710,869}},["arrow-down-0-1"]={16898612629,{48,48},{869,355}},["library-big"]={16898613509,{48,48},{820,759}},["file-json"]={16898613353,{48,48},{771,404}},["arrow-down-a-z"]={16898612629,{48,48},{771,453}},["arrow-down-left"]={16898612629,{48,48},{257,967}},["square-scissors"]={16898613777,{48,48},{147,918}},["move-up-left"]={16898613613,{48,48},{967,306}},["arrow-down-up"]={16898612629,{48,48},{612,869}},["folder-heart"]={16898613353,{48,48},{869,453}},["gauge-circle"]={16898613353,{48,48},{820,906}},percent={16898613699,{48,48},{771,563}},["arrow-up-1-0"]={16898612629,{48,48},{355,918}},["arrow-up-a-z"]={16898612629,{48,48},{306,967}},["circle-arrow-right"]={16898612819,{48,48},{820,955}},["panel-bottom-inactive"]={16898613613,{48,48},{869,759}},["arrow-up"]={16898612629,{48,48},{967,355}},asterisk={16898612629,{48,48},{869,453}},["gallery-vertical"]={16898613353,{48,48},{771,906}},["swatch-book"]={16898613777,{48,48},{869,808}},["receipt-cent"]={16898613699,{48,48},{771,710}},["audio-lines"]={16898612629,{48,48},{355,967}},["folder-archive"]={16898613353,{48,48},{612,918}},["folder-symlink"]={16898613353,{48,48},{196,918}},["columns-3"]={16898613044,{48,48},{771,710}},ban={16898612629,{48,48},{196,967}},["message-square-x"]={16898613613,{48,48},{404,771}},["paint-roller"]={16898613613,{48,48},{147,967}},["folder-search-2"]={16898613353,{48,48},{967,147}},fan={16898613353,{48,48},{869,0}},["badge-euro"]={16898612629,{48,48},{196,918}},["badge-info"]={16898612629,{48,48},{918,453}},["building-2"]={16898612819,{48,48},{967,514}},square={16898613777,{48,48},{869,710}},medal={16898613613,{48,48},{563,771}},cake={16898612819,{48,48},{612,869}},["cloud-rain"]={16898613044,{48,48},{147,820}},["maximize-2"]={16898613613,{48,48},{820,514}},shell={16898613777,{48,48},{771,49}},wrench={16898613869,{48,48},{820,906}},badge={16898612629,{48,48},{661,967}},codepen={16898613044,{48,48},{306,918}},["corner-right-down"]={16898613044,{48,48},{563,967}},["flag-triangle-right"]={16898613353,{48,48},{147,869}},network={16898613613,{48,48},{710,820}},["bar-chart-3"]={16898612629,{48,48},{918,759}},bell={16898612819,{48,48},{820,257}},["bar-chart"]={16898612629,{48,48},{967,759}},ratio={16898613699,{48,48},{820,661}},["square-chevron-up"]={16898613777,{48,48},{869,147}},["brick-wall"]={16898612819,{48,48},{918,306}},["user-check"]={16898613869,{48,48},{918,98}},proportions={16898613699,{48,48},{98,869}},["alert-octagon"]={16898612629,{48,48},{820,49}},plane={16898613699,{48,48},{98,820}},["webhook-off"]={16898613869,{48,48},{661,967}},["thermometer-sun"]={16898613869,{48,48},{0,869}},["square-arrow-left"]={16898613777,{48,48},{404,820}},["mouse-pointer"]={16898613613,{48,48},{612,869}},heart={16898613509,{48,48},{661,771}},["test-tube-diagonal"]={16898613869,{48,48},{306,771}},["briefcase-medical"]={16898612819,{48,48},{820,404}},["align-vertical-distribute-start"]={16898612629,{48,48},{98,820}},mailbox={16898613613,{48,48},{771,49}},["bell-off"]={16898612819,{48,48},{771,49}},binary={16898612819,{48,48},{563,771}},["book-open-text"]={16898612819,{48,48},{869,306}},split={16898613777,{48,48},{0,967}},twitter={16898613869,{48,48},{0,967}},calculator={16898612819,{48,48},{563,918}},forklift={16898613353,{48,48},{869,759}},bluetooth={16898612819,{48,48},{771,355}},folder={16898613353,{48,48},{404,967}},["square-kanban"]={16898613777,{48,48},{404,869}},["message-square-diff"]={16898613613,{48,48},{869,49}},["square-sigma"]={16898613777,{48,48},{98,967}},["alarm-plus"]={16898612629,{48,48},{771,563}},star={16898613777,{48,48},{967,147}},["rotate-ccw-square"]={16898613699,{48,48},{98,967}},castle={16898612819,{48,48},{453,869}},["book-down"]={16898612819,{48,48},{918,0}},["file-volume-2"]={16898613353,{48,48},{306,918}},["book-headphones"]={16898612819,{48,48},{869,49}},power={16898613699,{48,48},{820,147}},album={16898612629,{48,48},{514,820}},["book-marked"]={16898612819,{48,48},{49,869}},["book-open"]={16898612819,{48,48},{820,355}},["file-box"]={16898613353,{48,48},{771,612}},["book-text"]={16898612819,{48,48},{404,771}},telescope={16898613869,{48,48},{820,0}},["glass-water"]={16898613509,{48,48},{771,306}},filter={16898613353,{48,48},{612,869}},glasses={16898613509,{48,48},{306,771}},["piggy-bank"]={16898613699,{48,48},{820,563}},["book-type"]={16898612819,{48,48},{355,820}},cuboid={16898613044,{48,48},{355,967}},["cloud-off"]={16898613044,{48,48},{771,196}},["check-check"]={16898612819,{48,48},{967,612}},activity={16898612629,{48,48},{514,771}},axe={16898612629,{48,48},{869,710}},["plane-takeoff"]={16898613699,{48,48},{147,771}},["book-x"]={16898612819,{48,48},{869,563}},["cloud-rain-wind"]={16898613044,{48,48},{196,771}},bookmark={16898612819,{48,48},{514,918}},["zoom-in"]={16898613869,{48,48},{869,955}},["square-pilcrow"]={16898613777,{48,48},{563,967}},["file-axis-3d"]={16898613353,{48,48},{355,771}},["receipt-euro"]={16898613699,{48,48},{710,771}},["brain-circuit"]={16898612819,{48,48},{49,918}},["briefcase-business"]={16898612819,{48,48},{869,355}},["bug-play"]={16898612819,{48,48},{306,918}},["tally-3"]={16898613869,{48,48},{0,771}},["clipboard-type"]={16898613044,{48,48},{147,771}},brush={16898612819,{48,48},{404,820}},["tally-5"]={16898613869,{48,48},{257,771}},["cable-car"]={16898612819,{48,48},{771,710}},cable={16898612819,{48,48},{710,771}},["calendar-check"]={16898612819,{48,48},{967,49}},["user-square-2"]={16898613869,{48,48},{869,661}},["calendar-minus"]={16898612819,{48,48},{98,918}},["calendar-plus-2"]={16898612819,{48,48},{967,306}},linkedin={16898613509,{48,48},{453,918}},["life-buoy"]={16898613509,{48,48},{661,918}},["calendar-search"]={16898612819,{48,48},{820,453}},["circle-chevron-down"]={16898612819,{48,48},{967,906}},["volume-2"]={16898613869,{48,48},{771,808}},["battery-charging"]={16898612629,{48,48},{771,955}},["russian-ruble"]={16898613699,{48,48},{661,918}},["square-arrow-up-left"]={16898613777,{48,48},{869,612}},["earth-lock"]={16898613353,{48,48},{771,0}},footprints={16898613353,{48,48},{918,710}},hash={16898613509,{48,48},{147,771}},building={16898612819,{48,48},{918,563}},ear={16898613044,{48,48},{967,955}},caravan={16898612819,{48,48},{869,196}},carrot={16898612819,{48,48},{196,869}},cherry={16898612819,{48,48},{612,967}},["user-check-2"]={16898613869,{48,48},{967,49}},["shield-plus"]={16898613777,{48,48},{771,563}},moon={16898613613,{48,48},{306,918}},["bell-minus"]={16898612819,{48,48},{820,0}},["image-up"]={16898613509,{48,48},{355,869}},["case-sensitive"]={16898612819,{48,48},{98,967}},drum={16898613044,{48,48},{918,906}},["arrow-up-z-a"]={16898612629,{48,48},{98,967}},sun={16898613777,{48,48},{967,453}},["gantt-chart-square"]={16898613353,{48,48},{918,808}},["align-horizontal-justify-start"]={16898612629,{48,48},{820,563}},["file-key"]={16898613353,{48,48},{355,820}},["monitor-smartphone"]={16898613613,{48,48},{918,306}},["move-3d"]={16898613613,{48,48},{514,967}},["scissors-line-dashed"]={16898613699,{48,48},{967,710}},["text-select"]={16898613869,{48,48},{820,49}},["case-lower"]={16898612819,{48,48},{147,918}},["plus-circle"]={16898613699,{48,48},{355,820}},["ticket-check"]={16898613869,{48,48},{355,771}},pyramid={16898613699,{48,48},{0,967}},["chevron-last"]={16898612819,{48,48},{967,404}},["user-cog-2"]={16898613869,{48,48},{196,820}},["refresh-cw-off"]={16898613699,{48,48},{453,820}},piano={16898613699,{48,48},{771,355}},["picture-in-picture-2"]={16898613699,{48,48},{306,820}},["user-round"]={16898613869,{48,48},{967,563}},["flower-2"]={16898613353,{48,48},{869,661}},["chevron-up-square"]={16898612819,{48,48},{771,857}},["chevrons-left"]={16898612819,{48,48},{967,453}},["chevrons-right-left"]={16898612819,{48,48},{453,967}},car={16898612819,{48,48},{918,147}},["keyboard-music"]={16898613509,{48,48},{820,453}},["star-half"]={16898613777,{48,48},{661,918}},mouse={16898613613,{48,48},{563,918}},lock={16898613509,{48,48},{918,857}},["pencil-line"]={16898613699,{48,48},{49,771}},mails={16898613613,{48,48},{49,771}},film={16898613353,{48,48},{710,771}},tablet={16898613777,{48,48},{918,906}},["circle-arrow-left"]={16898612819,{48,48},{820,906}},pi={16898613699,{48,48},{820,306}},trash={16898613869,{48,48},{918,514}},dock={16898613044,{48,48},{918,759}},["hdmi-port"]={16898613509,{48,48},{49,869}},["circle-arrow-out-up-left"]={16898612819,{48,48},{918,857}},["case-upper"]={16898612819,{48,48},{967,355}},["circle-arrow-out-up-right"]={16898612819,{48,48},{869,906}},tags={16898613777,{48,48},{918,955}},croissant={16898613044,{48,48},{967,355}},["circle-check"]={16898612819,{48,48},{869,955}},bomb={16898612819,{48,48},{257,869}},diameter={16898613044,{48,48},{967,147}},["circle-dashed"]={16898613044,{48,48},{0,771}},["bar-chart-big"]={16898612629,{48,48},{820,857}},["upload-cloud"]={16898613869,{48,48},{661,820}},["code-xml"]={16898613044,{48,48},{404,820}},divide={16898613044,{48,48},{967,453}},grape={16898613509,{48,48},{820,49}},["play-square"]={16898613699,{48,48},{0,918}},["party-popper"]={16898613613,{48,48},{918,955}},["circle-ellipsis"]={16898613044,{48,48},{820,0}},file={16898613353,{48,48},{820,661}},["user-circle-2"]={16898613869,{48,48},{869,147}},truck={16898613869,{48,48},{771,196}},["cloud-sun-rain"]={16898613044,{48,48},{49,918}},["calendar-range"]={16898612819,{48,48},{869,404}},contact={16898613044,{48,48},{49,967}},["zap-off"]={16898613869,{48,48},{967,857}},["square-check-big"]={16898613777,{48,48},{612,869}},["circle-user"]={16898613044,{48,48},{869,257}},["layout-panel-top"]={16898613509,{48,48},{404,918}},["roller-coaster"]={16898613699,{48,48},{196,869}},["laptop-minimal"]={16898613509,{48,48},{612,918}},["table-properties"]={16898613777,{48,48},{918,857}},["clipboard-check"]={16898613044,{48,48},{869,514}},layout={16898613509,{48,48},{967,612}},["indent-decrease"]={16898613509,{48,48},{869,612}},cookie={16898613044,{48,48},{869,404}},["message-square-more"]={16898613613,{48,48},{147,771}},clipboard={16898613044,{48,48},{49,869}},euro={16898613353,{48,48},{771,306}},sparkles={16898613777,{48,48},{918,49}},["heart-off"]={16898613509,{48,48},{820,612}},vibrate={16898613869,{48,48},{453,869}},["clock-3"]={16898613044,{48,48},{404,771}},["move-horizontal"]={16898613613,{48,48},{147,869}},["file-sliders"]={16898613353,{48,48},{98,869}},frown={16898613353,{48,48},{967,196}},["move-up-right"]={16898613613,{48,48},{918,355}},["cup-soda"]={16898613044,{48,48},{967,612}},["stretch-vertical"]={16898613777,{48,48},{918,710}},["refresh-cw"]={16898613699,{48,48},{404,869}},sword={16898613777,{48,48},{710,967}},["cloud-drizzle"]={16898613044,{48,48},{563,869}},["laptop-2"]={16898613509,{48,48},{661,869}},earth={16898613353,{48,48},{0,771}},slice={16898613777,{48,48},{869,306}},["land-plot"]={16898613509,{48,48},{820,710}},milk={16898613613,{48,48},{514,918}},["git-pull-request-draft"]={16898613509,{48,48},{771,49}},crown={16898613044,{48,48},{404,918}},["wallet-2"]={16898613869,{48,48},{967,147}},settings={16898613777,{48,48},{771,257}},["rotate-cw-square"]={16898613699,{48,48},{918,404}},atom={16898612629,{48,48},{404,918}},["package-x"]={16898613613,{48,48},{967,147}},["bed-double"]={16898612629,{48,48},{918,955}},["ice-cream-bowl"]={16898613509,{48,48},{967,257}},["circle-dot"]={16898613044,{48,48},{514,771}},["grip-horizontal"]={16898613509,{48,48},{49,820}},cloudy={16898613044,{48,48},{869,355}},["text-cursor-input"]={16898613869,{48,48},{771,563}},["folder-git-2"]={16898613353,{48,48},{967,355}},["message-square-code"]={16898613613,{48,48},{514,869}},clover={16898613044,{48,48},{820,404}},["arrow-down-narrow-wide"]={16898612629,{48,48},{967,514}},code={16898613044,{48,48},{355,869}},["user-x"]={16898613869,{48,48},{710,820}},coins={16898613044,{48,48},{869,612}},dumbbell={16898613044,{48,48},{967,906}},weight={16898613869,{48,48},{196,967}},["alert-triangle"]={16898612629,{48,48},{771,98}},expand={16898613353,{48,48},{306,771}},scale={16898613699,{48,48},{404,967}},component={16898613044,{48,48},{967,49}},["flashlight-off"]={16898613353,{48,48},{918,355}},["panel-top-open"]={16898613613,{48,48},{918,808}},computer={16898613044,{48,48},{918,98}},construction={16898613044,{48,48},{196,820}},notebook={16898613613,{48,48},{869,196}},["power-square"]={16898613699,{48,48},{869,98}},["copy-slash"]={16898613044,{48,48},{306,967}},["square-menu"]={16898613777,{48,48},{967,563}},["circle-play"]={16898613044,{48,48},{514,820}},wallet={16898613869,{48,48},{147,967}},laptop={16898613509,{48,48},{563,967}},["scan-line"]={16898613699,{48,48},{771,857}},["clock-4"]={16898613044,{48,48},{355,820}},["square-arrow-up"]={16898613777,{48,48},{771,710}},copyright={16898613044,{48,48},{820,710}},["chevron-down"]={16898612819,{48,48},{196,918}},["unlock-keyhole"]={16898613869,{48,48},{820,661}},["clock-1"]={16898613044,{48,48},{0,918}},["align-horizontal-distribute-start"]={16898612629,{48,48},{306,820}},["arrow-down-to-line"]={16898612629,{48,48},{661,820}},["mouse-pointer-2"]={16898613613,{48,48},{820,661}},["refresh-ccw"]={16898613699,{48,48},{820,453}},["venetian-mask"]={16898613869,{48,48},{918,404}},["calendar-check-2"]={16898612819,{48,48},{514,967}},["arrow-down-square"]={16898612629,{48,48},{771,710}},spline={16898613777,{48,48},{147,820}},banana={16898612629,{48,48},{967,453}},["git-pull-request-create-arrow"]={16898613509,{48,48},{514,771}},crosshair={16898613044,{48,48},{453,869}},["list-video"]={16898613509,{48,48},{967,710}},["arrow-right-left"]={16898612629,{48,48},{918,355}},["bar-chart-4"]={16898612629,{48,48},{869,808}},["dice-3"]={16898613044,{48,48},{918,453}},["dice-5"]={16898613044,{48,48},{404,967}},["dice-6"]={16898613044,{48,48},{967,661}},["square-plus"]={16898613777,{48,48},{918,147}},["timer-off"]={16898613869,{48,48},{563,820}},["arrow-big-right-dash"]={16898612629,{48,48},{49,918}},["radio-receiver"]={16898613699,{48,48},{404,820}},shield={16898613777,{48,48},{869,0}},["square-equal"]={16898613777,{48,48},{869,404}},backpack={16898612629,{48,48},{710,869}},download={16898613044,{48,48},{820,906}},["drafting-compass"]={16898613044,{48,48},{771,955}},youtube={16898613869,{48,48},{820,955}},["file-plus-2"]={16898613353,{48,48},{967,0}},["message-circle-more"]={16898613613,{48,48},{355,771}},["arrow-down-right"]={16898612629,{48,48},{820,661}},["loader-circle"]={16898613509,{48,48},{771,906}},receipt={16898613699,{48,48},{869,147}},["egg-off"]={16898613353,{48,48},{771,514}},bitcoin={16898612819,{48,48},{820,49}},["eye-off"]={16898613353,{48,48},{820,514}},factory={16898613353,{48,48},{514,820}},["fast-forward"]={16898613353,{48,48},{820,49}},["image-off"]={16898613509,{48,48},{453,771}},["file-audio-2"]={16898613353,{48,48},{820,306}},braces={16898612819,{48,48},{147,820}},cone={16898613044,{48,48},{820,196}},["wand-sparkles"]={16898613869,{48,48},{453,918}},["square-chevron-right"]={16898613777,{48,48},{918,98}},navigation={16898613613,{48,48},{771,759}},["file-check"]={16898613353,{48,48},{563,820}},["file-cog"]={16898613353,{48,48},{820,98}},["file-diff"]={16898613353,{48,48},{771,147}},["file-digit"]={16898613353,{48,48},{147,771}},["power-off"]={16898613699,{48,48},{918,49}},["align-vertical-distribute-center"]={16898612629,{48,48},{771,147}},["tally-1"]={16898613777,{48,48},{967,955}},ampersand={16898612629,{48,48},{404,771}},["line-chart"]={16898613509,{48,48},{196,918}},["shopping-cart"]={16898613777,{48,48},{869,257}},["align-vertical-justify-end"]={16898612629,{48,48},{0,918}},eraser={16898613353,{48,48},{820,257}},["alarm-smoke"]={16898612629,{48,48},{563,771}},["file-line-chart"]={16898613353,{48,48},{306,869}},["file-input"]={16898613353,{48,48},{869,306}},["clock-8"]={16898613044,{48,48},{869,563}},["server-cog"]={16898613699,{48,48},{967,906}},["cloud-cog"]={16898613044,{48,48},{661,771}},blend={16898612819,{48,48},{771,98}},["search-x"]={16898613699,{48,48},{967,808}},["radio-tower"]={16898613699,{48,48},{355,869}},["list-tree"]={16898613509,{48,48},{453,967}},droplet={16898613044,{48,48},{820,955}},heater={16898613509,{48,48},{612,820}},eye={16898613353,{48,48},{771,563}},battery={16898612629,{48,48},{967,857}},lamp={16898613509,{48,48},{869,661}},["link-2-off"]={16898613509,{48,48},{147,967}},["panel-top"]={16898613613,{48,48},{869,857}},["file-volume"]={16898613353,{48,48},{257,967}},["file-x-2"]={16898613353,{48,48},{918,563}},["circle-equal"]={16898613044,{48,48},{771,49}},["flag-triangle-left"]={16898613353,{48,48},{196,820}},flower={16898613353,{48,48},{820,710}},["fold-horizontal"]={16898613353,{48,48},{710,820}},["folder-closed"]={16898613353,{48,48},{918,147}},["folder-dot"]={16898613353,{48,48},{196,869}},["arrow-up-right"]={16898612629,{48,48},{918,147}},router={16898613699,{48,48},{355,967}},["leafy-green"]={16898613509,{48,48},{869,710}},["message-square-dot"]={16898613613,{48,48},{820,98}},focus={16898613353,{48,48},{771,759}},copyleft={16898613044,{48,48},{869,661}},["folder-x"]={16898613353,{48,48},{453,918}},["form-input"]={16898613353,{48,48},{820,808}},["minimize-2"]={16898613613,{48,48},{967,0}},regex={16898613699,{48,48},{306,967}},["gallery-horizontal"]={16898613353,{48,48},{918,759}},university={16898613869,{48,48},{967,514}},["gallery-vertical-end"]={16898613353,{48,48},{820,857}},["file-image"]={16898613353,{48,48},{918,257}},["at-sign"]={16898612629,{48,48},{453,869}},palette={16898613613,{48,48},{453,918}},["user-plus-2"]={16898613869,{48,48},{967,306}},["gallery-thumbnails"]={16898613353,{48,48},{869,808}},["arrow-down-right-from-circle"]={16898612629,{48,48},{918,563}},cpu={16898613044,{48,48},{196,869}},["split-square-horizontal"]={16898613777,{48,48},{98,869}},["thumbs-down"]={16898613869,{48,48},{820,306}},merge={16898613613,{48,48},{0,869}},ghost={16898613353,{48,48},{869,906}},["git-compare"]={16898613353,{48,48},{967,955}},["git-fork"]={16898613509,{48,48},{771,0}},hospital={16898613509,{48,48},{147,820}},["git-merge"]={16898613509,{48,48},{771,257}},["folder-edit"]={16898613353,{48,48},{98,967}},["thumbs-up"]={16898613869,{48,48},{771,355}},globe={16898613509,{48,48},{771,563}},palmtree={16898613613,{48,48},{404,967}},["bug-off"]={16898612819,{48,48},{355,869}},kanban={16898613509,{48,48},{49,967}},["thermometer-snowflake"]={16898613869,{48,48},{49,820}},apple={16898612629,{48,48},{563,869}},["wine-off"]={16898613869,{48,48},{771,906}},["graduation-cap"]={16898613509,{48,48},{869,0}},["hand-helping"]={16898613509,{48,48},{820,563}},hand={16898613509,{48,48},{563,820}},["square-bottom-dashed-scissors"]={16898613777,{48,48},{661,820}},stamp={16898613777,{48,48},{710,869}},["candy-off"]={16898612819,{48,48},{820,710}},["plug-zap-2"]={16898613699,{48,48},{820,355}},["heading-2"]={16898613509,{48,48},{918,257}},["square-activity"]={16898613777,{48,48},{869,355}},["circle-gauge"]={16898613044,{48,48},{0,820}},["cigarette-off"]={16898612819,{48,48},{710,967}},["arrow-up-0-1"]={16898612629,{48,48},{404,869}},["message-circle"]={16898613613,{48,48},{563,820}},["undo-2"]={16898613869,{48,48},{771,453}},headset={16898613509,{48,48},{257,918}},["heart-crack"]={16898613509,{48,48},{918,514}},["git-branch"]={16898613353,{48,48},{918,906}},shovel={16898613777,{48,48},{820,306}},share={16898613777,{48,48},{514,771}},["wallet-cards"]={16898613869,{48,48},{918,196}},["square-arrow-out-down-right"]={16898613777,{48,48},{306,918}},grip={16898613509,{48,48},{869,257}},["monitor-speaker"]={16898613613,{48,48},{869,355}},save={16898613699,{48,48},{918,453}},["cloud-snow"]={16898613044,{48,48},{98,869}},["file-question"]={16898613353,{48,48},{869,98}},["arrow-big-up-dash"]={16898612629,{48,48},{967,257}},coffee={16898613044,{48,48},{967,514}},["image-down"]={16898613509,{48,48},{820,404}},["beer-off"]={16898612819,{48,48},{771,257}},["file-bar-chart"]={16898613353,{48,48},{820,563}},["bar-chart-2"]={16898612629,{48,48},{967,710}},["lock-keyhole-open"]={16898613509,{48,48},{820,906}},["chevrons-down-up"]={16898612819,{48,48},{661,967}},["clipboard-plus"]={16898613044,{48,48},{820,98}},["monitor-up"]={16898613613,{48,48},{771,453}},["list-end"]={16898613509,{48,48},{918,710}},["square-radical"]={16898613777,{48,48},{196,869}},play={16898613699,{48,48},{918,257}},["chevrons-right"]={16898612819,{48,48},{967,710}},["file-badge-2"]={16898613353,{48,48},{306,820}},["message-square-reply"]={16898613613,{48,48},{918,257}},["corner-down-right"]={16898613044,{48,48},{710,820}},phone={16898613699,{48,48},{0,869}},["arrow-left-to-line"]={16898612629,{48,48},{147,869}},["lamp-wall-down"]={16898613509,{48,48},{967,563}},["link-2"]={16898613509,{48,48},{967,404}},["repeat"]={16898613699,{48,48},{820,710}},["ellipsis-vertical"]={16898613353,{48,48},{820,0}},snail={16898613777,{48,48},{820,612}},["paint-bucket"]={16898613613,{48,48},{196,918}},["square-parking"]={16898613777,{48,48},{771,759}},["align-horizontal-justify-end"]={16898612629,{48,48},{869,514}},lasso={16898613509,{48,48},{918,147}},["align-vertical-distribute-end"]={16898612629,{48,48},{147,771}},soup={16898613777,{48,48},{612,820}},airplay={16898612629,{48,48},{771,49}},["layout-dashboard"]={16898613509,{48,48},{967,355}},["heading-1"]={16898613509,{48,48},{0,918}},["circle-x"]={16898613044,{48,48},{820,306}},["monitor-x"]={16898613613,{48,48},{453,771}},["octagon-pause"]={16898613613,{48,48},{869,453}},["library-square"]={16898613509,{48,48},{771,808}},["square-pen"]={16898613777,{48,48},{710,820}},["heart-pulse"]={16898613509,{48,48},{771,661}},["database-backup"]={16898613044,{48,48},{820,759}},["gantt-chart"]={16898613353,{48,48},{869,857}},octagon={16898613613,{48,48},{404,918}},ticket={16898613869,{48,48},{612,771}},["message-square"]={16898613613,{48,48},{355,820}},["list-filter"]={16898613509,{48,48},{869,759}},["train-front"]={16898613869,{48,48},{404,771}},["spray-can"]={16898613777,{48,48},{967,257}},["list-music"]={16898613509,{48,48},{771,857}},["utility-pole"]={16898613869,{48,48},{196,869}},["list-plus"]={16898613509,{48,48},{661,967}},["screen-share"]={16898613699,{48,48},{710,967}},["file-clock"]={16898613353,{48,48},{514,869}},["list-collapse"]={16898613509,{48,48},{967,661}},gauge={16898613353,{48,48},{771,955}},store={16898613777,{48,48},{404,967}},["circle-arrow-down"]={16898612819,{48,48},{869,857}},["notebook-pen"]={16898613613,{48,48},{563,967}},["egg-fried"]={16898613353,{48,48},{257,771}},["calendar-off"]={16898612819,{48,48},{49,967}},["locate-off"]={16898613509,{48,48},{918,808}},["corner-right-up"]={16898613044,{48,48},{967,98}},locate={16898613509,{48,48},{869,857}},["ticket-x"]={16898613869,{48,48},{771,612}},["user-round-plus"]={16898613869,{48,48},{404,869}},["panel-left-close"]={16898613613,{48,48},{710,918}},["lock-keyhole"]={16898613509,{48,48},{771,955}},["lock-open"]={16898613509,{48,48},{967,808}},["user-round-minus"]={16898613869,{48,48},{453,820}},["m-square"]={16898613509,{48,48},{869,955}},magnet={16898613509,{48,48},{967,906}},["message-square-text"]={16898613613,{48,48},{820,355}},["mail-plus"]={16898613613,{48,48},{0,771}},["mail-search"]={16898613613,{48,48},{257,771}},move={16898613613,{48,48},{453,820}},["play-circle"]={16898613699,{48,48},{49,869}},["git-commit-vertical"]={16898613353,{48,48},{967,906}},slash={16898613777,{48,48},{918,257}},["map-pin-off"]={16898613613,{48,48},{0,820}},aperture={16898612629,{48,48},{771,661}},["image-plus"]={16898613509,{48,48},{404,820}},["message-circle-heart"]={16898613613,{48,48},{771,355}},syringe={16898613777,{48,48},{918,808}},info={16898613509,{48,48},{612,869}},["rows-3"]={16898613699,{48,48},{918,661}},check={16898612819,{48,48},{710,869}},["text-search"]={16898613869,{48,48},{869,0}},["square-slash"]={16898613777,{48,48},{967,355}},sandwich={16898613699,{48,48},{918,196}},["settings-2"]={16898613777,{48,48},{0,771}},["file-stack"]={16898613353,{48,48},{0,967}},["external-link"]={16898613353,{48,48},{257,820}},["ice-cream-2"]={16898613509,{48,48},{0,967}},["file-archive"]={16898613353,{48,48},{869,257}},["signal-high"]={16898613777,{48,48},{771,612}},inbox={16898613509,{48,48},{918,563}},["flip-horizontal-2"]={16898613353,{48,48},{355,918}},["traffic-cone"]={16898613869,{48,48},{820,355}},["file-signature"]={16898613353,{48,48},{147,820}},["align-horizontal-space-between"]={16898612629,{48,48},{612,771}},["message-circle-dashed"]={16898613613,{48,48},{820,306}},maximize={16898613613,{48,48},{771,563}},["database-zap"]={16898613044,{48,48},{771,808}},droplets={16898613044,{48,48},{967,857}},["fish-symbol"]={16898613353,{48,48},{918,98}},["message-circle-off"]={16898613613,{48,48},{306,820}},["wheat-off"]={16898613869,{48,48},{967,453}},["layout-list"]={16898613509,{48,48},{869,453}},["file-search"]={16898613353,{48,48},{196,771}},["download-cloud"]={16898613044,{48,48},{869,857}},["alarm-clock-plus"]={16898612629,{48,48},{306,771}},["circle-dollar-sign"]={16898613044,{48,48},{257,771}},usb={16898613869,{48,48},{563,918}},["arrow-up-square"]={16898612629,{48,48},{869,196}},["receipt-pound-sterling"]={16898613699,{48,48},{563,918}},scan={16898613699,{48,48},{967,196}},["heading-5"]={16898613509,{48,48},{771,404}},undo={16898613869,{48,48},{404,820}},["file-search-2"]={16898613353,{48,48},{771,196}},minimize={16898613613,{48,48},{918,49}},["redo-2"]={16898613699,{48,48},{49,967}},thermometer={16898613869,{48,48},{869,257}},["filter-x"]={16898613353,{48,48},{661,820}},["sliders-vertical"]={16898613777,{48,48},{771,404}},["boom-box"]={16898612819,{48,48},{967,0}},["table-2"]={16898613777,{48,48},{869,857}},["touchpad-off"]={16898613869,{48,48},{98,820}},["diamond-percent"]={16898613044,{48,48},{918,196}},brain={16898612819,{48,48},{967,257}},microwave={16898613613,{48,48},{661,771}},["arrow-down-left-square"]={16898612629,{48,48},{306,918}},["user-round-cog"]={16898613869,{48,48},{820,453}},["octagon-x"]={16898613613,{48,48},{453,869}},languages={16898613509,{48,48},{710,820}},["file-json-2"]={16898613353,{48,48},{820,355}},["alarm-clock-check"]={16898612629,{48,48},{0,820}},guitar={16898613509,{48,48},{771,355}},anchor={16898612629,{48,48},{306,869}},["text-cursor"]={16898613869,{48,48},{563,771}},["search-code"]={16898613699,{48,48},{820,906}},["square-parking-off"]={16898613777,{48,48},{820,710}},["notebook-text"]={16898613613,{48,48},{918,147}},["arrow-right-to-line"]={16898612629,{48,48},{820,453}},["ticket-minus"]={16898613869,{48,48},{306,820}},["tally-4"]={16898613869,{48,48},{771,257}},heading={16898613509,{48,48},{355,820}},wallpaper={16898613869,{48,48},{967,404}},["door-open"]={16898613044,{48,48},{967,759}},["arrow-down-circle"]={16898612629,{48,48},{453,771}},["monitor-play"]={16898613613,{48,48},{967,257}},["key-square"]={16898613509,{48,48},{918,355}},["monitor-off"]={16898613613,{48,48},{49,918}},["pocket-knife"]={16898613699,{48,48},{918,514}},["book-copy"]={16898612819,{48,48},{563,820}},["panel-left-inactive"]={16898613613,{48,48},{967,196}},["car-front"]={16898612819,{48,48},{563,967}},["file-video"]={16898613353,{48,48},{355,869}},["reply-all"]={16898613699,{48,48},{661,869}},["cloud-moon-rain"]={16898613044,{48,48},{869,98}},["zoom-out"]={16898613869,{48,48},{967,906}},["search-slash"]={16898613699,{48,48},{771,955}},["notepad-text-dashed"]={16898613613,{48,48},{196,869}},["circle-alert"]={16898612819,{48,48},{918,808}},briefcase={16898612819,{48,48},{771,453}},["list-start"]={16898613509,{48,48},{196,967}},["more-vertical"]={16898613613,{48,48},{967,514}},["a-large-small"]={16898612629,{48,48},{771,257}},tractor={16898613869,{48,48},{869,306}},waves={16898613869,{48,48},{820,808}},["folder-cog"]={16898613353,{48,48},{869,196}},["code-2"]={16898613044,{48,48},{453,771}},["clock-5"]={16898613044,{48,48},{306,869}},vote={16898613869,{48,48},{612,967}},["shield-question"]={16898613777,{48,48},{563,771}},["arrow-right-from-line"]={16898612629,{48,48},{967,306}},["flame-kindling"]={16898613353,{48,48},{49,967}},["square-power"]={16898613777,{48,48},{869,196}},["circle-help"]={16898613044,{48,48},{820,257}},["bring-to-front"]={16898612819,{48,48},{453,771}},["move-right"]={16898613613,{48,48},{49,967}},figma={16898613353,{48,48},{0,869}},["bell-plus"]={16898612819,{48,48},{49,771}},sailboat={16898613699,{48,48},{612,967}},["hard-drive-upload"]={16898613509,{48,48},{869,49}},["pie-chart"]={16898613699,{48,48},{869,514}},meh={16898613613,{48,48},{820,49}},["mail-warning"]={16898613613,{48,48},{771,514}},["music-3"]={16898613613,{48,48},{355,918}},["pause-circle"]={16898613613,{48,48},{967,955}},["panels-right-bottom"]={16898613613,{48,48},{771,955}},["file-edit"]={16898613353,{48,48},{49,869}},redo={16898613699,{48,48},{918,355}},["file-lock"]={16898613353,{48,48},{918,514}},["square-user"]={16898613777,{48,48},{967,612}},["circle-fading-plus"]={16898613044,{48,48},{49,771}},workflow={16898613869,{48,48},{967,759}},["undo-dot"]={16898613869,{48,48},{453,771}},target={16898613869,{48,48},{514,771}},tablets={16898613777,{48,48},{869,955}},radar={16898613699,{48,48},{820,404}},drama={16898613044,{48,48},{967,808}},["signal-medium"]={16898613777,{48,48},{563,820}},baseline={16898612629,{48,48},{869,857}},martini={16898613613,{48,48},{257,820}},contrast={16898613044,{48,48},{918,355}},pickaxe={16898613699,{48,48},{355,771}},["square-divide"]={16898613777,{48,48},{967,306}},["chevron-left-circle"]={16898612819,{48,48},{918,453}},["book-check"]={16898612819,{48,48},{612,771}},["scan-barcode"]={16898613699,{48,48},{918,710}},["book-lock"]={16898612819,{48,48},{98,820}},["panel-right-inactive"]={16898613613,{48,48},{918,759}},refrigerator={16898613699,{48,48},{355,918}},["divide-circle"]={16898613044,{48,48},{967,196}},["package-plus"]={16898613613,{48,48},{661,918}},["mic-2"]={16898613613,{48,48},{257,918}},["hop-off"]={16898613509,{48,48},{771,196}},warehouse={16898613869,{48,48},{967,661}},["plus-square"]={16898613699,{48,48},{306,869}},["square-arrow-out-up-left"]={16898613777,{48,48},{257,967}},["save-all"]={16898613699,{48,48},{967,404}},candy={16898612819,{48,48},{771,759}},["iteration-ccw"]={16898613509,{48,48},{918,98}},["corner-left-down"]={16898613044,{48,48},{661,869}},paintbrush={16898613613,{48,48},{918,453}},["cloud-lightning"]={16898613044,{48,48},{918,49}},["circle-slash-2"]={16898613044,{48,48},{771,98}},["layers-3"]={16898613509,{48,48},{147,918}},["credit-card"]={16898613044,{48,48},{98,967}},["ear-off"]={16898613044,{48,48},{918,955}},["git-commit-horizontal"]={16898613353,{48,48},{869,955}},["panel-bottom"]={16898613613,{48,48},{771,857}},["square-code"]={16898613777,{48,48},{820,196}},["panel-bottom-open"]={16898613613,{48,48},{820,808}},["kanban-square-dashed"]={16898613509,{48,48},{147,869}},["circle-pause"]={16898613044,{48,48},{771,563}},["panel-top-close"]={16898613613,{48,48},{771,906}},ambulance={16898612629,{48,48},{771,404}},["trending-up"]={16898613869,{48,48},{514,918}},["bookmark-x"]={16898612819,{48,48},{563,869}},["clock-9"]={16898613044,{48,48},{820,612}},pen={16898613699,{48,48},{771,49}},["smartphone-nfc"]={16898613777,{48,48},{306,869}},["candy-cane"]={16898612819,{48,48},{869,661}},unlink={16898613869,{48,48},{869,612}},["parking-meter"]={16898613613,{48,48},{918,906}},["gamepad-2"]={16898613353,{48,48},{710,967}},["user-round-search"]={16898613869,{48,48},{355,918}},["parking-square"]={16898613613,{48,48},{967,906}},["paw-print"]={16898613699,{48,48},{771,257}},["arrow-down-right-square"]={16898612629,{48,48},{869,612}},["square-split-vertical"]={16898613777,{48,48},{869,453}},["circle-off"]={16898613044,{48,48},{306,771}},dessert={16898613044,{48,48},{612,967}},eclipse={16898613353,{48,48},{771,257}},squirrel={16898613777,{48,48},{771,808}},["percent-circle"]={16898613699,{48,48},{306,771}},cylinder={16898613044,{48,48},{869,710}},["badge-japanese-yen"]={16898612629,{48,48},{453,918}},["circle-divide"]={16898613044,{48,48},{771,257}},["receipt-text"]={16898613699,{48,48},{918,98}},["square-pi"]={16898613777,{48,48},{612,918}},["align-center-horizontal"]={16898612629,{48,48},{98,771}},["phone-off"]={16898613699,{48,48},{98,771}},["pi-square"]={16898613699,{48,48},{869,257}},["file-output"]={16898613353,{48,48},{661,771}},["disc-album"]={16898613044,{48,48},{710,918}},["percent-square"]={16898613699,{48,48},{820,514}},clapperboard={16898613044,{48,48},{257,869}},captions={16898612819,{48,48},{612,918}},["wallet-minimal"]={16898613869,{48,48},{196,918}},layers={16898613509,{48,48},{98,967}},["umbrella-off"]={16898613869,{48,48},{918,306}},["badge-alert"]={16898612629,{48,48},{661,918}},["arrow-down-left-from-circle"]={16898612629,{48,48},{355,869}},["folder-pen"]={16898613353,{48,48},{710,869}},cross={16898613044,{48,48},{869,453}},["alarm-check"]={16898612629,{48,48},{49,771}},["chevron-right"]={16898612819,{48,48},{869,759}},pill={16898613699,{48,48},{563,820}},["square-arrow-down-left"]={16898613777,{48,48},{820,404}},["share-2"]={16898613777,{48,48},{771,514}},["arrow-up-from-dot"]={16898612629,{48,48},{869,661}},["pin-off"]={16898613699,{48,48},{514,869}},["align-vertical-justify-start"]={16898612629,{48,48},{918,257}},combine={16898613044,{48,48},{612,869}},["tv-2"]={16898613869,{48,48},{147,820}},mountain={16898613613,{48,48},{869,612}},cast={16898612819,{48,48},{869,453}},["indent-increase"]={16898613509,{48,48},{820,661}},currency={16898613044,{48,48},{918,661}},["shield-ban"]={16898613777,{48,48},{0,820}},["message-circle-reply"]={16898613613,{48,48},{820,563}},["corner-left-up"]={16898613044,{48,48},{612,918}},["triangle-right"]={16898613869,{48,48},{918,49}},["folder-clock"]={16898613353,{48,48},{967,98}},link={16898613509,{48,48},{918,453}},["pound-sterling"]={16898613699,{48,48},{514,918}},type={16898613869,{48,48},{967,257}},webhook={16898613869,{48,48},{967,196}},barcode={16898612629,{48,48},{918,808}},["shopping-bag"]={16898613777,{48,48},{49,820}},bed={16898612819,{48,48},{771,0}},["panel-right-open"]={16898613613,{48,48},{869,808}},["pointer-off"]={16898613699,{48,48},{771,661}},turtle={16898613869,{48,48},{196,771}},camera={16898612819,{48,48},{967,563}},scissors={16898613699,{48,48},{820,857}},["user-minus-2"]={16898613869,{48,48},{98,918}},["git-pull-request"]={16898613509,{48,48},{49,771}},["bluetooth-searching"]={16898612819,{48,48},{820,306}},["arrow-up-to-line"]={16898612629,{48,48},{196,869}},drill={16898613044,{48,48},{869,906}},["file-check-2"]={16898613353,{48,48},{612,771}},["badge-percent"]={16898612629,{48,48},{967,661}},shuffle={16898613777,{48,48},{257,869}},radiation={16898613699,{48,48},{771,453}},radical={16898613699,{48,48},{453,771}},microscope={16898613613,{48,48},{771,661}},["message-circle-x"]={16898613613,{48,48},{612,771}},box={16898612819,{48,48},{771,196}},["align-left"]={16898612629,{48,48},{514,869}},["switch-camera"]={16898613777,{48,48},{771,906}},["file-heart"]={16898613353,{48,48},{0,918}},cat={16898612819,{48,48},{404,918}},space={16898613777,{48,48},{563,869}},["rectangle-vertical"]={16898613699,{48,48},{147,869}},["clipboard-signature"]={16898613044,{48,48},{771,147}},["arrow-up-circle"]={16898612629,{48,48},{967,563}},["corner-up-left"]={16898613044,{48,48},{918,147}},["clock-6"]={16898613044,{48,48},{257,918}},["candlestick-chart"]={16898612819,{48,48},{918,612}},["key-round"]={16898613509,{48,48},{967,306}},headphones={16898613509,{48,48},{306,869}},tv={16898613869,{48,48},{98,869}},["book-minus"]={16898612819,{48,48},{0,918}},["bar-chart-horizontal-big"]={16898612629,{48,48},{771,906}},rss={16898613699,{48,48},{771,808}},["user-round-x"]={16898613869,{48,48},{306,967}},highlighter={16898613509,{48,48},{918,49}},["rocking-chair"]={16898613699,{48,48},{869,196}},["square-arrow-out-down-left"]={16898613777,{48,48},{355,869}},music={16898613613,{48,48},{967,563}},handshake={16898613509,{48,48},{514,869}},["check-circle"]={16898612819,{48,48},{869,710}},tornado={16898613869,{48,48},{771,147}},["copy-plus"]={16898613044,{48,48},{355,918}},["folder-git"]={16898613353,{48,48},{918,404}},["triangle-alert"]={16898613869,{48,48},{967,0}},shrink={16898613777,{48,48},{355,771}},sofa={16898613777,{48,48},{661,771}},["school-2"]={16898613699,{48,48},{967,453}},["search-check"]={16898613699,{48,48},{869,857}},crop={16898613044,{48,48},{918,404}},["columns-2"]={16898613044,{48,48},{820,661}},["mouse-pointer-square"]={16898613613,{48,48},{661,820}},["flask-conical-off"]={16898613353,{48,48},{820,453}},milestone={16898613613,{48,48},{612,820}},["wand-2"]={16898613869,{48,48},{918,453}},["square-dot"]={16898613777,{48,48},{918,355}},["badge-minus"]={16898612629,{48,48},{404,967}},["cloud-fog"]={16898613044,{48,48},{514,918}},["milk-off"]={16898613613,{48,48},{563,869}},bone={16898612819,{48,48},{869,514}},["percent-diamond"]={16898613699,{48,48},{257,820}},["package-check"]={16898613613,{48,48},{820,759}},["chevron-first"]={16898612819,{48,48},{147,967}},pencil={16898613699,{48,48},{820,257}},["shield-minus"]={16898613777,{48,48},{257,820}},["list-x"]={16898613509,{48,48},{918,759}},["stretch-horizontal"]={16898613777,{48,48},{967,661}},["panel-left-open"]={16898613613,{48,48},{196,967}},["corner-up-right"]={16898613044,{48,48},{869,196}},["repeat-2"]={16898613699,{48,48},{869,661}},pin={16898613699,{48,48},{918,0}},["mail-question"]={16898613613,{48,48},{771,257}},gift={16898613353,{48,48},{820,955}},["badge-indian-rupee"]={16898612629,{48,48},{967,404}},smartphone={16898613777,{48,48},{257,918}},["redo-dot"]={16898613699,{48,48},{967,306}},["users-round"]={16898613869,{48,48},{563,967}},["align-start-horizontal"]={16898612629,{48,48},{869,49}},["message-square-warning"]={16898613613,{48,48},{771,404}},["file-plus"]={16898613353,{48,48},{918,49}},["git-pull-request-arrow"]={16898613509,{48,48},{257,771}},webcam={16898613869,{48,48},{710,918}},["arrow-down-to-dot"]={16898612629,{48,48},{710,771}},["bell-dot"]={16898612819,{48,48},{771,514}},["folder-down"]={16898613353,{48,48},{147,918}},church={16898612819,{48,48},{771,906}},["square-play"]={16898613777,{48,48},{967,98}},["badge-x"]={16898612629,{48,48},{710,918}},server={16898613777,{48,48},{771,0}},["phone-forwarded"]={16898613699,{48,48},{869,0}},diamond={16898613044,{48,48},{196,918}},blinds={16898612819,{48,48},{98,771}},["user-square"]={16898613869,{48,48},{820,710}},package={16898613613,{48,48},{918,196}},["alarm-clock-off"]={16898612629,{48,48},{771,306}},["table-cells-merge"]={16898613777,{48,48},{820,906}},["helping-hand"]={16898613509,{48,48},{514,918}},recycle={16898613699,{48,48},{98,918}},["mountain-snow"]={16898613613,{48,48},{918,563}},luggage={16898613509,{48,48},{918,906}},["divide-square"]={16898613044,{48,48},{196,967}},["bot-message-square"]={16898612819,{48,48},{918,49}},["phone-outgoing"]={16898613699,{48,48},{49,820}},["smartphone-charging"]={16898613777,{48,48},{355,820}},["panel-left"]={16898613613,{48,48},{967,453}},["train-track"]={16898613869,{48,48},{355,820}},["bookmark-minus"]={16898612819,{48,48},{661,771}},["tablet-smartphone"]={16898613777,{48,48},{967,857}},["fire-extinguisher"]={16898613353,{48,48},{514,967}},sigma={16898613777,{48,48},{820,563}},["shield-half"]={16898613777,{48,48},{306,771}},terminal={16898613869,{48,48},{820,257}},shapes={16898613777,{48,48},{257,771}},["bell-ring"]={16898612819,{48,48},{0,820}},["tower-control"]={16898613869,{48,48},{0,918}},["arrow-down-1-0"]={16898612629,{48,48},{820,404}},users={16898613869,{48,48},{967,98}},scroll={16898613699,{48,48},{918,808}},["arrow-left-right"]={16898612629,{48,48},{820,196}},["lightbulb-off"]={16898613509,{48,48},{967,147}},["panels-top-left"]={16898613613,{48,48},{967,808}},beaker={16898612629,{48,48},{918,906}},["message-square-share"]={16898613613,{48,48},{869,306}},annoyed={16898612629,{48,48},{918,514}},["test-tube"]={16898613869,{48,48},{257,820}},["user-circle"]={16898613869,{48,48},{820,196}},["cooking-pot"]={16898613044,{48,48},{820,453}},["between-horizontal-start"]={16898612819,{48,48},{306,771}},fullscreen={16898613353,{48,48},{967,453}},["circuit-board"]={16898613044,{48,48},{355,771}},["grid-3x3"]={16898613509,{48,48},{98,771}},["mail-open"]={16898613613,{48,48},{771,0}},["square-function"]={16898613777,{48,48},{820,453}},["arrow-up-left-from-circle"]={16898612629,{48,48},{771,759}},variable={16898613869,{48,48},{147,918}},["arrow-up-right-square"]={16898612629,{48,48},{967,98}},["pen-line"]={16898613699,{48,48},{771,514}}},["256px"]={["align-vertical-distribute-center"]={16898613509,{256,256},{514,0}},["chevron-down"]={16898617411,{256,256},{514,257}},["list-restart"]={16898674572,{256,256},{257,257}},["table-cells-split"]={16898787819,{256,256},{514,0}},gavel={16898672166,{256,256},{514,257}},["dna-off"]={16898669271,{256,256},{514,514}},["refresh-ccw-dot"]={16898733036,{256,256},{257,514}},bean={16898615374,{256,256},{257,0}},["arrow-up-right-from-circle"]={16898614410,{256,256},{514,257}},["table-columns-split"]={16898787819,{256,256},{257,257}},bolt={16898615799,{256,256},{0,514}},heater={16898673271,{256,256},{257,0}},feather={16898669897,{256,256},{0,514}},["align-horizontal-distribute-center"]={16898613044,{256,256},{514,514}},["align-center"]={16898613044,{256,256},{0,514}},["grip-vertical"]={16898672700,{256,256},{514,0}},["person-standing"]={16898731539,{256,256},{257,257}},["badge-swiss-franc"]={16898615022,{256,256},{514,0}},["between-horizontal-end"]={16898615428,{256,256},{514,257}},["rotate-cw"]={16898733415,{256,256},{514,0}},framer={16898671684,{256,256},{514,514}},["bus-front"]={16898616879,{256,256},{0,514}},["shield-ellipsis"]={16898734564,{256,256},{514,0}},["file-lock-2"]={16898670241,{256,256},{0,0}},["between-vertical-end"]={16898615428,{256,256},{514,514}},["globe-lock"]={16898672599,{256,256},{514,0}},tags={16898788033,{256,256},{514,0}},["concierge-bell"]={16898619347,{256,256},{257,0}},["user-square"]={16898790047,{256,256},{514,257}},["arrow-left-square"]={16898614166,{256,256},{257,257}},["file-down"]={16898670072,{256,256},{514,514}},["picture-in-picture"]={16898731683,{256,256},{514,514}},["messages-square"]={16898728402,{256,256},{257,514}},["touchpad-off"]={16898788908,{256,256},{257,0}},["user-round-cog"]={16898789825,{256,256},{257,514}},["chevron-up-circle"]={16898617509,{256,256},{514,257}},["server-crash"]={16898734242,{256,256},{514,514}},["heading-3"]={16898672954,{256,256},{257,514}},squircle={16898736597,{256,256},{0,514}},["wifi-off"]={16898790996,{256,256},{257,514}},["sun-medium"]={16898736967,{256,256},{514,257}},["message-square"]={16898728402,{256,256},{514,257}},["cloud-download"]={16898618763,{256,256},{0,257}},["sigma-square"]={16898734792,{256,256},{257,257}},["folder-plus"]={16898671463,{256,256},{257,0}},["hard-drive-download"]={16898672829,{256,256},{257,514}},["scatter-chart"]={16898733817,{256,256},{257,257}},pointer={16898732061,{256,256},{514,514}},["circle-alert"]={16898617705,{256,256},{514,0}},["chevrons-up-down"]={16898617626,{256,256},{514,257}},["iteration-cw"]={16898673616,{256,256},{0,0}},["rail-symbol"]={16898732665,{256,256},{0,514}},["message-circle-more"]={16898675752,{256,256},{0,257}},parentheses={16898731166,{256,256},{257,514}},["book-up-2"]={16898616524,{256,256},{0,0}},flame={16898670919,{256,256},{0,257}},["chevrons-up"]={16898617626,{256,256},{257,514}},["chevron-right-square"]={16898617509,{256,256},{257,257}},["square-mouse-pointer"]={16898736237,{256,256},{257,0}},superscript={16898787671,{256,256},{514,0}},tag={16898788033,{256,256},{0,257}},["file-warning"]={16898670620,{256,256},{0,257}},hexagon={16898673271,{256,256},{257,257}},["navigation-2-off"]={16898730065,{256,256},{257,0}},["eye-off"]={16898669772,{256,256},{514,514}},["arrows-up-from-line"]={16898614574,{256,256},{0,514}},["square-gantt-chart"]={16898736072,{256,256},{257,257}},["square-chevron-left"]={16898735845,{256,256},{257,0}},scaling={16898733674,{256,256},{0,514}},["inspection-panel"]={16898673523,{256,256},{0,514}},["arrow-left-from-line"]={16898614166,{256,256},{0,257}},["signal-medium"]={16898734792,{256,256},{514,514}},["ticket-percent"]={16898788660,{256,256},{257,514}},["arrow-right-square"]={16898614275,{256,256},{257,0}},["calendar-clock"]={16898616953,{256,256},{0,514}},x={16898791349,{256,256},{257,0}},voicemail={16898790439,{256,256},{514,514}},presentation={16898732262,{256,256},{257,514}},["tree-palm"]={16898789012,{256,256},{0,514}},badge={16898615022,{256,256},{0,514}},["captions-off"]={16898617146,{256,256},{514,514}},["align-vertical-justify-center"]={16898613509,{256,256},{514,257}},theater={16898788479,{256,256},{514,514}},tent={16898788248,{256,256},{257,257}},["repeat-1"]={16898733146,{256,256},{0,514}},stethoscope={16898736776,{256,256},{257,257}},["screen-share-off"]={16898734065,{256,256},{0,257}},["arrow-big-up"]={16898613777,{256,256},{514,514}},["volume-x"]={16898790615,{256,256},{0,257}},["mouse-pointer-click"]={16898729337,{256,256},{0,514}},["square-m"]={16898736072,{256,256},{257,514}},["hard-hat"]={16898672954,{256,256},{257,0}},["package-minus"]={16898730417,{256,256},{257,514}},["iteration-ccw"]={16898673523,{256,256},{514,514}},pipette={16898731819,{256,256},{257,514}},["flip-horizontal"]={16898671019,{256,256},{0,0}},["alert-circle"]={16898613044,{256,256},{0,0}},unplug={16898789644,{256,256},{0,0}},["badge-cent"]={16898614755,{256,256},{514,514}},["check-square-2"]={16898617325,{256,256},{514,514}},["monitor-check"]={16898728878,{256,256},{257,257}},trello={16898789012,{256,256},{514,514}},["paintbrush-2"]={16898730641,{256,256},{514,257}},["bar-chart-horizontal"]={16898615143,{256,256},{514,257}},["book-open-text"]={16898616322,{256,256},{257,257}},["parking-meter"]={16898731301,{256,256},{257,0}},cat={16898617325,{256,256},{514,0}},["heart-handshake"]={16898673115,{256,256},{514,257}},trees={16898789012,{256,256},{257,514}},ham={16898672700,{256,256},{257,514}},text={16898788479,{256,256},{257,514}},["circle-pause"]={16898617944,{256,256},{0,514}},["chevron-up-square"]={16898617509,{256,256},{257,514}},rat={16898732665,{256,256},{257,514}},["separator-horizontal"]={16898734242,{256,256},{0,514}},ambulance={16898613613,{256,256},{0,257}},["signal-zero"]={16898734905,{256,256},{0,0}},citrus={16898618228,{256,256},{0,0}},["phone-missed"]={16898731539,{256,256},{514,514}},["calendar-off"]={16898617053,{256,256},{0,257}},["battery-medium"]={16898615240,{256,256},{0,514}},["square-minus"]={16898736237,{256,256},{0,0}},hotel={16898673358,{256,256},{0,257}},["folder-output"]={16898671263,{256,256},{514,514}},["ice-cream"]={16898673358,{256,256},{257,514}},menu={16898675673,{256,256},{514,257}},["arrow-up-left-square"]={16898614410,{256,256},{514,0}},["image-down"]={16898673358,{256,256},{514,514}},terminal={16898788248,{256,256},{514,257}},angry={16898613613,{256,256},{514,257}},outdent={16898730417,{256,256},{257,257}},["circle-dot-dashed"]={16898617884,{256,256},{514,0}},speech={16898735455,{256,256},{257,0}},["cake-slice"]={16898616953,{256,256},{0,0}},["git-graph"]={16898672316,{256,256},{514,514}},armchair={16898613777,{256,256},{0,0}},["qr-code"]={16898732504,{256,256},{257,257}},copy={16898619423,{256,256},{257,514}},goal={16898672599,{256,256},{0,514}},["trending-down"]={16898789153,{256,256},{0,0}},["creative-commons"]={16898668482,{256,256},{257,0}},nfc={16898730065,{256,256},{257,514}},pickaxe={16898731683,{256,256},{514,257}},car={16898617249,{256,256},{514,0}},["notebook-tabs"]={16898730298,{256,256},{0,0}},ear={16898669689,{256,256},{0,257}},videotape={16898790439,{256,256},{514,257}},["sun-moon"]={16898736967,{256,256},{257,514}},calendar={16898617146,{256,256},{0,0}},["minus-circle"]={16898728878,{256,256},{257,0}},["arrow-down-left-from-circle"]={16898613869,{256,256},{0,514}},gift={16898672316,{256,256},{0,0}},["message-square-heart"]={16898675863,{256,256},{0,514}},["rectangle-ellipsis"]={16898733036,{256,256},{0,0}},["badge-plus"]={16898615022,{256,256},{0,0}},["indian-rupee"]={16898673523,{256,256},{0,257}},["monitor-dot"]={16898728878,{256,256},{0,514}},delete={16898668755,{256,256},{514,257}},["clipboard-pen-line"]={16898618228,{256,256},{514,514}},["folder-search"]={16898671463,{256,256},{257,257}},["utensils-crossed"]={16898790259,{256,256},{257,257}},["arrow-up"]={16898614574,{256,256},{257,257}},["arrow-up-from-dot"]={16898614410,{256,256},{0,0}},["flask-round"]={16898670919,{256,256},{257,514}},pause={16898731301,{256,256},{257,514}},shrub={16898734792,{256,256},{0,257}},flag={16898670919,{256,256},{0,0}},underline={16898789303,{256,256},{514,257}},["align-horizontal-distribute-end"]={16898613353,{256,256},{0,0}},newspaper={16898730065,{256,256},{514,257}},table={16898787819,{256,256},{257,514}},["move-vertical"]={16898729752,{256,256},{257,257}},["file-pen-line"]={16898670241,{256,256},{514,257}},["badge-russian-ruble"]={16898615022,{256,256},{0,257}},radius={16898732665,{256,256},{257,257}},["loader-2"]={16898674684,{256,256},{0,257}},pilcrow={16898731819,{256,256},{514,0}},["corner-left-up"]={16898668288,{256,256},{257,257}},spade={16898735175,{256,256},{514,257}},["folder-cog"]={16898671139,{256,256},{514,0}},["flip-vertical"]={16898671019,{256,256},{0,257}},["square-arrow-down"]={16898735593,{256,256},{257,257}},["circle-plus"]={16898617944,{256,256},{514,514}},view={16898790439,{256,256},{257,514}},cctv={16898617325,{256,256},{257,257}},["more-horizontal"]={16898729337,{256,256},{0,0}},rows={16898733534,{256,256},{257,0}},["pause-octagon"]={16898731301,{256,256},{514,257}},["circle-arrow-left"]={16898617705,{256,256},{0,514}},volume={16898790615,{256,256},{514,0}},facebook={16898669897,{256,256},{257,0}},["octagon-alert"]={16898730298,{256,256},{257,514}},["panel-bottom-dashed"]={16898730821,{256,256},{0,257}},["book-a"]={16898615799,{256,256},{514,514}},["align-end-vertical"]={16898613044,{256,256},{257,514}},["user-x-2"]={16898790047,{256,256},{257,514}},chrome={16898617626,{256,256},{514,514}},["receipt-japanese-yen"]={16898732855,{256,256},{514,0}},rabbit={16898732504,{256,256},{514,257}},["scissors-square"]={16898734065,{256,256},{0,0}},["check-square"]={16898617411,{256,256},{0,0}},["train-front-tunnel"]={16898788908,{256,256},{257,514}},["panel-left-dashed"]={16898730821,{256,256},{257,514}},["dice-4"]={16898669042,{256,256},{0,514}},["message-circle-x"]={16898675752,{256,256},{514,514}},["folder-x"]={16898671684,{256,256},{0,0}},["message-circle-warning"]={16898675752,{256,256},{257,514}},map={16898675359,{256,256},{0,514}},move={16898729752,{256,256},{0,514}},["arrow-up-left"]={16898614410,{256,256},{257,257}},award={16898614755,{256,256},{0,257}},["arrow-down-wide-narrow"]={16898614020,{256,256},{257,514}},["unfold-horizontal"]={16898789451,{256,256},{257,0}},["area-chart"]={16898613699,{256,256},{514,514}},["music-4"]={16898729752,{256,256},{514,514}},["shield-x"]={16898734664,{256,256},{0,0}},["plane-landing"]={16898731919,{256,256},{0,0}},["disc-3"]={16898669271,{256,256},{0,257}},["columns-4"]={16898619182,{256,256},{514,0}},["archive-x"]={16898613699,{256,256},{514,257}},["square-dashed-kanban"]={16898735845,{256,256},{257,514}},["mouse-pointer-2"]={16898729337,{256,256},{257,257}},["shield-off"]={16898734564,{256,256},{514,257}},compass={16898619182,{256,256},{257,514}},vegan={16898790439,{256,256},{0,0}},["message-circle-plus"]={16898675752,{256,256},{257,257}},["stop-circle"]={16898736776,{256,256},{257,514}},nut={16898730298,{256,256},{514,257}},search={16898734242,{256,256},{257,0}},files={16898670620,{256,256},{514,257}},["send-to-back"]={16898734242,{256,256},{514,0}},["alarm-clock"]={16898612819,{256,256},{257,257}},["shopping-basket"]={16898734664,{256,256},{514,257}},send={16898734242,{256,256},{257,257}},["chevron-left-square"]={16898617509,{256,256},{257,0}},["terminal-square"]={16898788248,{256,256},{0,514}},["square-arrow-out-down-left"]={16898735593,{256,256},{514,257}},["skip-back"]={16898734905,{256,256},{0,514}},["zoom-in"]={16898791349,{256,256},{0,514}},["file-scan"]={16898670367,{256,256},{514,0}},["message-square-dashed"]={16898675863,{256,256},{0,257}},trophy={16898789153,{256,256},{0,514}},umbrella={16898789303,{256,256},{0,514}},touchpad={16898788908,{256,256},{0,257}},["clipboard-copy"]={16898618228,{256,256},{514,0}},["map-pin-off"]={16898675359,{256,256},{0,257}},headset={16898673115,{256,256},{257,257}},["circle-chevron-up"]={16898617803,{256,256},{514,514}},["align-vertical-space-between"]={16898613613,{256,256},{257,0}},["lamp-desk"]={16898673794,{256,256},{514,0}},["circle-arrow-up"]={16898617803,{256,256},{0,257}},zap={16898791349,{256,256},{257,257}},["triangle-alert"]={16898789153,{256,256},{0,257}},["swiss-franc"]={16898787671,{256,256},{0,514}},["move-left"]={16898729572,{256,256},{514,514}},["chevron-up"]={16898617509,{256,256},{514,514}},instagram={16898673523,{256,256},{514,257}},["pen-tool"]={16898731419,{256,256},{514,0}},["pencil-ruler"]={16898731419,{256,256},{514,257}},dna={16898669433,{256,256},{0,0}},["arrow-big-down-dash"]={16898613777,{256,256},{257,0}},["clipboard-edit"]={16898618228,{256,256},{257,257}},mic={16898728659,{256,256},{0,257}},["folder-search-2"]={16898671463,{256,256},{514,0}},gitlab={16898672450,{256,256},{514,514}},["rotate-3d"]={16898733317,{256,256},{514,514}},["spell-check"]={16898735455,{256,256},{514,0}},popcorn={16898732262,{256,256},{0,0}},blocks={16898615570,{256,256},{514,514}},["washing-machine"]={16898790791,{256,256},{0,514}},["badge-minus"]={16898614945,{256,256},{257,514}},["cloud-sun"]={16898618899,{256,256},{0,514}},circle={16898618049,{256,256},{257,514}},["shield-alert"]={16898734564,{256,256},{0,0}},rainbow={16898732665,{256,256},{514,257}},["separator-vertical"]={16898734242,{256,256},{514,257}},ampersands={16898613613,{256,256},{257,257}},["user-search"]={16898790047,{256,256},{257,257}},fence={16898669897,{256,256},{514,257}},["square-user-round"]={16898736597,{256,256},{257,0}},sunrise={16898787671,{256,256},{257,0}},strikethrough={16898736967,{256,256},{0,257}},["calendar-days"]={16898616953,{256,256},{514,257}},["dollar-sign"]={16898669433,{256,256},{514,0}},puzzle={16898732504,{256,256},{0,257}},["list-minus"]={16898674572,{256,256},{0,0}},["sun-dim"]={16898736967,{256,256},{0,514}},upload={16898789644,{256,256},{0,257}},["app-window-mac"]={16898613699,{256,256},{0,257}},ellipsis={16898669772,{256,256},{257,0}},["copy-check"]={16898619423,{256,256},{0,257}},history={16898673271,{256,256},{514,257}},satellite={16898733674,{256,256},{0,0}},["bookmark-plus"]={16898616524,{256,256},{257,514}},["folder-key"]={16898671263,{256,256},{514,0}},["lamp-ceiling"]={16898673794,{256,256},{0,257}},["circle-power"]={16898618049,{256,256},{0,0}},hourglass={16898673358,{256,256},{514,0}},["folder-git"]={16898671139,{256,256},{514,514}},bomb={16898615799,{256,256},{514,257}},["layers-2"]={16898673999,{256,256},{514,514}},["battery-full"]={16898615240,{256,256},{514,0}},["user-minus"]={16898789825,{256,256},{514,0}},["x-octagon"]={16898791187,{256,256},{514,514}},["folder-tree"]={16898671463,{256,256},{257,514}},command={16898619182,{256,256},{514,257}},regex={16898733146,{256,256},{514,0}},hand={16898672829,{256,256},{0,514}},["chevrons-down"]={16898617626,{256,256},{257,0}},["bluetooth-off"]={16898615799,{256,256},{257,0}},["music-2"]={16898729752,{256,256},{514,257}},book={16898616524,{256,256},{257,257}},hammer={16898672700,{256,256},{514,514}},["circle-minus"]={16898617944,{256,256},{257,0}},["audio-waveform"]={16898614755,{256,256},{257,0}},["moon-star"]={16898729141,{256,256},{257,514}},["arrow-down-narrow-wide"]={16898613869,{256,256},{514,514}},sparkle={16898735175,{256,256},{257,514}},wand={16898790791,{256,256},{514,0}},["calendar-minus-2"]={16898617053,{256,256},{0,0}},["copy-minus"]={16898619423,{256,256},{514,0}},["folder-input"]={16898671263,{256,256},{257,0}},["book-image"]={16898616080,{256,256},{257,514}},shirt={16898734664,{256,256},{257,257}},["server-off"]={16898734421,{256,256},{0,0}},["move-up"]={16898729752,{256,256},{514,0}},["plug-2"]={16898731919,{256,256},{514,257}},radio={16898732665,{256,256},{514,0}},brackets={16898616650,{256,256},{514,514}},["calendar-heart"]={16898616953,{256,256},{514,514}},["list-ordered"]={16898674572,{256,256},{0,257}},["mic-off"]={16898728659,{256,256},{0,0}},["arrow-big-left"]={16898613777,{256,256},{257,257}},["square-split-horizontal"]={16898736398,{256,256},{514,257}},clover={16898619015,{256,256},{0,0}},["sun-snow"]={16898736967,{256,256},{514,514}},["user-2"]={16898789644,{256,256},{257,257}},["help-circle"]={16898673271,{256,256},{0,257}},["clock-2"]={16898618583,{256,256},{257,0}},["calendar-fold"]={16898616953,{256,256},{257,514}},["fish-off"]={16898670775,{256,256},{514,0}},baby={16898614755,{256,256},{0,514}},leaf={16898674337,{256,256},{0,0}},["fold-vertical"]={16898671019,{256,256},{257,514}},hop={16898673358,{256,256},{0,0}},["phone-incoming"]={16898731539,{256,256},{257,514}},cigarette={16898617705,{256,256},{0,257}},minus={16898728878,{256,256},{514,0}},["smile-plus"]={16898735040,{256,256},{514,514}},["folder-edit"]={16898671139,{256,256},{514,257}},["star-off"]={16898736776,{256,256},{0,0}},["git-pull-request-closed"]={16898672450,{256,256},{0,257}},["badge-check"]={16898614945,{256,256},{0,0}},["test-tube-2"]={16898788248,{256,256},{257,514}},["kanban-square"]={16898673616,{256,256},{257,257}},["plug-zap"]={16898731919,{256,256},{514,514}},["heading-4"]={16898672954,{256,256},{514,514}},["git-pull-request-create"]={16898672450,{256,256},{257,257}},["replace-all"]={16898733146,{256,256},{514,514}},["receipt-swiss-franc"]={16898732855,{256,256},{514,257}},["square-dashed-bottom-code"]={16898735845,{256,256},{0,514}},["clock-7"]={16898618583,{256,256},{514,257}},["scan-text"]={16898733817,{256,256},{0,257}},["shower-head"]={16898734792,{256,256},{0,0}},["equal-not"]={16898669772,{256,256},{0,257}},["sliders-horizontal"]={16898735040,{256,256},{0,257}},["ticket-slash"]={16898788789,{256,256},{0,0}},ruler={16898733534,{256,256},{514,0}},["circle-user-round"]={16898618049,{256,256},{257,257}},["list-filter"]={16898674482,{256,256},{514,514}},["alarm-minus"]={16898612819,{256,256},{0,514}},["egg-off"]={16898669689,{256,256},{257,514}},cog={16898619015,{256,256},{514,514}},dog={16898669433,{256,256},{0,257}},swords={16898787671,{256,256},{514,514}},["panel-right-dashed"]={16898731024,{256,256},{514,0}},["ship-wheel"]={16898734664,{256,256},{0,257}},bot={16898616650,{256,256},{514,0}},["trash-2"]={16898789012,{256,256},{0,257}},["chevron-down-square"]={16898617411,{256,256},{0,514}},["panel-left-open"]={16898731024,{256,256},{0,0}},["file-symlink"]={16898670469,{256,256},{257,0}},["clipboard-paste"]={16898618228,{256,256},{257,514}},["chevron-last"]={16898617411,{256,256},{514,514}},["book-heart"]={16898616080,{256,256},{514,257}},["circle-parking"]={16898617944,{256,256},{257,257}},["panel-left"]={16898731024,{256,256},{257,0}},["message-circle-off"]={16898675752,{256,256},{514,0}},speaker={16898735455,{256,256},{0,0}},timer={16898788789,{256,256},{0,514}},forward={16898671684,{256,256},{514,257}},["file-up"]={16898670469,{256,256},{514,257}},["between-vertical-start"]={16898615570,{256,256},{0,0}},database={16898668755,{256,256},{0,514}},["panel-right"]={16898731024,{256,256},{514,257}},["log-out"]={16898674825,{256,256},{257,257}},["git-branch-plus"]={16898672316,{256,256},{257,0}},["shield-half"]={16898734564,{256,256},{257,257}},["square-dot"]={16898736072,{256,256},{257,0}},["arrow-right-circle"]={16898614166,{256,256},{257,514}},["table-rows-split"]={16898787819,{256,256},{514,257}},watch={16898790791,{256,256},{514,257}},["cloud-upload"]={16898618899,{256,256},{514,257}},["screen-share"]={16898734065,{256,256},{514,0}},drumstick={16898669562,{256,256},{514,514}},["list-checks"]={16898674482,{256,256},{0,514}},bug={16898616879,{256,256},{0,257}},["circle-chevron-left"]={16898617803,{256,256},{514,257}},["arrow-down"]={16898614166,{256,256},{0,0}},["arrow-up-down"]={16898614275,{256,256},{514,514}},["folder-dot"]={16898671139,{256,256},{257,257}},["whole-word"]={16898790996,{256,256},{514,257}},monitor={16898729141,{256,256},{514,257}},["flag-off"]={16898670775,{256,256},{514,257}},["align-right"]={16898613509,{256,256},{0,0}},["circle-stop"]={16898618049,{256,256},{514,0}},infinity={16898673523,{256,256},{514,0}},["arrow-big-down"]={16898613777,{256,256},{0,257}},["circle-parking-off"]={16898617944,{256,256},{514,0}},["calendar-x-2"]={16898617053,{256,256},{257,514}},["user-plus"]={16898789825,{256,256},{0,514}},["move-diagonal-2"]={16898729572,{256,256},{0,257}},["gallery-horizontal-end"]={16898672004,{256,256},{257,257}},["panel-top-dashed"]={16898731024,{256,256},{514,514}},["tram-front"]={16898789012,{256,256},{257,0}},podcast={16898732061,{256,256},{514,257}},["audio-lines"]={16898614755,{256,256},{0,0}},["flip-vertical-2"]={16898671019,{256,256},{257,0}},github={16898672450,{256,256},{257,514}},["rows-2"]={16898733415,{256,256},{257,514}},printer={16898732262,{256,256},{514,514}},["megaphone-off"]={16898675673,{256,256},{257,0}},["file-bar-chart-2"]={16898669984,{256,256},{514,257}},["arrow-big-right"]={16898613777,{256,256},{514,257}},["file-clock"]={16898670072,{256,256},{0,257}},["toy-brick"]={16898788908,{256,256},{257,257}},["square-chevron-down"]={16898735845,{256,256},{0,0}},smartphone={16898735040,{256,256},{257,514}},drill={16898669562,{256,256},{257,257}},["app-window"]={16898613699,{256,256},{514,0}},["shield-check"]={16898734564,{256,256},{0,257}},["hand-metal"]={16898672829,{256,256},{514,0}},["x-circle"]={16898791187,{256,256},{257,514}},["spell-check-2"]={16898735455,{256,256},{0,257}},["minus-square"]={16898728878,{256,256},{0,257}},["box-select"]={16898616650,{256,256},{257,257}},["list-plus"]={16898674572,{256,256},{514,0}},waypoints={16898790791,{256,256},{514,514}},["ice-cream-cone"]={16898673358,{256,256},{514,257}},["copy-slash"]={16898619423,{256,256},{0,514}},wind={16898791187,{256,256},{0,0}},["layout-panel-left"]={16898674182,{256,256},{0,514}},pill={16898731819,{256,256},{257,257}},grip={16898672700,{256,256},{257,257}},["square-x"]={16898736597,{256,256},{514,0}},italic={16898673523,{256,256},{257,514}},["step-forward"]={16898736776,{256,256},{514,0}},["a-arrow-down"]={16898612629,{256,256},{0,0}},container={16898619347,{256,256},{257,514}},sticker={16898736776,{256,256},{0,514}},["parking-circle-off"]={16898731166,{256,256},{514,514}},import={16898673447,{256,256},{514,257}},bird={16898615570,{256,256},{257,257}},["square-terminal"]={16898736597,{256,256},{0,0}},gem={16898672166,{256,256},{257,514}},beef={16898615374,{256,256},{0,514}},["ticket-x"]={16898788789,{256,256},{257,0}},["timer-reset"]={16898788789,{256,256},{257,257}},["monitor-stop"]={16898729141,{256,256},{514,0}},smile={16898735175,{256,256},{0,0}},["signpost-big"]={16898734905,{256,256},{0,257}},cloudy={16898618899,{256,256},{514,514}},["square-percent"]={16898736237,{256,256},{0,514}},["navigation-off"]={16898730065,{256,256},{514,0}},["arrow-left"]={16898614166,{256,256},{514,257}},["car-taxi-front"]={16898617249,{256,256},{0,257}},laugh={16898673999,{256,256},{257,514}},["x-square"]={16898791349,{256,256},{0,0}},["step-back"]={16898736776,{256,256},{0,257}},equal={16898669772,{256,256},{514,0}},megaphone={16898675673,{256,256},{0,257}},["chevron-left"]={16898617509,{256,256},{0,257}},egg={16898669689,{256,256},{514,514}},["video-off"]={16898790439,{256,256},{257,257}},["japanese-yen"]={16898673616,{256,256},{257,0}},library={16898674337,{256,256},{257,257}},["file-terminal"]={16898670469,{256,256},{0,257}},["circle-chevron-down"]={16898617803,{256,256},{0,514}},["bell-off"]={16898615428,{256,256},{0,257}},["square-library"]={16898736072,{256,256},{514,257}},salad={16898733534,{256,256},{514,257}},["tally-2"]={16898788033,{256,256},{0,514}},sheet={16898734421,{256,256},{257,514}},["circle-check-big"]={16898617803,{256,256},{514,0}},["map-pinned"]={16898675359,{256,256},{257,257}},["corner-down-left"]={16898668288,{256,256},{257,0}},dribbble={16898669562,{256,256},{514,0}},["pilcrow-square"]={16898731819,{256,256},{0,257}},["lamp-wall-up"]={16898673794,{256,256},{514,257}},["book-dashed"]={16898616080,{256,256},{514,0}},bluetooth={16898615799,{256,256},{514,0}},["tree-pine"]={16898789012,{256,256},{514,257}},["receipt-indian-rupee"]={16898732855,{256,256},{0,257}},["check-circle-2"]={16898617325,{256,256},{514,257}},["flask-conical"]={16898670919,{256,256},{514,257}},["package-search"]={16898730641,{256,256},{257,0}},columns={16898619182,{256,256},{257,257}},["folder-sync"]={16898671463,{256,256},{514,257}},fingerprint={16898670775,{256,256},{257,0}},["arrow-up-narrow-wide"]={16898614410,{256,256},{0,514}},frame={16898671684,{256,256},{257,514}},["clock-12"]={16898618583,{256,256},{0,0}},images={16898673447,{256,256},{0,514}},lollipop={16898674825,{256,256},{0,514}},["folder-root"]={16898671463,{256,256},{0,257}},["arrow-left-circle"]={16898614166,{256,256},{257,0}},["lamp-floor"]={16898673794,{256,256},{257,257}},image={16898673447,{256,256},{257,257}},["badge-euro"]={16898614945,{256,256},{0,257}},bike={16898615570,{256,256},{257,0}},option={16898730417,{256,256},{0,257}},["scroll-text"]={16898734065,{256,256},{257,257}},["toggle-right"]={16898788789,{256,256},{257,514}},["ferris-wheel"]={16898669897,{256,256},{257,514}},["camera-off"]={16898617146,{256,256},{257,0}},["function-square"]={16898672004,{256,256},{514,0}},group={16898672700,{256,256},{0,514}},codesandbox={16898619015,{256,256},{514,257}},expand={16898669772,{256,256},{514,257}},["tent-tree"]={16898788248,{256,256},{514,0}},settings={16898734421,{256,256},{514,0}},bitcoin={16898615570,{256,256},{0,514}},["thumbs-up"]={16898788660,{256,256},{257,257}},["calendar-search"]={16898617053,{256,256},{514,257}},["hand-platter"]={16898672829,{256,256},{257,257}},["circle-x"]={16898618049,{256,256},{514,257}},["file-diff"]={16898670072,{256,256},{514,257}},["archive-restore"]={16898613699,{256,256},{0,514}},["clock-10"]={16898618392,{256,256},{257,514}},["dice-1"]={16898669042,{256,256},{0,257}},["copy-x"]={16898619423,{256,256},{514,257}},["folder-open-dot"]={16898671263,{256,256},{514,257}},["axis-3d"]={16898614755,{256,256},{257,257}},["arrow-down-1-0"]={16898613869,{256,256},{257,0}},["clipboard-check"]={16898618228,{256,256},{0,257}},["file-x"]={16898670620,{256,256},{257,257}},diff={16898669271,{256,256},{0,0}},dot={16898669433,{256,256},{257,514}},castle={16898617325,{256,256},{0,257}},["power-circle"]={16898732262,{256,256},{514,0}},["fast-forward"]={16898669897,{256,256},{257,257}},["mail-minus"]={16898675156,{256,256},{257,0}},["file-minus-2"]={16898670241,{256,256},{0,257}},paintbrush={16898730641,{256,256},{257,514}},cast={16898617325,{256,256},{257,0}},["parking-square-off"]={16898731301,{256,256},{0,257}},["clipboard-pen"]={16898618392,{256,256},{0,0}},["settings-2"]={16898734421,{256,256},{0,257}},["alarm-clock-off"]={16898612819,{256,256},{0,257}},["ice-cream-2"]={16898673358,{256,256},{257,257}},list={16898674684,{256,256},{257,0}},["file-pie-chart"]={16898670241,{256,256},{514,514}},["square-arrow-right"]={16898735664,{256,256},{257,0}},["scissors-square-dashed-bottom"]={16898733817,{256,256},{514,514}},["remove-formatting"]={16898733146,{256,256},{257,257}},["bookmark-check"]={16898616524,{256,256},{0,514}},cannabis={16898617146,{256,256},{257,514}},["file-plus-2"]={16898670367,{256,256},{0,0}},["bookmark-x"]={16898616524,{256,256},{514,514}},["a-arrow-up"]={16898612629,{256,256},{257,0}},["chevron-right-circle"]={16898617509,{256,256},{514,0}},caravan={16898617249,{256,256},{257,257}},["file-text"]={16898670469,{256,256},{514,0}},["vibrate-off"]={16898790439,{256,256},{0,257}},["mail-check"]={16898675156,{256,256},{0,0}},["square-split-vertical"]={16898736398,{256,256},{257,514}},["file-type-2"]={16898670469,{256,256},{257,257}},["file-code"]={16898670072,{256,256},{257,257}},["file-volume"]={16898670620,{256,256},{257,0}},["flag-triangle-left"]={16898670775,{256,256},{257,514}},["square-equal"]={16898736072,{256,256},{0,257}},["scan-barcode"]={16898733674,{256,256},{514,257}},["cassette-tape"]={16898617325,{256,256},{0,0}},["battery-low"]={16898615240,{256,256},{257,257}},["utility-pole"]={16898790259,{256,256},{514,257}},folder={16898671684,{256,256},{257,0}},signpost={16898734905,{256,256},{514,0}},["file-edit"]={16898670171,{256,256},{0,0}},["globe-2"]={16898672599,{256,256},{0,257}},landmark={16898673999,{256,256},{0,0}},["fish-symbol"]={16898670775,{256,256},{257,257}},["form-input"]={16898671684,{256,256},{0,514}},loader={16898674684,{256,256},{257,257}},bold={16898615799,{256,256},{257,257}},["dice-2"]={16898669042,{256,256},{514,0}},["file-type"]={16898670469,{256,256},{0,514}},["book-user"]={16898616524,{256,256},{0,257}},beer={16898615374,{256,256},{257,514}},["gantt-chart-square"]={16898672166,{256,256},{0,257}},ghost={16898672166,{256,256},{514,514}},globe={16898672599,{256,256},{257,257}},["satellite-dish"]={16898733534,{256,256},{514,514}},binary={16898615570,{256,256},{0,257}},["move-diagonal"]={16898729572,{256,256},{514,0}},["table-cells-merge"]={16898787819,{256,256},{0,257}},["door-closed"]={16898669433,{256,256},{0,514}},["image-minus"]={16898673447,{256,256},{0,0}},utensils={16898790259,{256,256},{0,514}},["paw-print"]={16898731301,{256,256},{514,514}},["bar-chart-4"]={16898615143,{256,256},{514,0}},["book-x"]={16898616524,{256,256},{514,0}},["panel-bottom-close"]={16898730821,{256,256},{257,0}},["hand-heart"]={16898672829,{256,256},{257,0}},["file-code-2"]={16898670072,{256,256},{514,0}},["move-down-left"]={16898729572,{256,256},{257,257}},indent={16898673523,{256,256},{257,0}},joystick={16898673616,{256,256},{0,257}},keyboard={16898673794,{256,256},{257,0}},["toggle-left"]={16898788789,{256,256},{514,257}},skull={16898734905,{256,256},{257,514}},["route-off"]={16898733415,{256,256},{257,257}},["dice-6"]={16898669042,{256,256},{257,514}},lightbulb={16898674337,{256,256},{514,514}},key={16898673616,{256,256},{514,514}},["clock-11"]={16898618392,{256,256},{514,514}},["list-video"]={16898674572,{256,256},{514,514}},["ticket-plus"]={16898788660,{256,256},{514,514}},["square-dashed-bottom"]={16898735845,{256,256},{514,257}},["layout-panel-top"]={16898674182,{256,256},{514,257}},["more-vertical"]={16898729337,{256,256},{257,0}},["monitor-pause"]={16898728878,{256,256},{514,514}},["book-open-check"]={16898616322,{256,256},{514,0}},projector={16898732504,{256,256},{0,0}},["lasso-select"]={16898673999,{256,256},{0,514}},maximize={16898675359,{256,256},{514,514}},["text-quote"]={16898788479,{256,256},{257,257}},["image-up"]={16898673447,{256,256},{514,0}},["message-square-quote"]={16898728402,{256,256},{0,0}},bus={16898616879,{256,256},{514,257}},["square-arrow-down-right"]={16898735593,{256,256},{514,0}},["bed-single"]={16898615374,{256,256},{514,0}},["list-music"]={16898674572,{256,256},{257,0}},["file-spreadsheet"]={16898670367,{256,256},{514,514}},["heart-pulse"]={16898673115,{256,256},{514,514}},["clipboard-list"]={16898618228,{256,256},{0,514}},video={16898790439,{256,256},{0,514}},["contact-round"]={16898619347,{256,256},{0,514}},battery={16898615240,{256,256},{257,514}},microscope={16898728659,{256,256},{514,0}},["message-circle-question"]={16898675752,{256,256},{0,514}},["file-badge"]={16898669984,{256,256},{0,514}},["battery-warning"]={16898615240,{256,256},{514,257}},["git-pull-request"]={16898672450,{256,256},{514,257}},["arrow-down-from-line"]={16898613869,{256,256},{257,257}},briefcase={16898616757,{256,256},{514,257}},biohazard={16898615570,{256,256},{514,0}},moon={16898729141,{256,256},{514,514}},["heading-6"]={16898673115,{256,256},{257,0}},["scale-3d"]={16898733674,{256,256},{514,0}},["chevron-down-circle"]={16898617411,{256,256},{257,257}},["mail-x"]={16898675156,{256,256},{257,514}},["square-dashed-mouse-pointer"]={16898735845,{256,256},{514,514}},["user-cog"]={16898789825,{256,256},{257,0}},["lock-open"]={16898674825,{256,256},{257,0}},["mouse-pointer-square-dashed"]={16898729337,{256,256},{514,257}},pizza={16898731819,{256,256},{514,514}},["pc-case"]={16898731419,{256,256},{0,0}},["arrow-up-wide-narrow"]={16898614574,{256,256},{0,257}},["mouse-pointer"]={16898729337,{256,256},{514,514}},["clock-5"]={16898618583,{256,256},{257,257}},dices={16898669042,{256,256},{514,514}},["rotate-ccw"]={16898733415,{256,256},{257,0}},["align-horizontal-justify-center"]={16898613353,{256,256},{0,257}},mouse={16898729572,{256,256},{0,0}},antenna={16898613613,{256,256},{514,514}},["memory-stick"]={16898675673,{256,256},{257,257}},["scan-eye"]={16898733674,{256,256},{257,514}},["bean-off"]={16898615374,{256,256},{0,0}},["square-check"]={16898735664,{256,256},{514,514}},unlock={16898789451,{256,256},{514,514}},highlighter={16898673271,{256,256},{0,514}},["loader-circle"]={16898674684,{256,256},{514,0}},["hard-drive-upload"]={16898672829,{256,256},{514,514}},["gallery-vertical-end"]={16898672004,{256,256},{257,514}},["menu-square"]={16898675673,{256,256},{0,514}},["hand-coins"]={16898672829,{256,256},{0,0}},["notepad-text"]={16898730298,{256,256},{257,257}},orbit={16898730417,{256,256},{514,0}},["package-open"]={16898730417,{256,256},{514,514}},clock={16898618763,{256,256},{0,0}},["file-pen"]={16898670241,{256,256},{257,514}},["git-compare-arrows"]={16898672316,{256,256},{0,514}},["cloud-sun-rain"]={16898618899,{256,256},{257,257}},["align-horizontal-justify-start"]={16898613353,{256,256},{257,257}},["grid-2x2"]={16898672700,{256,256},{0,0}},percent={16898731539,{256,256},{514,0}},vibrate={16898790439,{256,256},{514,0}},["calendar-plus"]={16898617053,{256,256},{257,257}},brain={16898616757,{256,256},{0,257}},["arrow-down-z-a"]={16898614020,{256,256},{514,514}},bath={16898615240,{256,256},{257,0}},["panel-right-close"]={16898731024,{256,256},{0,257}},["unlink-2"]={16898789451,{256,256},{0,514}},paperclip={16898731166,{256,256},{514,257}},["parking-circle"]={16898731301,{256,256},{0,0}},["folder-check"]={16898671139,{256,256},{0,0}},["parking-square"]={16898731301,{256,256},{514,0}},["book-key"]={16898616080,{256,256},{514,514}},ribbon={16898733317,{256,256},{257,257}},microwave={16898728659,{256,256},{257,257}},["air-vent"]={16898612629,{256,256},{514,257}},["library-big"]={16898674337,{256,256},{0,257}},["file-json"]={16898670171,{256,256},{0,514}},["folder-open"]={16898671263,{256,256},{257,514}},["monitor-off"]={16898728878,{256,256},{257,514}},["square-scissors"]={16898736398,{256,256},{514,0}},["move-up-left"]={16898729752,{256,256},{257,0}},brush={16898616757,{256,256},{514,514}},["folder-heart"]={16898671263,{256,256},{0,0}},hash={16898672954,{256,256},{0,257}},["arrow-up-1-0"]={16898614275,{256,256},{0,514}},["arrow-right"]={16898614275,{256,256},{514,0}},["arrow-up-a-z"]={16898614275,{256,256},{514,257}},["badge-x"]={16898615022,{256,256},{257,257}},["panel-bottom-inactive"]={16898730821,{256,256},{514,0}},["file-video-2"]={16898670469,{256,256},{257,514}},["phone-call"]={16898731539,{256,256},{0,514}},construction={16898619347,{256,256},{514,0}},["swatch-book"]={16898787671,{256,256},{257,257}},["receipt-cent"]={16898732855,{256,256},{0,0}},["badge-pound-sterling"]={16898615022,{256,256},{257,0}},["folder-archive"]={16898671019,{256,256},{514,514}},["folder-symlink"]={16898671463,{256,256},{0,514}},["columns-3"]={16898619182,{256,256},{0,257}},ban={16898615022,{256,256},{257,514}},["message-square-x"]={16898728402,{256,256},{0,514}},["paint-roller"]={16898730641,{256,256},{0,514}},plug={16898732061,{256,256},{0,0}},gamepad={16898672166,{256,256},{257,0}},["book-minus"]={16898616322,{256,256},{0,257}},popsicle={16898732262,{256,256},{257,0}},["building-2"]={16898616879,{256,256},{514,0}},["circle-slash-2"]={16898618049,{256,256},{257,0}},["rectangle-horizontal"]={16898733036,{256,256},{257,0}},cake={16898616953,{256,256},{257,0}},["cloud-rain"]={16898618899,{256,256},{0,257}},["maximize-2"]={16898675359,{256,256},{257,514}},["redo-2"]={16898733036,{256,256},{257,257}},wrench={16898791187,{256,256},{514,257}},["repeat-2"]={16898733146,{256,256},{514,257}},codepen={16898619015,{256,256},{0,514}},reply={16898733317,{256,256},{0,257}},["flag-triangle-right"]={16898670775,{256,256},{514,514}},["rotate-ccw-square"]={16898733415,{256,256},{0,0}},["scan-search"]={16898733817,{256,256},{257,0}},bell={16898615428,{256,256},{0,514}},["grid-3x3"]={16898672700,{256,256},{257,0}},save={16898733674,{256,256},{0,257}},["music-3"]={16898729752,{256,256},{257,514}},focus={16898671019,{256,256},{0,514}},["user-check"]={16898789644,{256,256},{514,257}},proportions={16898732504,{256,256},{257,0}},["alert-octagon"]={16898613044,{256,256},{257,0}},plane={16898731919,{256,256},{0,257}},["webhook-off"]={16898790996,{256,256},{257,0}},carrot={16898617249,{256,256},{0,514}},["square-arrow-left"]={16898735593,{256,256},{0,514}},["file-cog"]={16898670072,{256,256},{0,514}},heart={16898673271,{256,256},{0,0}},["scan-face"]={16898733674,{256,256},{514,514}},["folder-down"]={16898671139,{256,256},{0,514}},["layout-template"]={16898674182,{256,256},{257,514}},mailbox={16898675359,{256,256},{0,0}},home={16898673271,{256,256},{257,514}},["traffic-cone"]={16898788908,{256,256},{514,257}},scissors={16898734065,{256,256},{257,0}},split={16898735455,{256,256},{257,514}},twitter={16898789303,{256,256},{0,257}},["locate-off"]={16898674684,{256,256},{514,257}},forklift={16898671684,{256,256},{257,257}},["square-arrow-out-up-left"]={16898735593,{256,256},{514,514}},component={16898619182,{256,256},{514,514}},["panels-left-bottom"]={16898731166,{256,256},{514,0}},["message-square-diff"]={16898675863,{256,256},{514,0}},["book-marked"]={16898616322,{256,256},{257,0}},["alarm-plus"]={16898612819,{256,256},{514,257}},["bluetooth-connected"]={16898615799,{256,256},{0,0}},unlink={16898789451,{256,256},{514,257}},signal={16898734905,{256,256},{257,0}},slack={16898734905,{256,256},{514,514}},["file-volume-2"]={16898670620,{256,256},{0,0}},["pound-sterling"]={16898732262,{256,256},{0,257}},power={16898732262,{256,256},{514,257}},["skip-forward"]={16898734905,{256,256},{514,257}},["m-square"]={16898674825,{256,256},{257,514}},["git-merge"]={16898672450,{256,256},{0,0}},["file-box"]={16898669984,{256,256},{514,514}},["align-justify"]={16898613353,{256,256},{257,514}},["paint-bucket"]={16898730641,{256,256},{257,257}},wallpaper={16898790791,{256,256},{0,0}},filter={16898670775,{256,256},{0,0}},glasses={16898672599,{256,256},{257,0}},["piggy-bank"]={16898731819,{256,256},{257,0}},["square-play"]={16898736237,{256,256},{514,514}},shell={16898734421,{256,256},{514,514}},["cloud-off"]={16898618899,{256,256},{0,0}},["check-check"]={16898617325,{256,256},{0,514}},activity={16898612629,{256,256},{0,514}},axe={16898614755,{256,256},{514,0}},["plane-takeoff"]={16898731919,{256,256},{257,0}},snowflake={16898735175,{256,256},{0,257}},["cloud-rain-wind"]={16898618899,{256,256},{257,0}},["square-plus"]={16898736398,{256,256},{0,0}},["dice-5"]={16898669042,{256,256},{514,257}},["search-slash"]={16898734065,{256,256},{514,514}},["file-axis-3d"]={16898669984,{256,256},{514,0}},["receipt-euro"]={16898732855,{256,256},{257,0}},["square-radical"]={16898736398,{256,256},{0,257}},["cloud-drizzle"]={16898618763,{256,256},{514,0}},["bug-play"]={16898616879,{256,256},{257,0}},["align-vertical-distribute-start"]={16898613509,{256,256},{0,514}},layout={16898674182,{256,256},{514,514}},["square-stack"]={16898736398,{256,256},{514,514}},["tally-5"]={16898788033,{256,256},{514,514}},squirrel={16898736597,{256,256},{514,257}},["pen-square"]={16898731419,{256,256},{0,257}},["folder-lock"]={16898671263,{256,256},{257,257}},["circle-divide"]={16898617884,{256,256},{257,0}},["case-sensitive"]={16898617249,{256,256},{257,514}},sunset={16898787671,{256,256},{0,257}},linkedin={16898674482,{256,256},{257,257}},["life-buoy"]={16898674337,{256,256},{0,514}},["circle-play"]={16898617944,{256,256},{257,514}},["tally-4"]={16898788033,{256,256},{257,514}},["volume-2"]={16898790615,{256,256},{257,0}},["battery-charging"]={16898615240,{256,256},{0,257}},["russian-ruble"]={16898733534,{256,256},{257,257}},["wallet-minimal"]={16898790615,{256,256},{257,514}},["earth-lock"]={16898669689,{256,256},{514,0}},footprints={16898671684,{256,256},{514,0}},["text-cursor-input"]={16898788479,{256,256},{0,257}},building={16898616879,{256,256},{257,257}},["lock-keyhole-open"]={16898674684,{256,256},{514,514}},twitch={16898789303,{256,256},{257,0}},["thermometer-sun"]={16898788660,{256,256},{257,0}},["switch-camera"]={16898787671,{256,256},{514,257}},club={16898619015,{256,256},{257,0}},["shield-plus"]={16898734564,{256,256},{257,514}},["alarm-check"]={16898612629,{256,256},{514,514}},["bell-minus"]={16898615428,{256,256},{257,0}},["log-in"]={16898674825,{256,256},{514,0}},["bot-message-square"]={16898616650,{256,256},{0,257}},drum={16898669562,{256,256},{257,514}},["arrow-up-z-a"]={16898614574,{256,256},{514,0}},sun={16898787671,{256,256},{0,0}},["layers-3"]={16898674182,{256,256},{0,0}},["zoom-out"]={16898791349,{256,256},{514,257}},["file-key"]={16898670171,{256,256},{257,514}},tractor={16898788908,{256,256},{0,514}},["school-2"]={16898733817,{256,256},{0,514}},["scissors-line-dashed"]={16898733817,{256,256},{257,514}},["text-select"]={16898788479,{256,256},{514,257}},["file-search"]={16898670367,{256,256},{0,514}},["unfold-vertical"]={16898789451,{256,256},{0,257}},["ticket-check"]={16898788660,{256,256},{0,514}},pyramid={16898732504,{256,256},{514,0}},["hard-drive"]={16898672954,{256,256},{0,0}},["user-cog-2"]={16898789825,{256,256},{0,0}},["refresh-cw-off"]={16898733146,{256,256},{0,0}},["external-link"]={16898669772,{256,256},{257,514}},["picture-in-picture-2"]={16898731683,{256,256},{257,514}},["file-x-2"]={16898670620,{256,256},{514,0}},["flower-2"]={16898671019,{256,256},{514,0}},["calendar-x"]={16898617053,{256,256},{514,514}},["user-round-check"]={16898789825,{256,256},{514,257}},["user-round"]={16898790047,{256,256},{514,0}},["link-2-off"]={16898674482,{256,256},{257,0}},["keyboard-music"]={16898673794,{256,256},{0,0}},["star-half"]={16898736597,{256,256},{514,514}},["user-x"]={16898790047,{256,256},{514,514}},["code-xml"]={16898619015,{256,256},{514,0}},["trending-up"]={16898789153,{256,256},{257,0}},mails={16898675359,{256,256},{257,0}},["brain-cog"]={16898616757,{256,256},{257,0}},tablet={16898788033,{256,256},{0,0}},["users-round"]={16898790259,{256,256},{0,257}},pi={16898731683,{256,256},{257,257}},trash={16898789012,{256,256},{514,0}},dock={16898669433,{256,256},{257,0}},["hdmi-port"]={16898672954,{256,256},{257,257}},braces={16898616650,{256,256},{257,514}},["case-upper"]={16898617249,{256,256},{514,514}},["move-3d"]={16898729572,{256,256},{257,0}},wallet={16898790615,{256,256},{514,514}},croissant={16898668482,{256,256},{514,0}},["monitor-speaker"]={16898729141,{256,256},{0,257}},waves={16898790791,{256,256},{257,514}},barcode={16898615143,{256,256},{514,514}},lock={16898674825,{256,256},{0,257}},["wheat-off"]={16898790996,{256,256},{257,257}},bed={16898615374,{256,256},{257,257}},quote={16898732504,{256,256},{0,514}},divide={16898669271,{256,256},{257,514}},grape={16898672599,{256,256},{514,514}},["play-square"]={16898731919,{256,256},{257,257}},["party-popper"]={16898731301,{256,256},{257,257}},["file-video"]={16898670469,{256,256},{514,514}},university={16898789451,{256,256},{257,257}},["user-circle-2"]={16898789644,{256,256},{257,514}},truck={16898789153,{256,256},{514,257}},box={16898616650,{256,256},{0,514}},["calendar-range"]={16898617053,{256,256},{0,514}},subscript={16898736967,{256,256},{514,0}},["zap-off"]={16898791349,{256,256},{514,0}},["square-check-big"]={16898735664,{256,256},{257,514}},["wand-sparkles"]={16898790791,{256,256},{0,257}},["square-chevron-up"]={16898735845,{256,256},{514,0}},["circle-ellipsis"]={16898617884,{256,256},{0,514}},["laptop-minimal"]={16898673999,{256,256},{514,0}},["radio-receiver"]={16898732665,{256,256},{257,0}},sofa={16898735175,{256,256},{514,0}},["square-asterisk"]={16898735664,{256,256},{0,514}},wine={16898791187,{256,256},{0,257}},cookie={16898619423,{256,256},{0,0}},["message-square-more"]={16898675863,{256,256},{514,257}},clapperboard={16898618228,{256,256},{257,0}},euro={16898669772,{256,256},{0,514}},["dice-3"]={16898669042,{256,256},{257,257}},["heart-off"]={16898673115,{256,256},{257,514}},["clipboard-minus"]={16898618228,{256,256},{514,257}},info={16898673523,{256,256},{257,257}},["move-horizontal"]={16898729572,{256,256},{257,514}},["file-sliders"]={16898670367,{256,256},{257,514}},frown={16898672004,{256,256},{0,0}},["cloud-hail"]={16898618763,{256,256},{0,514}},["cup-soda"]={16898668755,{256,256},{0,0}},["cable-car"]={16898616879,{256,256},{257,514}},["lock-keyhole"]={16898674825,{256,256},{0,0}},sword={16898787671,{256,256},{257,514}},play={16898731919,{256,256},{0,514}},["laptop-2"]={16898673999,{256,256},{0,257}},earth={16898669689,{256,256},{257,257}},slice={16898735040,{256,256},{257,0}},["land-plot"]={16898673794,{256,256},{514,514}},milk={16898728659,{256,256},{257,514}},["circle-user"]={16898618049,{256,256},{0,514}},["align-left"]={16898613353,{256,256},{514,514}},["circle-slash"]={16898618049,{256,256},{0,257}},contact={16898619347,{256,256},{514,257}},["rotate-cw-square"]={16898733415,{256,256},{0,257}},atom={16898614574,{256,256},{514,514}},["package-x"]={16898730641,{256,256},{0,257}},["bed-double"]={16898615374,{256,256},{0,257}},anchor={16898613613,{256,256},{0,514}},["circle-dot"]={16898617884,{256,256},{257,257}},["git-commit-horizontal"]={16898672316,{256,256},{514,0}},["git-commit-vertical"]={16898672316,{256,256},{257,257}},["message-circle-code"]={16898675673,{256,256},{514,514}},["folder-git-2"]={16898671139,{256,256},{257,514}},["message-square-code"]={16898675863,{256,256},{257,0}},["mail-plus"]={16898675156,{256,256},{514,0}},["diamond-percent"]={16898669042,{256,256},{0,0}},["message-circle-heart"]={16898675752,{256,256},{257,0}},["arrow-big-left-dash"]={16898613777,{256,256},{514,0}},["circle-arrow-out-down-left"]={16898617705,{256,256},{514,257}},dumbbell={16898669689,{256,256},{0,0}},["file-music"]={16898670241,{256,256},{257,257}},["alert-triangle"]={16898613044,{256,256},{0,257}},["chevrons-right-left"]={16898617626,{256,256},{257,257}},scale={16898733674,{256,256},{257,257}},eraser={16898669772,{256,256},{257,257}},["flashlight-off"]={16898670919,{256,256},{514,0}},["panel-top-open"]={16898731166,{256,256},{257,0}},["cloud-lightning"]={16898618763,{256,256},{514,257}},ungroup={16898789451,{256,256},{514,0}},notebook={16898730298,{256,256},{0,257}},["power-square"]={16898732262,{256,256},{0,514}},sprout={16898735593,{256,256},{0,0}},["square-menu"]={16898736072,{256,256},{514,514}},["mic-vocal"]={16898728659,{256,256},{257,0}},["monitor-smartphone"]={16898729141,{256,256},{257,0}},laptop={16898673999,{256,256},{257,257}},["scan-line"]={16898733817,{256,256},{0,0}},["clock-4"]={16898618583,{256,256},{514,0}},["square-arrow-up"]={16898735664,{256,256},{257,257}},copyright={16898668288,{256,256},{0,0}},["monitor-up"]={16898729141,{256,256},{257,257}},["unlock-keyhole"]={16898789451,{256,256},{257,514}},usb={16898789644,{256,256},{514,0}},rocket={16898733317,{256,256},{0,514}},["arrow-down-to-line"]={16898614020,{256,256},{0,514}},["book-plus"]={16898616322,{256,256},{514,257}},["refresh-ccw"]={16898733036,{256,256},{514,514}},["venetian-mask"]={16898790439,{256,256},{257,0}},["calendar-check-2"]={16898616953,{256,256},{514,0}},["arrow-down-square"]={16898614020,{256,256},{514,0}},spline={16898735455,{256,256},{257,257}},mail={16898675156,{256,256},{514,514}},["git-pull-request-create-arrow"]={16898672450,{256,256},{514,0}},["library-square"]={16898674337,{256,256},{514,0}},["circle-check"]={16898617803,{256,256},{257,257}},["square-arrow-up-right"]={16898735664,{256,256},{514,0}},["book-text"]={16898616322,{256,256},{257,514}},user={16898790259,{256,256},{0,0}},["file-key-2"]={16898670171,{256,256},{514,257}},["gallery-horizontal"]={16898672004,{256,256},{0,514}},["circle-chevron-right"]={16898617803,{256,256},{257,514}},["timer-off"]={16898788789,{256,256},{514,0}},["arrow-big-right-dash"]={16898613777,{256,256},{0,514}},["wallet-2"]={16898790615,{256,256},{0,514}},cloud={16898618899,{256,256},{257,514}},triangle={16898789153,{256,256},{257,257}},backpack={16898614755,{256,256},{514,257}},lamp={16898673794,{256,256},{257,514}},flower={16898671019,{256,256},{257,257}},youtube={16898791349,{256,256},{0,257}},["upload-cloud"]={16898789644,{256,256},{257,0}},lasso={16898673999,{256,256},{514,257}},["arrow-down-right"]={16898614020,{256,256},{0,257}},sailboat={16898733534,{256,256},{0,514}},receipt={16898732855,{256,256},{514,514}},["bell-ring"]={16898615428,{256,256},{257,257}},["heart-crack"]={16898673115,{256,256},{0,514}},["tree-deciduous"]={16898789012,{256,256},{257,257}},["fire-extinguisher"]={16898670775,{256,256},{0,257}},["baggage-claim"]={16898615022,{256,256},{514,257}},["image-off"]={16898673447,{256,256},{257,0}},["arrow-left-to-line"]={16898614166,{256,256},{0,514}},["layout-grid"]={16898674182,{256,256},{514,0}},["pi-square"]={16898731683,{256,256},{514,0}},["clock-3"]={16898618583,{256,256},{0,257}},["square-chevron-right"]={16898735845,{256,256},{0,257}},navigation={16898730065,{256,256},{257,257}},["filter-x"]={16898670620,{256,256},{514,514}},["bar-chart-3"]={16898615143,{256,256},{0,257}},["map-pin"]={16898675359,{256,256},{514,0}},["arrow-down-right-from-circle"]={16898614020,{256,256},{0,0}},["shopping-bag"]={16898734664,{256,256},{0,514}},["chevron-right"]={16898617509,{256,256},{0,514}},["tally-1"]={16898788033,{256,256},{257,257}},ampersand={16898613613,{256,256},{514,0}},["arrow-up-from-line"]={16898614410,{256,256},{257,0}},["shopping-cart"]={16898734664,{256,256},{257,514}},["user-minus-2"]={16898789825,{256,256},{0,257}},vote={16898790615,{256,256},{257,257}},["alarm-smoke"]={16898612819,{256,256},{257,514}},["file-line-chart"]={16898670171,{256,256},{514,514}},["file-input"]={16898670171,{256,256},{514,0}},["clock-8"]={16898618583,{256,256},{257,514}},["server-cog"]={16898734242,{256,256},{257,514}},["cloud-cog"]={16898618763,{256,256},{257,0}},blend={16898615570,{256,256},{514,257}},["search-x"]={16898734242,{256,256},{0,0}},["radio-tower"]={16898732665,{256,256},{0,257}},["list-tree"]={16898674572,{256,256},{257,514}},droplet={16898669562,{256,256},{0,514}},["panel-right-open"]={16898731024,{256,256},{0,514}},eye={16898669897,{256,256},{0,0}},siren={16898734905,{256,256},{257,257}},star={16898736776,{256,256},{257,0}},banana={16898615022,{256,256},{514,514}},["panel-top"]={16898731166,{256,256},{0,257}},donut={16898669433,{256,256},{257,257}},telescope={16898788248,{256,256},{0,257}},["circle-equal"]={16898617884,{256,256},{514,257}},["arrow-up-right"]={16898614410,{256,256},{514,514}},calculator={16898616953,{256,256},{0,257}},magnet={16898674825,{256,256},{514,514}},crown={16898668482,{256,256},{257,514}},subtitles={16898736967,{256,256},{257,257}},["brick-wall"]={16898616757,{256,256},{514,0}},["message-circle-dashed"]={16898675752,{256,256},{0,0}},["leafy-green"]={16898674337,{256,256},{257,0}},["message-square-dot"]={16898675863,{256,256},{257,257}},["arrow-down-a-z"]={16898613869,{256,256},{0,257}},copyleft={16898619423,{256,256},{514,514}},["monitor-play"]={16898729141,{256,256},{0,0}},["text-cursor"]={16898788479,{256,256},{514,0}},["minimize-2"]={16898728659,{256,256},{514,514}},disc={16898669271,{256,256},{257,257}},locate={16898674684,{256,256},{257,514}},cone={16898619347,{256,256},{0,257}},["heading-1"]={16898672954,{256,256},{0,514}},["file-image"]={16898670171,{256,256},{0,257}},sparkles={16898735175,{256,256},{514,514}},palette={16898730641,{256,256},{514,514}},["user-plus-2"]={16898789825,{256,256},{257,257}},["gallery-thumbnails"]={16898672004,{256,256},{514,257}},["book-up"]={16898616524,{256,256},{257,0}},cpu={16898668482,{256,256},{0,0}},["split-square-horizontal"]={16898735455,{256,256},{0,514}},["thumbs-down"]={16898788660,{256,256},{514,0}},merge={16898675673,{256,256},{257,514}},["circle-dashed"]={16898617884,{256,256},{0,0}},["bar-chart-big"]={16898615143,{256,256},{257,257}},["test-tubes"]={16898788479,{256,256},{257,0}},hospital={16898673358,{256,256},{257,0}},haze={16898672954,{256,256},{514,0}},plus={16898732061,{256,256},{514,0}},["align-vertical-space-around"]={16898613613,{256,256},{0,0}},["key-square"]={16898673616,{256,256},{257,514}},palmtree={16898730821,{256,256},{0,0}},["file-audio"]={16898669984,{256,256},{0,257}},kanban={16898673616,{256,256},{0,514}},["sliders-vertical"]={16898735040,{256,256},{514,0}},apple={16898613699,{256,256},{257,257}},["wine-off"]={16898791187,{256,256},{257,0}},["check-circle"]={16898617325,{256,256},{257,514}},cuboid={16898668482,{256,256},{514,514}},["square-code"]={16898735845,{256,256},{257,257}},["bug-off"]={16898616879,{256,256},{0,0}},["circle-arrow-out-up-left"]={16898617705,{256,256},{514,514}},["corner-right-down"]={16898668288,{256,256},{0,514}},["plug-zap-2"]={16898731919,{256,256},{257,514}},["heading-2"]={16898672954,{256,256},{514,257}},["square-activity"]={16898735593,{256,256},{257,0}},["package-plus"]={16898730641,{256,256},{0,0}},["cigarette-off"]={16898617705,{256,256},{257,0}},["align-vertical-justify-start"]={16898613509,{256,256},{514,514}},["power-off"]={16898732262,{256,256},{257,257}},["undo-2"]={16898789303,{256,256},{257,514}},router={16898733415,{256,256},{514,257}},["tower-control"]={16898788908,{256,256},{514,0}},["git-branch"]={16898672316,{256,256},{0,257}},shovel={16898734664,{256,256},{514,514}},share={16898734421,{256,256},{514,257}},["wallet-cards"]={16898790615,{256,256},{514,257}},["square-arrow-out-down-right"]={16898735593,{256,256},{257,514}},["circuit-board"]={16898618049,{256,256},{514,514}},shield={16898734664,{256,256},{257,0}},["bar-chart-2"]={16898615143,{256,256},{257,0}},["cloud-snow"]={16898618899,{256,256},{514,0}},["file-question"]={16898670367,{256,256},{0,257}},["arrow-big-up-dash"]={16898613777,{256,256},{257,514}},["folder-closed"]={16898671139,{256,256},{0,257}},["smartphone-nfc"]={16898735040,{256,256},{514,257}},network={16898730065,{256,256},{0,514}},["file-bar-chart"]={16898669984,{256,256},{257,514}},["user-round-x"]={16898790047,{256,256},{0,257}},["signal-low"]={16898734792,{256,256},{257,514}},["mail-question"]={16898675156,{256,256},{257,257}},["clipboard-plus"]={16898618392,{256,256},{257,0}},["file-minus"]={16898670241,{256,256},{514,0}},["list-end"]={16898674482,{256,256},{257,514}},torus={16898788908,{256,256},{0,0}},["arrow-down-left"]={16898613869,{256,256},{257,514}},["chevrons-right"]={16898617626,{256,256},{0,514}},["file-badge-2"]={16898669984,{256,256},{257,257}},["message-square-reply"]={16898728402,{256,256},{257,0}},["corner-down-right"]={16898668288,{256,256},{0,257}},["gauge-circle"]={16898672166,{256,256},{257,257}},["users-2"]={16898790259,{256,256},{257,0}},["lamp-wall-down"]={16898673794,{256,256},{0,514}},["square-bottom-dashed-scissors"]={16898735664,{256,256},{514,257}},["repeat"]={16898733146,{256,256},{257,514}},["ellipsis-vertical"]={16898669772,{256,256},{0,0}},snail={16898735175,{256,256},{257,0}},check={16898617411,{256,256},{257,0}},["square-parking"]={16898736237,{256,256},{514,0}},["align-horizontal-justify-end"]={16898613353,{256,256},{514,0}},["mail-search"]={16898675156,{256,256},{0,514}},["align-vertical-distribute-end"]={16898613509,{256,256},{257,257}},soup={16898735175,{256,256},{257,257}},airplay={16898612629,{256,256},{257,514}},pentagon={16898731419,{256,256},{514,514}},["rocking-chair"]={16898733317,{256,256},{514,257}},["between-horizontal-start"]={16898615428,{256,256},{257,514}},["monitor-x"]={16898729141,{256,256},{0,514}},["octagon-pause"]={16898730298,{256,256},{514,514}},["square-kanban"]={16898736072,{256,256},{0,514}},["square-pen"]={16898736237,{256,256},{257,257}},["rectangle-vertical"]={16898733036,{256,256},{0,257}},["panels-right-bottom"]={16898731166,{256,256},{257,257}},["gantt-chart"]={16898672166,{256,256},{514,0}},octagon={16898730417,{256,256},{257,0}},ticket={16898788789,{256,256},{0,257}},pocket={16898732061,{256,256},{0,514}},["link-2"]={16898674482,{256,256},{0,257}},["train-front"]={16898788908,{256,256},{514,514}},["spray-can"]={16898735455,{256,256},{514,514}},["arrow-up-0-1"]={16898614275,{256,256},{257,257}},album={16898612819,{256,256},{514,514}},replace={16898733317,{256,256},{0,0}},["move-right"]={16898729752,{256,256},{0,0}},["hand-helping"]={16898672829,{256,256},{0,257}},["list-collapse"]={16898674482,{256,256},{514,257}},gauge={16898672166,{256,256},{0,514}},store={16898736776,{256,256},{514,514}},["circle-arrow-down"]={16898617705,{256,256},{257,257}},["notebook-pen"]={16898730065,{256,256},{514,514}},["egg-fried"]={16898669689,{256,256},{514,257}},ligature={16898674337,{256,256},{514,257}},["sticky-note"]={16898736776,{256,256},{514,257}},["corner-right-up"]={16898668288,{256,256},{514,257}},["badge-help"]={16898614945,{256,256},{514,0}},["panel-top-inactive"]={16898731166,{256,256},{0,0}},["user-round-plus"]={16898790047,{256,256},{0,0}},["panel-left-close"]={16898730821,{256,256},{514,257}},rewind={16898733317,{256,256},{514,0}},fuel={16898672004,{256,256},{257,0}},["divide-circle"]={16898669271,{256,256},{0,514}},["square-arrow-out-up-right"]={16898735664,{256,256},{0,0}},["chevrons-down-up"]={16898617626,{256,256},{0,0}},["message-square-text"]={16898728402,{256,256},{514,0}},["user-round-search"]={16898790047,{256,256},{257,0}},scan={16898733817,{256,256},{514,0}},["monitor-down"]={16898728878,{256,256},{514,257}},["play-circle"]={16898731919,{256,256},{514,0}},["file-digit"]={16898670072,{256,256},{257,514}},slash={16898735040,{256,256},{0,0}},["split-square-vertical"]={16898735455,{256,256},{514,257}},aperture={16898613699,{256,256},{257,0}},["arrow-right-left"]={16898614275,{256,256},{0,0}},["helping-hand"]={16898673271,{256,256},{514,0}},["flask-conical-off"]={16898670919,{256,256},{0,514}},["circle-gauge"]={16898617884,{256,256},{514,514}},crosshair={16898668482,{256,256},{514,257}},["move-down-right"]={16898729572,{256,256},{0,514}},["text-search"]={16898788479,{256,256},{0,514}},["square-slash"]={16898736398,{256,256},{0,514}},sandwich={16898733534,{256,256},{257,514}},factory={16898669897,{256,256},{0,257}},["chef-hat"]={16898617411,{256,256},{0,257}},["arrow-down-to-dot"]={16898614020,{256,256},{257,257}},["image-plus"]={16898673447,{256,256},{0,257}},["file-archive"]={16898669984,{256,256},{0,0}},["signal-high"]={16898734792,{256,256},{514,257}},inbox={16898673447,{256,256},{257,514}},["flip-horizontal-2"]={16898670919,{256,256},{514,514}},["book-type"]={16898616322,{256,256},{514,514}},["file-signature"]={16898670367,{256,256},{514,257}},["align-horizontal-space-between"]={16898613353,{256,256},{514,257}},["bookmark-minus"]={16898616524,{256,256},{514,257}},["calendar-check"]={16898616953,{256,256},{257,257}},["database-zap"]={16898668755,{256,256},{257,257}},droplets={16898669562,{256,256},{514,257}},boxes={16898616650,{256,256},{514,257}},["bell-electric"]={16898615428,{256,256},{0,0}},["bar-chart"]={16898615143,{256,256},{257,514}},["layout-list"]={16898674182,{256,256},{257,257}},link={16898674482,{256,256},{514,0}},["download-cloud"]={16898669433,{256,256},{514,514}},["alarm-clock-plus"]={16898612819,{256,256},{514,0}},["circle-dollar-sign"]={16898617884,{256,256},{0,257}},["activity-square"]={16898612629,{256,256},{257,257}},["arrow-up-square"]={16898614574,{256,256},{0,0}},["receipt-pound-sterling"]={16898732855,{256,256},{257,257}},grab={16898672599,{256,256},{514,257}},["align-center-horizontal"]={16898613044,{256,256},{514,0}},undo={16898789451,{256,256},{0,0}},ratio={16898732665,{256,256},{514,514}},minimize={16898728878,{256,256},{0,0}},["user-square-2"]={16898790047,{256,256},{0,514}},heading={16898673115,{256,256},{0,257}},["panel-top-close"]={16898731024,{256,256},{257,514}},["grip-horizontal"]={16898672700,{256,256},{0,257}},["boom-box"]={16898616650,{256,256},{257,0}},package={16898730641,{256,256},{514,0}},["user-round-minus"]={16898789825,{256,256},{514,514}},["file-audio-2"]={16898669984,{256,256},{257,0}},["align-end-horizontal"]={16898613044,{256,256},{514,257}},mountain={16898729337,{256,256},{514,0}},["arrow-down-left-square"]={16898613869,{256,256},{514,257}},["folder-kanban"]={16898671263,{256,256},{0,257}},["octagon-x"]={16898730417,{256,256},{0,0}},languages={16898673999,{256,256},{257,0}},["file-json-2"]={16898670171,{256,256},{257,257}},["alarm-clock-check"]={16898612819,{256,256},{0,0}},["refresh-cw"]={16898733146,{256,256},{257,0}},medal={16898675673,{256,256},{0,0}},["beer-off"]={16898615374,{256,256},{514,257}},["search-code"]={16898734065,{256,256},{257,514}},["square-parking-off"]={16898736237,{256,256},{0,257}},["notebook-text"]={16898730298,{256,256},{257,0}},["arrow-right-to-line"]={16898614275,{256,256},{0,257}},["ticket-minus"]={16898788660,{256,256},{514,257}},["test-tube-diagonal"]={16898788248,{256,256},{514,514}},["rows-4"]={16898733534,{256,256},{0,0}},["pencil-line"]={16898731419,{256,256},{0,514}},["door-open"]={16898669433,{256,256},{514,257}},["arrow-down-circle"]={16898613869,{256,256},{514,0}},["pen-line"]={16898731419,{256,256},{257,0}},file={16898670620,{256,256},{0,514}},["git-compare"]={16898672316,{256,256},{514,257}},["pocket-knife"]={16898732061,{256,256},{257,257}},["book-copy"]={16898616080,{256,256},{0,257}},["panel-left-inactive"]={16898730821,{256,256},{514,514}},["car-front"]={16898617249,{256,256},{257,0}},["align-start-horizontal"]={16898613509,{256,256},{257,0}},["reply-all"]={16898733317,{256,256},{257,0}},["cloud-moon-rain"]={16898618763,{256,256},{257,514}},["clipboard-type"]={16898618392,{256,256},{514,0}},["contact-2"]={16898619347,{256,256},{257,257}},["list-todo"]={16898674572,{256,256},{514,257}},tablets={16898788033,{256,256},{257,0}},["pie-chart"]={16898731819,{256,256},{0,0}},["list-start"]={16898674572,{256,256},{0,514}},milestone={16898728659,{256,256},{0,514}},["a-large-small"]={16898612629,{256,256},{0,257}},ship={16898734664,{256,256},{514,0}},["percent-circle"]={16898731539,{256,256},{0,0}},radiation={16898732504,{256,256},{514,514}},["code-2"]={16898619015,{256,256},{0,257}},["tablet-smartphone"]={16898787819,{256,256},{514,514}},["phone-forwarded"]={16898731539,{256,256},{514,257}},["gallery-vertical"]={16898672004,{256,256},{514,514}},["arrow-right-from-line"]={16898614166,{256,256},{514,514}},webcam={16898790996,{256,256},{0,0}},["square-power"]={16898736398,{256,256},{257,0}},["circle-help"]={16898617944,{256,256},{0,0}},["bring-to-front"]={16898616757,{256,256},{257,514}},archive={16898613699,{256,256},{257,514}},figma={16898669897,{256,256},{514,514}},school={16898733817,{256,256},{514,257}},download={16898669562,{256,256},{0,0}},piano={16898731683,{256,256},{0,514}},["line-chart"]={16898674482,{256,256},{0,0}},folders={16898671684,{256,256},{0,257}},["mail-warning"]={16898675156,{256,256},{514,257}},vault={16898790259,{256,256},{514,514}},["pause-circle"]={16898731301,{256,256},{0,514}},["mic-2"]={16898728402,{256,256},{514,514}},["chevrons-left-right"]={16898617626,{256,256},{0,257}},redo={16898733036,{256,256},{514,257}},["file-lock"]={16898670241,{256,256},{257,0}},radar={16898732504,{256,256},{257,514}},["circle-fading-plus"]={16898617884,{256,256},{257,514}},workflow={16898791187,{256,256},{514,0}},["undo-dot"]={16898789303,{256,256},{514,514}},target={16898788248,{256,256},{257,0}},["corner-left-down"]={16898668288,{256,256},{514,0}},["indent-increase"]={16898673523,{256,256},{0,0}},drama={16898669562,{256,256},{0,257}},["arrow-down-up"]={16898614020,{256,256},{514,257}},baseline={16898615240,{256,256},{0,0}},martini={16898675359,{256,256},{514,257}},contrast={16898619347,{256,256},{514,514}},["shield-ban"]={16898734564,{256,256},{257,0}},syringe={16898787819,{256,256},{0,0}},["chevron-left-circle"]={16898617509,{256,256},{0,0}},["book-check"]={16898616080,{256,256},{257,0}},["nut-off"]={16898730298,{256,256},{0,514}},["book-lock"]={16898616322,{256,256},{0,0}},["panel-right-inactive"]={16898731024,{256,256},{257,257}},["briefcase-medical"]={16898616757,{256,256},{0,514}},bookmark={16898616650,{256,256},{0,0}},["heading-5"]={16898673115,{256,256},{0,0}},["align-vertical-justify-end"]={16898613509,{256,256},{257,514}},["hop-off"]={16898673271,{256,256},{514,514}},warehouse={16898790791,{256,256},{257,257}},["plus-square"]={16898732061,{256,256},{0,257}},["drafting-compass"]={16898669562,{256,256},{257,0}},["save-all"]={16898733674,{256,256},{257,0}},["plus-circle"]={16898732061,{256,256},{257,0}},["square-sigma"]={16898736398,{256,256},{257,257}},["clipboard-signature"]={16898618392,{256,256},{0,257}},["fold-horizontal"]={16898671019,{256,256},{514,257}},["notepad-text-dashed"]={16898730298,{256,256},{514,0}},["glass-water"]={16898672599,{256,256},{0,0}},["book-headphones"]={16898616080,{256,256},{0,514}},["credit-card"]={16898668482,{256,256},{0,257}},["message-circle"]={16898675863,{256,256},{0,0}},["square-pilcrow"]={16898736237,{256,256},{257,514}},radical={16898732665,{256,256},{0,0}},["tally-3"]={16898788033,{256,256},{514,257}},["panel-bottom-open"]={16898730821,{256,256},{257,257}},["kanban-square-dashed"]={16898673616,{256,256},{514,0}},["book-audio"]={16898616080,{256,256},{0,0}},["file-search-2"]={16898670367,{256,256},{257,257}},["receipt-russian-ruble"]={16898732855,{256,256},{0,514}},["square-arrow-up-left"]={16898735664,{256,256},{0,257}},["locate-fixed"]={16898674684,{256,256},{0,514}},["clock-9"]={16898618583,{256,256},{514,514}},pen={16898731419,{256,256},{257,257}},["navigation-2"]={16898730065,{256,256},{0,257}},["candy-cane"]={16898617146,{256,256},{257,257}},["book-open"]={16898616322,{256,256},{0,514}},["user-check-2"]={16898789644,{256,256},{0,514}},["gamepad-2"]={16898672166,{256,256},{0,0}},["badge-info"]={16898614945,{256,256},{0,514}},wheat={16898790996,{256,256},{0,514}},["roller-coaster"]={16898733317,{256,256},{257,514}},["arrow-down-right-square"]={16898614020,{256,256},{257,0}},["shield-minus"]={16898734564,{256,256},{0,514}},thermometer={16898788660,{256,256},{0,257}},dessert={16898668755,{256,256},{257,514}},eclipse={16898669689,{256,256},{0,514}},church={16898617705,{256,256},{0,0}},combine={16898619182,{256,256},{0,514}},cylinder={16898668755,{256,256},{0,257}},["badge-japanese-yen"]={16898614945,{256,256},{514,257}},["calendar-plus-2"]={16898617053,{256,256},{514,0}},["receipt-text"]={16898732855,{256,256},{257,514}},film={16898670620,{256,256},{257,514}},["book-down"]={16898616080,{256,256},{257,257}},asterisk={16898614574,{256,256},{514,257}},cable={16898616879,{256,256},{514,514}},["file-output"]={16898670241,{256,256},{0,514}},["disc-album"]={16898669271,{256,256},{514,0}},["percent-square"]={16898731539,{256,256},{0,257}},["arrow-down-0-1"]={16898613869,{256,256},{0,0}},captions={16898617249,{256,256},{0,0}},diameter={16898668755,{256,256},{514,514}},bone={16898615799,{256,256},{257,514}},["umbrella-off"]={16898789303,{256,256},{257,257}},["badge-alert"]={16898614755,{256,256},{257,514}},flashlight={16898670919,{256,256},{257,257}},["folder-pen"]={16898671463,{256,256},{0,0}},cross={16898668482,{256,256},{0,514}},["badge-dollar-sign"]={16898614945,{256,256},{257,0}},["ice-cream-bowl"]={16898673358,{256,256},{0,514}},worm={16898791187,{256,256},{257,257}},["square-arrow-down-left"]={16898735593,{256,256},{0,257}},["share-2"]={16898734421,{256,256},{0,514}},["circle-arrow-out-down-right"]={16898617705,{256,256},{257,514}},["ear-off"]={16898669689,{256,256},{257,0}},wifi={16898790996,{256,256},{514,514}},["message-square-off"]={16898675863,{256,256},{257,514}},["tv-2"]={16898789153,{256,256},{514,514}},fish={16898670775,{256,256},{0,514}},sliders={16898735040,{256,256},{257,257}},["stretch-horizontal"]={16898736967,{256,256},{0,0}},currency={16898668755,{256,256},{257,0}},coffee={16898619015,{256,256},{257,514}},["message-circle-reply"]={16898675752,{256,256},{514,257}},route={16898733415,{256,256},{0,514}},["triangle-right"]={16898789153,{256,256},{514,0}},["folder-clock"]={16898671139,{256,256},{257,0}},["circle-off"]={16898617944,{256,256},{0,257}},["message-square-plus"]={16898675863,{256,256},{514,514}},type={16898789303,{256,256},{514,0}},webhook={16898790996,{256,256},{0,257}},["candlestick-chart"]={16898617146,{256,256},{514,0}},phone={16898731683,{256,256},{0,257}},["package-2"]={16898730417,{256,256},{0,514}},["chevrons-left"]={16898617626,{256,256},{514,0}},["pointer-off"]={16898732061,{256,256},{257,514}},turtle={16898789153,{256,256},{257,514}},camera={16898617146,{256,256},{0,257}},["thermometer-snowflake"]={16898788660,{256,256},{0,0}},clipboard={16898618392,{256,256},{0,514}},["send-horizontal"]={16898734242,{256,256},{0,257}},["bluetooth-searching"]={16898615799,{256,256},{0,257}},["arrow-up-to-line"]={16898614574,{256,256},{257,0}},["wrap-text"]={16898791187,{256,256},{0,514}},["file-check-2"]={16898670072,{256,256},{0,0}},["badge-percent"]={16898614945,{256,256},{514,514}},shuffle={16898734792,{256,256},{514,0}},refrigerator={16898733146,{256,256},{0,257}},["rows-3"]={16898733415,{256,256},{514,514}},sigma={16898734792,{256,256},{0,514}},["milk-off"]={16898728659,{256,256},{514,257}},["file-check"]={16898670072,{256,256},{257,0}},["pin-off"]={16898731819,{256,256},{0,514}},["clock-1"]={16898618392,{256,256},{514,257}},["file-heart"]={16898670171,{256,256},{257,0}},beaker={16898615240,{256,256},{514,514}},space={16898735175,{256,256},{0,514}},users={16898790259,{256,256},{514,0}},["shield-question"]={16898734564,{256,256},{514,514}},["arrow-up-circle"]={16898614275,{256,256},{257,514}},["corner-up-left"]={16898668288,{256,256},{257,514}},["clock-6"]={16898618583,{256,256},{0,514}},["layout-dashboard"]={16898674182,{256,256},{0,257}},["key-round"]={16898673616,{256,256},{514,257}},headphones={16898673115,{256,256},{514,0}},tv={16898789303,{256,256},{0,0}},["brain-circuit"]={16898616757,{256,256},{0,0}},["bar-chart-horizontal-big"]={16898615143,{256,256},{0,514}},rss={16898733534,{256,256},{0,257}},["file-stack"]={16898670469,{256,256},{0,0}},["at-sign"]={16898614574,{256,256},{257,514}},code={16898619015,{256,256},{257,257}},["calendar-minus"]={16898617053,{256,256},{257,0}},music={16898730065,{256,256},{0,0}},handshake={16898672829,{256,256},{514,257}},["graduation-cap"]={16898672599,{256,256},{257,514}},tornado={16898788789,{256,256},{514,514}},["copy-plus"]={16898619423,{256,256},{257,257}},stamp={16898736597,{256,256},{257,514}},cherry={16898617411,{256,256},{514,0}},shrink={16898734792,{256,256},{257,0}},["circle-arrow-out-up-right"]={16898617803,{256,256},{0,0}},meh={16898675673,{256,256},{514,0}},["search-check"]={16898734065,{256,256},{514,257}},crop={16898668482,{256,256},{257,257}},["columns-2"]={16898619182,{256,256},{257,0}},["mouse-pointer-square"]={16898729337,{256,256},{257,514}},["indent-decrease"]={16898673447,{256,256},{514,514}},["align-center-vertical"]={16898613044,{256,256},{257,257}},["wand-2"]={16898790791,{256,256},{257,0}},anvil={16898613699,{256,256},{0,0}},["align-start-vertical"]={16898613509,{256,256},{0,257}},["cloud-fog"]={16898618763,{256,256},{257,257}},accessibility={16898612629,{256,256},{514,0}},layers={16898674182,{256,256},{257,0}},["percent-diamond"]={16898731539,{256,256},{257,0}},["package-check"]={16898730417,{256,256},{514,257}},["chevron-first"]={16898617411,{256,256},{257,514}},pencil={16898731419,{256,256},{257,514}},["database-backup"]={16898668755,{256,256},{514,0}},["list-x"]={16898674684,{256,256},{0,0}},shapes={16898734421,{256,256},{257,257}},["move-down"]={16898729572,{256,256},{514,257}},["corner-up-right"]={16898668288,{256,256},{514,514}},computer={16898619347,{256,256},{0,0}},pin={16898731819,{256,256},{514,257}},["phone-off"]={16898731683,{256,256},{0,0}},["clipboard-x"]={16898618392,{256,256},{257,257}},fullscreen={16898672004,{256,256},{0,257}},["align-horizontal-distribute-start"]={16898613353,{256,256},{257,0}},["redo-dot"]={16898733036,{256,256},{0,514}},["cloud-moon"]={16898618763,{256,256},{514,514}},["stretch-vertical"]={16898736967,{256,256},{257,0}},["message-square-warning"]={16898728402,{256,256},{257,257}},["file-plus"]={16898670367,{256,256},{257,0}},["git-pull-request-arrow"]={16898672450,{256,256},{257,0}},guitar={16898672700,{256,256},{514,257}},tangent={16898788248,{256,256},{0,0}},["bell-dot"]={16898615374,{256,256},{514,514}},["panel-bottom"]={16898730821,{256,256},{0,514}},["flame-kindling"]={16898670919,{256,256},{257,0}},["table-2"]={16898787819,{256,256},{257,0}},["align-horizontal-space-around"]={16898613353,{256,256},{0,514}},server={16898734421,{256,256},{257,0}},["briefcase-business"]={16898616757,{256,256},{257,257}},diamond={16898669042,{256,256},{257,0}},blinds={16898615570,{256,256},{257,514}},weight={16898790996,{256,256},{514,0}},candy={16898617146,{256,256},{514,257}},["volume-1"]={16898790615,{256,256},{0,0}},["table-properties"]={16898787819,{256,256},{0,514}},["git-fork"]={16898672316,{256,256},{257,514}},recycle={16898733036,{256,256},{514,0}},["mountain-snow"]={16898729337,{256,256},{0,257}},luggage={16898674825,{256,256},{514,257}},["divide-square"]={16898669271,{256,256},{514,257}},["folder-minus"]={16898671263,{256,256},{0,514}},["phone-outgoing"]={16898731683,{256,256},{257,0}},["smartphone-charging"]={16898735040,{256,256},{0,514}},banknote={16898615143,{256,256},{0,0}},["train-track"]={16898789012,{256,256},{0,0}},["folder-up"]={16898671463,{256,256},{514,514}},["circle-percent"]={16898617944,{256,256},{514,257}},["bell-plus"]={16898615428,{256,256},{514,0}},fan={16898669897,{256,256},{514,0}},["disc-2"]={16898669271,{256,256},{257,0}},["git-pull-request-draft"]={16898672450,{256,256},{0,514}},coins={16898619182,{256,256},{0,0}},["square-divide"]={16898736072,{256,256},{0,0}},scroll={16898734065,{256,256},{0,514}},["circle-arrow-right"]={16898617803,{256,256},{257,0}},["candy-off"]={16898617146,{256,256},{0,514}},["square-pi"]={16898736237,{256,256},{514,257}},["arrow-left-right"]={16898614166,{256,256},{514,0}},["lightbulb-off"]={16898674337,{256,256},{257,514}},["panels-top-left"]={16898731166,{256,256},{0,514}},["move-up-right"]={16898729752,{256,256},{0,257}},["message-square-share"]={16898728402,{256,256},{0,257}},annoyed={16898613613,{256,256},{257,514}},["test-tube"]={16898788479,{256,256},{0,0}},["user-circle"]={16898789644,{256,256},{514,514}},["cooking-pot"]={16898619423,{256,256},{257,0}},["case-lower"]={16898617249,{256,256},{514,257}},["alarm-clock-minus"]={16898612819,{256,256},{257,0}},["square-user"]={16898736597,{256,256},{0,257}},square={16898736597,{256,256},{257,257}},["mail-open"]={16898675156,{256,256},{0,257}},["square-function"]={16898736072,{256,256},{514,0}},["arrow-up-left-from-circle"]={16898614410,{256,256},{0,257}},variable={16898790259,{256,256},{257,514}},["arrow-up-right-square"]={16898614410,{256,256},{257,514}},["badge-indian-rupee"]={16898614945,{256,256},{257,257}}}}

local EmbeddedLucide = {
	PackageVersion = "0.1.3",
	LucideVersion = "0.363.0",
}

local function trimIconName(iconName)
	return string.match(string.lower(iconName), "^%s*(.-)%s*$")
end

do
	local names = {}
	for iconName in pairs(EMBEDDED_LUCIDE_DATA["48px"]) do
		table.insert(names, iconName)
	end
	table.sort(names)
	EmbeddedLucide.IconNames = names
end

function EmbeddedLucide.GetAsset(iconName, iconSize)
	if type(iconName) ~= "string" then
		error("Lucide.GetAsset: iconName must be a string", 2)
	end
	iconSize = iconSize == nil and 256 or tonumber(iconSize)
	if not iconSize then
		error("Lucide.GetAsset: iconSize must be a number", 2)
	end
	iconSize = math.abs(iconSize)

	local bucketName = iconSize <= 48 and "48px" or "256px"
	local normalizedName = trimIconName(iconName)
	local rawAsset = EMBEDDED_LUCIDE_DATA[bucketName][normalizedName]
	if not rawAsset then
		error("Lucide.GetAsset: unknown icon '" .. normalizedName .. "'", 2)
	end

	return {
		IconName = normalizedName,
		Id = rawAsset[1],
		Url = "rbxassetid://" .. tostring(rawAsset[1]),
		ImageRectSize = Vector2.new(rawAsset[2][1], rawAsset[2][2]),
		ImageRectOffset = Vector2.new(rawAsset[3][1], rawAsset[3][2]),
	}
end

function EmbeddedLucide.GetAllAssets(iconSize)
	local assets = {}
	for _, iconName in ipairs(EmbeddedLucide.IconNames) do
		table.insert(assets, EmbeddedLucide.GetAsset(iconName, iconSize))
	end
	return assets
end

function EmbeddedLucide.ImageLabel(iconName, imageSize, propertyOverrides)
	imageSize = imageSize == nil and 256 or imageSize
	propertyOverrides = propertyOverrides or {}
	local asset = EmbeddedLucide.GetAsset(iconName, imageSize)
	local image = Instance.new("ImageLabel")
	image.Name = asset.IconName
	image.BackgroundTransparency = 1
	image.BorderSizePixel = 0
	image.Image = asset.Url
	image.ImageColor3 = Color3.new(1, 1, 1)
	image.ImageRectOffset = asset.ImageRectOffset
	image.ImageRectSize = asset.ImageRectSize
	image.ScaleType = Enum.ScaleType.Fit
	image.Size = UDim2.fromOffset(imageSize, imageSize)
	for property, value in pairs(propertyOverrides) do
		if property ~= "Parent" then image[property] = value end
	end
	if propertyOverrides.Parent then image.Parent = propertyOverrides.Parent end
	return image
end

PrismUI.Lucide = EmbeddedLucide
PrismUI.IconNames = EmbeddedLucide.IconNames
-- These direct assets are retained as lightweight fallbacks and custom
-- overrides. The complete embedded Lucide provider above resolves all bundled
-- icon names. Numbers, rbxassetid://, rbxasset://, rbxthumb:// and http(s)
-- image strings are still accepted anywhere an Icon is used.
PrismUI.Icons = {
	["activity"] = 7733655755,
	["bell"] = 7733911828,
	["check"] = 7733715400,
	["chevron-down"] = 7733717447,
	["chevron-right"] = 7733717755,
	["eye-off"] = 7733774495,
	["home"] = 7733960981,
	["layout-dashboard"] = 7733970318,
	["loader"] = 7733992358,
	["lock"] = 7733992528,
	["menu"] = 7733993211,
	["minimize-2"] = 7733997870,
	["palette"] = 7734021595,
	["refresh-ccw"] = 7734050715,
	["search"] = 7734052925,
	["settings"] = 7734053495,
	["shield-check"] = 7734056411,
	["sliders"] = 7734058803,
	["user"] = 7743875962,
	["x-circle"] = 7743878496,
}
PrismUI.IconProvider = EmbeddedLucide

function PrismUI:SetIconProvider(provider)
	self.IconProvider = provider
	return self
end

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
local SPRING = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local PRESS = TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local ROW_HEIGHT = 74

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

local function normalizeIconProvider(provider)
	if typeof(provider) == "Instance" and provider:IsA("ModuleScript") then
		local ok, module = pcall(require, provider)
		if ok then return module end
		warn("[PrismUI] The supplied Lucide ModuleScript could not be required: " .. tostring(module))
		return nil
	end
	return provider
end

local function normalizeImageSource(source)
	if type(source) == "number" then
		return "rbxassetid://" .. tostring(source)
	end
	if type(source) ~= "string" then return nil end
	if tonumber(source) then return "rbxassetid://" .. source end
	if string.match(source, "^rbxassetid://")
		or string.match(source, "^rbxasset://")
		or string.match(source, "^rbxthumb://")
		or string.match(source, "^https?://") then
		return source
	end
	return nil
end

local function iconDescriptor(value)
	local direct = normalizeImageSource(value)
	if direct then return { Image = direct } end
	if type(value) ~= "table" then return nil end

	local source = value.Image or value.Url or value.URL or value.Id or value.AssetId
	direct = normalizeImageSource(source)
	if not direct then return nil end
	return {
		Image = direct,
		ImageRectOffset = value.ImageRectOffset or value.RectOffset,
		ImageRectSize = value.ImageRectSize or value.RectSize,
	}
end

local function resolveIcon(icon, size, provider)
	local direct = iconDescriptor(icon)
	if direct then return direct end
	if type(icon) ~= "string" or icon == "" then return nil end

	local name = string.lower(icon)
	local activeProvider = normalizeIconProvider(provider)
	if activeProvider then
		local result
		local ok = false
		if type(activeProvider) == "function" then
			ok, result = pcall(activeProvider, name, size or 18)
		elseif type(activeProvider) == "table" then
			local getter = activeProvider.GetAsset or activeProvider.getAsset
			if type(getter) == "function" then
				ok, result = pcall(getter, name, size or 18)
				if not ok or not iconDescriptor(result) then
					ok, result = pcall(getter, activeProvider, name, size or 18)
				end
			elseif activeProvider[name] ~= nil then
				ok, result = true, activeProvider[name]
			end
		end
		if ok then
			local provided = iconDescriptor(result)
			if provided then return provided end
		end
	end

	local builtIn = PrismUI.Icons[name]
	return builtIn and iconDescriptor(builtIn) or nil
end

local function createIcon(parent, icon, size, color, properties, provider)
	local descriptor = resolveIcon(icon, size, provider)
	if not descriptor then return nil end
	local iconProperties = {
		Parent = parent,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = descriptor.Image,
		ImageColor3 = color or COLORS.Text,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(size or 18, size or 18),
	}
	if typeof(descriptor.ImageRectOffset) == "Vector2" then
		iconProperties.ImageRectOffset = descriptor.ImageRectOffset
	end
	if typeof(descriptor.ImageRectSize) == "Vector2" then
		iconProperties.ImageRectSize = descriptor.ImageRectSize
	end
	for property, value in pairs(properties or {}) do
		iconProperties[property] = value
	end
	return make("ImageLabel", iconProperties)
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

local function measureTextWidth(text, textSize, font)
	local ok, bounds = pcall(function()
		return TextService:GetTextSize(
			tostring(text or ""),
			textSize or 12,
			font or Enum.Font.Gotham,
			Vector2.new(1000, 100)
		)
	end)
	return ok and bounds.X or (#tostring(text or "") * (textSize or 12) * 0.56)
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
	}, { corner(14) })
	make("UIGradient", {
		Parent = card,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.7, Color3.fromRGB(246, 246, 246)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 236, 236)),
		}),
		Rotation = 96,
	})
	local cardScale = make("UIScale", {
		Parent = card,
		Scale = 1,
	})
	local cardAccent = make("Frame", {
		Name = "HoverAccent",
		Parent = card,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = COLORS.Accent,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.fromOffset(3, 28),
		ZIndex = 2,
	}, { corner(2) })
	local cardStroke = stroke(COLORS.Border, 0.58, 1)
	cardStroke.Parent = card
	card.MouseEnter:Connect(function()
		setThemeBinding(card, "BackgroundColor3", "SurfaceHover")
		setThemeBinding(cardStroke, "Color", "Accent")
		tween(card, { BackgroundColor3 = COLORS.SurfaceHover }, FAST)
		tween(cardStroke, { Color = COLORS.Accent, Transparency = 0.58 }, FAST)
		tween(cardAccent, { BackgroundTransparency = 0.12 }, FAST)
		tween(cardScale, { Scale = 1.006 }, FAST)
	end)
	card.MouseLeave:Connect(function()
		setThemeBinding(card, "BackgroundColor3", "Surface")
		setThemeBinding(cardStroke, "Color", "Border")
		tween(card, { BackgroundColor3 = COLORS.Surface }, FAST)
		tween(cardStroke, { Color = COLORS.Border, Transparency = 0.58 }, FAST)
		tween(cardAccent, { BackgroundTransparency = 1 }, FAST)
		tween(cardScale, { Scale = 1 }, FAST)
	end)
	return card
end

local function addCardText(card, titleText, descriptionText)
	local hasDescription = descriptionText ~= nil and tostring(descriptionText) ~= ""
	local title = label(card, titleText, 14, COLORS.Text, Enum.Font.GothamMedium)
	title.Position = UDim2.fromOffset(20, hasDescription and 11 or 0)
	title.Size = UDim2.new(1, -148, 0, hasDescription and 22 or ROW_HEIGHT)
	title.TextYAlignment = Enum.TextYAlignment.Center

	local description
	if hasDescription then
		description = label(card, descriptionText, 11, COLORS.Muted, Enum.Font.Gotham)
		description.Position = UDim2.fromOffset(20, 36)
		description.Size = UDim2.new(1, -148, 0, 18)
	end

	return title, description
end

-- Window construction ------------------------------------------------------
function PrismUI:CreateWindow(config)
	config = config or {}
	local iconProvider = normalizeIconProvider(config.Lucide or config.IconProvider or self.IconProvider)

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
		UserMoved = false,
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

	-- A real GuiObject root gives both CoreGui and PlayerGui fallbacks the
	-- same rendered coordinate space. Centering against this fixes GUI inset
	-- and device-emulator offsets that camera.ViewportSize alone can miss.
	local uiRoot = screen
	if not usingRobloxGui then
		uiRoot = make("Frame", {
			Name = "Root",
			Parent = screen,
			Active = false,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
		})
	end
	local guiHitTestRoot = usingRobloxGui and CoreGui or playerGui
	local camera = workspace.CurrentCamera
	local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
	local wantedSize = config.Size or Vector2.new(920, 600)
	local initialMinWidth = math.max(300, math.min(440, viewport.X - 16))
	local initialMinHeight = math.max(260, math.min(320, viewport.Y - 16))
	local initialSize = Vector2.new(
		clamp(wantedSize.X, initialMinWidth, math.max(initialMinWidth, viewport.X - 16)),
		clamp(wantedSize.Y, initialMinHeight, math.max(initialMinHeight, viewport.Y - 16))
	)

	local shadow = make("Frame", {
		Name = "Shadow",
		Parent = uiRoot,
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.58,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(
			math.floor((viewport.X - initialSize.X) / 2) + 7,
			math.floor((viewport.Y - initialSize.Y) / 2) + 9
		),
		Size = UDim2.fromOffset(initialSize.X, initialSize.Y),
	}, { corner(18) })
	local shadowScale = make("UIScale", {
		Parent = shadow,
		Scale = 1,
	})

	local main = make("Frame", {
		Name = "Window",
		Parent = uiRoot,
		BackgroundColor3 = COLORS.Background,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.fromOffset(
			math.floor((viewport.X - initialSize.X) / 2),
			math.floor((viewport.Y - initialSize.Y) / 2)
		),
		Size = UDim2.fromOffset(initialSize.X, initialSize.Y),
	}, {
		corner(18),
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
	}, { corner(18) })
	make("UIGradient", {
		Parent = topBar,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 238, 238)),
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
		Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(214, 214, 214)),
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
	title.Position = UDim2.fromOffset(52, 10)
	title.Size = UDim2.new(1, -155, 0, 22)
	title.TextYAlignment = Enum.TextYAlignment.Center

	local subtitle = label(topBar, config.Subtitle or "Interface Library", 11, COLORS.Muted, Enum.Font.Gotham)
	subtitle.Position = UDim2.fromOffset(52, 33)
	subtitle.Size = UDim2.new(1, -155, 0, 17)
	subtitle.TextYAlignment = Enum.TextYAlignment.Center

	local themeBadge = make("Frame", {
		Parent = topBar,
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = COLORS.SurfaceRaised,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -142, 0.5, 0),
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
		}, { corner(10) })
		local buttonScale = make("UIScale", { Parent = button, Scale = 1 })
		addHover(button, COLORS.SurfaceRaised, hoverColor)
		button.MouseButton1Down:Connect(function()
			tween(buttonScale, { Scale = 0.9 }, PRESS)
		end)
		button.MouseButton1Up:Connect(function()
			tween(buttonScale, { Scale = 1 }, SPRING)
		end)
		return button
	end

	local discordButton = topButton(-112, COLORS.SurfaceHover)
	discordButton.Name = "DiscordButton"
	discordButton.Visible = config.ShowDiscordButton ~= false
	local minimizeButton = topButton(-72, COLORS.SurfaceHover)
	local closeButton = topButton(-32, COLORS.Danger)
	local discordIcon = createIcon(discordButton, config.DiscordIcon or "gamepad-2", 15, COLORS.Muted, { ZIndex = 2 }, iconProvider)
	if not discordIcon then
		discordIcon = createIcon(discordButton, "gamepad-2", 15, COLORS.Muted, { ZIndex = 2 }, iconProvider)
	end
	local minimizeIcon = createIcon(minimizeButton, "minimize-2", 15, COLORS.Muted, { ZIndex = 2 }, iconProvider)
	local closeIcon = createIcon(closeButton, "x-circle", 15, COLORS.Muted, { ZIndex = 2 }, iconProvider)
	if discordIcon then
		discordButton.MouseEnter:Connect(function()
			setThemeBinding(discordIcon, "ImageColor3", "Accent")
			tween(discordIcon, { ImageColor3 = COLORS.Accent }, FAST)
		end)
		discordButton.MouseLeave:Connect(function()
			setThemeBinding(discordIcon, "ImageColor3", "Muted")
			tween(discordIcon, { ImageColor3 = COLORS.Muted }, FAST)
		end)
	end
	minimizeButton.MouseEnter:Connect(function()
		setThemeBinding(minimizeIcon, "ImageColor3", "Text")
		tween(minimizeIcon, { ImageColor3 = COLORS.Text }, FAST)
	end)
	minimizeButton.MouseLeave:Connect(function()
		setThemeBinding(minimizeIcon, "ImageColor3", "Muted")
		tween(minimizeIcon, { ImageColor3 = COLORS.Muted }, FAST)
	end)
	closeButton.MouseEnter:Connect(function()
		setThemeBinding(closeIcon, "ImageColor3", "Text")
		tween(closeIcon, { ImageColor3 = COLORS.Text }, FAST)
	end)
	closeButton.MouseLeave:Connect(function()
		setThemeBinding(closeIcon, "ImageColor3", "Muted")
		tween(closeIcon, { ImageColor3 = COLORS.Muted }, FAST)
	end)

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
	local avatarImage = make("ImageLabel", {
		Name = "Avatar",
		Parent = readyDot,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "",
		Size = UDim2.fromScale(1, 1),
		Visible = false,
		ZIndex = 2,
	}, { corner(10) })
	task.spawn(function()
		local ok, image = pcall(function()
			return Players:GetUserThumbnailAsync(
				localPlayer.UserId,
				Enum.ThumbnailType.HeadShot,
				Enum.ThumbnailSize.Size100x100
			)
		end)
		if ok and avatarImage.Parent then
			avatarImage.Image = image
			avatarImage.Visible = true
			initialLabel.Visible = false
		end
	end)
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
	local ambientGlow = make("Frame", {
		Name = "AmbientGlow",
		Parent = content,
		BackgroundColor3 = COLORS.Accent,
		BackgroundTransparency = 0.94,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 112),
	})
	make("UIGradient", {
		Parent = ambientGlow,
		Rotation = 90,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.18),
			NumberSequenceKeypoint.new(1, 1),
		}),
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
	local searchIcon = createIcon(searchFrame, "search", 16, COLORS.Muted, {
		Position = UDim2.new(0, 23, 0.5, 0),
	}, iconProvider)
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
		Parent = uiRoot,
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
	local customLogo = config.Logo and createIcon(reopenButton, config.Logo, 23, COLORS.Text, {
		ZIndex = 2,
	}, iconProvider)
	if not customLogo then
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
			Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(214, 214, 214)),
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
	reopenButton.MouseEnter:Connect(function()
		if reopenButton.Visible then
			tween(reopenScale, { Scale = 1.07 }, SPRING)
		end
	end)
	reopenButton.MouseLeave:Connect(function()
		if reopenButton.Visible then tween(reopenScale, { Scale = 1 }, FAST) end
	end)

	local notificationRoot = make("Frame", {
		Name = "Notifications",
		Parent = uiRoot,
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
	window.IconProvider = iconProvider
	window.DiscordButton = discordButton
	window.AvatarImage = avatarImage
	function window:ResolveIcon(icon, size)
		return resolveIcon(icon, size, self.IconProvider)
	end

	local expandedSize = main.Size
	local expandedPosition = main.Position
	local function syncShadow()
		shadow.Visible = main.Visible
		shadow.Position = UDim2.fromOffset(main.Position.X.Offset + 7, main.Position.Y.Offset + 9)
		shadow.Size = main.Size
	end

	local function getViewport()
		local renderedSize = uiRoot.AbsoluteSize
		if renderedSize.X > 0 and renderedSize.Y > 0 then
			return renderedSize
		end
		local currentCamera = workspace.CurrentCamera
		return currentCamera and currentCamera.ViewportSize or Vector2.new(1280, 720)
	end
	local function getRootPosition(guiObject)
		return guiObject.AbsolutePosition - uiRoot.AbsolutePosition
	end

	function window:Center()
		if self.Destroyed then return end
		local currentViewport = getViewport()
		local sourceSize = (self.Minimized or self.VisibilityBusy) and expandedSize or main.Size
		local centered = UDim2.fromOffset(
			math.floor((currentViewport.X - sourceSize.X.Offset) / 2),
			math.floor((currentViewport.Y - sourceSize.Y.Offset) / 2)
		)
		expandedPosition = centered
		self.UserMoved = false
		if not self.Minimized and not self.VisibilityBusy then
			main.Position = centered
			syncShadow()
		end
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
		reopenPositionStart = getRootPosition(reopenButton)
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
			title.Size = UDim2.new(1, -190, 0, 21)
			subtitle.Size = UDim2.new(1, -190, 0, 16)
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
				tab.Button.Size = UDim2.fromOffset(132, 42)
			end
		else
			local sidebarWidth = width < 720 and 168 or 200
			themeBadge.Visible = width >= 760
			sidebarFooter.Visible = true
			sidebarBottomFill.Visible = false
			pageHeading.Visible = width >= 720 and not compactHeight
			pageHint.Visible = width >= 720 and not compactHeight
			contentDivider.Visible = not compactHeight
			title.Size = UDim2.new(1, width >= 760 and -310 or -200, 0, 21)
			subtitle.Size = UDim2.new(1, width >= 760 and -310 or -200, 0, 16)
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

	local function isInteractiveAtPoint(point, inputType)
		if inputType == Enum.UserInputType.Touch then
			if pointInside(tabList, point) then
				return true
			end
			for _, tab in ipairs(window.Tabs) do
				if tab.Page.Visible and pointInside(tab.Page, point) then
					return true
				end
			end
		end
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
					-- A touch that begins anywhere inside a scrolling region belongs to
					-- that region. This prevents mobile swipes from moving the window.
					if inputType == Enum.UserInputType.Touch then
						return true
					end
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
		if isInteractiveAtPoint(point, input.UserInputType) then
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
		if delta.Magnitude > 3 then
			window.UserMoved = true
		end
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
		window.UserMoved = true
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
			local origin = getRootPosition(reopenButton)
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
			local target = getRootPosition(reopenButton)
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
		if window.UserMoved then
			expandedPosition = UDim2.fromOffset(
				clamp(expandedPosition.X.Offset, 8, math.max(8, currentViewport.X - width - 8)),
				expandedPosition.Y.Offset
			)
		else
			expandedPosition = UDim2.fromOffset(
				math.floor((currentViewport.X - width) / 2),
				math.floor((currentViewport.Y - height) / 2)
			)
		end
		updateResponsiveLayout(expandedSize)

		if not preserveExpandedState then
			main.Size = expandedSize
			if not window.UserMoved then
				main.Position = expandedPosition
			end
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
	connect(uiRoot:GetPropertyChangedSignal("AbsoluteSize"), fitToViewport)
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

	-- Custom notification API; no separate event bridge is required.
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
			BackgroundColor3 = COLORS.SurfaceRaised,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			GroupTransparency = 0,
			LayoutOrder = notificationOrder,
			Size = UDim2.new(1, 0, 0, hasActions and 134 or 96),
			ZIndex = 201,
		}, {
			corner(13),
			stroke(COLORS.Accent, 0.38, 1),
		})
		local toastScale = make("UIScale", {
			Parent = toast,
			Scale = 0.88,
		})
		make("UIGradient", {
			Parent = toast,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(0.55, Color3.fromRGB(246, 246, 246)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(234, 234, 234)),
			}),
			Rotation = 104,
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
		local toastIcon = createIcon(iconPlate, notification.Icon or "bell", 18, COLORS.Accent, {
			ZIndex = 203,
		}, iconProvider)
		if not toastIcon then
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
			tween(toastScale, { Scale = 1 }, SPRING)
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

	-- Tabs own their page and expose all public element constructors below.
	function window:CreateTab(tabConfig)
		tabConfig = type(tabConfig) == "table" and tabConfig or { Name = tostring(tabConfig) }
		local tab = {
			Window = window,
			Elements = {},
			Sections = {},
			Name = tabConfig.Name or "Tab",
			Description = tabConfig.Description or "Browse and configure controls",
			IconName = tabConfig.Icon,
			IsActive = false,
			IsHovered = false,
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
		}, { corner(11) })
		make("UIGradient", {
			Parent = tabButton,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240)),
			}),
			Rotation = 6,
		})
		local tabScale = make("UIScale", {
			Parent = tabButton,
			Scale = 1,
		})

		local tabAccent = make("Frame", {
			Parent = tabButton,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = window.Accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.fromOffset(3, 24),
		}, { corner(2) })

		local tabIconPlate = make("Frame", {
			Parent = tabButton,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = COLORS.SurfaceRaised,
			BackgroundTransparency = 0.42,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 10, 0.5, 0),
			Size = UDim2.fromOffset(28, 28),
		}, { corner(9) })
		local hasRequestedIcon = tabConfig.Icon ~= nil
			and tabConfig.Icon ~= false
			and tostring(tabConfig.Icon) ~= ""
		tabIconPlate.Visible = hasRequestedIcon
		local tabIcon = hasRequestedIcon
			and createIcon(tabIconPlate, tabConfig.Icon, 15, COLORS.Muted, nil, iconProvider)
			or nil
		local tabFallback
		if hasRequestedIcon and not tabIcon then
			tabFallback = label(tabIconPlate, string.upper(string.sub(tab.Name, 1, 1)), 10, COLORS.Muted, Enum.Font.GothamBold)
			tabFallback.Size = UDim2.fromScale(1, 1)
			tabFallback.TextXAlignment = Enum.TextXAlignment.Center
			tabFallback.TextYAlignment = Enum.TextYAlignment.Center
		end

		local tabText = label(tabButton, tab.Name, 12, COLORS.Muted, Enum.Font.GothamMedium)
		tabText.Position = UDim2.fromOffset(hasRequestedIcon and 49 or 16, 0)
		tabText.Size = UDim2.new(1, hasRequestedIcon and -58 or -26, 1, 0)
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
				Padding = UDim.new(0, 14),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			make("UIPadding", {
				PaddingBottom = UDim.new(0, 14),
				PaddingRight = UDim.new(0, 7),
			}),
		})
		local pageScale = make("UIScale", {
			Parent = page,
			Scale = 1,
		})

		tab.Button = tabButton
		tab.Page = page
		tab.Accent = tabAccent
		tab.Text = tabText
		tab.IconPlate = tabIconPlate
		tab.Icon = tabIcon or tabFallback
		tab.Scale = tabScale
		tab.PageScale = pageScale

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
				tostring(elementConfig.Name or "") .. " "
					.. tostring(elementConfig.Description or "") .. " "
					.. tostring(elementConfig.LockReason or "")
			)

			local card = handle.Instance
			if card and card:IsA("GuiObject") then
				local lockOverlay = make("CanvasGroup", {
					Name = "Lockdown",
					Parent = card,
					Active = true,
					BackgroundColor3 = COLORS.Surface,
					BackgroundTransparency = 0.04,
					BorderSizePixel = 0,
					GroupTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Visible = false,
					ZIndex = 40,
				}, {
					corner(14),
					stroke(COLORS.Accent, 0.62, 1),
				})
				make("UIGradient", {
					Parent = lockOverlay,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.62, Color3.fromRGB(242, 242, 242)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 226, 226)),
					}),
					Rotation = 4,
				})
				local lockScale = make("UIScale", {
					Parent = lockOverlay,
					Scale = 0.97,
				})
				local lockPlate = make("Frame", {
					Parent = lockOverlay,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = COLORS.Accent,
					BackgroundTransparency = 0.14,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 16, 0.5, 0),
					Size = UDim2.fromOffset(38, 38),
					ZIndex = 42,
				}, { corner(12) })
				local lockPlateScale = make("UIScale", {
					Parent = lockPlate,
					Scale = 1,
				})
				local lockIcon = createIcon(lockPlate, "lock", 17, COLORS.Text, {
					ZIndex = 43,
				}, iconProvider)
				local lockTitle = label(lockOverlay, tostring(elementConfig.LockTitle or "Locked"), 12, COLORS.Text, Enum.Font.GothamBold)
				lockTitle.Position = UDim2.new(0, 66, 0.5, -19)
				lockTitle.Size = UDim2.new(1, -86, 0, 20)
				lockTitle.TextYAlignment = Enum.TextYAlignment.Center
				lockTitle.ZIndex = 42
				local lockReason = label(lockOverlay, tostring(elementConfig.LockReason or "This control is currently unavailable."), 10, COLORS.Muted, Enum.Font.Gotham)
				lockReason.Position = UDim2.new(0, 66, 0.5, 1)
				lockReason.Size = UDim2.new(1, -86, 0, 18)
				lockReason.TextYAlignment = Enum.TextYAlignment.Center
				lockReason.ZIndex = 42
				local lockBlocker = make("TextButton", {
					Parent = lockOverlay,
					Active = true,
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.fromScale(1, 1),
					Text = "",
					ZIndex = 44,
				})

				handle.Locked = false
				handle.LockReason = tostring(elementConfig.LockReason or "This control is currently unavailable.")
				handle.LockOverlay = lockOverlay

				local lockAnimationId = 0
				function handle:SetLocked(locked, reason)
					locked = locked == true
					if reason ~= nil then
						self.LockReason = tostring(reason)
						lockReason.Text = self.LockReason
						self.SearchText = string.lower(self.SearchText .. " " .. self.LockReason)
					end
					if self.Locked == locked and lockOverlay.Visible == locked then return end
					self.Locked = locked
					card:SetAttribute("PrismLocked", locked)
					lockAnimationId = lockAnimationId + 1
					local animationId = lockAnimationId

					if locked then
						if self.OpenState and self.Close then self:Close() end
						lockOverlay.Visible = true
						lockOverlay.GroupTransparency = 1
						lockScale.Scale = 0.965
						lockPlateScale.Scale = 0.72
						tween(lockOverlay, { GroupTransparency = 0 }, SMOOTH)
						tween(lockScale, { Scale = 1 }, SPRING)
						tween(lockPlateScale, { Scale = 1 }, SPRING)
					else
						tween(lockOverlay, { GroupTransparency = 1 }, FAST)
						tween(lockScale, { Scale = 0.975 }, FAST)
						task.delay(FAST.Time, function()
							if lockOverlay.Parent and lockAnimationId == animationId and not self.Locked then
								lockOverlay.Visible = false
							end
						end)
					end
				end

				function handle:IsLocked()
					return self.Locked
				end

				connect(lockBlocker.Activated, function()
					tween(lockPlateScale, { Scale = 0.82 }, PRESS)
					if lockIcon then tween(lockIcon, { Rotation = -8 }, PRESS) end
					task.delay(0.1, function()
						if lockPlate.Parent then tween(lockPlateScale, { Scale = 1 }, SPRING) end
						if lockIcon and lockIcon.Parent then tween(lockIcon, { Rotation = 0 }, SPRING) end
					end)
					callback(elementConfig.LockedCallback, handle.LockReason)
				end)

				if elementConfig.Locked == true then
					handle:SetLocked(true, handle.LockReason)
				end
			end

			table.insert(tab.Elements, handle)
			if window.ActiveTab == tab then
				tab:ApplySearch(searchBox.Text)
			end
			return handle
		end

		function tab:RenderNavigation(instant)
			local active = self.IsActive
			local hovered = self.IsHovered and not active
			local backgroundKey = active and "SurfaceRaised" or (hovered and "SurfaceHover" or "Surface")
			local textKey = (active or hovered) and "Text" or "Muted"
			local iconKey = active and "Text" or (hovered and "Accent" or "Muted")
			local plateKey = active and "Accent" or (hovered and "SurfaceRaised" or "SurfaceRaised")
			local properties = {
				BackgroundColor3 = COLORS[backgroundKey],
				BackgroundTransparency = active and 0.08 or (hovered and 0.22 or 1),
			}
			local accentTransparency = active and 0 or (hovered and 0.44 or 1)
			local plateTransparency = active and 0.08 or (hovered and 0.18 or 0.42)
			local targetScale = active and 1.01 or (hovered and 1.018 or 1)
			local idleTextX = self.Icon and 49 or 16
			local targetTextPosition = UDim2.fromOffset(
				idleTextX + (active and 3 or (hovered and 2 or 0)),
				0
			)

			setThemeBinding(self.Button, "BackgroundColor3", backgroundKey)
			setThemeBinding(self.Text, "TextColor3", textKey)
			setThemeBinding(self.IconPlate, "BackgroundColor3", plateKey)
			if self.Icon then setThemeBinding(self.Icon, self.Icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3", iconKey) end

			if instant then
				self.Button.BackgroundColor3 = properties.BackgroundColor3
				self.Button.BackgroundTransparency = properties.BackgroundTransparency
				self.Accent.BackgroundTransparency = accentTransparency
				self.Text.TextColor3 = COLORS[textKey]
				self.Text.Position = targetTextPosition
				self.IconPlate.BackgroundColor3 = COLORS[plateKey]
				self.IconPlate.BackgroundTransparency = plateTransparency
				self.Scale.Scale = targetScale
				if self.Icon then
					if self.Icon:IsA("ImageLabel") then
						self.Icon.ImageColor3 = COLORS[iconKey]
					else
						self.Icon.TextColor3 = COLORS[iconKey]
					end
				end
			else
				tween(self.Button, properties, FAST)
				tween(self.Accent, { BackgroundTransparency = accentTransparency }, FAST)
				tween(self.Text, { TextColor3 = COLORS[textKey], Position = targetTextPosition }, FAST)
				tween(self.IconPlate, {
					BackgroundColor3 = COLORS[plateKey],
					BackgroundTransparency = plateTransparency,
				}, FAST)
				tween(self.Scale, { Scale = targetScale }, active and SPRING or FAST)
				if self.Icon then
					if self.Icon:IsA("ImageLabel") then
						tween(self.Icon, { ImageColor3 = COLORS[iconKey] }, FAST)
					else
						tween(self.Icon, { TextColor3 = COLORS[iconKey] }, FAST)
					end
				end
			end
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
				other.IsActive = active
				other.Page.Visible = active
				other:RenderNavigation(false)
			end

			window.ActiveTab = self
			pageHeading.Text = self.Name
			pageHint.Text = self.Description
			local targetX = window.PageLeft or 18
			local targetY = window.PageTop or 76
			self.Page.Position = UDim2.fromOffset(targetX + 8, targetY)
			self.PageScale.Scale = 0.985
			tween(self.Page, { Position = UDim2.fromOffset(targetX, targetY) }, SMOOTH)
			tween(self.PageScale, { Scale = 1 }, SPRING)
			self:ApplySearch(searchBox.Text)
		end

		table.insert(window.Tabs, tab)
		updateResponsiveLayout()
		tab:RenderNavigation(true)
		connect(tabButton.MouseEnter, function()
			tab.IsHovered = true
			tab:RenderNavigation(false)
		end)
		connect(tabButton.MouseLeave, function()
			tab.IsHovered = false
			tab:RenderNavigation(false)
		end)
		connect(tabButton.MouseButton1Down, function()
			tween(tabScale, { Scale = 0.975 }, PRESS)
		end)
		connect(tabButton.MouseButton1Up, function()
			tab:RenderNavigation(false)
		end)
		connect(tabButton.Activated, function()
			tab:SetActive()
		end)

		if #window.Tabs == 1 then
			tab:SetActive()
		end

		function tab:CreateSection(sectionConfig)
			local sectionName = type(sectionConfig) == "table" and sectionConfig.Name or sectionConfig
			local section = label(page, "    " .. string.upper(tostring(sectionName or "Section")), 10, COLORS.Muted, Enum.Font.GothamBold)
			section.Size = UDim2.new(1, 0, 0, 34)
			section.TextYAlignment = Enum.TextYAlignment.Center
			make("Frame", {
				Parent = section,
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = COLORS.Accent,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 2, 0.5, 0),
				Size = UDim2.fromOffset(6, 6),
			}, { corner(3) })
			make("Frame", {
				Parent = section,
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = COLORS.Border,
				BackgroundTransparency = 0.58,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -4, 0.5, 0),
				Size = UDim2.new(1, -154, 0, 1),
			})
			table.insert(self.Sections, section)
			return section
		end

		function tab:CreateButton(buttonConfig)
			buttonConfig = buttonConfig or {}
			local card = createCard(page, ROW_HEIGHT)
			local buttonTitle, buttonDescription = addCardText(card, buttonConfig.Name or "Button", buttonConfig.Description)

			local actionText = tostring(buttonConfig.ButtonText or "Run")
			local actionWidth = clamp(
				math.ceil(measureTextWidth(actionText, 11, Enum.Font.GothamBold) + (buttonConfig.Icon and 42 or 28)),
				72,
				tonumber(buttonConfig.MaxButtonWidth) or 128
			)
			if tonumber(buttonConfig.ButtonWidth) then
				actionWidth = clamp(tonumber(buttonConfig.ButtonWidth), 64, 180)
			end
			local textRightInset = actionWidth + 44
			local hasDescription = buttonDescription ~= nil
			buttonTitle.Size = UDim2.new(1, -textRightInset, 0, hasDescription and 22 or ROW_HEIGHT)
			if buttonDescription then
				buttonDescription.Size = UDim2.new(1, -textRightInset, 0, 18)
			end
			local button = make("TextButton", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0.5),
				AutoButtonColor = false,
				BackgroundColor3 = window.Accent,
				BorderSizePixel = 0,
				Font = Enum.Font.GothamBold,
				Position = UDim2.new(1, -16, 0.5, 0),
				Size = UDim2.fromOffset(actionWidth, 36),
				RichText = false,
				Text = "",
				TextColor3 = COLORS.Text,
				TextSize = 11,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
			}, { corner(10) })
			make("UIGradient", {
				Parent = button,
				Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(214, 214, 214)),
				Rotation = 12,
			})
			local buttonScale = make("UIScale", { Parent = button, Scale = 1 })
			local buttonIcon = buttonConfig.Icon and createIcon(button, buttonConfig.Icon, 14, COLORS.Text, {
				Position = UDim2.new(0, 15, 0.5, 0),
				ZIndex = 2,
			}, iconProvider)
			local actionLabel = label(button, actionText, 11, COLORS.Text, Enum.Font.GothamBold)
			actionLabel.Position = buttonIcon and UDim2.fromOffset(28, 0) or UDim2.new()
			actionLabel.Size = buttonIcon and UDim2.new(1, -34, 1, 0) or UDim2.fromScale(1, 1)
			actionLabel.TextXAlignment = buttonIcon and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center
			actionLabel.TextYAlignment = Enum.TextYAlignment.Center
			actionLabel.ZIndex = 2
			addHover(button, window.Accent, COLORS.AccentDark)

			local handle = { Instance = card }
			function handle:Press()
				callback(buttonConfig.Callback)
			end
			function handle:SetVisible(visible)
				card.Visible = visible
			end

			connect(button.Activated, function()
				tween(buttonScale, { Scale = 0.92 }, PRESS)
				task.delay(0.1, function()
					if button.Parent then
						tween(buttonScale, { Scale = 1 }, SPRING)
					end
				end)
				handle:Press()
			end)

			return registerElement(handle, buttonConfig)
		end

		function tab:CreateToggle(toggleConfig)
			toggleConfig = toggleConfig or {}
			local card = createCard(page, ROW_HEIGHT)
			addCardText(card, toggleConfig.Name or "Toggle", toggleConfig.Description)

			local button = make("TextButton", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0.5),
				AutoButtonColor = false,
				BackgroundColor3 = COLORS.SurfaceRaised,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -18, 0.5, 0),
				Size = UDim2.fromOffset(50, 28),
				Text = "",
			}, { corner(14), stroke(COLORS.Border, 0.2, 1) })

			local knob = make("Frame", {
				Parent = button,
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = COLORS.Muted,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 4, 0.5, 0),
				Size = UDim2.fromOffset(20, 20),
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
					Position = handle.Value and UDim2.new(1, -24, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
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

		-- Text input ---------------------------------------------------------
		-- Callback fires when focus is released. ChangedCallback is optional
		-- and fires while the player types.
		function tab:CreateInput(inputConfig)
			inputConfig = inputConfig or {}
			local card = createCard(page, ROW_HEIGHT)
			local inputTitle, inputDescription = addCardText(
				card,
				inputConfig.Name or "Text Input",
				inputConfig.Description
			)
			local controlWidth = clamp(tonumber(inputConfig.ControlWidth) or 184, 120, 240)
			local textInset = controlWidth + 44
			local hasDescription = inputDescription ~= nil
			inputTitle.Size = UDim2.new(1, -textInset, 0, hasDescription and 22 or ROW_HEIGHT)
			if inputDescription then
				inputDescription.Size = UDim2.new(1, -textInset, 0, 18)
			end

			local inputPlate = make("Frame", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = COLORS.SurfaceRaised,
				BackgroundTransparency = 0.2,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -16, 0.5, 0),
				Size = UDim2.fromOffset(controlWidth, 36),
			}, {
				corner(10),
				stroke(COLORS.Border, 0.42, 1),
			})
			local inputIcon = inputConfig.Icon and createIcon(inputPlate, inputConfig.Icon, 14, COLORS.Muted, {
				Position = UDim2.new(0, 17, 0.5, 0),
				ZIndex = 2,
			}, iconProvider) or nil
			local textBox = make("TextBox", {
				Name = "Input",
				Parent = inputPlate,
				BackgroundTransparency = 1,
				ClearTextOnFocus = inputConfig.ClearTextOnFocus == true,
				Font = Enum.Font.Gotham,
				MultiLine = inputConfig.MultiLine == true,
				PlaceholderColor3 = COLORS.Muted,
				PlaceholderText = tostring(inputConfig.Placeholder or "Type here..."),
				Position = UDim2.fromOffset(inputIcon and 34 or 12, 0),
				Size = UDim2.new(1, inputIcon and -44 or -24, 1, 0),
				Text = tostring(inputConfig.CurrentValue or inputConfig.Default or ""),
				TextColor3 = COLORS.Text,
				TextSize = 11,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
			})
			local inputStroke = inputPlate:FindFirstChildOfClass("UIStroke")
			local maximumLength = tonumber(inputConfig.MaxLength)
			if maximumLength then maximumLength = math.max(0, math.floor(maximumLength)) end
			local internalChange = false
			local handle = {
				Instance = card,
				TextBox = textBox,
				Value = textBox.Text,
			}

			local function normalizeText(value)
				local text = tostring(value or "")
				if inputConfig.NumbersOnly == true then
					text = string.gsub(text, "[^%d%.%-]", "")
				end
				if maximumLength and maximumLength >= 0 then
					text = string.sub(text, 1, maximumLength)
				end
				return text
			end

			function handle:Set(value, silent)
				local normalized = normalizeText(value)
				internalChange = true
				textBox.Text = normalized
				internalChange = false
				self.Value = normalized
				if not silent then callback(inputConfig.ChangedCallback, normalized) end
			end
			function handle:Get()
				return self.Value
			end
			function handle:Clear(silent)
				self:Set("", silent)
			end
			function handle:Focus()
				textBox:CaptureFocus()
			end
			function handle:SetVisible(visible)
				card.Visible = visible == true
			end

			connect(textBox:GetPropertyChangedSignal("Text"), function()
				if internalChange then return end
				local normalized = normalizeText(textBox.Text)
				if normalized ~= textBox.Text then
					internalChange = true
					textBox.Text = normalized
					internalChange = false
				end
				handle.Value = normalized
				callback(inputConfig.ChangedCallback, normalized)
			end)
			connect(textBox.Focused, function()
				if inputStroke then
					setThemeBinding(inputStroke, "Color", "Accent")
					tween(inputStroke, { Color = window.Accent, Transparency = 0.08 }, FAST)
				end
			end)
			connect(textBox.FocusLost, function(enterPressed)
				if inputStroke then
					setThemeBinding(inputStroke, "Color", "Border")
					tween(inputStroke, { Color = COLORS.Border, Transparency = 0.42 }, FAST)
				end
				callback(inputConfig.Callback, handle.Value, enterPressed)
				if inputConfig.RemoveTextAfterFocusLost == true then
					handle:Clear(true)
				end
			end)

			handle:Set(textBox.Text, true)
			return registerElement(handle, inputConfig)
		end

		-- Both common spellings point to the same input component.
		tab.CreateTextbox = tab.CreateInput
		tab.CreateTextBox = tab.CreateInput

		-- Lightweight, non-interactive text row. Icon is optional.
		function tab:CreateLabel(labelConfig)
			labelConfig = type(labelConfig) == "table" and labelConfig or { Text = tostring(labelConfig or "Label") }
			local text = tostring(labelConfig.Text or labelConfig.Content or labelConfig.Name or "Label")
			local rowHeight = clamp(tonumber(labelConfig.Height) or 48, 34, 120)
			local card = createCard(page, rowHeight)
			card.BackgroundTransparency = tonumber(labelConfig.BackgroundTransparency) or 0.34
			local textIcon = labelConfig.Icon and createIcon(card, labelConfig.Icon, 15,
				labelConfig.Color or COLORS.Muted, {
					Position = UDim2.new(0, 22, 0.5, 0),
				}, iconProvider) or nil
			local textLabel = label(
				card,
				text,
				tonumber(labelConfig.TextSize) or 11,
				labelConfig.Color or COLORS.Muted,
				labelConfig.Bold == true and Enum.Font.GothamBold or Enum.Font.Gotham
			)
			textLabel.Position = UDim2.fromOffset(textIcon and 42 or 16, 0)
			textLabel.Size = UDim2.new(1, textIcon and -58 or -32, 1, 0)
			textLabel.TextWrapped = labelConfig.Wrap == true
			textLabel.TextYAlignment = Enum.TextYAlignment.Center

			local handle = { Instance = card, Label = textLabel, Value = text }
			function handle:Set(value)
				self.Value = tostring(value or "")
				textLabel.Text = self.Value
			end
			function handle:Get()
				return self.Value
			end
			function handle:SetVisible(visible)
				card.Visible = visible == true
			end
			labelConfig.Name = labelConfig.Name or text
			return registerElement(handle, labelConfig)
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

			local card = createCard(page, 100)
			local titleLabel, sliderDescription = addCardText(card, sliderConfig.Name or "Slider", sliderConfig.Description)
			local hasDescription = sliderConfig.Description ~= nil and tostring(sliderConfig.Description) ~= ""
			titleLabel.Size = UDim2.new(1, -156, 0, hasDescription and 22 or 58)
			if sliderDescription then
				sliderDescription.Size = UDim2.new(1, -156, 0, 18)
			end

			local valuePill = make("Frame", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = COLORS.SurfaceRaised,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -18, 0, 15),
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
				Position = UDim2.fromOffset(20, 79),
				Size = UDim2.new(1, -40, 0, 5),
			}, { corner(3) })
			local fill = make("Frame", {
				Parent = track,
				BackgroundColor3 = window.Accent,
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0, 1),
			}, { corner(3) })
			make("UIGradient", {
				Parent = fill,
				Color = ColorSequence.new(Color3.fromRGB(212, 212, 212), Color3.fromRGB(255, 255, 255)),
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
				Position = UDim2.fromOffset(14, 62),
				Size = UDim2.new(1, -28, 0, 36),
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
			local function optionInfo(option)
				if type(option) == "table" then
					local display = option.Name or option.Label or option.Text
					if display == nil then
						display = option.Value ~= nil and option.Value or option[1]
					end
					display = tostring(display ~= nil and display or "Option")
					local value = option.Value
					if value == nil then value = display end
					return display, value, option.Icon
				end
				return tostring(option), option, nil
			end

			local card = createCard(page, ROW_HEIGHT)
			local titleLabel, descriptionLabel = addCardText(card, dropdownConfig.Name or "Dropdown", dropdownConfig.Description)
			local hasDescription = dropdownConfig.Description ~= nil and tostring(dropdownConfig.Description) ~= ""

			local selectionPlate = make("Frame", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = COLORS.SurfaceRaised,
				BackgroundTransparency = 0.28,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -16, 0.5, 0),
				Size = UDim2.fromOffset(100, 34),
			}, {
				corner(10),
				stroke(COLORS.Border, 0.62, 1),
			})
			local selectionLabel = label(selectionPlate, "Select", 11, COLORS.Muted, Enum.Font.Gotham)
			selectionLabel.AnchorPoint = Vector2.new(1, 0.5)
			selectionLabel.Position = UDim2.new(1, -32, 0.5, 0)
			selectionLabel.Size = UDim2.new(1, -42, 1, 0)
			selectionLabel.TextXAlignment = Enum.TextXAlignment.Right

			local arrow = createIcon(selectionPlate, "chevron-down", 15, COLORS.Muted, {
				Position = UDim2.new(1, -16, 0.5, 0),
				ZIndex = 2,
			}, iconProvider)
			local selectionStroke = selectionPlate:FindFirstChildOfClass("UIStroke")
			local maximumSelectionWidth = math.max(84, tonumber(dropdownConfig.MaxControlWidth) or 168)
			local selectionIcon

			local function layoutSelection(instant)
				selectionLabel.Size = UDim2.new(1, selectionIcon and -66 or -42, 1, 0)
				local measuredWidth = math.ceil(
					measureTextWidth(selectionLabel.Text, 11, Enum.Font.Gotham)
						+ 50
						+ (selectionIcon and 22 or 0)
				)
				local targetWidth = tonumber(dropdownConfig.ControlWidth)
					or clamp(measuredWidth, 84, maximumSelectionWidth)
				targetWidth = clamp(targetWidth, 72, 200)
				local targetSize = UDim2.fromOffset(targetWidth, 34)
				if instant then
					selectionPlate.Size = targetSize
				else
					tween(selectionPlate, { Size = targetSize }, FAST)
				end

				local textRightInset = targetWidth + 44
				titleLabel.Size = UDim2.new(1, -textRightInset, 0, hasDescription and 22 or ROW_HEIGHT)
				if descriptionLabel then
					descriptionLabel.Size = UDim2.new(1, -textRightInset, 0, 18)
				end
			end

			local headerButton = make("TextButton", {
				Parent = card,
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, ROW_HEIGHT),
				Text = "",
				ZIndex = 3,
			})

			local optionsFrame = make("ScrollingFrame", {
				Parent = card,
				Active = true,
				BackgroundColor3 = COLORS.Background,
				BorderSizePixel = 0,
				CanvasSize = UDim2.new(),
				Position = UDim2.fromOffset(12, ROW_HEIGHT),
				ScrollBarImageColor3 = COLORS.Border,
				ScrollBarThickness = 2,
				Size = UDim2.new(1, -24, 0, 0),
			}, {
				corner(8),
				make("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				make("UIPadding", {
					PaddingBottom = UDim.new(0, 5),
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
					PaddingTop = UDim.new(0, 5),
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
					local _, value = optionInfo(option)
					if handle.Selected[tostring(value)] then
						table.insert(result, value)
					end
				end
				return result
			end

			local function updateSelectionText()
				if selectionIcon then
					selectionIcon:Destroy()
					selectionIcon = nil
				end
				local displayValues = {}
				for _, option in ipairs(handle.Options) do
					local display, optionValue = optionInfo(option)
					if handle.Selected[tostring(optionValue)] then
						table.insert(displayValues, display)
					end
				end
				if #displayValues == 0 then
					selectionLabel.Text = dropdownConfig.Placeholder or "Select"
				else
					selectionLabel.Text = table.concat(displayValues, ", ")
				end
				for _, option in ipairs(handle.Options) do
					local _, optionValue, optionIcon = optionInfo(option)
					if optionIcon and handle.Selected[tostring(optionValue)] then
						selectionIcon = createIcon(selectionPlate, optionIcon, 14, COLORS.Muted, {
							Position = UDim2.new(0, 17, 0.5, 0),
							ZIndex = 2,
						}, iconProvider)
						if selectionIcon then break end
					end
				end
				layoutSelection(false)
			end

			local rebuildOptions
			local function setOpen(open)
				handle.OpenState = open
				local visibleHeight = math.min(#handle.Options * 35 + 10, 186)
				local targetHeight = open and ROW_HEIGHT + visibleHeight + 10 or ROW_HEIGHT
				optionsFrame.Size = UDim2.new(1, -24, 0, open and visibleHeight or 0)
				tween(card, { Size = UDim2.new(1, 0, 0, targetHeight) }, SMOOTH)
				tween(arrow, { Rotation = open and 180 or 0 }, SMOOTH)
				tween(selectionPlate, { BackgroundTransparency = open and 0.08 or 0.28 }, FAST)
				if selectionStroke then
					setThemeBinding(selectionStroke, "Color", open and "Accent" or "Border")
					tween(selectionStroke, {
						Color = open and window.Accent or COLORS.Border,
						Transparency = open and 0.18 or 0.62,
					}, FAST)
				end

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
				local values
				if self.Multiple and type(value) == "table" then
					values = value
				elseif type(value) == "table"
					and (value.Name ~= nil or value.Label ~= nil or value.Text ~= nil or value.Value ~= nil) then
					local _, structuredValue = optionInfo(value)
					values = { structuredValue }
				else
					values = { value }
				end
				for _, chosen in ipairs(values) do
					for _, option in ipairs(self.Options) do
						local _, optionValue = optionInfo(option)
						if tostring(optionValue) == tostring(chosen) then
							self.Selected[tostring(optionValue)] = true
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
					local display, optionValue, optionIconName = optionInfo(option)
					local key = tostring(optionValue)
					local selected = handle.Selected[key] == true
					local optionButton = make("TextButton", {
						Parent = optionsFrame,
						AutoButtonColor = false,
						BackgroundColor3 = selected and window.Accent or COLORS.Surface,
						BorderSizePixel = 0,
						LayoutOrder = order,
						Size = UDim2.new(1, 0, 0, 32),
						Text = "",
					}, { corner(7) })
					local optionIcon = optionIconName and createIcon(optionButton, optionIconName, 14,
						selected and COLORS.Text or COLORS.Muted, {
							Position = UDim2.new(0, 17, 0.5, 0),
							ZIndex = 2,
						}, iconProvider) or nil
					local optionLabel = label(optionButton, display, 12,
						selected and COLORS.Text or COLORS.Muted, Enum.Font.Gotham)
					optionLabel.Position = UDim2.fromOffset(optionIcon and 34 or 12, 0)
					optionLabel.Size = UDim2.new(1, optionIcon and -62 or -40, 1, 0)
					optionLabel.TextYAlignment = Enum.TextYAlignment.Center
					if selected then
						createIcon(optionButton, "check", 13, COLORS.Text, {
							Position = UDim2.new(1, -17, 0.5, 0),
							ZIndex = 2,
						}, iconProvider)
					end
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

				optionsFrame.CanvasSize = UDim2.fromOffset(0, #handle.Options * 35 + 10)
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
			local card = createCard(page, ROW_HEIGHT)
			local titleLabel = addCardText(card, pickerConfig.Name or "Color Picker", pickerConfig.Description)
			local hasDescription = pickerConfig.Description ~= nil and tostring(pickerConfig.Description) ~= ""
			titleLabel.Size = UDim2.new(1, -132, 0, hasDescription and 22 or ROW_HEIGHT)

			-- The transparent header covers the complete collapsed row. The swatch
			-- remains above it, so both the text area and color chip can toggle.
			local headerButton = make("TextButton", {
				Parent = card,
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, ROW_HEIGHT),
				Text = "",
				ZIndex = 3,
			})

			local swatch = make("TextButton", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0.5),
				AutoButtonColor = false,
				BackgroundColor3 = pickerConfig.CurrentColor or window.Accent,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -18, 0.5, 0),
				Size = UDim2.fromOffset(46, 30),
				Text = "",
				ZIndex = 4,
			}, { corner(8), stroke(Color3.new(1, 1, 1), 0.65, 1) })
			local pickerArrow = createIcon(card, "chevron-down", 14, COLORS.Muted, {
				Position = UDim2.new(1, -82, 0, 37),
				ZIndex = 4,
			}, iconProvider)

			local panel = make("Frame", {
				Parent = card,
				BackgroundColor3 = COLORS.Background,
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(12, ROW_HEIGHT),
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
				tween(card, { Size = UDim2.new(1, 0, 0, open and 272 or ROW_HEIGHT) }, SMOOTH)
				if pickerArrow then
					tween(pickerArrow, { Rotation = open and 180 or 0 }, SMOOTH)
				end
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

			local function togglePicker()
				setOpen(not handle.OpenState)
			end
			connect(headerButton.Activated, togglePicker)
			connect(swatch.Activated, togglePicker)

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

		function tab:CreateWarning(warningConfig)
			warningConfig = warningConfig or {}
			local warningColor = typeof(warningConfig.Color) == "Color3"
				and warningConfig.Color
				or Color3.fromRGB(245, 181, 63)
			local card = createCard(page, tonumber(warningConfig.Height) or 78)
			local cardStroke = card:FindFirstChildOfClass("UIStroke")
			if cardStroke then
				cardStroke.Color = warningColor
				cardStroke.Transparency = 0.42
			end

			make("Frame", {
				Parent = card,
				BackgroundColor3 = warningColor,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 3, 1, 0),
			}, { corner(2) })
			local iconPlate = make("Frame", {
				Parent = card,
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = warningColor,
				BackgroundTransparency = 0.84,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 16, 0.5, 0),
				Size = UDim2.fromOffset(42, 42),
			}, {
				corner(12),
				stroke(warningColor, 0.58, 1),
			})
			local warningIcon = createIcon(
				iconPlate,
				warningConfig.Icon or "triangle-alert",
				19,
				warningColor,
				nil,
				iconProvider
			)
			if not warningIcon then
				warningIcon = label(iconPlate, "⚠", 20, warningColor, Enum.Font.GothamBold)
				warningIcon.Size = UDim2.fromScale(1, 1)
				warningIcon.TextXAlignment = Enum.TextXAlignment.Center
				warningIcon.TextYAlignment = Enum.TextYAlignment.Center
			end

			local warningTitle = label(card, tostring(warningConfig.Name or "Warning"), 12, COLORS.Text, Enum.Font.GothamBold)
			warningTitle.Position = UDim2.new(0, 72, 0.5, -20)
			warningTitle.Size = UDim2.new(1, -90, 0, 21)
			warningTitle.TextYAlignment = Enum.TextYAlignment.Center
			local warningDescription = label(
				card,
				tostring(warningConfig.Description or warningConfig.Content or "Please review this information before continuing."),
				10,
				COLORS.Muted,
				Enum.Font.Gotham
			)
			warningDescription.Position = UDim2.new(0, 72, 0.5, 2)
			warningDescription.Size = UDim2.new(1, -90, 0, 18)
			warningDescription.TextYAlignment = Enum.TextYAlignment.Center

			local handle = {
				Instance = card,
				Icon = warningIcon,
			}
			function handle:SetText(name, description)
				if name ~= nil then warningTitle.Text = tostring(name) end
				if description ~= nil then warningDescription.Text = tostring(description) end
			end
			function handle:SetVisible(visible)
				card.Visible = visible == true
			end
			return registerElement(handle, warningConfig)
		end

		function tab:CreateStat(statConfig)
			statConfig = statConfig or {}
			local card = createCard(page, ROW_HEIGHT)
			local statTitle, statDescription = addCardText(card, statConfig.Name or "Stat", statConfig.Description)
			local hasDescription = statConfig.Description ~= nil and tostring(statConfig.Description) ~= ""

			local valuePlate = make("Frame", {
				Parent = card,
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = COLORS.SurfaceRaised,
				BackgroundTransparency = 0.2,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -16, 0.5, 0),
				Size = UDim2.fromOffset(96, 36),
			}, {
				corner(10),
				stroke(COLORS.Border, 0.62, 1),
			})
			createIcon(valuePlate, statConfig.Icon or "activity", 14, statConfig.Color or window.Accent, {
				Position = UDim2.new(0, 17, 0.5, 0),
			}, iconProvider)
			local valueLabel = label(valuePlate, "", 13, statConfig.Color or window.Accent, Enum.Font.GothamBold)
			valueLabel.AnchorPoint = Vector2.new(1, 0.5)
			valueLabel.Position = UDim2.new(1, -12, 0.5, 0)
			valueLabel.Size = UDim2.new(1, -38, 1, 0)
			valueLabel.TextXAlignment = Enum.TextXAlignment.Right

			local handle = {
				Instance = card,
				Value = statConfig.Value or 0,
				Suffix = statConfig.Suffix or "",
			}

			local function layoutValue(instant)
				local measuredWidth = math.ceil(measureTextWidth(valueLabel.Text, 13, Enum.Font.GothamBold) + 50)
				local targetWidth = tonumber(statConfig.ControlWidth)
					or clamp(measuredWidth, 88, tonumber(statConfig.MaxControlWidth) or 168)
				targetWidth = clamp(targetWidth, 78, 200)
				local targetSize = UDim2.fromOffset(targetWidth, 36)
				if instant then
					valuePlate.Size = targetSize
				else
					tween(valuePlate, { Size = targetSize }, FAST)
				end

				local textRightInset = targetWidth + 44
				statTitle.Size = UDim2.new(1, -textRightInset, 0, hasDescription and 22 or ROW_HEIGHT)
				if statDescription then
					statDescription.Size = UDim2.new(1, -textRightInset, 0, 18)
				end
			end

			function handle:Set(value)
				self.Value = value
				valueLabel.Text = tostring(value) .. tostring(self.Suffix)
				layoutValue(false)
			end
			function handle:Get()
				return self.Value
			end
			function handle:SetSuffix(suffix)
				self.Suffix = suffix or ""
				self:Set(self.Value)
			end

			valueLabel.Text = tostring(handle.Value) .. tostring(handle.Suffix)
			layoutValue(true)
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
		if searchIcon then
			setThemeBinding(searchIcon, "ImageColor3", "Accent")
			tween(searchIcon, { ImageColor3 = window.Accent }, FAST)
		end
	end)
	connect(searchBox.FocusLost, function()
		if searchStroke then
			setThemeBinding(searchStroke, "Color", "Border")
			tween(searchStroke, { Color = COLORS.Border, Transparency = 0.3 }, FAST)
		end
		setThemeBinding(searchFrame, "BackgroundColor3", "Surface")
		tween(searchFrame, { BackgroundColor3 = COLORS.Surface }, FAST)
		if searchIcon then
			setThemeBinding(searchIcon, "ImageColor3", "Muted")
			tween(searchIcon, { ImageColor3 = COLORS.Muted }, FAST)
		end
	end)
	connect(clearSearch.Activated, function()
		searchBox.Text = ""
		searchBox:ReleaseFocus()
	end)

	fitToViewport()
	window:Center()
	-- AbsoluteSize can be zero during the construction frame. Recenter once
	-- Roblox has rendered the real CoreGui/PlayerGui bounds.
	task.defer(function()
		RunService.RenderStepped:Wait()
		if not window.Destroyed and not window.UserMoved then
			fitToViewport()
			window:Center()
		end
	end)
	return window
end

--[[
	EXAMPLE / STARTER CONFIGURATION
	Edit or remove this section to fit your game.
]]

local Window = PrismUI:CreateWindow({
	Title = "My Experience",
	Subtitle = "Control center",
	Size = Vector2.new(920, 600),
	Theme = "Amethyst", -- See PrismUI.ThemeNames for every preset.
	-- Lucide = require(path.To.Lucide), -- Optional provider override; the full module is embedded.
	-- Logo = "shield-check", -- Lucide name, asset ID, or rbxasset(id) string.
	-- DiscordIcon = "gamepad-2", -- Replace with an rbxassetid if you have a Discord brand asset.
	Profile = "Player settings",
	ToggleKey = Enum.KeyCode.RightShift,
})

local MainTab = Window:CreateTab({
	Name = "Main",
	Icon = "layout-dashboard",
	Description = "General controls and experience settings",
})
local PlayerTab = Window:CreateTab({
	Name = "Player",
	Icon = "user",
	Description = "Local player information and actions",
})
local AppearanceTab = Window:CreateTab({
	Name = "Appearance",
	Icon = "palette",
	Description = "Personalize the interface without reloading it",
})

MainTab:CreateSection("Controls")

MainTab:CreateWarning({
	Name = "Yield Warning",
	Description = "Review important information before using a sensitive control.",
})

MainTab:CreateLabel({
	Text = "Prism UI is ready. Labels can be plain text or include an optional icon.",
})

local ExampleInput = MainTab:CreateInput({
	Name = "Display Message",
	Description = "Enter client-side text and press Enter.",
	Placeholder = "Type a message...",
	MaxLength = 60,
	Callback = function(text, enterPressed)
		print("Input:", text, "Enter pressed:", enterPressed)
	end,
})

MainTab:CreateButton({
	Name = "Example Button",
	Description = "Runs your client-side callback.",
	ButtonText = "Run",
	Icon = "activity",
	Callback = function()
		print("Button pressed")
	end,
})

local ExampleToggle = MainTab:CreateToggle({
	Name = "Example Toggle",
	Description = "A boolean setting with a callback.",
	CurrentValue = false,
	Callback = function(value)
		print("Toggle:", value)
	end,
})

local ExampleSlider = MainTab:CreateSlider({
	Name = "Field of View",
	Description = "Drag to select a snapped numeric value.",
	Range = { 70, 120 },
	Increment = 1,
	Suffix = "°",
	CurrentValue = 90,
	Callback = function(value)
		local camera = workspace.CurrentCamera
		if camera then
			camera.FieldOfView = value
		end
	end,
})

local ExampleDropdown = MainTab:CreateDropdown({
	Name = "Quality",
	Description = "Choose one option.",
	Options = {
		{ Name = "Low", Icon = "battery-low" },
		{ Name = "Medium", Icon = "gauge" },
		{ Name = "High", Icon = "zap" },
		{ Name = "Ultra", Icon = "rocket" },
	},
	CurrentOption = "High",
	MultipleOptions = false,
	Callback = function(value)
		print("Quality:", value)
	end,
})

MainTab:CreateDropdown({
	Name = "Enabled Effects",
	Options = { "Bloom", "Blur", "Sun Rays" },
	CurrentOption = { "Bloom", "Sun Rays" },
	MultipleOptions = true,
	Callback = function(values)
		print("Effects:", table.concat(values, ", "))
	end,
})

local AccentPicker = MainTab:CreateColorPicker({
	Name = "Accent Color",
	Description = "Drag in the field and hue strip.",
	CurrentColor = Window.Accent,
	FollowTheme = true,
	Callback = function(color)
		print("Color:", color)
	end,
})

PlayerTab:CreateSection("Live Stats")

local SpeedStat = PlayerTab:CreateStat({
	Name = "Walk Speed",
	Description = "Current local humanoid speed.",
	Value = 16,
	Suffix = " studs/s",
})

PlayerTab:CreateButton({
	Name = "Refresh Stat",
	Description = "Reads the local character's current WalkSpeed.",
	ButtonText = "Refresh",
	Icon = "refresh-ccw",
	Callback = function()
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			SpeedStat:Set(humanoid.WalkSpeed)
		end
	end,
})

AppearanceTab:CreateSection("Interface")

AppearanceTab:CreateDropdown({
	Name = "Theme Preset",
	Description = "Switch the complete visual system with a smooth transition.",
	Options = PrismUI.ThemeNames,
	CurrentOption = Window.ThemeName,
	MultipleOptions = false,
	Callback = function(themeName)
		Window:ChangeTheme(themeName)
	end,
})

AppearanceTab:CreateStat({
	Name = "Included Themes",
	Description = "Every preset is bundled in this single LocalScript.",
	Value = #PrismUI.ThemeNames,
	Suffix = " presets",
})

PlayerTab:CreateButton({
	Name = "Custom Notification",
	Description = "Shows a theme-aware toast with optional actions.",
	ButtonText = "Show",
	Icon = "bell",
	Callback = function()
		Window:Notify({
			Title = "Prism UI",
			Content = "The interface is working.",
			Duration = 5,
			Button1 = "Nice",
			Button2 = "Close",
			Callback = function(buttonText)
				print("Notification button:", buttonText)
			end,
		})
	end,
})

-- Examples of changing controls later:
-- Window.DiscordButton.Activated:Connect(function() print("Open your Discord action here") end)
-- ExampleToggle:Set(true)
-- ExampleSlider:Set(100)
-- ExampleInput:Set("Hello from Prism UI")
-- ExampleDropdown:Refresh({ "Low", "High" }, true)
-- AccentPicker:Set(Color3.fromRGB(255, 120, 80))
-- ExampleToggle:SetLocked(true, "Complete the tutorial to unlock this setting.")
-- ExampleToggle:SetLocked(false)

Window:Notify({
	Title = "My Experience",
	Content = "UI loaded. Press RightShift to hide or show it.",
	Icon = "shield-check",
	Duration = 5,
})
