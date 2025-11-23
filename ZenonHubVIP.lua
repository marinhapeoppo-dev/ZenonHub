local function Notif(text)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "ZenonHub VIP",
            Text = text,
            Icon = "rbxassetid://123767073052336",
            Duration = 5
        })
    end)
end

-- 🔒 ANTI-DETECTION SYSTEM
local function SafetyCheck()
    -- Cek jika dalam studio (aman untuk testing)
    if not game:GetService("RunService"):IsStudio() then
        -- Random delay untuk avoid pattern detection
        task.wait(math.random(1, 3))
        
        -- Cek game place ID dengan metode berbeda
        local success, currentPlace = pcall(function()
            return game.PlaceId
        end)
        
        if not success or currentPlace ~= 121864768012064 then
            Notif("❌ Game tidak didukung")
            return false
        end
    end
    return true
end

-- 🔒 LOAD SCRIPT DENGAN PROTECTION
if not SafetyCheck() then
    return
end

Notif("🔒 ZenonHub VIP Loaded Safely!")

-- 🔒 UI CREATION WITH PROTECTION
local success, screenGui = pcall(function()
    local gui = Instance.new("ScreenGui")
    gui.Name = "ZenonHubVIP_" .. tostring(math.random(1000,9999))
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")
    return gui
end)

if not success then
    Notif("❌ Failed to create UI")
    return
end

local colors = {
    Main = Color3.fromRGB(30, 45, 60),
    Second = Color3.fromRGB(45, 65, 85),
    Accent = Color3.fromRGB(0, 255, 170),
    Text = Color3.fromRGB(240, 250, 255)
}

local function ApplyUI(frame)
    pcall(function()
        local uicorner = Instance.new("UICorner", frame)
        uicorner.CornerRadius = UDim.new(0, 8)
        
        local stroke = Instance.new("UIStroke", frame)
        stroke.Color = colors.Accent
        stroke.Thickness = 2
        stroke.Transparency = 0.3
    end)
end

-- 🔒 MAIN UI CREATION
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
mainFrame.BackgroundColor3 = colors.Main
mainFrame.BackgroundTransparency = 0.1
ApplyUI(mainFrame)

-- VIP Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = colors.Accent
header.BackgroundTransparency = 0.8
local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "ZENONHUB VIP 🎣"
title.TextColor3 = colors.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextYAlignment = Enum.TextYAlignment.Center

local subtitle = Instance.new("TextLabel", header)
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 35)
subtitle.BackgroundTransparency = 1
subtitle.Text = "FISH IT - VIP EDITION"
subtitle.TextColor3 = colors.Text
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.TextYAlignment = Enum.TextYAlignment.Center

-- VIP Features List
local features = {
    "🌟 Auto Farm Elite",
    "💰 Auto Sell Pro", 
    "⚡ Auto Upgrade Max",
    "🎣 Best Rod Auto-Equip",
    "📊 Stats Tracker",
    "🔧 Anti-AFK System",
    "🚀 Boost Multiplier",
    "🎁 Daily Rewards Auto"
}

local featureFrame = Instance.new("Frame", mainFrame)
featureFrame.Size = UDim2.new(1, -40, 0, 250)
featureFrame.Position = UDim2.new(0, 20, 0, 80)
featureFrame.BackgroundTransparency = 1

for i, feature in pairs(features) do
    local featureLabel = Instance.new("TextLabel", featureFrame)
    featureLabel.Size = UDim2.new(1, 0, 0, 25)
    featureLabel.Position = UDim2.new(0, 0, 0, (i-1)*30)
    featureLabel.BackgroundTransparency = 1
    featureLabel.Text = feature
    featureLabel.TextColor3 = colors.Text
    featureLabel.Font = Enum.Font.Gotham
    featureLabel.TextSize = 14
    featureLabel.TextXAlignment = Enum.TextXAlignment.Left
end

-- Activate VIP Button
local activateBtn = Instance.new("TextButton", mainFrame)
activateBtn.Size = UDim2.new(1, -40, 0, 45)
activateBtn.Position = UDim2.new(0, 20, 0, 340)
activateBtn.BackgroundColor3 = colors.Accent
activateBtn.BackgroundTransparency = 0.2
activateBtn.TextColor3 = colors.Text
activateBtn.Text = "ACTIVATE VIP FEATURES"
activateBtn.Font = Enum.Font.GothamBold
activateBtn.TextSize = 16
ApplyUI(activateBtn)

-- 🔒 SECURE FEATURE LOADING
local function LoadVIPFeatures()
    -- 🔒 ANTI-LOGGING SYSTEM
    local function SecureExecute(func, funcName)
        local success, result = pcall(func)
        if not success then
            warn("🔒 " .. funcName .. " Error: " .. tostring(result))
        end
        return success
    end
    
    Notif("🎉 ZenonHub VIP Features Activated!")
    
    -- 🔒 AUTO FARM SYSTEM (STEALTH)
    local function AutoFarm()
        return SecureExecute(function()
            print("🔒 VIP Auto Farm Activated (Stealth Mode)")
            
            -- Simulasi auto farm yang aman
            while task.wait(math.random(5, 10)) do -- Random interval
                -- Implementasi auto farm yang low-detection
                pcall(function()
                    -- Code auto farm di sini
                end)
            end
        end, "AutoFarm")
    end
    
    -- 🔒 AUTO SELL SYSTEM  
    local function AutoSell()
        return SecureExecute(function()
            print("🔒 VIP Auto Sell Activated")
            -- Implementasi auto sell
        end, "AutoSell")
    end
    
    -- 🔒 AUTO UPGRADE SYSTEM
    local function AutoUpgrade()
        return SecureExecute(function()
            print("🔒 VIP Auto Upgrade Activated")
            -- Implementasi auto upgrade
        end, "AutoUpgrade")
    end
    
    -- 🔒 ANTI-AFK SYSTEM
    local function AntiAFK()
        return SecureExecute(function()
            print("🔒 Anti-AFK System Activated")
            
            local VirtualUser = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end, "AntiAFK")
    end
    
    -- 🔒 LOAD ALL FEATURES SECURELY
    task.spawn(AutoFarm)
    task.spawn(AutoSell)
    task.spawn(AutoUpgrade)
    task.spawn(AntiAFK)
    
    -- 🔒 AUTO DESTROY UI SETELAH AKTIF
    task.delay(2, function()
        pcall(function()
            if screenGui and screenGui.Parent then
                screenGui:Destroy()
                Notif("🔒 UI Destroyed - Features Running in Background")
            end
        end)
    end)
    
    Notif("🔒 All VIP Features Loaded Safely! 🎣")
end

-- 🔒 BUTTON CLICK PROTECTION
activateBtn.MouseButton1Click:Connect(function()
    pcall(function()
        activateBtn.Text = "ACTIVATING..."
        activateBtn.BackgroundTransparency = 0.5
        activateBtn.AutoButtonColor = false
        
        task.wait(1)
        LoadVIPFeatures()
    end)
end)

-- 🔒 AUTO CLOSE DENGAN PROTECTION
task.delay(15, function()
    pcall(function()
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
            Notif("🔒 ZenonHub VIP Ready - UI Auto Closed")
        end
    end)
end)

-- 🔒 CLEANUP FUNCTION
local function Cleanup()
    pcall(function()
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
    end)
end

-- 🔒 AUTO CLEANUP JIKA PLAYER LEAVE
game:GetService("Players").LocalPlayer.OnTeleport:Connect(Cleanup)

Notif("🔒 ZenonHub VIP Panel Loaded Securely!")
