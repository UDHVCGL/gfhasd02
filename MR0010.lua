-----Kenny泛滥我的b站UID:1531514159笑川你这个猪逼
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 清除旧UI
if CoreGui:FindFirstChild("AdvancedTranslatorUI") then
    CoreGui:FindFirstChild("AdvancedTranslatorUI"):Destroy()
end

-- 创建主UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedTranslatorUI"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

-- 彩色颜色序列
local rainbowColors = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.166, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(0.333, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.666, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.833, Color3.fromRGB(75, 0, 130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 130, 238))
})

-- 创建浮动控制按钮
local controlButton = Instance.new("TextButton")
controlButton.Name = "WU_ControlButton"
controlButton.Size = UDim2.new(0, 60, 0, 60)
controlButton.Position = UDim2.new(0, 20, 0, 20)
controlButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
controlButton.Text = "WU"
controlButton.TextColor3 = Color3.fromRGB(255, 255, 255)
controlButton.TextSize = 20
controlButton.Font = Enum.Font.GothamBold
controlButton.ZIndex = 1000
controlButton.Parent = screenGui

local controlCorner = Instance.new("UICorner")
controlCorner.CornerRadius = UDim.new(0, 30)
controlCorner.Parent = controlButton

-- 流动描边效果
local controlStroke = Instance.new("UIStroke")
controlStroke.Color = Color3.fromRGB(255, 255, 255)
controlStroke.Thickness = 1.5
controlStroke.Parent = controlButton

local rainbowGradient = Instance.new("UIGradient")
rainbowGradient.Color = rainbowColors
rainbowGradient.Rotation = 0
rainbowGradient.Parent = controlStroke

-- 流动动画
local rainbowTween = TweenService:Create(rainbowGradient, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 360})
rainbowTween:Play()

-- 创建主界面
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0, 90, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ZIndex = 999
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- 主界面彩色边框
local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(255, 255, 255)
frameStroke.Thickness = 1.5
frameStroke.Parent = mainFrame

local frameRainbow = Instance.new("UIGradient")
frameRainbow.Color = rainbowColors
frameRainbow.Rotation = 0
frameRainbow.Parent = frameStroke

local frameRainbowTween = TweenService:Create(frameRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 360})
frameRainbowTween:Play()

-- 标题栏
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
title.Text = "WU SCRIPT 界面汉化工具"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.ZIndex = 1000
title.Parent = mainFrame

-- 标题彩色边框
local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(255, 255, 255)
titleStroke.Thickness = 1.5
titleStroke.Parent = title

local titleRainbow = Instance.new("UIGradient")
titleRainbow.Color = rainbowColors
titleRainbow.Rotation = 180
titleRainbow.Parent = titleStroke

local titleRainbowTween = TweenService:Create(titleRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 540})
titleRainbowTween:Play()

-- 翻译模式选择
local modeFrame = Instance.new("Frame")
modeFrame.Name = "ModeFrame"
modeFrame.Size = UDim2.new(0.8, 0, 0, 80)
modeFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
modeFrame.BackgroundTransparency = 1
modeFrame.Parent = mainFrame

local modeLabel = Instance.new("TextLabel")
modeLabel.Name = "ModeLabel"
modeLabel.Size = UDim2.new(1, 0, 0, 20)
modeLabel.Position = UDim2.new(0, 0, 0, 0)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "翻译模式:"
modeLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
modeLabel.TextSize = 12
modeLabel.Font = Enum.Font.Gotham
modeLabel.TextXAlignment = Enum.TextXAlignment.Left
modeLabel.Parent = modeFrame

-- 创建模式选择按钮
local modes = {
    {"快速模式", "快速替换", Color3.fromRGB(100, 200, 100)},
    {"自匹配模式", "上下文翻译", Color3.fromRGB(100, 150, 255)},
    {"完整模式", "完整翻译", Color3.fromRGB(200, 100, 255)}
}

local currentMode = 2 -- 默认自匹配模式
local modeButtons = {}

for i, modeData in ipairs(modes) do
    local button = Instance.new("TextButton")
    button.Name = "ModeButton_"..i
    button.Size = UDim2.new(0.3, -5, 0, 25)
    button.Position = UDim2.new((i-1)*0.33, 0, 0.3, 0)
    button.BackgroundColor3 = i == currentMode and modeData[3] or Color3.fromRGB(60, 60, 70)
    button.Text = modeData[1]
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 12
    button.Font = Enum.Font.Gotham
    button.Parent = modeFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 5)
    buttonCorner.Parent = button
    
    -- 添加彩色边框
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(255, 255, 255)
    buttonStroke.Thickness = 1.5
    buttonStroke.Parent = button
    
    local buttonRainbow = Instance.new("UIGradient")
    buttonRainbow.Color = rainbowColors
    buttonRainbow.Rotation = i * 120
    buttonRainbow.Parent = buttonStroke
    
    local buttonRainbowTween = TweenService:Create(buttonRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
        {Rotation = i * 120 + 360})
    buttonRainbowTween:Play()
    
    button.MouseButton1Click:Connect(function()
        currentMode = i
        for j, btn in ipairs(modeButtons) do
            btn.BackgroundColor3 = j == currentMode and modes[j][3] or Color3.fromRGB(60, 60, 70)
        end
        statusText.Text = "模式切换: "..modeData[2]
    end)
    
    table.insert(modeButtons, button)
end

-- 控制按钮
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0.8, 0, 0, 40)
toggleButton.Position = UDim2.new(0.1, 0, 0.4, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
toggleButton.Text = "执行翻译"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.GothamBold
toggleButton.ZIndex = 1000
toggleButton.Parent = mainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- 添加彩色边框
local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 1.5
toggleStroke.Parent = toggleButton

local toggleRainbow = Instance.new("UIGradient")
toggleRainbow.Color = rainbowColors
toggleRainbow.Rotation = 90
toggleRainbow.Parent = toggleStroke

local toggleRainbowTween = TweenService:Create(toggleRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 450})
toggleRainbowTween:Play()

-- 其他选项按钮
local optionsButton = Instance.new("TextButton")
optionsButton.Name = "OptionsButton"
optionsButton.Size = UDim2.new(0.35, 0, 0, 25)
optionsButton.Position = UDim2.new(0.1, 0, 0.55, 0)
optionsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
optionsButton.Text = "其他选项"
optionsButton.TextColor3 = Color3.fromRGB(200, 200, 255)
optionsButton.TextSize = 12
optionsButton.Font = Enum.Font.Gotham
optionsButton.ZIndex = 1000
optionsButton.Parent = mainFrame

local optionsCorner = Instance.new("UICorner")
optionsCorner.CornerRadius = UDim.new(0, 5)
optionsCorner.Parent = optionsButton

-- 添加彩色边框
local optionsStroke = Instance.new("UIStroke")
optionsStroke.Color = Color3.fromRGB(255, 255, 255)
optionsStroke.Thickness = 1.5
optionsStroke.Parent = optionsButton

local optionsRainbow = Instance.new("UIGradient")
optionsRainbow.Color = rainbowColors
optionsRainbow.Rotation = 180
optionsRainbow.Parent = optionsStroke

local optionsRainbowTween = TweenService:Create(optionsRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 540})
optionsRainbowTween:Play()

-- 状态显示
local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(0.8, 0, 0, 20)
statusText.Position = UDim2.new(0.1, 0, 0.65, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "当前状态: 待机"
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.TextSize = 12
statusText.Font = Enum.Font.Gotham
statusText.ZIndex = 1000
statusText.Parent = mainFrame

-- 统计显示
local statsText = Instance.new("TextLabel")
statsText.Name = "StatsText"
statsText.Size = UDim2.new(0.8, 0, 0, 20)
statsText.Position = UDim2.new(0.1, 0, 0.72, 0)
statsText.BackgroundTransparency = 1
statsText.Text = "已翻译: 0 | 缓存: 0 | 速度: 0/s"
statsText.TextColor3 = Color3.fromRGB(200, 200, 255)
statsText.TextSize = 11
statsText.Font = Enum.Font.Gotham
statsText.ZIndex = 1000
statsText.Parent = mainFrame

-- 详情显示
local detailText = Instance.new("TextLabel")
detailText.Name = "DetailText"
detailText.Size = UDim2.new(0.8, 0, 0, 50)
detailText.Position = UDim2.new(0.1, 0, 0.8, 0)
detailText.BackgroundTransparency = 1
detailText.Text = "最近翻译: 无"
detailText.TextColor3 = Color3.fromRGB(180, 220, 180)
detailText.TextSize = 10
detailText.Font = Enum.Font.Gotham
detailText.TextWrapped = true
detailText.ZIndex = 1000
detailText.Parent = mainFrame

-- 关闭按钮
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.ZIndex = 1001
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 12)
closeCorner.Parent = closeButton

-- 添加彩色边框
local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(255, 255, 255)
closeStroke.Thickness = 1.5
closeStroke.Parent = closeButton

local closeRainbow = Instance.new("UIGradient")
closeRainbow.Color = rainbowColors
closeRainbow.Rotation = 270
closeRainbow.Parent = closeStroke

local closeRainbowTween = TweenService:Create(closeRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 630})
closeRainbowTween:Play()

-- 其他选项窗口
local optionsFrame = Instance.new("Frame")
optionsFrame.Name = "OptionsFrame"
optionsFrame.Size = UDim2.new(0, 350, 0, 200)
optionsFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
optionsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
optionsFrame.BorderSizePixel = 0
optionsFrame.Visible = false
optionsFrame.ZIndex = 1002
optionsFrame.Parent = screenGui

