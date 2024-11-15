-- Create a ScreenGui for the button
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local buttonGui = Instance.new("ScreenGui")
buttonGui.Name = "NoclipDoorsButtonGui"
buttonGui.Parent = playerGui
buttonGui.ResetOnSpawn = false

-- Create the noclip button
local noclipButton = Instance.new("TextButton")
noclipButton.Name = "NoclipDoorsButton"
noclipButton.Parent = buttonGui
noclipButton.Size = UDim2.new(0, 80, 0, 40) -- Button size (80x40 pixels)
noclipButton.Position = UDim2.new(1, -370, 0, 80) -- Positioned below the specified position
noclipButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background color
noclipButton.BackgroundTransparency = 0.8 -- Set transparency
noclipButton.Text = "NOCLIP"
noclipButton.TextColor3 = Color3.new(1, 0, 0) -- Red text color initially (off state)
noclipButton.Font = Enum.Font.SourceSansBold
noclipButton.TextScaled = true

-- Add UICorner to the noclip button for rounded edges
local cornerDelete = Instance.new("UICorner")
cornerDelete.Parent = noclipButton

-- Variables for Noclip Functionality
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Clip = true
local Noclipping = nil
local speaker = Players.LocalPlayer  -- Get the local player

-- Function to toggle noclip for parts under "workspace.Map.Doors"
function toggleNoclip()
    Clip = not Clip  -- Toggle Clip between true and false

    if not Clip then
        print("Noclip activated for workspace.Map.Doors.")
        
        -- Change button text color to green for "On"
        noclipButton.TextColor3 = Color3.fromRGB(0, 255, 0)  -- Green color
        
        -- Function to run the noclip logic
        local function NoclipLoop()
            if Clip == false and speaker.Character ~= nil then
                for _, child in pairs(workspace.Map.Doors:GetDescendants()) do
                    if child:IsA("BasePart") then
                        child.CanCollide = false  -- Disable collisions
                    end
                end
            end
        end

        -- Start the noclip loop to disable collisions with "workspace.Map.Doors"
        Noclipping = RunService.Stepped:Connect(NoclipLoop)
    else
        print("Noclip deactivated for workspace.Map.Doors.")
        
        -- Change button text color to red for "Off"
        noclipButton.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Red color

        -- Disconnect the noclip connection to stop noclipping
        if Noclipping then
            Noclipping:Disconnect()
            Noclipping = nil
        end

        -- Reset collisions for workspace.Map.Doors
        for _, child in pairs(workspace.Map.Doors:GetDescendants()) do
            if child:IsA("BasePart") then
                child.CanCollide = true  -- Enable collisions
            end
        end
    end
end

-- Function to animate the button text with fade in and fade out effects
local function animateButtonText()
    local texts = {"NOCLIP", "DOORS"}
    local currentTextIndex = 1
    while noclipButton.Parent do
        noclipButton.Text = texts[currentTextIndex]
        
        -- Fade in
        for i = 0, 1, 0.05 do
            noclipButton.TextTransparency = 1 - i
            wait(0.05)
        end
        
        wait(0.8) -- Wait for 0.8 seconds
        
        -- Fade out
        for i = 0, 1, 0.05 do
            noclipButton.TextTransparency = i
            wait(0.05)
        end
        
        wait(0.1)
        
        -- Switch to the next text
        currentTextIndex = currentTextIndex % #texts + 1
    end
end

-- Start the text animation
spawn(animateButtonText)

-- Connect the button click to toggleNoclip function
noclipButton.MouseButton1Click:Connect(toggleNoclip)
