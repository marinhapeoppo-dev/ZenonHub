local function Notif(text)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "MartinSC",
            Text = text,
            Icon = "rbxassetid://123767073052336",
            Duration = 3
        })
    end)
end

-- Cek game
if game.PlaceId ~= 121864768012064 then
    Notif("Hanya untuk Fish It!")
    return
end

Notif("MartinSC Premium Loaded!")

-- Config
local MartinSC = {
    NoAnimations = false,
    FPSBoost = false,
    AutoClick = false,
    ClickSpeed = 1
}

-- UI Premium
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "MartinSC_Premium"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 320, 0, 280)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 12)

local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 12))
})

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(80, 120, 255)
stroke.Thickness = 2
stroke.Transparency = 0.3

-- Header Premium
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
header.BackgroundTransparency = 0.1

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 12)

local headerGradient = Instance.new("UIGradient", header)
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
})

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MARTINSC PREMIUM"
title.TextColor3 = Color3.fromRGB(220, 220, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local subtitle = Instance.new("TextLabel", header)
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 15, 0, 20)
title.BackgroundTransparency = 1
title.Text = "Performance Suite"
title.TextColor3 = Color3.fromRGB(150, 150, 200)
title.Font = Enum.Font.Gotham
title.TextSize = 11
title.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 8)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
minimizeBtn.Text = "─"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18

local btnCorner = Instance.new("UICorner", minimizeBtn)
btnCorner.CornerRadius = UDim.new(0, 6)
local btnCorner2 = Instance.new("UICorner", closeBtn)
btnCorner2.CornerRadius = UDim.new(0, 6)

-- Content Area
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -55)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1

-- Function untuk buat toggle button premium
local function CreatePremiumToggle(name, description, position, toggleFunction)
    local toggleFrame = Instance.new("Frame", contentFrame)
    toggleFrame.Size = UDim2.new(1, 0, 0, 60)
    toggleFrame.Position = position
    toggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    toggleFrame.BackgroundTransparency = 0.1
    
    local toggleCorner = Instance.new("UICorner", toggleFrame)
    toggleCorner.CornerRadius = UDim.new(0, 8)
    
    local toggleStroke = Instance.new("UIStroke", toggleFrame)
    toggleStroke.Color = Color3.fromRGB(60, 60, 80)
    toggleStroke.Thickness = 1
    
    local nameLabel = Instance.new("TextLabel", toggleFrame)
    nameLabel.Size = UDim2.new(0.7, 0, 0, 25)
    nameLabel.Position = UDim2.new(0, 10, 0, 8)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local descLabel = Instance.new("TextLabel", toggleFrame)
    descLabel.Size = UDim2.new(0.7, 0, 0, 20)
    descLabel.Position = UDim2.new(0, 10, 0, 30)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 11
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton", toggleFrame)
    toggleBtn.Size = UDim2.new(0, 80, 0, 30)
    toggleBtn.Position = UDim2.new(1, -90, 0, 15)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(200, 100, 100)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 12
    
    local btnCorner = Instance.new("UICorner", toggleBtn)
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    toggleBtn.MouseButton1Click:Connect(function()
        toggleFunction(toggleBtn)
    end)
    
    return toggleBtn
end

-- No Animations Function (Improved - tidak jelekan texture)
local function ToggleNoAnimations(btn)
    MartinSC.NoAnimations = not MartinSC.NoAnimations
    
    if MartinSC.NoAnimations then
        -- Hanya disable character animations tanpa pengaruhi texture
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
                end
            end
        end
        
        btn.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
        btn.Text = "ON"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLabel.Text = "No Animations: Active"
        Notif("Smooth Animations: ON")
    else
        -- Restore animations
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                end
            end
        end
        
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(200, 100, 100)
        statusLabel.Text = "No Animations: Inactive"
        Notif("Smooth Animations: OFF")
    end
end

-- FPS Boost Function (Improved - tidak jelekan texture)
local function ToggleFPSBoost(btn)
    MartinSC.FPSBoost = not MartinSC.FPSBoost
    
    if MartinSC.FPSBoost then
        -- Optimize settings tanpa mengubah texture quality
        settings().Rendering.FrameRateManager = 2 -- 60 FPS cap
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FantasySky.Enabled = false
        
        -- Reduce particles tanpa mempengaruhi texture utama
        for _, effect in ipairs(workspace:GetDescendants()) do
            if effect:IsA("ParticleEmitter") then
                effect.Rate = math.min(effect.Rate, 10)
            end
        end
        
        btn.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
        btn.Text = "ON"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLabel.Text = "FPS Boost: Active"
        Notif("Performance Boost: ON")
    else
        -- Restore settings
        settings().Rendering.FrameRateManager = 0
        game:GetService("Lighting").GlobalShadows = true
        
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(200, 100, 100)
        statusLabel.Text = "FPS Boost: Inactive"
        Notif("Performance Boost: OFF")
    end
end

-- Auto Click Function
local autoClickConnection = nil