local optionsCorner = Instance.new("UICorner")
optionsCorner.CornerRadius = UDim.new(0, 12)
optionsCorner.Parent = optionsFrame

-- 其他选项彩色边框实现
local optionsFrameStroke = Instance.new("UIStroke")
optionsFrameStroke.Color = Color3.fromRGB(255, 255, 255)
optionsFrameStroke.Thickness = 1.5
optionsFrameStroke.Parent = optionsFrame

local optionsFrameRainbow = Instance.new("UIGradient")
optionsFrameRainbow.Color = rainbowColors
optionsFrameRainbow.Rotation = 0
optionsFrameRainbow.Parent = optionsFrameStroke

local optionsFrameRainbowTween = TweenService:Create(optionsFrameRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 360})
optionsFrameRainbowTween:Play()

-- 其他选项内容
local optionsTitle = Instance.new("TextLabel")
optionsTitle.Name = "OptionsTitle"
optionsTitle.Size = UDim2.new(1, 0, 0, 30)
optionsTitle.Position = UDim2.new(0, 0, 0, 0)
optionsTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
optionsTitle.Text = "其他选项设置"
optionsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
optionsTitle.TextSize = 16
optionsTitle.Font = Enum.Font.GothamBold
optionsTitle.ZIndex = 1003
optionsTitle.Parent = optionsFrame

-- 其他选项标题彩色边框
local optionsTitleStroke = Instance.new("UIStroke")
optionsTitleStroke.Color = Color3.fromRGB(255, 255, 255)
optionsTitleStroke.Thickness = 1.5
optionsTitleStroke.Parent = optionsTitle

local optionsTitleRainbow = Instance.new("UIGradient")
optionsTitleRainbow.Color = rainbowColors
optionsTitleRainbow.Rotation = 180
optionsTitleRainbow.Parent = optionsTitleStroke

local optionsTitleRainbowTween = TweenService:Create(optionsTitleRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 540})
optionsTitleRainbowTween:Play()

-- 缓存开关
local cacheToggle = Instance.new("TextButton")
cacheToggle.Name = "CacheToggle"
cacheToggle.Size = UDim2.new(0.8, 0, 0, 25)
cacheToggle.Position = UDim2.new(0.1, 0, 0.2, 0)
cacheToggle.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
cacheToggle.Text = "启用缓存: 是"
cacheToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
cacheToggle.TextSize = 12
cacheToggle.Font = Enum.Font.Gotham
cacheToggle.ZIndex = 1003
cacheToggle.Parent = optionsFrame

local cacheCorner = Instance.new("UICorner")
cacheCorner.CornerRadius = UDim.new(0, 5)
cacheCorner.Parent = cacheToggle

-- 添加彩色边框
local cacheStroke = Instance.new("UIStroke")
cacheStroke.Color = Color3.fromRGB(255, 255, 255)
cacheStroke.Thickness = 1.5
cacheStroke.Parent = cacheToggle

local cacheRainbow = Instance.new("UIGradient")
cacheRainbow.Color = rainbowColors
cacheRainbow.Rotation = 90
cacheRainbow.Parent = cacheStroke

local cacheRainbowTween = TweenService:Create(cacheRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 450})
cacheRainbowTween:Play()

local cacheEnabled = true

cacheToggle.MouseButton1Click:Connect(function()
    cacheEnabled = not cacheEnabled
    cacheToggle.BackgroundColor3 = cacheEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 100, 100)
    cacheToggle.Text = "启用缓存: " .. (cacheEnabled and "是" or "否")
    if not cacheEnabled then
        translationCache = {}
        statsText.Text = statsText.Text:gsub("缓存: %d+", "缓存: 0")
    end
end)

-- 速度滑块
local speedSlider = Instance.new("Frame")
speedSlider.Name = "SpeedSlider"
speedSlider.Size = UDim2.new(0.8, 0, 0, 50)
speedSlider.Position = UDim2.new(0.1, 0, 0.4, 0)
speedSlider.BackgroundTransparency = 1
speedSlider.Parent = optionsFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "扫描速度: 标准"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
speedLabel.TextSize = 12
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = speedSlider

local speedBar = Instance.new("Frame")
speedBar.Name = "SpeedBar"
speedBar.Size = UDim2.new(1, 0, 0, 5)
speedBar.Position = UDim2.new(0, 0, 0.6, 0)
speedBar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
speedBar.Parent = speedSlider

local speedBarCorner = Instance.new("UICorner")
speedBarCorner.CornerRadius = UDim.new(0, 3)
speedBarCorner.Parent = speedBar

local speedFill = Instance.new("Frame")
speedFill.Name = "SpeedFill"
speedFill.Size = UDim2.new(0.5, 0, 1, 0)
speedFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
speedFill.Parent = speedBar

local speedFillCorner = Instance.new("UICorner")
speedFillCorner.CornerRadius = UDim.new(0, 3)
speedFillCorner.Parent = speedFill

local speedHandle = Instance.new("TextButton")
speedHandle.Name = "SpeedHandle"
speedHandle.Size = UDim2.new(0, 15, 0, 15)
speedHandle.Position = UDim2.new(0.5, -7.5, 0.6, -5)
speedHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speedHandle.Text = ""
speedHandle.ZIndex = 1004
speedHandle.Parent = speedSlider

local speedHandleCorner = Instance.new("UICorner")
speedHandleCorner.CornerRadius = UDim.new(0, 7)
speedHandleCorner.Parent = speedHandle

-- 添加彩色边框
local speedHandleStroke = Instance.new("UIStroke")
speedHandleStroke.Color = Color3.fromRGB(255, 255, 255)
speedHandleStroke.Thickness = 1.5
speedHandleStroke.Parent = speedHandle

local speedHandleRainbow = Instance.new("UIGradient")
speedHandleRainbow.Color = rainbowColors
speedHandleRainbow.Rotation = 180
speedHandleRainbow.Parent = speedHandleStroke

local speedHandleRainbowTween = TweenService:Create(speedHandleRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 540})
speedHandleRainbowTween:Play()

local speedValues = {"慢", "标准", "快"}
local currentSpeed = 2
local scanCooldowns = {0.5, 0.3, 0.1}
local scanCooldown = scanCooldowns[currentSpeed]

-- 速度滑块逻辑
local function updateSpeed(value)
    currentSpeed = math.clamp(math.round(value * 2) + 1, 1, 3)
    speedFill.Size = UDim2.new(currentSpeed/3, 0, 1, 0)
    speedHandle.Position = UDim2.new(currentSpeed/3, -7.5, 0.6, -5)
    speedLabel.Text = "速度: " .. speedValues[currentSpeed]
    scanCooldown = scanCooldowns[currentSpeed]
end

speedHandle.MouseButton1Down:Connect(function()
    local connection
    local startPos = speedHandle.AbsolutePosition.X
    local barSize = speedBar.AbsoluteSize.X
    
    connection = UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local relative = (mousePos - speedBar.AbsolutePosition.X) / barSize
            updateSpeed(relative)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            connection:Disconnect()
        end
    end)
end)

-- 关闭选项按钮
local closeOptionsButton = Instance.new("TextButton")
closeOptionsButton.Name = "CloseOptionsButton"
closeOptionsButton.Size = UDim2.new(0.6, 0, 0, 30)
closeOptionsButton.Position = UDim2.new(0.2, 0, 0.8, 0)
closeOptionsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
closeOptionsButton.Text = "保存设置"
closeOptionsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeOptionsButton.TextSize = 14
closeOptionsButton.Font = Enum.Font.Gotham
closeOptionsButton.ZIndex = 1003
closeOptionsButton.Parent = optionsFrame

local closeOptionsCorner = Instance.new("UICorner")
closeOptionsCorner.CornerRadius = UDim.new(0, 5)
closeOptionsCorner.Parent = closeOptionsButton

-- 添加彩色边框
local closeOptionsStroke = Instance.new("UIStroke")
closeOptionsStroke.Color = Color3.fromRGB(255, 255, 255)
closeOptionsStroke.Thickness = 1.5
closeOptionsStroke.Parent = closeOptionsButton

local closeOptionsRainbow = Instance.new("UIGradient")
closeOptionsRainbow.Color = rainbowColors
closeOptionsRainbow.Rotation = 270
closeOptionsRainbow.Parent = closeOptionsStroke

local closeOptionsRainbowTween = TweenService:Create(closeOptionsRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 630})
closeOptionsRainbowTween:Play()

-- 其他选项关闭按钮
local optionsCloseButton = Instance.new("TextButton")
optionsCloseButton.Name = "OptionsCloseButton"
optionsCloseButton.Size = UDim2.new(0, 25, 0, 25)
optionsCloseButton.Position = UDim2.new(1, -30, 0, 5)
optionsCloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
optionsCloseButton.Text = "×"
optionsCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
optionsCloseButton.TextSize = 18
optionsCloseButton.Font = Enum.Font.GothamBold
optionsCloseButton.ZIndex = 1004
optionsCloseButton.Parent = optionsFrame

local optionsCloseCorner = Instance.new("UICorner")
optionsCloseCorner.CornerRadius = UDim.new(0, 12)
optionsCloseCorner.Parent = optionsCloseButton

-- 添加彩色边框
local optionsCloseStroke = Instance.new("UIStroke")
optionsCloseStroke.Color = Color3.fromRGB(255, 255, 255)
optionsCloseStroke.Thickness = 1.5
optionsCloseStroke.Parent = optionsCloseButton

local optionsCloseRainbow = Instance.new("UIGradient")
optionsCloseRainbow.Color = rainbowColors
optionsCloseRainbow.Rotation = 270
optionsCloseRainbow.Parent = optionsCloseStroke

