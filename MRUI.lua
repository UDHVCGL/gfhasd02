
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

local function GetScreenSize()
    local viewport = workspace.CurrentCamera.ViewportSize
    return viewport.X, viewport.Y
end

local function GetAdaptiveSize()
    local screenWidth, screenHeight = GetScreenSize()
    local isMobile = IsMobile()

    if isMobile then

        local width = math.min(screenWidth * 0.85, 420)
        local height = math.min(screenHeight * 0.65, 500)
        return UDim2.new(0, width, 0, height)
    else

        local width = math.min(520, screenWidth * 0.8)
        local height = math.min(520 * 0.618, screenHeight * 0.8)
        return UDim2.new(0, width, 0, height)
    end
end

local function GetAdaptivePosition(size)
    local isMobile = IsMobile()

    if isMobile then

        return UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    else

        return UDim2.new(0, -size.X.Offset - 100, 0.5, -size.Y.Offset/2)
    end
end

local function GetGameListSize()
    local screenWidth, screenHeight = GetScreenSize()
    local isMobile = IsMobile()

    if isMobile then

        local width = math.min(screenWidth * 0.9, 380)
        local height = math.min(screenHeight * 0.8, 550)
        return UDim2.new(0, width, 0, height)
    else

        return UDim2.new(0, 450, 0, 600)
    end
end

local function GetDeveloperPageSize()
    local screenWidth, screenHeight = GetScreenSize()
    local isMobile = IsMobile()

    if isMobile then

        local width = math.min(screenWidth * 0.92, 400)
        local height = math.min(screenHeight * 0.85, 580)
        return UDim2.new(0, width, 0, height)
    else

        return UDim2.new(0, 600, 0, 520)
    end
end

local function cleanupAllGuis()
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui.Name == "XiProLoader" or gui.Name == "XiProGameList" then
            gui:Destroy()
        end
    end
end

local function createParticle(parent)
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
    particle.Position = UDim2.new(math.random(0, 100)/100, 0, math.random(0, 100)/100, 0)
    particle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    particle.BackgroundTransparency = math.random(30, 70)/100
    particle.BorderSizePixel = 0
    particle.ZIndex = 6
    particle.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.5, 0)
    corner.Parent = particle
    spawn(function()
        while particle.Parent do
            local moveInfo = TweenInfo.new(math.random(20, 40)/10, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local newPos = UDim2.new(math.random(0, 100)/100, 0, math.random(0, 100)/100, 0)
            local moveTween = TweenService:Create(particle, moveInfo, {Position = newPos})
            moveTween:Play()
            wait(math.random(20, 40)/10)
        end
    end)
end

local function GetAsset(v)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return game:GetService("HttpService"):JSONDecode(request({
        Url = v,
        Headers = {
            Authorization = "Bearer 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"
        }
    }).Body).content:gsub('[^'..b..'=]', ''):gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end)
end