local function ToggleAutoClick(btn)
    MartinSC.AutoClick = not MartinSC.AutoClick
    
    if MartinSC.AutoClick then
        -- Start auto clicking
        autoClickConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.01)
            virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end)
        
        btn.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
        btn.Text = "ON"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLabel.Text = "Auto Click: Active - " .. MartinSC.ClickSpeed .. "s"
        Notif("Auto Click: ON - " .. MartinSC.ClickSpeed .. "s interval")
    else
        -- Stop auto clicking
        if autoClickConnection then
            autoClickConnection:Disconnect()
            autoClickConnection = nil
        end
        
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(200, 100, 100)
        statusLabel.Text = "Auto Click: Inactive"
        Notif("Auto Click: OFF")
    end
end

-- Speed Control untuk Auto Click
local function CreateSpeedControl(position)
    local speedFrame = Instance.new("Frame", contentFrame)
    speedFrame.Size = UDim2.new(1, 0, 0, 40)
    speedFrame.Position = position
    speedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    speedFrame.BackgroundTransparency = 0.1
    
    local speedCorner = Instance.new("UICorner", speedFrame)
    speedCorner.CornerRadius = UDim.new(0, 6)
    
    local speedLabel = Instance.new("TextLabel", speedFrame)
    speedLabel.Size = UDim2.new(0.6, 0, 1, 0)
    speedLabel.Position = UDim2.new(0, 10, 0, 0)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "Click Interval: " .. MartinSC.ClickSpeed .. "s"
    speedLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.TextSize = 12
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local speedDown = Instance.new("TextButton", speedFrame)
    speedDown.Size = UDim2.new(0, 30, 0, 25)
    speedDown.Position = UDim2.new(0.65, 0, 0, 8)
    speedDown.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    speedDown.Text = "-"
    speedDown.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedDown.Font = Enum.Font.GothamBold
    speedDown.TextSize = 14
    
    local speedUp = Instance.new("TextButton", speedFrame)
    speedUp.Size = UDim2.new(0, 30, 0, 25)
    speedUp.Position = UDim2.new(0.8, 0, 0, 8)
    speedUp.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    speedUp.Text = "+"
    speedUp.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedUp.Font = Enum.Font.GothamBold
    speedUp.TextSize = 14
    
    local btnCorner = Instance.new("UICorner", speedDown)
    btnCorner.CornerRadius = UDim.new(0, 4)
    local btnCorner2 = Instance.new("UICorner", speedUp)
    btnCorner2.CornerRadius = UDim.new(0, 4)
    
    speedDown.MouseButton1Click:Connect(function()
        MartinSC.ClickSpeed = math.max(0.1, MartinSC.ClickSpeed - 0.1)
        speedLabel.Text = "Click Interval: " .. string.format("%.1f", MartinSC.ClickSpeed) .. "s"
        if MartinSC.AutoClick then
            statusLabel.Text = "Auto Click: Active - " .. string.format("%.1f", MartinSC.ClickSpeed) .. "s"
        end
    end)
    
    speedUp.MouseButton1Click:Connect(function()
        MartinSC.ClickSpeed = math.min(5, MartinSC.ClickSpeed + 0.1)
        speedLabel.Text = "Click Interval: " .. string.format("%.1f", MartinSC.ClickSpeed) .. "s"
        if MartinSC.AutoClick then
            statusLabel.Text = "Auto Click: Active - " .. string.format("%.1f", MartinSC.ClickSpeed) .. "s"
        end
    end)
    
    return speedFrame
end

-- Status Label
local statusLabel = Instance.new("TextLabel", contentFrame)
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 230)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: System Ready"
statusLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Create Toggles
local animToggle = CreatePremiumToggle("Smooth Animations", "Optimize character movements", UDim2.new(0, 0, 0, 0), ToggleNoAnimations)
local fpsToggle = CreatePremiumToggle("Performance Boost", "Increase FPS & reduce lag", UDim2.new(0, 0, 0, 70), ToggleFPSBoost)
local clickToggle = CreatePremiumToggle("Auto Click", "Automatic mouse clicking", UDim2.new(0, 0, 0, 140), ToggleAutoClick)

-- Speed Control
local speedControl = CreateSpeedControl(UDim2.new(0, 0, 0, 190))

-- Minimize Function (Fixed - tidak ikut analog)
local minimized = false
local originalSize = mainFrame.Size
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        mainFrame.Size = UDim2.new(0, 320, 0, 45)
        contentFrame.Visible = false
        mainFrame.Draggable = true -- Tetap bisa drag meski minimized
        minimizeBtn.Text = "+"
    else
        mainFrame.Size = originalSize
        contentFrame.Visible = true
        minimizeBtn.Text = "─"
    end
end)

-- Close Button
closeBtn.MouseButton1Click:Connect(function()
    -- Cleanup
    if autoClickConnection then
        autoClickConnection:Disconnect()
    end
    screenGui:Destroy()
    Notif("MartinSC Premium Closed")
end)

Notif("MartinSC Premium Ready - Drag header to move")
