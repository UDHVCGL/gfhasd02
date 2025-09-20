local L = loadstring or load
local Notis = 'https://raw.githubusercontent.com/CF-Trail/random/main/FE2Notifs.lua'
local NotificationLib = "https://raw.githubusercontent.com/BloodLetters/Ash-Libs/refs/heads/main/source.lua"
local EspLib = "https://raw.githubusercontent.com/ImamGV/Script/main/ESP"
local Lib = "https://raw.githubusercontent.com/OAO-Kamu/UI-Library-Interface/refs/heads/main/SP%20LibraryMain.lua"
local SY = "https://raw.githubusercontent.com/AxerRe/ProSite/refs/heads/main/views/Axrewatermark.lib"
local splib = L(game:HttpGet(Lib))()
local LibESP = L(game:HttpGet(EspLib))()
local GUI = L(game:HttpGet(NotificationLib))()
local notifs = L(game:HttpGet(Notis))()
local WatermarkLib = L(game:HttpGet(SY))()
--======================================================================================================================================================================================================================================--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
--======================================================================================================================================================================================================================================--
local V = "1.2"
local Window = splib:MakeWindow({
 Name = "帝脚本 " .. V,
 HidePremium = false,
 SaveConfig = true,
 Setting = true,
 ToggleIcon = "rbxassetid://8394822455",
 ConfigFolder = "帝脚本 配置文件",
 CloseCallback = true
})
WatermarkLib:Create({
    Hotkey = Enum.KeyCode.Home,
    CustomText = "帝脚本 V1.2 | By:小北,Q3E4 | {FPS} FPS"
})

Tab = Window:MakeTab({
  IsMobile = true,
  Name = "本地信息",
  Icon = "rbxassetid://4483345998"
})
Tab:AddLabel("您的用户名: "..game.Players.LocalPlayer.Name)
Tab:AddLabel("您的名称: "..game.Players.LocalPlayer.DisplayName)
Tab:AddLabel("您的语言: "..game.Players.LocalPlayer.LocaleId)
Tab:AddLabel("您的国家: "..game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(game.Players.LocalPlayer))
Tab:AddLabel("您的账户年龄(天): "..game.Players.LocalPlayer.AccountAge)
Tab:AddLabel("您的账户年龄(年): "..math.floor(game.Players.LocalPlayer.AccountAge/365*100)/(100))
Tab:AddLabel("您使用的注入器："..identifyexecutor())
Tab:AddLabel("您当前的服务器ID: "..game.PlaceId)
Tab:AddSection({
  Name = "======================================================================"  
})
Tab:AddLabel("脚本由: 小北 Q3E4 制作")
ATab = Window:MakeTab({
  IsMobile = true,
  Name = "玩家传送",
  Icon = "rbxassetid://4483345998"
})
local function getPlayers()
    local t = {}
    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(t, p.Name) end
    end
    return t
end

ATab:AddDropdown({
    Name = "选择要传送的玩家",
    Desc = "会自动进行传送进行传送",
    Default = "...",
    Options = getPlayers(),
    Callback = function(Option)
        local v = Option[1]
        local target = Players:FindFirstChild(v)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            char:WaitForChild("HumanoidRootPart").CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
            GUI:CreateNotify({
                 title = "已传送到: ",
                description = v
            })
        else
            GUI:CreateNotify({
                 title = "传送错误",
                 description = "玩家离开游戏或者生在重生"
            })
        end
    end    
})
ATab:AddButton({
    Name = "刷新列表",
    Desc = "What?",
    Callback = function()
        PlayerDropdown:Refresh(getPlayers())
        GUI:CreateNotify({
          title = "已刷新!",
          description = "已更新列表!"
        })
    end
})
ATab:AddSection({
  Name = "======================================================================"  
})
ATab:AddButton({
    Name = "解锁神秘视角",
    Desc = "不可恢复!!!谨慎使用",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            h.WalkSpeed = 16
            h.JumpPower = 50
            workspace.Gravity = defaultGravity
            Camera.FieldOfView = defaultFOV
        end
     end
})
BTab = Window:MakeTab({
  IsMobile = true,
  Name = "本地玩家",
  Icon = "rbxassetid://4483345998"
})
BTab:AddSection({
  Name = "速度/跳跃"
})
BTab:AddSlider({
  Name = "跳跃高度调节",
  Min = 0,
  Max = 1000,
  Default = 56,
  Increment = 1,
  ValueName = "跳跃",
  Flag = "Jump",
  Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
  end    
})
BTab:AddSlider({
  Name = "速度调节",
  Min = 0,
  Max = 1000,
  Default = 16,
  Increment = 1,
  ValueName = "速度",
  Flag = "Speed",
  Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
  end    
})

BTab:AddButton({
    Name = "飞行GUI",
    Desc = "What",
    Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/UVAj0uWu"))()
    end
})

BTab:AddToggle({
    Name = "夜视",
    Desc = "开启或关闭夜视模式",
    Default = false,
    IsMobile = false,
    Flag = "NightVisionToggle",
    Save = true,
    Callback = function(Value)
        if Value then
            game.Lighting.Ambient = Color3.new(1, 1, 1)
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})

BTab:AddButton({
    Name = "点击传送工具",
    Desc = "获取点击传送工具到背包",
    Callback = function()
        mouse = game.Players.LocalPlayer:GetMouse() 
        tool = Instance.new("Tool") 
        tool.RequiresHandle = false 
        tool.Name = "小北、小凌NB" 
        tool.Activated:connect(function() 
            local pos = mouse.Hit+Vector3.new(0,2.5,0) 
            pos = CFrame.new(pos.X,pos.Y,pos.Z) 
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos 
        end) 
        tool.Parent = game.Players.LocalPlayer.Backpack
    end
})

BTab:AddColorpicker({
    Name = "颜色选择器",
    Desc = "选择一个颜色",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Value)
        print(Value)
    end
})

BTab:AddButton({
    Name = "坐标抓取器",
    Desc = "获取坐标位置(需要卡密)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/maincoordinatesgrabber/refs/heads/main/new"))()
    end
})

BTab:AddButton({
    Name = "键盘脚本",
    Desc = "传统经典键盘‪ᯅ̈",
    Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"))()
    end
})

BTab:AddButton({
    Name = "飞车",
    Desc = "What?",
    Callback = function()
    --MADE BY WARRIOR ROBERR

--BACKGROUND BY NOX

-- Version: 3.2

-- Instances:

local Flymguiv2 = Instance.new("ScreenGui")

local Drag = Instance.new("Frame")

local FlyFrame = Instance.new("Frame")

local ddnsfbfwewefe = Instance.new("TextButton")

local Speed = Instance.new("TextBox")

local Fly = Instance.new("TextButton")

local Speeed = Instance.new("TextLabel")

local Stat = Instance.new("TextLabel")

local Stat2 = Instance.new("TextLabel")

local Unfly = Instance.new("TextButton")

local Vfly = Instance.new("TextLabel")

local Close = Instance.new("TextButton")

local Minimize = Instance.new("TextButton")

local Flyon = Instance.new("Frame")

local W = Instance.new("TextButton")

local S = Instance.new("TextButton")

--Properties:

Flymguiv2.Name = "Flym gui v2"

Flymguiv2.Parent = game.CoreGui

Flymguiv2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Drag.Name = "Drag"

Drag.Parent = Flymguiv2

Drag.Active = true

Drag.BackgroundColor3 = Color3.fromRGB(138,43,226)

Drag.BorderSizePixel = 0

Drag.Draggable = true

Drag.Position = UDim2.new(0.482438415, 0, 0.454874992, 0)

Drag.Size = UDim2.new(0, 237, 0, 27)

FlyFrame.Name = "FlyFrame"

FlyFrame.Parent = Drag

FlyFrame.BackgroundColor3 = Color3.fromRGB(147,112,219)

FlyFrame.BorderSizePixel = 0

FlyFrame.Draggable = true

FlyFrame.Position = UDim2.new(-0.00200000009, 0, 0.989000022, 0)

FlyFrame.Size = UDim2.new(0, 237, 0, 139)

ddnsfbfwewefe.Name = "ddnsfbfwewefe"

ddnsfbfwewefe.Parent = FlyFrame

ddnsfbfwewefe.BackgroundColor3 = Color3.fromRGB(138,43,226)

ddnsfbfwewefe.BorderSizePixel = 0

ddnsfbfwewefe.Position = UDim2.new(-0.000210968778, 0, -0.00395679474, 0)

ddnsfbfwewefe.Size = UDim2.new(0, 237, 0, 27)

ddnsfbfwewefe.Font = Enum.Font.SourceSans

ddnsfbfwewefe.Text = "nox🐙"

ddnsfbfwewefe.TextColor3 = Color3.fromRGB(0,0,0)

ddnsfbfwewefe.TextScaled = true

ddnsfbfwewefe.TextSize = 14.000

ddnsfbfwewefe.TextWrapped = true

Speed.Name = "Speed"

Speed.Parent = FlyFrame

Speed.BackgroundColor3 = Color3.fromRGB(138,43,226)

Speed.BorderColor3 = Color3.fromRGB(0, 0, 191)

Speed.BorderSizePixel = 0

Speed.Position = UDim2.new(0.445025861, 0, 0.402877688, 0)

Speed.Size = UDim2.new(0, 111, 0, 33)

Speed.Font = Enum.Font.SourceSans

Speed.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)

Speed.Text = "50"

Speed.TextColor3 = Color3.fromRGB(0,0,0)

Speed.TextScaled = true

Speed.TextSize = 14.000

Speed.TextWrapped = true

Fly.Name = "Fly"

Fly.Parent = FlyFrame

Fly.BackgroundColor3 = Color3.fromRGB(138,43,226)

Fly.BorderSizePixel = 0

Fly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)

Fly.Size = UDim2.new(0, 199, 0, 32)

Fly.Font = Enum.Font.SourceSans

Fly.Text = "Enable"

Fly.TextColor3 = Color3.fromRGB(0,0,0)

Fly.TextScaled = true

Fly.TextSize = 14.000

Fly.TextWrapped = true

Fly.MouseButton1Click:Connect(function()

	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart	Fly.Visible = false

	Stat2.Text = "On"

	Stat2.TextColor3 = Color3.fromRGB(0, 255, 0)

	Unfly.Visible = true

	Flyon.Visible = true

	local BV = Instance.new("BodyVelocity",HumanoidRP)

	local BG = Instance.new("BodyGyro",HumanoidRP)

	BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)

	game:GetService('RunService').RenderStepped:connect(function()

	BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)

	BG.D = 5000

	BG.P = 100000

	BG.CFrame = game.Workspace.CurrentCamera.CFrame

	end)

end)

Speeed.Name = "Speeed"

Speeed.Parent = FlyFrame

Speeed.BackgroundColor3 = Color3.fromRGB(138,43,226)

Speeed.BorderSizePixel = 0

Speeed.Position = UDim2.new(0.0759493634, 0, 0.402877688, 0)

Speeed.Size = UDim2.new(0, 87, 0, 32)

Speeed.ZIndex = 0

Speeed.Font = Enum.Font.SourceSans

Speeed.Text = "Speed:"

Speeed.TextColor3 = Color3.fromRGB(0,0,0)

Speeed.TextScaled = true

Speeed.TextSize = 14.000

Speeed.TextWrapped = true

Stat.Name = "Stat"

