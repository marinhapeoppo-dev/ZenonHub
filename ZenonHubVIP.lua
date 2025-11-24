-- MartinSC Premium UI
-- Updated with Scrollable Features

if game.CoreGui:FindFirstChild("MartinSC_UI") then
    game.CoreGui.MartinSC_UI:Destroy()
end

local MartinSC = {
    CurrentTab = "Fitur",
    AutoClick = false,
    NoAnim = false,
    FPSBoost = false,
    Speed = 16
}

---------------------------------------------------------
-- NOTIFIKASI
---------------------------------------------------------

local function Notif(msg)
    game.StarterGui:SetCore("SendNotification", {
        Title = "MartinSC",
        Text = msg,
        Duration = 3
    })
end

---------------------------------------------------------
-- AUTO FARM + WEBHOOK LOGGER
---------------------------------------------------------

local AutoFarm = {
    Enabled = false,
    FishCount = 0,
    StartTime = 0,
    Connection = nil
}

local WEBHOOK_URL = "" -- GANTI WEBHOOK DISINI

-- Webhook sender
local function SendWebhook(title, message)
    if WEBHOOK_URL == "" then return end

    local data = {
        ["embeds"] = {{
            ["title"] = title,
            ["description"] = message,
            ["color"] = 5793266,
            ["footer"] = {
                ["text"] = "MartinSC Premium"
            }
        }}
    }

    local http = game:GetService("HttpService")
    pcall(function()
        syn.request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = http:JSONEncode(data)
        })
    end)
end

-- AutoFarm Logic
local function AutoFarmLoop()
    if AutoFarm.Connection then
        AutoFarm.Connection:Disconnect()
    end
    
    AutoFarm.StartTime = os.time()
    AutoFarm.FishCount = 0

    SendWebhook("🎣 AutoFarm Started", "Mode: Auto Lempar + Auto Tarik\nStatus: **ON**")

    AutoFarm.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        if not AutoFarm.Enabled then return end
        
        -- LEMPAR
        local cast = game.ReplicatedStorage:FindFirstChild("CastRod")
        if cast then
            cast:FireServer()
        end

        task.wait(math.random(13, 19)/10) -- 1.3–1.9sec

        if not AutoFarm.Enabled then return end

        -- TARIK
        local pull = game.ReplicatedStorage:FindFirstChild("PullRod")
        if pull then
            pull:FireServer()
            AutoFarm.FishCount = AutoFarm.FishCount + 1

            if AutoFarm.FishCount % 5 == 0 then -- Kirim webhook setiap 5 ikan
                SendWebhook("🐟 Progress Update", "Total Ikan: **" .. AutoFarm.FishCount .. "**")
            end
        end

        task.wait(math.random(15, 24)/10)
    end)
end

local function ToggleAutoFarm(state)
    AutoFarm.Enabled = state

    if state then
        Notif("AutoFarm ON - Mulai memancing...")
        AutoFarmLoop()
    else
        Notif("AutoFarm OFF")
        if AutoFarm.Connection then
            AutoFarm.Connection:Disconnect()
            AutoFarm.Connection = nil
        end
        
        -- Kirim laporan akhir
        local dur = os.time() - AutoFarm.StartTime
        if dur > 0 then
            SendWebhook("⏹️ AutoFarm Stopped",
                "Durasi: **" .. dur .. " detik**\nTotal Ikan: **" .. AutoFarm.FishCount .. "**")
        end
    end
end

---------------------------------------------------------
-- FITUR LAIN YANG BERFUNGSI
---------------------------------------------------------

-- No Animations Function (DIPERBAIKI - tidak matikan animasi sepenuhnya)
local function ToggleNoAnimations(state)
    MartinSC.NoAnim = state
    
    if state then
        -- Hanya reduce animation quality, tidak disable sepenuhnya
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    -- Reduce animation quality tapi tidak stop sepenuhnya
                    humanoid.AutoRotate = false
                end
            end
        end
        Notif("Animation Optimizer: ON")
    else
        -- Restore animation settings
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.AutoRotate = true
                end
            end
        end
        Notif("Animation Optimizer: OFF")
    end
