local Translations = {
["Azure Hub丨Ink Game"] = "墨水",
    ["Xenoz"] = "早川秋汉化,倒卖的我拿筷子塞你妈逼里",
    ["RedLightGreenLight"] = "123木头人",
    ["Dalgona"] = "糖饼",
    ["Light Off"] = "晚上熄灯",
    ["Hide And Seek"] = "捉迷藏",
    ["Tug Of War"] = "拔河",
    ["Rope Game"] = "跳绳",
    ["Glass Bridge"] = "玻璃桥",
    ["Mingle"] = "自动按QTE",
    ["Remove Red Door"] = "无敌模式",
    ["Tp To End"] = "传送终点",
    ["Open Azure Hub"] = "打开脚本",
    ["God Mode"] = "糖饼不破损",
    ["Finish Shape"] = "完成糖饼",
    ["Player"] = "玩家功能",
    ["ESP"] = "玩家绘制",
    ["Auto Power Hold"] = "自动锁喉",
    ["Teleport To End"] = "送达终点",
    ["Cancel"] = "取消",
    ["Close Window"] = "确认退出",
    ["Show Correct Path"] = "可能是防坠落可能是透视玻璃",
    ["Anti lnjury"] = "免除将械伤害",
    ["Jump Higher ( 50 = default)"] = "跳跃高度默认50",
    ["Run Faster"] = "跑得更快",
    ["Anti Fling"] = "反淡水",
    ["Anti Ragdoll"] = "防抗",
    ["Anti Stun"] = "防眩晕",
    ["Unlock PhantomStep"] = "解锁能力",
    ["Be Able To Run"] = "不知道什么意思",
    ["Delete Rope"] = "删除绳子",
    ["Auto Pull Rope"] = "自动拉绳",
    ["Teleport To Exit Door"] = "远程传送逃生门",
    ["Follow Closest Hider"] = "远程自动杀死躲藏者",
    ["Save Position"] = "保存位置",
    ["Teleport To Saved Position"] = "自动传送安全区",
    ["Teleport Inside Pig"] = "不知道什么意思",
    ["Anti Injury"] = "防损伤",
    ["Unlock Dash & Speed"] = "解锁冲刺",
    ["Help Random"] = "随机帮助他人",
    ["Troll Random"] = "随机带回人到起点",
}

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if Translations[text] then
        return Translations[text]
    end
    
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        warn("元表劫持失败:", err)
       
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
            
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                            if text and text ~= "" then
                                local translatedText = translateText(text)
                                if translatedText ~= text then
                                    gui.Text = translatedText
                                    translated[gui] = true
                                end
                            end
                        end)
                    end
                end
            end
        end
        
        local function setupDescendantListener(parent)
            parent.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                    task.wait(0.1)
                    pcall(function()
                        local text = descendant.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                descendant.Text = translatedText
                            end
                        end
                    end)
                end
            end)
        end
        
        pcall(setupDescendantListener, game:GetService("CoreGui"))
        local player = game:GetService("Players").LocalPlayer
        if player and player:FindFirstChild("PlayerGui") then
            pcall(setupDescendantListener, player.PlayerGui)
        end
        
        while true do
            scanAndTranslate()
            task.wait(3)
        end
    end
end

task.wait(2)

setupTranslationEngine()

local success, err = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ScripterVaz/InkGameAzure/main/Protected_7974105512464815.lua.txt"))()


end)

if not success then
    warn("加载失败:", err)
end
