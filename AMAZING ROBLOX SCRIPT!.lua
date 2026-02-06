-- MM2 Script by Jassy - FIXED VERSION
-- Simple, reliable, no external dependencies

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Create simple UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2Script"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔫 MM2 Script 🔫"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

-- Tab frame
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, -10, 1, -50)
tabFrame.Position = UDim2.new(0, 5, 0, 40)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = mainFrame

-- Create tabs
local tabs = {}
local tabNames = {"ESP", "Aimbot", "Misc", "Credits"}
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -10, 1, -80)
contentFrame.Position = UDim2.new(0, 5, 0, 70)
contentFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
contentFrame.BorderSizePixel = 1
contentFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
contentFrame.Parent = mainFrame

local contentY = 10
local function addElement(element)
    element.Position = UDim2.new(0, 10, 0, contentY)
    element.Parent = contentFrame
    contentY = contentY + element.Size.Y.Offset + 5
    return element
end

for i, tabName in ipairs(tabNames) do
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 95, 0, 30)
    tabButton.Position = UDim2.new(0, 5 + (i-1) * 100, 0, 0)
    tabButton.BackgroundColor3 = i == 1 and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.1, 0.1, 0.1)
    tabButton.BorderSizePixel = 1
    tabButton.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.TextScaled = true
    tabButton.Font = Enum.Font.SourceSans
    tabButton.Parent = tabFrame
    tabs[i] = tabButton
end

-- Notification function
local function notify(title, content)
    local msg = Instance.new("Message")
    msg.Text = title .. ": " .. content
    msg.Duration = 3
    msg.Parent = game:GetService("StarterGui")
end

-- Global variables
getgenv().ESPEnabled = false
getgenv().AimbotEnabled = false
getgenv().FlyEnabled = false
getgenv().NoclipEnabled = false
getgenv().CoinAutoFarmEnabled = false
getgenv().HitboxExpanderEnabled = false
getgenv().MagicBulletEnabled = false
getgenv().FlingEnabled = false
getgenv().VCBypassEnabled = false

-- ESP Toggle
local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(0, 180, 0, 30)
espToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
espToggle.BorderSizePixel = 1
espToggle.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
espToggle.Text = "🎯 ESP"
espToggle.TextColor3 = Color3.new(1, 1, 1)
espToggle.TextScaled = true
espToggle.Font = Enum.Font.SourceSans
espToggle.Parent = contentFrame
espToggle.MouseButton1Click:Connect(function()
    getgenv().ESPEnabled = not getgenv().ESPEnabled
    espToggle.BackgroundColor3 = getgenv().ESPEnabled and Color3.new(0, 0.5, 0) or Color3.new(0.2, 0.2, 0.2)
    notify("ESP", getgenv().ESPEnabled and "Enabled" or "Disabled")
end)
addElement(espToggle)

-- Aimbot Toggle
local aimbotToggle = Instance.new("TextButton")
aimbotToggle.Size = UDim2.new(0, 180, 0, 30)
aimbotToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
aimbotToggle.BorderSizePixel = 1
aimbotToggle.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
aimbotToggle.Text = "🎯 Aimbot"
aimbotToggle.TextColor3 = Color3.new(1, 1, 1)
aimbotToggle.TextScaled = true
aimbotToggle.Font = Enum.Font.SourceSans
aimbotToggle.Parent = contentFrame
aimbotToggle.MouseButton1Click:Connect(function()
    getgenv().AimbotEnabled = not getgenv().AimbotEnabled
    aimbotToggle.BackgroundColor3 = getgenv().AimbotEnabled and Color3.new(0, 0.5, 0) or Color3.new(0.2, 0.2, 0.2)
    notify("Aimbot", getgenv().AimbotEnabled and "Enabled" or "Disabled")
end)
addElement(aimbotToggle)

