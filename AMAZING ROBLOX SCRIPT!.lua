-- Made by Jassy ❤
-- Property of ScriptForge ❤

-- Simple UI Creation (NO EXTERNAL DEPENDENCIES)
local function createUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MM2Script"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
    mainFrame.Parent = screenGui
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🔫 MM2 Script 🔫"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.Parent = mainFrame
    
    -- Tab Frame
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = "TabFrame"
    tabFrame.Size = UDim2.new(1, -10, 1, -50)
    tabFrame.Position = UDim2.new(0, 5, 0, 40)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Parent = mainFrame
    
    -- Tab Buttons
    local tabs = {}
    local tabNames = {"ESP", "Aimbot", "Misc", "Credits"}
    
    for i, tabName in ipairs(tabNames) do
        local tabButton = Instance.new("TextButton")
        tabButton.Name = "TabButton" .. i
        tabButton.Size = UDim2.new(0, 120, 0, 30)
        tabButton.Position = UDim2.new(0, 5 + (i-1) * 125, 0, 0)
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
    
    -- Content Frame
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -10, 1, -80)
    contentFrame.Position = UDim2.new(0, 5, 0, 70)
    contentFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    contentFrame.BorderSizePixel = 1
    contentFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    contentFrame.Parent = mainFrame
    
    -- Content positioning
    local contentY = 10
    local function addElement(element)
        element.Position = UDim2.new(0, 10, 0, contentY)
        element.Parent = contentFrame
        contentY = contentY + element.Size.Y.Offset + 5
        return element
    end
    
    -- Notification function
    local function notify(title, content, duration)
        local notification = Instance.new("Message")
        notification.Text = title .. ": " .. content
        notification.Duration = duration or 3
        notification.Parent = game:GetService("StarterGui")
    end
    
    return {
        CreateTab = function(config)
            return tabs[config.Index or 1]
        end,
        
        ESP = tabs[1],
        Aimbot = tabs[2],
        Misc = tabs[3],
        Credits = tabs[4],
        
        ContentFrame = contentFrame,
        AddElement = addElement,
        Notify = notify,
        
        CreateToggle = function(config)
            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(0, 200, 0, 30)
            toggle.BackgroundColor3 = config.CurrentValue and Color3.new(0, 0.5, 0) or Color3.new(0.2, 0.2, 0.2)
            toggle.BorderSizePixel = 1
            toggle.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
            toggle.Text = config.Name or "Toggle"
            toggle.TextColor3 = Color3.new(1, 1, 1)
            toggle.TextScaled = true
            toggle.Font = Enum.Font.SourceSans
            toggle.Parent = contentFrame
            
            toggle.MouseButton1Click:Connect(function()
                config.CurrentValue = not config.CurrentValue
                toggle.BackgroundColor3 = config.CurrentValue and Color3.new(0, 0.5, 0) or Color3.new(0.2, 0.2, 0.2)
                if config.Callback then
                    config.Callback(config.CurrentValue)
                end
            end)
            
            return addElement(toggle)
        end,
        
        CreateSlider = function(config)
            local slider = Instance.new("Frame")
            slider.Size = UDim2.new(0, 200, 0, 40)
            slider.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            slider.BorderSizePixel = 1
            slider.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
            slider.Parent = contentFrame
            
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(0, 180, 0, 20)
            sliderLabel.Position = UDim2.new(0, 10, 0, 0)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = config.Name or "Slider: " .. (config.CurrentValue or 0)
            sliderLabel.TextColor3 = Color3.new(1, 1, 1)
            sliderLabel.TextScaled = true
            sliderLabel.Font = Enum.Font.SourceSans
            sliderLabel.Parent = slider
            
            local sliderButton = Instance.new("TextButton")
            sliderButton.Size = UDim2.new(0, 20, 1, 0)
            sliderButton.Position = UDim2.new(0, 190, 0, 0)
            sliderButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            sliderButton.BorderSizePixel = 0
            sliderButton.Text = "◀"
            sliderButton.TextColor3 = Color3.new(1, 1, 1)
            sliderButton.TextScaled = true
            sliderButton.Font = Enum.Font.SourceSans
            sliderButton.Parent = slider
            
            local sliderButton2 = Instance.new("TextButton")
            sliderButton2.Size = UDim2.new(0, 20, 1, 0)
            sliderButton2.Position = UDim2.new(0, 0, 0, 0)
            sliderButton2.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            sliderButton2.BorderSizePixel = 0
            sliderButton2.Text = "▶"
            sliderButton2.TextColor3 = Color3.new(1, 1, 1)
            sliderButton2.TextScaled = true
            sliderButton2.Font = Enum.Font.SourceSans
            sliderButton2.Parent = slider
            
            sliderButton.MouseButton1Click:Connect(function()
                local newValue = config.CurrentValue - (config.Increment or 1)
                if newValue >= (config.Min or 0) then
                    config.CurrentValue = newValue
                    sliderLabel.Text = config.Name .. ": " .. config.CurrentValue
                    if config.Callback then
                        config.Callback(config.CurrentValue)
                    end
                end
            end)
            
            sliderButton2.MouseButton1Click:Connect(function()
                local newValue = config.CurrentValue + (config.Increment or 1)
                if newValue <= (config.Max or 100) then
                    config.CurrentValue = newValue
                    sliderLabel.Text = config.Name .. ": " .. config.CurrentValue
                    if config.Callback then
                        config.Callback(config.CurrentValue)
                    end
                end
            end)
            
            return addElement(slider)
        end,
        
        CreateButton = function(config)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 200, 0, 30)
            button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            button.BorderSizePixel = 1
            button.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
            button.Text = config.Name or "Button"
            button.TextColor3 = Color3.new(1, 1, 1)
            button.TextScaled = true
            button.Font = Enum.Font.SourceSans
            button.Parent = contentFrame
            
            button.MouseButton1Click:Connect(config.Callback or function() end)
            
            return addElement(button)
        end,
        
        CreateLabel = function(config)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 200, 0, 20)
            label.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
            label.BorderSizePixel = 0
            label.Text = config.Text or "Label"
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextScaled = true
            label.Font = Enum.Font.SourceSans
            label.Parent = contentFrame
            
            return addElement(label)
        end,
        
        CreateDropdown = function(config)
            local dropdown = Instance.new("TextButton")
            dropdown.Size = UDim2.new(0, 200, 0, 30)
            dropdown.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            dropdown.BorderSizePixel = 1
            dropdown.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
            dropdown.Text = (config.CurrentOption or config.Options[1]) .. " ▼"
            dropdown.TextColor3 = Color3.new(1, 1, 1)
            dropdown.TextScaled = true
            dropdown.Font = Enum.Font.SourceSans
            dropdown.Parent = contentFrame
            
            local isOpen = false
            local optionsFrame = Instance.new("Frame")
            optionsFrame.Size = UDim2.new(0, 200, 0, #config.Options * 25)
            optionsFrame.Position = UDim2.new(0, 0, 0, 30)
            optionsFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            optionsFrame.BorderSizePixel = 1
            optionsFrame.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
            optionsFrame.Visible = false
            optionsFrame.Parent = contentFrame
            
            for i, option in ipairs(config.Options) do
                local optionButton = Instance.new("TextButton")
                optionButton.Size = UDim2.new(1, -10, 0, 25)
                optionButton.Position = UDim2.new(0, 5, 0, (i-1) * 25)
                optionButton.BackgroundColor3 = option == (config.CurrentOption or config.Options[1]) and Color3.new(0, 0.5, 0) or Color3.new(0.1, 0.1, 0.1)
                optionButton.BorderSizePixel = 0
                optionButton.Text = option
                optionButton.TextColor3 = Color3.new(1, 1, 1)
                optionButton.TextScaled = true
                optionButton.Font = Enum.Font.SourceSans
                optionButton.Parent = optionsFrame
                
                optionButton.MouseButton1Click:Connect(function()
                    config.CurrentOption = option
                    dropdown.Text = option .. " ▼"
                    isOpen = false
                    optionsFrame.Visible = false
                    if config.Callback then
                        config.Callback(option)
                    end
                    
                    -- Update button colors
                    for _, child in pairs(optionsFrame:GetChildren()) do
                        if child:IsA("TextButton") then
                            child.BackgroundColor3 = child.Text == option and Color3.new(0, 0.5, 0) or Color3.new(0.1, 0.1, 0.1)
                        end
                    end
                end)
            end
            
            dropdown.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                optionsFrame.Visible = isOpen
            end)
            
            return addElement(dropdown)
        end
    }
