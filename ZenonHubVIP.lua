-- MartinSC Premium - Optimized Version
-- Compatible with most executors

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

-- Simple Notification Function
local function Notif(msg)
    game.StarterGui:SetCore("SendNotification", {
        Title = "MartinSC",
        Text = msg,
        Duration = 3
    })
end

-- Safe function execution
local function SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("MartinSC Error: " .. tostring(result))
    end
    return success
end

-- Auto Click System
local autoClickConnection = nil

local function ToggleAutoClick(state)
    MartinSC.AutoClick = state
    
    if state then
        Notif("Auto Click: ON")
        autoClickConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not MartinSC.AutoClick then return end
            SafeCall(function()
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(0.05)
                virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                task.wait(0.5)
            end)
        end)
    else
        Notif("Auto Click: OFF")
        if autoClickConnection then
            autoClickConnection:Disconnect()
            autoClickConnection = nil
        end
    end
end

-- FPS Booster System
local function ToggleFPSBoost(state)
    MartinSC.FPSBoost = state
    
    if state then
        SafeCall(function()
            settings().Rendering.QualityLevel = 1
            game:GetService("Lighting").GlobalShadows = false
        end)
        Notif("FPS Booster: ON")
    else
        SafeCall(function()
            settings().Rendering.QualityLevel = 10
            game:GetService("Lighting").GlobalShadows = true
        end)
        Notif("FPS Booster: OFF")
    end
end

-- WalkSpeed Controller
local function UpdateWalkSpeed(speed)
    MartinSC.Speed = speed
    SafeCall(function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speed
        end
    end)
end

-- Auto Farm System
local AutoFarm = {
    Enabled = false,
    Connection = nil
}

local function ToggleAutoFarm(state)
    AutoFarm.Enabled = state
    
    if state then
        Notif("Auto Farm: ON")
        if AutoFarm.Connection then
            AutoFarm.Connection:Disconnect()
        end
        
        AutoFarm.Connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not AutoFarm.Enabled then return end
            
            SafeCall(function()
                -- Cari dan fire fishing events
                local cast = game:GetService("ReplicatedStorage"):FindFirstChild("CastRod")
                local pull = game:GetService("ReplicatedStorage"):FindFirstChild("PullRod")
                
                if cast then
                    cast:FireServer()
                    task.wait(1.5)
                end
                
                if pull then
                    pull:FireServer()
                    task.wait(1.5)
                end
            end)
        end)
    else
        Notif("Auto Farm: OFF")
        if AutoFarm.Connection then
            AutoFarm.Connection:Disconnect()
            AutoFarm.Connection = nil
        end
    end
end

-- Animation Optimizer (Light version)
local function ToggleNoAnimations(state)
    MartinSC.NoAnim = state
    if state then
        Notif("Animation Optimizer: ON")
    else
        Notif("Animation Optimizer: OFF")
    end
end

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MartinSC_UI"
screenGui.Parent = game.CoreGui
screenGui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(80, 120, 255)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MartinSC Premium"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(180, 200, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextSize = 18
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
closeBtn.TextSize = 16
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -75, 0, 10)
minimizeBtn.Text = "─"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
minimizeBtn.TextSize = 16
minimizeBtn.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeBtn

-- Tabs
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(1, -20, 0, 40)
tabsFrame.Position = UDim2.new(0, 10, 0, 55)
tabsFrame.BackgroundTransparency = 1
tabsFrame.Parent = mainFrame

local tabs = {"Fitur", "Info"}
local tabButtons = {}

local function CreateTab(name, index)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5, -5, 1, 0)
    btn.Position = UDim2.new((index-1)*0.5, 0, 0, 0)
    btn.Text = name
    btn.Font = Enum.Font.GothamSemibold
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.TextSize = 14
    btn.BackgroundColor3 = name == MartinSC.CurrentTab and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(50, 50, 70)
    btn.AutoButtonColor = false
    btn.Parent = tabsFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    tabButtons[name] = btn
    return btn
end

-- Content Frame dengan Scrolling
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -20, 1, -110)
contentFrame.Position = UDim2.new(0, 10, 0, 100)
contentFrame.BackgroundTransparency = 1
contentFrame.ScrollBarThickness = 6
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 120, 255)
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
contentFrame.Parent = mainFrame

