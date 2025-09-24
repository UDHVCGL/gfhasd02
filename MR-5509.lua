
local partsize = 1
local partsize2 = 5
local partsize3 = 5


local repo = "https://raw.githubusercontent.com/XcRNB/Obsidian-CNHK/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true 

local Window = Library:CreateWindow({
    Title = "MR丨终极战场",
    Footer = "by MR",
    Icon = 88686191977617,
    NotifySide = "Right",
    ShowCustomCursor = true,
    AutoShow = true,
    Resizable = true,
    Center = true,
    TabPadding = 2,
    MenuFadeTime = 0.5,
    Position = UDim2.fromOffset(6, 6),
    Size = UDim2.fromOffset(620, 600),
    IconSize = UDim2.fromOffset(50, 50)
})
local Tabs = {
	lol = Window:AddTab('主要功能'),
	["UI Settings"] = Window:AddTab("UI调试", "settings"),
}

local lol = Tabs.lol:AddLeftGroupbox("贴墙攻击")
local loz = Tabs.lol:AddLeftGroupbox("防御")
local lox = Tabs.lol:AddRightGroupbox("攻击等杂物")

local hb
lol:AddToggle('MyToggle', {
    Text = '贴墙打',
    Default = false,
    Callback = function(s)
        if hb then hb:Disconnect() end
        if s then
            hb = game:GetService("RunService").Heartbeat:Connect(function()
                local c = game.Players.LocalPlayer.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local player = game.Players.LocalPlayer
local character = player.Character
if not character then return end

local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
if not humanoidRootPart then return end
local part = workspace.Map.Props.Walls.Break.Part
part.Size = Vector3.new(partsize,partsize2,partsize3)
part.Transparency = 0.7
local distanceInFront = 5
local lookDirection = humanoidRootPart.CFrame.LookVector
local positionInFront = humanoidRootPart.Position + (lookDirection * distanceInFront)
local rotationCFrame = CFrame.Angles(0, math.rad(90), 0)
local finalCFrame = CFrame.new(positionInFront, positionInFront + lookDirection) * rotationCFrame
part.CFrame = finalCFrame
                end
            end)
        end
    end
})

lol:AddSlider("MySlider", {
	Text = "贴墙打范围",
	Default = 1,
	Min = 0,
	Max = 20,
	Rounding = 1,
	Compact = true,

	Callback = function(Value)
partsize2 = Value
partsize3 = Value
	end,
	Disabled = false, -- Will disable the slider (true / false)
	Visible = true, -- Will make the slider invisible (true / false)
})

loz:AddToggle('MyToggle', {
    Text = '正面防御',
    Default = false,
    Callback = function(s)
    if s then
 game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("Block"):FireServer(true)
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("Block"):FireServer(false)
    end
    end
})

lox:AddToggle('MyToggle', {
    Text = '攻击无间隔',
    Default = false,
    Callback = function(s)
    if s then
game:GetService("ReplicatedStorage").Settings.Cooldowns.Melee.Value = 0
else
game:GetService("ReplicatedStorage").Settings.Cooldowns.Melee.Value = 100
    end
    end
})

lox:AddToggle('MyToggle', {
    Text = '冲刺无间隔',
    Default = false,
    Callback = function(s)
    if s then
game:GetService("ReplicatedStorage").Settings.Cooldowns.Dash.Value = 0
else
game:GetService("ReplicatedStorage").Settings.Cooldowns.Dash.Value = 100
    end
    end
})

lox:AddToggle('MyToggle', {
    Text = '无布娃娃状态 (加无后摇)',
    Default = false,
    Callback = function(s)
if s then
_G.whwy = true
spawn(function()
while _G.whwy and task.wait() do
pcall(function()
game:GetService("ReplicatedStorage").Settings.Toggles.NoSlowdowns.Value = true
game:GetService("ReplicatedStorage").Settings.Toggles.DisableHitStun.Value = true
game:GetService("ReplicatedStorage").Settings.Multipliers.RagdollTimer.Value = 0
end)
end
end)
    else
    game:GetService("ReplicatedStorage").Settings.Toggles.NoSlowdowns.Value = false
    game:GetService("ReplicatedStorage").Settings.Toggles.DisableHitStun.Value = false
    game:GetService("ReplicatedStorage").Settings.Multipliers.RagdollTimer.Value = 100
    _G.whwy = false
    end 
    end
})

lox:AddToggle('MyToggle', {
    Text = '大招时间延长',
    Default = false,
    Callback = function(s)
if s then
_G.bbb = true
spawn(function()
while _G.bbb and task.wait() do
pcall(function()
game:GetService("ReplicatedStorage").Settings.Multipliers.UltimateTimer.Value = 99999
end)
end
end)
    else
    game:GetService("ReplicatedStorage").Settings.Multipliers.UltimateTimer.Value = 100
    _G.bbb = false
    end 
    end
})

lox:AddToggle('MyToggle', {
    Text = '一拳眩晕',
    Default = false,
    Callback = function(s)
if s then
_G.aaa = true
spawn(function()
while _G.aaa and task.wait() do
pcall(function()
game:GetService("ReplicatedStorage").Settings.Multipliers.MeleeDamage.Value = 1000000
end)
end
end)
    else
    game:GetService("ReplicatedStorage").Settings.Multipliers.MeleeDamage.Value = 100
    _G.aaa = false
    end 
    end
})

LeftGroupBox:AddInput("MyTextbox", {
	Default = "100",
	Numeric = false,
	Finished = false,
	ClearTextOnFocus = true,

	Text = "攻击速度",
Placeholder = "请输入",
	Callback = function(Value)
	game:GetService("ReplicatedStorage").Settings.Multipliers.MeleeSpeed.Value = Value
	end,
})

LeftGroupBox:AddInput("MyTextbox", {
	Default = "100",
	Numeric = false,
	Finished = false,
	ClearTextOnFocus = true,

	Text = "击退大小",
Placeholder = "请输入",
	Callback = function(Value)
	game:GetService("ReplicatedStorage").Settings.Multipliers.RagdollPower.Value = Value
	end,
})

LeftGroupBox:AddInput("MyTextbox", {
	Default = "100",
	Numeric = false,
	Finished = false,
	ClearTextOnFocus = true,

	Text = "冲刺速度",
Placeholder = "请输入",
	Callback = function(Value)
	game:GetService("ReplicatedStorage").Settings.Multipliers.DashSpeed.Value = Value
	end,
})

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("一些调试")

MenuGroup:AddToggle("KeybindMenuOpen", {
	Default = Library.KeybindFrame.Visible,
	Text = "快捷菜单",
	Callback = function(value)
		Library.KeybindFrame.Visible = value
	end,
})
MenuGroup:AddToggle("ShowCustomCursor", {
	Text = "自定义光标",
	Default = true,
	Callback = function(Value)
		Library.ShowCustomCursor = Value
	end,
})
MenuGroup:AddDropdown("NotificationSide", {
	Values = { "左", "右" },
	Default = "右",

	Text = "通知位置",

	Callback = function(Value)
		Library:SetNotifySide(Value)
	end,
})
MenuGroup:AddDropdown("DPIDropdown", {
	Values = { "25%", "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",

	Text = "UI大小",

	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local DPI = tonumber(Value)

		Library:SetDPIScale(DPI)
	end,
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind")
	:AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)