end

-- Create UI
local UI = createUI()
print("UI Created Successfully")

-- Anti-Cheat Bypass
local function bypassAntiCheat()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        
        -- Prevent position validation
        hrp.Changed:Connect(function(property)
            if property == "Position" then
                hrp.Position = hrp.Position
            end
        end)
        
        -- Bypass teleport detection
        local oldTeleport = hrp.Position
        game:GetService("RunService").Heartbeat:Connect(function()
            if (hrp.Position - oldTeleport).Magnitude > 50 then
                oldTeleport = hrp.Position
            end
        end)
        
        -- Bypass speed detection
        game:GetService("RunService").Stepped:Connect(function()
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid.MoveDirection.Magnitude > 0 then
                    humanoid.WalkSpeed = math.min(humanoid.WalkSpeed, 50)
                end
            end
        end)
    end
end

-- Activate bypass
bypassAntiCheat()

-- ESP Tab 🎯
local ESPTab = UI.ESP

-- Role ESP Toggle 🔴
ESPTab:CreateToggle({
    Name = "🔴 Role ESP",
    CurrentValue = false,
    Callback = function(value)
        getgenv().RoleESPEnabled = value
    end,
})

-- Name ESP Toggle 📝
ESPTab:CreateToggle({
    Name = "📝 Name ESP",
    CurrentValue = false,
    Callback = function(value)
        getgenv().NameESPEnabled = value
    end,
})

-- Distance ESP Toggle 📏
ESPTab:CreateToggle({
    Name = "📏 Distance ESP",
    CurrentValue = false,
    Callback = function(value)
        getgenv().DistanceESPEnabled = value
    end,
})

-- ESP Folder for Highlights
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "MM2_RoleESP_Highlights"
ESPFolder.Parent = game.CoreGui

-- Name ESP Folder
local NameESPFolder = Instance.new("Folder")
NameESPFolder.Name = "MM2_NameESP"
NameESPFolder.Parent = game.CoreGui

-- Track Player Function
local function TrackPlayer(player)
    -- Role ESP Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name .. "_RoleESP"
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = ESPFolder

    -- Name ESP Billboard
    local billboard = Instance.new("BillboardGui")
    billboard.Name = player.Name .. "_NameESP"
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = NameESPFolder

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Parent = billboard

    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = ""
    distanceLabel.TextColor3 = Color3.new(1, 1, 0)
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.TextScaled = true
    distanceLabel.Font = Enum.Font.SourceSans
    distanceLabel.Parent = billboard

    coroutine.wrap(function()
        while player and player.Parent do
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    highlight.Adornee = char
                    billboard.Adornee = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                    
                    -- Check for weapons to determine role
                    local knife = char:FindFirstChild("Knife") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Knife"))
                    local gun = char:FindFirstChild("Gun") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Gun"))
                    
                    if knife then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Murderer (Red)
                        nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    elseif gun then
                        highlight.FillColor = Color3.fromRGB(0, 0, 255) -- Sheriff (Blue)
                        nameLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Innocent (Green)
                        nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    end
                    
                    -- Calculate distance
                    local localChar = game.Players.LocalPlayer.Character
                    if localChar and localChar:FindFirstChild("HumanoidRootPart") then
                        local distance = (char:FindFirstChild("HumanoidRootPart").Position - localChar:FindFirstChild("HumanoidRootPart").Position).Magnitude
                        distanceLabel.Text = string.format("%.1f studs", distance)
                    end
                    
                    highlight.Enabled = getgenv().RoleESPEnabled
                    billboard.Enabled = getgenv().NameESPEnabled
                    distanceLabel.Visible = getgenv().DistanceESPEnabled
                else
                    highlight.Enabled = false
                    billboard.Enabled = false
                end
            end)
            task.wait(0.1)
        end
        highlight:Destroy()
        billboard:Destroy()
    end)()
end

-- Track existing players
for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        TrackPlayer(player)
    end
end

-- Track new players
game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        TrackPlayer(player)
    end
end)

-- Clean up when players leave
game.Players.PlayerRemoving:Connect(function(player)
    local oldHighlight = ESPFolder:FindFirstChild(player.Name .. "_RoleESP")
    if oldHighlight then
        oldHighlight:Destroy()
    end
    local oldBillboard = NameESPFolder:FindFirstChild(player.Name .. "_NameESP")
    if oldBillboard then
        oldBillboard:Destroy()
    end
end)

-- Aimbot Tab 🎯
local AimbotTab = Window:CreateTab("🎯 Aimbot", 4483362458)

-- Aimbot Toggle 🎖
AimbotTab:CreateToggle({
    Name = "🎖 Aimbot",
    CurrentValue = false,
    Callback = function(value)
        getgenv().AimbotEnabled = value
    end,
})

-- Aimbot Keybind (Q Key)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Q then
        getgenv().AimbotEnabled = not getgenv().AimbotEnabled
        if Rayfield then
            Rayfield:Notify({
                Title = "Aimbot",
                Content = "Aimbot " .. (getgenv().AimbotEnabled and "Enabled" or "Disabled") .. " (Q Key)",
                Duration = 2
            })
        end
    end
end)

-- Aimbot Settings ⚙️
AimbotTab:CreateSlider({
    Name = "⚙️ Aimbot Smoothness",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 5,
    Callback = function(value)
        getgenv().AimbotSmoothness = value
    end,
})

AimbotTab:CreateToggle({
    Name = "🎯 Target Murderers Only",
    CurrentValue = true,
    Callback = function(value)
        getgenv().TargetMurderersOnly = value
    end,
})

