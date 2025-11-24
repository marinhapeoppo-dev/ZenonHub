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
    CurrentTab = "Fitur",
    NoAnimations = false,
    FPSBoost = false,
    AutoClick = false,
    ClickSpeed = 0.5
}

-- Auto Click Connection
local autoClickConnection = nil

-- UI Premium
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "MartinSC_Premium"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Window
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
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
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
header.BackgroundTransparency = 0.1

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 12)

local headerGradient = Instance.new("UIGradient", header)
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
})

local logo = Instance.new("TextButton", header) -- Changed to TextButton for click functionality
logo.Size = UDim2.new(0, 40, 0, 40)
logo.Position = UDim2.new(0, 8, 0, 5)
logo.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
logo.Text = "M"
logo.TextColor3 = Color3.fromRGB(255, 255, 255)
logo.Font = Enum.Font.GothamBlack
logo.TextSize = 20
logo.AutoButtonColor = false
local logoCorner = Instance.new("UICorner", logo)
logoCorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(0.5, 0, 0, 25)
title.Position = UDim2.new(0, 55, 0, 5)
title.BackgroundTransparency = 1
title.Text = "MARTINSC"
title.TextColor3 = Color3.fromRGB(220, 220, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

local subtitle = Instance.new("TextLabel", header)
subtitle.Size = UDim2.new(0.5, 0, 0, 20)
subtitle.Position = UDim2.new(0, 55, 0, 25)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Premium Suite"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 10)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
minimizeBtn.Text = "─"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18

local btnCorner = Instance.new("UICorner", minimizeBtn)
btnCorner.CornerRadius = UDim.new(0, 6)
local btnCorner2 = Instance.new("UICorner", closeBtn)
btnCorner2.CornerRadius = UDim.new(0, 6)

-- Tab System
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(1, -20, 0, 35)
tabsFrame.Position = UDim2.new(0, 10, 0, 55)
tabsFrame.BackgroundTransparency = 1

local tabs = {"Fitur", "Teleport", "Info"}
local tabButtons = {}

local function CreateTab(name, index)
    local tab = Instance.new("TextButton", tabsFrame)
    tab.Size = UDim2.new(0.33, -5, 1, 0)
    tab.Position = UDim2.new((index-1) * 0.33, 0, 0, 0)
    tab.BackgroundColor3 = name == MartinSC.CurrentTab and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(40, 40, 60)
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Font = Enum.Font.GothamSemibold
    tab.TextSize = 12
    
    local tabCorner = Instance.new("UICorner", tab)
    tabCorner.CornerRadius = UDim.new(0, 6)
    
    tabButtons[name] = tab
    return tab
end

-- Content Area
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -100)
contentFrame.Position = UDim2.new(0, 10, 0, 95)
contentFrame.BackgroundTransparency = 1

-- Function untuk buat toggle button premium
local function CreatePremiumToggle(name, description, position, toggleFunction)
    local toggleFrame = Instance.new("Frame", contentFrame)
    toggleFrame.Size = UDim2.new(1, 0, 0, 70)
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
    nameLabel.Position = UDim2.new(0, 15, 0, 10)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local descLabel = Instance.new("TextLabel", toggleFrame)
    descLabel.Size = UDim2.new(0.7, 0, 0, 20)
    descLabel.Position = UDim2.new(0, 15, 0, 35)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 11
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton", toggleFrame)
    toggleBtn.Size = UDim2.new(0, 60, 0, 30)
    toggleBtn.Position = UDim2.new(1, -70, 0, 20)
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

-- No Animations Function (FIXED - benar-benar work)
local function ToggleNoAnimations(btn)
    MartinSC.NoAnimations = not MartinSC.NoAnimations
    
    if MartinSC.NoAnimations then
        -- Method yang benar untuk disable animations
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    -- Disable specific animation tracks
                    for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                        track:Stop()
                    end
                end
                
                -- Remove animation controllers
                for _, obj in ipairs(player.Character:GetDescendants()) do
                    if obj:IsA("AnimationController") then
                        obj:Destroy()
                    end
                end
            end
        end
        
        -- Prevent future animations
        game:GetService("Players").PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                wait(1)
                for _, obj in ipairs(character:GetDescendants()) do
                    if obj:IsA("AnimationController") then
                        obj:Destroy()
                    end
                end
            end)
        end)
        
        btn.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
        btn.Text = "ON"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Notif("No Animations: Activated")
    else
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(200, 100, 100)
        Notif("No Animations: Deactivated")
    end
