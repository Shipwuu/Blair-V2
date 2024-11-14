-- Special ESP for "Ghost" path
local function highlightGhost()
    local ghost = Workspace:FindFirstChild("Ghost")
    if ghost then
        local FillColor = Color3.fromRGB(175, 25, 255)
        local DepthMode = "AlwaysOnTop"
        local FillTransparency = 0.5
        local OutlineColor = Color3.fromRGB(255, 255, 255)
        local OutlineTransparency = 0

        local Storage = COREGUI:FindFirstChild("Highlight_Storage")
        if not Storage then
            Storage = Instance.new("Folder")
            Storage.Parent = COREGUI
            Storage.Name = "Highlight_Storage"
        end

        local Highlight = Instance.new("Highlight")
        Highlight.Name = "Ghost_Highlight"
        Highlight.FillColor = FillColor
        Highlight.DepthMode = DepthMode
        Highlight.FillTransparency = FillTransparency
        Highlight.OutlineColor = OutlineColor
        Highlight.OutlineTransparency = OutlineTransparency
        Highlight.Parent = Storage
        Highlight.Adornee = ghost
    end
end

-- Call the ghost highlight function
highlightGhost()