Stat.Parent = FlyFrame

Stat.BackgroundColor3 = Color3.fromRGB(138,43,226)

Stat.BorderSizePixel = 0

Stat.Position = UDim2.new(0.299983799, 0, 0.239817441, 0)

Stat.Size = UDim2.new(0, 85, 0, 15)

Stat.Font = Enum.Font.SourceSans

Stat.Text = "Status:"

Stat.TextColor3 = Color3.fromRGB(0,0,0)

Stat.TextScaled = true

Stat.TextSize = 14.000

Stat.TextWrapped = true

Stat2.Name = "Stat2"

Stat2.Parent = FlyFrame

Stat2.BackgroundColor3 = Color3.fromRGB(138,43,226)

Stat2.BorderSizePixel = 0

Stat2.Position = UDim2.new(0.546535194, 0, 0.239817441, 0)

Stat2.Size = UDim2.new(0, 27, 0, 15)

Stat2.Font = Enum.Font.SourceSans

Stat2.Text = "Off"

Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)

Stat2.TextScaled = true

Stat2.TextSize = 14.000

Stat2.TextWrapped = true

Unfly.Name = "Unfly"

Unfly.Parent = FlyFrame

Unfly.BackgroundColor3 = Color3.fromRGB(138,43,226)

Unfly.BorderSizePixel = 0

Unfly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)

Unfly.Size = UDim2.new(0, 199, 0, 32)

Unfly.Visible = false

Unfly.Font = Enum.Font.SourceSans

Unfly.Text = "Disable"

Unfly.TextColor3 = Color3.fromRGB(0,0,0)

Unfly.TextScaled = true

Unfly.TextSize = 14.000

Unfly.TextWrapped = true

Unfly.MouseButton1Click:Connect(function()

	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart

	Fly.Visible = true

	Stat2.Text = "Off"

	Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)

	wait()

	Unfly.Visible = false

	Flyon.Visible = false

	HumanoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()

	HumanoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()

end)

Vfly.Name = "Vfly"

Vfly.Parent = Drag

Vfly.BackgroundColor3 = Color3.fromRGB(138,43,226)

Vfly.BorderSizePixel = 0

Vfly.Size = UDim2.new(0, 57, 0, 27)

Vfly.Font = Enum.Font.SourceSans

Vfly.Text = "VFly"

Vfly.TextColor3 = Color3.fromRGB(0,0,0)

Vfly.TextScaled = true

Vfly.TextSize = 14.000

Vfly.TextWrapped = true

Close.Name = "Close"

Close.Parent = Drag

Close.BackgroundColor3 = Color3.fromRGB(138,43,226)

Close.BorderSizePixel = 0

Close.Position = UDim2.new(0.875, 0, 0, 0)

Close.Size = UDim2.new(0, 27, 0, 27)

Close.Font = Enum.Font.SourceSans

Close.Text = "X"

Close.TextColor3 = Color3.fromRGB(0,0,0)

Close.TextScaled = true

Close.TextSize = 14.000

Close.TextWrapped = true

Close.MouseButton1Click:Connect(function()

	Flymguiv2:Destroy()

end)

Minimize.Name = "Minimize"

Minimize.Parent = Drag

Minimize.BackgroundColor3 = Color3.fromRGB(138,43,226)

Minimize.BorderSizePixel = 0

Minimize.Position = UDim2.new(0.75, 0, 0, 0)

Minimize.Size = UDim2.new(0, 27, 0, 27)

Minimize.Font = Enum.Font.SourceSans

Minimize.Text = "-"

Minimize.TextColor3 = Color3.fromRGB(0,0,0)

Minimize.TextScaled = true

Minimize.TextSize = 14.000

Minimize.TextWrapped = true

function Mini()

	if Minimize.Text == "-" then

		Minimize.Text = "+"

		FlyFrame.Visible = false

	elseif Minimize.Text == "+" then

		Minimize.Text = "-"

		FlyFrame.Visible = true

	end

end

Minimize.MouseButton1Click:Connect(Mini)

Flyon.Name = "Fly on"

Flyon.Parent = Flymguiv2

Flyon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

Flyon.BorderSizePixel = 0

Flyon.Position = UDim2.new(0.117647067, 0, 0.550284624, 0)

Flyon.Size = UDim2.new(0.148000002, 0, 0.314999998, 0)

Flyon.Visible = false

Flyon.Active = true

Flyon.Draggable = true

W.Name = "W"

W.Parent = Flyon

W.BackgroundColor3 = Color3.fromRGB(138,43,226)

W.BorderSizePixel = 0

W.Position = UDim2.new(0.134719521, 0, 0.0152013302, 0)

W.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)

W.Font = Enum.Font.SourceSans

W.Text = "^"

W.TextColor3 = Color3.fromRGB(0,0,0)

W.TextScaled = true

W.TextSize = 14.000

W.TextWrapped = true

W.TouchLongPress:Connect(function()

	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0

end)

W.MouseButton1Click:Connect(function()

	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0

end)

S.Name = "S"

S.Parent = Flyon

S.BackgroundColor3 = Color3.fromRGB(138,43,226)

S.BorderSizePixel = 0

S.Position = UDim2.new(0.134000003, 0, 0.479999989, 0)

S.Rotation = 180.000

S.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)

S.Font = Enum.Font.SourceSans

S.Text = "^"

S.TextColor3 = Color3.fromRGB(0,0,0)

S.TextScaled = true

S.TextSize = 14.000

S.TextWrapped = true

S.TouchLongPress:Connect(function()

	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0

end)

S.MouseButton1Click:Connect(function()

	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text

	wait(.1)

	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0

end)
    end
})
BTab:AddButton({
    Name = "假延迟 1",
    Desc = "What?",
    Callback = function()
    local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- === GUI Setup ===
local gui = Instance.new("ScreenGui")
gui.Name = "EgorToggle"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 130, 0, 40)
button.Position = UDim2.new(0, 10, 1, -60)
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 20
button.Font = Enum.Font.SourceSansBold
button.Text = "假延迟: 关"
button.Parent = gui

-- === State Variables ===
local egorEnabled = false
local runAnimId = "rbxassetid://913376220" -- Roblox default run
local runTrack = nil
local runConnection = nil

-- === Setup Run Animation ===
local function playRunAnimation(humanoid)
	local animator = humanoid:FindFirstChildWhichIsA("Animator")
	if not animator then
		animator = Instance.new("Animator", humanoid)
	end

	local runAnim = Instance.new("Animation")
	runAnim.AnimationId = runAnimId
	runTrack = animator:LoadAnimation(runAnim)
	runTrack.Priority = Enum.AnimationPriority.Movement
	runTrack:AdjustSpeed(6)
	runTrack:Play()

	runConnection = game:GetService("RunService").RenderStepped:Connect(function()
		if humanoid.MoveDirection.Magnitude == 0 then
			if runTrack.IsPlaying then runTrack:Stop() end
		else
			if not runTrack.IsPlaying then
				runTrack:Play()
				runTrack:AdjustSpeed(6)
			end
		end
	end)
end

local function stopRunAnimation()
	if runTrack then runTrack:Stop() end
	if runConnection then runConnection:Disconnect() end
end

-- === Toggle Egor Mode ===
local function enableEgor()
	local char = player.Character
	if not char then return end
	local humanoid = char:FindFirstChild("Humanoid")
	if not humanoid then return end

	humanoid.WalkSpeed = 3
	playRunAnimation(humanoid)
	button.Text = "假延迟: 开"
end

local function disableEgor()
	local char = player.Character
	if not char then return end
	local humanoid = char:FindFirstChild("Humanoid")
	if not humanoid then return end

	humanoid.WalkSpeed = 16
	stopRunAnimation()
	button.Text = "假延迟: 关"
end

-- === Button Toggle ===
button.MouseButton1Click:Connect(function()
	egorEnabled = not egorEnabled
	if egorEnabled then enableEgor() else disableEgor() end
end)

-- === On Character Spawn ===
local function onCharacterAdded(char)
	local humanoid = char:WaitForChild("Humanoid")
	char:WaitForChild("Animate") -- Keep default animations like jump
	task.wait(0.5)

	if egorEnabled then
		enableEgor()
	else
		disableEgor()
	end
end

if player.Character then onCharacterAdded(player.Character) end
player.CharacterAdded:Connect(onCharacterAdded)
    end
})
BTab:AddButton({
    Name = "假延迟 2",
    Desc = "What?",
    Callback = function()
    local enabled = false
local interval = 0.07 -- Interval set to 0.07 seconds (70 milliseconds)
local minInterval = 0.07 -- Minimum interval set to 0.07 seconds (70 milliseconds)
local maxInterval = 0.07 -- Maximum interval set to 0.07 seconds (70 milliseconds)
local anchoredDuration = 0.4 -- Duration for which player is anchored in seconds (0.40 seconds)

local guiMinimized = false
local guiPosition = UDim2.new(0.5, -100, 0.5, -65) -- Initial position
local minimizedPosition = UDim2.new(0.95, -200, 0.95, -35) -- Minimized position
local minimizedSize = UDim2.new(0, 200, 0, 30) -- Minimized size

-- Function to toggle anchoring with delay to simulate high ping
local function toggleAnchoring()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.Anchored = true -- Anchor the character
            wait(anchoredDuration) -- Wait for anchoredDuration seconds
            humanoidRootPart.Anchored = false -- Unanchor the character
        end
    end
end

-- Create GUI for enabling/disabling
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true -- Ensures GUI works correctly on mobile

-- For compatibility with executors, parent the GUI to the game's "CoreGui" service
local coreGuiService = game:GetService("CoreGui")
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 130)
frame.Position = guiPosition
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(100, 100, 100)
frame.Active = true -- Necessary for mobile drag support
frame.Parent = gui
gui.Parent = coreGuiService

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 40, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Text = "Fake Lag Gui"
title.Parent = frame

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 35, 0, 30)
minimizeButton.Position = UDim2.new(0, 5, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Text = "-"
minimizeButton.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 35, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Text = "X"
closeButton.Parent = frame

local enableButton = Instance.new("TextButton")
enableButton.Size = UDim2.new(0, 80, 0, 30)
enableButton.Position = UDim2.new(0.5, -90, 0.5, 20)
enableButton.BackgroundColor3 = Color3.fromRGB(70, 70, 255)
enableButton.TextColor3 = Color3.new(1, 1, 1)
enableButton.Text = "Enable"
enableButton.Parent = frame

local disableButton = Instance.new("TextButton")
disableButton.Size = UDim2.new(0, 80, 0, 30)
disableButton.Position = UDim2.new(0.5, 10, 0.5, 20)
disableButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
disableButton.TextColor3 = Color3.new(1, 1, 1)
disableButton.Text = "Disable"
disableButton.Parent = frame

-- Function to generate random interval between minInterval and maxInterval
local function getRandomInterval()
    return math.random() * (maxInterval - minInterval) + minInterval
end

-- Mobile support for draggable frame
local inputService = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

if inputService.TouchEnabled then
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch and dragging then
            dragInput = input
            local delta = dragInput.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Minimize button functionality
local function toggleMinimize()
    if guiMinimized then
        -- Restore frame to original size and position
        guiMinimized = false
        frame:TweenSizeAndPosition(UDim2.new(0, 200, 0, 130), guiPosition, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
        minimizeButton.Text = "-"
        enableButton.Visible = true
        disableButton.Visible = true
    else
        -- Minimize frame
        guiMinimized = true
        frame:TweenSizeAndPosition(minimizedSize, minimizedPosition, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
        minimizeButton.Text = "+"
        enableButton.Visible = false
        disableButton.Visible = false
    end
end

minimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy() -- Destroy the GUI when close button is clicked
end)

enableButton.MouseButton1Click:Connect(function()
    enabled = true
end)

disableButton.MouseButton1Click:Connect(function()
    enabled = false
end)

-- Main loop to toggle anchoring with 0.07 second interval
while true do
    if enabled then
        toggleAnchoring()
    end
    wait(interval)
end
    end
})
BTab:AddButton({
    Name = "视角锁(可拖动)",
    Desc = "What?",
    Callback = function()
    local ShiftlockStarterGui = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
ShiftlockStarterGui.Name = "Shiftlock (StarterGui)"
ShiftlockStarterGui.Parent = game.CoreGui
ShiftlockStarterGui.ZIndexBehavior =  Enum.ZIndexBehavior.Sibling
ShiftlockStarterGui.ResetOnSpawn = false

ImageButton.Parent = ShiftlockStarterGui
ImageButton.Active = true
ImageButton.Draggable = true
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.BackgroundTransparency = 1.000
ImageButton.Position = UDim2.new(0.921914339, 0, 0.552375436, 0)
ImageButton.Size = UDim2.new(0.0636147112, 0, 0.0661305636, 0)
ImageButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
ImageButton.Image = "http://www.roblox.com/asset/?id=182223762"
local function TLQOYN_fake_script()
    local script = Instance.new("LocalScript", ImageButton)

    local MobileCameraFramework = {}
    local players = game:GetService("Players")
    local runservice = game:GetService("RunService")
    local CAS = game:GetService("ContextActionService")
    local player = players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    local humanoid = character.Humanoid
    local camera = workspace.CurrentCamera
    local button = script.Parent
    uis = game:GetService("UserInputService")
    ismobile = uis.TouchEnabled
    button.Visible = ismobile
    
    local states = {
        OFF = "rbxasset://textures/ui/mouseLock_off@2x.png",
        ON = "rbxasset://textures/ui/mouseLock_on@2x.png"
    }
    local MAX_LENGTH = 900000
    local active = false
    local ENABLED_OFFSET = CFrame.new(1.7, 0, 0)
    local DISABLED_OFFSET = CFrame.new(-1.7, 0, 0)
local rootPos = Vector3.new(0,0,0)
local function UpdatePos()
if player.Character and player.Character:FindFirstChildOfClass"Humanoid" and player.Character:FindFirstChildOfClass"Humanoid".RootPart then
rootPos = player.Character:FindFirstChildOfClass"Humanoid".RootPart.Position
end
end
    local function UpdateImage(STATE)
        button.Image = states[STATE]
    end
    local function UpdateAutoRotate(BOOL)
if player.Character and player.Character:FindFirstChildOfClass"Humanoid" then
player.Character:FindFirstChildOfClass"Humanoid".AutoRotate = BOOL
end
end
    local function GetUpdatedCameraCFrame()
if game:GetService"Workspace".CurrentCamera then
return CFrame.new(rootPos, Vector3.new(game:GetService"Workspace".CurrentCamera.CFrame.LookVector.X * MAX_LENGTH, rootPos.Y, game:GetService"Workspace".CurrentCamera.CFrame.LookVector.Z * MAX_LENGTH))
end
end
    local function EnableShiftlock()
UpdatePos()
        UpdateAutoRotate(false)
        UpdateImage("ON")
if player.Character and player.Character:FindFirstChildOfClass"Humanoid" and player.Character:FindFirstChildOfClass"Humanoid".RootPart then
player.Character:FindFirstChildOfClass"Humanoid".RootPart.CFrame = GetUpdatedCameraCFrame()
end
if game:GetService"Workspace".CurrentCamera then
game:GetService"Workspace".CurrentCamera.CFrame = camera.CFrame * ENABLED_OFFSET
end
    end
    local function DisableShiftlock()
UpdatePos()
        UpdateAutoRotate(true)
        UpdateImage("OFF")
        if game:GetService"Workspace".CurrentCamera then
game:GetService"Workspace".CurrentCamera.CFrame = camera.CFrame * DISABLED_OFFSET
end
        pcall(function()
            active:Disconnect()
            active = nil
        end)
    end
    UpdateImage("OFF")
    active = false
    function ShiftLock()
        if not active then
            active = runservice.RenderStepped:Connect(function()
                EnableShiftlock()
            end)
        else
            DisableShiftlock()
        end
    end
    local ShiftLockButton = CAS:BindAction("ShiftLOCK", ShiftLock, false, "On")
    CAS:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0))
    button.MouseButton1Click:Connect(function()
        if not active then
            active = runservice.RenderStepped:Connect(function()
                EnableShiftlock()
            end)
        else
            DisableShiftlock()
        end
    end)
    return MobileCameraFramework
    