-- Toggle Constructor
local function CreatePremiumToggle(title, desc, pos, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 60)
    frame.Position = pos
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    frame.Parent = contentFrame
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local frameStroke = Instance.new("UIStroke")
    frameStroke.Color = Color3.fromRGB(60, 60, 80)
    frameStroke.Thickness = 1
    frameStroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 0.5, 0)
    label.Position = UDim2.new(0, 15, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = title
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(220, 220, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, -70, 0.5, 0)
    sub.Position = UDim2.new(0, 15, 0.5, -5)
    sub.BackgroundTransparency = 1
    sub.Text = desc
    sub.Font = Enum.Font.Gotham
    sub.TextColor3 = Color3.fromRGB(180, 180, 220)
    sub.TextSize = 11
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 25)
    btn.Position = UDim2.new(1, -60, 0.5, -12)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    btn.Text = "OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 12
    btn.AutoButtonColor = false
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local isOn = false
    btn.MouseButton1Click:Connect(function()
        isOn = not isOn
        btn.Text = isOn and "ON" or "OFF"
        btn.BackgroundColor3 = isOn and Color3.fromRGB(80, 160, 80) or Color3.fromRGB(60, 60, 80)
        btn.TextColor3 = isOn and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 100, 100)
        SafeCall(callback, isOn)
    end)

    return frame
end

-- Speed Control
local function CreateSpeedControl(pos)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 70)
    frame.Position = pos
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    frame.Parent = contentFrame
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local frameStroke = Instance.new("UIStroke")
    frameStroke.Color = Color3.fromRGB(60, 60, 80)
    frameStroke.Thickness = 1
    frameStroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.4, 0)
    label.Text = "WalkSpeed: " .. MartinSC.Speed
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(220, 220, 255)
    label.Parent = frame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -20, 0, 8)
    slider.Position = UDim2.new(0, 10, 0.6, 0)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    slider.Parent = frame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 4)
    sliderCorner.Parent = slider

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 20)
    knob.Position = UDim2.new(0, 0, -0.75, 0)
    knob.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
    knob.ZIndex = 2
    knob.Parent = slider
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 4)
    knobCorner.Parent = knob

    -- Update knob position
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

-- Tab System
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
        local totalHeight = 0
        
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

        contentFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)

    elseif tabName == "Info" then
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, 250)
        
        local infoFrame = Instance.new("Frame")
        infoFrame.Size = UDim2.new(1, 0, 0, 250)
        infoFrame.BackgroundTransparency = 1
        infoFrame.Parent = contentFrame

        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, 0, 0, 120)
        infoText.Position = UDim2.new(0, 0, 0, 20)
        infoText.BackgroundTransparency = 1
        infoText.TextColor3 = Color3.fromRGB(220, 220, 255)
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 14
        infoText.TextWrapped = true
        infoText.Text = "MartinSC Premium Suite\n\nVersion: 2.1\nDeveloper: Martin\nStatus: Premium"
        infoText.Parent = infoFrame

        -- Discord Button
        local discordBtn = Instance.new("TextButton")
        discordBtn.Size = UDim2.new(1, 0, 0, 40)
        discordBtn.Position = UDim2.new(0, 0, 0, 150)
        discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        discordBtn.Text = "Join Discord"
        discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        discordBtn.Font = Enum.Font.GothamBold
        discordBtn.TextSize = 14
        discordBtn.Parent = infoFrame
        
        local discordCorner = Instance.new("UICorner")
        discordCorner.CornerRadius = UDim.new(0, 8)
        discordCorner.Parent = discordBtn

        discordBtn.MouseButton1Click:Connect(function()
            setclipboard("martin.sc")
            Notif("Discord link copied: martin.sc")
        end)
    end
end

-- Create Tabs
for i, name in ipairs(tabs) do
    local btn = CreateTab(name, i)
    btn.MouseButton1Click:Connect(function()
        ShowTab(name)
    end)
end

-- Button Events
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

closeBtn.MouseButton1Click:Connect(function()
    if AutoFarm.Connection then
        AutoFarm.Connection:Disconnect()
    end
    if autoClickConnection then
        autoClickConnection:Disconnect()
    end
    screenGui:Destroy()
    Notif("MartinSC Closed")
end)

-- Initialize
ShowTab("Fitur")
Notif("MartinSC Premium Loaded Successfully!")