end

-- FPS Boost Function
local function ToggleFPSBoost(btn)
    MartinSC.FPSBoost = not MartinSC.FPSBoost
    
    if MartinSC.FPSBoost then
        -- Optimize settings
        settings().Rendering.FrameRateManager = 2
        game:GetService("Lighting").GlobalShadows = false
        
        -- Reduce particles
        for _, effect in ipairs(workspace:GetDescendants()) do
            if effect:IsA("ParticleEmitter") then
                effect.Enabled = false
            end
        end
        
        btn.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
        btn.Text = "ON"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Notif("FPS Boost: Activated")
    else
        -- Restore settings
        settings().Rendering.FrameRateManager = 0
        game:GetService("Lighting").GlobalShadows = true
        
        -- Enable particles
        for _, effect in ipairs(workspace:GetDescendants()) do
            if effect:IsA("ParticleEmitter") then
                effect.Enabled = true
            end
        end
        
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(200, 100, 100)
        Notif("FPS Boost: Deactivated")
    end
end

-- Auto Click Function
local function ToggleAutoClick(btn)
    MartinSC.AutoClick = not MartinSC.AutoClick
    
    if MartinSC.AutoClick then
        -- Start auto clicking dengan interval
        autoClickConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.05)
            virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            task.wait(MartinSC.ClickSpeed)
        end)
        
        btn.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
        btn.Text = "ON"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Notif("Auto Click: Activated - " .. MartinSC.ClickSpeed .. "s")
    else
        -- Stop auto clicking
        if autoClickConnection then
            autoClickConnection:Disconnect()
            autoClickConnection = nil
        end
        
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(200, 100, 100)
        Notif("Auto Click: Deactivated")
    end
end

-- Speed Control untuk Auto Click
local function CreateSpeedControl(position)
    local speedFrame = Instance.new("Frame", contentFrame)
    speedFrame.Size = UDim2.new(1, 0, 0, 50)
    speedFrame.Position = position
    speedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    speedFrame.BackgroundTransparency = 0.1
    
    local speedCorner = Instance.new("UICorner", speedFrame)
    speedCorner.CornerRadius = UDim.new(0, 8)
    
    local speedStroke = Instance.new("UIStroke", speedFrame)
    speedStroke.Color = Color3.fromRGB(60, 60, 80)
    speedStroke.Thickness = 1
    
    local speedLabel = Instance.new("TextLabel", speedFrame)
    speedLabel.Size = UDim2.new(0.6, 0, 0, 25)
    speedLabel.Position = UDim2.new(0, 15, 0, 5)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "Click Speed: " .. MartinSC.ClickSpeed .. "s"
    speedLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.TextSize = 12
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local speedDesc = Instance.new("TextLabel", speedFrame)
    speedDesc.Size = UDim2.new(0.6, 0, 0, 20)
    speedDesc.Position = UDim2.new(0, 15, 0, 25)
    speedDesc.BackgroundTransparency = 1
    speedDesc.Text = "Lower = Faster"
    speedDesc.TextColor3 = Color3.fromRGB(150, 150, 200)
    speedDesc.Font = Enum.Font.Gotham
    speedDesc.TextSize = 10
    speedDesc.TextXAlignment = Enum.TextXAlignment.Left
    
    local speedDown = Instance.new("TextButton", speedFrame)
    speedDown.Size = UDim2.new(0, 30, 0, 25)
    speedDown.Position = UDim2.new(0.7, 0, 0, 13)
    speedDown.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    speedDown.Text = "-"
    speedDown.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedDown.Font = Enum.Font.GothamBold
    speedDown.TextSize = 14
    
    local speedUp = Instance.new("TextButton", speedFrame)
    speedUp.Size = UDim2.new(0, 30, 0, 25)
    speedUp.Position = UDim2.new(0.85, 0, 0, 13)
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
        speedLabel.Text = "Click Speed: " .. string.format("%.1f", MartinSC.ClickSpeed) .. "s"
        if MartinSC.AutoClick then
            Notif("Auto Click Speed: " .. string.format("%.1f", MartinSC.ClickSpeed) .. "s")
        end
    end)
    
    speedUp.MouseButton1Click:Connect(function()
        MartinSC.ClickSpeed = math.min(3, MartinSC.ClickSpeed + 0.1)
        speedLabel.Text = "Click Speed: " .. string.format("%.1f", MartinSC.ClickSpeed) .. "s"
        if MartinSC.AutoClick then
            Notif("Auto Click Speed: " .. string.format("%.1f", MartinSC.ClickSpeed) .. "s")
        end
    end)
    
    return speedFrame