end
coroutine.wrap(TLQOYN_fake_script)()
local function OMQRQRC_fake_script()
    local script = Instance.new("LocalScript", ShiftlockStarterGui)

    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local Settings = UserSettings()
    local GameSettings = Settings.GameSettings
    local ShiftLockController = {}
    while not Players.LocalPlayer do
        wait()
    end
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local ScreenGui, ShiftLockIcon, InputCn
    local IsShiftLockMode = true
    local IsShiftLocked = true
    local IsActionBound = false
    local IsInFirstPerson = false
    ShiftLockController.OnShiftLockToggled = Instance.new("BindableEvent")
    local function isShiftLockMode()
        return LocalPlayer.DevEnableMouseLock and GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove and LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
    end
    if not UserInputService.TouchEnabled then
        IsShiftLockMode = isShiftLockMode()
    end
    local function onShiftLockToggled()
        IsShiftLocked = not IsShiftLocked
        ShiftLockController.OnShiftLockToggled:Fire()
    end
    local initialize = function()
        print("enabled")
    end
    function ShiftLockController:IsShiftLocked()
        return IsShiftLockMode and IsShiftLocked
    end
    function ShiftLockController:SetIsInFirstPerson(isInFirstPerson)
        IsInFirstPerson = isInFirstPerson
    end
    local function mouseLockSwitchFunc(actionName, inputState, inputObject)
        if IsShiftLockMode then
            onShiftLockToggled()
        end
    end
    local function disableShiftLock()
        if ScreenGui then
            ScreenGui.Parent = nil
        end
        IsShiftLockMode = false
        Mouse.Icon = ""
        if InputCn then
            InputCn:disconnect()
            InputCn = nil
        end
        IsActionBound = false
        ShiftLockController.OnShiftLockToggled:Fire()
    end
    local onShiftInputBegan = function(inputObject, isProcessed)
        if isProcessed then
            return
        end
        if inputObject.UserInputType ~= Enum.UserInputType.Keyboard or inputObject.KeyCode == Enum.KeyCode.LeftShift or inputObject.KeyCode == Enum.KeyCode.RightShift then
        end
    end
    local function enableShiftLock()
        IsShiftLockMode = isShiftLockMode()
        if IsShiftLockMode then
            if ScreenGui then
                ScreenGui.Parent = PlayerGui
            end
            if IsShiftLocked then
                ShiftLockController.OnShiftLockToggled:Fire()
            end
            if not IsActionBound then
                InputCn = UserInputService.InputBegan:connect(onShiftInputBegan)
                IsActionBound = true
            end
        end
    end
    GameSettings.Changed:connect(function(property)
        if property == "ControlMode" then
            if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
                enableShiftLock()
            else
                disableShiftLock()
            end
        elseif property == "ComputerMovementMode" then
            if GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                disableShiftLock()
            else
                enableShiftLock()
            end
        end
    end)
    LocalPlayer.Changed:connect(function(property)
        if property == "DevEnableMouseLock" then
            if LocalPlayer.DevEnableMouseLock then
                enableShiftLock()
            else
                disableShiftLock()
            end
        elseif property == "DevComputerMovementMode" then
            if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
                disableShiftLock()
            else
                enableShiftLock()
            end
        end
    end)
    LocalPlayer.CharacterAdded:connect(function(character)
        if not UserInputService.TouchEnabled then
            initialize()
        end
    end)
    if not UserInputService.TouchEnabled then
        initialize()
        if isShiftLockMode() then
            InputCn = UserInputService.InputBegan:connect(onShiftInputBegan)
            IsActionBound = true
        end
    end
    enableShiftLock()
    return ShiftLockController
    
end
coroutine.wrap(OMQRQRC_fake_script)()
    end
})
BTab:AddButton({
    Name = "显示 XYZ 坐标",
    Desc = "What?",
    Callback = function()
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "PositionDisplayGui"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 100)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 15)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "坐标"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Center

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 24
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 10)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, -20, 1, -35)
label.Position = UDim2.new(0, 10, 0, 30)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 18
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Top
label.Text = "加载..."

local dragging = false
local dragInput
local dragStart
local startPos

local function updatePosition(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		updatePosition(input)
	end
end)