local function showLoadingAnimation(onComplete)
    cleanupAllGuis()

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "XiProLoader"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui

    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.3
    background.BorderSizePixel = 0
    background.ZIndex = 1
    background.Parent = screenGui

    local backgroundGradient = Instance.new("UIGradient")
    backgroundGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 15, 35)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(5, 8, 20)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 40))
    }
    backgroundGradient.Rotation = 45
    backgroundGradient.Parent = background

    spawn(function()
        while background.Parent do
            local rotateInfo = TweenInfo.new(12, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true)
            local rotateTween = TweenService:Create(backgroundGradient, rotateInfo, {Rotation = 135})
            rotateTween:Play()
            wait(12)
        end
    end)

    local mainContainer = Instance.new("Frame")
    local adaptiveSize = GetAdaptiveSize()
    mainContainer.Size = adaptiveSize
    mainContainer.Position = GetAdaptivePosition(adaptiveSize)
    mainContainer.BackgroundColor3 = Color3.fromRGB(18, 25, 45)
    mainContainer.BackgroundTransparency = 0.02
    mainContainer.BorderSizePixel = 0
    mainContainer.ZIndex = 3
    mainContainer.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 28)
    mainCorner.Parent = mainContainer

    local shadowStroke1 = Instance.new("UIStroke")
    shadowStroke1.Thickness = 20
    shadowStroke1.Color = Color3.fromRGB(0, 0, 0)
    shadowStroke1.Transparency = 0.95
    shadowStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    shadowStroke1.Parent = mainContainer

    local shadowStroke2 = Instance.new("UIStroke")
    shadowStroke2.Thickness = 12
    shadowStroke2.Color = Color3.fromRGB(0, 0, 0)
    shadowStroke2.Transparency = 0.8
    shadowStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    shadowStroke2.Parent = mainContainer

    local shadowStroke3 = Instance.new("UIStroke")
    shadowStroke3.Thickness = 6
    shadowStroke3.Color = Color3.fromRGB(0, 0, 0)
    shadowStroke3.Transparency = 0.6
    shadowStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    shadowStroke3.Parent = mainContainer

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Thickness = 3
    mainStroke.Color = Color3.fromRGB(100, 150, 255)
    mainStroke.Transparency = 0
    mainStroke.Parent = mainContainer

    local glowStroke = Instance.new("UIStroke")
    glowStroke.Thickness = 6
    glowStroke.Color = Color3.fromRGB(120, 180, 255)
    glowStroke.Transparency = 0.4
    glowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    glowStroke.Parent = mainContainer

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 60, 95)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(30, 45, 75)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 25, 45)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(25, 35, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 50, 80))
    }
    gradient.Rotation = 135
    gradient.Parent = mainContainer

    spawn(function()
        while mainContainer.Parent do
            local rotateInfo = TweenInfo.new(8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true)
            local rotateTween = TweenService:Create(gradient, rotateInfo, {Rotation = 225})
            rotateTween:Play()
            wait(8)
        end
    end)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -50, 0, IsMobile() and 55 or 65)
    titleLabel.Position = UDim2.new(0, 25, 0, IsMobile() and 20 or 25)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "亲爱的 " .. player.Name
    titleLabel.TextColor3 = Color3.fromRGB(240, 245, 255)
    titleLabel.TextSize = IsMobile() and 22 or 28
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 4
    titleLabel.TextTransparency = 1
    titleLabel.Parent = mainContainer

    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Size = UDim2.new(1, -50, 0, IsMobile() and 50 or 55)
    welcomeLabel.Position = UDim2.new(0, 25, 0, IsMobile() and 75 or 85)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.Text = "欢迎使用 Xi Pro 脚本"
    welcomeLabel.TextColor3 = Color3.fromRGB(140, 200, 255)
    welcomeLabel.TextSize = IsMobile() and 24 or 32
    welcomeLabel.Font = Enum.Font.GothamBold
    welcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
    welcomeLabel.ZIndex = 4
    welcomeLabel.TextTransparency = 1
    welcomeLabel.Parent = mainContainer


    local welcomeGradient = Instance.new("UIGradient")
    welcomeGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 200, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 120, 255))
    }
    welcomeGradient.Parent = welcomeLabel
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -50, 0, IsMobile() and 30 or 35)
    statusLabel.Position = UDim2.new(0, 25, 0, IsMobile() and 140 or 160)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "正在初始化..."
    statusLabel.TextColor3 = Color3.fromRGB(220, 235, 255)
    statusLabel.TextSize = IsMobile() and 16 or 19
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.ZIndex = 4
    statusLabel.TextTransparency = 1
    statusLabel.Parent = mainContainer
    local progressBg = Instance.new("Frame")
    progressBg.Size = UDim2.new(1, -50, 0, IsMobile() and 14 or 16)
    progressBg.Position = UDim2.new(0, 25, 0, IsMobile() and 180 or 220)
    progressBg.BackgroundColor3 = Color3.fromRGB(25, 35, 55)
    progressBg.BorderSizePixel = 0
    progressBg.ZIndex = 4
    progressBg.BackgroundTransparency = 1
    progressBg.Parent = mainContainer
    local progressBgCorner = Instance.new("UICorner")
    progressBgCorner.CornerRadius = UDim.new(0, 8)
    progressBgCorner.Parent = progressBg
    local progressBgStroke = Instance.new("UIStroke")
    progressBgStroke.Thickness = 2
    progressBgStroke.Color = Color3.fromRGB(60, 80, 120)
    progressBgStroke.Transparency = 0.5
    progressBgStroke.Parent = progressBg
    local progressBgShadow = Instance.new("UIStroke")
    progressBgShadow.Thickness = 1
    progressBgShadow.Color = Color3.fromRGB(0, 0, 0)
    progressBgShadow.Transparency = 0.8
    progressBgShadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    progressBgShadow.Parent = progressBg
    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.Position = UDim2.new(0, 0, 0, 0)
    progressFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    progressFill.BorderSizePixel = 0
    progressFill.ZIndex = 5
    progressFill.Parent = progressBg
    local progressFillCorner = Instance.new("UICorner")
    progressFillCorner.CornerRadius = UDim.new(0, 8)
    progressFillCorner.Parent = progressFill
    local progressGradient = Instance.new("UIGradient")
    progressGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 120, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 180, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
    }
    progressGradient.Parent = progressFill
    local progressGlow = Instance.new("UIStroke")
    progressGlow.Thickness = 4
    progressGlow.Color = Color3.fromRGB(100, 150, 255)
    progressGlow.Transparency = 0.3
    progressGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    progressGlow.Parent = progressFill
    local progressInnerGlow = Instance.new("UIStroke")
    progressInnerGlow.Thickness = 1
    progressInnerGlow.Color = Color3.fromRGB(200, 220, 255)
    progressInnerGlow.Transparency = 0.2
    progressInnerGlow.Parent = progressFill
    spawn(function()
        while progressFill.Parent do
            local glowInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true)
            local glowTween = TweenService:Create(progressGlow, glowInfo, {
                Transparency = 0.1,
                Thickness = 6
            })
            glowTween:Play()
            wait(1.5)
        end
    end)
    local progressText = Instance.new("TextLabel")
    progressText.Size = UDim2.new(1, -50, 0, IsMobile() and 25 or 30)
    progressText.Position = UDim2.new(0, 25, 0, IsMobile() and 210 or 250)
    progressText.BackgroundTransparency = 1
    progressText.Text = "0%"
    progressText.TextColor3 = Color3.fromRGB(140, 200, 255)
    progressText.TextSize = IsMobile() and 15 or 18
    progressText.Font = Enum.Font.GothamBold
    progressText.TextXAlignment = Enum.TextXAlignment.Center
    progressText.ZIndex = 4
    progressText.TextTransparency = 1 
    progressText.Parent = mainContainer
    for i = 1, 12 do
        createParticle(mainContainer)
    end
    spawn(function()
        wait(0.1)

        local slideInInfo = TweenInfo.new(1.0, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local finalPosition = UDim2.new(0.5, -adaptiveSize.X.Offset/2, 0.5, -adaptiveSize.Y.Offset/2)
        local slideInTween = TweenService:Create(mainContainer, slideInInfo, {
            Position = finalPosition
        })
        slideInTween:Play()
        wait(0.2)
        local titleFadeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(titleLabel, titleFadeInfo, {TextTransparency = 0}):Play()
        wait(0.15)
        TweenService:Create(welcomeLabel, titleFadeInfo, {TextTransparency = 0}):Play()
        wait(0.15)
        TweenService:Create(statusLabel, titleFadeInfo, {TextTransparency = 0}):Play()
        TweenService:Create(progressBg, titleFadeInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(progressText, titleFadeInfo, {TextTransparency = 0}):Play()
    end)
    local loadingSteps = {
        {text = "正在初始化系统...", progress = 0},
        {text = "检测运行环境...", progress = 8},
        {text = "加载核心模块...", progress = 18},
        {text = "初始化用户界面...", progress = 30},
        {text = "连接远程服务器...", progress = 45},
        {text = "验证用户权限...", progress = 60},
        {text = "下载游戏数据...", progress = 75},
        {text = "解析配置文件...", progress = 85},
        {text = "准备游戏列表...", progress = 95},
        {text = "神仇牛逼！", progress = 100}
    }
    spawn(function()
        wait(0.6)
        for i, step in ipairs(loadingSteps) do
            statusLabel.Text = step.text
            progressText.Text = step.progress.. "%"
            local progressInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local progressTween = TweenService:Create(progressFill, progressInfo, {
                Size = UDim2.new(step.progress/100, 0, 1, 0)
            })
            progressTween:Play()
            wait(math.random(5, 8)/10)
        end
        local successInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local successTween1 = TweenService:Create(mainStroke, successInfo, {
            Color = Color3.fromRGB(100, 255, 150),
            Thickness = 4
        })
        successTween1:Play()
        local instantFadeOut = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(titleLabel, instantFadeOut, {TextTransparency = 1}):Play()
        TweenService:Create(welcomeLabel, instantFadeOut, {TextTransparency = 1}):Play()
        TweenService:Create(statusLabel, instantFadeOut, {TextTransparency = 1}):Play()
        TweenService:Create(progressText, instantFadeOut, {TextTransparency = 1}):Play()
        TweenService:Create(progressBg, instantFadeOut, {BackgroundTransparency = 1}):Play()


        spawn(function()
            wait(0.15)
            titleLabel:Destroy()
            welcomeLabel:Destroy()
            statusLabel:Destroy()
            progressText:Destroy()
            progressBg:Destroy()
        end)


        wait(0.2)
        local transformInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local gameListSize = GetGameListSize()
        local gameListPosition = UDim2.new(0.5, -gameListSize.X.Offset/2, 0.5, -gameListSize.Y.Offset/2)
        local transformTween = TweenService:Create(mainContainer, transformInfo, {
            Size = gameListSize,
            Position = gameListPosition
        })
        transformTween:Play()


        transformTween.Completed:Connect(function()

            local finalSize = GetGameListSize()
            local finalPosition = UDim2.new(0.5, -finalSize.X.Offset/2, 0.5, -finalSize.Y.Offset/2)
            mainContainer.Size = finalSize
            mainContainer.Position = finalPosition


            spawn(function()
                wait(0.05)
                mainContainer.Size = finalSize
                mainContainer.Position = finalPosition
            end)


            if onComplete then
                onComplete(screenGui, mainContainer, background)
            end
        end)
    end)
end

local function MakeAdvancedDraggable(topbar, frame)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    local function BeginDrag(input)
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        TweenService:Create(topbar, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 60, 90)
        }):Play()
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                TweenService:Create(topbar, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(30, 35, 50)
                }):Play()
            end
        end)
    end
    local function UpdateDrag(input)
        if dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           (IsMobile() and input.UserInputType == Enum.UserInputType.Touch) then
            BeginDrag(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                         input.UserInputType == Enum.UserInputType.Touch) then
            UpdateDrag(input)
        end
    end)