-- Magic Bullet Toggle
AimbotTab:CreateToggle({
    Name = "🪄 Magic Bullet",
    CurrentValue = false,
    Callback = function(value)
        getgenv().MagicBulletEnabled = value
        if value then
            coroutine.wrap(function()
                while getgenv().MagicBulletEnabled do
                    pcall(function()
                        local localPlayer = game.Players.LocalPlayer
                        local char = localPlayer.Character
                        if not char then return end
                        
                        local tool = char:FindFirstChildWhichIsA("Tool")
                        if not tool or tool.Name ~= "Gun" then return end
                        
                        local toolHandle = tool:FindFirstChild("Handle")
                        if not toolHandle then return end
                        
                        -- Find target
                        local target = getClosestPlayer()
                        if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
                        
                        local targetPos = target.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0, 1, 0) -- Aim at chest/head level
                        
                        -- Hook into the gun's firing mechanism
                        local gunScript = tool:FindFirstChildWhichIsA("Script") or tool:FindFirstChildWhichIsA("LocalScript")
                        if gunScript and not gunScript:GetAttribute("MagicBulletHooked") then
                            gunScript:SetAttribute("MagicBulletHooked", true)
                            
                            -- Override the gun's firing function
                            local originalFire = nil
                            
                            -- Find the fire function
                            for _, child in ipairs(tool:GetChildren()) do
                                if child:IsA("Script") or child:IsA("LocalScript") then
                                    local success, result = pcall(function()
                                        return loadstring([[
                                            local tool = script.Parent.Parent
                                            local player = game.Players.LocalPlayer
                                            local char = player.Character
                                            
                                            -- MAGIC BULLET FUNCTION
                                            return function(targetPos, intensity)
                                                local bullets = {}
                                                
                                                -- Create a custom bullet that will curve
                                                local magicBullet = Instance.new("Part")
                                                magicBullet.Name = "MagicBullet_" .. tick()
                                                magicBullet.Size = Vector3.new(0.5, 0.5, 2)
                                                magicBullet.BrickColor = BrickColor.new("Really red")
                                                magicBullet.Material = Enum.Material.Neon
                                                magicBullet.Anchored = false
                                                magicBullet.CanCollide = false
                                                magicBullet.Parent = workspace
                                                
                                                -- Add velocity towards target
                                                local direction = (targetPos - toolHandle.Position).Unit
                                                magicBullet.Velocity = direction * 500 -- Fast bullet speed
                                                
                                                -- Curve calculation
                                                local curveIntensity = intensity or getgenv().MagicBulletIntensity or 5
                                                local curvePoint = toolHandle.Position + Vector3.new(0, curveIntensity, 0)
                                                
                                                -- Animate the bullet along curved path
                                                local startTime = tick()
                                                local duration = 0.3 -- Time to reach target
                                                
                                                local connection
                                                connection = game:GetService("RunService").Heartbeat:Connect(function()
                                                    local elapsed = tick() - startTime
                                                    local progress = math.min(elapsed / duration, 1)
                                                    
                                                    -- Quadratic Bezier curve
                                                    local t = progress
                                                    local curvePos = (1-t)^2 * toolHandle.Position + 2*(1-t)*t * curvePoint + t^2 * targetPos
                                                    
                                                    magicBullet.Position = curvePos
                                                    magicBullet.CFrame = CFrame.lookAt(curvePos, targetPos)
                                                    
                                                    -- Check if bullet reached target
                                                    if progress >= 1 then
                                                        -- Apply damage to target
                                                        local targetChar = target.Character
                                                        if targetChar then
                                                            local humanoid = targetChar:FindFirstChild("Humanoid")
                                                            if humanoid then
                                                                humanoid:TakeDamage(20) -- Gun damage
                                                                
                                                                -- Visual effect
                                                                local hitEffect = Instance.new("Part")
                                                                hitEffect.Size = Vector3.new(3, 3, 3)
                                                                hitEffect.Position = targetPos
                                                                hitEffect.BrickColor = BrickColor.new("Bright orange")
                                                                hitEffect.Material = Enum.Material.Neon
                                                                hitEffect.Anchored = true
                                                                hitEffect.CanCollide = false
                                                                hitEffect.Parent = workspace
                                                                
                                                                game:GetService("Debris"):AddItem(hitEffect, 0.5)
                                                            end
                                                        end
                                                        
                                                        -- Clean up
                                                        magicBullet:Destroy()
                                                        if connection then
                                                            connection:Disconnect()
                                                        end
                                                    end
                                                end)
                                                
                                                table.insert(bullets, magicBullet)
                                            end
                                        ]])
                                    end)
                                    
                                    if success and result then
                                        originalFire = result
                                        break
                                    end
                                end
                            end
                            
                            -- If we found the fire function, override it
                            if originalFire then
                                -- Create a wrapper that calls magic bullet function
                                local newFire = function(...)
                                    -- Call magic bullet function instead
                                    return originalFire(targetPos, getgenv().MagicBulletIntensity or 5)
                                end
                                
                                -- Replace the original fire function
                                for _, child in ipairs(tool:GetChildren()) do
                                    if child:IsA("Script") or child:IsA("LocalScript") then
                                        for _, prop in ipairs(child:GetChildren()) do
                                            if prop:IsA("BindableFunction") and prop.Name == "Fire" then
                                                prop.Value = newFire
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(0.1)
                end
            end)()
        else
            -- Clean up magic bullets when disabled
            pcall(function()
                for _, obj in ipairs(workspace:GetChildren()) do
                    if obj.Name:find("MagicBullet_") then
                        obj:Destroy()
                    end
                end
            end)
        end
    end,
})

-- Magic Bullet Intensity Slider
AimbotTab:CreateSlider({
    Name = "🪄 Bullet Curve Intensity",
    Range = {0, 20},
    Increment = 1,
    CurrentValue = 5,
    Callback = function(value)
        getgenv().MagicBulletIntensity = value
    end,
})

-- Aimbot Function
local camera = game.Workspace.CurrentCamera
local target = nil

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                -- Check if target is murderer (if setting is enabled)
                if getgenv().TargetMurderersOnly then
                    local knife = char:FindFirstChild("Knife") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Knife"))
                    if not knife then
                        continue
                    end
                end
                
                local distance = (char:FindFirstChild("HumanoidRootPart").Position - camera.CFrame.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    
    return closestPlayer
end

game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().AimbotEnabled then
        local closestPlayer = getClosestPlayer()
        if closestPlayer then
            local char = closestPlayer.Character
            if char and char:FindFirstChild("Head") then
                local targetPos = char:FindFirstChild("Head").Position
                local currentCFrame = camera.CFrame
                local lookAt = CFrame.lookAt(currentCFrame.Position, targetPos)
                
                local smoothness = getgenv().AimbotSmoothness or 5
                camera.CFrame = currentCFrame:Lerp(lookAt, 0.1 / smoothness)
            end
        end
    end
end)

-- Misc Tab 🛠️
local MiscTab = Window:CreateTab("🛠️ Misc", 4483362458)

-- Credits/Discord Tab 💬
local CreditsDiscordTab = Window:CreateTab("💬 Credits/Discord", 4483362458)

-- Movement Section
MiscTab:CreateLabel("=== MOVEMENT ===")

-- Anti-Cheat Bypass Toggle
MiscTab:CreateToggle({
    Name = "[Anti-Cheat Bypass]",
    CurrentValue = true,
    Callback = function(value)
        getgenv().AntiCheatBypass = value
    end,
})

-- Position Lock (Bypass Invalid Position)
MiscTab:CreateButton({
    Name = "[Lock Position (Bypass Kick)]",
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            getgenv().LockedPosition = hrp.Position
            
            -- Create position lock loop
            coroutine.wrap(function()
                while getgenv().AntiCheatBypass and hrp and hrp.Parent do
                    pcall(function()
                        hrp.Position = getgenv().LockedPosition
                    end)
                    task.wait(0.1)
                end
            end)()
        end
    end,
})

