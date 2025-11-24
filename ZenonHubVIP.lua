-- MartinSC Premium UI
-- Full Clean Version (Teleport Removed)

if game.CoreGui:FindFirstChild("MartinSC_UI") then
    game.CoreGui.MartinSC_UI:Destroy()
end

local MartinSC = {
    CurrentTab = "Fitur",
    AutoClick = false,
    NoAnim = false,
    FPSBoost = false,
    Speed = 1
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
-- AUTO FARM + WEBHOOK LOGGER (FITUR BARU)
---------------------------------------------------------

local AutoFarm = {
    Enabled = false,
    FishCount = 0,
    StartTime = 0
}

local WEBHOOK_URL = "" -- GANTI WEBHOOK DISINI

-- Webhook sender (Tipe B)
local function SendWebhook(title, message)
    if WEBHOOK_URL == "" then return end

    local data = {
        ["embeds"] = {{
            ["title"] = title,
            ["description"] = message,
            ["color"] = 5793266
        }}
    }

    local http = game:GetService("HttpService")
    syn.request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = http:JSONEncode(data)
    })
end

-- AutoFarm Logic
local function AutoFarmLoop()
    AutoFarm.StartTime = os.time()
    AutoFarm.FishCount = 0

    SendWebhook("AutoFarm Started", "Mode: Auto Lempar + Auto Tarik\nStatus: ON")

    task.spawn(function()
        while AutoFarm.Enabled do
            
            -- LEMPAR
            local cast = game.ReplicatedStorage:FindFirstChild("CastRod")
            if cast then
                cast:FireServer()
            end

            task.wait(math.random(13, 19)/10) -- 1.3–1.9sec

            -- TARIK
            local pull = game.ReplicatedStorage:FindFirstChild("PullRod")
            if pull then
                pull:FireServer()
                AutoFarm.FishCount += 1

                SendWebhook("Fish Caught", "Total: **" .. AutoFarm.FishCount .. "**")
            end

            task.wait(math.random(15, 24)/10)
        end

        -- Jika OFF
        local dur = os.time() - AutoFarm.StartTime
        SendWebhook("AutoFarm Stopped",
            "Durasi: **" .. dur .. " detik**\nTotal Ikan: **" .. AutoFarm.FishCount .. "**")
    end)
end

local function ToggleAutoFarm(state)
    AutoFarm.Enabled = state

    if state then
        Notif("AutoFarm ON")
        AutoFarmLoop()
    else
        Notif("AutoFarm OFF")
    end
end

---------------------------------------------------------
-- GUI
---------------------------------------------------------

local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "MartinSC_UI"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", header)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MartinSC Premium"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(180, 200, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextSize = 18

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 40, 1, 0)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(200, 100, 100)
closeBtn.BackgroundTransparency = 1
closeBtn.TextSize = 18

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 40, 1, 0)
minimizeBtn.Position = UDim2.new(1, -80, 0, 0)
minimizeBtn.Text = "─"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.TextSize = 18

-- Tabs
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(1, 0, 0, 40)
tabsFrame.Position = UDim2.new(0, 0, 0, 40)
tabsFrame.BackgroundTransparency = 1

local tabs = { "Fitur", "Info" }
local tabButtons = {}

local function CreateTab(name, index)
    local btn = Instance.new("TextButton", tabsFrame)
    btn.Size = UDim2.new(0.5, -10, 1, -10)
    btn.Position = UDim2.new((index-1)*0.5 + 0.02, 0, 0.1, 0)
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Instance.new("UICorner", btn)
    tabButtons[name] = btn
    return btn
end

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -100)
contentFrame.Position = UDim2.new(0, 10, 0, 90)
contentFrame.BackgroundTransparency = 1