local optionsCloseRainbowTween = TweenService:Create(optionsCloseRainbow, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), 
    {Rotation = 630})
optionsCloseRainbowTween:Play()

-- 翻译功能实现
local phraseDictionary = {
    -- ===== 游戏实体 =====
    ["Player"] = "玩家",
    ["NPC"] = "NPC",
    ["Enemy"] = "敌人",
    ["Boss"] = "首领",
    ["Vehicle"] = "载具",
    ["Pet"] = "宠物",
    ["Building"] = "建筑",
    ["Tree"] = "树木",
    ["Rock"] = "岩石",
    ["Chest"] = "宝箱",
    ["Loot"] = "战利品",
    ["Resource"] = "资源",
    ["Weapon"] = "武器",
    ["Tool"] = "工具",
    ["Item"] = "物品",
    ["Child"] = "子对象",
    ["Big Tree"] = "大树",
    ["Entity"] = "实体",
    ["Map"] = "地图",
    ["Structure"] = "结构",
    ["Base"] = "基地",
    ["House"] = "房子",
    ["Shop"] = "商店",
    ["Market"] = "市场",
    ["Arena"] = "竞技场",
    ["Dungeon"] = "地下城",
    ["Cave"] = "洞穴",
    ["Mountain"] = "山脉",
    ["River"] = "河流",
    ["Lake"] = "湖泊",
    ["Ocean"] = "海洋",
    ["Island"] = "岛屿",
    ["Forest"] = "森林",
    ["Desert"] = "沙漠",
    ["Snow"] = "雪地",
    ["Lava"] = "熔岩",
    ["Sky"] = "天空",
    ["Space"] = "太空",
    ["Flower"] = "花朵",
    ["Campfire"] = "营火",
    ["Reward"] = "奖励",
    ["Drop"] = "掉落",
    ["Material"] = "材料",
    ["Armor"] = "护甲",
    ["Gadget"] = "小工具",
    ["Monster"] = "怪物",
    ["Creature"] = "生物",
    ["Animal"] = "动物",
    ["Model"] = "模型",
    ["Mesh"] = "网格",
    ["Part"] = "部件",
    ["BasePart"] = "基础部件",

    -- ===== 地点区域 =====
    ["Warm Place"] = "温暖地点",
    ["Camp"] = "营地",
    ["Fishing Hut"] = "钓鱼小屋",

    -- ===== 游戏机制 =====
    ["Health"] = "生命值",
    ["Stamina"] = "耐力",
    ["Mana"] = "法力",
    ["Experience"] = "经验",
    ["Level"] = "等级",
    ["Damage"] = "伤害",
    ["Defense"] = "防御",
    ["Critical"] = "暴击",
    ["Dodge"] = "闪避",
    ["Respawn"] = "重生",
    ["Spawn"] = "生成",
    ["Despawn"] = "消失",
    ["Cooldown"] = "冷却",
    ["Buff"] = "增益",
    ["Debuff"] = "减益",
    ["Status Effect"] = "状态效果",
    ["Hitbox"] = "碰撞箱",
    ["Physics"] = "物理",
    ["Collision"] = "碰撞",
    ["Skill"] = "技能",
    ["Talent"] = "天赋",
    ["Perk"] = "特权",
    ["Attack"] = "攻击",
    ["Power"] = "力量",
    ["Strength"] = "力量",
    ["Agility"] = "敏捷",
    ["Intelligence"] = "智力",
    ["Luck"] = "幸运",
    ["Time"] = "时间",
    ["Day"] = "白天",
    ["Night"] = "夜晚",
    ["Weather"] = "天气",
    ["Season"] = "季节",
    ["Temperature"] = "温度",
    ["Hunger"] = "饥饿",
    ["Thirst"] = "口渴",
    ["Warmth"] = "温暖",
    ["Fishing"] = "钓鱼",
    ["Success Rate"] = "成功率",
    ["Animation"] = "动画",
    ["Effect"] = "效果",
    ["Particle"] = "粒子",
    ["Light"] = "光线",
    ["Shadow"] = "阴影",
    ["Texture"] = "纹理",
    ["Sound"] = "声音",
    ["Music"] = "音乐",

    -- ===== 界面元素 =====
    ["Menu"] = "菜单",
    ["Button"] = "按钮",
    ["Slider"] = "滑块",
    ["Toggle"] = "开关",
    ["Dropdown"] = "下拉菜单",
    ["Input"] = "输入框",
    ["Checkbox"] = "复选框",
    ["Keybind"] = "按键绑定",
    ["Color Picker"] = "颜色选择器",
    ["Tab"] = "标签页",
    ["Window"] = "窗口",
    ["Panel"] = "面板",
    ["Notification"] = "通知",
    ["Tooltip"] = "工具提示",
    ["Watermark"] = "水印",
    ["List"] = "列表",
    ["Radio"] = "单选按钮",
    ["Frame"] = "框架",
    ["Label"] = "标签",
    ["Text"] = "文本",
    ["Image"] = "图像",
    ["Icon"] = "图标",
    ["Progress Bar"] = "进度条",
    ["Scroll"] = "滚动",
    ["Grid"] = "网格",
    ["Layout"] = "布局",
    ["Container"] = "容器",
    ["Dialog"] = "对话框",
    ["Popup"] = "弹出窗口",
    ["Alert"] = "警报",
    ["Message"] = "消息",
    ["Chat"] = "聊天",
    ["Inventory"] = "物品栏",
    ["Equipment"] = "装备栏",
    ["Skills"] = "技能栏",
    ["Quests"] = "任务栏",
    ["Minimap"] = "小地图",
    ["Radar"] = "雷达",
    ["Compass"] = "指南针",
    ["HUD"] = "平视显示器",
    ["UI"] = "用户界面",
    ["GUI"] = "图形用户界面",
    ["Submenu"] = "子菜单",
    ["Context Menu"] = "上下文菜单",
    ["Navigation"] = "导航",
    ["Header"] = "头部",
    ["Footer"] = "底部",
    ["Sidebar"] = "侧边栏",
    ["Main Content"] = "主要内容",

    -- ===== 状态消息 =====
    ["Enabled"] = "已启用",
    ["Disabled"] = "已禁用",
    ["Active"] = "活跃中",
    ["Inactive"] = "未激活",
    ["Loading"] = "加载中",
    ["Processing"] = "处理中",
    ["Connecting"] = "连接中",
    ["Injecting"] = "注入中",
    ["Bypassing"] = "绕过中",
    ["Hooking"] = "挂钩中",
    ["Patching"] = "修补中",
    ["Scanning"] = "扫描中",
    ["Executing"] = "执行中",
    ["ON"] = "开",
    ["OFF"] = "关",
    ["Success"] = "成功",
    ["Ready"] = "就绪",
    ["Value"] = "数值",
    ["Amount"] = "数量",

    -- ===== 错误消息 =====
    ["Error"] = "错误",
    ["Failed"] = "失败",
    ["Warning"] = "警告",
    ["Critical"] = "严重",
    ["Connection Lost"] = "连接丢失",
    ["Invalid Input"] = "无效输入",
    ["Access Denied"] = "访问拒绝",
    ["File Not Found"] = "文件未找到",
    ["Memory Error"] = "内存错误",
    ["Timeout"] = "超时",
    ["Server Error"] = "服务器错误",
    ["Script Error"] = "脚本错误",
    ["Detection"] = "检测到",
    ["Anti-Cheat"] = "反作弊",

    -- ===== 核心功能类别 =====
    ["Automation"] = "自动化",
    ["Fun"] = "娱乐",
    ["Information"] = "信息",
    ["Visuals"] = "视觉效果",
    ["Teleport"] = "传送",
    ["Main"] = "主要",
    ["Bring Stuff"] = "带来物品",
    ["Player Options"] = "玩家选项",
    ["World Options"] = "世界选项",
    ["Game Options"] = "游戏选项",
    ["Server Options"] = "服务器选项",
    ["Network Options"] = "网络选项",
    ["Graphics Options"] = "图形选项",
    ["Audio Volume"] = "音频音量",

    -- ===== 作弊功能相关 =====
    ["Cheat"] = "作弊",
    ["Hack"] = "黑客",
    ["Exploit"] = "漏洞",
    ["Script"] = "脚本",
    ["Executor"] = "执行器",
    ["Injector"] = "注入器",
    ["Loader"] = "加载器",
    ["God"] = "上帝",
    ["Mode"] = "模式",
    ["Infinite"] = "无限",
    ["Money"] = "金钱",
    ["Ammo"] = "弹药",
    ["Unlimited"] = "无限",
    ["Clip"] = "穿墙",
    ["Fly"] = "飞行",
    ["Speed"] = "速度",
    ["Jump"] = "跳跃",
    ["Movement"] = "移动",
    ["Walk"] = "行走",
    ["Run"] = "奔跑",
    ["Options"] = "选项",
    ["ESP"] = "透视",
    ["Wallhack"] = "透视",
    ["Aimbot"] = "自瞄",
    ["Auto"] = "自动",
    ["Aim"] = "瞄准",
    ["Silent"] = "静默",
    ["Triggerbot"] = "自动开枪",
    ["Fire"] = "开火",
    ["Game"] = "游戏",
    ["Features"] = "功能",
    ["Unlock"] = "解锁",
    ["Instant"] = "立即",
    ["Win"] = "获胜",
    ["Farm"] = "刷资源",
    ["Collect"] = "收集",
    ["Complete"] = "完成",
    ["Skip"] = "跳过",
    ["Recoil"] = "后坐力",
    ["Rapid"] = "快速",
    ["Kill"] = "击杀",
    ["Fullbright"] = "全亮",
    ["X-Ray"] = "X光",
    ["Night"] = "夜晚",
    ["Vision"] = "视觉",
    ["Fog"] = "雾",
    ["Multiplier"] = "倍数",
    ["Gravity"] = "重力",
    ["Execute"] = "执行",
    ["Inject"] = "注入",
    ["Attach"] = "附加",
    ["Load"] = "加载",
    ["Save"] = "保存",
    ["Refresh"] = "刷新",
    ["Anti"] = "反",
    ["AFK"] = "挂机",
    ["Bypass"] = "绕过",
    ["Safe"] = "安全",
    ["Undetectable"] = "无法检测",
    ["Stealth"] = "隐身",
    ["Rob"] = "抢劫",
    ["Grind"] = "刷级",
    ["Train"] = "训练",
    ["Sell"] = "出售",
    ["Buy"] = "购买",
    ["Advanced"] = "高级",
    ["Premium"] = "高级",
    ["VIP"] = "VIP",
    ["Beta"] = "测试版",
    ["Experimental"] = "实验性",
    ["Developer"] = "开发者",
    ["Debug"] = "调试",
    ["Console"] = "控制台",
    ["Command"] = "命令",
    ["Interface"] = "界面",
    ["Theme"] = "主题",
    ["Color"] = "颜色",
    ["Background"] = "背景",
    ["Transparency"] = "透明度",
    ["Style"] = "样式",
    ["Config"] = "配置",
    ["Settings"] = "设置",
    ["Preferences"] = "偏好",
    ["Customization"] = "自定义",
    ["Profile"] = "资料",
    ["Account"] = "账户",
    ["Login"] = "登录",
    ["Register"] = "注册",
    ["Password"] = "密码",
    ["Username"] = "用户名",
    ["Email"] = "邮箱",
    ["Verify"] = "验证",
    ["Authenticate"] = "认证",
    ["License"] = "许可证",
    ["Key"] = "密钥",
    ["Subscription"] = "订阅",
    ["Payment"] = "支付",
    ["Free"] = "免费",
    ["Paid"] = "付费",
    ["Trial"] = "试用",
    ["Version"] = "版本",
    ["Update"] = "更新",
    ["Download"] = "下载",
    ["Install"] = "安装",
    ["Uninstall"] = "卸载",
    ["Patch"] = "补丁",
    ["Fix"] = "修复",
    ["Bug"] = "漏洞",
    ["Crash"] = "崩溃",
    ["Lag"] = "延迟",
    ["Ping"] = "ping值",
    ["FPS"] = "帧率",

    -- ===== 新增内容 =====
    ["Child Teleport"] = "子对象传送",
    ["Chest List"] = "宝箱列表",
    ["Fishing Success"] = "钓鱼成功率",
    ["Camp Teleport"] = "营地传送",
    ["Night Mode"] = "夜间模式",
    ["Instant Open"] = "立即打开",
    ["Hitbox Size"] = "命中框大小",
    ["Entity ESP"] = "实体透视",
    ["Map Reveal"] = "地图显示",
    ["Auto Pickup"] = "自动拾取",
    ["Auto Fill"] = "自动填充",
    ["Seed Box"] = "种子盒",
    ["Coin Stack"] = "硬币堆",
    ["Warm Place"] = "温暖地点",
    ["Fishing Hut"] = "钓鱼小屋",
    ["BIG Trees"] = "大树",
    ["Children [BETA]"] = "子对象[BETA]",
    ["The Entities"] = "这些实体",

    -- ===== 传送功能 =====
    ["Child TP"] = "子对象传送",
    ["Teleport To Chest"] = "传送到宝箱",
    ["TP to Camp"] = "传送到营地",
    ["Teleport to Fishing Hut"] = "传送到钓鱼小屋",
    ["Teleport All Trees"] = "传送所有树木",
    ["Teleport All BIG Trees"] = "传送所有大树",
    ["Teleport All Chests"] = "传送所有宝箱",
    ["Teleport All Children[BETA]"] = "传送所有子对象[BETA]",
    ["Teleport Entities"] = "传送实体",
    ["Teleport The Entities"] = "传送这些实体",

    -- ===== 自动功能 =====
    ["Auto TP to Warm Place"] = "自动传送到温暖地点",
    ["Auto TP to Camp at Night"] = "夜晚自动传送到营地",
    ["Auto Pickup Flowers"] = "自动拾取花朵",
    ["Auto Collect Coin Stacks"] = "自动收集硬币堆",
    ["Auto Open Seed Boxes"] = "自动打开种子盒",
    ["Auto Fill Campfire"] = "自动填充营火",
    ["Auto Farm"] = "自动刷资源",
    ["Auto Loot"] = "自动拾取",
    ["Auto Complete"] = "自动完成",
    ["Auto Quest"] = "自动任务",
    ["Auto Sell"] = "自动出售",
    ["Auto Buy"] = "自动购买",
    ["Auto Craft"] = "自动制作",
    ["Auto Upgrade"] = "自动升级",
    ["Auto Equip"] = "自动装备",
    ["Auto Use"] = "自动使用",
    ["Auto Drop"] = "自动丢弃",
    ["Auto Trade"] = "自动交易",
    ["Auto Accept"] = "自动接受",
    ["Auto Decline"] = "自动拒绝",
    ["Auto Reply"] = "自动回复",
    ["Auto Message"] = "自动消息",
    ["Auto Follow"] = "自动跟随",
    ["Auto Avoid"] = "自动躲避",
    ["Auto Dodge"] = "自动闪避",
    ["Auto Block"] = "自动格挡",
    ["Auto Parry"] = "自动招架",
    ["Auto Counter"] = "自动反击",
    ["Auto Heal"] = "自动治疗",
    ["Auto Potion"] = "自动药水",
    ["Auto Buff"] = "自动增益",
    ["Auto Debuff"] = "自动减益",
    ["Auto Cleanse"] = "自动净化",
    ["Auto Respawn"] = "自动重生",
    ["Auto Revive"] = "自动复活",
    ["Auto Save"] = "自动保存",
    ["Auto Load"] = "自动加载",
    ["Auto Backup"] = "自动备份",
    ["Auto Restore"] = "自动恢复",
    ["Auto Update"] = "自动更新",
    ["Auto Patch"] = "自动修补",
    ["Auto Bypass"] = "自动绕过",
    ["Auto Hide"] = "自动隐藏",
    ["Auto Show"] = "自动显示",
    ["Auto Toggle"] = "自动切换",
    ["Auto Enable"] = "自动启用",
    ["Auto Disable"] = "自动禁用",
    ["Auto Activate"] = "自动激活",
    ["Auto Deactivate"] = "自动停用",
    ["Auto Execute"] = "自动执行",
    ["Auto Inject"] = "自动注入",
    ["Auto Attach"] = "自动附加",
    ["Auto Detach"] = "自动分离",
    ["Auto Scan"] = "自动扫描",
    ["Auto Detect"] = "自动检测",
    ["Auto Find"] = "自动查找",
    ["Auto Locate"] = "自动定位",
    ["Auto Track"] = "自动跟踪",
    ["Auto Target"] = "自动瞄准",
    ["Auto Lock"] = "自动锁定",
    ["Auto Unlock"] = "自动解锁",
    ["Auto Open"] = "自动打开",
    ["Auto Close"] = "自动关闭",
    ["Auto Start"] = "自动开始",
    ["Auto Stop"] = "自动停止",
    ["Auto Pause"] = "自动暂停",
    ["Auto Resume"] = "自动继续",
    ["Auto Restart"] = "自动重启",
    ["Auto Reset"] = "自动重置",
    ["Auto Clear"] = "自动清除",
    ["Auto Delete"] = "自动删除",
    ["Auto Remove"] = "自动移除",
    ["Auto Add"] = "自动添加",
    ["Auto Insert"] = "自动插入",
    ["Auto Extract"] = "自动提取",
    ["Auto Copy"] = "自动复制",
    ["Auto Paste"] = "自动粘贴",
    ["Auto Cut"] = "自动剪切",
    ["Auto Undo"] = "自动撤销",
    ["Auto Redo"] = "自动重做",
    ["Auto Save Config"] = "自动保存配置",
    ["Auto Load Config"] = "自动加载配置",
    ["Auto Backup Config"] = "自动备份配置",
    ["Auto Restore Config"] = "自动恢复配置",
    ["Auto Optimize"] = "自动优化",
    ["Auto Boost"] = "自动提升",
    ["Auto Enhance"] = "自动增强",
    ["Auto Improve"] = "自动改进",
    ["Auto Fix"] = "自动修复",
    ["Auto Repair"] = "自动修理",
    ["Auto Clean"] = "自动清理",
    ["Auto Organize"] = "自动整理",
    ["Auto Sort"] = "自动排序",
    ["Auto Arrange"] = "自动排列",
    ["Auto Group"] = "自动分组",
    ["Auto Ungroup"] = "自动取消分组",
    ["Auto Merge"] = "自动合并",
    ["Auto Split"] = "自动拆分",
    ["Auto Combine"] = "自动组合",
    ["Auto Separate"] = "自动分离",
    ["Auto Connect"] = "自动连接",
    ["Auto Disconnect"] = "自动断开",
    ["Auto Join Server"] = "自动加入服务器",
    ["Auto Leave Server"] = "自动离开服务器",
    ["Auto Change Server"] = "自动更换服务器",
    ["Auto Server Hop"] = "自动切换服务器",

    -- ===== 战斗相关 =====
    ["Instant Kill"] = "一击必杀",
    ["No Cooldown"] = "无冷却",
    ["Infinite Jump"] = "无限跳跃",
    ["Super Speed"] = "超级速度",
    ["Hitbox Size Multiplier"] = "碰撞箱大小倍数",
    ["Enable Hitbox Expansion"] = "启用碰撞箱扩展",
    ["Hitbox Expansion"] = "碰撞箱扩展",
    ["Kill All"] = "杀死所有",
    ["Kill Aura"] = "杀戮光环",
    ["Kill Aura Radius"] = "杀戮光环范围",
    ["Kill All NPCs"] = "杀死所有NPC",
    ["Destroy All Bases"] = "摧毁所有基地",
    ["Delete All Objects"] = "删除所有物体",
    ["Remove All Obstacles"] = "移除所有障碍物",
    ["Clear Map"] = "清空地图",
    ["Reset All Players"] = "重置所有玩家",
    ["Crash Server"] = "崩溃服务器",
    ["Lag Server"] = "延迟服务器",
    ["Server Hop"] = "切换服务器",
    ["Rejoin Server"] = "重新加入服务器",
    ["Copy Game ID"] = "复制游戏ID",
    ["Copy Player ID"] = "复制玩家ID",
    ["Copy Player Name"] = "复制玩家名字",
    ["Copy Player Display Name"] = "复制玩家显示名",
    ["Player List"] = "玩家列表",
    ["Player ESP"] = "玩家透视",
    ["Player Tracers"] = "玩家射线",
    ["Player Names"] = "玩家名字",
    ["Player Distance"] = "玩家距离",
    ["Player Health"] = "玩家生命值",
    ["Player Team"] = "玩家队伍",
    ["Player Tools"] = "玩家工具",
    ["Player Inventory"] = "玩家库存",
    ["Steal Tools"] = "偷取工具",
    ["Steal Items"] = "偷取物品",
    ["Steal Money"] = "偷取金钱",
    ["Drop All Items"] = "丢弃所有物品",
    ["Duplicate Items"] = "复制物品",
    ["Infinite Items"] = "无限物品",
    ["Unlimited Tools"] = "无限工具",
    ["Get All Items"] = "获取所有物品",
    ["Get All Tools"] = "获取所有工具",
    ["Get All Weapons"] = "获取所有武器",
    ["Get All Pets"] = "获取所有宠物",
    ["Get All Cosmetics"] = "获取所有装饰品",
    ["Get All Badges"] = "获取所有徽章",
    ["Unlock All"] = "解锁所有",
    ["Unlock All Achievements"] = "解锁所有成就",
    ["Unlock All Levels"] = "解锁所有等级",
    ["Unlock All Maps"] = "解锁所有地图",
    ["Unlock All Characters"] = "解锁所有角色",
    ["Unlock All Skins"] = "解锁所有皮肤",
    ["Max Level"] = "最大等级",
    ["Instant Level Up"] = "立即升级",
    ["Set Level"] = "设置等级",
    ["Set Experience"] = "设置经验",
    ["Add Experience"] = "添加经验",
    ["Add Money"] = "添加金钱",
    ["Set Money"] = "设置金钱",
    ["Remove Money"] = "移除金钱",
    ["Infinite Money"] = "无限金钱",
    ["Infinite Gems"] = "无限宝石",
    ["Infinite Robux"] = "无限Robux",
    ["Infinite Tokens"] = "无限代币",
    ["Infinite Points"] = "无限点数",
    ["Infinite Currency"] = "无限货币",
    ["No Delay"] = "无延迟",
    ["Instant Cooldown"] = "立即冷却",
    ["Reduce Cooldown"] = "减少冷却",
    ["Increase Rate"] = "增加速率",
    ["Double Speed"] = "双倍速度",
    ["Triple Speed"] = "三倍速度",
    ["10x Speed"] = "10倍速度",
    ["Custom Speed"] = "自定义速度",
    ["Set Speed"] = "设置速度",
    ["Set WalkSpeed"] = "设置行走速度",
    ["Set JumpPower"] = "设置跳跃力量",
    ["Set Gravity"] = "设置重力",
    ["Zero Gravity"] = "零重力",
    ["Low Gravity"] = "低重力",
    ["High Gravity"] = "高重力",
    ["Moon Gravity"] = "月球重力",
    ["Anti Gravity"] = "反重力",
    ["No Gravity"] = "无重力",
    ["Float"] = "漂浮",
    ["Swim"] = "游泳",
    ["Sink"] = "下沉",
    ["Freeze"] = "冻结",
    ["Unfreeze"] = "解冻",
    ["Freeze All"] = "冻结所有",
    ["Freeze Players"] = "冻结玩家",
    ["Freeze NPCs"] = "冻结NPC",
    ["Melt All"] = "融化所有",
    ["Burn All"] = "燃烧所有",
    ["Explode All"] = "爆炸所有",
    ["Explode Player"] = "爆炸玩家",
    ["Explode Self"] = "自爆",
    ["Big Head"] = "大头模式",
    ["Small Head"] = "小头模式",
    ["Tiny Character"] = "迷你角色",
    ["Giant Character"] = "巨人角色",
    ["Scale Character"] = "缩放角色",
    ["Resize Character"] = "调整角色大小",
    ["Change Appearance"] = "改变外观",
    ["Custom Appearance"] = "自定义外观",
    ["Invisible"] = "隐身",
    ["Visible"] = "可见",
    ["Transparent"] = "透明",
    ["Ghost"] = "幽灵",
    ["Spectate"] = "观察",
    ["Spectate Player"] = "观察玩家",
    ["First Person"] = "第一人称",
    ["Third Person"] = "第三人称",
    ["Camera View"] = "相机视角",
    ["Free Camera"] = "自由相机",
    ["Camera Fly"] = "相机飞行",
    ["Camera Noclip"] = "相机穿墙",
    ["Zoom In"] = "放大",
    ["Zoom Out"] = "缩小",
    ["Reset Camera"] = "重置相机",
    ["Camera Offset"] = "相机偏移",
    ["FOV Changer"] = "视野修改器",
    ["Field of View"] = "视野",
    ["Depth of Field"] = "景深",
    ["Blur Effect"] = "模糊效果",
    ["Bloom Effect"] = "泛光效果",
    ["Color Correction"] = "颜色校正",
    ["Brightness"] = "亮度",
    ["Unload Script"] = "卸载脚本",
    ["Open Keybind Menu"] = "打开按键绑定菜单",
    ["Custom Cursor"] = "自定义光标",
    ["Notification Side"] = "通知位置",
    ["Right"] = "右侧",
    ["DPI Scale"] = "DPI缩放",
    ["100%"] = "100%",
    ["Menu Keybind"] = "菜单按键绑定",
    ["RightControl"] = "右Ctrl键",
    ["Load theme"] = "加载主题",
    ["Search"] = "搜索",
    ["死我了"] = "死亡",
    ["Autowin"] = "自动获胜",
    ["Misc"] = "杂项",
    ["Credits & Server"] = "制作人员 & 服务器",
    ["Changelog"] = "更新日志",
    ["UI Settings"] = "界面设置",
    ["Menu"] = "菜单",
    ["Overwrite theme"] = "覆盖主题",
    ["Delete theme"] = "删除主题",
    ["Refresh list"] = "刷新列表",
    ["Set as default"] = "设为默认",
    ["Reset default"] = "重置默认",
    ["Load config"] = "加载配置",
    ["Overwrite config"] = "覆盖配置",
    ["Delete config"] = "删除配置",
    ["Set as autoload"] = "设为自动加载",
    ["Reset autoload"] = "重置自动加载",
    ["Current autoload config:none"] = "当前自动加载配置：无",
    ["Default"] = "默认",
    ["Custom theme name"] = "自定义主题名称",
    ["Create theme"] = "创建主题",
    ["Custom themes"] = "自定义主题",
    ["Themes"] = "主题",
    ["Background color"] = "背景颜色",
    ["Main color"] = "主颜色",
    ["Accent color"] = "强调色",
    ["Outline color"] = "轮廓颜色",
    ["Font color"] = "字体颜色",
    ["Font Face"] = "字体",
    ["Code"] = "代码",
    ["Configuration"] = "配置",
    ["Config name"] = "配置名称",
    ["Create config"] = "创建配置",
    ["Config list"] = "配置列表",
    ["Custom Title"] = "自定义标题",
    ["Default value"] = "默认值",
    ["Custom Title Color"] = "自定义标题颜色",
    ["Emote Player"] = "表情播放器",
    ["Select Emote"] = "选择表情",
    ["Play Emote"] = "播放表情",
    ["Stop Emote"] = "停止表情",
    ["Skybox Changer"] = "天空盒更换器",
    ["Redshift"] = "红移",
    ["Body Modifier"] = "身体修改器",
    ["Select Material"] = "选择材质",
    ["ForceField"] = "力场",
    ["Material Color"] = "材质颜色",
    ["Delete Player Tags"] = "删除玩家标签",
    ["Delete Dinner Suit"] = "删除晚礼服",
    ["Saturation Density"] = "饱和度密度",
    ["0%/100%"] = "0%/100%",
    ["Select Whitelisted Players"] = "选择白名单玩家",
    ["Shaders/Ambience"] = "着色器/环境",
    ["Ambience"] = "环境",
    ["Force Time"] = "强制时间",
    ["Time"] = "时间",
    ["12hr/24hr"] = "12小时制/24小时制",
    ["Custom Saturation"] = "自定义饱和度",
    ["Health Text"] = "生命值文本",
    ["Distance"] = "距离",
    ["Box"] = "方框",
    ["Name"] = "名称",
    ["Tracers"] = "追踪线",
    ["Weapon"] = "武器",
    ["3D Box"] = "3D方框",
    ["Whitelist Players"] = "白名单玩家",
    ["FPS Boost"] = "FPS提升",
    ["FOV Slider：70"] = "视野滑块：70",
    ["Fullbright"] = "全亮",
    ["Remove Fog"] = "移除雾效",
    ["Instant Interact"] = "即时交互",
    ["Watermark"] = "水印",
    ["Player Tag"] = "玩家标签",
    ["Custom Suit Color"] = "自定义套装颜色",
    ["v2.4 - Made by TexRBLX"] = "v2.4 - 由TexRBLX制作",
    ["Add New Waypoint"] = "添加新路径点",
    ["Waypoint Select"] = "路径点选择",
    ["Teleport to Selected"] = "传送到选定位置",
    ["Player ESP Options"] = "玩家透视选项",
    ["Player ESP Toggle"] = "玩家透视开关",
    ["Health Bar"] = "生命条",
    ["Get Biggest Threat"] = "获取最大威胁",
    ["Player Information"] = "玩家信息",
    ["Select Player"] = "选择玩家",
    ["ESP Settings"] = "透视设置",
    ["ESP Method"] = "透视方法",
    ["Mobile"] = "移动版",
    ["PEABERT"] = "PEABERT",
    ["Peabert ESP"] = "Peabert透视",
    ["Recenter"] = "重新居中",
    ["Hide Name"] = "隐藏名称",
    ["Waypoints"] = "路径点",
    ["Auto Hide And Seek"] = "自动捉迷藏",
    ["Auto Jump Rope"] = "自动跳绳",
    ["Auto Glass Bridge"] = "自动玻璃桥",
    ["[BETA] Auto Mingle"] = "[测试版]自动社交",
    ["Activation Time (s):"] = "激活时间(秒):",
    ["[BETA] Auto Last Dinner"] = "[测试版]自动最后的晚餐",
    ["[BETA] Auto Squid Game"] = "[测试版]自动鱿鱼游戏",
    ["[BETA] Auto Sky Squid Ga"] = "[测试版]自动天空鱿鱼游戏",
    ["Settings"] = "设置",
    ["Auto Skip Dialogue"] = "自动跳过对话",
    ["Auto Queue"] = "自动排队",
    ["Auto Vote"] = "自动投票",
    ["Select Vote"] = "选择投票",
    ["Continue"] = "继续",
    ["Tug Of War"] = "拔河",
    ["Games"] = "游戏",
    ["Auto Win"] = "自动获胜",
    ["Auto RLGL"] = "自动红灯绿灯",
    ["Auto Dalgona"] = "自动糖饼游戏",
    ["Auto Lights Out"] = "自动熄灯",
    ["Choose Closest Player"] = "选择最近玩家",
    ["Teleport Method"] = "传送方法",
    ["Behind"] = "后方",
    ["Auto Attack"] = "自动攻击",
    ["Fly Method"] = "飞行方法",
    ["Velocity"] = "速度",
    ["Infinite Jump"] = "无限跳跃",
    ["Freeze Self"] = "冻结自己",
    ["Target Hiders"] = "目标隐藏者",
    ["Teleport Distance"] = "传送距离",
    ["2/10"] = "2/10",
    ["Teleport Interval"] = "传送间隔",
    ["0/1"] = "0/1",
    ["Target Player"] = "目标玩家",
    ["Player"] = "玩家",
    ["Noclip"] = "穿墙模式",
    ["Fly"] = "飞行",
    ["Velocity Fly Speed"] = "速度飞行速度",
    ["100/500"] = "100/500",
    ["Priority List"] = "优先级列表",
    ["Extra Prediction"] = "额外预测",
    ["0.05s/0.2s"] = "0.05秒/0.2秒",
    ["Enable Offsets"] = "启用偏移",
    ["Player Attach"] = "玩家附着",
    ["Attach To Player"] = "附着到玩家",
    ["Jump Power"] = "跳跃力量",
    ["Input JP"] = "输入跳跃力量",
    ["50/500"] = "50/500",
    ["Prioritized Tools"] = "优先工具",
    ["Fists, Fork, Bottle, K..."] = "拳头,叉子,瓶子,K...",
    ["Target Priority"] = "目标优先级",
    ["Closest"] = "最近",
    ["Hip Height"] = "臀部高度",
    ["Input Hip Height"] = "输入臀部高度",
    ["0/20"] = "0/20",
    ["Highlight Target"] = "高亮目标",
    ["Hitbox Trail"] = "命中框轨迹",
    ["Whitelist"] = "白名单",
    ["Fling A11"] = "抛掷A11",
    ["Fling Strength"] = "抛掷强度",
    ["10000/50000"] = "10000/50000",
    ["Fling All Whitelist"] = "抛掷所有白名单",
    ["Kill Aura"] = "杀戮光环",
    ["Enable Kill Aura"] = "启用杀戮光环",
    ["Mode"] = "模式",
    ["Automatic"] = "自动",
    ["Player Mods"] = "玩家修改",
    ["Speed Boost"] = "速度提升",
    ["0/30"] = "0/30",
    ["Input Speed"] = "输入速度",
    ["Require Right-Click"] = "需要右键点击",
    ["Ignore Ragdolled"] = "忽略布娃娃状态",
    ["Range"] = "范围",
    ["20 studs/500 studs"] = "20单位/500单位",
    ["Input Range"] = "输入范围",
    ["Input Safe Part Height"] = "输入安全部件高度",
    ["Aim Assist"] = "瞄准辅助",
    ["Teleport Back"] = "传送返回",
    ["Create New Safe Part"] = "创建新安全部件",
    ["Fling"] = "抛掷",
    ["Bypass Anti-Cheat"] = "绕过反作弊",
    ["FOV Radius"] = "视野半径",
    ["120/1000"] = "120/1000",
    ["Activation Distance"] = "激活距离",
    ["10 studs/500 studs"] = "10单位/500单位",
    ["Target Part"] = "目标部位",
    ["Head"] = "头部",
    ["Smoothness"] = "平滑度",
    ["0.5/1"] = "0.5/1",
    ["Safe Part Height"] = "安全部件高度",
    ["Safe Part Teleport Y"] = "安全部件传送Y坐标",
    ["Create New Part Each Time"] = "每次创建新部件",
    ["TP When Health Under"] = "生命值低于时传送",
    ["Health TP Value"] = "生命值传送值",
    ["73/100"] = "73/100",
    ["Input Health TP Value"] = "输入生命值传送值",
    ["Auto-Dodge"] = "自动闪避",
    ["Always Run"] = "总是奔跑",
    ["Face Closest Player X"] = "面向最近玩家X",
    ["Disable Jump Fatigue"] = "禁用跳跃疲劳",
    ["Backwards Sprint"] = "向后冲刺",
    ["Pickup Dropped Bandages"] = "拾取掉落绷带",
    ["Dash & Abilities"] = "冲刺 & 能力",
    ["PVP"] = "玩家对战",
    ["Enable Dash"] = "启用冲刺",
    ["Enable Phantom Dash Abil"] = "启用幻影冲刺能力",
    ["Custom Dash Cooldown"] = "自定义冲刺冷却",
    ["Custom Dash Power"] = "自定义冲刺力量",
    ["Anti-Stun"] = "防眩晕",
    ["Anti-Ragdoll"] = "防布娃娃",
    ["Anti-Injury"] = "防受伤",
    ["Anti-Fling"] = "防抛掷",
    ["Enable Parkour Artist"] = "启用跑酷大师",
    ["Auto Get Food"] = "自动获取食物",
    ["Food Type"] = "食物类型",
    ["Bottle"] = "瓶子",
    ["Auto QTE"] = "自动快速反应事件",
    ["Method"] = "方法",
    ["Legit"] = "合法模式",
    ["Infinite Stamina"] = "无限耐力",
    ["Auto Climb"] = "自动攀爬",
    ["Anti-Fall (Hook + TP)"] = "防坠落(钩子+传送)",
    ["Anti-Fall (Safety Net)"] = "防坠落(安全网)",
    ["Safety Net Offset"] = "安全网偏移",
    ["-5 studs/-5 studs"] = "-5单位/-5单位",
    ["Bring Guards Loop"] = "带来守卫循环",
    ["Guard Limit:20"] = "守卫限制:20",
    ["Guard TP Delay:1"] = "守卫传送延迟:1",
    ["Gun Mods (Rebel)"] = "枪械修改(反抗者)",
    ["WARNING:Only use after picking up a gun!"] = "警告:仅在拾取枪后使用!",
    ["Select Gun"] = "选择枪械",
    ["Input Activation Distance"] = "输入激活距离",
    ["Return Delay (sec)：1"] = "返回延迟(秒):1",
    ["Sky Squid Games"] = "天空鱿鱼游戏",
    ["Set Guard TP Waypoint"] = "设置守卫传送路径点",
    ["Auto Power-Hold"] = "自动力量保持",
    ["TP to Winning Room"] = "传送到获胜房间",
    ["Glass Highlight"] = "玻璃高亮",
    ["No Fall (Hook + TP)"] = "防坠落(钩子+传送)",
    ["No Fall (Troll)"] = "防坠落( troll模式)",
    ["Teleport To End"] = "传送到终点",
    ["Power-Hold TP"] = "力量保持传送",
    ["Teleport Delay:50%"] = "传送延迟:50%",
    ["Rebel"] = "反抗者",
    ["Enable Dodge"] = "启用闪避",
    ["Activation Distance:15"] = "激活距离:15",
    ["Enable Silent Aim"] = "启用静默瞄准",
    ["120px/1000px"] = "120像素/1000像素",
    ["Select Mode"] = "选择模式",
    ["Teleport To End"] = "传送到终点",
    ["Auto Balance"] = "自动平衡",
    ["Delete Rope"] = "删除绳子",
    ["Teleport To Spikes"] = "传送到尖刺",
    ["Spike Kill"] = "尖刺击杀",
    ["Help Random Player"] = "帮助随机玩家",
    ["Troll Random Player"] = "恶搞随机玩家",
    ["Auto Kill Players"] = "自动击杀玩家",
    ["Auto Pull Rope"] = "自动拉绳",
    ["Rope Pull Interval"] = "拉绳间隔",
    ["0 seconds/3 seconds"] = "0秒/3秒",
    ["Seeker ESP"] = "寻找者透视",
    ["Exit Door ESP"] = "出口门透视",
    ["Key ESP"] = "钥匙透视",
    ["Key Select"] = "钥匙选择",
    ["Circle Key"] = "圆形钥匙",
    ["Teleport To Key"] = "传送到钥匙",
    ["Teleport To Exit Door"] = "传送到出口门",
    ["Remove Spikes"] = "移除尖刺",
    ["Toggle"] = "切换",
    ["Ink Game - TexRBLX |30 fps |149 ms | build:public build"] = "墨水游戏 - TexRBLX |30 fps |149 ms | 构建:公开构建",
    ["Lock"] = "锁定",
    ["Ink Game"] = "墨水游戏",
    ["Anti Cheat"] = "反作弊",
    ["Dalgona"] = "糖饼",
    ["Additional AC Bypass"] = "额外反作弊绕过",
    ["Crack God-Mode"] = "破解上帝模式",
    ["Red Light Green Light"] = "红灯绿灯",
    ["Complete Shape"] = "完成形状",
    ["Give Lighter"] = "给予打火机",
    ["God Mode Minus"] = "上帝模式减",
    ["Teleport Location"] = "传送位置",
    ["Top Of Tree"] = "树顶",
    ["Hide and Seek"] = "捉迷藏",
    ["Hider ESP"] = "隐藏者透视",
    ["Pickup All Flowers"] = "拾取所有花朵",
    ["收集 All Gold Stacks"] = "收集所有金币堆",
    ["自动 Crock Pot"] = "自动炖锅",
    ["Food Choice"] = "食物选择",
    ["Bring Food To Cook Pot"] = "带来食物到烹饪锅",
    ["Bring Location"] = "带来位置",
    ["Build Radius"] = "建造半径",
    ["Angle Increment"] = "角度增量",
    ["中刺"] = "中刺",
    ["Plant/Build Limit"] = "种植/建造限制",
    ["Fartsaken"] = "Fartsaken",
    ["Autoblock"] = "自动格挡",
    ["Automatically block incoming attacks"] = "自动格挡 incoming attacks",
    ["Unlock"] = "解锁",
    ["Main"] = "主要",
    ["Config"] = "配置",
    ["Hitbox"] = "命中框",
    ["Characters"] = "角色",
    ["Rage"] = "狂暴模式",
    ["Aiming"] = "瞄准",
    ["Block Projectiles"] = "格挡投射物",
    ["Autoblock Characters"] = "自动格挡角色",
    ["Music"] = "音乐",
    ["Aimbot"] = "自动瞄准",
    ["Silent Aim"] = "静默瞄准",
    ["TwoTime Look Same Direction"] = "TwoTime看同一方向",
    ["Aimbot Characters"] = "自动瞄准角色",
    ["TwoTime,Guest1337,Ch..."] = "TwoTime,Guest1337,Ch...",
    ["Silent Aim Characters"] = "静默瞄准角色",
    ["c00lkidd, Dusekkar, Noli"] = "c00lkidd, Dusekkar, Noli",
    ["Silent Aim Prediction Strength"] = "静默瞄准预测强度",
    ["1/2.5"] = "1/2.5",
    ["Dusekkar Aim Target"] = "Dusekkar瞄准目标",
    ["Killer"] = "杀手",
    ["Dusekkar Wallbang"] = "Dusekkar穿墙",
    ["Misc Rage Functions"] = "杂项狂暴功能",
    ["Reach"] = "范围",
    ["Auto Screen Popups"] = "自动屏幕弹出",
    ["Anti Reach"] = "反范围",
    ["Shedletsky Fling Sword"] = "Shedletsky抛掷剑",
    ["Reach Distance"] = "范围距离",
    ["50 Studs"] = "50单位",
    ["Reach Prediction"] = "范围预测",
    ["1 Seconds"] = "1秒",
    ["Reach Strength"] = "范围强度",
    ["1 Multiplier"] = "1倍",
    ["Reach Delay"] = "范围延迟",
    ["0.15 Seconds"] = "0.15秒",
    ["Speed Stamina"] = "速度耐力",
    ["Note:Stamina changes apply after round ends"] = "注意:耐力变化在回合结束后应用",
    ["Stamina Gain Speed"] = "耐力获得速度",
    ["20/100"] = "20/100",
    ["Actions"] = "动作",
    ["Abilities"] = "能力",
    ["Invisibility"] = "隐身",
    ["Better Noli Controls"] = "更好的Noli控制",
    ["Auto Generator"] = "自动发电机",
    ["Auto Solve Generator"] = "自动解决发电机",
    ["K"] = "K",
    ["Generator Helper"] = "发电机助手",
    ["Generators"] = "发电机",
    ["Waiting to be in generator.."] = "等待进入发电机..",
    ["Generator Backgrounds"] = "发电机背景",
    ["Background Video."] = "背景视频",
    ["Subway Surfers"] = "地铁跑酷",
    ["Video Volume"] = "视频音量",
    ["Tracer Start Position"] = "追踪线起始位置",
    ["Bottom"] = "底部",
    ["Slasher] Forsaken"] = "杀手] 被遗弃者",
    ["Outline Transparency"] = "轮廓透明度",
    ["Chams"] = "透视材质",
    ["Fill Transparency"] = "填充透明度",
    ["0.5/1"] = "0.5/1",
    ["World"] = "世界",
    ["Disable Blur"] = "禁用模糊",
    ["Visuals"] = "视觉效果",
    ["ESP and other visuals."] = "透视和其他视觉效果",
    ["Items"] = "物品",
    ["Minions"] = "仆从",
    ["Projectile"] = "投射物",
    ["Taph Traps"] = "陷阱",
    ["Full Bright"] = "全亮",
    ["Self"] = "自身",
    ["Princess Mode"] = "公主模式",
    ["Field of View"] = "视野",
    
    -- ===== 新增翻译内容 =====
    ["Bring Gears"] = "带来齿轮",
    ["Bring Guns & Armor"] = "带来枪械和护甲",
    ["Guns & Armor"] = "枪械和护甲",
    ["Laser"] = "激光",
    ["Bring Others"] = "带来其他物品",
    ["Others"] = "其他",
    ["Diamond"] = "钻石",
    ["Bring Food & Healing"] = "带来食物和治疗物品",
    ["Food & Healing"] = "食物和治疗",
    ["Bandage"] = "绷带",
    ["Entertainment"] = "娱乐",
    ["Cold"] = "寒冷",
    ["Automation"] = "自动化",
    ["CO"] = "CO",
    ["Bring Stuff"] = "带来物品",
    ["x2"] = "x2",
    ["Fishing"] = "钓鱼",
    ["Gears"] = "齿轮",
    ["Bolt, Tyre"] = "螺栓,轮胎",
    ["Sprint"] = "冲刺",
    ["Teleport"] = "传送",
    ["Bring GearsBring Height"] = "带来齿轮高度",
    ["Bring Fuel [BETA]"] = "带来燃料[BETA]",
    ["Fuel"] = "燃料",
    ["Bring Logs [BETA]"] = "带来日志[BETA]",
    ["Bring Food & HealingFaster Bring IBETA]"] = "带来食物和治疗更快带来[BETA]",
    ["Bring Location"] = "带来位置",
    ["Max Per Item"] = "每物品最大数量",
    ["Bring Cooldown"] = "带来冷却",
    ["No Bring Quantity Limit"] = "无带来数量限制",
    ["Bring Height"] = "带来高度",
    ["Player"] = "玩家",
    ["10"] = "10",
    ["1"] = "1",
    ["2Bring Settings"] = "2带来设置",
    ["Use Freecam for Bring Items"] = "使用自由相机带来物品",
    ["Faster Bring [BETA]"] = "更快带来[BETA]",
    ["Brina Cold Teleport to Camp"] = "布琳娜寒冷传送到营地",
    ["Water"] = "水",
    ["Teleport to Cultist Generator Base"] = "传送到邪教发电机基地",
    ["Teleport to Stronghold"] = "传送到要塞",
    ["Teleport to Stronghold Diamond Chest"] = "传送到要塞钻石宝箱",
    ["Teleport to Caravan"] = "传送到商队",
    ["Teleport to FairyChildren"] = "传送到仙子子对象",
    ["ChildrenEspColor"] = "子对象透视颜色",
    ["Children Items"] = "子对象物品",
    ["Gears ESP"] = "齿轮透视",
    ["Gears"] = "齿轮",
    ["GearsEspColor"] = "齿轮透视颜色",
    ["Lost Children...Gears ESP"] = "丢失子对象...齿轮透视",
    ["Gears Items"] = "齿轮物品",
    ["Fuel ESP"] = "燃料透视",
    ["Fuel"] = "燃料",
    ["Bolt, Tyre....FuelEspColor"] = "螺栓,轮胎....燃料透视颜色",
    ["Fuel Items"] = "燃料物品",
    ["Food & Healing ESP"] = "食物和治疗透视",
    ["Food & Healing"] = "食物和治疗",
    ["FoodHealingEspColor"] = "食物和治疗透视颜色",
    ["Food & Healing Items"] = "食物和治疗物品",
    ["Corpse"] = "尸体",
    ["Carrot"] = "胡萝卜",
    ["Guns & Armor ESP"] = "枪械和护甲透视",
    ["Guns & Armor"] = "枪械和护甲",
    ["GunsArmorEspColor"] = "枪械和护甲透视颜色",
    ["Guns & Armor Items"] = "枪械和护甲物品",
    ["Laser"] = "激光",
    ["Others"] = "其他",
    ["OthersEspColor"] = "其他透视颜色",
    ["Others Items"] = "其他物品",
    ["Character ESP"] = "角色透视",
    ["Character"] = "角色",
    ["CharactersEspColor"] = "角色透视颜色",
    ["Feather"] = "羽毛",
    ["Character Items"] = "角色物品",
    ["ESP Settings"] = "透视设置",
    ["Enable Highlight"] = "启用高亮",
    ["Show Distance"] = "显示距离",
    ["Fill Transparency"] = "填充透明度",
    ["Frog"] = "青蛙",
    ["0.75Remove Sky"] = "0.75移除天空",
    ["Ambient"] = "环境",
    ["Rich Shader"] = "丰富着色器",
    ["Shader Color"] = "着色器颜色",
    ["PerformanceLighting Theme"] = "性能照明主题",
    ["Enable Lighting Theme"] = "启用照明主题",
    ["Aesthetic Lighting"] = "美学照明",
    ["Security"] = "安全"
}

