-- Services
local Players = game:GetService("Players")

-- Function to create ESP with BillboardGui
local function createESP(player)
    -- Exclude the local player
    if player == Players.LocalPlayer then return end

    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    -- Create BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = player.Name .. "_ESP"
    billboard.Adornee = character.HumanoidRootPart
    billboard.Size = UDim2.new(0, 200, 0, 50) -- Set the size of the BillboardGui
    billboard.StudsOffset = Vector3.new(0, 3, 0)  -- Position above the character
    billboard.AlwaysOnTop = true
    billboard.Parent = character.HumanoidRootPart

    -- Create a frame to hold text labels
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)  -- Full size of the BillboardGui
    frame.BackgroundTransparency = 1
    frame.Parent = billboard

    -- Create Username TextLabel at the top
    local usernameLabel = Instance.new("TextLabel")
    usernameLabel.Size = UDim2.new(1, 0, 0.5, -5)  -- Top half of the frame, reduce height to reduce distance
    usernameLabel.Position = UDim2.new(0, 0, 0, 0)
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.Font = Enum.Font.GothamBold
    usernameLabel.Text = "@" .. player.Name
    usernameLabel.TextColor3 = Color3.fromRGB(255, 215, 0)  -- Gold color for the username
    usernameLabel.TextSize = 14  -- Small text size
    usernameLabel.TextStrokeTransparency = 0.7  -- Slight text outline for visibility
    usernameLabel.TextXAlignment = Enum.TextXAlignment.Center
    usernameLabel.TextYAlignment = Enum.TextYAlignment.Bottom  -- Move closer to the bottom
    usernameLabel.Parent = frame

    -- Create DisplayName TextLabel at the bottom
    local displayNameLabel = Instance.new("TextLabel")
    displayNameLabel.Size = UDim2.new(1, 0, 0.5, -5)  -- Bottom half of the frame, reduce height to reduce distance
    displayNameLabel.Position = UDim2.new(0, 0, 0.5, 0)
    displayNameLabel.BackgroundTransparency = 1
    displayNameLabel.Font = Enum.Font.GothamBold
    displayNameLabel.Text = player.DisplayName
    displayNameLabel.TextColor3 = Color3.fromRGB(255, 215, 0)  -- Gold color for the display name
    displayNameLabel.TextSize = 12  -- Small text size
    displayNameLabel.TextStrokeTransparency = 0.7  -- Slight text outline for visibility
    displayNameLabel.TextXAlignment = Enum.TextXAlignment.Center
    displayNameLabel.TextYAlignment = Enum.TextYAlignment.Top  -- Align towards the top to bring closer to the username
    displayNameLabel.Parent = frame

    -- Add UIGradient animation for shiny white effect
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Parent = usernameLabel
    uiGradient.Offset = Vector2.new(-1, 0)  -- Start position of the gradient at the beginning
    uiGradient.Rotation = 0  -- Horizontal gradient
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),  -- Starting color (white)
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 200, 200)), -- Intermediate color (lighter white)
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))   -- Ending color (white)
    })
    uiGradient.Enabled = true

    -- Add UIGradient animation for the bottom label as well
    local uiGradientBottom = Instance.new("UIGradient")
    uiGradientBottom.Parent = displayNameLabel
    uiGradientBottom.Offset = Vector2.new(-1, 0)  -- Start position of the gradient at the beginning
    uiGradientBottom.Rotation = 0  -- Horizontal gradient
    uiGradientBottom.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),  -- Starting color (white)
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 200, 200)), -- Intermediate color (lighter white)
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))   -- Ending color (white)
    })
    uiGradientBottom.Enabled = true

    -- Create a loop to animate the shiny gradient effect
    local function animateShinyEffect()
        while true do
            for i = -1, 1, 0.02 do
                uiGradient.Offset = Vector2.new(i, 0)  -- Move the gradient smoothly
                uiGradientBottom.Offset = Vector2.new(i, 0)
                wait(0.05)  -- Slower speed for smooth animation
            end
        end
    end

    -- Start the animation loop for shiny effect
    spawn(animateShinyEffect)
end

-- Connect to new players joining and create ESP for them
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        createESP(player)
    end)
end)

-- Create ESP for players who are already in the game
for _, player in pairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer and player.Character then
        createESP(player)
    end
end
