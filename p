local players = game.Players:GetChildren()

for _, player in pairs(players) do
    if player.Name ~= game.Players.LocalPlayer.Name then
        if player.Humanoid then
            if not player:FindFirstChild("Highlight") then
                local highlight = Instance.new('Highlight')
                highlight.Parent = player
                highlight.FaceColor = Color3.new(255, 255, 255) -- Change this to the desired color
                highlight.Transparency = 0.5 -- Change this to the desired transparency
            end
        end
    end
end