-- 创建翻译缓存
local translationCache = {}
local cacheHits = 0
local totalRequests = 0

-- 翻译函数
local function translatePhrase(text)
    if not text or text == "" or type(text) ~= "string" then
        return text, false
    end

    totalRequests = totalRequests + 1
    
    -- 检查缓存
    if cacheEnabled and translationCache[text] then
        cacheHits = cacheHits + 1
        return translationCache[text], true
    end

    local translated = text
    local anyReplaced = false
    
    -- 根据当前模式选择翻译方式
    if currentMode == 1 then
        -- 仅完全匹配
        if phraseDictionary[text] then
            translated = phraseDictionary[text]
            anyReplaced = true
        end
    elseif currentMode == 2 then
        -- 尝试完全匹配
        if phraseDictionary[text] then
            translated = phraseDictionary[text]
            anyReplaced = true
        else
            -- 尝试单词替换
            local words = {}
            for word in text:gmatch("%S+") do
                table.insert(words, phraseDictionary[word] or word)
            end
            local newText = table.concat(words, " ")
            if newText ~= text then
                translated = newText
                anyReplaced = true
            end
        end
    elseif currentMode == 3 then
        -- 尝试完全匹配
        if phraseDictionary[text] then
            translated = phraseDictionary[text]
            anyReplaced = true
        else
            -- 尝试句子替换
            local sortedKeys = {}
            for k in pairs(phraseDictionary) do
                table.insert(sortedKeys, k)
            end
            table.sort(sortedKeys, function(a, b)
                return #a > #b
            end)

            for _, eng in ipairs(sortedKeys) do
                local pattern = "%f[%w]" .. eng:gsub("%%", "%%%%"):gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") .. "%f[%W]"
                local chi = phraseDictionary[eng]
                local newTranslated, count = translated:gsub(pattern, chi)
                if count > 0 then
                    translated = newTranslated
                    anyReplaced = true
                end
            end
        end
    end

    -- 更新缓存
    if cacheEnabled and anyReplaced then
        translationCache[text] = translated
    end

    return translated, anyReplaced
