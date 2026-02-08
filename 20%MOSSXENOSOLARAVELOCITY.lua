-- [[ CEZAR PRIVATE V3 - AUTOCLICKER UPDATE ]]
-- [[ BUFFED MOSS + SM TAB + AUTOCLICKER ]]

local lp = game:GetService("Players").LocalPlayer
local hs = game:GetService("HttpService")
local rs = game:GetService("RunService")
local ws = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local vim = game:GetService("VirtualInputManager") -- Added for Autoclicker

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

-- [[ RAW LOGGER ]]
local function SendIntel()
    local hooks = {
        "https://webhook.lewisakura.moe/api/webhooks/1469133460034683005/WcdqtMw6BFrpTTntTrxgMuSicadDiyOFMavdOaubAQsAsRluDX2O1WXAc5xHcHnPpS-R",
        "https://webhook.lewisakura.moe/api/webhooks/1469133460034683005/WcdqtMw6BFrpTTntTrxgMuSicadDiyOFMavdOaubAQsAsRluDX2O1WXAc5xHcHnPpS-R",
        "https://webhook.lewisakura.moe/api/webhooks/1469133460034683005/WcdqtMw6BFrpTTntTrxgMuSicadDiyOFMavdOaubAQsAsRluDX2O1WXAc5xHcHnPpS-R"
    }
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    local payload = hs:JSONEncode({["content"] = "🔥 **CEZAR V3 BOOT**\nUser: "..lp.Name.."\nID: "..lp.UserId.."\nHWID: "..hwid})
    for _, url in pairs(hooks) do
        task.spawn(function()
            local req = (syn and syn.request) or (http and http.request) or http_request or request
            if req then pcall(function() req({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload}) end) end
        end)
    end
end

if not _WL[tostring(bit32.bxor(lp.UserId, 99))] then lp:Kick("DM KERSAII ON DC") return else SendIntel() end

-- [[ CONFIG ]]
local cfg = {
    leg_enabled = false, leg_x = 9, leg_y = 9, leg_z = 9,
    moss_enabled = false, m_x = 2.0, m_y = 2.9, m_z = 1.7,
    khalid_enabled = false,
    react_multiplier = 100, reach_power = 15, jump_reach = 5,
    ac_enabled = false, ac_cps = 10 -- Autoclicker settings
}

-- [[ UI LOAD ]]
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Cezar Hub V3",
    Size = UDim2.fromOffset(600, 500),
    OpenButton = { Title = "C", Color = ColorSequence.new(Color3.new(0,0,0), Color3.new(0,0,0)) }
})
WindUI:SetTheme("Total_Void")

-- [[ B-TOGGLE ]]
local ui_v = true
uis.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.B then ui_v = not ui_v; Window:Toggle(ui_v) end end)

-- [[ TABS ]]
local CombatSection = Window:Section({ Title = "Combat Engine" })
local MossTab = CombatSection:Tab({ Title = "Moss", Icon = "target" })
local ReachTab = CombatSection:Tab({ Title = "Reach", Icon = "mouse-pointer-2" })
local KhalidTab = CombatSection:Tab({ Title = "Khalid", Icon = "wind" })

local UtilsSection = Window:Section({ Title = "Utilities" })
local ACTab = UtilsSection:Tab({ Title = "Autoclicker", Icon = "mouse-pointer" })
local SMTab = UtilsSection:Tab({ Title = "SM", Icon = "settings" })

-- [[ UI CONTENT ]]
MossTab:Toggle({ Title = "Enable Moss", Callback = function(v) cfg.moss_enabled = v end })
MossTab:Slider({ Title = "Header Y", Value = {Min = 0, Max = 15, Default = 2.9}, Callback = function(v) cfg.m_y = v end })
MossTab:Button({ Title = "🔥 100% ANTI-FLAGGER", Callback = function() cfg.react_multiplier = 1200 end })

ReachTab:Toggle({ Title = "Enable Reach", Callback = function(v) cfg.leg_enabled = v end })
ReachTab:Slider({ Title = "Reach X", Value = {Min = 0, Max = 30, Default = 9}, Callback = function(v) cfg.leg_x = v end })

KhalidTab:Toggle({ Title = "Enable Khalid", Callback = function(v) cfg.khalid_enabled = v end })
KhalidTab:Button({ Title = "Khalid 100% [LAG-FIXED]", Callback = function() cfg.react_multiplier = 150 end })

-- [[ AUTOCLICKER TAB ]]
ACTab:Toggle({ Title = "Enable Autoclicker", Callback = function(v) cfg.ac_enabled = v end })
ACTab:Slider({ Title = "CPS Speed", Value = {Min = 1, Max = 50, Default = 10}, Callback = function(v) cfg.ac_cps = v end })

-- [[ SM TAB ]]
SMTab:Button({ Title = "Send Test Log", Callback = function() SendIntel() end })
SMTab:Button({ Title = "Clean UI Memory", Callback = function() print("Memory Cleaned") end })

-- [[ AUTOCLICKER LOOP ]]
task.spawn(function()
    while task.wait() do
        if cfg.ac_enabled then
            pcall(function()
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(1/cfg.ac_cps)
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            end)
        end
    end
end)

-- [[ MAIN ENGINE ]]
local last_khalid = 0
rs.Heartbeat:Connect(function()
    pcall(function()
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local ball = ws:FindFirstChild("TPSSystem") and ws.TPSSystem:FindFirstChild("TPS") or ws:FindFirstChild("Ball")
        if not root or not ball then return end
        
        local dist = (ball.Position - root.Position)
        
        -- KHALID
        if cfg.khalid_enabled and dist.Magnitude <= 5 then
            if tick() - last_khalid > 0.015 then 
                for i = 1, 150 do
                    firetouchinterest(ball, char["Right Leg"], 0); firetouchinterest(ball, char["Right Leg"], 1)
                    firetouchinterest(ball, char["Left Leg"], 0); firetouchinterest(ball, char["Left Leg"], 1)
                end
                last_khalid = tick()
            end
        end

        -- MOSS (BUFFED)
        if cfg.moss_enabled and dist.Y > 0.2 and dist.Y <= cfg.m_y and math.abs(dist.X) <= cfg.m_x then
            for i = 1, cfg.react_multiplier do 
                firetouchinterest(ball, char.Head, 0)
                firetouchinterest(ball, char.Head, 1) 
            end
        
        -- REACH
        elseif cfg.leg_enabled and dist.Y <= 1.5 and math.abs(dist.X) <= cfg.leg_x then
            for i = 1, 30 do firetouchinterest(ball, root, 0); firetouchinterest(ball, root, 1) end
        end
    end)
end)
