local function ESP(model)
    task.spawn(function()
        local playerName = model.Name
        local existingESP = COREGUI:FindFirstChild(playerName .. '_ESP')
        if existingESP then
            existingESP:Destroy()
        end

        local ESPholder = Instance.new("Folder")
        ESPholder.Name = playerName .. '_ESP'
        ESPholder.Parent = COREGUI

        local humanoidRootPart = model:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart and model:FindFirstChildOfClass("Humanoid") then
            local BillboardGui = Instance.new("BillboardGui")
            BillboardGui.Adornee = humanoidRootPart
            BillboardGui.Name = playerName
            BillboardGui.Parent = ESPholder
            BillboardGui.Size = UDim2.new(0, 150, 0, 50)
            BillboardGui.StudsOffset = Vector3.new(0, 1.5, 0)
            BillboardGui.AlwaysOnTop = true

            local TextLabel = Instance.new("TextLabel")
            TextLabel.Parent = BillboardGui
            TextLabel.BackgroundTransparency = 1
            TextLabel.Position = UDim2.new(0, 0, 0, 0)
            TextLabel.Size = UDim2.new(0, 150, 0, 25)
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.TextSize = 18
            TextLabel.TextColor3 = Color3.new(1, 0, 0) -- Red for real players (non-NPC)
            TextLabel.TextStrokeTransparency = 0.5
            TextLabel.TextStrokeColor3 = Color3.fromRGB(209, 216, 197)  -- Black outline
            TextLabel.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel.Text = playerName

            local espLoopFunc
            local function espLoop()
                if COREGUI:FindFirstChild(playerName .. '_ESP') then
                    if model and humanoidRootPart then
                        local pos = math.floor((humanoidRootPart.Position - LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).magnitude)
                        TextLabel.Text = playerName .. " (" .. pos .. " studs)"
                    end
                else
                    espLoopFunc:Disconnect()
                end
            end
            espLoopFunc = RunService.RenderStepped:Connect(espLoop)
        end
    end)
