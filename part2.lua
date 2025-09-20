-- 设置面板标题栏
local SettingsTitleBar = Instance.new("Frame")
SettingsTitleBar.Name = "SettingsTitleBar"
SettingsTitleBar.Size = UDim2.new(1, 0, 0, 20)
SettingsTitleBar.Position = UDim2.new(0, 0, 0, 0)
SettingsTitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SettingsTitleBar.BackgroundTransparency = 0.3
SettingsTitleBar.BorderSizePixel = 0
SettingsTitleBar.Parent = SettingsFrame

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Name = "SettingsTitle"
SettingsTitle.Size = UDim2.new(1, -20, 1, 0)
SettingsTitle.Position = UDim2.new(0, 5, 0, 0)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "设置"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.Font = Enum.Font.SourceSansBold
SettingsTitle.TextSize = 12
SettingsTitle.Parent = SettingsTitleBar

-- 关闭设置按钮
local CloseSettingsButton = Instance.new("TextButton")
CloseSettingsButton.Name = "CloseSettingsButton"
CloseSettingsButton.Size = UDim2.new(0, 20, 0, 20)
CloseSettingsButton.Position = UDim2.new(1, -20, 0, 0)
CloseSettingsButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
CloseSettingsButton.BackgroundTransparency = 0.3
CloseSettingsButton.BorderSizePixel = 0
CloseSettingsButton.Text = "X"
CloseSettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSettingsButton.Font = Enum.Font.SourceSansBold
CloseSettingsButton.TextSize = 12
CloseSettingsButton.Parent = SettingsTitleBar

-- 主题设置
local ThemeLabel = Instance.new("TextLabel")
ThemeLabel.Name = "ThemeLabel"
ThemeLabel.Size = UDim2.new(1, -10, 0, 20)
ThemeLabel.Position = UDim2.new(0, 5, 0, 30)
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Text = "UI主题颜色:"
ThemeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeLabel.Font = Enum.Font.SourceSansBold
ThemeLabel.TextSize = 12
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left
ThemeLabel.Parent = SettingsFrame

local ThemeButtonsFrame = Instance.new("Frame")
ThemeButtonsFrame.Name = "ThemeButtonsFrame"
ThemeButtonsFrame.Size = UDim2.new(1, -10, 0, 30)
ThemeButtonsFrame.Position = UDim2.new(0, 5, 0, 55)
ThemeButtonsFrame.BackgroundTransparency = 1
ThemeButtonsFrame.Parent = SettingsFrame

-- 默认主题按钮
local DefaultThemeButton = Instance.new("TextButton")
DefaultThemeButton.Name = "DefaultThemeButton"
DefaultThemeButton.Size = UDim2.new(0.3, 0, 1, 0)
DefaultThemeButton.Position = UDim2.new(0, 0, 0, 0)
DefaultThemeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DefaultThemeButton.BackgroundTransparency = 0.3
DefaultThemeButton.BorderSizePixel = 0
DefaultThemeButton.Text = "默认"
DefaultThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DefaultThemeButton.Font = Enum.Font.SourceSans
DefaultThemeButton.TextSize = 12
DefaultThemeButton.Parent = ThemeButtonsFrame

-- 白色主题按钮
local WhiteThemeButton = Instance.new("TextButton")
WhiteThemeButton.Name = "WhiteThemeButton"
WhiteThemeButton.Size = UDim2.new(0.3, 0, 1, 0)
WhiteThemeButton.Position = UDim2.new(0.35, 0, 0, 0)
WhiteThemeButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
WhiteThemeButton.BackgroundTransparency = 0.3
WhiteThemeButton.BorderSizePixel = 0
WhiteThemeButton.Text = "白色"
WhiteThemeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
WhiteThemeButton.Font = Enum.Font.SourceSans
WhiteThemeButton.TextSize = 12
WhiteThemeButton.Parent = ThemeButtonsFrame