RunService.Heartbeat:Connect(function()
	local character = LocalPlayer.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		local pos = character.HumanoidRootPart.Position
		label.Text = string.format("X: %.2f\nY: %.2f\nZ: %.2f", pos.X, pos.Y, pos.Z)
	else
		label.Text = "坐标错误"
	end
end)
    end
})
BTab:AddButton({
    Name = "旋转 GUI",
    Desc = "What?",
    Callback = function()
local PlayerService = game:GetService("Players")--:GetPlayers()
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local plr = PlayerService.LocalPlayer
local mouse = plr:GetMouse()
local BodyThrust = nil
local Dragging = {}

local Suggestions = {
    2298830673, 300, 365, --gamier (test game)
    1537690962, 250, 350, --bee swarm sim
    5580097107, 300, 400, --frappe
    2202352383, 275, 350, --super power training sim
    142823291, 350, 425,  --murder mystery 2
    155615604, 273, 462,  --prison life
    1990228024, 200, 235, --bloxton hotels
    189707, 250, 325,     --natural disaster survival
    230362888, 265, 415,  --the normal elevator       (may not work)
    5293755937, 335, 435, --speedrun sim
    537413528, 300, 350,  --build a boat              (may not work)
    18540115, 300, 425,   --survive the disasters
    2041312716, 350, 465  --Ragdoll engine
}


local version = "v1.0.4"
local font = Enum.Font.FredokaOne

local AxisPositionX = {
	0.05, 
	0.35,
	0.65
}

local AxisPositionY = {
	40, --edit fling speed
	90, --toggle fling types (normal, qfling, serverkek)
	140, --extra (respawn)
	190, --edit gui settings (hotkey, theme)
	240
}

local Fling = {
	false, --toggle
	"", --hotkey
	300, --speed
	false, --server
	false --stop vertfling
}


--[[themes:]]--

local Theme_JeffStandard = {
	Color3.fromRGB(15, 25, 35),   
	Color3.fromRGB(10, 20, 30),   
	Color3.fromRGB(27, 42, 53),   
	Color3.fromRGB(25, 35, 45),   
	Color3.fromRGB(20, 30, 40),   
	Color3.fromRGB(25, 65, 45),   
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(245, 245, 255),
	Color3.fromRGB(155, 155, 255) 
}
local Theme_Dark = {
	Color3.fromRGB(25, 25, 25),   --Top bar
	Color3.fromRGB(10, 10, 10),   --Background
	Color3.fromRGB(40, 40, 40),   --Border color
	Color3.fromRGB(35, 35, 35),   --Button background
	Color3.fromRGB(20, 20, 20),   --Unused
	Color3.fromRGB(25, 100, 45),  --Button highlight
	Color3.fromRGB(255, 255, 255),--Text title
	Color3.fromRGB(245, 245, 255),--Text generic
	Color3.fromRGB(155, 155, 255) --Text highlight
}
local Theme_Steel = {
	Color3.fromRGB(25, 25, 35),   --Top bar
	Color3.fromRGB(10, 10, 20),   --Background
	Color3.fromRGB(40, 40, 50),   --Border color
	Color3.fromRGB(35, 35, 45),   --Button background
	Color3.fromRGB(20, 20, 25),   --Unused
	Color3.fromRGB(25, 100, 55),  --Button highlight
	Color3.fromRGB(255, 255, 255),--Text title
	Color3.fromRGB(245, 245, 255),--Text generic
	Color3.fromRGB(155, 155, 255) --Text highlight
}
local Theme_Rust = {
	Color3.fromRGB(45, 25, 25),   
	Color3.fromRGB(30, 10, 10),   
	Color3.fromRGB(60, 40, 40),   
	Color3.fromRGB(55, 35, 35),   
	Color3.fromRGB(40, 20, 20),   
	Color3.fromRGB(45, 100, 45),  
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(255, 245, 255),
	Color3.fromRGB(175, 155, 255) 
}
local Theme_Violet = {
	Color3.fromRGB(35, 25, 45),   --Top bar
	Color3.fromRGB(20, 10, 30),   --Background
	Color3.fromRGB(50, 40, 60),   --Border color
	Color3.fromRGB(45, 35, 55),   --Button background
	Color3.fromRGB(30, 20, 40),   --Unused
	Color3.fromRGB(35, 100, 65),  --Button highlight
	Color3.fromRGB(255, 255, 255),--Text title
	Color3.fromRGB(245, 245, 255),--Text generic
	Color3.fromRGB(155, 155, 255) --Text highlight
}
local Theme_Space = {
	Color3.fromRGB(10, 10, 10),   --Top bar
	Color3.fromRGB(0, 0, 0),   --Background
	Color3.fromRGB(20, 20, 20),   --Border color
	Color3.fromRGB(15, 15, 15),   --Button background
	Color3.fromRGB(5, 5, 5),   --Unused
	Color3.fromRGB(20, 25, 50),  --Button highlight
	Color3.fromRGB(255, 255, 255),--Text title
	Color3.fromRGB(245, 245, 255),--Text generic
	Color3.fromRGB(155, 155, 255) --Text highlight
}
local Theme_SynX = {
	Color3.fromRGB(75, 75, 75),   --Top bar
	Color3.fromRGB(45, 45, 45),   --Background
	Color3.fromRGB(45, 45, 45),   --Border color
	Color3.fromRGB(75, 75, 75),   --Button background
	Color3.fromRGB(0, 0, 5),   --Unused
	Color3.fromRGB(150, 75, 20),  --Button highlight
	Color3.fromRGB(255, 255, 255),--Text title
	Color3.fromRGB(245, 245, 255),--Text generic
	Color3.fromRGB(155, 155, 255) --Text highlight
}


local SelectedTheme = math.random(1,6)
if SelectedTheme == 1 then
    SelectedTheme = Theme_Steel
elseif SelectedTheme == 2 then
    SelectedTheme = Theme_Dark
elseif SelectedTheme == 3 then
    SelectedTheme = Theme_Rust
elseif SelectedTheme == 4 then
    SelectedTheme = Theme_Violet
elseif SelectedTheme == 5 then
    SelectedTheme = Theme_Space
elseif SelectedTheme == 6 then
    if syn then
        SelectedTheme = Theme_SynX
    else
        SelectedTheme = Theme_JeffStandard
    end
end


--[[instances:]]--
local ScreenGui = Instance.new("ScreenGui")
local TitleBar = Instance.new("Frame")
local Shadow = Instance.new("Frame")
local Menu = Instance.new("ScrollingFrame")

local TitleText = Instance.new("TextLabel")
local TitleTextShadow = Instance.new("TextLabel")
local CreditText = Instance.new("TextLabel")
local SuggestionText = Instance.new("TextLabel")

local SpeedBox = Instance.new("TextBox")
local Hotkey = Instance.new("TextBox")

local SpeedUp = Instance.new("TextButton")
local SpeedDown = Instance.new("TextButton")
local ToggleFling = Instance.new("TextButton")
local ToggleServerKill = Instance.new("TextButton")
local NoVertGain = Instance.new("TextButton")
local Respawn = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

--local BodyThrust = Instance.new("BodyThrust")

ScreenGui.Name = "JeffFling"
ScreenGui.Parent = game.CoreGui
ScreenGui.Enabled = true

TitleBar.Name = "Title Bar"
TitleBar.Parent = ScreenGui
TitleBar.BackgroundColor3 = SelectedTheme[1]
TitleBar.BorderColor3 = SelectedTheme[3]
TitleBar.Position = UDim2.new(-0.3, 0, 0.7, 0)
TitleBar.Size = UDim2.new(0, 400, 0, 250)
TitleBar.Draggable = true
TitleBar.Active = true
TitleBar.Selectable = true
TitleBar.ZIndex = 100

Shadow.Name = "Shadow"
Shadow.Parent = TitleBar
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.5
Shadow.BorderSizePixel = 0
Shadow.Position = UDim2.new(0, 5, 0, 5)
Shadow.Size = TitleBar.Size
Shadow.ZIndex = 50

Menu.Name = "Menu"
Menu.Parent = TitleBar
Menu.BackgroundColor3 = SelectedTheme[2]
Menu.BorderColor3 = SelectedTheme[3]
Menu.AnchorPoint = Vector2.new(0,0)
Menu.Position = UDim2.new(0, 0, 0, 50)
Menu.Size = UDim2.new(0, 400, 0, 200)
Menu.CanvasSize = UDim2.new(0, TitleBar.Size.X, 0, 325)
Menu.ScrollBarImageTransparency = 0.5
Menu.ZIndex = 200

TitleText.Name = "Title Text"
TitleText.Parent = TitleBar
TitleText.AnchorPoint = Vector2.new(0, 0)
TitleText.Position = UDim2.new(0, 100, 0, 25)
TitleText.Font = font
TitleText.Text = "Fling GUI "..version
TitleText.TextColor3 = SelectedTheme[8]
TitleText.TextSize = 28
TitleText.ZIndex = 300
TitleText.BackgroundTransparency = 1

TitleTextShadow.Name = "Shadow"
TitleTextShadow.Parent = TitleText
TitleTextShadow.Font = font
TitleTextShadow.Text = "Fling GUI "..version
TitleTextShadow.TextSize = 28
TitleTextShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
TitleTextShadow.TextTransparency = 0.5
TitleTextShadow.Position = UDim2.new(0, 5, 0, 5)
TitleTextShadow.ZIndex = 250
TitleTextShadow.BackgroundTransparency = 1

SuggestionText.Name = "Suggestion Text"
SuggestionText.Parent = Menu
SuggestionText.Position = UDim2.new(0, 20, 0, 250)
SuggestionText.Font = font
SuggestionText.Text = "e"
SuggestionText.TextColor3 = SelectedTheme[7]
SuggestionText.TextSize = 24
SuggestionText.TextXAlignment = Enum.TextXAlignment.Left
SuggestionText.ZIndex = 300
SuggestionText.BackgroundTransparency = 1

CreditText.Name = "Credit Text"
CreditText.Parent = Menu
CreditText.Position = UDim2.new(0, 20, 0, 300)
CreditText.Font = font
CreditText.Text = "Made by topit"
CreditText.TextColor3 = SelectedTheme[7]
CreditText.TextSize = 20
CreditText.TextXAlignment = Enum.TextXAlignment.Left
CreditText.ZIndex = 300
CreditText.BackgroundTransparency = 1

SpeedBox.Name = "Speed setting"
SpeedBox.Parent = Menu
SpeedBox.BackgroundColor3 = SelectedTheme[4]
SpeedBox.BorderColor3 = SelectedTheme[3]
SpeedBox.TextColor3 = SelectedTheme[7]
SpeedBox.Position = UDim2.new(AxisPositionX[1], 0, 0, AxisPositionY[1])
SpeedBox.Size = UDim2.new(0, 100, 0, 25)
SpeedBox.Font = Enum.Font.FredokaOne
SpeedBox.Text = "Speed: "..Fling[3]
SpeedBox.PlaceholderText = "Enter custom speed"
SpeedBox.TextScaled = true
SpeedBox.ZIndex = 300

Hotkey.Name = "Custom Hotkey"
Hotkey.Parent = Menu
Hotkey.BackgroundColor3 = SelectedTheme[4]
Hotkey.BorderColor3 = SelectedTheme[3]
Hotkey.TextColor3 = SelectedTheme[7]
Hotkey.Position = UDim2.new(AxisPositionX[2], 0, 0, AxisPositionY[3])
Hotkey.Size = UDim2.new(0, 100, 0, 25)
Hotkey.Font = Enum.Font.FredokaOne
Hotkey.Text = "Enter new hotkey"
Hotkey.PlaceholderText = "Enter new hotkey"
Hotkey.TextScaled = true
Hotkey.ZIndex = 300

SpeedUp.Name = "Speed Up"
SpeedUp.Parent = Menu
SpeedUp.BackgroundColor3 = SelectedTheme[4]
SpeedUp.BorderColor3 = SelectedTheme[3]
SpeedUp.TextColor3 = SelectedTheme[7]
SpeedUp.Position = UDim2.new((AxisPositionX[2]), 0, 0, (AxisPositionY[1]))
SpeedUp.Size = UDim2.new(0, 100, 0, 25)
SpeedUp.Font = Enum.Font.FredokaOne
SpeedUp.Text = "↑"
SpeedUp.TextScaled = true
SpeedUp.ZIndex = 300

SpeedDown.Name = "Speed Down"
SpeedDown.Parent = Menu
SpeedDown.BackgroundColor3 = SelectedTheme[4]
SpeedDown.BorderColor3 = SelectedTheme[3]
SpeedDown.TextColor3 = SelectedTheme[7]
SpeedDown.Position = UDim2.new((AxisPositionX[3]), 0, 0, (AxisPositionY[1]))
SpeedDown.Size = UDim2.new(0, 100, 0, 25)
SpeedDown.Font = Enum.Font.FredokaOne
SpeedDown.Text = "↓"
SpeedDown.TextScaled = true
SpeedDown.ZIndex = 300

ToggleFling.Name = "Fling toggle"
ToggleFling.Parent = Menu
ToggleFling.BackgroundColor3 = SelectedTheme[4]
ToggleFling.BorderColor3 = SelectedTheme[3]
ToggleFling.TextColor3 = SelectedTheme[7]
ToggleFling.Position = UDim2.new((AxisPositionX[1]), 0, 0, (AxisPositionY[2]))
ToggleFling.Size = UDim2.new(0, 100, 0, 25)
ToggleFling.Font = Enum.Font.FredokaOne
ToggleFling.Text = "Toggle fling"
ToggleFling.TextScaled = true
ToggleFling.ZIndex = 300

Respawn.Name = "Respawn"
Respawn.Parent = Menu
Respawn.BackgroundColor3 = SelectedTheme[4]
Respawn.BorderColor3 = SelectedTheme[3]
Respawn.TextColor3 = SelectedTheme[7]
Respawn.Position = UDim2.new((AxisPositionX[1]), 0, 0, (AxisPositionY[3]))
Respawn.Size = UDim2.new(0, 100, 0, 25)
Respawn.Font = Enum.Font.FredokaOne
Respawn.Text = "Fix player"
Respawn.TextScaled = true
Respawn.ZIndex = 300

NoVertGain.Name = "NoVertGain"
NoVertGain.Parent = Menu
NoVertGain.BackgroundColor3 = SelectedTheme[4]
NoVertGain.BorderColor3 = SelectedTheme[3]
NoVertGain.TextColor3 = SelectedTheme[7]
NoVertGain.Position = UDim2.new((AxisPositionX[2]), 0, 0, (AxisPositionY[2]))
NoVertGain.Size = UDim2.new(0, 100, 0, 25)
NoVertGain.Font = Enum.Font.FredokaOne
NoVertGain.Text = "Soften vertical fling"
NoVertGain.TextScaled = true
NoVertGain.ZIndex = 300

ToggleServerKill.Name = ""
ToggleServerKill.Parent = Menu
ToggleServerKill.BackgroundColor3 = SelectedTheme[4]
ToggleServerKill.BorderColor3 = SelectedTheme[3]
ToggleServerKill.TextColor3 = SelectedTheme[7]
ToggleServerKill.Position = UDim2.new((AxisPositionX[3]), 0, 0, (AxisPositionY[2]))
ToggleServerKill.Size = UDim2.new(0, 100, 0, 25)
ToggleServerKill.Font = Enum.Font.FredokaOne
ToggleServerKill.Text = "Kek server"
ToggleServerKill.TextScaled = true
ToggleServerKill.ZIndex = 300

CloseButton.Name = "Close Button"
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = SelectedTheme[4]
CloseButton.BorderColor3 = SelectedTheme[3]
CloseButton.TextColor3 = SelectedTheme[7]
CloseButton.Position = UDim2.new(1, 0, 0, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.FredokaOne
CloseButton.Text = "X"
CloseButton.ZIndex = 300
CloseButton.TextSize = 14

--BodyThrust.Name = "Power"
--BodyThrust.Parent = plr.Character.Torso
--BodyThrust.Force = Vector3.new(0, 0, 0)
--BodyThrust.Location = Vector3.new(0, 0, 0)

--[[functions:]]--
local function DisplayText(title, text, duration)
	duration = duration or 1
	game.StarterGui:SetCore("SendNotification", 
		{
			Title = title;
			Text = text;
			Icon = "";
			Duration = duration;
		}
	)
end

local function DisplaySuggestion()
    for i,v in pairs(Suggestions) do
        if v >= 9999 and v == game.PlaceId then
            DisplayText("Detected current game!","Suggested speed: "..Suggestions[i+1].." - "..Suggestions[i+2])
            SuggestionText.Text = "Suggested speed: "..Suggestions[i+1].." - "..Suggestions[i+2]
        end
    end
    if SuggestionText.Text == "e" then
        SuggestionText.Text = "No suggestion for this game"
    end
end


local function GetRigType()
    
    if plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        return Enum.HumanoidRigType.R15
    elseif plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
        return Enum.HumanoidRigType.R6
    else
        return nil
    end
end

local function GetDeadState(player)
    if player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
        return true
    else
        return false
    end
end


local function EnableNoClip()
    
    if GetDeadState(plr) == false then
        if GetRigType() == Enum.HumanoidRigType.R6 then
            plr.Character:FindFirstChild("Torso").CanCollide            = false
            plr.Character:FindFirstChild("Head").CanCollide             = false
            plr.Character:FindFirstChild("HumanoidRootPart").CanCollide = false
        elseif GetRigType() == Enum.HumanoidRigType.R15 then
            plr.Character:FindFirstChild("UpperTorso").CanCollide       = false
            plr.Character:FindFirstChild("LowerTorso").CanCollide       = false
            plr.Character:FindFirstChild("Head").CanCollide             = false
            plr.Character:FindFirstChild("HumanoidRootPart").CanCollide = false
        end
    end
end

local function DisableNoClip()
    
    if GetDeadState(plr) == false then
        if GetRigType() == Enum.HumanoidRigType.R6 then
            plr.Character:FindFirstChild("Torso").CanCollide            = true
            plr.Character:FindFirstChild("Head").CanCollide             = true
            plr.Character:FindFirstChild("HumanoidRootPart").CanCollide = true
        elseif GetRigType() == Enum.HumanoidRigType.R15 then
            plr.Character:FindFirstChild("UpperTorso").CanCollide       = true
            plr.Character:FindFirstChild("LowerTorso").CanCollide       = true
            plr.Character:FindFirstChild("Head").CanCollide             = true
            plr.Character:FindFirstChild("HumanoidRootPart").CanCollide = true
        end
    end
end

local function OpenObject(object)
    local OpenAnim = TweenService:Create(
    	object,
    	TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), --Enum.EasingStyle.Linear, Enum.EasingDirection.In
    	{Size = UDim2.new(0, 110, 0, 35), BackgroundColor3 = SelectedTheme[6] }
    )
    
    OpenAnim:Play()
end

local function CloseObject(object)
    local CloseAnim = TweenService:Create(
    	object,
    	TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
    	{Size = UDim2.new(0, 100, 0, 25), BackgroundColor3 = SelectedTheme[4] }
    )
    
    CloseAnim:Play()
end

    
local function TToggleFling()
    Fling[1] = not Fling[1]
    if Fling[1] then
        OpenObject(ToggleFling)
        
        BodyThrust = Instance.new("BodyThrust")
        if GetRigType() == Enum.HumanoidRigType.R6 then
            BodyThrust.Parent = plr.Character.Torso
        elseif GetRigType() == Enum.HumanoidRigType.R15 then
            BodyThrust.Parent = plr.Character.UpperTorso
        end
        
        EnableNoClip()
        BodyThrust.Force = Vector3.new(Fling[3], 0, 0)
        BodyThrust.Location = Vector3.new(0, 0, Fling[3])
        
        
        print("Enabled fling")
    else
        CloseObject(ToggleFling)
        
        DisableNoClip()
        for i, v in pairs(plr.Character:GetDescendants()) do
            if v:IsA("BasePart") then
            v.Velocity, v.RotVelocity = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
            end
        end
        BodyThrust:Destroy()
        
        print("Disabled fling")
        
    end
end

local function GetIfPlayerInGame(PlayerToFind)
    if PlayerService:FindFirstChild(PlayerToFind) then
        return true
    else
        return false
    end
end

local function ServerKek()
    local TargetList = {}
    local index = 1
    local playercount = 0
    
    if Fling[1] == true then
        TToggleFling()
    end
    
    for i,v in pairs(PlayerService:GetPlayers()) do
        if v ~= plr then
            playercount = playercount + 1
            table.insert(TargetList, v)
        end
    end
    
    for i,v in pairs(TargetList) do
       print(i,v.Name) 
    end
    
    
    while Fling[4] do
        if index > playercount then
            CloseObject(ToggleServerKill)
            DisplayText("Disabled ServerKek","Finished")
            Fling[4] = false
            break
        else
            local InGame = GetIfPlayerInGame(TargetList[index].Name)
            local Dead = GetDeadState(TargetList[index])
            if InGame == true and Dead == false then
                plr.Character.HumanoidRootPart.CFrame = TargetList[index].Character.HumanoidRootPart.CFrame --tp to them
                
                TToggleFling() --enable fling
                
                for i = 0,2,1 do
                    plr.Character.HumanoidRootPart.CFrame = TargetList[index].Character.HumanoidRootPart.CFrame
                    wait(0.15)
                end
                
                TToggleFling() --disable fling
                
                wait(0.1) --wait until disabled
                
                if plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then --check if seated
                    plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running) --get out if you are
                end
                
                index = index + 1 --go to next victim
                
                if Fling[4] == false then
                    break
                end
            else
                index = index + 1
            end
        end
    end
end

--[[events:]]--
CloseButton.MouseButton1Down:Connect(function()
    TitleBar:TweenPosition(UDim2.new(-0.3, 0, 0.7, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.75)
	DisplayText("Goodbye!","")
	wait(0.8)
	ScreenGui.Enabled = false
	ScreenGui:Destroy()
	script:Destroy()
end)

SpeedUp.MouseButton1Down:Connect(function()
    Fling[3] = Fling[3] + 50
    SpeedBox.Text = "Speed: "..Fling[3]
    
    if Fling[1] then
        BodyThrust.Force = Vector3.new(Fling[3], 0, 0)
        BodyThrust.Location = Vector3.new(0, 0, Fling[3])
    end
end)

SpeedDown.MouseButton1Down:Connect(function()
    Fling[3] = Fling[3] - 50
    SpeedBox.Text = "Speed: "..Fling[3]
    
    if Fling[1] then
        BodyThrust.Force = Vector3.new(Fling[3], 0, 0)
        BodyThrust.Location = Vector3.new(0, 0, Fling[3])
    end
end)

SpeedBox.FocusLost:Connect(function()
    Fling[3] = SpeedBox.Text:gsub("%D",""):sub(0,5)
    if Fling[3] ~= nil then
        SpeedBox.Text = "Speed: "..Fling[3]
        if Fling[1] then
            BodyThrust.Force = Vector3.new(Fling[3], 0, 0)
            BodyThrust.Location = Vector3.new(0, 0, Fling[3])
        end
    end
    
end)

Hotkey.FocusLost:Connect(function()
    Fling[2] = Hotkey.Text:split(" ")[1]:sub(1,1)
    if Fling[2] ~= nil then
        Hotkey.Text = "Hotkey: "..Fling[2]
    end
end)


ToggleFling.MouseButton1Down:Connect(function()
    TToggleFling()
end)

Respawn.MouseButton1Down:Connect(function()
        
    if Fling[1] then --disable fling if its enabled
        TToggleFling()
    end
    
    wait(0.4) --wait for fling to stop
    
    for i=0,10,1 do
        plr.Character.Humanoid:ChangeState(2) --make player recover from falling
    end
    
    for i, v in pairs(plr.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Velocity, v.RotVelocity = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
        end
    end
end)

ToggleServerKill.MouseButton1Down:Connect(function()
    Fling[4] = not Fling[4]
    if Fling[4] then
        OpenObject(ToggleServerKill)
        DisplayText("Enabled ServerKek","")
        ServerKek()
    else
        CloseObject(ToggleServerKill)
        DisplayText("Disabled ServerKek","There might be a delay!")
    end
    
end)

NoVertGain.MouseButton1Down:Connect(function()
    Fling[5] = not Fling[5]
    if Fling[5] then
        OpenObject(NoVertGain)
    else
        CloseObject(NoVertGain)
    end
end)

RunService.Stepped:Connect(function()
    if Fling[1] then
        EnableNoClip()
    elseif Fling[5] then
        for i, v in pairs(plr.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Velocity, v.RotVelocity = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
            end
        end
    end
end)

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging[1] = true
        Dragging[2] = input.Position
        Dragging[3] = TitleBar.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging[1] = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if Dragging[1] then
            local delta = input.Position - Dragging[2]
            TitleBar:TweenPosition(UDim2.new(Dragging[3].X.Scale, Dragging[3].X.Offset + delta.X, Dragging[3].Y.Scale, Dragging[3].Y.Offset + delta.Y), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.035)
            wait()
        end
    end
end)

mouse.KeyDown:Connect(function(key)
    if key == Fling[2] then
        TToggleFling()
    end
end)


DisplaySuggestion()
TitleBar:TweenPosition(UDim2.new(0.25, 0, 0.7, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.75)
DisplayText("Loaded Fling GUI "..version, "Made by Swervo#0462", 3)
return nil
    end
})
BTab:AddButton({
    Name = "计时器",
    Desc = "What?",
    Callback = function()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TimerGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "TimerFrame"
mainFrame.Size = UDim2.new(0, 120, 0, 40)
mainFrame.Position = UDim2.new(0, 20, 0.5, -20)
mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local timerLabel = Instance.new("TextLabel")
timerLabel.Name = "TimerLabel"
timerLabel.Size = UDim2.new(1, 0, 1, 0)
timerLabel.Position = UDim2.new(0, 0, 0, 0)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "0:00"
timerLabel.TextColor3 = Color3.new(0.5, 1, 0)
timerLabel.TextScaled = true
timerLabel.Font = Enum.Font.RobotoMono
timerLabel.Parent = mainFrame

local textGradient = Instance.new("UIGradient")
textGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.5, 1, 0)),
    ColorSequenceKeypoint.new(1, Color3.new(0, 0.4, 0))
}
textGradient.Rotation = 90
textGradient.Parent = timerLabel

local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 8)
padding.PaddingRight = UDim.new(0, 8)
padding.PaddingTop = UDim.new(0, 4)
padding.PaddingBottom = UDim.new(0, 4)
padding.Parent = mainFrame