-- Toggle Constructor
local function CreatePremiumToggle(title, desc, pos, callback)
    local frame = Instance.new("Frame", contentFrame)
    frame.Size = UDim2.new(1, 0, 0, 60)
    frame.Position = pos
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Instance.new("UICorner", frame)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -60, 0.5, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(200, 200, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local sub = Instance.new("TextLabel", frame)
    sub.Size = UDim2.new(1, -60, 0.5, 0)
    sub.Position = UDim2.new(0, 10, 0.5, -5)
    sub.BackgroundTransparency = 1
    sub.Text = desc
    sub.Font = Enum.Font.Gotham
    sub.TextColor3 = Color3.fromRGB(180, 180, 220)
    sub.TextSize = 12
    sub.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 45, 0, 25)
    btn.Position = UDim2.new(1, -55, 0.5, -12)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    btn.Text = "OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(200, 100, 100)
    btn.TextSize = 12
    Instance.new("UICorner", btn)

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.Text = on and "ON" or "OFF"
        btn.BackgroundColor3 = on and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(60, 60, 90)
        callback(on)
    end)

    return frame
end

-- Speed Control
local function CreateSpeedControl(pos)
    local frame = Instance.new("Frame", contentFrame)
    frame.Size = UDim2.new(1, 0, 0, 60)
    frame.Position = pos
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Instance.new("UICorner", frame)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 0.4, 0)
    label.Text = "WalkSpeed Controller"
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(200, 200, 255)

    local slider = Instance.new("Frame", frame)
    slider.Size = UDim2.new(1, -20, 0, 8)
    slider.Position = UDim2.new(0, 10, 0.6, 0)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    Instance.new("UICorner", slider)

    local knob = Instance.new("Frame", slider)
    knob.Size = UDim2.new(0, 12, 0, 20)
    knob.Position = UDim2.new(0, 0, -0.7, 0)
    knob.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
    Instance.new("UICorner", knob)

    local uis = game:GetService("UserInputService")

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local move
            move = uis.InputChanged:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseMovement then
                    local rel = math.clamp((inp.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                    knob.Position = UDim2.new(rel, -6, -0.7, 0)
                    MartinSC.Speed = 16 + (rel * 64)

                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.WalkSpeed = MartinSC.Speed
                    end
                end
            end)

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    move:Disconnect()
                end
            end)
        end
    end)

    return frame
end

---------------------------------------------------------
-- TAB SYSTEM
---------------------------------------------------------

local function ShowTab(tabName)
    MartinSC.CurrentTab = tabName

    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(40, 40, 60)
    end

    for _, c in ipairs(contentFrame:GetChildren()) do
        c:Destroy()
    end

    if tabName == "Fitur" then

        CreatePremiumToggle("No Animations", "Disable character animations", UDim2.new(0, 0, 0, 0), function(v)
            MartinSC.NoAnim = v
            Notif("No Animations: " .. tostring(v))
        end)

        CreatePremiumToggle("FPS Booster", "Increase performance", UDim2.new(0, 0, 0, 80), function(v)
            MartinSC.FPSBoost = v
            Notif("FPS Booster: " .. tostring(v))
        end)

        CreatePremiumToggle("Auto Click", "Automatic clicking", UDim2.new(0, 0, 0, 160), function(v)
            MartinSC.AutoClick = v
            Notif("Auto Click: " .. tostring(v))
        end)

        CreateSpeedControl(UDim2.new(0, 0, 0, 240))

        ---------------------------------------------------------
        -- FITUR BARU: AUTO FARM
        ---------------------------------------------------------
        CreatePremiumToggle("Auto Farm", "Auto Lempar & Tarik", UDim2.new(0, 0, 0, 320), function(v)
            ToggleAutoFarm(v)
        end)

    elseif tabName == "Info" then
        local info = Instance.new("TextLabel", contentFrame)
        info.Size = UDim2.new(1, 0, 1, 0)
        info.BackgroundTransparency = 1
        info.TextColor3 = Color3.fromRGB(200, 200, 255)
        info.Font = Enum.Font.Gotham
        info.TextSize = 16
        info.TextWrapped = true
        info.Text = "MartinSC Premium Suite\nVersion 1.0\nDeveloper: Martin"
        info.TextYAlignment = Enum.TextYAlignment.Center
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

-- Minimize
minimizeBtn.MouseButton1Click:Connect(function()
    if contentFrame.Visible then
        contentFrame.Visible = false
        tabsFrame.Visible = false
        mainFrame.Size = UDim2.new(0, 350, 0, 60)
        minimizeBtn.Text = "+"
    else
        contentFrame.Visible = true
        tabsFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 350, 0, 400)
        minimizeBtn.Text = "─"
    end
end)

-- Close
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    Notif("MartinSC Closed")
end)
