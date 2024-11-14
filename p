local FillColor = Color3.fromRGB(175, 25, 255)
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = Color3.fromRGB(255, 255, 255)
local OutlineTransparency = 0

local CoreGui = game:FindService("CoreGui")
local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Ghost_Highlight_Storage"

local function HighlightGhost()
    -- Check if the ghost exists in the workspace
    local ghost = workspace:FindFirstChild("Ghost")
    if ghost then
        -- Iterate through all the ghost parts
        for _, part in ipairs(ghost:GetChildren()) do
            if part:IsA("BasePart") then
                -- Create a highlight for the ghost part
                local highlight = Instance.new("Highlight")
                highlight.Name = "GhostHighlight_" .. part.Name
                highlight.FillColor = FillColor
                highlight.DepthMode = DepthMode
                highlight.FillTransparency = FillTransparency
                highlight.OutlineColor = OutlineColor
                highlight.OutlineTransparency = OutlineTransparency
                highlight.Adornee = part
                highlight.Parent = Storage
            end
        end
    end
end

-- Function to clear highlights when the ghost is no longer detected
local function ClearGhostHighlight()
    for _, highlight in ipairs(Storage:GetChildren()) do
        if highlight:IsA("Highlight") then
            highlight:Destroy()
        end
    end
end

-- Continuously check for the ghost and apply ESP
while true do
    -- Clear previous highlights to prevent duplicates
    ClearGhostHighlight()
    
    -- Highlight the ghost if it exists
    HighlightGhost()
    
    -- Wait for a short interval before checking again
    wait(1)
end