end

-- FPS Booster Function
local function ToggleFPSBoost(state)
    MartinSC.FPSBoost = state
    
    if state then
        -- Optimize settings
        settings().Rendering.QualityLevel = 1
        game:GetService("Lighting").GlobalShadows = false
        
        for _, effect in ipairs(workspace:GetDescendants()) do
            if effect:IsA("ParticleEmitter") then
                effect.Enabled = false
            end
        end
        Notif("FPS Booster: ON")
    else
        -- Restore settings
        settings().Rendering.QualityLevel = 10
        game:GetService("Lighting").GlobalShadows = true
        
        for _, effect in ipairs(workspace:GetDescendants()) do
            if effect:IsA("ParticleEmitter") then
                effect.Enabled = true
            end
        end
        Notif("FPS Booster: OFF")
    end
end

-- Auto Click Function
local autoClickConnection = nil

local function ToggleAutoClick(state)
    MartinSC.AutoClick = state
    
    if state then
        -- Start auto clicking
        autoClickConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not MartinSC.AutoClick then return end
            
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.05)
            virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            task.wait(0.5) -- 2 clicks per second
        end)
        Notif("Auto Click: ON")
    else
        -- Stop auto clicking
        if autoClickConnection then
            autoClickConnection:Disconnect()
            autoClickConnection = nil
        end
        Notif("Auto Click: OFF")
    end
end

-- WalkSpeed Controller
local function UpdateWalkSpeed(speed)
    MartinSC.Speed = speed
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end

---------------------------------------------------------
-- GUI DENGAN SCROLLING FEATURES
---------------------------------------------------------

local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "MartinSC_UI"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(80, 120, 255)
mainStroke.Thickness = 2

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
header.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MartinSC Premium"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(180, 200, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextSize = 18

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
closeBtn.TextSize = 16

local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0, 6)

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -75, 0, 10)
minimizeBtn.Text = "─"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
minimizeBtn.TextSize = 16

local minimizeCorner = Instance.new("UICorner", minimizeBtn)
minimizeCorner.CornerRadius = UDim.new(0, 6)

-- Tabs
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(1, -20, 0, 40)
tabsFrame.Position = UDim2.new(0, 10, 0, 55)
tabsFrame.BackgroundTransparency = 1

local tabs = { "Fitur", "Info" }
local tabButtons = {}

local function CreateTab(name, index)
    local btn = Instance.new("TextButton", tabsFrame)
    btn.Size = UDim2.new(0.5, -5, 1, 0)
    btn.Position = UDim2.new((index-1)*0.5, 0, 0, 0)
    btn.Text = name
    btn.Font = Enum.Font.GothamSemibold
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.TextSize = 14
    btn.BackgroundColor3 = name == MartinSC.CurrentTab and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(50, 50, 70)
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    tabButtons[name] = btn
    return btn
end

-- Content Frame dengan Scrolling
local contentFrame = Instance.new("ScrollingFrame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -110)
contentFrame.Position = UDim2.new(0, 10, 0, 100)
contentFrame.BackgroundTransparency = 1
contentFrame.ScrollBarThickness = 6
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 120, 255)
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 500) -- Akan diupdate nanti

