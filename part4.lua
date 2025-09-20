-- 关闭UI
local function CloseUI()
    MRGui:Destroy()
    print("MR脚本UI已关闭")
end

-- 重置设置
local function ResetSettings()
    UISettings.Theme = "default"
    ApplyUISettings()
    print("设置已重置为默认值")
end

-- 处理拖动事件
local function SetupDragging(frame, dragFlag, startPosFlag)
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            _G[dragFlag] = true
            _G[startPosFlag] = Vector2.new(input.Position.X, input.Position.Y)
            frame.Draggable = false
        end
    end)
    
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            _G[dragFlag] = false
            frame.Draggable = true
        end
    end)
end

-- 初始化
CreateScriptButtons()
CreateInfoContent()
UpdateScrollSize()
UpdateInfoScrollSize()
ApplyUISettings()

-- 设置拖动
SetupDragging(TitleBar, "IsDragging", "DragStartPos")
SetupDragging(InfoTitleBar, "IsInfoDragging", "InfoDragStartPos")
SetupDragging(SettingsTitleBar, "IsSettingsDragging", "SettingsDragStartPos")

-- 按钮点击事件
ToggleButton.MouseButton1Click:Connect(ToggleUI)
CloseButton.MouseButton1Click:Connect(CloseUI)
InfoButton.MouseButton1Click:Connect(ToggleInfo)
SettingsButton.MouseButton1Click:Connect(ToggleSettings)
CloseInfoButton.MouseButton1Click:Connect(function() InfoFrame.Visible = false end)
CloseSettingsButton.MouseButton1Click:Connect(function() SettingsFrame.Visible = false end)

-- 主题按钮点击
DefaultThemeButton.MouseButton1Click:Connect(function()
    UISettings.Theme = "default"
    ApplyUISettings()
end)

WhiteThemeButton.MouseButton1Click:Connect(function()
    UISettings.Theme = "white"
    ApplyUISettings()
end)

BlackThemeButton.MouseButton1Click:Connect(function()
    UISettings.Theme = "black"
    ApplyUISettings()
end)

ResetSettingsButton.MouseButton1Click:Connect(ResetSettings)

UserInputService.InputChanged:Connect(function(input)
    if IsDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - DragStartPos
        MainContainer.Position = UDim2.new(0, MainContainer.Position.X.Offset + delta.X, 0, MainContainer.Position.Y.Offset + delta.Y)
        DragStartPos = Vector2.new(input.Position.X, input.Position.Y)
    end
    
    if IsInfoDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - InfoDragStartPos
        InfoFrame.Position = UDim2.new(0, InfoFrame.Position.X.Offset + delta.X, 0, InfoFrame.Position.Y.Offset + delta.Y)
        InfoDragStartPos = Vector2.new(input.Position.X, input.Position.Y)
    end
    
    if IsSettingsDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - SettingsDragStartPos
        SettingsFrame.Position = UDim2.new(0, SettingsFrame.Position.X.Offset + delta.X, 0, SettingsFrame.Position.Y.Offset + delta.Y)
        SettingsDragStartPos = Vector2.new(input.Position.X, input.Position.Y)
    end
end)

-- 布局变化时更新滚动大小
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateScrollSize)
InfoListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateInfoScrollSize)

-- 初始化UI
print("MR脚本UI v3.0 已加载！")
print("简洁版，保留核心功能")
print("点击+按钮展开脚本列表")
print("点击⚙️按钮打开设置面板")
print("点击i按钮查看信息")