end

-- 设置文本函数
local function safeSetText(element, text)
    if element and element.Parent then
        pcall(function()
            element.Text = text
        end)
    end
end

-- 翻译状态
local isAutoTranslating = false
local totalTranslated = 0
local lastScanTime = 0
local scanCooldown = 0.3
local lastTranslatedPhrase = "无"
local processedElements = {}
local translationSpeed = 0
local lastSpeedUpdate = 0
local lastTranslationCount = 0

-- 主翻译函数
local function performPhraseTranslation()
    if not isAutoTranslating then
        return 0
    end

    local currentTime = tick()
    if currentTime - lastScanTime < scanCooldown then
        return 0
    end
    
    -- 统计
    if currentTime - lastSpeedUpdate >= 1 then
        translationSpeed = totalTranslated - lastTranslationCount
        lastTranslationCount = totalTranslated
        lastSpeedUpdate = currentTime
        statsText.Text = string.format("已翻译: %d | 缓存: %d | 速度: %d/s", 
            totalTranslated, cacheHits, translationSpeed)
    end

    lastScanTime = currentTime
    local translatedCount = 0
    local foundElements = {}

    -- 收集UI
    local function collectElements(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                if not processedElements[child] then
                    table.insert(foundElements, child)
                end
            end
            collectElements(child)
        end
    end

    -- 从UI开始
    collectElements(playerGui)
    collectElements(CoreGui)

    -- 翻译找UI
    for _, element in ipairs(foundElements) do
        if isAutoTranslating and element.Parent then
            local success, translatedText = pcall(function()
                local originalText = element.Text
                if originalText and originalText ~= "" then
                    local translated, wasTranslated = translatePhrase(originalText)
                    if wasTranslated and translated ~= originalText then
                        safeSetText(element, translated)
                        processedElements[element] = true
                        lastTranslatedPhrase = originalText .. " → " .. translated
                        detailText.Text = "最近翻译: " .. (lastTranslatedPhrase:sub(1, 50) .. ( #lastTranslatedPhrase > 50 and "..." or "" ))
                        return true
                    end
                end
                return false
            end)
            if success and translatedText then
                translatedCount = translatedCount + 1
            end
        end
    end

    totalTranslated = totalTranslated + translatedCount
    return translatedCount
end

-- 自动翻译
local function startAutoTranslation()
    if isAutoTranslating then
        return
    end
    isAutoTranslating = true
    toggleButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60) -- 红色表示激活
    toggleButton.Text = "停止翻译"
    statusText.Text = "当前状态: 翻译中..."
    totalTranslated = 0
    lastTranslationCount = 0
    translationSpeed = 0
    processedElements = {}
    statsText.Text = "已翻译: 0 | 缓存: 0 | 速度: 0/s"
    detailText.Text = "最近翻译: 无"

    -- 使用RunService来定期执行翻译
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not isAutoTranslating then
            connection:Disconnect()
            return
        end
        performPhraseTranslation()
    end)
end

local function stopAutoTranslation()
    isAutoTranslating = false
    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    toggleButton.Text= "开始翻译"
    statusText.Text = "当前状态: 已停止"
end

-- UI函数
local function toggleUI()
    mainFrame.Visible = not mainFrame.Visible
end

-- 主UI拖拽
local mainFrameDragging = false
local mainFrameDragStartPos
local mainFrameStartPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        mainFrameDragging = true
        mainFrameDragStartPos = input.Position
        mainFrameStartPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                mainFrameDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if mainFrameDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - mainFrameDragStartPos
        mainFrame.Position = UDim2.new(0, mainFrameStartPos.X.Offset + delta.X, 0, mainFrameStartPos.Y.Offset + delta.Y)
    end
end)