local startButton = Instance.new("TextButton")
startButton.Name = "StartButton"
startButton.Size = UDim2.new(0, 40, 0, 40)
startButton.Position = UDim2.new(0, 20, 0.5, 30)
startButton.BackgroundColor3 = Color3.new(0, 0, 0.5)
startButton.BorderSizePixel = 0
startButton.Text = "开始"
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.TextScaled = true
startButton.Font = Enum.Font.RobotoMono
startButton.Parent = screenGui

local creditLabel = Instance.new("TextLabel")
creditLabel.Name = "CreditLabel"
creditLabel.Size = UDim2.new(0, 200, 0, 30)
creditLabel.Position = UDim2.new(0, 70, 0.5, 30)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "计时器"
creditLabel.TextColor3 = Color3.new(1, 1, 1)
creditLabel.TextScaled = true
creditLabel.Font = Enum.Font.RobotoMono
creditLabel.TextXAlignment = Enum.TextXAlignment.Left
creditLabel.Parent = screenGui

local startTime = nil
local timerRunning = false
local heartbeatConnection = nil

local function updateTimer()
    if not timerRunning or not startTime then return end
    
    local currentTime = tick()
    local elapsed = currentTime - startTime
    
    local minutes = math.floor(elapsed / 60)
    local seconds = math.floor(elapsed % 60)
    
    timerLabel.Text = string.format("%d:%02d", minutes, seconds)
