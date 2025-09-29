-- 创建界面
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ArmyScriptGUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Selectable = true
mainFrame.Parent = screenGui

-- 添加圆角效果
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "MR制作｜免费禁倒卖｜425695367"
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextWrapped = true
title.Parent = mainFrame

-- 标题栏圆角
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

-- 获取游戏服务
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local eventsFolder = replicatedStorage:WaitForChild("Events")
local deployEvent = eventsFolder:WaitForChild("Deploy")
local returnEvent = eventsFolder:WaitForChild("Return")

-- 全局变量
local cashConnection = nil
local lagConnections = {}
local threads = 10

-- 存储按钮引用以便控制显示隐藏
local buttons = {}
local statusLabel = nil
local infoLabel = nil

-- 创建带样式的按钮
local function createButton(name, position, callback, buttonColor)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.85, 0, 0, 35)
    button.Position = position
    button.BackgroundColor3 = buttonColor or Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 13
    button.AutoButtonColor = true
    button.Parent = mainFrame
    button.Name = name
    
    -- 按钮圆角
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- 按钮悬停效果
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = button.BackgroundColor3:Lerp(Color3.fromRGB(255, 255, 255), 0.1)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = buttonColor or Color3.fromRGB(60, 60, 60)
    end)
    
    button.MouseButton1Click:Connect(callback)
    
    table.insert(buttons, button)
    return button
end

-- 停止所有功能
local function stopAll()
    if cashConnection then
        cashConnection:Disconnect()
        cashConnection = nil
    end
    
    for i, conn in ipairs(lagConnections) do
        if conn then
            conn:Disconnect()
            lagConnections[i] = nil
        end
    end
    
    updateStatus("所有功能已停止")
end

-- 开始刷钱功能
local function startMoneyFarm()
    stopAll() -- 先停止其他功能
    
    cashConnection = runService.Heartbeat:Connect(function()
        pcall(function()
            deployEvent:FireServer()
            returnEvent:FireServer()
        end)
    end)
    
    updateStatus("刷钱功能已启动")
end

-- 开始卡服功能
local function startLagServer()
    stopAll() -- 先停止其他功能
    
    for i = 1, threads do
        lagConnections[i] = runService.Heartbeat:Connect(function()
            pcall(function()
                deployEvent:FireServer()
            end)
        end)
    end
    
    updateStatus("卡服功能已启动 - " .. threads .. "线程")
end

-- 状态显示
statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0, 160)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.Text = "状态: 就绪"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.Parent = mainFrame

-- 更新状态显示
function updateStatus(message)
    if statusLabel then
        statusLabel.Text = "状态: " .. message
    end
    print("系统: " .. message)
end

-- 创建按钮（使用不同颜色区分功能）
createButton("💰 开始刷钱", UDim2.new(0.075, 0, 0.3, 0), startMoneyFarm, Color3.fromRGB(40, 120, 60))
createButton("⚡ 开始卡服", UDim2.new(0.075, 0, 0.55, 0), startLagServer, Color3.fromRGB(120, 60, 40))
createButton("🛑 停止所有", UDim2.new(0.075, 0, 0.8, 0), stopAll, Color3.fromRGB(120, 40, 40))

-- 添加关闭按钮
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 8)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = title

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 12)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- 添加最小化功能
local minimized = false
local originalSize = mainFrame.Size
local minimizedSize = UDim2.new(0, 250, 0, 40)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -60, 0, 8)
minimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Text = "_"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 14
minimizeButton.Parent = title

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 12)
minimizeCorner.Parent = minimizeButton

-- 显示/隐藏内容函数
local function toggleContentVisibility(visible)
    for _, button in ipairs(buttons) do
        button.Visible = visible
    end
    if statusLabel then
        statusLabel.Visible = visible
    end
    if infoLabel then
        infoLabel.Visible = visible
    end
end

minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        -- 最小化：隐藏所有内容，只保留标题栏
        toggleContentVisibility(false)
        mainFrame.Size = minimizedSize
        minimizeButton.Text = "+"
        updateStatus("界面已最小化")
    else
        -- 恢复：显示所有内容
        toggleContentVisibility(true)
        mainFrame.Size = originalSize
        minimizeButton.Text = "_"
        updateStatus("界面已恢复")
    end
end)

-- 键盘快捷键
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then -- 按F键隐藏/显示界面
        screenGui.Enabled = not screenGui.Enabled
        updateStatus(screenGui.Enabled and "界面显示" or "界面隐藏")
    elseif input.KeyCode == Enum.KeyCode.R then -- 按R键重置位置
        mainFrame.Position = UDim2.new(0, 10, 0, 10)
        updateStatus("位置已重置")
    elseif input.KeyCode == Enum.KeyCode.M then -- 按M键最小化/恢复
        minimizeButton:MouseButton1Click()
    end
end)

-- 添加说明文本
infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 35)
infoLabel.Position = UDim2.new(0, 0, 1, 5)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
infoLabel.Text = "MR制作免费分享｜倒卖全死｜作者Q425695367"
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 10
infoLabel.TextWrapped = true
infoLabel.Parent = mainFrame

print("MR制作｜组建军队脚本已加载")
print("快捷键: F - 隐藏/显示, R - 重置位置, M - 最小化")
print("拖动标题栏可以移动界面")
updateStatus("就绪 - 等待操作")
