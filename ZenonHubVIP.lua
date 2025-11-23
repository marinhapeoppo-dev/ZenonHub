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

-- Cek game
if game.PlaceId ~= 121864768012064 then
    Notif("Game Tidak Didukung - Hanya Fish It")
    return
end

Notif("ZenonHub VIP Loaded!")

-- Buat UI yang proper
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "ZenonHubVIP_Main"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Variabel global untuk kontrol fitur
local ZenonHub = {
    AutoFarm = false,
    AutoSell = false,
    AutoUpgrade = false,
    AntiAFK = false,
    SelectedRod = "Basic Rod",
    FarmSpeed = 1
}

-- Warna theme
local colors = {
    Background = Color3.fromRGB(20, 25, 35),
    Header = Color3.fromRGB(0, 170, 255),
    TabActive = Color3.fromRGB(0, 140, 255),
    TabInactive = Color3.fromRGB(40, 50, 70),
    Button = Color3.fromRGB(0, 150, 255),
    ButtonText = Color3.fromRGB(255, 255, 255),
    Text = Color3.fromRGB(240, 240, 255)
}

-- Main Window (bisa di-drag)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 500)
mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
mainFrame.BackgroundColor3 = colors.Background
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = colors.Header
stroke.Thickness = 2

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = colors.Header

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🎣 ZENONHUB VIP - FISH IT"
title.TextColor3 = colors.ButtonText
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = colors.ButtonText
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14

local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0, 4)

-- Tab System
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(1, 0, 0, 40)
tabsFrame.Position = UDim2.new(0, 0, 0, 45)
tabsFrame.BackgroundTransparency = 1

local tabs = {"Auto Farm", "Auto Sell", "Upgrade", "Settings"}
local currentTab = "Auto Farm"

local function CreateTab(name, index)
    local tab = Instance.new("TextButton", tabsFrame)
    tab.Size = UDim2.new(0.25, -5, 1, 0)
    tab.Position = UDim2.new((index-1) * 0.25, 0, 0, 0)
    tab.BackgroundColor3 = name == currentTab and colors.TabActive or colors.TabInactive
    tab.Text = name
    tab.TextColor3 = colors.Text
    tab.Font = Enum.Font.Gotham
    tab.TextSize = 12
    
    local tabCorner = Instance.new("UICorner", tab)
    tabCorner.CornerRadius = UDim.new(0, 6)
    
    return tab
end

-- Content Area
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 0, 410)
contentFrame.Position = UDim2.new(0, 10, 0, 90)
contentFrame.BackgroundTransparency = 1