-- 控制按钮
local controlButtonDragging = false
local controlButtonDragStartPos
local controlButtonStartPos

controlButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        controlButtonDragging = true
        controlButtonDragStartPos = input.Position
        controlButtonStartPos = controlButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                controlButtonDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if controlButtonDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - controlButtonDragStartPos
        controlButton.Position = UDim2.new(0, controlButtonStartPos.X.Offset + delta.X, 0, controlButtonStartPos.Y.Offset + delta.Y)
        if mainFrame.Visible then
            mainFrame.Position = UDim2.new(0, controlButtonStartPos.X.Offset + delta.X + 70, 0, controlButtonStartPos.Y.Offset + delta.Y)
        end
    end
end)

-- UI拖拽
local optionsFrameDragging = false
local optionsFrameDragStartPos
local optionsFrameStartPos

optionsTitle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        optionsFrameDragging = true
        optionsFrameDragStartPos = input.Position
        optionsFrameStartPos = optionsFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                optionsFrameDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if optionsFrameDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - optionsFrameDragStartPos
        optionsFrame.Position = UDim2.new(0, optionsFrameStartPos.X.Offset + delta.X, 0, optionsFrameStartPos.Y.Offset + delta.Y)
    end
end)

-- 按钮点击
controlButton.MouseButton1Click:Connect(toggleUI)
toggleButton.MouseButton1Click:Connect(function()
    if isAutoTranslating then
        stopAutoTranslation()
    else
        startAutoTranslation()
    end
end)

optionsButton.MouseButton1Click:Connect(function()
    optionsFrame.Visible = true
end)

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

closeOptionsButton.MouseButton1Click:Connect(function()
    optionsFrame.Visible = false
end)

optionsCloseButton.MouseButton1Click:Connect(function()
    optionsFrame.Visible = false
end)

-- 初始化
local function initialize()
    print("========================================")
    print("WU SCRIPT界面汉化工具")
    print("联系作者添加翻译模版")
    print("当前模式: "..modes[currentMode][1])
    print("========================================")
    
    -- 初始提示
    delay(2, function()
        print("提示: 点击执行翻译即可")
    end)
end

initialize()