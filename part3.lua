-- UI状态变量
local IsExpanded = false
local IsInfoVisible = false
local IsSettingsVisible = false
local IsDragging = false
local IsInfoDragging = false
local IsSettingsDragging = false
local DragStartPos, InfoDragStartPos, SettingsDragStartPos

-- 脚本数据表
local Scripts = {
    {
        Name = "鲨鱼咬2",
        Color = Color3.fromRGB(60, 120, 60),
        LoadFunction = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/UDHVCGL/gfhasd02/refs/heads/Q425695367/SharkBite2汉化.lua"))()
        end
    },
    {
        Name = "超速射击",
        Color = Color3.fromRGB(120, 60, 60),
        LoadFunction = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/UDHVCGL/gfhasd02/refs/heads/Q425695367/Hypersshot汉化.lua"))()
        end
    },
    {
        Name = "墨水游戏",
        Color = Color3.fromRGB(80, 60, 120),
        LoadFunction = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/UDHVCGL/gfhasd02/refs/heads/Q425695367/墨水汉化.lua"))()
        end
    },
    {
        Name = "DOORS",
        Color = Color3.fromRGB(60, 100, 150),
        LoadFunction = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/UDHVCGL/gfhasd02/refs/heads/Q425695367/DOORS.lua"))()
        end
    }
}

-- 信息内容数据
local InfoContents = {
    "🎯 MR脚本中心 正式版v1",
    "✨ 更新公告：",
    "• 更新服务器DOORS",
    "• 不定期更新",
    "• 后续更新:被遗弃，死铁轨，起床战争",
    "• 更新时间:2025/9/20",
    "",
    "🛠️ 重要信息：",
    "• MR脚本创始人:MR",
    "• 作者QQ:425695367",
    "• 免费版本丨倒卖全死"
}

-- 应用UI设置
local function ApplyUISettings()
    local theme = UISettings.Themes[UISettings.Theme]
    
    -- 应用颜色主题
    MainContainer.BackgroundColor3 = theme.MainColor
    TitleBar.BackgroundColor3 = theme.TitleColor
    ContentFrame.BackgroundColor3 = theme.ContentColor
end

-- 创建脚本按钮
local function CreateScriptButtons()
    for i, scriptData in ipairs(Scripts) do
        local button = Instance.new("TextButton")
        button.Name = scriptData.Name .. "Button"
        button.Size = UDim2.new(1, -10, 0, 30)
        button.Position = UDim2.new(0, 5, 0, (i-1)*35 + 5)
        button.BackgroundColor3 = scriptData.Color
        button.BackgroundTransparency = 0.3
        button.BorderSizePixel = 0
        button.Text = scriptData.Name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 14
        button.LayoutOrder = i
        button.Visible = false
        
        button.MouseButton1Click:Connect(function()
            local oldText = button.Text
            button.Text = "加载中..."
            pcall(scriptData.LoadFunction)
            delay(2, function()
                if button then button.Text = oldText end
            end)
        end)
        
        button.Parent = ScrollFrame
    end
end

-- 创建信息内容
local function CreateInfoContent()
    for i, content in ipairs(InfoContents) do
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "InfoLine" .. i
        textLabel.Size = UDim2.new(1, 0, 0, 20)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = content
        textLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        textLabel.Font = Enum.Font.SourceSans
        textLabel.TextSize = 12
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.TextWrapped = true
        textLabel.LayoutOrder = i
        textLabel.AutomaticSize = Enum.AutomaticSize.Y
        
        if content:find("🎯") or content:find("✨") or content:find("🛠️") then
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 150)
            textLabel.Font = Enum.Font.SourceSansBold
        elseif content:find("•") then
            textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            textLabel.Position = UDim2.new(0, 10, 0, 0)
        elseif content == "" then
            textLabel.Size = UDim2.new(1, 0, 0, 10)
            textLabel.Text = ""
        end
        
        textLabel.Parent = InfoScrollFrame
    end
end

-- 更新滚动框架大小
local function UpdateScrollSize()
    local totalHeight = #Scripts * 35 + (#Scripts - 1) * 5 + 10
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- 更新信息滚动框架大小
local function UpdateInfoScrollSize()
    local totalHeight = 0
    for _, child in ipairs(InfoScrollFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            totalHeight = totalHeight + child.AbsoluteSize.Y + 5
        end
    end
    InfoScrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- 切换设置显示
local function ToggleSettings()
    IsSettingsVisible = not IsSettingsVisible
    SettingsFrame.Visible = IsSettingsVisible
    
    if IsSettingsVisible then
        local mainPos = MainContainer.AbsolutePosition
        local mainSize = MainContainer.AbsoluteSize
        SettingsFrame.Position = UDim2.new(0, mainPos.X + mainSize.X + 10, 0, mainPos.Y)
    end
end

-- 切换信息显示
local function ToggleInfo()
    IsInfoVisible = not IsInfoVisible
    InfoFrame.Visible = IsInfoVisible
    
    if IsInfoVisible then
        local mainPos = MainContainer.AbsolutePosition
        local mainSize = MainContainer.AbsoluteSize
        InfoFrame.Position = UDim2.new(0, mainPos.X + mainSize.X + 10, 0, mainPos.Y)
    end
end

-- 展开/折叠UI
local function ToggleUI()
    IsExpanded = not IsExpanded
    
    if IsExpanded then
        ToggleButton.Text = "-"
        local contentHeight = math.min(#Scripts * 35 + (#Scripts) * 5 + 10, 250)
        MainContainer.Size = UDim2.new(0, 200, 0, contentHeight + 40)
        ContentFrame.Size = UDim2.new(1, 0, 0, contentHeight)
        ScrollFrame.Visible = true
        
        for _, child in ipairs(ScrollFrame:GetChildren()) do
            if child:IsA("TextButton") then child.Visible = true end
        end
    else
        ToggleButton.Text = "+"
        MainContainer.Size = UDim2.new(0, 150, 0, 40)
        ContentFrame.Size = UDim2.new(1, 0, 0, 0)
        ScrollFrame.Visible = false
    end
end