-- Toggle Constructor untuk Scrolling
local function CreatePremiumToggle(title, desc, pos, callback)
    local frame = Instance.new("Frame", contentFrame)
    frame.Size = UDim2.new(1, 0, 0, 60)
    frame.Position = pos
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    frame.BorderSizePixel = 0
    
    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 8)
    
    local frameStroke = Instance.new("UIStroke", frame)
    frameStroke.Color = Color3.fromRGB(60, 60, 80)
    frameStroke.Thickness = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -70, 0.5, 0)
    label.Position = UDim2.new(0, 15, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = title
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(220, 220, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local sub = Instance.new("TextLabel", frame)
    sub.Size = UDim2.new(1, -70, 0.5, 0)
    sub.Position = UDim2.new(0, 15, 0.5, -5)
    sub.BackgroundTransparency = 1
    sub.Text = desc
    sub.Font = Enum.Font.Gotham
    sub.TextColor3 = Color3.fromRGB(180, 180, 220)
    sub.TextSize = 11
    sub.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 50, 0, 25)
    btn.Position = UDim2.new(1, -60, 0.5, -12)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    btn.Text = "OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 12
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)

    local isOn = false
    btn.MouseButton1Click:Connect(function()
        isOn = not isOn
        btn.Text = isOn and "ON" or "OFF"
        btn.BackgroundColor3 = isOn and Color3.fromRGB(80, 160, 80) or Color3.fromRGB(60, 60, 80)
        btn.TextColor3 = isOn and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 100, 100)
        callback(isOn)
    end)

    return frame
end

-- Speed Control untuk Scrolling
local function CreateSpeedControl(pos)
    local frame = Instance.new("Frame", contentFrame)
    frame.Size = UDim2.new(1, 0, 0, 70)
    frame.Position = pos
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    frame.BorderSizePixel = 0
    
    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 8)
    
    local frameStroke = Instance.new("UIStroke", frame)
    frameStroke.Color = Color3.fromRGB(60, 60, 80)
    frameStroke.Thickness = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 0.4, 0)
    label.Text = "WalkSpeed: " .. MartinSC.Speed
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(220, 220, 255)

    local slider = Instance.new("Frame", frame)
    slider.Size = UDim2.new(1, -20, 0, 8)
    slider.Position = UDim2.new(0, 10, 0.6, 0)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    slider.BorderSizePixel = 0
    
    local sliderCorner = Instance.new("UICorner", slider)
    sliderCorner.CornerRadius = UDim.new(0, 4)

    local knob = Instance.new("Frame", slider)
    knob.Size = UDim2.new(0, 16, 0, 20)
    knob.Position = UDim2.new(0, 0, -0.75, 0)
    knob.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 2
    
    local knobCorner = Instance.new("UICorner", knob)
    knobCorner.CornerRadius = UDim.new(0, 4)

    -- Update knob position based on current speed
    local initialPos = (MartinSC.Speed - 16) / 64
    knob.Position = UDim2.new(initialPos, -8, -0.75, 0)

    local uis = game:GetService("UserInputService")
    local dragging = false

    local function updateSpeed(rel)
        MartinSC.Speed = math.floor(16 + (rel * 64))
        label.Text = "WalkSpeed: " .. MartinSC.Speed
        UpdateWalkSpeed(MartinSC.Speed)
    end

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    uis.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            knob.Position = UDim2.new(rel, -8, -0.75, 0)
            updateSpeed(rel)
        end
    end)

    return frame
end

---------------------------------------------------------
-- TAB SYSTEM DENGAN SCROLLING
---------------------------------------------------------

