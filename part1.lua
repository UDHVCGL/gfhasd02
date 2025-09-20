local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- 创建主UI
local MRGui = Instance.new("ScreenGui")
MRGui.Name = "MRGui"
MRGui.Parent = CoreGui
MRGui.ResetOnSpawn = false

-- UI设置数据
local UISettings = {
    Theme = "default",
    Themes = {
        default = {
            MainColor = Color3.fromRGB(30, 30, 30),
            TitleColor = Color3.fromRGB(20, 20, 20),
            ContentColor = Color3.fromRGB(40, 40, 40)
        },
        white = {
            MainColor = Color3.fromRGB(240, 240, 240),
            TitleColor = Color3.fromRGB(220, 220, 220),
            ContentColor = Color3.fromRGB(250, 250, 250)
        },
        black = {
            MainColor = Color3.fromRGB(10, 10, 10),
            TitleColor = Color3.fromRGB(0, 0, 0),
            ContentColor = Color3.fromRGB(20, 20, 20)
        }
    }
}

-- 主容器
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 150, 0, 40)
MainContainer.Position = UDim2.new(0, 10, 0, 10)
MainContainer.BackgroundColor3 = UISettings.Themes.default.MainColor
MainContainer.BackgroundTransparency = 0.3
MainContainer.BorderSizePixel = 0
MainContainer.Active = true
MainContainer.Draggable = true
MainContainer.Parent = MRGui

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 20)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = UISettings.Themes.default.TitleColor
TitleBar.BackgroundTransparency = 0.3
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainContainer

-- 标题文本
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 60, 1, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MR中心v1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.Parent = TitleBar

-- 功能按钮容器
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Size = UDim2.new(0, 80, 1, 0)
ButtonContainer.Position = UDim2.new(1, -80, 0, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = TitleBar

-- 功能按钮布局
local ButtonLayout = Instance.new("UIListLayout")
ButtonLayout.Name = "ButtonLayout"
ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
ButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
ButtonLayout.Padding = UDim.new(0, 5)
ButtonLayout.Parent = ButtonContainer

-- 设置按钮
local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Size = UDim2.new(0, 20, 0, 20)
SettingsButton.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
SettingsButton.BackgroundTransparency = 0.3
SettingsButton.BorderSizePixel = 0
SettingsButton.Text = "⚙️"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.Font = Enum.Font.SourceSansBold
SettingsButton.TextSize = 12
SettingsButton.LayoutOrder = 1
SettingsButton.Parent = ButtonContainer

-- 信息按钮
local InfoButton = Instance.new("TextButton")
InfoButton.Name = "InfoButton"
InfoButton.Size = UDim2.new(0, 20, 0, 20)
InfoButton.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
InfoButton.BackgroundTransparency = 0.3
InfoButton.BorderSizePixel = 0
InfoButton.Text = "i"
InfoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoButton.Font = Enum.Font.SourceSansBold
InfoButton.TextSize = 14
InfoButton.LayoutOrder = 2
InfoButton.Parent = ButtonContainer

-- 展开/折叠按钮
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.BackgroundTransparency = 0.3
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "+"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 14
ToggleButton.LayoutOrder = 3
ToggleButton.Parent = ButtonContainer

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
CloseButton.BackgroundTransparency = 0.3
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 14
CloseButton.LayoutOrder = 4
CloseButton.Parent = ButtonContainer

-- 内容区域
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 0, 0)
ContentFrame.Position = UDim2.new(0, 0, 0, 20)
ContentFrame.BackgroundColor3 = UISettings.Themes.default.ContentColor
ContentFrame.BackgroundTransparency = 0.3
ContentFrame.BorderSizePixel = 0
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainContainer

-- 脚本滚动框架
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Visible = false
ScrollFrame.Parent = ContentFrame

-- UI布局
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Name = "UIListLayout"
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollFrame

-- 设置面板
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Size = UDim2.new(0, 250, 0, 120)
SettingsFrame.Position = UDim2.new(0, 220, 0, 30)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SettingsFrame.BackgroundTransparency = 0.3
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Visible = false
SettingsFrame.Active = true
SettingsFrame.Draggable = true
SettingsFrame.Parent = MRGui