-- Function untuk switch tab
local function ShowTab(tabName)
    currentTab = tabName
    -- Clear content
    for _, child in ipairs(contentFrame:GetChildren()) do
        child:Destroy()
    end
    
    if tabName == "Auto Farm" then
        -- AUTO FARM TAB
        local farmToggle = Instance.new("TextButton", contentFrame)
        farmToggle.Size = UDim2.new(1, 0, 0, 40)
        farmToggle.Position = UDim2.new(0, 0, 0, 10)
        farmToggle.BackgroundColor3 = ZenonHub.AutoFarm and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        farmToggle.Text = ZenonHub.AutoFarm and "🟢 AUTO FARM AKTIF" or "🔴 AUTO FARM MATI"
        farmToggle.TextColor3 = colors.ButtonText
        farmToggle.Font = Enum.Font.GothamBold
        farmToggle.TextSize = 14
        
        local toggleCorner = Instance.new("UICorner", farmToggle)
        toggleCorner.CornerRadius = UDim.new(0, 6)
        
        farmToggle.MouseButton1Click:Connect(function()
            ZenonHub.AutoFarm = not ZenonHub.AutoFarm
            farmToggle.BackgroundColor3 = ZenonHub.AutoFarm and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            farmToggle.Text = ZenonHub.AutoFarm and "🟢 AUTO FARM AKTIF" or "🔴 AUTO FARM MATI"
            Notif(ZenonHub.AutoFarm and "Auto Farm Diaktifkan!" or "Auto Farm Dimatikan!")
            
            if ZenonHub.AutoFarm then
                -- Start auto farm
                coroutine.wrap(function()
                    while ZenonHub.AutoFarm and task.wait(ZenonHub.FarmSpeed) do
                        pcall(function()
                            -- Simulasi auto farm (ganti dengan code asli)
                            print("🎣 Memancing ikan...")
                        end)
                    end
                end)()
            end
        end)
        
        -- Speed Control
        local speedLabel = Instance.new("TextLabel", contentFrame)
        speedLabel.Size = UDim2.new(1, 0, 0, 25)
        speedLabel.Position = UDim2.new(0, 0, 0, 60)
        speedLabel.BackgroundTransparency = 1
        speedLabel.Text = "Kecepatan Farm: " .. ZenonHub.FarmSpeed .. "s"
        speedLabel.TextColor3 = colors.Text
        speedLabel.Font = Enum.Font.Gotham
        speedLabel.TextSize = 12
        speedLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local speedSlider = Instance.new("TextButton", contentFrame)
        speedSlider.Size = UDim2.new(1, 0, 0, 30)
        speedSlider.Position = UDim2.new(0, 0, 0, 90)
        speedSlider.BackgroundColor3 = colors.TabInactive
        speedSlider.Text = "Atur Kecepatan (1-10 detik)"
        speedSlider.TextColor3 = colors.Text
        speedSlider.Font = Enum.Font.Gotham
        speedSlider.TextSize = 12
        
        local sliderCorner = Instance.new("UICorner", speedSlider)
        sliderCorner.CornerRadius = UDim.new(0, 6)
        
        speedSlider.MouseButton1Click:Connect(function()
            ZenonHub.FarmSpeed = ZenonHub.FarmSpeed % 10 + 1
            speedLabel.Text = "Kecepatan Farm: " .. ZenonHub.FarmSpeed .. "s"
            Notif("Kecepatan: " .. ZenonHub.FarmSpeed .. " detik")
        end)
        
    elseif tabName == "Auto Sell" then
        -- AUTO SELL TAB
        local sellToggle = Instance.new("TextButton", contentFrame)
        sellToggle.Size = UDim2.new(1, 0, 0, 40)
        sellToggle.Position = UDim2.new(0, 0, 0, 10)
        sellToggle.BackgroundColor3 = ZenonHub.AutoSell and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        sellToggle.Text = ZenonHub.AutoSell and "🟢 AUTO SELL AKTIF" or "🔴 AUTO SELL MATI"
        sellToggle.TextColor3 = colors.ButtonText
        sellToggle.Font = Enum.Font.GothamBold
        sellToggle.TextSize = 14
        
        local toggleCorner = Instance.new("UICorner", sellToggle)
        toggleCorner.CornerRadius = UDim.new(0, 6)
        
        sellToggle.MouseButton1Click:Connect(function()
            ZenonHub.AutoSell = not ZenonHub.AutoSell
            sellToggle.BackgroundColor3 = ZenonHub.AutoSell and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            sellToggle.Text = ZenonHub.AutoSell and "🟢 AUTO SELL AKTIF" or "🔴 AUTO SELL MATI"
            Notif(ZenonHub.AutoSell and "Auto Sell Diaktifkan!" or "Auto Sell Dimatikan!")
        end)
        
        -- Info Auto Sell
        local infoLabel = Instance.new("TextLabel", contentFrame)
        infoLabel.Size = UDim2.new(1, 0, 0, 100)
        infoLabel.Position = UDim2.new(0, 0, 0, 60)
        infoLabel.BackgroundTransparency = 1
        infoLabel.Text = "Fitur Auto Sell akan otomatis menjual ikan yang didapat setiap 30 detik"
        infoLabel.TextColor3 = colors.Text
        infoLabel.Font = Enum.Font.Gotham
        infoLabel.TextSize = 12
        infoLabel.TextWrapped = true
        infoLabel.TextYAlignment = Enum.TextYAlignment.Top
        
    elseif tabName == "Upgrade" then
        -- UPGRADE TAB
        local upgradeToggle = Instance.new("TextButton", contentFrame)
        upgradeToggle.Size = UDim2.new(1, 0, 0, 40)
        upgradeToggle.Position = UDim2.new(0, 0, 0, 10)
        upgradeToggle.BackgroundColor3 = ZenonHub.AutoUpgrade and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        upgradeToggle.Text = ZenonHub.AutoUpgrade and "🟢 AUTO UPGRADE AKTIF" or "🔴 AUTO UPGRADE MATI"
        upgradeToggle.TextColor3 = colors.ButtonText
        upgradeToggle.Font = Enum.Font.GothamBold
        upgradeToggle.TextSize = 14
        
        local toggleCorner = Instance.new("UICorner", upgradeToggle)
        toggleCorner.CornerRadius = UDim.new(0, 6)
        
        upgradeToggle.MouseButton1Click:Connect(function()
            ZenonHub.AutoUpgrade = not ZenonHub.AutoUpgrade
            upgradeToggle.BackgroundColor3 = ZenonHub.AutoUpgrade and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            upgradeToggle.Text = ZenonHub.AutoUpgrade and "🟢 AUTO UPGRADE AKTIF" or "🔴 AUTO UPGRADE MATI"
            Notif(ZenonHub.AutoUpgrade and "Auto Upgrade Diaktifkan!" or "Auto Upgrade Dimatikan!")
        end)
        
        -- Rod Selection
        local rods = {"Basic Rod", "Advanced Rod", "Pro Rod", "VIP Rod"}
        local rodLabel = Instance.new("TextLabel", contentFrame)
        rodLabel.Size = UDim2.new(1, 0, 0, 25)
        rodLabel.Position = UDim2.new(0, 0, 0, 60)
        rodLabel.BackgroundTransparency = 1
        rodLabel.Text = "Pilih Rod: " .. ZenonHub.SelectedRod
        rodLabel.TextColor3 = colors.Text
        rodLabel.Font = Enum.Font.Gotham
        rodLabel.TextSize = 12
        rodLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local rodButton = Instance.new("TextButton", contentFrame)
        rodButton.Size = UDim2.new(1, 0, 0, 30)
        rodButton.Position = UDim2.new(0, 0, 0, 90)
        rodButton.BackgroundColor3 = colors.Button
        rodButton.Text = "Ganti Rod"
        rodButton.TextColor3 = colors.ButtonText
        rodButton.Font = Enum.Font.Gotham
        rodButton.TextSize = 12
        
        local rodCorner = Instance.new("UICorner", rodButton)
        rodCorner.CornerRadius = UDim.new(0, 6)
        
        rodButton.MouseButton1Click:Connect(function()
            local currentIndex = 1
            for i, rod in ipairs(rods) do
                if rod == ZenonHub.SelectedRod then
                    currentIndex = i
                    break
                end
            end
            ZenonHub.SelectedRod = rods[(currentIndex % #rods) + 1]
            rodLabel.Text = "Pilih Rod: " .. ZenonHub.SelectedRod
            Notif("Rod dipilih: " .. ZenonHub.SelectedRod)
        end)
        
    elseif tabName == "Settings" then
        -- SETTINGS TAB
        local afkToggle = Instance.new("TextButton", contentFrame)
        afkToggle.Size = UDim2.new(1, 0, 0, 40)
        afkToggle.Position = UDim2.new(0, 0, 0, 10)
        afkToggle.BackgroundColor3 = ZenonHub.AntiAFK and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        afkToggle.Text = ZenonHub.AntiAFK and "🟢 ANTI-AFK AKTIF" or "🔴 ANTI-AFK MATI"
        afkToggle.TextColor3 = colors.ButtonText
        afkToggle.Font = Enum.Font.GothamBold
        afkToggle.TextSize = 14
        
        local toggleCorner = Instance.new("UICorner", afkToggle)
        toggleCorner.CornerRadius = UDim.new(0, 6)
        
        afkToggle.MouseButton1Click:Connect(function()
            ZenonHub.AntiAFK = not ZenonHub.AntiAFK
            afkToggle.BackgroundColor3 = ZenonHub.AntiAFK and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            afkToggle.Text = ZenonHub.AntiAFK and "🟢 ANTI-AFK AKTIF" or "🔴 ANTI-AFK MATI"
            
            if ZenonHub.AntiAFK then
                -- Aktifkan Anti-AFK
                local VirtualUser = game:GetService("VirtualUser")
                game:GetService("Players").LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
                Notif("Anti-AFK Diaktifkan!")
            else
                Notif("Anti-AFK Dimatikan!")
            end
        end)
        
        -- Status Info
        local statusLabel = Instance.new("TextLabel", contentFrame)
        statusLabel.Size = UDim2.new(1, 0, 0, 120)
        statusLabel.Position = UDim2.new(0, 0, 0, 60)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Text = "STATUS FITUR:\n\n" ..
                          "Auto Farm: " .. (ZenonHub.AutoFarm and "🟢 AKTIF" or "🔴 MATI") .. "\n" ..
                          "Auto Sell: " .. (ZenonHub.AutoSell and "🟢 AKTIF" or "🔴 MATI") .. "\n" ..
                          "Auto Upgrade: " .. (ZenonHub.AutoUpgrade and "🟢 AKTIF" or "🔴 MATI") .. "\n" ..
                          "Anti-AFK: " .. (ZenonHub.AntiAFK and "🟢 AKTIF" or "🔴 MATI")
        statusLabel.TextColor3 = colors.Text
        statusLabel.Font = Enum.Font.Gotham
        statusLabel.TextSize = 12
        statusLabel.TextXAlignment = Enum.TextXAlignment.Left
        statusLabel.TextYAlignment = Enum.TextYAlignment.Top
    end
end

-- Buat tabs
for i, tabName in ipairs(tabs) do
    local tab = CreateTab(tabName, i)
    tab.MouseButton1Click:Connect(function()
        for _, otherTab in ipairs(tabsFrame:GetChildren()) do
            if otherTab:IsA("TextButton") then
                otherTab.BackgroundColor3 = colors.TabInactive
            end
        end
        tab.BackgroundColor3 = colors.TabActive
        ShowTab(tabName)
    end)
end

-- Close button
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    Notif("ZenonHub VIP Ditutup")
end)

-- Show default tab
ShowTab("Auto Farm")

Notif("ZenonHub VIP Ready! Window bisa di-drag")