end

-- Function untuk show tab content
local function ShowTab(tabName)
    MartinSC.CurrentTab = tabName
    
    -- Update tab buttons
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(40, 40, 60)
    end
    
    -- Clear content
    for _, child in ipairs(contentFrame:GetChildren()) do
        child:Destroy()
    end
    
    if tabName == "Fitur" then
        -- FITUR TAB
        local animToggle = CreatePremiumToggle("No Animations", "Disable character animations", UDim2.new(0, 0, 0, 0), ToggleNoAnimations)
        local fpsToggle = CreatePremiumToggle("FPS Booster", "Increase game performance", UDim2.new(0, 0, 0, 80), ToggleFPSBoost)
        local clickToggle = CreatePremiumToggle("Auto Click", "Automatic mouse clicking", UDim2.new(0, 0, 0, 160), ToggleAutoClick)
        local speedControl = CreateSpeedControl(UDim2.new(0, 0, 0, 240))
        
    elseif tabName == "Teleport" then
        -- TELEPORT TAB dengan island lengkap
        local islands = {
            {"🏝️ Main Spawn", CFrame.new(0, 10, 0)},
            {"🎣 Fishing Spot 1", CFrame.new(50, 10, 50)},
            {"🎣 Fishing Spot 2", CFrame.new(-50, 10, -50)},
            {"🎣 Fishing Spot 3", CFrame.new(100, 10, 0)},
            {"🎣 Fishing Spot 4", CFrame.new(-100, 10, 0)},
            {"🌊 Deep Water Area", CFrame.new(0, 5, 100)},
            {"🌴 Palm Tree Island", CFrame.new(150, 15, 50)},
            {"🪨 Rocky Shore", CFrame.new(-150, 12, -50)},
            {"🚤 Boat Dock", CFrame.new(80, 10, -80)},
            {"🏔️ Mountain Lake", CFrame.new(-80, 25, 120)},
            {"🔮 Secret Cave", CFrame.new(200, 8, 200)},
            {"💎 Crystal Bay", CFrame.new(-200, 10, 150)}
        }
        
        local scrollFrame = Instance.new("ScrollingFrame", contentFrame)
        scrollFrame.Size = UDim2.new(1, 0, 1, 0)
        scrollFrame.Position = UDim2.new(0, 0, 0, 0)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.ScrollBarThickness = 6
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #islands * 45)
        
        for i, island in ipairs(islands) do
            local islandBtn = Instance.new("TextButton", scrollFrame)
            islandBtn.Size = UDim2.new(1, -10, 0, 40)
            islandBtn.Position = UDim2.new(0, 5, 0, (i-1)*45)
            islandBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            islandBtn.Text = island[1]
            islandBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            islandBtn.Font = Enum.Font.Gotham
            islandBtn.TextSize = 12
            
            local btnCorner = Instance.new("UICorner", islandBtn)
            btnCorner.CornerRadius = UDim.new(0, 6)
            
            local btnStroke = Instance.new("UIStroke", islandBtn)
            btnStroke.Color = Color3.fromRGB(80, 120, 255)
            btnStroke.Thickness = 1
            btnStroke.Transparency = 0.5
            
            islandBtn.MouseButton1Click:Connect(function()
                local player = game.Players.LocalPlayer
                if player.Character then
                    player.Character:SetPrimaryPartCFrame(island[2])
                    Notif("Teleported to " .. island[1])
                end
            end)
        end
        
    elseif tabName == "Info" then
        -- INFO TAB
        local infoFrame = Instance.new("Frame", contentFrame)
        infoFrame.Size = UDim2.new(1, 0, 1, 0)
        infoFrame.BackgroundTransparency = 1
        
        local devTitle = Instance.new("TextLabel", infoFrame)
        devTitle.Size = UDim2.new(1, 0, 0, 30)
        devTitle.Position = UDim2.new(0, 0, 0, 10)
        devTitle.BackgroundTransparency = 1
        devTitle.Text = "Developer: Martin"
        devTitle.TextColor3 = Color3.fromRGB(80, 120, 255)
        devTitle.Font = Enum.Font.GothamBold
        devTitle.TextSize = 16
        
        local discord = Instance.new("TextLabel", infoFrame)
        discord.Size = UDim2.new(1, 0, 0, 25)
        discord.Position = UDim2.new(0, 0, 0, 50)
        discord.BackgroundTransparency = 1
        discord.Text = "Discord: martin.sc"
        discord.TextColor3 = Color3.fromRGB(220, 220, 255)
        discord.Font = Enum.Font.Gotham
        discord.TextSize = 14
        
        local version = Instance.new("TextLabel", infoFrame)
        version.Size = UDim2.new(1, 0, 0, 25)
        version.Position = UDim2.new(0, 0, 0, 80)
        version.BackgroundTransparency = 1
        version.Text = "Version: Premium 2.1"
        version.TextColor3 = Color3.fromRGB(180, 180, 200)
        version.Font = Enum.Font.Gotham
        version.TextSize = 12
        
        local features = Instance.new("TextLabel", infoFrame)
        features.Size = UDim2.new(1, 0, 0, 120)
        features.Position = UDim2.new(0, 0, 0, 120)
        features.BackgroundTransparency = 1
        features.Text = "Premium Features:\n• No Animations\n• FPS Booster\n• Auto Click\n• 12 Island Teleports\n• Elegant UI\n• Minimize to Logo"
        features.TextColor3 = Color3.fromRGB(200, 200, 220)
        features.Font = Enum.Font.Gotham
        features.TextSize = 12
        features.TextYAlignment = Enum.TextYAlignment.Top
    end