end
local function CreateParticles(parent)
    local particleContainer = Instance.new("Frame")
    particleContainer.Name = "ParticleContainer"
    particleContainer.BackgroundTransparency = 1
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.ZIndex = 0
    particleContainer.Parent = parent
    for i = 1, 20 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle"
        particle.BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
        particle.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        particle.Position = UDim2.new(0, math.random(-20, 200), 0, math.random(-20, 200))
        particle.BorderSizePixel = 0
        particle.ZIndex = 0
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        particle.Parent = particleContainer
        spawn(function()
            while particle and particle.Parent do
                local duration = math.random(2, 5)
                local targetPos = UDim2.new(
                    0, math.random(-20, 200),
                    0, math.random(-20, 200)
                )
                TweenService:Create(particle, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
                    Position = targetPos
                }):Play()
                wait(duration)
            end
        end)
    end
end

local function showGameList(screenGui, mainContainer, background, list_game)

    screenGui.Name = "XiProGameList"


    spawn(function()
        wait(0.05)
        local correctSize = GetGameListSize()
        local correctPosition = UDim2.new(0.5, -correctSize.X.Offset/2, 0.5, -correctSize.Y.Offset/2)
        mainContainer.Size = correctSize
        mainContainer.Position = correctPosition
    end)

    local mainStroke = mainContainer:FindFirstChild("UIStroke")
    local glowStroke = mainContainer:FindFirstChildOfClass("UIStroke")
    if mainStroke then
        TweenService:Create(mainStroke, TweenInfo.new(0.5), {
            Color = Color3.fromRGB(100, 150, 255),
            Thickness = 2
        }):Play()
    end
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 55)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(40, 55, 90)
    titleBar.BorderSizePixel = 0
    titleBar.ZIndex = 4
    titleBar.Parent = mainContainer

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 28)
    titleCorner.Parent = titleBar
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 65, 100)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 55, 90)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 60, 95))
    }
    titleGradient.Rotation = 90
    titleGradient.Parent = titleBar
    local titleStroke = Instance.new("UIStroke")
    titleStroke.Thickness = 2
    titleStroke.Color = Color3.fromRGB(120, 180, 255)
    titleStroke.Transparency = 0.6
    titleStroke.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Xi Pro"
    titleLabel.TextColor3 = Color3.fromRGB(240, 245, 255)
    titleLabel.TextSize = IsMobile() and 16 or 20
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 5
    titleLabel.Parent = titleBar
    local closeButton = Instance.new("TextButton")
    closeButton.Size = IsMobile() and UDim2.new(0, 30, 0, 30) or UDim2.new(0, 35, 0, 35)
    closeButton.Position = IsMobile() and UDim2.new(1, -40, 0, 8) or UDim2.new(1, -45, 0, 10)
    closeButton.BackgroundColor3 = Color3.fromRGB(45, 55, 75)
    closeButton.Text = ""
    closeButton.BorderSizePixel = 0
    closeButton.ZIndex = 5
    closeButton.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 12)
    closeCorner.Parent = closeButton
    local closeGradient = Instance.new("UIGradient")
    closeGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 65, 85)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(45, 55, 75)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(40, 50, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 60, 80))
    }
    closeGradient.Rotation = 135
    closeGradient.Parent = closeButton
    local closeOuterGlow = Instance.new("UIStroke")
    closeOuterGlow.Thickness = 3
    closeOuterGlow.Color = Color3.fromRGB(80, 120, 200)
    closeOuterGlow.Transparency = 0.8
    closeOuterGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    closeOuterGlow.Parent = closeButton
    local closeBorder = Instance.new("UIStroke")
    closeBorder.Thickness = 1
    closeBorder.Color = Color3.fromRGB(120, 140, 180)
    closeBorder.Transparency = 0.4
    closeBorder.Parent = closeButton
    local innerShadow = Instance.new("Frame")
    innerShadow.Size = UDim2.new(1, -4, 1, -4)
    innerShadow.Position = UDim2.new(0, 2, 0, 2)
    innerShadow.BackgroundTransparency = 1
    innerShadow.ZIndex = 6
    innerShadow.Parent = closeButton

    local innerShadowStroke = Instance.new("UIStroke")
    innerShadowStroke.Thickness = 1
    innerShadowStroke.Color = Color3.fromRGB(0, 0, 0)
    innerShadowStroke.Transparency = 0.6
    innerShadowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    innerShadowStroke.Parent = innerShadow

    local innerShadowCorner = Instance.new("UICorner")
    innerShadowCorner.CornerRadius = UDim.new(0, 10)
    innerShadowCorner.Parent = innerShadow
    local xIcon1 = Instance.new("Frame")
    xIcon1.Size = UDim2.new(0, 14, 0, 2)
    xIcon1.Position = UDim2.new(0.5, -7, 0.5, -1)
    xIcon1.BackgroundColor3 = Color3.fromRGB(220, 230, 250)
    xIcon1.BorderSizePixel = 0
    xIcon1.Rotation = 45
    xIcon1.ZIndex = 7
    xIcon1.Parent = closeButton

    local xCorner1 = Instance.new("UICorner")
    xCorner1.CornerRadius = UDim.new(0, 1)
    xCorner1.Parent = xIcon1
    local xGlow1 = Instance.new("UIStroke")
    xGlow1.Thickness = 1
    xGlow1.Color = Color3.fromRGB(255, 255, 255)
    xGlow1.Transparency = 0.7
    xGlow1.Parent = xIcon1

    local xIcon2 = Instance.new("Frame")
    xIcon2.Size = UDim2.new(0, 14, 0, 2)
    xIcon2.Position = UDim2.new(0.5, -7, 0.5, -1)
    xIcon2.BackgroundColor3 = Color3.fromRGB(220, 230, 250)
    xIcon2.BorderSizePixel = 0
    xIcon2.Rotation = -45
    xIcon2.ZIndex = 7
    xIcon2.Parent = closeButton

    local xCorner2 = Instance.new("UICorner")
    xCorner2.CornerRadius = UDim.new(0, 1)
    xCorner2.Parent = xIcon2
    local xGlow2 = Instance.new("UIStroke")
    xGlow2.Thickness = 1
    xGlow2.Color = Color3.fromRGB(255, 255, 255)
    xGlow2.Transparency = 0.7
    xGlow2.Parent = xIcon2
    local isPressed = false

    local function handleButtonPress()
        isPressed = true
        local pressInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local pressedSize = IsMobile() and UDim2.new(0, 28, 0, 28) or UDim2.new(0, 32, 0, 32)
        local pressedPos = IsMobile() and UDim2.new(1, -39, 0, 9) or UDim2.new(1, -43.5, 0, 11.5)
        TweenService:Create(closeButton, pressInfo, {
            Size = pressedSize,
            Position = pressedPos
        }):Play()
    end

    local function handleButtonRelease()
        if isPressed then
            isPressed = false
            local releaseInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local normalSize = IsMobile() and UDim2.new(0, 30, 0, 30) or UDim2.new(0, 35, 0, 35)
            local normalPos = IsMobile() and UDim2.new(1, -40, 0, 8) or UDim2.new(1, -45, 0, 10)
            TweenService:Create(closeButton, releaseInfo, {
                Size = normalSize,
                Position = normalPos
            }):Play()
        end
    end


    closeButton.MouseButton1Down:Connect(handleButtonPress)
    closeButton.MouseButton1Up:Connect(handleButtonRelease)


    closeButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            handleButtonPress()
        end
    end)

    closeButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            handleButtonRelease()
        end
    end)
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, -20, 0, IsMobile() and 60 or 50)
    buttonContainer.Position = UDim2.new(0, 10, 0, 65)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.ZIndex = 4
    buttonContainer.Parent = mainContainer

    local buttonNames = {"更新公告", "游戏列表", "开发人员"}
    local buttons = {}
    local currentPage = "游戏列表"

    for i, buttonName in ipairs(buttonNames) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.32, -5, 1, 0)
        button.Position = UDim2.new((i-1) * 0.34, 0, 0, 0)
        button.BackgroundColor3 = buttonName == "游戏列表" and Color3.fromRGB(70, 130, 210) or Color3.fromRGB(30, 40, 60)
        button.Text = buttonName
        button.TextColor3 = buttonName == "游戏列表" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 255, 255)
        button.TextSize = IsMobile() and 14 or 18
        button.Font = Enum.Font.GothamBold
        button.TextStrokeTransparency = 0.3
        button.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        button.BorderSizePixel = 0
        button.ZIndex = 5
        button.Parent = buttonContainer

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 15)
        corner.Parent = button

        local gradient = Instance.new("UIGradient")
        if buttonName == "游戏列表" then
            gradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 150, 230)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(70, 130, 210)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 120, 200))
            }
        else
            gradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 50, 70)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 40, 60)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 55))
            }
        end
        gradient.Rotation = 90
        gradient.Parent = button

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 2
        stroke.Color = buttonName == "游戏列表" and Color3.fromRGB(120, 180, 255) or Color3.fromRGB(70, 90, 120)
        stroke.Transparency = 0.3
        stroke.Parent = button
        local innerShadow = Instance.new("Frame")
        innerShadow.Size = UDim2.new(1, -4, 1, -4)
        innerShadow.Position = UDim2.new(0, 2, 0, 2)
        innerShadow.BackgroundTransparency = 1
        innerShadow.ZIndex = 6
        innerShadow.Parent = button

        local innerStroke = Instance.new("UIStroke")
        innerStroke.Thickness = 1
        innerStroke.Color = Color3.fromRGB(255, 255, 255)
        innerStroke.Transparency = buttonName == "游戏列表" and 0.7 or 0.9
        innerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        innerStroke.Parent = innerShadow

        local innerCorner = Instance.new("UICorner")
        innerCorner.CornerRadius = UDim.new(0, 13)
        innerCorner.Parent = innerShadow

        buttons[buttonName] = {button = button, gradient = gradient, stroke = stroke, innerStroke = innerStroke}
    end

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -85)
    contentFrame.Position = UDim2.new(0, 10, 0, 75)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ZIndex = 4
    contentFrame.Parent = mainContainer

    local welcomeText = Instance.new("TextLabel")
    welcomeText.Size = UDim2.new(1, 0, 0, 50)
    welcomeText.Position = UDim2.new(0, 0, 0, 10)
    welcomeText.BackgroundTransparency = 1
    welcomeText.Text = ""
    welcomeText.TextColor3 = Color3.fromRGB(140, 200, 255)
    welcomeText.TextSize = 28
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.TextXAlignment = Enum.TextXAlignment.Center
    welcomeText.ZIndex = 5
    welcomeText.Parent = contentFrame

    local welcomeTextGradient = Instance.new("UIGradient")
    welcomeTextGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 210, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 180, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 150, 255))
    }
    welcomeTextGradient.Parent = welcomeText
    local textShadow = Instance.new("TextLabel")
    textShadow.Size = welcomeText.Size
    textShadow.Position = UDim2.new(0, 2, 0, 12)
    textShadow.BackgroundTransparency = 1
    textShadow.Text = welcomeText.Text
    textShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
    textShadow.TextTransparency = 0.7
    textShadow.TextSize = welcomeText.TextSize
    textShadow.Font = welcomeText.Font
    textShadow.TextXAlignment = welcomeText.TextXAlignment
    textShadow.ZIndex = 4
    textShadow.Parent = contentFrame

    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 0, 35)
    statusText.Position = UDim2.new(0, 0, 0, 65)
    statusText.BackgroundTransparency = 1
    statusText.Text = ""
    statusText.TextColor3 = Color3.fromRGB(180, 220, 190)
    statusText.TextSize = 18
    statusText.Font = Enum.Font.GothamMedium
    statusText.TextXAlignment = Enum.TextXAlignment.Center
    statusText.ZIndex = 5
    statusText.Parent = contentFrame

    local statusGradient = Instance.new("UIGradient")
    statusGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 240, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 200, 160))
    }
    statusGradient.Parent = statusText
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -10, 1, -80)
    scrollFrame.Position = UDim2.new(0, 10, 0, 75)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 40)
    scrollFrame.BackgroundTransparency = 0.2
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = IsMobile() and 15 or 10
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 180, 255)
    scrollFrame.ZIndex = 5
    scrollFrame.Parent = contentFrame

    local scrollCorner = Instance.new("UICorner")
    scrollCorner.CornerRadius = UDim.new(0, 15)
    scrollCorner.Parent = scrollFrame
    local scrollStroke = Instance.new("UIStroke")
    scrollStroke.Thickness = 2
    scrollStroke.Color = Color3.fromRGB(60, 80, 120)
    scrollStroke.Transparency = 0.4
    scrollStroke.Parent = scrollFrame
    local scrollShadow = Instance.new("UIStroke")
    scrollShadow.Thickness = 1
    scrollShadow.Color = Color3.fromRGB(0, 0, 0)
    scrollShadow.Transparency = 0.7
    scrollShadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    scrollShadow.Parent = scrollFrame
    local scrollGradient = Instance.new("UIGradient")
    scrollGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 28, 50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 20, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 25, 45))
    }
    scrollGradient.Rotation = 90
    scrollGradient.Parent = scrollFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = scrollFrame

    local listPadding = Instance.new("UIPadding")
    listPadding.PaddingTop = UDim.new(0, 10)
    listPadding.PaddingBottom = UDim.new(0, 10)
    listPadding.PaddingLeft = UDim.new(0, 10)
    listPadding.PaddingRight = UDim.new(0, 10)
    listPadding.Parent = scrollFrame
    for i, game in ipairs(list_game) do
        local gameItem = Instance.new("Frame")
        gameItem.Size = IsMobile() and UDim2.new(1, -20, 0, 40) or UDim2.new(1, -20, 0, 45)
        gameItem.BackgroundColor3 = Color3.fromRGB(28, 38, 60)
        gameItem.BackgroundTransparency = 0.1
        gameItem.BorderSizePixel = 0
        gameItem.ZIndex = 6
        gameItem.Parent = scrollFrame

        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 12)
        itemCorner.Parent = gameItem
        local itemGradient = Instance.new("UIGradient")
        itemGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 45, 70)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(28, 38, 60)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 42, 65))
        }
        itemGradient.Rotation = 90
        itemGradient.Parent = gameItem
        local itemStroke = Instance.new("UIStroke")
        itemStroke.Thickness = 1
        itemStroke.Color = Color3.fromRGB(80, 120, 200)
        itemStroke.Transparency = 0.6
        itemStroke.Parent = gameItem
        local itemShadow = Instance.new("UIStroke")
        itemShadow.Thickness = 1
        itemShadow.Color = Color3.fromRGB(0, 0, 0)
        itemShadow.Transparency = 0.8
        itemShadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        itemShadow.Parent = gameItem
        local gameIcon = Instance.new("Frame")
        gameIcon.Size = UDim2.new(0, 8, 0, 8)
        gameIcon.Position = UDim2.new(0, 20, 0.5, -4)
        gameIcon.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        gameIcon.BorderSizePixel = 0
        gameIcon.ZIndex = 7
        gameIcon.Parent = gameItem

        local iconCorner = Instance.new("UICorner")
        iconCorner.CornerRadius = UDim.new(0.5, 0)
        iconCorner.Parent = gameIcon

        local gameButton = Instance.new("TextButton")
        gameButton.Size = UDim2.new(1, -50, 1, 0)
        gameButton.Position = UDim2.new(0, 40, 0, 0)
        gameButton.BackgroundTransparency = 1
        gameButton.TextTransparency = 1
        gameButton.Text = game
        gameButton.TextColor3 = Color3.fromRGB(230, 245, 255)
        gameButton.TextSize = IsMobile() and 14 or 16
        gameButton.Font = Enum.Font.GothamMedium
        gameButton.TextXAlignment = Enum.TextXAlignment.Left
        gameButton.ZIndex = 7
        gameButton.Parent = gameItem
        local statusDot = Instance.new("Frame")
        statusDot.Size = UDim2.new(0, 8, 0, 8)
        statusDot.Position = UDim2.new(1, -20, 0.5, -4)
        statusDot.BackgroundColor3 = Color3.fromRGB(100, 255, 150)
        statusDot.BorderSizePixel = 0
        statusDot.ZIndex = 7
        statusDot.Parent = gameItem

        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(0.5, 0)
        dotCorner.Parent = statusDot
        local dotGlow = Instance.new("UIStroke")
        dotGlow.Thickness = 2
        dotGlow.Color = Color3.fromRGB(100, 255, 150)
        dotGlow.Transparency = 0.5
        dotGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        dotGlow.Parent = statusDot

        gameButton.Activated:Connect(function()
            local closeInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            local scaleTween = TweenService:Create(mainContainer, closeInfo, {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            })
            local backgroundTween = TweenService:Create(background, closeInfo, {
                BackgroundTransparency = 1
            })
            scaleTween:Play()
            backgroundTween:Play()
            scaleTween.Completed:Connect(function()
                if screenGui and screenGui.Parent then
                    screenGui:Destroy()
                end
            end)
            spawn(function()
                wait(0.5)
                if screenGui and screenGui.Parent then
                    screenGui:Destroy()
                end
            end)
            loadstring(GetAsset('https://api.github.com/repos/123fa98/Xi_Pro/contents/'..gameButton.Text..".lua"))()
        end)


        local function handleHover()
            local hoverInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(gameItem, hoverInfo, {
                BackgroundColor3 = Color3.fromRGB(40, 55, 85)
            }):Play()
            TweenService:Create(itemStroke, hoverInfo, {
                Transparency = 0.2,
                Color = Color3.fromRGB(120, 180, 255),
                Thickness = 2
            }):Play()
            TweenService:Create(gameButton, hoverInfo, {
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        end

        local function handleLeave()
            local leaveInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(gameItem, leaveInfo, {
                BackgroundColor3 = Color3.fromRGB(28, 38, 60)
            }):Play()
            TweenService:Create(itemStroke, leaveInfo, {
                Transparency = 0.6,
                Color = Color3.fromRGB(80, 120, 200),
                Thickness = 1
            }):Play()
            TweenService:Create(gameButton, leaveInfo, {
                TextColor3 = Color3.fromRGB(220, 240, 255)
            }):Play()
        end


        if not IsMobile() then
            gameItem.MouseEnter:Connect(handleHover)
            gameItem.MouseLeave:Connect(handleLeave)
        end


        if IsMobile() then
            gameButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    handleHover()
                end
            end)
            gameButton.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    spawn(function()
                        wait(0.1)
                        handleLeave()
                    end)
                end
            end)
        end
    end

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)

    spawn(function()
        titleBar.BackgroundTransparency = 1
        titleLabel.TextTransparency = 1
        closeButton.BackgroundTransparency = 1
        closeButton.TextTransparency = 1
        welcomeText.TextTransparency = 1
        statusText.TextTransparency = 1
        scrollFrame.BackgroundTransparency = 1

        for _, child in ipairs(scrollFrame:GetChildren()) do
            if child:IsA("Frame") and child:FindFirstChild("TextButton") then
                child.BackgroundTransparency = 1
                child:FindFirstChild("TextButton").TextTransparency = 1
            end
        end

        spawn(function()
            wait(0.1)
            local fastFadeInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(titleBar, fastFadeInfo, {BackgroundTransparency = 0}):Play()
            TweenService:Create(titleLabel, fastFadeInfo, {TextTransparency = 0}):Play()
            TweenService:Create(closeButton, fastFadeInfo, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
            wait(0.1)
            TweenService:Create(welcomeText, fastFadeInfo, {TextTransparency = 0}):Play()
            TweenService:Create(statusText, fastFadeInfo, {TextTransparency = 0}):Play()
            TweenService:Create(scrollFrame, fastFadeInfo, {BackgroundTransparency = 0.2}):Play()

            wait(0.15)
            for i, child in ipairs(scrollFrame:GetChildren()) do
                if child:IsA("Frame") and child:FindFirstChild("TextButton") then
                    spawn(function()
                        wait(i * 0.03)
                        local itemFadeInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        TweenService:Create(child, itemFadeInfo, {BackgroundTransparency = 0.1}):Play()
                        TweenService:Create(child:FindFirstChild("TextButton"), itemFadeInfo, {TextTransparency = 0}):Play()
                    end)
                end
            end
        end)
    end)

    local function handleCloseClick()
        local closeInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        local scaleTween = TweenService:Create(mainContainer, closeInfo, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        local backgroundTween = TweenService:Create(background, closeInfo, {
            BackgroundTransparency = 1
        })
        scaleTween:Play()
        backgroundTween:Play()
        scaleTween.Completed:Connect(function()
            if screenGui and screenGui.Parent then
                screenGui:Destroy()
            end
        end)
        spawn(function()
            wait(0.5)
            if screenGui and screenGui.Parent then
                screenGui:Destroy()
            end
        end)
    end

    closeButton.MouseButton1Click:Connect(handleCloseClick)
    closeButton.Activated:Connect(handleCloseClick)


    if not IsMobile() then
        closeButton.MouseEnter:Connect(function()
            local hoverInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(closeButton, hoverInfo, {
                BackgroundColor3 = Color3.fromRGB(220, 60, 60)
            }):Play()
            TweenService:Create(closeGradient, hoverInfo, {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 80)),
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(220, 60, 60)),
                    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(200, 50, 50)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 70, 70))
                }
            }):Play()
            TweenService:Create(closeOuterGlow, hoverInfo, {
                Color = Color3.fromRGB(255, 100, 100),
                Transparency = 0.3,
                Thickness = 5
            }):Play()
            TweenService:Create(closeBorder, hoverInfo, {
                Color = Color3.fromRGB(255, 150, 150),
                Transparency = 0.1
            }):Play()
            TweenService:Create(xIcon1, hoverInfo, {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.new(0, 16, 0, 2.5)
            }):Play()
            TweenService:Create(xIcon2, hoverInfo, {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.new(0, 16, 0, 2.5)
            }):Play()
            TweenService:Create(xGlow1, hoverInfo, {
                Transparency = 0.3
            }):Play()
            TweenService:Create(xGlow2, hoverInfo, {
                Transparency = 0.3
            }):Play()
        end)

        closeButton.MouseLeave:Connect(function()
            local leaveInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(closeButton, leaveInfo, {
                BackgroundColor3 = Color3.fromRGB(45, 55, 75)
            }):Play()
            TweenService:Create(closeGradient, leaveInfo, {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 65, 85)),
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(45, 55, 75)),
                    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(40, 50, 70)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 60, 80))
                }
            }):Play()
            TweenService:Create(closeOuterGlow, leaveInfo, {
                Color = Color3.fromRGB(80, 120, 200),
                Transparency = 0.8,
                Thickness = 3
            }):Play()
            TweenService:Create(closeBorder, leaveInfo, {
                Color = Color3.fromRGB(120, 140, 180),
                Transparency = 0.4
            }):Play()
            TweenService:Create(xIcon1, leaveInfo, {
                BackgroundColor3 = Color3.fromRGB(220, 230, 250),
                Size = UDim2.new(0, 14, 0, 2)
            }):Play()
            TweenService:Create(xIcon2, leaveInfo, {
                BackgroundColor3 = Color3.fromRGB(220, 230, 250),
                Size = UDim2.new(0, 14, 0, 2)
            }):Play()
            TweenService:Create(xGlow1, leaveInfo, {
                Transparency = 0.7
            }):Play()
            TweenService:Create(xGlow2, leaveInfo, {
                Transparency = 0.7
            }):Play()
        end)
    end
    local function switchPage(pageName)
        currentPage = pageName

        for name, buttonData in pairs(buttons) do
            local isActive = (name == pageName)
            local button = buttonData.button
            local gradient = buttonData.gradient
            local stroke = buttonData.stroke
            local innerStroke = buttonData.innerStroke

            TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = isActive and Color3.fromRGB(70, 130, 210) or Color3.fromRGB(30, 40, 60),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()

            TweenService:Create(stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Color = isActive and Color3.fromRGB(120, 180, 255) or Color3.fromRGB(70, 90, 120),
                Transparency = isActive and 0.2 or 0.4
            }):Play()

            TweenService:Create(innerStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = isActive and 0.7 or 0.9
            }):Play()

            if isActive then
                gradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 150, 230)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(70, 130, 210)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 120, 200))
                }
            else
                gradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 50, 70)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 40, 60)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 55))
                }
            end
        end
        local announcementContainer = contentFrame:FindFirstChild("AnnouncementContainer")
        local developerText = contentFrame:FindFirstChild("DeveloperText")
        if announcementContainer then announcementContainer.Visible = false end
        if developerText then developerText.Visible = false end
        if pageName == "游戏列表" then

            local defaultSize = GetGameListSize()
            local defaultPosition = UDim2.new(0.5, -defaultSize.X.Offset/2, 0.5, -defaultSize.Y.Offset/2)

            mainContainer:TweenSize(defaultSize, "Out", "Quad", 0.3, true)
            mainContainer:TweenPosition(defaultPosition, "Out", "Quad", 0.3, true)

            welcomeText.Text = ""
            statusText.Text = ""
            scrollFrame.Visible = true
        elseif pageName == "更新公告" then

            local defaultSize = GetGameListSize()
            local defaultPosition = UDim2.new(0.5, -defaultSize.X.Offset/2, 0.5, -defaultSize.Y.Offset/2)

            mainContainer:TweenSize(defaultSize, "Out", "Quad", 0.3, true)
            mainContainer:TweenPosition(defaultPosition, "Out", "Quad", 0.3, true)

            welcomeText.Text = ""
            statusText.Text = ""
            scrollFrame.Visible = false
            if not announcementContainer then
                local updateConfig = {
                    updateItems = {
                        {date = "2025-08-05", desc = "脚本发布！支持9款热门游戏，界面全新升级。"},
                        {date = "2025-08-04", desc = "增加了新的UI界面和数字效果，提升用户体验。"},
                        {date = "2025-08-03", desc = "修复了在'最强战场'中一个导致自动停止的bug。"},
                        {date = "2025-08-01", desc = "内部测试版本v0.1启动，感谢早期测试人员。"}
                    }
                }
                local announcementContainer = Instance.new("ScrollingFrame")
                announcementContainer.Name = "AnnouncementContainer"
                announcementContainer.Size = UDim2.new(1, -30, 1, -80)
                announcementContainer.Position = UDim2.new(0, 15, 0, 65)
                announcementContainer.BackgroundTransparency = 1
                announcementContainer.BorderSizePixel = 0
                announcementContainer.ScrollBarThickness = 6
                announcementContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
                announcementContainer.ZIndex = 5
                announcementContainer.Parent = contentFrame
                local startY = 5
                local itemHeight = 75
                local itemSpacing = 8
                local totalHeight = startY + #updateConfig.updateItems * (itemHeight + itemSpacing)
                local timelineLine = Instance.new("Frame")
                timelineLine.Size = UDim2.new(0, 3, 0, totalHeight - 20)
                timelineLine.Position = UDim2.new(0, 20, 0, startY + 10)
                timelineLine.BackgroundColor3 = Color3.fromRGB(70, 120, 255)
                timelineLine.BorderSizePixel = 0
                timelineLine.ZIndex = 4
                timelineLine.Parent = announcementContainer
                local lineGradient = Instance.new("UIGradient")
                lineGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 120, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 80, 180))
                }
                lineGradient.Rotation = 90
                lineGradient.Parent = timelineLine

                for i, item in ipairs(updateConfig.updateItems) do
                    local yPos = startY + (i-1) * (itemHeight + itemSpacing)
                    local timelineNode = Instance.new("Frame")
                    timelineNode.Size = UDim2.new(0, 14, 0, 14)
                    timelineNode.Position = UDim2.new(0, 14, 0, yPos + 25)
                    timelineNode.BackgroundColor3 = Color3.fromRGB(70, 120, 255)
                    timelineNode.BorderSizePixel = 0
                    timelineNode.ZIndex = 5
                    timelineNode.Parent = announcementContainer

                    local nodeCorner = Instance.new("UICorner")
                    nodeCorner.CornerRadius = UDim.new(0.5, 0)
                    nodeCorner.Parent = timelineNode
                    local nodeInner = Instance.new("Frame")
                    nodeInner.Size = UDim2.new(0, 6, 0, 6)
                    nodeInner.Position = UDim2.new(0.5, -3, 0.5, -3)
                    nodeInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    nodeInner.BorderSizePixel = 0
                    nodeInner.ZIndex = 6
                    nodeInner.Parent = timelineNode

                    local innerCorner = Instance.new("UICorner")
                    innerCorner.CornerRadius = UDim.new(0.5, 0)
                    innerCorner.Parent = nodeInner

                    local contentFrame = Instance.new("Frame")
                    contentFrame.Size = UDim2.new(1, -50, 0, itemHeight)
                    contentFrame.Position = UDim2.new(0, 40, 0, yPos)
                    contentFrame.BackgroundColor3 = Color3.fromRGB(25, 35, 50)
                    contentFrame.BackgroundTransparency = 0.3
                    contentFrame.BorderSizePixel = 0
                    contentFrame.ZIndex = 6
                    contentFrame.Parent = announcementContainer

                    local contentCorner = Instance.new("UICorner")
                    contentCorner.CornerRadius = UDim.new(0, 8)
                    contentCorner.Parent = contentFrame

                    local dateLabel = Instance.new("TextLabel")
                    dateLabel.Size = UDim2.new(1, -20, 0, 22)
                    dateLabel.Position = UDim2.new(0, 10, 0, 8)
                    dateLabel.BackgroundTransparency = 1
                    dateLabel.Text = item.date
                    dateLabel.TextColor3 = Color3.fromRGB(70, 120, 255)
                    dateLabel.TextSize = 16
                    dateLabel.Font = Enum.Font.GothamBold
                    dateLabel.TextXAlignment = Enum.TextXAlignment.Left
                    dateLabel.ZIndex = 7
                    dateLabel.Parent = contentFrame

                    local descLabel = Instance.new("TextLabel")
                    descLabel.Size = UDim2.new(1, -20, 1, -35)
                    descLabel.Position = UDim2.new(0, 10, 0, 28)
                    descLabel.BackgroundTransparency = 1
                    descLabel.Text = item.desc
                    descLabel.TextColor3 = Color3.fromRGB(200, 220, 240)
                    descLabel.TextSize = 14
                    descLabel.Font = Enum.Font.Gotham
                    descLabel.TextXAlignment = Enum.TextXAlignment.Left
                    descLabel.TextYAlignment = Enum.TextYAlignment.Top
                    descLabel.TextWrapped = true
                    descLabel.ZIndex = 7
                    descLabel.Parent = contentFrame
                end
                local totalHeight = startY + #updateConfig.updateItems * (itemHeight + itemSpacing) + 40
                announcementContainer.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
            end
            announcementContainer.Visible = true
        elseif pageName == "开发人员" then
            local newSize = GetDeveloperPageSize()
            local newPosition = UDim2.new(0.5, -newSize.X.Offset/2, 0.5, -newSize.Y.Offset/2)

            mainContainer:TweenSize(newSize, "Out", "Quad", 0.3, true)
            mainContainer:TweenPosition(newPosition, "Out", "Quad", 0.3, true)

            welcomeText.Text = ""
            statusText.Text = ""
            scrollFrame.Visible = false
            if not developerText then
                developerText = Instance.new("ScrollingFrame")
                developerText.Name = "DeveloperText"
                developerText.Size = UDim2.new(1, -30, 1, -100)
                developerText.Position = UDim2.new(0, 15, 0, 85)
                developerText.BackgroundTransparency = 1
                developerText.BorderSizePixel = 0
                developerText.ScrollBarThickness = IsMobile() and 12 or 6
                developerText.ScrollBarImageColor3 = Color3.fromRGB(70, 120, 255)
                developerText.ZIndex = 5
                developerText.Parent = contentFrame

                local developers = {
                    {name = "神仇", role = "主作者", desc = "项目负责人 · 核心架构", color = Color3.fromRGB(255, 100, 100)},
                    {name = "鲨蛋", role = "副作者", desc = "功能开发 · 代码优化", color = Color3.fromRGB(100, 255, 100)},
                    {name = "泡芙", role = "UI制作者", desc = "界面设计 · 用户体验", color = Color3.fromRGB(255, 200, 100)},
                    {name = "Irena", role = "剪辑师", desc = "视频制作 · 宣传内容", color = Color3.fromRGB(255, 100, 255)},
                    {name = "du8", role = "备用作者", desc = "代码维护 · 功能补充", color = Color3.fromRGB(100, 200, 255)},
                    {name = "qumu", role = "白名单制作者", desc = "安全系统 · 权限管理", color = Color3.fromRGB(200, 255, 100)},
                    {name = "小天", role = "黑客", desc = "技术研究 · 安全测试", color = Color3.fromRGB(255, 150, 200)}
                }

                local cardHeight = IsMobile() and 90 or 120
                local cardSpacing = IsMobile() and 20 or 25
                local columnsCount = IsMobile() and 1 or 2
                local cardWidth = (1 / columnsCount) - 0.02 
                local rowsCount = math.ceil(#developers / columnsCount)
                local totalHeight = rowsCount * (cardHeight + cardSpacing) + 30

                developerText.CanvasSize = UDim2.new(0, 0, 0, totalHeight)

                for i, dev in ipairs(developers) do
                    local column = (i - 1) % columnsCount
                    local row = math.floor((i - 1) / columnsCount)
                    local xPos = column * (cardWidth + 0.02)
                    local yPos = row * (cardHeight + cardSpacing) + 10

                    local card = Instance.new("Frame")
                    card.Size = UDim2.new(cardWidth, 0, 0, cardHeight)
                    card.Position = UDim2.new(xPos, 10, 0, yPos)
                    card.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
                    card.BorderSizePixel = 0
                    card.ZIndex = 6
                    card.Parent = developerText

                    local cardCorner = Instance.new("UICorner")
                    cardCorner.CornerRadius = UDim.new(0, 10)
                    cardCorner.Parent = card

                    local colorBar = Instance.new("Frame")
                    colorBar.Size = UDim2.new(0, 4, 1, 0)
                    colorBar.Position = UDim2.new(0, 0, 0, 0)
                    colorBar.BackgroundColor3 = dev.color
                    colorBar.BorderSizePixel = 0
                    colorBar.ZIndex = 7
                    colorBar.Parent = card

                    local barCorner = Instance.new("UICorner")
                    barCorner.CornerRadius = UDim.new(0, 10)
                    barCorner.Parent = colorBar

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, -20, 0, 32)
                    nameLabel.Position = UDim2.new(0, 15, 0, 8)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = dev.name
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.TextSize = IsMobile() and 18 or 22
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                    nameLabel.ZIndex = 7
                    nameLabel.Parent = card

                    local roleLabel = Instance.new("TextLabel")
                    roleLabel.Size = UDim2.new(1, -20, 0, 26)
                    roleLabel.Position = UDim2.new(0, 15, 0, 38)
                    roleLabel.BackgroundTransparency = 1
                    roleLabel.Text = dev.role
                    roleLabel.TextColor3 = dev.color
                    roleLabel.TextSize = IsMobile() and 14 or 18
                    roleLabel.Font = Enum.Font.GothamMedium
                    roleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    roleLabel.ZIndex = 7
                    roleLabel.Parent = card

                    local descLabel = Instance.new("TextLabel")
                    descLabel.Size = UDim2.new(1, -20, 0, 28)
                    descLabel.Position = UDim2.new(0, 15, 0, 64)
                    descLabel.BackgroundTransparency = 1
                    descLabel.Text = dev.desc
                    descLabel.TextColor3 = Color3.fromRGB(200, 210, 220)
                    descLabel.TextSize = IsMobile() and 12 or 16
                    descLabel.Font = Enum.Font.Gotham
                    descLabel.TextXAlignment = Enum.TextXAlignment.Left
                    descLabel.ZIndex = 7
                    descLabel.Parent = card
                end
            end
            developerText.Visible = true
        end
    end

    for buttonName, buttonData in pairs(buttons) do
        buttonData.button.MouseButton1Click:Connect(function()
            switchPage(buttonName)
        end)
        buttonData.button.Activated:Connect(function()
            switchPage(buttonName)
        end)


        if not IsMobile() then
            buttonData.button.MouseEnter:Connect(function()
                if currentPage ~= buttonName then
                    local hoverInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(buttonData.button, hoverInfo, {
                        BackgroundColor3 = Color3.fromRGB(55, 75, 105),
                        TextColor3 = Color3.fromRGB(255, 255, 255)
                    }):Play()
                    TweenService:Create(buttonData.stroke, hoverInfo, {
                        Color = Color3.fromRGB(100, 140, 200),
                        Transparency = 0.2
                    }):Play()
                    TweenService:Create(buttonData.innerStroke, hoverInfo, {
                        Transparency = 0.6
                    }):Play()
                    buttonData.gradient.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(65, 85, 115)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(55, 75, 105)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 70, 100))
                    }
                end
            end)

            buttonData.button.MouseLeave:Connect(function()
                if currentPage ~= buttonName then
                    local leaveInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(buttonData.button, leaveInfo, {
                        BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                        TextColor3 = Color3.fromRGB(255, 255, 255)
                    }):Play()
                    TweenService:Create(buttonData.stroke, leaveInfo, {
                        Color = Color3.fromRGB(70, 90, 120),
                        Transparency = 0.3
                    }):Play()
                    TweenService:Create(buttonData.innerStroke, leaveInfo, {
                        Transparency = 0.9
                    }):Play()
                    buttonData.gradient.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 50, 70)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 40, 60)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 55))
                    }
                end
            end)
        end
    end


    spawn(function()
        wait(0.2)
        local finalSize = GetGameListSize()
        local finalPosition = UDim2.new(0.5, -finalSize.X.Offset/2, 0.5, -finalSize.Y.Offset/2)
        mainContainer.Size = finalSize
        mainContainer.Position = finalPosition
    end)

    print(" Xi Pro 游戏列表已显示")
    print(" 支持 " .. #list_game .. " 个游戏")
end

function CreateSupportList(list_game)
    showLoadingAnimation(function(screenGui, mainContainer, background)
        showGameList(screenGui, mainContainer, background, list_game)
    end)
end

local name = {
    "最强战场",
    "Blox Fruit",
    "疯狂之城",
    "忍者传奇",
    "俄亥俄州",
    "刀刃球",
    "战争大亨",
    "Fisch",
    "Doors",
}


local lastScreenWidth, lastScreenHeight = GetScreenSize()
local lastOrientation = lastScreenWidth > lastScreenHeight and "Landscape" or "Portrait"

RunService.Heartbeat:Connect(function()
    local currentWidth, currentHeight = GetScreenSize()
    local currentOrientation = currentWidth > currentHeight and "Landscape" or "Portrait"


    if math.abs(currentWidth - lastScreenWidth) > 50 or
       math.abs(currentHeight - lastScreenHeight) > 50 or
       currentOrientation ~= lastOrientation then

        lastScreenWidth, lastScreenHeight = currentWidth, currentHeight
        lastOrientation = currentOrientation


        local existingGui = player.PlayerGui:FindFirstChild("XiProGameList")
        if existingGui then
            local mainContainer = existingGui:FindFirstChild("MainContainer")
            if mainContainer then

                local newSize = GetGameListSize()


                local contentFrame = existingGui:FindFirstChild("ContentFrame")
                if contentFrame then
                    local developerText = contentFrame:FindFirstChild("DeveloperText")
                    if developerText and developerText.Visible then
                        newSize = GetDeveloperPageSize()
                    end
                end

                local newPosition = UDim2.new(0.5, -newSize.X.Offset/2, 0.5, -newSize.Y.Offset/2)


                local animationTime = currentOrientation ~= lastOrientation and 0.5 or 0.3
                mainContainer:TweenSize(newSize, "Out", "Quart", animationTime, true)
                mainContainer:TweenPosition(newPosition, "Out", "Quart", animationTime, true)


                if IsMobile() and currentOrientation ~= lastOrientation then
                    local scrollFrame = mainContainer:FindFirstChild("ContentFrame"):FindFirstChild("ScrollingFrame")
                    if scrollFrame then
                        scrollFrame.ScrollBarThickness = 15
                    end
                end
            end
        end
    end
end)

CreateSupportList(name)