-- No Clip
MiscTab:CreateToggle({
    Name = "[No Clip]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().NoClipEnabled = value
        if value then
            coroutine.wrap(function()
                while getgenv().NoClipEnabled do
                    pcall(function()
                        local char = game.Players.LocalPlayer.Character
                        if char then
                            for _, part in ipairs(char:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end)
                    task.wait(0.1)
                end
            end)()
        end
    end,
})

-- Fly
MiscTab:CreateToggle({
    Name = "[Fly]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().FlyEnabled = value
        local flySpeed = 50
        local flyDirection = Vector3.new(0, 0, 0)
        
        if value then
            local char = game.Players.LocalPlayer.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            local rootPart = char and char:FindFirstChild("HumanoidRootPart")
            
            if humanoid and rootPart then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.Parent = rootPart
                getgenv().FlyBV = bv
                
                local bg = Instance.new("BodyGyro")
                bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bg.P = 10000
                bg.Parent = rootPart
                getgenv().FlyBG = bg
                
                coroutine.wrap(function()
                    while getgenv().FlyEnabled do
                        pcall(function()
                            local cam = workspace.CurrentCamera
                            local moveDirection = Vector3.new(0, 0, 0)
                            
                            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                                moveDirection = moveDirection + cam.CFrame.LookVector
                            end
                            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                                moveDirection = moveDirection - cam.CFrame.LookVector
                            end
                            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                                moveDirection = moveDirection - cam.CFrame.RightVector
                            end
                            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                                moveDirection = moveDirection + cam.CFrame.RightVector
                            end
                            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                                moveDirection = moveDirection + Vector3.new(0, 1, 0)
                            end
                            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                                moveDirection = moveDirection - Vector3.new(0, 1, 0)
                            end
                            
                            if moveDirection.Magnitude > 0 then
                                moveDirection = moveDirection.Unit * flySpeed
                                getgenv().FlyBV.Velocity = moveDirection
                            else
                                getgenv().FlyBV.Velocity = Vector3.new(0, 0, 0)
                            end
                            
                            getgenv().FlyBG.CFrame = cam.CFrame
                        end)
                        task.wait()
                    end
                end)()
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
    end,
})

-- Speed Boost
MiscTab:CreateSlider({
    Name = "[Speed Boost]",
    Range = {16, 200},
    Increment = 4,
    CurrentValue = 16,
    Callback = function(value)
        getgenv().WalkSpeed = value
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").WalkSpeed = value
            end
        end)
    end,
})

-- Jump Power
MiscTab:CreateSlider({
    Name = "[Jump Power]",
    Range = {50, 200},
    Increment = 10,
    CurrentValue = 50,
    Callback = function(value)
        getgenv().JumpPower = value
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").JumpPower = value
            end
        end)
    end,
})

-- Infinite Jump
MiscTab:CreateToggle({
    Name = "[Infinite Jump]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().InfiniteJump = value
    end,
})

-- Visual Section
MiscTab:CreateLabel("=== VISUAL ===")

-- Full Bright
MiscTab:CreateToggle({
    Name = "[Full Bright]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().FullBrightEnabled = value
        if value then
            getgenv().FullBrightLighting = game:GetService("Lighting")
            getgenv().OriginalBrightness = getgenv().FullBrightLighting.Brightness
            getgenv().OriginalTimeOfDay = getgenv().FullBrightLighting.TimeOfDay
            getgenv().OriginalFogEnd = getgenv().FullBrightLighting.FogEnd
            
            getgenv().FullBrightLighting.Brightness = 2
            getgenv().FullBrightLighting.TimeOfDay = "14:00:00"
            getgenv().FullBrightLighting.FogEnd = 100000
        else
            if getgenv().FullBrightLighting then
                getgenv().FullBrightLighting.Brightness = getgenv().OriginalBrightness or 1
                getgenv().FullBrightLighting.TimeOfDay = getgenv().OriginalTimeOfDay or "14:00:00"
                getgenv().FullBrightLighting.FogEnd = getgenv().OriginalFogEnd or 1000
            end
        end
    end,
})

-- No Fog
MiscTab:CreateToggle({
    Name = "[No Fog]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().NoFogEnabled = value
        if value then
            getgenv().OriginalFogEnd = game:GetService("Lighting").FogEnd
            game:GetService("Lighting").FogEnd = 100000
        else
            if getgenv().OriginalFogEnd then
                game:GetService("Lighting").FogEnd = getgenv().OriginalFogEnd
            end
        end
    end,
})

-- Remove Grass
MiscTab:CreateToggle({
    Name = "[Remove Grass]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().RemoveGrassEnabled = value
        if value then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Terrain") then
                    obj:Clear()
                end
            end
        end
    end,
})

-- Utility Section
MiscTab:CreateLabel("=== UTILITY ===")

-- Auto Respawn
MiscTab:CreateToggle({
    Name = "[Auto Respawn]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().AutoRespawnEnabled = value
        if value then
            coroutine.wrap(function()
                while getgenv().AutoRespawnEnabled do
                    pcall(function()
                        local char = game.Players.LocalPlayer.Character
                        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.Health <= 0 then
                            game.Players.LocalPlayer:LoadCharacter()
                        end
                    end)
                    task.wait(1)
                end
            end)()
        end
    end,
})

-- Anti AFK
MiscTab:CreateToggle({
    Name = "[Anti AFK]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().AntiAFKEnabled = value
        if value then
            getgenv().AntiAFKConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        else
            if getgenv().AntiAFKConnection then
                getgenv().AntiAFKConnection:Disconnect()
                getgenv().AntiAFKConnection = nil
            end
        end
    end,
})


-- Anti Knockback
MiscTab:CreateToggle({
    Name = "[Anti Knockback]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().AntiKnockbackEnabled = value
        if value then
            coroutine.wrap(function()
                while getgenv().AntiKnockbackEnabled do
                    pcall(function()
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, 0, 0)
                        end
                    end)
                    task.wait(0.1)
                end
            end)()
        end
    end,
})

