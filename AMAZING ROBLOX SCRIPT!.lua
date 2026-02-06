-- Made by Jassy ❤
-- Property of ScriptForge ❤

-- Anti-Cheat Bypass
local function bypassAntiCheat()
    -- Bypass "Invalid position" kick
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        
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
    end
    
    -- Bypass speed detection
    game:GetService("RunService").Stepped:Connect(function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid.MoveDirection.Magnitude > 0 then
                humanoid.WalkSpeed = math.min(humanoid.WalkSpeed, 50)
            end
        end
    end)
end

-- Test Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
print(Rayfield and "[Rayfield loaded]" or "[Rayfield failed to load]")

if not Rayfield then
    game.Players.LocalPlayer:Kick("[Rayfield UI library is currently down. Please try again later.]")
    return
end

-- Activate anti-cheat bypass
bypassAntiCheat()

local Window = Rayfield:CreateWindow({
    Name = "🔫 MM2 Script 🔫",
    LoadingTitle = "⚡ MM2 Script ⚡",
    LoadingSubtitle = "❤ Made by Jassy ❤",
    ConfigurationSaving = {
        Enabled = false,
    },
    BackgroundImage = "https://i.imgur.com/f6P9Vci.jpeg"
})

-- ESP Tab 🎯
local ESPTab = Window:CreateTab("🎯 ESP", 4483362458)

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
                        if tool and tool.Name == "Gun" then
                            -- Find the closest target
                            local target = getClosestPlayer()
                            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                                local targetPos = target.Character:FindFirstChild("HumanoidRootPart").Position
                                
                                -- Hook into the gun's firing mechanism
                                local gunScript = tool:FindFirstChildWhichIsA("Script") or tool:FindFirstChildWhichIsA("LocalScript")
                                if gunScript and not gunScript:GetAttribute("MagicBulletHooked") then
                                    gunScript:SetAttribute("MagicBulletHooked", true)
                                    
                                    -- Create a bullet manipulation system
                                    game:GetService("RunService").Heartbeat:Connect(function()
                                        if not getgenv().MagicBulletEnabled then return end
                                        
                                        -- Look for newly created bullets
                                        for _, obj in ipairs(workspace:GetDescendants()) do
                                            if obj:IsA("Part") and obj.Name:find("Bullet") or obj.Name:find("Projectile") then
                                                if not obj:GetAttribute("MagicBulletProcessed") then
                                                    obj:SetAttribute("MagicBulletProcessed", true)
                                                    
                                                    -- Calculate trajectory to target
                                                    local startPos = obj.Position
                                                    local endPos = targetPos + Vector3.new(0, 1, 0) -- Aim at head/chest level
                                                    
                                                    -- Create a curved path
                                                    local curveIntensity = getgenv().MagicBulletIntensity or 5
                                                    local midPoint = (startPos + endPos) / 2 + Vector3.new(0, curveIntensity, 0)
                                                    
                                                    -- Animate the bullet along the curved path
                                                    local startTime = tick()
                                                    local duration = 0.2 -- Time to reach target
                                                    
                                                    local connection
                                                    connection = game:GetService("RunService").Heartbeat:Connect(function()
                                                        local elapsed = tick() - startTime
                                                        local progress = math.min(elapsed / duration, 1)
                                                        
                                                        -- Quadratic Bezier curve for smooth curving
                                                        local t = progress
                                                        local curvePos = (1-t)^2 * startPos + 2*(1-t)*t * midPoint + t^2 * endPos
                                                        
                                                        obj.Position = curvePos
                                                        
                                                        -- Make the bullet look at the target
                                                        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                                                            obj.CFrame = CFrame.lookAt(curvePos, target.Character:FindFirstChild("HumanoidRootPart").Position)
                                                        end
                                                        
                                                        -- When bullet reaches target, ensure hit registration
                                                        if progress >= 1 then
                                                            -- Force hit registration
                                                            local targetChar = target.Character
                                                            if targetChar then
                                                                local humanoid = targetChar:FindFirstChild("Humanoid")
                                                                if humanoid then
                                                                    -- Apply damage directly
                                                                    humanoid:TakeDamage(20)
                                                                    
                                                                    -- Create visual effect
                                                                    local hitEffect = Instance.new("Part")
                                                                    hitEffect.Size = Vector3.new(1, 1, 1)
                                                                    hitEffect.Position = endPos
                                                                    hitEffect.BrickColor = BrickColor.new("Really red")
                                                                    hitEffect.Material = Enum.Material.Neon
                                                                    hitEffect.Anchored = true
                                                                    hitEffect.CanCollide = false
                                                                    hitEffect.Parent = workspace
                                                                    
                                                                    -- Remove effect after short time
                                                                    game:GetService("Debris"):AddItem(hitEffect, 0.5)
                                                                end
                                                            end
                                                            
                                                            -- Remove the bullet
                                                            obj:Destroy()
                                                            if connection then
                                                                connection:Disconnect()
                                                            end
                                                        end
                                                    end)
                                                end
                                            end
                                        end
                                    end)
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
                        if not localPlayer.Character then return end
                        
                        local hitboxSize = getgenv().HitboxSize or 5
                        local transparency = getgenv().HitboxTransparency or 0.5
                        
                        for _, player in ipairs(game.Players:GetPlayers()) do
                            if player ~= localPlayer then -- CRITICAL: Only affect OTHER players
                                local char = player.Character
                                if char and char:FindFirstChild("HumanoidRootPart") then
                                    local hrp = char:FindFirstChild("HumanoidRootPart")
                                    
                                    -- Method 1: Directly scale the player's body parts
                                    for _, part in ipairs(char:GetChildren()) do
                                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                                            -- Store original size if not already stored
                                            if not part:GetAttribute("OriginalSize") then
                                                part:SetAttribute("OriginalSize", part.Size)
                                            end
                                            
                                            -- Scale the part based on hitbox size multiplier
                                            local originalSize = part:GetAttribute("OriginalSize")
                                            local scaleFactor = 1 + (hitboxSize / 10) -- Scale factor based on slider
                                            part.Size = originalSize * scaleFactor
                                        end
                                    end
                                    
                                    -- Method 2: Create invisible hitbox parts that transfer damage
                                    local hitbox = hrp:FindFirstChild("FunctionalHitbox")
                                    if not hitbox then
                                        hitbox = Instance.new("Part")
                                        hitbox.Name = "FunctionalHitbox"
                                        hitbox.Anchored = false
                                        hitbox.CanCollide = false
                                        hitbox.Massless = true
                                        hitbox.Transparency = transparency
                                        hitbox.BrickColor = BrickColor.new("Really red")
                                        hitbox.Material = Enum.Material.ForceField
                                        hitbox.Parent = hrp
                                        
                                        -- Use WeldConstraint for better syncing
                                        local weld = Instance.new("WeldConstraint")
                                        weld.Part0 = hrp
                                        weld.Part1 = hitbox
                                        weld.Parent = weld
                                        
                                        -- Store reference to real player
                                        hitbox:SetAttribute("RealPlayer", player)
                                        hitbox:SetAttribute("IsPlayerHitbox", true)
                                    end
                                    
                                    -- Update hitbox size
                                    hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                                    hitbox.Transparency = transparency
                                    
                                    -- Method 3: Hook into the game's damage system
                                    local humanoid = char:FindFirstChild("Humanoid")
                                    if humanoid and not humanoid:GetAttribute("HitboxHooked") then
                                        humanoid:SetAttribute("HitboxHooked", true)
                                        humanoid:SetAttribute("OriginalHealth", humanoid.Health)
                                        
                                        -- Create a connection to detect when player should take damage
                                        local connection
                                        connection = game:GetService("RunService").Heartbeat:Connect(function()
                                            if not getgenv().HitboxExpanderEnabled or not humanoid or not humanoid.Parent then
                                                if connection then
                                                    connection:Disconnect()
                                                end
                                                return
                                            end
                                            
                                            -- Check if local player's weapon is near the expanded hitbox
                                            local localChar = localPlayer.Character
                                            if localChar then
                                                local tool = localChar:FindFirstChildWhichIsA("Tool") or localPlayer.Backpack:FindFirstChildWhichIsA("Tool")
                                                if tool and (tool.Name == "Knife" or tool.Name == "Gun") then
                                                    local toolHandle = tool:FindFirstChild("Handle")
                                                    if toolHandle then
                                                        local distance = (toolHandle.Position - hrp.Position).Magnitude
                                                        if distance <= hitboxSize then
                                                            -- Simulate a direct hit on the player
                                                            local originalDistance = (toolHandle.Position - hrp.Position).Magnitude
                                                            if originalDistance <= 2 then -- Normal hit range
                                                                -- This is a normal hit, let game handle it
                                                                return
                                                            else
                                                                -- This is an expanded hitbox hit, force damage
                                                                if tool.Name == "Knife" and player ~= localPlayer then -- EXTRA PROTECTION
                                                                    -- Knife hit - apply damage directly
                                                                    humanoid:TakeDamage(40) -- Typical knife damage
                                                                elseif tool.Name == "Gun" and player ~= localPlayer then -- EXTRA PROTECTION
                                                                    -- Gun hit - apply damage directly
                                                                    humanoid:TakeDamage(20) -- Typical gun damage
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                        
                        -- CRITICAL: Ensure local player is never affected
                        local localChar = localPlayer.Character
                        if localChar then
                            -- Remove any hitbox expanders from local player
                            local localHrp = localChar:FindFirstChild("HumanoidRootPart")
                            if localHrp then
                                local hitbox = localHrp:FindFirstChild("FunctionalHitbox")
                                if hitbox then
                                    hitbox:Destroy()
                                end
                            end
                            
                            -- Restore local player's body part sizes
                            for _, part in ipairs(localChar:GetChildren()) do
                                if part:IsA("BasePart") and part:GetAttribute("OriginalSize") then
                                    part.Size = part:GetAttribute("OriginalSize")
                                    part:SetAttribute("OriginalSize", nil)
                                end
                            end
                            
                            -- Remove hitbox hook from local player's humanoid
                            local localHumanoid = localChar:FindFirstChild("Humanoid")
                            if localHumanoid then
                                localHumanoid:SetAttribute("HitboxHooked", nil)
                                localHumanoid:SetAttribute("OriginalHealth", nil)
                            end
                        end
                    end)
                    task.wait(0.1)
                end
            end)()
        else
            -- Clean up hitbox expanders and restore original sizes when disabled
            pcall(function()
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
                        
                        -- Remove hitbox hook from humanoid
                        local humanoid = char:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid:SetAttribute("HitboxHooked", nil)
                            humanoid:SetAttribute("OriginalHealth", nil)
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
                        local coinsFound = {}
                        
                        -- Comprehensive coin search
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            local isCoin = false
                            
                            -- Multiple detection methods
                            if obj:IsA("Part") or obj:IsA("MeshPart") then
                                -- Check by name
                                if obj.Name:lower():find("coin") or obj.Name:lower():find("money") or obj.Name:lower():find("cash") then
                                    isCoin = true
                                end
                                
                                -- Check by color (common coin colors)
                                local colorsToCheck = {
                                    BrickColor.new("Bright yellow"),
                                    BrickColor.new("Yellow"),
                                    BrickColor.new("New Yeller"),
                                    BrickColor.new("Gold"),
                                    BrickColor.new("Bright orange")
                                }
                                for _, color in ipairs(colorsToCheck) do
                                    if obj.BrickColor == color then
                                        isCoin = true
                                        break
                                    end
                                end
                                
                                -- Check if it's a collectible (common MM2 coin properties)
                                if obj:FindFirstChild("TouchTransmitter") or obj:FindFirstChild("ClickDetector") then
                                    if obj.Size.X <= 3 and obj.Size.Y <= 3 and obj.Size.Z <= 3 then -- Small parts are likely coins
                                        isCoin = true
                                    end
                                end
                            end
                            
                            if isCoin then
                                local distance = (obj.Position - hrp.Position).Magnitude
                                if distance <= 500 then -- Increased range to 500 studs
                                    table.insert(coinsFound, {
                                        coin = obj,
                                        distance = distance,
                                        position = obj.Position
                                    })
                                end
                            end
                        end
                        
                        -- Sort coins by distance (closest first)
                        table.sort(coinsFound, function(a, b)
                            return a.distance < b.distance
                        end)
                        
                        -- Teleport to each coin and collect it
                        for _, coinData in ipairs(coinsFound) do
                            if not getgenv().CoinAutoFarmEnabled then break end -- Stop if disabled mid-farming
                            
                            local coin = coinData.coin
                            if coin and coin.Parent then -- Make sure coin still exists
                                -- Teleport directly to coin
                                hrp.Position = coin.Position
                                task.wait(0.1)
                                
                                -- Try multiple collection methods
                                -- Method 1: Touch the coin
                                coin.CanCollide = false
                                coin.Position = hrp.Position
                                task.wait(0.1)
                                
                                -- Method 2: Fire touch events if they exist
                                if coin:FindFirstChild("TouchTransmitter") then
                                    for _, connection in ipairs(coin.TouchTransmitter:GetConnectedChildren()) do
                                        if connection:IsA("RemoteEvent") then
                                            connection:FireServer()
                                        end
                                    end
                                end
                                
                                -- Method 3: Click if click detector exists
                                if coin:FindFirstChild("ClickDetector") then
                                    coin.ClickDetector.MaxActivationDistance = 100
                                    fireclickdetector(coin.ClickDetector)
                                end
                                
                                -- Small delay between coins
                                task.wait(0.2)
                                
                                -- Check if coin was collected (removed from workspace)
                                if not coin.Parent then
                                    -- Coin successfully collected
                                else
                                    -- Try alternative collection method
                                    hrp.Position = coin.Position + Vector3.new(0, 2, 0)
                                    task.wait(0.1)
                                    hrp.Position = coin.Position
                                    task.wait(0.1)
                                end
                            end
                        end
                        
                        -- Return to original position
                        hrp.Position = originalPosition
                        task.wait(1) -- Wait before next cycle
                    end)
                    task.wait(3) -- Check every 3 seconds
                end
            end)()
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
                            
                            -- Search for gun in workspace
                            for _, obj in ipairs(workspace:GetDescendants()) do
                                if obj:IsA("Tool") and obj.Name == "Gun" then
                                    gunFound = true
                                    gunPosition = obj:GetPrimaryPartCFrame().Position
                                    break
                                end
                            end
                            
                            -- If gun found, teleport to it and grab it
                            if gunFound and gunPosition then
                                local originalPosition = char:FindFirstChild("HumanoidRootPart").Position
                                
                                -- Teleport to gun
                                char:FindFirstChild("HumanoidRootPart").Position = gunPosition
                                task.wait(0.5)
                                
                                -- Try to grab the gun
                                for _, obj in ipairs(workspace:GetDescendants()) do
                                    if obj:IsA("Tool") and obj.Name == "Gun" then
                                        if (obj:GetPrimaryPartCFrame().Position - gunPosition).Magnitude < 10 then
                                            localPlayer.Character:FindFirstChild("Humanoid"):EquipTool(obj)
                                            break
                                        end
                                    end
                                end
                                
                                task.wait(0.3)
                                
                                -- Teleport back to original position
                                char:FindFirstChild("HumanoidRootPart").Position = originalPosition
                                
                                -- Disable after grabbing gun
                                getgenv().AutoGrabGunEnabled = false
                                if Rayfield then
                                    Rayfield:Notify({
                                        Title = "Auto Grab Gun",
                                        Content = "Gun grabbed successfully!",
                                        Duration = 3
                                    })
                                end
                            end
                        end
                    end)
                    task.wait(1) -- Check every second
                end
            end)()
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