-- Fly Toggle
local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(0, 180, 0, 30)
flyToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
flyToggle.BorderSizePixel = 1
flyToggle.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
flyToggle.Text = "✈ Fly"
flyToggle.TextColor3 = Color3.new(1, 1, 1)
flyToggle.TextScaled = true
flyToggle.Font = Enum.Font.SourceSans
flyToggle.Parent = contentFrame
flyToggle.MouseButton1Click:Connect(function()
    getgenv().FlyEnabled = not getgenv().FlyEnabled
    flyToggle.BackgroundColor3 = getgenv().FlyEnabled and Color3.new(0, 0.5, 0) or Color3.new(0.2, 0.2, 0.2)
    notify("Fly", getgenv().FlyEnabled and "Enabled" or "Disabled")
    
    if getgenv().FlyEnabled then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            
            getgenv().FlyBV = Instance.new("BodyVelocity")
            getgenv().FlyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            getgenv().FlyBV.P = 5000
            getgenv().FlyBV.Velocity = Vector3.new(0, 0, 0)
            getgenv().FlyBV.Parent = hrp
            
            getgenv().FlyBG = Instance.new("BodyGyro")
            getgenv().FlyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            getgenv().FlyBG.P = 20000
            getgenv().FlyBG.CFrame = hrp.CFrame
            getgenv().FlyBG.Parent = hrp
        end
    else
        if getgenv().FlyBV then
            getgenv().FlyBV:Destroy()
            getgenv().FlyBV = nil
        end
        if getgenv().FlyBG then
            getgenv().FlyBG:Destroy()
            getgenv().FlyBG = nil
        end
    end
end)
addElement(flyToggle)

-- Noclip Toggle
local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0, 180, 0, 30)
noclipToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
noclipToggle.BorderSizePixel = 1
noclipToggle.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
noclipToggle.Text = "🚫 NoClip"
noclipToggle.TextColor3 = Color3.new(1, 1, 1)
noclipToggle.TextScaled = true
noclipToggle.Font = Enum.Font.SourceSans
noclipToggle.Parent = contentFrame
noclipToggle.MouseButton1Click:Connect(function()
    getgenv().NoclipEnabled = not getgenv().NoclipEnabled
    noclipToggle.BackgroundColor3 = getgenv().NoclipEnabled and Color3.new(0, 0.5, 0) or Color3.new(0.2, 0.2, 0.2)
    notify("NoClip", getgenv().NoclipEnabled and "Enabled" or "Disabled")
    
    if getgenv().NoclipEnabled then
        game:GetService("RunService").Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)
addElement(noclipToggle)

-- Coin Auto Farm Toggle
local coinFarmToggle = Instance.new("TextButton")
coinFarmToggle.Size = UDim2.new(0, 180, 0, 30)
coinFarmToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
coinFarmToggle.BorderSizePixel = 1
coinFarmToggle.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
coinFarmToggle.Text = "🪙 Coin Farm"
coinFarmToggle.TextColor3 = Color3.new(1, 1, 1)
coinFarmToggle.TextScaled = true
coinFarmToggle.Font = Enum.Font.SourceSans
coinFarmToggle.Parent = contentFrame
coinFarmToggle.MouseButton1Click:Connect(function()
    getgenv().CoinAutoFarmEnabled = not getgenv().CoinAutoFarmEnabled
    coinFarmToggle.BackgroundColor3 = getgenv().CoinAutoFarmEnabled and Color3.new(0, 0.5, 0) or Color3.new(0.2, 0.2, 0.2)
    notify("Coin Farm", getgenv().CoinAutoFarmEnabled and "Enabled" or "Disabled")
    
    if getgenv().CoinAutoFarmEnabled then
        game:GetService("RunService").Heartbeat:Connect(function()
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local originalPos = hrp.Position
                
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj:IsA("Part") and (obj.Name:find("Coin") or obj.Name:find("Money") or obj.BrickColor == BrickColor.new("Bright yellow")) then
                        local distance = (obj.Position - hrp.Position).Magnitude
                        if distance <= 500 then
                            hrp.Position = obj.Position
                            task.wait(0.1)
                            obj:Destroy()
                            hrp.Position = originalPos
                            notify("Coin Farm", "Collected coin!")
                            break
                        end
                    end
                end
            end
        end)
    end
end)
addElement(coinFarmToggle)

print("MM2 Script Loaded Successfully!")