-- 黑色主题按钮
local BlackThemeButton = Instance.new("TextButton")
BlackThemeButton.Name = "BlackThemeButton"
BlackThemeButton.Size = UDim2.new(0.3, 0, 1, 0)
BlackThemeButton.Position = UDim2.new(0.7, 0, 0, 0)
BlackThemeButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
BlackThemeButton.BackgroundTransparency = 0.3
BlackThemeButton.BorderSizePixel = 0
BlackThemeButton.Text = "黑色"
BlackThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BlackThemeButton.Font = Enum.Font.SourceSans
BlackThemeButton.TextSize = 12
BlackThemeButton.Parent = ThemeButtonsFrame

-- 重置设置按钮
local ResetSettingsButton = Instance.new("TextButton")
ResetSettingsButton.Name = "ResetSettingsButton"
ResetSettingsButton.Size = UDim2.new(1, -10, 0, 25)
ResetSettingsButton.Position = UDim2.new(0, 5, 0, 90)
ResetSettingsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ResetSettingsButton.BackgroundTransparency = 0.3
ResetSettingsButton.BorderSizePixel = 0
ResetSettingsButton.Text = "重置设置"
ResetSettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetSettingsButton.Font = Enum.Font.SourceSansBold
ResetSettingsButton.TextSize = 12
ResetSettingsButton.Parent = SettingsFrame

-- 脚本信息显示框
local InfoFrame = Instance.new("Frame")
InfoFrame.Name = "InfoFrame"
InfoFrame.Size = UDim2.new(0, 250, 0, 300)
InfoFrame.Position = UDim2.new(0, 220, 0, 30)
InfoFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InfoFrame.BackgroundTransparency = 0.5
InfoFrame.BorderSizePixel = 0
InfoFrame.Visible = false
InfoFrame.Active = true
InfoFrame.Draggable = true
InfoFrame.Parent = MRGui

-- 信息框标题栏
local InfoTitleBar = Instance.new("Frame")
InfoTitleBar.Name = "InfoTitleBar"
InfoTitleBar.Size = UDim2.new(1, 0, 0, 20)
InfoTitleBar.Position = UDim2.new(0, 0, 0, 0)
InfoTitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InfoTitleBar.BackgroundTransparency = 0.3
InfoTitleBar.BorderSizePixel = 0
InfoTitleBar.Parent = InfoFrame

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Name = "InfoTitle"
InfoTitle.Size = UDim2.new(1, -20, 1, 0)
InfoTitle.Position = UDim2.new(0, 5, 0, 0)
InfoTitle.BackgroundTransparency = 1
InfoTitle.Text = "脚本信息-免费勿倒卖"
InfoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
InfoTitle.Font = Enum.Font.SourceSansBold
InfoTitle.TextSize = 12
InfoTitle.Parent = InfoTitleBar

-- 关闭信息按钮
local CloseInfoButton = Instance.new("TextButton")
CloseInfoButton.Name = "CloseInfoButton"
CloseInfoButton.Size = UDim2.new(0, 20, 0, 20)
CloseInfoButton.Position = UDim2.new(1, -20, 0, 0)
CloseInfoButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
CloseInfoButton.BackgroundTransparency = 0.3
CloseInfoButton.BorderSizePixel = 0
CloseInfoButton.Text = "X"
CloseInfoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseInfoButton.Font = Enum.Font.SourceSansBold
CloseInfoButton.TextSize = 12
CloseInfoButton.Parent = InfoTitleBar

-- 信息内容滚动框架
local InfoScrollFrame = Instance.new("ScrollingFrame")
InfoScrollFrame.Name = "InfoScrollFrame"
InfoScrollFrame.Size = UDim2.new(1, -10, 1, -30)
InfoScrollFrame.Position = UDim2.new(0, 5, 0, 25)
InfoScrollFrame.BackgroundTransparency = 1
InfoScrollFrame.BorderSizePixel = 0
InfoScrollFrame.ScrollBarThickness = 6
InfoScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
InfoScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
InfoScrollFrame.Parent = InfoFrame

-- 信息内容布局
local InfoListLayout = Instance.new("UIListLayout")
InfoListLayout.Name = "InfoListLayout"
InfoListLayout.Padding = UDim.new(0, 5)
InfoListLayout.SortOrder = Enum.SortOrder.LayoutOrder
InfoListLayout.Parent = InfoScrollFrame