end

startButton.MouseButton1Click:Connect(function()
    if not timerRunning then
        
        timerRunning = true
        startTime = tick()
        startButton.Text = "停止"
        startButton.BackgroundColor3 = Color3.new(1, 0, 0)
        
        textGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0.5, 1, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0.4, 0)) 
        }
        
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(updateTimer)
    else
        
        timerRunning = false
        startButton.Text = "开始"
        startButton.BackgroundColor3 = Color3.new(0, 0, 0.5) -- Back to dark blue
        
        
        textGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0.5, 0.8, 1)), -- Sky blue at top
            ColorSequenceKeypoint.new(1, Color3.new(0, 0.2, 0.6))  -- Dark blue at bottom
        }
        
        
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
    end
end)
    end
})

RTab = Window:MakeTab({
  IsMobile = true,
  Name = "范围",
  Icon = "rbxassetid://4483345998"
})

RTab:AddButton({
    Name = "Acrylix（通用）",
    Desc = "加载Acrylix通用脚本",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/3dsonsuce/acrylix/main/Acrylix'))()
    end
})

RTab:AddTextbox({
    Name = "自定义范围",
    Desc = "设置自定义Hitbox范围大小",
    Default = "25",
    TextDisappear = true,
    Callback = function(Value)
        _G.HeadSize = Value
        _G.Disabled = true 
        game:GetService('RunService').RenderStepped:connect(function()
            if _G.Disabled then
                for i,v in next, game:GetService('Players'):GetPlayers() do
                    if v.Name ~= game:GetService('Players').LocalPlayer.Name then 
                        pcall(function()
                            v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) 
                            v.Character.HumanoidRootPart.Transparency = 0.7 
                            v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
                            v.Character.HumanoidRootPart.Material = "Neon"
                            v.Character.HumanoidRootPart.CanCollide = false
                        end)
                    end 
                end 
            end
        end)
    end           
})

RTab:AddButton({
    Name = "全游戏通用范围",
    Desc = "启用全游戏通用的Hitbox范围",
    Callback = function()
        local ScreenGui = Instance.new("ScreenGui")
        local main = Instance.new("Frame")
        local label = Instance.new("TextLabel")
        local Hitbox = Instance.new("TextButton")
        
        ScreenGui.Parent = game.CoreGui
        
        main.Name = "main"
        main.Parent = ScreenGui
        main.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        main.Position = UDim2.new(0.40427351, 0, 0.34591195, 0)
        main.Size = UDim2.new(0, 100, 0, 100)
        main.Active = true
        main.Draggable = true
        
        label.Name = "label"
        label.Parent = main
        label.BackgroundColor3 = Color3.fromRGB(139,0,0)
        label.Size = UDim2.new(0, 100, 0, 20)
        label.Font = Enum.Font.SourceSans
        label.Text = "hitbox GUI"
        label.TextColor3 = Color3.fromRGB(0, 0, 0)
        label.TextScaled = true
        label.TextSize = 5.000
        label.TextWrapped = true
        
        Hitbox.Name = "Hitbox"
        Hitbox.Parent = main
        Hitbox.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        Hitbox.Position = UDim2.new(0.114285722, 0, 0.372448981, 0)
        Hitbox.Size = UDim2.new(0, 90, 0, 40)
        Hitbox.Font = Enum.Font.SourceSans
        Hitbox.Text = "hitbox"
        Hitbox.TextColor3 = Color3.fromRGB(0, 0, 0)
        Hitbox.TextSize = 40.000
        Hitbox.MouseButton1Down:connect(function()
            _G.HeadSize = 20
            _G.Disabled = true
            
            game:GetService('RunService').RenderStepped:connect(function()
                if _G.Disabled then
                    for i,v in next, game:GetService('Players'):GetPlayers() do
                        if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                            pcall(function()
                                v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
                                v.Character.HumanoidRootPart.Transparency = 0.7
                                v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
                                v.Character.HumanoidRootPart.Material = "Neon"
                                v.Character.HumanoidRootPart.CanCollide = false
                            end)
                        end
                    end
                end
            end)
        end)
    end
})

RTab:AddButton({
    Name = "空范围",
    Desc = "启用空范围Hitbox",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BINjiaobzx6/BINjiao/main/%E7%A9%BA%E9%80%8F%E8%A7%86.lua"))()
    end
})

RTab:AddButton({
    Name = "普通范围",
    Desc = "启用普通范围Hitbox",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/jiNwDbCN"))()
    end
})

RTab:AddButton({
    Name = "中等范围",
    Desc = "启用中等范围Hitbox",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/x13bwrFb"))()
    end
})

RTab:AddButton({
    Name = "全图范围",
    Desc = "启用全图范围Hitbox",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/KKY9EpZU"))()
    end
})

RTab:AddButton({
    Name = "终极范围",
    Desc = "启用终极范围Hitbox",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/CAQ9x4A7"))()
    end
})

MTab = Window:MakeTab({
  IsMobile = true,
  Name = "加入服务器",
  Icon = "rbxassetid://4483345998"
})
MTab:AddButton({
    Name = "加入极速传奇",
    Desc = "传送到极速传奇游戏",
    Callback = function()
        local game_id = 3101667897
        game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)
    end
})

MTab:AddButton({
    Name = "加入鲨口求生2",
    Desc = "传送到鲨口求生2游戏",
    Callback = function()
        local game_id = 8908228901
        game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)
    end
})

MTab:AddButton({
    Name = "加入监狱人生",
    Desc = "传送到监狱人生游戏",
    Callback = function()
        local game_id = 155615604
        game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)
    end
})

MTab:AddButton({
    Name = "加入忍者传奇",
    Desc = "传送到忍者传奇游戏",
    Callback = function()
        local game_id = 3956818381
        game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)
    end
})

MTab:AddButton({
    Name = "加入Break in",
    Desc = "传送到Break in游戏",
    Callback = function()
        local game_id = 1318971886
        game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)
    end
})

MTab:AddButton({
    Name = "加入自然灾害Game",
    Desc = "传送到自然灾害Game",
    Callback = function()
        local game_id = 189707
        game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)
    end
})

MTab:AddButton({
    Name = "加入力量传奇",
    Desc = "传送到力量传奇游戏",
    Callback = function()
        local game_id = 3623096087
        game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)
    end
})

MTab:AddButton({
    Name = "加入餐厅大亨2",
    Desc = "传送到餐厅大亨2游戏",
    Callback = function()
        local game_id = 3398014311
        game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)
    end
})

NTab = Window:MakeTab({
  IsMobile = true,
  Name = "音乐",
  Icon = "rbxassetid://4483345998"
})

NTab:AddButton({
    Name = "植物大战僵尸",
    Desc = "播放植物大战僵尸音乐并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://158260415"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("158260415")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "早安越南",
    Desc = "播放早安越南音乐并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://8295016126"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("8295016126")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "愤怒芒西 Evade?",
    Desc = "播放愤怒芒西音乐并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://5029269312"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("5029269312")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "梅西",
    Desc = "播放梅西音乐并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://7354576319"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("7352576319")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "永春拳",
    Desc = "播放永春拳音乐并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://1845973140"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("1845973140")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "带劲的音乐",
    Desc = "播放带劲的音乐并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://18841891575"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("18841891517")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "韩国国歌",
    Desc = "播放韩国国歌并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://1837478300"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("1837478300")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "“哥哥你女朋友不会吃醋吧?”",
    Desc = "播放该梗音频并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://8715811379"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("8715811379")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "蜘蛛侠出场声音",
    Desc = "播放蜘蛛侠出场声音并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9108472930"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("918472930")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "消防车",
    Desc = "播放消防车声音并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://317455930"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("317455930")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "万圣节1🎃",
    Desc = "播放万圣节音乐并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://1837467198"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("1837457198")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "好听的",
    Desc = "播放好听的音乐并复制ID",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://1844125168"
        sound.Parent = game.Workspace
        sound:Play()
        setclipboard("1844125168")
        Notification:Notify(
            {Title = "帝脚本中心", Description = "已复制到粘贴板..."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)}
        )
    end
})