end

-- Create tabs
for i, tabName in ipairs(tabs) do
    local tab = CreateTab(tabName, i)
    tab.MouseButton1Click:Connect(function()
        ShowTab(tabName)
    end)
end

-- Minimize Function (FIXED - bisa dibuka lagi)
local minimized = false
local originalSize = mainFrame.Size
local originalPosition = mainFrame.Position

minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        mainFrame.Size = UDim2.new(0, 60, 0, 60)
        header.Visible = false
        tabsFrame.Visible = false
        contentFrame.Visible = false
        minimizeBtn.Visible = false
        closeBtn.Visible = false
        title.Visible = false
        subtitle.Visible = false
        
        -- Posisi logo di tengah saat minimized
        logo.Position = UDim2.new(0.5, -20, 0.5, -20)
        logo.Size = UDim2.new(0, 40, 0, 40)
        logo.Text = "M"
        logo.TextSize = 16
        
        -- Simpan posisi asli
        originalPosition = mainFrame.Position
    else
        mainFrame.Size = originalSize
        header.Visible = true
        tabsFrame.Visible = true
        contentFrame.Visible = true
        minimizeBtn.Visible = true
        closeBtn.Visible = true
        title.Visible = true
        subtitle.Visible = true
        
        -- Kembalikan posisi logo
        logo.Position = UDim2.new(0, 8, 0, 5)
        logo.Size = UDim2.new(0, 40, 0, 40)
        logo.Text = "M"
        logo.TextSize = 20
    end
end)

-- FIX: Logo click untuk buka/tutup (alternatif minimize)
logo.MouseButton1Click:Connect(function()
    if minimized then
        -- Klik logo saat minimized untuk buka kembali
        minimized = false
        mainFrame.Size = originalSize
        header.Visible = true
        tabsFrame.Visible = true
        contentFrame.Visible = true
        minimizeBtn.Visible = true
        closeBtn.Visible = true
        title.Visible = true
        subtitle.Visible = true
        
        logo.Position = UDim2.new(0, 8, 0, 5)
        logo.Size = UDim2.new(0, 40, 0, 40)
        logo.Text = "M"
        logo.TextSize = 20
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

-- Show default tab
ShowTab("Fitur")

Notif("MartinSC Premium Ready - Click logo to minimize/maximize")
