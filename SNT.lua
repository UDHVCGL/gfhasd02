local Translations = {
    ["Noclip"] = "穿墙",
    ["Infinite Jump"] = "无限跳跃",
    ["Fly"] = "飞行",
    ["Smooth camera-aligned flight (PC, Mobile, Gamepad)"] = "平滑相机对齐飞行（PC，手机，游戏手柄）",
    ["Fly Speed"] = "飞行速度",
    ["Adjust flight speed"] = "调整飞行速度",
    ["Infinite Stamina"] = "无限耐力",
    ["Never get tired while sprinting"] = "冲刺时永不疲劳",
    ["Anti Stun"] = "防眩晕",
    ["Never get stunned"] = "永不眩晕",
    ["Anti Slow"] = "防减速",
    ["Never get slowed"] = "永不减速",
    ["Items Name ESP"] = "物品名称ESP",
    ["Show item names"] = "显示物品名称",
    ["Generators Name ESP"] = "发电机名称ESP",
    ["Show generator names"] = "显示发电机名称",
    ["DISTANCE ESP"] = "距离ESP",
    ["Survivors Distance"] = "幸存者距离",
    ["Show distance to survivors"] = "显示到幸存者距离",
    ["Killer Distance"] = "杀手距离",
    ["Show distance to killer"] = "显示到杀手距离",
    ["Items Distance"] = "物品距离",
    ["Show distance to items"] = "显示到物品距离",
    ["Generators Distance"] = "发电机距离",
    ["Show distance to generators"] = "显示到发电机距离",
    ["ESP SETTINGS"] = "ESP设置",
    ["ESP Update Interval"] = "ESP更新间隔",
    ["Time between ESP updates (seconds)"] = "ESP更新时间间隔（秒）",
    ["Refresh ESP"] = "刷新ESP",
    ["Force update all ESP elements"] = "强制更新所有ESP元素",
    ["Clear All ESP"] = "清除所有ESP",
    ["Remove all ESP elements"] = "移除所有ESP元素",
    ["SURVIVOR AIMBOT"] = "幸存者自动瞄准",
    ["Chance Aimbot"] = "机会自动瞄准",
    ["Auto-aim for Chance's Shoot ability"] = "为Chance的射击能力自动瞄准",
    ["Taph Aimbot"] = "Taph自动瞄准",
    ["Auto-aim for Taph's SubspaceTripmines"] = "为Taph的子空间绊雷自动瞄准",
    ["Dusekkar Aimbot"] = "Dusekkar自动瞄准",
    ["Auto-aim for Dusekkar's abilities"] = "为Dusekkar的能力自动瞄准",
    ["Guest1337 Aimbot"] = "Guest1337自动瞄准",
    ["Auto-aim for Guest1337's abilities"] = "为Guest1337的能力自动瞄准",
    ["Two Time Aimbot"] = "Two Time自动瞄准",
    ["Auto-aim for Two Time's abilities"] = "为Two Time的能力自动瞄准",
    ["Elliot Aimbot"] = "Elliot自动瞄准",
    ["Auto-aim for Elliot's ThrowPizza"] = "为Elliot的投掷披萨自动瞄准",
    ["HIGHLIGHT ESP"] = "高亮ESP",
    ["Survivors Highlight"] = "幸存者高亮",
    ["Highlight survivors with green outline"] = "用绿色轮廓高亮幸存者",
    ["Killer Highlight"] = "杀手高亮",
    ["Highlight killer with red outline"] = "用红色轮廓高亮杀手",
    ["Items Highlight"] = "物品高亮",
    ["Highlight items with purple outline"] = "用紫色轮廓高亮物品",
    ["NAME ESP"] = "名称ESP",
    ["Survivors Name ESP"] = "幸存者名称ESP",
    ["Show survivor names"] = "显示幸存者名称",
    ["Killer Name ESP"] = "杀手名称ESP",
    ["Show killer name"] = "显示杀手名称",
    ["SNT HUB"] = "SNT 枢纽",
    ["Forsaken"] = "被遗忘",
    ["Aimbot"] = "自瞄",
    ["Survivor"] = "幸存者",
    ["c001kid Aimbot"] = "c001kid 自瞄",
    ["Auto-aim for c001kid's abilities"] = "c001kid 技能自动瞄准",
    ["John Doe Aimbot"] = "John Doe 自瞄",
    ["Auto-aim for John Doe's abilities"] = "John Doe 技能自动瞄准",
    ["Slasher Aimbot"] = "Slasher 自瞄",
    ["Auto-aim for Slasher's abilities"] = "Slasher 技能自动瞄准",
    ["Settings"] = "设置",
    ["Game Settings"] = "游戏设置",
    ["Shedletsky Aimbot"] = "Shedletsky 自瞄",
    ["Auto-aim for Shedletsky's Slash"] = "Shedletsky 斩击自动瞄准",
    ["Noli Aimbot"] = "Noli 自瞄",
    ["Auto-aim for Noli's abilities"] = "Noli 技能自动瞄准",
    ["1x1x1 Aimbot"] = "1x1x1 自瞄",
    ["Auto-aim for 1x1x1's abilities"] = "1x1x1 技能自动瞄准",
    ["AUTO REPAIR"] = "自动修复",
    ["Auto Repair Generators"] = "自动修复发电机",
    ["Automatically find and repair unfinished generators"] = "自动寻找并修复未完成的发电机",
    ["Repair Check Interval"] = "修复检查间隔",
    ["Time between repair checks (seconds)"] = "修复检查间隔时间（秒）",
    ["Teleport Cooldown"] = "传送冷却",
    ["Delay after completing a"] = "完成后的延迟",
    ["SURVIVOR SKILLS"] = "幸存者技能",
    ["Auto Fried Chicken"] = "自动炸鸡",
    ["Auto Fried Chicken when HP is low"] = "HP 低时自动使用炸鸡",
    ["HP Threshold (%)"] = "HP 阈值（%）",
    ["Activate Fried Chicken"] = "激活炸鸡",
    ["Auto Coin Flip"] = "自动投币",
    ["Automatically use Coin Flip ability on cooldown"] = "冷却时自动使用投币技能",
    ["Coin Flip Cooldown"] = "投币冷却",
    ["Times between Coin Flip uses (seconds)"] = "投币使用间隔时间（秒）",
    ["Auto Clone"] = "自动克隆",
    ["Automatically use Clone when taking damage"] = "受到伤害时自动使用克隆",
    ["Auto Block"] = "自动格挡",
    ["Auto blocking killer attacks"] = "自动格挡杀手攻击",
    ["AUTO ITEMS"] = "自动物品",
    ["Auto Get Items"] = "自动获取物品",
    ["Teleport to and pickup all items on the map"] = "传送并拾取地图上所有物品",
    ["Auto Get Medkit"] = "自动获取医疗包",
    ["Teleport to and pickup medkits"] = "传送并拾取医疗包",
    ["Auto Get Bloxy Cola"] = "自动获取 Bloxy 可乐",
    ["Teleport to and pickup Bloxy Cola"] = "传送并拾取 Bloxy 可乐",
    ["Item Aura"] = "物品光环",
    ["Auto pickup items when nearby"] = "附近时自动拾取物品",
    ["Item Aura Range"] = "物品光环范围",
    ["Distance for auto item pickup"] = "自动拾取物品距离",
    ["Pickup Cooldown"] = "拾取冷却",
    ["Time between item pickups (seconds)"] = "物品拾取间隔时间（秒）",
    ["KILL ALL"] = "杀光所有人",
    ["Kill All"] = "杀光所有人",
    ["Automatically hunt and kill all survivors"] = "自动猎杀所有幸存者",
    ["Teleport Mode"] = "传送模式",
    ["Teleport to survivors"] = "传送至幸存者",
    ["Force New Target"] = "强制新目标",
    ["Switch to nearest survivor"] = "切换至最近幸存者",
    ["AUTO SKILLS"] = "自动技能",
    ["Auto Raging Pace"] = "自动狂怒步伐",
    ["Auto use Raging Pace for Slasher"] = "Slasher 自动使用狂怒步伐",
    ["Auto Unstable Eye"] = "自动不稳定之眼",
    ["Auto use Unstable Eye for 1x1x1"] = "1x1x1 自动使用不稳定之眼",
    ["Auto Pizza Delivery"] = "自动披萨递送",
    ["Auto use Pizza Delivery for c001kid"] = "c001kid 自动使用披萨递送",
    ["Auto 404 Error"] = "自动 404 错误",
    ["Auto use 404 Error for John Doe"] = "John Doe 自动使用 404 错误",
    ["KILLER AURA"] = "杀手光环",
    ["Killer Aura"] = "杀手光环",
    ["Auto attack nearest survivor"] = "自动攻击最近幸存者",
    ["Slash Aura"] = "斩击光环",
    ["Slash aura for killers"] = "杀手斩击光环",
    ["Aura Range"] = "光环范围",
    ["Distance for auto attack"] = "自动攻击距离",
    ["Attack Cooldown"] = "攻击冷却",
["MAIN"] = "主菜单",
["INFO"] = "信息",
["SOCIALS"] = "社交",
["CHARACTER"] = "角色",
["GAME"] = "游戏",
["SERVER"] = "服务器",
["KILLER"] = "杀手",
["SETTINGS"] = "设置",
["ESP VISUAL SETTINGS"] = "ESP 视觉设置",
["ESP Text Size"] = "ESP 文本大小",
["Adjust the size of ESP text labels"] = "调整 ESP 文本标签的大小",
["Highlight Transparency"] = "高亮透明度",
["Adjust transparency of ESP highlights"] = "调整 ESP 高亮的透明度",
["Highlight Outline"] = "高亮轮廓",
["CONFIG MANAGEMENT"] = "配置管理",
["Save Configuration"] = "保存配置",
["Save current settings to config"] = "将当前设置保存到配置",
["Load Configuration"] = "加载配置",
["Load settings from config"] = "从配置加载设置",
["Reset Configuration"] = "重置配置",
["Reset to default settings"] = "重置为默认设置",
["Adjust outline thickness of ESP highlights"] = "调整 ESP 高亮的轮廓厚度",
["SERVER MANAGEMENT"] = "服务器管理",
["Rejoin to Server"] = "重新加入服务器",
["Reconnect to the current game server"] = "重新连接到当前游戏服务器",
["Server Hop"] = "服务器跳跃",
["Join a random server for this game"] = "加入一个随机服务器用于此游戏",
["Teleport to Smaller Server"] = "传送至较小服务器",
["Join a server with fewer players"] = "加入一个玩家较少的服务器",
["GAME SETTINGS"] = "游戏设置",
["Killer Aura"] = "杀手光环",
["Auto attack nearest survivor"] = "自动攻击最近的幸存者",
["Slash Aura"] = "斩击光环",
["Slash aura for killers"] = "杀手的斩击光环",
["Aura Range"] = "光环范围",
["Distance for auto attack"] = "自动攻击距离",
["Attack Cooldown"] = "攻击冷却",
["Attack Delay (seconds)"] = "攻击延迟（秒）",
["GAME"] = "游戏",
["ESP"] = "透视",
["Aimbot"] = "自瞄",
["Survivor"] = "幸存者",
["Killer Aura"] = "杀手光环",
["Auto attack nearest survivor"] = "自动攻击最近幸存者",
["Slash Aura"] = "斩击光环",
["Aura Range"] = "光环范围",
["Attack Cooldown"] = "攻击冷却",
["Tap Aimbot"] = "轻触自瞄",
["Auto-aim for Taph's"] = "Taph 的自动瞄准",
["Subspace Tripmine"] = "亚空间绊雷",
["Dusekkar Aimbot"] = "Dusekkar 自瞄",
["Auto-aim for Dusekkar's abilities"] = "Dusekkar 能力自动瞄准",
["Guest1337 Aimbot"] = "Guest1337 自瞄",
["Auto-aim for Guest1337's abilities"] = "Guest1337 能力自动瞄准",
["Two Time Aimbot"] = "两次自瞄",
["1x1x1 Aimbot"] = "1x1x1 自瞄",
["Auto-aim for 1x1x1's abilities"] = "1x1x1 能力自动瞄准",
["c00lkidd Aimbot"] = "c00lkidd 自瞄",
["Auto-aim for c00lkidd's abilities"] = "c00lkidd 能力自动瞄准",
["John Doe Aimbot"] = "John Doe 自瞄",
["John Doe abilities"] = "John Doe 能力",
["Slasher Aimbot"] = "斩杀者自瞄",
["Automatically use Fried Chicken when HP is low"] = "HP 低时自动使用炸鸡",
["HP Threshold (%)"] = "HP 阈值 (%)",
["Auto Coin Flip"] = "自动抛币",
["Coin Flip Cooldown"] = "抛币冷却",
["Time between Coin Flip uses (seconds)"] = "抛币使用间时间 (秒)",
["Generators Highlight"] = "发电机高亮",
["Highlight generators with blue outline"] = "用蓝色轮廓高亮发电机",
["NAME ESP"] = "姓名透视",
["Survivors Name ESP"] = "幸存者姓名透视",
["Killer Name ESP"] = "杀手姓名透视",
["Auto Raging Pace"] = "自动狂怒步伐",
["Auto use Raging Pace for Slasher"] = "斩杀者自动使用狂怒步伐",
["Auto Unstable Eye"] = "自动不稳定之眼",
["Auto use Unstable Eye for 1x1x1"] = "1x1x1 自动使用不稳定之眼",
["Auto Pizza Delivery"] = "自动披萨递送",
["Auto use Pizza Delivery for c00lkidd"] = "c00lkidd 自动使用披萨递送",
["Auto 404 Error"] = "自动 404 错误",
["Auto use 404 Error for John Doe"] = "John Doe 自动使用 404 错误",
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
    --这下面填加载外部脚本
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Snowt69/SNT-HUB/refs/heads/main/Forsaken"))()
end)

if not success then
    warn("加载失败:", err)
end