local function ShowTab(tabName)
    MartinSC.CurrentTab = tabName

    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(50, 50, 70)
    end

    -- Clear content
    for _, c in ipairs(contentFrame:GetChildren()) do
        c:Destroy()
    end

    if tabName == "Fitur" then
        -- Semua fitur dalam scrolling frame
        local totalHeight = 0
        
        -- Animation Optimizer (bukan No Animations)
        CreatePremiumToggle("Animation Optimizer", "Optimize animation performance", UDim2.new(0, 0, 0, totalHeight), ToggleNoAnimations)
        totalHeight = totalHeight + 70
        
        CreatePremiumToggle("FPS Booster", "Increase game performance", UDim2.new(0, 0, 0, totalHeight), ToggleFPSBoost)
        totalHeight = totalHeight + 70
        
        CreatePremiumToggle("Auto Click", "Automatic mouse clicking", UDim2.new(0, 0, 0, totalHeight), ToggleAutoClick)
        totalHeight = totalHeight + 70
        
        CreateSpeedControl(UDim2.new(0, 0, 0, totalHeight))
        totalHeight = totalHeight + 80
        
        CreatePremiumToggle("Auto Farm", "Auto Lempar & Tarik Ikan", UDim2.new(0, 0, 0, totalHeight), ToggleAutoFarm)
        totalHeight = totalHeight + 70

        -- Update canvas size untuk scrolling
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)

    elseif tabName == "Info" then
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
        
        local infoFrame = Instance.new("Frame", contentFrame)
        infoFrame.Size = UDim2.new(1, 0, 0, 300)
        infoFrame.BackgroundTransparency = 1

        local infoText = Instance.new("TextLabel", infoFrame)
        infoText.Size = UDim2.new(1, 0, 0, 120)
        infoText.Position = UDim2.new(0, 0, 0, 20)
        infoText.BackgroundTransparency = 1
        infoText.TextColor3 = Color3.fromRGB(220, 220, 255)
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 14
        infoText.TextWrapped = true
        infoText.Text = "MartinSC Premium Suite\n\nVersion: 2.1\nDeveloper: Martin\nStatus: Premium"

        -- Discord Button
        local discordBtn = Instance.new("TextButton", infoFrame)
        discordBtn.Size = UDim2.new(1, 0, 0, 40)
        discordBtn.Position = UDim2.new(0, 0, 0, 150)
        discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        discordBtn.Text = "󰙯 Join Discord"
        discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        discordBtn.Font = Enum.Font.GothamBold
        discordBtn.TextSize = 14
        
        local discordCorner = Instance.new("UICorner", discordBtn)
        discordCorner.CornerRadius = UDim.new(0, 8)
        
        local discordStroke = Instance.new("UIStroke", discordBtn)
        discordStroke.Color = Color3.fromRGB(255, 255, 255)
        discordStroke.Thickness = 1
        discordStroke.Transparency = 0.5

        discordBtn.MouseButton1Click:Connect(function()
            setclipboard("martin.sc")
            Notif("Discord link copied: martin.sc")
        end)

        -- Features List
        local features = Instance.new("TextLabel", infoFrame)
        features.Size = UDim2.new(1, 0, 0, 100)
        features.Position = UDim2.new(0, 0, 0, 200)
        features.BackgroundTransparency = 1
        features.TextColor3 = Color3.fromRGB(180, 180, 220)
        features.Font = Enum.Font.Gotham
        features.TextSize = 12
        features.TextWrapped = true
        features.TextXAlignment = Enum.TextXAlignment.Left
        features.Text = "✨ Features:\n• Animation Optimizer\n• FPS Booster\n• Auto Click\n• WalkSpeed Control\n• Auto Farm\n• Webhook Logger"
    end
end

-- Create Tabs
for i, name in ipairs(tabs) do
    local btn = CreateTab(name, i)
    btn.MouseButton1Click:Connect(function()
        ShowTab(name)
    end)
end

-- Default Page
ShowTab("Fitur")

-- Minimize Function
minimizeBtn.MouseButton1Click:Connect(function()
    if contentFrame.Visible then
        contentFrame.Visible = false
        tabsFrame.Visible = false
        mainFrame.Size = UDim2.new(0, 350, 0, 50)
        minimizeBtn.Text = "+"
    else
        contentFrame.Visible = true
        tabsFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 350, 0, 400)
        minimizeBtn.Text = "─"
    end
end)

-- Close Button
closeBtn.MouseButton1Click:Connect(function()
    -- Cleanup semua connections
    if AutoFarm.Connection then
        AutoFarm.Connection:Disconnect()
    end
    if autoClickConnection then
        autoClickConnection:Disconnect()
    end
    screenGui:Destroy()
    Notif("MartinSC Closed")
end

Notif("MartinSC Premium Loaded!")