-- Hitbox Expander
MiscTab:CreateToggle({
    Name = "[Hitbox Expander]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().HitboxExpanderEnabled = value
        if value then
            coroutine.wrap(function()
                while getgenv().HitboxExpanderEnabled do
                    pcall(function()
                        local localPlayer = game.Players.LocalPlayer
                        if not localPlayer or not localPlayer.Character then return end
                        
                        local char = localPlayer.Character
                        if not char:FindFirstChild("HumanoidRootPart") then return end
                        
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        local hitboxSize = getgenv().HitboxSize or 5
                        local transparency = getgenv().HitboxTransparency or 0.5
                        
                        -- Process ALL other players
                        for _, player in ipairs(game.Players:GetPlayers()) do
                            if player == localPlayer then 
                                -- CRITICAL: Skip local player completely
                                continue 
                            end
                            
                            local targetChar = player.Character
                            if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then continue end
                            
                            local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
                            local humanoid = targetChar:FindFirstChild("Humanoid")
                            if not humanoid then continue end
                            
                            -- METHOD 1: Create functional hitbox
                            local hitbox = targetHrp:FindFirstChild("FunctionalHitbox")
                            if not hitbox then
                                hitbox = Instance.new("Part")
                                hitbox.Name = "FunctionalHitbox"
                                hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                                hitbox.Transparency = transparency
                                hitbox.BrickColor = BrickColor.new("Really red")
                                hitbox.Material = Enum.Material.ForceField
                                hitbox.Anchored = false
                                hitbox.CanCollide = false
                                hitbox.Massless = true
                                hitbox.Parent = targetHrp
                                
                                -- Store player reference
                                hitbox:SetAttribute("TargetPlayer", player)
                                hitbox:SetAttribute("IsHitbox", true)
                                
                                -- Create proper weld
                                local weld = Instance.new("WeldConstraint")
                                weld.Part0 = targetHrp
                                weld.Part1 = hitbox
                                weld.Parent = weld
                            else
                                -- Update existing hitbox
                                hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                                hitbox.Transparency = transparency
                            end
                            
                            -- METHOD 2: Scale body parts (safer method)
                            if getgenv().HitboxSize and getgenv().HitboxSize > 5 then
                                local scaleFactor = 1 + (getgenv().HitboxSize / 15) -- More conservative scaling
                                
                                for _, part in ipairs(targetChar:GetChildren()) do
                                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                                        -- Store original size safely
                                        if not part:GetAttribute("OriginalSize") then
                                            part:SetAttribute("OriginalSize", part.Size)
                                        end
                                        
                                        -- Apply scaling
                                        local originalSize = part:GetAttribute("OriginalSize")
                                        part.Size = originalSize * scaleFactor
                                    end
                                end
                            end
                            
                            -- METHOD 3: Damage hooking (most reliable)
                            if humanoid and not humanoid:GetAttribute("HitboxHooked") then
                                humanoid:SetAttribute("HitboxHooked", true)
                                humanoid:SetAttribute("OriginalHealth", humanoid.Health)
                                
                                -- Create damage detection connection
                                local connection
                                connection = game:GetService("RunService").Heartbeat:Connect(function()
                                    if not getgenv().HitboxExpanderEnabled or not humanoid or not humanoid.Parent then
                                        if connection then connection:Disconnect() end
                                        return
                                    end
                                    
                                    -- Check local player's weapon proximity
                                    local localChar = localPlayer.Character
                                    if localChar and localChar:FindFirstChild("HumanoidRootPart") then
                                        local localHrp = localChar:FindFirstChild("HumanoidRootPart")
                                        local tool = localChar:FindFirstChildWhichIsA("Tool") or localPlayer.Backpack:FindFirstChildWhichIsA("Tool")
                                        
                                        if tool and (tool.Name == "Knife" or tool.Name == "Gun") then
                                            local toolHandle = tool:FindFirstChild("Handle")
                                            if toolHandle then
                                                local distance = (toolHandle.Position - targetHrp.Position).Magnitude
                                                
                                                -- Check if within expanded hitbox range
                                                if distance <= hitboxSize then
                                                    -- Determine if this is a normal hit or expanded hitbox hit
                                                    local normalRange = 2 -- Normal attack range
                                                    
                                                    if distance > normalRange then
                                                        -- This is an expanded hitbox hit - apply damage directly
                                                        if tool.Name == "Knife" then
                                                            humanoid:TakeDamage(40) -- Knife damage
                                                        elseif tool.Name == "Gun" then
                                                            humanoid:TakeDamage(20) -- Gun damage
                                                        end
                                                        
                                                        -- Visual feedback (REMOVED - too obvious)
                                                        -- local effect = targetHrp:FindFirstChild("HitboxEffect")
                                                        -- if not effect then
                                                        --     effect = Instance.new("Part")
                                                        --     effect.Name = "HitboxEffect"
                                                        --     effect.Size = Vector3.new(2, 2, 2)
                                                        --     effect.Position = targetHrp.Position
                                                        --     effect.BrickColor = BrickColor.new("Bright orange")
                                                        --     effect.Material = Enum.Material.Neon
                                                        --     effect.Anchored = true
                                                        --     effect.CanCollide = false
                                                        --     effect.Parent = workspace
                                                        --     
                                                        --     game:GetService("Debris"):AddItem(effect, 0.5)
                                                        -- end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end)
                            end
                        end
                    end)
                    task.wait(0.1) -- Fast updates for smooth operation
                end
            end)()
        else
            -- Clean up everything when disabled
            pcall(function()
                local localPlayer = game.Players.LocalPlayer
                if not localPlayer then return end
                
                -- Remove all hitboxes from all players
                for _, player in ipairs(game.Players:GetPlayers()) do
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        
                        -- Remove functional hitbox
                        local hitbox = hrp:FindFirstChild("FunctionalHitbox")
                        if hitbox then
                            hitbox:Destroy()
                        end
                        
                        -- Restore original body part sizes
                        for _, part in ipairs(char:GetChildren()) do
                            if part:IsA("BasePart") and part:GetAttribute("OriginalSize") then
                                part.Size = part:GetAttribute("OriginalSize")
                                part:SetAttribute("OriginalSize", nil)
                            end
                        end
                        
                        -- Remove hitbox hook
                        local humanoid = char:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid:SetAttribute("HitboxHooked", nil)
                            humanoid:SetAttribute("OriginalHealth", nil)
                        end
                        
                        -- Remove hit effects
                        local effect = hrp:FindFirstChild("HitboxEffect")
                        if effect then
                            effect:Destroy()
                        end
                    end
                end
            end)
        end
    end,
})

-- Hitbox Size Slider
MiscTab:CreateSlider({
    Name = "[Hitbox Size]",
    Range = {1, 20},
    Increment = 1,
    CurrentValue = 5,
    Callback = function(value)
        getgenv().HitboxSize = value
    end,
})

-- Hitbox Transparency Slider
MiscTab:CreateSlider({
    Name = "[Hitbox Transparency]",
    Range = {0, 1},
    Increment = 0.1,
    CurrentValue = 0.5,
    Callback = function(value)
        getgenv().HitboxTransparency = value
    end,
})

-- Fling Feature
MiscTab:CreateToggle({
    Name = "[Fling]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().FlingEnabled = value
        if value then
            coroutine.wrap(function()
                while getgenv().FlingEnabled do
                    pcall(function()
                        local localPlayer = game.Players.LocalPlayer
                        local char = localPlayer.Character
                        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                        
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        
                        -- Find target based on selection
                        local target = nil
                        local flingMode = getgenv().FlingMode or "Murderer"
                        
                        if flingMode == "Murderer" then
                            -- Find murderer (has knife)
                            for _, player in ipairs(game.Players:GetPlayers()) do
                                if player ~= localPlayer then
                                    local playerChar = player.Character
                                    if playerChar and playerChar:FindFirstChild("HumanoidRootPart") then
                                        local knife = playerChar:FindFirstChild("Knife") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Knife"))
                                        if knife then
                                            target = player
                                            break
                                        end
                                    end
                                end
                        elseif flingMode == "Sheriff" then
                            -- Find sheriff (has gun)
                            for _, player in ipairs(game.Players:GetPlayers()) do
                                if player ~= localPlayer then
                                    local playerChar = player.Character
                                    if playerChar and playerChar:FindFirstChild("HumanoidRootPart") then
                                        local gun = playerChar:FindFirstChild("Gun") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Gun"))
                                        if gun then
                                            target = player
                                            break
                                        end
                                    end
                                end
                        elseif flingMode == "All" then
                            -- Target closest player
                            target = getClosestPlayer()
                        end
                        
                        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                            local targetHrp = target.Character:FindFirstChild("HumanoidRootPart")
                            local targetHumanoid = target.Character:FindFirstChild("Humanoid")
                            
                            -- FLING THE TARGET OUT OF MAP
                            local flingPower = getgenv().FlingPower or 500
                            local flingDirection = (targetHrp.Position - hrp.Position).Unit
                            
                            -- Apply massive velocity to fling target out of map
                            targetHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                            targetHrp.Velocity = flingDirection * flingPower
                            
                            -- Add extra upward velocity to ensure they go out of map
                            targetHrp.Velocity = targetHrp.Velocity + Vector3.new(0, 1000, 0)
                            
                            -- Apply instant kill damage
                            targetHumanoid:TakeDamage(100) -- Massive damage to ensure kill
                            
                            -- Add spin effect for dramatic effect
                            local bodyVelocity = Instance.new("BodyVelocity")
                            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                            bodyVelocity.P = 50000
                            bodyVelocity.velocity = Vector3.new(math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000))
                            bodyVelocity.Parent = targetHrp
                            
                            -- Create visual effect
                            local flingEffect = Instance.new("Part")
                            flingEffect.Size = Vector3.new(3, 3, 3)
                            flingEffect.BrickColor = BrickColor.new("Really red")
                            flingEffect.Material = Enum.Material.Neon
                            flingEffect.Anchored = true
                            flingEffect.CanCollide = false
                            flingEffect.Position = targetHrp.Position
                            flingEffect.Parent = workspace
                            
                            -- Notification
                            if Rayfield then
                                Rayfield:Notify({
                                    Title = "Fling",
                                    Content = "Flinging " .. target.Name .. " out of map!",
                                    Duration = 2
                                })
                            end
                            
                            -- Clean up after delay
                            game:GetService("Debris"):AddItem(flingEffect, 2)
                            game:GetService("Debris"):AddItem(bodyVelocity, 1)
                        end
                    end)
                    task.wait(0.5) -- Check every 0.5 seconds
                end
            end)()
        else
            -- Clean up when disabled
            pcall(function()
                for _, obj in ipairs(workspace:GetChildren()) do
                    if obj:IsA("BodyVelocity") then
                        obj:Destroy()
                    end
                end
            end)
        end
    end,
})

