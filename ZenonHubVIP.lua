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

Notif("MartinSC Loaded!")

-- Config
local MartinSC = {
    NoAnimations = false,
    FPSBoost = false
}

-- UI Elegan Hitam
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "MartinSC_Main"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 280, 0, 200)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(60, 60, 70)
stroke.Thickness = 2

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MartinSC"
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
minimizeBtn.Position = UDim2.new(1, -60, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
minimizeBtn.Text = "_"
minimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16

local btnCorner = Instance.new("UICorner", minimizeBtn)
btnCorner.CornerRadius = UDim.new(0, 4)
local btnCorner2 = Instance.new("UICorner", closeBtn)
btnCorner2.CornerRadius = UDim.new(0, 4)

-- Content Area
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -45)
contentFrame.Position = UDim2.new(0, 10, 0, 40)
contentFrame.BackgroundTransparency = 1

-- No Animations Toggle
local animToggle = Instance.new("TextButton", contentFrame)
animToggle.Size = UDim2.new(1, 0, 0, 40)
animToggle.Position = UDim2.new(0, 0, 0, 10)
animToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
animToggle.Text = "❌ NO ANIMATIONS: OFF"
animToggle.TextColor3 = Color3.fromRGB(180, 180, 180)
animToggle.Font = Enum.Font.Gotham
animToggle.TextSize = 13

local animCorner = Instance.new("UICorner", animToggle)
animCorner.CornerRadius = UDim.new(0, 6)

local animStroke = Instance.new("UIStroke", animToggle)
animStroke.Color = Color3.fromRGB(60, 60, 70)
animStroke.Thickness = 1

-- FPS Boost Toggle
local fpsToggle = Instance.new("TextButton", contentFrame)
fpsToggle.Size = UDim2.new(1, 0, 0, 40)
fpsToggle.Position = UDim2.new(0, 0, 0, 60)
fpsToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
fpsToggle.Text = "❌ FPS BOOSTER: OFF"
fpsToggle.TextColor3 = Color3.fromRGB(180, 180, 180)
fpsToggle.Font = Enum.Font.Gotham
fpsToggle.TextSize = 13

local fpsCorner = Instance.new("UICorner", fpsToggle)
fpsCorner.CornerRadius = UDim.new(0, 6)

local fpsStroke = Instance.new("UIStroke", fpsToggle)
fpsStroke.Color = Color3.fromRGB(60, 60, 70)
fpsStroke.Thickness = 1

-- Status
local statusLabel = Instance.new("TextLabel", contentFrame)
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 110)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Ready"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- No Animations Function
local function ToggleAnimations()
    MartinSC.NoAnimations = not MartinSC.NoAnimations
    
    if MartinSC.NoAnimations then
        -- Disable animations
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("AnimationController") or part:IsA("Animator") then
                        part:Destroy()
                    end
                end
            end
        end
        
        -- Disable future animations
        game:GetService("Players").PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                if MartinSC.NoAnimations then
                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("AnimationController") or part:IsA("Animator") then
                            part:Destroy()
                        end
                    end
                end
            end)
        end)
        
        animToggle.Text = "✅ NO ANIMATIONS: ON"
        animToggle.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
        statusLabel.Text = "Animations Disabled"
        Notif("No Animations: ON")
    else
        animToggle.Text = "❌ NO ANIMATIONS: OFF"
        animToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        statusLabel.Text = "Animations Enabled"
        Notif("No Animations: OFF")
    end
end

-- FPS Boost Function
local function ToggleFPSBoost()
    MartinSC.FPSBoost = not MartinSC.FPSBoost
    
    if MartinSC.FPSBoost then
        -- Graphics settings
        settings().Rendering.QualityLevel = 1
        
        -- Disable unnecessary effects
        for _, effect in ipairs(workspace:GetDescendants()) do
            if effect:IsA("ParticleEmitter") or effect:IsA("Trail") or effect:IsA("Beam") then
                effect.Enabled = false
            end
        end
        
        -- Reduce terrain detail
        if workspace:FindFirstChildOfClass("Terrain") then
            workspace.Terrain.Decoration = false
        end
        
        fpsToggle.Text = "✅ FPS BOOSTER: ON"
        fpsToggle.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
        statusLabel.Text = "FPS Boost: ON"
        Notif("FPS Booster: ON")
    else
        -- Restore settings
        settings().Rendering.QualityLevel = 10
        
        -- Enable effects
        for _, effect in ipairs(workspace:GetDescendants()) do
            if effect:IsA("ParticleEmitter") or effect:IsA("Trail") or effect:IsA("Beam") then
                effect.Enabled = true
            end
        end
        
        -- Restore terrain
        if workspace:FindFirstChildOfClass("Terrain") then
            workspace.Terrain.Decoration = true
        end
        
        fpsToggle.Text = "❌ FPS BOOSTER: OFF"
        fpsToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        statusLabel.Text = "FPS Boost: OFF"
        Notif("FPS Booster: OFF")
    end
end

-- Button Events
animToggle.MouseButton1Click:Connect(ToggleAnimations)
fpsToggle.MouseButton1Click:Connect(ToggleFPSBoost)

-- Minimize Function
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        mainFrame.Size = UDim2.new(0, 280, 0, 35)
        contentFrame.Visible = false
        minimizeBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 280, 0, 200)
        contentFrame.Visible = true
        minimizeBtn.Text = "_"
    end
end)

-- Close Button
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    Notif("MartinSC Closed")
end)

Notif("MartinSC Ready - Drag to move")
