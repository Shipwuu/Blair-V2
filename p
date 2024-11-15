-- Services needed for the script
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Variables
local Clip = true
local Noclipping = nil
local speaker = Players.LocalPlayer  -- Get the local player

-- GUI for Toggle Button
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the ScreenGui to hold the button
local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "ToggleButtonGui"
toggleGui.Parent = playerGui
toggleGui.ResetOnSpawn = false  -- So the button persists across respawns

-- Create the Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 30, 0, 30)  -- Set size to 30x30
toggleButton.Position = UDim2.new(0.5, -15, 0.5, -15)  -- Start near the center of the screen
toggleButton.Text = "Off"
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)  -- Red for "Off" state
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
toggleButton.Parent = toggleGui

local isToggled = false  -- Track toggle state
local isDragging = false  -- Track dragging state
local dragStart, startPos  -- Variables to keep track of drag positions

-- Function to toggle noclip for parts under "workspace.Map.Doors"
function toggleNoclip()
    Clip = not Clip  -- Toggle Clip between true and false

    if not Clip then
        print("Noclip activated for workspace.Map.Doors.")
        
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

-- Function to toggle the button between "On" and "Off"
local function toggleButtonState()
    isToggled = not isToggled
    if isToggled then
        toggleButton.Text = "On"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)  -- Green for "On" state
    else
        toggleButton.Text = "Off"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)  -- Red for "Off" state
    end

    -- Toggle noclip whenever the button state is toggled
    toggleNoclip()
end

-- Connect button click to the toggle function
toggleButton.MouseButton1Click:Connect(toggleButtonState)

-- Dragging Logic for Toggle Button
toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = toggleButton.Position
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        toggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)