-- Fling Mode Selection
MiscTab:CreateDropdown({
    Name = "[Fling Target]",
    Options = {"Murderer", "Sheriff", "All"},
    CurrentOption = "Murderer",
    Callback = function(option)
        getgenv().FlingMode = option
        if Rayfield then
            Rayfield:Notify({
                Title = "Fling Mode",
                Content = "Target: " .. option,
                Duration = 2
            })
        end
    end,
})

-- VC Bypass
MiscTab:CreateToggle({
    Name = "[VC Bypass]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().VCBypassEnabled = value
        if value then
            coroutine.wrap(function()
                while getgenv().VCBypassEnabled do
                    pcall(function()
                        -- Method 1: Filter chat messages
                        local chatService = game:GetService("Chat")
                        local originalChatFunction = chatService.ChatBar.TargetText
                        
                        -- Create safe chat function
                        local safeChatFunction = function(message)
                            -- Filter common swear words
                            local filteredMessage = message
                            local swearWords = {
                                "fuck", "shit", "bitch", "ass", "cunt", "dick", 
                                "nigger", "fag", "retard", "idiot", "bastered",
                                "motherfucker", "son of a bitch", "wtf", "stfu", " kys", "die"
                            }
                            
                            -- Replace swear words with safe alternatives
                            for _, swear in ipairs(swearWords) do
                                local replacement = string.rep("*", string.len(swear))
                                filteredMessage = string.gsub(filteredMessage:lower(), swear, replacement)
                            end
                            
                            -- Add special characters to bypass filters
                            local bypassChars = {
                                "Ą", "Ć", "ć", "Ĉ", "ĉ", "Ċ", "ċ", "Č", "č", "Ď", "ď",
                                "ą", "ć", "ę", "ė", "ę", "ě", "Ĝ", "ą", "ż", "ź", "ś", "ć",
                                "á", "à", "â", "ä", "ã", "å", "æ", "œ", "ç", "é", "è", "ê", "ë",
                                "í", "ï", "î", "ì", "ó", "ò", "ô", "ö", "õ", "ø", "ù", "û", "ü",
                                "ý", "ÿ", "¡", "¢", "£", "¤", "¥", "₧", "₩", "₪", "₫", "€",
                                "ß", "§", "†", "‡", "•", "‰", "‱", "‡", "†", "‡"
                            }
                            
                            -- Randomly insert special characters
                            for i = 1, #bypassChars do
                                local charIndex = math.random(1, #bypassChars)
                                filteredMessage = filteredMessage:sub(1, i) .. bypassChars[charIndex] .. filteredMessage:sub(i + 1)
                            end
                            
                            -- Call original chat function with filtered message
                            return originalChatFunction(filteredMessage)
                        end
                        
                        -- Override chat function
                        chatService.ChatBar.TargetText = safeChatFunction
                        
                        -- Method 2: Block VC audio detection
                        local voiceChatService = game:GetService("VoiceChatService")
                        if voiceChatService then
                            -- Hook into voice chat events
                            local originalConnect = voiceChatService.MainSpeakerStarted:Connect(function() end)
                            
                            -- Create safe voice chat handler
                            voiceChatService.MainSpeakerStarted:Connect(function(speaker)
                                if speaker == game.Players.LocalPlayer then
                                    -- Prevent voice chat detection
                                    speaker:SetAttribute("VCBypassActive", true)
                                    
                                    -- Hook into voice state changes
                                    local originalStateChanged = speaker.StateChanged
                                    speaker.StateChanged = function(newState)
                                        if getgenv().VCBypassEnabled and speaker:GetAttribute("VCBypassActive") then
                                            -- Block voice state reporting
                                            return
                                        end
                                        
                                        -- Call original with safe checks
                                        return originalStateChanged(newState)
                                    end
                                end)
                        end
                        
                        -- Method 3: Filter text chat
                        local textChatService = game:GetService("TextChatService")
                        if textChatService then
                            local originalSendMessage = textChatService.SendMessage
                            
                            textChatService.SendMessage = function(textChannel, message)
                                -- Filter message
                                local filteredMessage = message
                                local swearWords = {
                                    "fuck", "shit", "bitch", "ass", "cunt", "dick", 
                                    "nigger", "fag", "retard", "idiot", "bastered",
                                    "motherfucker", "son of a bitch", "wtf", "stfu", " kys", "die"
                                }
                                
                                -- Replace swear words with safe alternatives
                                for _, swear in ipairs(swearWords) do
                                    local replacement = string.rep("*", string.len(swear))
                                    filteredMessage = string.gsub(filteredMessage:lower(), swear, replacement)
                                end
                                
                                -- Add special characters to bypass filters
                                local bypassChars = {
                                    "Ą", "Ć", "ć", "Ĉ", "ĉ", "Ċ", "ċ", "Č", "č", "Ď", "ď",
                                    "ą", "ć", "ę", "ė", "ę", "ě", "Ĝ", "ą", "ż", "ź", "ś", "ć",
                                    "á", "à", "â", "ä", "ã", "å", "æ", "œ", "ç", "é", "è", "ê", "ë",
                                    "í", "ï", "î", "ì", "ó", "ò", "ô", "ö", "õ", "ø", "ù", "û", "ü",
                                    "ý", "ÿ", "¡", "¢", "£", "¤", "¥", "₧", "₩", "₪", "₫", "€",
                                    "ß", "§", "†", "‡", "•", "‰", "‱", "‡", "†", "‡"
                                }
                                
                                -- Randomly insert special characters
                                for i = 1, #bypassChars do
                                    local charIndex = math.random(1, #bypassChars)
                                    filteredMessage = filteredMessage:sub(1, i) .. bypassChars[charIndex] .. filteredMessage:sub(i + 1)
                                end
                                
                                -- Call original with filtered message
                                return originalSendMessage(textChannel, filteredMessage)
                            end
                        end
                        
                        -- Method 4: Anti-VC detection system
                        game:GetService("RunService").Heartbeat:Connect(function()
                            if not getgenv().VCBypassEnabled then return end
                            
                            -- Check if local player is muted
                            local localPlayer = game.Players.LocalPlayer
                            if localPlayer and localPlayer:FindFirstChild("HumanoidRootPart") then
                                -- Prevent automatic muting for swearing
                                localPlayer.Character:FindFirstChild("Humanoid").Health = 100
                            end
                        end)
                        
                        if Rayfield then
                            Rayfield:Notify({
                                Title = "VC Bypass",
                                Content = "VC Bypass activated!",
                                Duration = 3
                            })
                        end
                    end)
                    task.wait(1)
                end
            end)()
        else
            -- Clean up when disabled
            pcall(function()
                local chatService = game:GetService("Chat")
                if chatService and chatService.ChatBar and chatService.ChatBar.TargetText ~= nil then
                    -- Restore original chat function
                    chatService.ChatBar.TargetText = nil
                end
                
                local voiceChatService = game:GetService("VoiceChatService")
                if voiceChatService then
                    -- Clean up voice chat hooks
                    for _, speaker in pairs(voiceChatService:GetSpeakers()) do
                        if speaker:GetAttribute("VCBypassActive") then
                            speaker:SetAttribute("VCBypassActive", nil)
                        end
                    end
                end
            end)
        end
    end,
})

-- Coin Auto Farm
MiscTab:CreateToggle({
    Name = "[Coin Auto Farm]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().CoinAutoFarmEnabled = value
        if value then
            coroutine.wrap(function()
                while getgenv().CoinAutoFarmEnabled do
                    pcall(function()
                        local localPlayer = game.Players.LocalPlayer
                        local char = localPlayer.Character
                        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                        
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        local originalPosition = hrp.Position
                        local coinsCollected = 0
                        
                        -- COMPREHENSIVE COIN SEARCH - Check entire workspace
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            if not getgenv().CoinAutoFarmEnabled then break end
                            
                            local isCoin = false
                            
                            -- METHOD 1: Name detection
                            local name = obj.Name:lower()
                            if name:find("coin") or name:find("money") or name:find("cash") or name:find("shard") or name:find("gem") then
                                isCoin = true
                            end
                            
                            -- METHOD 2: Color detection
                            if not isCoin and obj:IsA("Part") then
                                local coinColors = {
                                    BrickColor.new("Bright yellow"),
                                    BrickColor.new("Yellow"),
                                    BrickColor.new("New Yeller"),
                                    BrickColor.new("Gold"),
                                    BrickColor.new("Bright orange"),
                                    BrickColor.new("Pastel yellow")
                                }
                                
                                for _, color in ipairs(coinColors) do
                                    if obj.BrickColor == color and obj.Size.X <= 4 and obj.Size.Y <= 4 and obj.Size.Z <= 4 then
                                        isCoin = true
                                        break
                                    end
                                end
                            end
                            
                            -- METHOD 3: Collection properties detection
                            if not isCoin and obj:IsA("Part") then
                                if obj:FindFirstChild("TouchTransmitter") or obj:FindFirstChild("ClickDetector") or obj:FindFirstChild("ProximityPrompt") then
                                    if obj.Size.X <= 3 and obj.Size.Y <= 3 and obj.Size.Z <= 3 then
                                        isCoin = true
                                    end
                                end
                            end
                            
                            -- METHOD 4: MeshPart detection
                            if not isCoin and obj:IsA("MeshPart") then
                                local name = obj.Name:lower()
                                if name:find("coin") or name:find("money") then
                                    isCoin = true
                                end
                            end
                            
                            -- COLLECT THE COIN IF DETECTED
                            if isCoin and obj.Parent then
                                local distance = (obj.Position - hrp.Position).Magnitude
                                if distance <= 2000 then -- Large collection range
                                    
                                    -- TELEPORT TO COIN WITH SPEED
                                    hrp.Position = obj.Position
                                    task.wait(0.02) -- Faster teleport
                                    
                                    -- ENABLE NO CLIP FOR FASTER COLLECTION
                                    for _, part in ipairs(char:GetChildren()) do
                                        if part:IsA("BasePart") then
                                            part.CanCollide = false
                                        end
                                    end
                                    
                                    -- COLLECTION ATTEMPT 1: Direct touch
                                    obj.CanCollide = false
                                    obj.Position = hrp.Position
                                    task.wait(0.02) -- Faster touch
                                    
                                    -- COLLECTION ATTEMPT 2: Fire touch events
                                    if obj:FindFirstChild("TouchTransmitter") then
                                        local touch = obj:FindFirstChild("TouchTransmitter")
                                        for _, connection in pairs(touch:GetConnectedChildren()) do
                                            if connection:IsA("RemoteEvent") then
                                                connection:FireServer()
                                            end
                                        end
                                    end
                                    
                                    -- COLLECTION ATTEMPT 3: Click detector
                                    if obj:FindFirstChild("ClickDetector") then
                                        local click = obj:FindFirstChild("ClickDetector")
                                        click.MaxActivationDistance = 1000
                                        fireclickdetector(click)
                                    end
                                    
                                    -- COLLECTION ATTEMPT 4: Proximity prompt
                                    if obj:FindFirstChild("ProximityPrompt") then
                                        local prompt = obj:FindFirstChild("ProximityPrompt")
                                        prompt.MaxActivationDistance = 1000
                                        prompt:InputHoldEnded()
                                    end
                                    
                                    -- COLLECTION ATTEMPT 5: Force collection
                                    if obj.Parent then
                                        obj.Anchored = false
                                        obj.Position = hrp.Position
                                        task.wait(0.05)
                                    end
                                    
                                    -- CHECK IF COLLECTED
                                    if not obj.Parent then
                                        coinsCollected = coinsCollected + 1
                                    else
                                        -- FORCE COLLECT
                                        obj:Destroy()
                                        coinsCollected = coinsCollected + 1
                                    end
                                    
                                    task.wait(0.1) -- Small delay between coins
                                end
                            end
                        end
                        
                        -- Return to original position
                        hrp.Position = originalPosition
                        
                        -- Notify if coins were collected
                        if coinsCollected > 0 and Rayfield then
                            Rayfield:Notify({
                                Title = "Coin Auto Farm",
                                Content = "Collected " .. coinsCollected .. " coins!",
                                Duration = 2
                            })
                        end
                        
                        task.wait(2) -- Wait before next cycle
                    end)
                    task.wait(0.5) -- Check every 0.5 seconds (faster)
                end
            end)()
        else
            -- CRITICAL: Immediately return to original position when disabled
            pcall(function()
                local localPlayer = game.Players.LocalPlayer
                local char = localPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    -- Return to a safe position
                    hrp.Position = Vector3.new(hrp.Position.X, workspace.CurrentCamera.Focus.Position.Y, hrp.Position.Z)
                end
            end)
            
            if Rayfield then
                Rayfield:Notify({
                    Title = "Coin Auto Farm",
                    Content = "Farm stopped!",
                    Duration = 2
                })
            end
        end
    end,
})

-- Auto Grab Gun
MiscTab:CreateToggle({
    Name = "[Auto Grab Gun]",
    CurrentValue = false,
    Callback = function(value)
        getgenv().AutoGrabGunEnabled = value
        if value then
            coroutine.wrap(function()
                while getgenv().AutoGrabGunEnabled do
                    pcall(function()
                        local localPlayer = game.Players.LocalPlayer
                        local char = localPlayer.Character
                        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                        
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        
                        -- Check if Sheriff is dead
                        local sheriffDead = false
                        for _, player in ipairs(game.Players:GetPlayers()) do
                            if player ~= localPlayer then
                                local playerChar = player.Character
                                if playerChar and playerChar:FindFirstChild("Humanoid") then
                                    local humanoid = playerChar:FindFirstChild("Humanoid")
                                    local gun = playerChar:FindFirstChild("Gun") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Gun"))
                                    
                                    if gun and humanoid.Health <= 0 then
                                        sheriffDead = true
                                        break
                                    end
                                end
                            end
                        end
                        
                        -- If Sheriff is dead, look for dropped gun
                        if sheriffDead then
                            local gunFound = false
                            local gunPosition = nil
                            local gunObject = nil
                            
                            -- Search for gun in workspace with better detection
                            for _, obj in ipairs(workspace:GetDescendants()) do
                                if obj:IsA("Tool") and obj.Name == "Gun" then
                                    gunFound = true
                                    gunPosition = obj:GetPrimaryPartCFrame().Position
                                    gunObject = obj
                                    break
                                end
                            end
                            
                            -- If gun found, teleport to it and grab it
                            if gunFound and gunPosition and gunObject then
                                local originalPosition = hrp.Position
                                local originalCFrame = hrp.CFrame
                                
                                -- TELEPORT TO GUN
                                hrp.Position = gunPosition + Vector3.new(0, 2, 0) -- Slightly above gun
                                task.wait(0.1)
                                
                                -- Try to grab the gun - METHOD 1: Direct equip
                                pcall(function()
                                    localPlayer.Character:FindFirstChild("Humanoid"):EquipTool(gunObject)
                                end)
                                task.wait(0.2)
                                
                                -- METHOD 2: Touch the gun
                                if gunObject.Parent then
                                    hrp.Position = gunPosition
                                    task.wait(0.1)
                                    
                                    -- Move around to ensure touch
                                    local positions = {
                                        gunPosition,
                                        gunPosition + Vector3.new(1, 0, 0),
                                        gunPosition - Vector3.new(1, 0, 0),
                                        gunPosition + Vector3.new(0, 0, 1),
                                        gunPosition - Vector3.new(0, 0, 1)
                                    }
                                    
                                    for _, pos in ipairs(positions) do
                                        if not gunObject.Parent then break end -- Gun picked up
                                        hrp.Position = pos
                                        task.wait(0.05)
                                    end
                                end
                                
                                -- METHOD 3: Fire touch events
                                if gunObject.Parent and gunObject:FindFirstChild("Handle") then
                                    local handle = gunObject:FindFirstChild("Handle")
                                    if handle:FindFirstChild("TouchTransmitter") then
                                        for _, connection in pairs(handle.TouchTransmitter:GetConnectedChildren()) do
                                            if connection:IsA("RemoteEvent") then
                                                connection:FireServer()
                                            end
                                        end
                                    end
                                end
                                
                                -- METHOD 4: Click detector
                                if gunObject.Parent and gunObject:FindFirstChild("ClickDetector") then
                                    fireclickdetector(gunObject:FindFirstChild("ClickDetector"))
                                end
                                
                                -- METHOD 5: Force equip by moving to backpack
                                if gunObject.Parent then
                                    gunObject.Parent = localPlayer.Backpack
                                    task.wait(0.1)
                                    localPlayer.Character:FindFirstChild("Humanoid"):EquipTool(gunObject)
                                end
                                
                                task.wait(0.3)
                                
                                -- TELEPORT BACK TO ORIGINAL POSITION
                                hrp.Position = originalPosition
                                hrp.CFrame = originalCFrame
                                
                                -- Check if gun was successfully grabbed
                                local hasGun = char:FindFirstChild("Gun") or localPlayer.Backpack:FindFirstChild("Gun")
                                
                                if hasGun then
                                    -- Success! Disable after grabbing gun
                                    getgenv().AutoGrabGunEnabled = false
                                    if Rayfield then
                                        Rayfield:Notify({
                                            Title = "Auto Grab Gun",
                                            Content = "Gun grabbed successfully!",
                                            Duration = 3
                                        })
                                    end
                                else
                                    -- Failed, try again next cycle
                                    if Rayfield then
                                        Rayfield:Notify({
                                            Title = "Auto Grab Gun",
                                            Content = "Failed to grab gun, retrying...",
                                            Duration = 2
                                        })
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(1) -- Check every second
                end
            end)()
        else
            -- When disabled, ensure player is in safe position
            pcall(function()
                local localPlayer = game.Players.LocalPlayer
                local char = localPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    -- Ensure player is on ground
                    hrp.Position = Vector3.new(hrp.Position.X, workspace.CurrentCamera.Focus.Position.Y, hrp.Position.Z)
                end
            end)
        end
    end,
})

-- Jassy Section ✨
CreditsDiscordTab:CreateLabel("=== ❤ JASSY ❤ ===")

CreditsDiscordTab:CreateButton({
    Name = "💬 Copy Discord invite to clipboard",
    Callback = function()
        setclipboard("https://discord.gg/RhjnE4tEQ8")
        Rayfield:Notify({
            Title = "Discord",
            Content = "Copied Discord invite to clipboard!",
            Duration = 5
        })
    end,
})

CreditsDiscordTab:CreateButton({
    Name = "⌨️ GUI KEYBIND: K",
    Callback = function()
        Rayfield:Notify({
            Title = "Keybind",
            Content = "GUI Keybind is K",
            Duration = 5
        })
    end,
})

-- Credits 📜
CreditsDiscordTab:CreateLabel("📜 Script made by: Jassy ❤")
CreditsDiscordTab:CreateLabel("📈 Version: 1.0")
CreditsDiscordTab:CreateLabel("🔥 Property Of ScriptForge")

-- Uninject Button
CreditsDiscordTab:CreateButton({
    Name = "[Uninject Script]",
    Callback = function()
        -- Stop all features
        getgenv().RoleESPEnabled = false
        getgenv().NameESPEnabled = false
        getgenv().DistanceESPEnabled = false
        getgenv().AimbotEnabled = false
        getgenv().NoClipEnabled = false
        getgenv().FlyEnabled = false
        getgenv().AutoRespawnEnabled = false
        getgenv().AntiAFKEnabled = false
        getgenv().InvisibleEnabled = false
        getgenv().AntiKnockbackEnabled = false
        getgenv().AntiCheatBypass = false
        getgenv().AutoGrabGunEnabled = false
        getgenv().HitboxExpanderEnabled = false
        getgenv().MagicBulletEnabled = false
        getgenv().CoinAutoFarmEnabled = false
        
        -- Clean up ESP
        pcall(function()
            if workspace:FindFirstChild("MM2_RoleESP_Highlights") then
                workspace:FindFirstChild("MM2_RoleESP_Highlights"):Destroy()
            end
            if workspace:FindFirstChild("MM2_NameESP") then
                workspace:FindFirstChild("MM2_NameESP"):Destroy()
            end
        end)
        
        -- Destroy UI
        if Rayfield then
            Rayfield:Destroy()
        end
        
        Rayfield:Notify({
            Title = "Script Uninjected",
            Content = "Script has been successfully uninjected!",
            Duration = 5
        })
    end,
})

-- Status
CreditsDiscordTab:CreateLabel("Status: " .. (Rayfield and "Working" or "Error"))

-- Notification on load
Rayfield:Notify({
    Title = "Jassy's ❤ MM2 Script",
    Content = "Script loaded successfully!",
    Duration = 5
})

print("Jassy's ❤ MM2 Script loaded - Rayfield status: " .. (Rayfield and "Working" or "Error"))