NTab:AddButton({
    Name = "国外音乐脚本",
    Desc = "加载国外音乐脚本",
    Callback = function()
        loadstring(game:HttpGet(('https://pastebin.com/raw/g97RafnE'), true))()
    end
})

NTab:AddButton({
    Name = "国歌[Krx版]",
    Desc = "播放国歌[Krx版]",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://1845918434"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "妈妈生的",
    Desc = "播放'妈妈生的'音频",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6689498326"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "Music Ball-CTT",
    Desc = "播放Music Ball-CTT音乐",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9045415830"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "电音",
    Desc = "播放电音音乐",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6911766512"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "梗合集",
    Desc = "播放梗合集音频",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://8161248815"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "Its been so long",
    Desc = "播放'Its been so long'音乐",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6913550990"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "Baller",
    Desc = "播放Baller音乐",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://13530439660"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "男娘必听",
    Desc = "播放男娘必听音乐",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6797864253"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "螃蟹之舞",
    Desc = "播放螃蟹之舞音乐",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://54100886218"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "布鲁克林惨案",
    Desc = "播放布鲁克林惨案音频",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6783714255"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

NTab:AddButton({
    Name = "航空模拟器音乐",
    Desc = "播放航空模拟器音乐",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://1838080629"
        sound.Parent = game.Workspace
        sound:Play()
    end
})

PTab = Window:MakeTab({
  IsMobile = true,
  Name = "罗宝",
  Icon = "rbxassetid://4483345998"
})

PTab:AddButton({
    Name = "10 Robux",
    Desc = "点击获取10 Robux",
    Callback = function()
        game.Players.LocalPlayer:Kick('获取10Robux完成，请到通知查看')
    end
})

PTab:AddButton({
    Name = "20 Robux",
    Desc = "点击获取20 Robux",
    Callback = function()
        game.Players.LocalPlayer:Kick('获取20Robux完成，请到通知查看')
    end
})

PTab:AddButton({
    Name = "50 Robux",
    Desc = "点击获取50 Robux",
    Callback = function()
        game.Players.LocalPlayer:Kick('获取50Robux完成，请到通知查看')
    end
})

PTab:AddButton({
    Name = "100 Robux",
    Desc = "点击获取100 Robux",
    Callback = function()
        game.Players.LocalPlayer:Kick('臭傻屌被骗了吧😭😰😡😂🤓🤮😒🤣😎')
    end
})

PTab:AddTextbox({
    Name = "自定义Robux",
    Default = "Robux",
    PlaceholderText = "输入Robux数量",
    TextDisappear = true,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.Health = tonumber(Value) or 100
    end
})


CTab = Window:MakeTab({
  IsMobile = true,
  Name = "被遗弃",
  Icon = "rbxassetid://4483345998"
})

CTab:AddButton({
    Name = "被遗弃脚本",
    Desc = "注意:汉化了˘ᗜ˘",
    Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E9%81%97%E5%BC%83.lua"))()
    end
})

CTab:AddButton({
    Name = "被遗弃‪ᯅ̈",
    Desc = "Q3E4制作",
    Callback = function()
            loadstring(game:HttpGet("https://raw.github.com/OAO-Kamu/I/main/Forsaken-CHANGED.Luau"))()
    end
})

DTab = Window:MakeTab({
  IsMobile = true,
  Name = "战争大亨",
  Icon = "rbxassetid://4483345998"
})

DTab:AddButton({
    Name = "战争大亨中文",
    Desc = "wow",
    Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E6%88%98%E4%BA%89%E5%A4%A7%E4%BA%A8.lua"))()
    end
})


ETab = Window:MakeTab({
  IsMobile = true,
  Name = "吃掉世界",
  Icon = "rbxassetid://4483345998"
})

ETab:AddButton({
    Name = "吃掉世界",
    Desc = "小北制作",
    Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E5%90%83%E6%8E%89%E4%B8%96%E7%95%8C.lua"))()
    end
})

FTab = Window:MakeTab({
  IsMobile = true,
  Name = "凹凸世界",
  Icon = "rbxassetid://4483345998"
})

FTab:AddToggle({
    Name = "自动收集球体",
    Desc = "启用后自动收集球体",
    Default = false,
    Flag = "ToggleTest",
    Save = true,
    Callback = function(Value)
        AutoBallFarm = Value
        
        if Value then
            
            task.spawn(function()
                while AutoBallFarm and task.wait(0.1) do  -- 添加适当延迟
                    local number_1 = 2
                    local table_1 = { [1] = 1, [2] = 1, [3] = 19 }
                    local Target = game:GetService("ReplicatedStorage").Project.RemoteEvent.ControlMessageEvent
                    Target:FireServer(number_1, table_1)
                end
            end)
        end
    end
})

GTab = Window:MakeTab({
  IsMobile = true,
  Name = "俄亥俄州",
  Icon = "rbxassetid://4483345998"
})

GTab:AddButton({
    Name = "俄亥俄州~小北",
    Desc = "持续更新⸝⸝ ᷇࿀ ᷆⸝⸝",
    Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/-/refs/heads/main/xk%E4%BF%84%E4%BA%A5%E4%BF%84%E5%B7%9E.lua"))()
    end
})

HTab = Window:MakeTab({
  IsMobile = true,
  Name = "制作一架飞机",
  Icon = "rbxassetid://4483345998"
})

HTab:AddButton({
    Name = "制作一架飞机",
    Desc = "制作一架飞机~汉化功能较少",
    Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E5%BB%BA%E9%80%A0%E4%B8%80%E9%A9%BE%E9%A3%9E%E6%9C%BA.lua"))()
    end
})

lTab = Window:MakeTab({
  IsMobile = true,
  Name = "种植花园",
  Icon = "rbxassetid://4483345998"
})

lTab:AddButton({
    Name = "功能一",
    Desc = "⸝⸝ ᷇࿀ ᷆⸝⸝",
    Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E8%8A%B1%E5%9B%AD.lua"))()
    end
})

JTab = Window:MakeTab({
  IsMobile = true,
  Name = "伐木大亨2",
  Icon = "rbxassetid://4483345998"
})

JTab:AddButton({
    Name = "伐木脚本",
    Desc = "小北伐木",
    Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/-/refs/heads/main/%E4%BC%90%E6%9C%A8%E8%84%9A%E6%9C%AC.Lua"))()
    end
})

KTab = Window:MakeTab({
  IsMobile = true,
  Name = "监狱人生",
  Icon = "rbxassetid://4483345998"
})

KTab:AddButton({
    Name = "单车",
    Desc = "生成一辆自行车",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zLe3e4BS"))()
    end
})

KTab:AddButton({
    Name = "kill全部人",
    Desc = "消灭所有玩家",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/kXjfpFPh"))()
    end
})

KTab:AddButton({
    Name = "变身死神",
    Desc = "变身为死神角色",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/ewv9bbRp"))()
    end
})

KTab:AddButton({
    Name = "变身警察",
    Desc = "加入警察队伍",
    Callback = function()
        workspace.Remote.TeamEvent:FireServer("Bright blue")
    end
})

KTab:AddButton({
    Name = "变身囚犯",
    Desc = "加入囚犯队伍",
    Callback = function()
        workspace.Remote.TeamEvent:FireServer("Bright orange")
    end
})

KTab:AddButton({
    Name = "钢筋",
    Desc = "获取钢筋武器",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/7prijqYH"))()
    end
})

KTab:AddButton({
    Name = "手里剑",
    Desc = "获取手里剑武器",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/mSLiAZHk"))()
    end
})

KTab:AddButton({
    Name = "无敌",
    Desc = "启用无敌模式",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/LdTVujTA"))()
    end
})

KTab:AddButton({
    Name = "食堂传送",
    Desc = "传送到食堂位置",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(921.0059204101562, 99.98993682861328, 2289.23095703125)
    end
})

KTab:AddButton({
    Name = "下水道传送",
    Desc = "传送到下水道位置",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.4256591796875, 78.69828033447266, 2416.18359375)
    end
})

KTab:AddButton({
    Name = "警车库传送",
    Desc = "传送到警车库位置",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(602.7301635742188, 98.20000457763672, 2503.56982421875)
    end
})

KTab:AddButton({
    Name = "院子传送",
    Desc = "传送到院子位置",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(788.5759887695312, 97.99992370605469, 2455.056640625)
    end
})

KTab:AddButton({
    Name = "犯罪复活点传送",
    Desc = "传送到犯罪复活点",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875)
    end
})

KTab:AddButton({
    Name = "监狱外面传送",
    Desc = "传送到监狱外部",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)
    end
})

KTab:AddButton({
    Name = "监狱内传送",
    Desc = "传送到监狱内部",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875)
    end
})

KTab:AddButton({
    Name = "警卫室传送",
    Desc = "传送到警卫室",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875)
    end
})

LTab = Window:MakeTab({
  IsMobile = true,
  Name = "极速传奇",
  Icon = "rbxassetid://4483345998"
})

LTab:AddButton({
    Name = "极速脚本",
    Desc = "北极星版本",
    Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E6%9E%81%E9%80%9F%E4%BC%A0%E5%A5%87.lua"))()
    end
})

OTab = Window:MakeTab({
  IsMobile = true,
  Name = "城市防御大亨",
  Icon = "rbxassetid://4483345998"
})

OTab:AddButton({
    Name = "无限金钱",
    Desc = "尝试获取大量游戏货币",
    Callback = function()
        local args = { [1] = math.huge }
        game:GetService("ReplicatedStorage").Knit.Services.RaidService.RF.GiveReward:InvokeServer(unpack(args))
    end
})

STab = Window:MakeTab({
  IsMobile = true,
  Name = "忍者传奇",
  Icon = "rbxassetid://4483345998"
})

STab:AddToggle({
    Name = "自动购买剑",
    Desc = "自动购买剑类武器",
    Default = false,
    IsMobile = false,
    Flag = "AutoBuySwordsToggle",
    Save = true,
    Callback = function(Value)
        autobuyswords = Value
        if autobuyswords then
            buyswords()
        end
    end
})

STab:AddToggle({
    Name = "自动购买腰带",
    Desc = "自动购买腰带装备",
    Default = false,
    IsMobile = false,
    Flag = "AutoBuyBeltsToggle",
    Save = true,
    Callback = function(Value)
        autobuybelts = Value
        if autobuybelts then
            buybelts()
        end
    end
})

STab:AddToggle({
    Name = "自动购买称号（等级）",
    Desc = "自动购买等级称号",
    Default = false,
    IsMobile = false,
    Flag = "AutoBuyRanksToggle",
    Save = true,
    Callback = function(Value)
        autobuyranks = Value
        if autobuyranks then
            buyranks()
        end
    end
})

STab:AddToggle({
    Name = "自动购买忍术",
    Desc = "自动购买忍术技能",
    Default = false,
    IsMobile = false,
    Flag = "AutoBuySkillToggle",
    Save = true,
    Callback = function(Value)
        autobuyskill = Value
        if autobuyskill then
            buyskill()
        end
    end
})

STab:AddToggle({
    Name = "自动购买（全部打开）",
    Desc = "自动购买所有可购买的物品",
    Default = false,
    IsMobile = false,
    Flag = "AutoBuyAllToggle",
    Save = true,
    Callback = function(Value)
        autobuyshurikens = Value
        if autobuyshurikens then
            buyshurikens()
        end
    end
})

