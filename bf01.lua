local T = {["Kenny"] = "MR", 
["b站UID"] = "测试2",}

local function tr(t)
    if not t or type(t)~="string" then return t end
    if T[t] then return T[t] end
    for k,v in pairs(T) do if t:find(k) then return t:gsub(k,v) end end
    return t
end

local function setup()
    local s,e = pcall(function()
        local m = getrawmetatable(game)
        setreadonly(m, false)
        local o = m.__newindex
        m.__newindex = newcclosure(function(t,k,v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = tr(tostring(v))
            end
            return o(t,k,v)
        end)
        setreadonly(m, true)
    end)
    
    if not s then
        warn("元表劫持失败:", e)
        local d = {}
        local function s(g)
            for _,x in ipairs(g:GetDescendants()) do
                if (x:IsA("TextLabel") or x:IsA("TextButton") or x:IsA("TextBox")) and not d[x] then
                    pcall(function() local t = x.Text if t and t~="" then local r = tr(t) if r~=t then x.Text = r d[x] = true end end end)
                end
            end
        end
        
        local function l(p) p.DescendantAdded:Connect(function(x) if x:IsA("TextLabel") or x:IsA("TextButton") or x:IsA("TextBox") then task.wait(0.1) pcall(function() local t = x.Text if t and t~="" then local r = tr(t) if r~=t then x.Text = r end end end) end end) end
        
        pcall(l, game:GetService("CoreGui"))
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("PlayerGui") then pcall(l, p.PlayerGui) end
        
        while true do
            pcall(s, game:GetService("CoreGui"))
            if p and p:FindFirstChild("PlayerGui") then pcall(s, p.PlayerGui) end
            task.wait(3)
        end
    end
end

task.wait(2)
setup()

local s,e = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/bf.txt"))()


end)
if not s then warn("加载失败:", e) end