STab:AddToggle({
    Name = "自动挥舞",
    Desc = "自动挥舞武器",
    Default = false,
    IsMobile = false,
    Flag = "AutoSwingToggle",
    Save = true,
    Callback = function(Value)
        autoswing = Value
        if autoswing then
            swinging()
        end
    end
})

STab:AddToggle({
    Name = "自动售卖",
    Desc = "自动售卖物品",
    Default = false,
    IsMobile = false,
    Flag = "AutoSellToggle",
    Save = true,
    Callback = function(Value)
        autosell = Value
        if autosell then
            selling()
        end
    end
})

STab:AddToggle({
    Name = "存满了自动售卖",
    Desc = "库存满时自动售卖",
    Default = false,
    IsMobile = false,
    Flag = "AutoSellMaxToggle",
    Save = true,
    Callback = function(Value)
        autosellmax = Value
        if autosellmax then
            maxsell()
        end
    end
})

STab:AddButton({
    Name = "解锁所有岛",
    Desc = "自动传送到所有岛屿解锁区域",
    Callback = function()
        for _, v in next, game.workspace.islandUnlockParts:GetChildren() do
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.islandSignPart.CFrame
                wait(.5)
            end
        end
    end
})

STab:AddButton({
    Name = "附魔岛",
    Desc = "传送到附魔岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(83.028564453125, 766.3915405273438, -128.62686157226562)
    end
})

STab:AddButton({
    Name = "星界岛",
    Desc = "传送到星界岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(144.43006896972656, 2014.091064453125, 247.5571746826172)
    end
})

STab:AddButton({
    Name = "神秘岛",
    Desc = "传送到神秘岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(162.7420654296875, 4047.7841796875, 13.378257751464844)
    end
})

STab:AddButton({
    Name = "太空岛",
    Desc = "传送到太空岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(184.0364227294922, 5657.091796875, 161.54000854492188)
    end
})

STab:AddButton({
    Name = "冻土岛",
    Desc = "传送到冻土岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(186.7508544921875, 9285.08984375, 158.16287231445312)
    end
})

STab:AddButton({
    Name = "沙暴",
    Desc = "传送到沙暴岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(183.7511749267578, 17686.236328125, 147.5008087158203)
    end
})

STab:AddButton({
    Name = "雷暴",
    Desc = "传送到雷暴岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(186.87640380859375, 24069.9296875, 158.25582885742188)
    end
})

STab:AddButton({
    Name = "远古炼狱岛",
    Desc = "传送到远古炼狱岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(166.48052978515625, 28256.201171875, 160.25828552246094)
    end
})

STab:AddButton({
    Name = "午夜暗影岛",
    Desc = "传送到午夜暗影岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(182.76388549804688, 33206.88671875, 136.66305541992188)
    end
})

STab:AddButton({
    Name = "神秘灵魂岛",
    Desc = "传送到神秘灵魂岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(157.39967346191406, 39317.4765625, 146.05630493164062)
    end
})

STab:AddButton({
    Name = "冬季奇迹岛",
    Desc = "传送到冬季奇迹岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(168.73797607421875, 46010.4609375, 158.589599609375)
    end
})

STab:AddButton({
    Name = "黄金大师岛",
    Desc = "传送到黄金大师岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(184.56202697753906, 52607.671875, 166.47279357910156)
    end
})

STab:AddButton({
    Name = "龙传奇岛",
    Desc = "传送到龙传奇岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(166.83065795898438, 59594.58984375, 150.16586303710938)
    end
})

STab:AddButton({
    Name = "赛博传奇岛",
    Desc = "传送到赛博传奇岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(167.66766357421875, 66669.0703125, 142.27223205566406)
    end
})

STab:AddButton({
    Name = "天岚超能岛",
    Desc = "传送到天岚超能岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(182.09237670898438, 70271.0625, 157.14857482910156)
    end
})

STab:AddButton({
    Name = "混沌传奇岛",
    Desc = "传送到混沌传奇岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(177.88784790039062, 74442.7578125, 143.346435546875)
    end
})

STab:AddButton({
    Name = "灵魂融合岛",
    Desc = "传送到灵魂融合岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(183.39129638671875, 79746.890625, 163.01148986816406)
    end
})

STab:AddButton({
    Name = "黑暗元素岛",
    Desc = "传送到黑暗元素岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(169.4972381591797, 83198.890625, 170.53890991210938)
    end
})

STab:AddButton({
    Name = "禅心岛",
    Desc = "传送到禅心岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(173.4744873046875, 87050.9765625, 141.89602661132812)
    end
})

STab:AddButton({
    Name = "炽热漩涡之岛",
    Desc = "传送到炽热漩涡之岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(178.33023071289062, 91245.96875, 152.53775024414062)
    end
})

VTab = Window:MakeTab({
  IsMobile = true,
  Name = "穿着溜冰鞋的布娃娃Obby",
  Icon = "rbxassetid://4483345998"
})

VTab:AddButton({
    Name = "复制服务器名字",
    Desc = "复制服务器名称到剪贴板",
    Callback = function()
        setclipboard("Ragdoll on Skates Obby")
    end
})

VTab:AddButton({
    Name = "无限跳过",
    Desc = "获取无限跳过次数",
    Callback = function()
        game:GetService("ReplicatedStorage").Shared.RemoteFunctions.PlayerProfileRemote:InvokeServer("increment", "Skips", math.huge)
    end
})

VTab:AddTextbox({
    Name = "输入获取跳过",
    Desc = "输入自定义数量的跳过次数",
    TextDisappear = false,
    Callback = function(c, d)
        if d then
            game:GetService("ReplicatedStorage").Shared.RemoteFunctions.PlayerProfileRemote:InvokeServer("increment", "Skips", c)
        end
    end
})

VTab:AddButton({
    Name = "无限胜利",
    Desc = "获取无限胜利次数",
    Callback = function()
        game:GetService("ReplicatedStorage").Shared.RemoteFunctions.PlayerProfileRemote:InvokeServer("increment", "Wins", math.huge)
    end
})

VTab:AddTextbox({
    Name = "输入获取胜利",
    Desc = "输入自定义数量的胜利次数",
    TextDisappear = false,
    Callback = function(e, f)
        if f then
            game:GetService("ReplicatedStorage").Shared.RemoteFunctions.PlayerProfileRemote:InvokeServer("increment", "Wins", e)
        end
    end
})

VTab:AddButton({
    Name = "无限旋转",
    Desc = "获取无限旋转次数",
    Callback = function()
        game:GetService("ReplicatedStorage").Shared.RemoteFunctions.PlayerProfileRemote:InvokeServer("increment", "Spins", math.huge)
    end
})

VTab:AddTextbox({
    Name = "输入获取旋转",
    Desc = "输入自定义数量的旋转次数",
    TextDisappear = false,
    Callback = function(g, h)
        if h then
            game:GetService("ReplicatedStorage").Shared.RemoteFunctions.PlayerProfileRemote:InvokeServer("increment", "Spins", g)
        end
    end
})

VTab:AddButton({
    Name = "无限金币",
    Desc = "获取无限金币",
    Callback = function()
        game:GetService("ReplicatedStorage").Shared.RemoteFunctions.PlayerProfileRemote:InvokeServer("increment", "Coins", math.huge)
    end
})

VTab:AddTextbox({
    Name = "输入获取金币",
    Desc = "输入自定义数量的金币",
    TextDisappear = false,
    Callback = function(i, j)
        if j then
            game:GetService("ReplicatedStorage").Shared.RemoteFunctions.PlayerProfileRemote:InvokeServer("increment", "Coins", i)
        end
    end
})

WTab = Window:MakeTab({
  IsMobile = true,
  Name = "彩虹朋友",
  Icon = "rbxassetid://4483345998"
})

WTab:AddButton({
    Name = "自动收集积木块",
    Desc = "自动收集所有积木块物品",
    Flag = "CollectBlocksButton",
    Callback = function()
        for v = 1, 24 do
            if workspace:FindFirstChild("Block"..v) then
                Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("Block"..v).TouchTrigger.CFrame
                wait(0.2)
                Character.HumanoidRootPart.CFrame = workspace["GroupBuildStructures"]:FindFirstChildOfClass("Model").Trigger.CFrame
                wait(0.2)
                tpSpawn()
                wait(0.2)
            end
        end
    end    
})

WTab:AddButton({
    Name = "自动收集食品包",
    Desc = "自动收集所有颜色的食品包",
    Flag = "CollectFoodButton",
    Callback = function()
        for v = 1, 15 do
            if workspace:FindFirstChild("FoodGreen") then
                Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("FoodGreen").TouchTrigger.CFrame
                wait(0.2)
                Character.HumanoidRootPart.CFrame = workspace["GroupBuildStructures"]:FindFirstChildOfClass("Model").Trigger.CFrame
                wait(0.2)
                tpSpawn()
                wait(0.2)
            end
            if workspace:FindFirstChild("FoodOrange") then
                Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("FoodOrange").TouchTrigger.CFrame
                wait(0.2)
                Character.HumanoidRootPart.CFrame = workspace["GroupBuildStructures"]:FindFirstChildOfClass("Model").Trigger.CFrame
                wait(0.2)
                tpSpawn()
                wait(0.2)
            end
            if workspace:FindFirstChild("FoodPink") then
                Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("FoodPink").TouchTrigger.CFrame
                wait(0.2)
                Character.HumanoidRootPart.CFrame = workspace["GroupBuildStructures"]:FindFirstChildOfClass("Model").Trigger.CFrame
                wait(0.2)
                tpSpawn()
                wait(0.2)
            end
        end
    end    
})

WTab:AddButton({
    Name = "自动收集保险丝",
    Desc = "自动收集所有保险丝物品",
    Flag = "CollectFusesButton",
    Callback = function()
        for v = 1, 14 do
            if workspace:FindFirstChild("Fuse"..v) then
                Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("Fuse"..v).TouchTrigger.CFrame
                wait(0.2)
                Character.HumanoidRootPart.CFrame = workspace["GroupBuildStructures"]:FindFirstChildOfClass("Model").Trigger.CFrame
                wait(0.2)
                tpSpawn()
                wait(0.2)
            end
        end
    end    
})

WTab:AddButton({
    Name = "自动收集电池",
    Desc = "自动收集所有电池物品",
    Flag = "CollectBatteriesButton",
    Callback = function()
        for v = 1, 24 do
            if workspace:FindFirstChild("Battery") then
                Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("Battery").TouchTrigger.CFrame
                wait(0.2)
                Character.HumanoidRootPart.CFrame = workspace["GroupBuildStructures"]:FindFirstChildOfClass("Model").Trigger.CFrame
                wait(0.2)
                tpSpawn()
                wait(0.2)
            end
        end
    end    
})

local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Tag = {
    Color = "#FFFF00", 
    Chattag = "[EMPEROR VIP]" 
}

TextChatService.OnIncomingMessage = function(Message, ChatStyle)
    local MessageProperties = Instance.new("TextChatMessageProperties")
    local Player = Players:GetPlayerByUserId(Message.TextSource.UserId)
    if Player.Name == LocalPlayer.Name then
        MessageProperties.PrefixText = '<font color="' .. Tag.Color .. '">' .. Tag.Chattag .. '</font> ' .. Message.PrefixText
    end
    return MessageProperties
end
LocalPlayer.CharacterAdded:Connect(function()
    if config.Enabled and combatConnection then
        combatConnection:Disconnect()
        combatConnection = RunService.Stepped:Connect(CombatLoop)
    end
end)