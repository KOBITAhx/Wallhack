local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function DrawOutline(player)
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if humanoid then
        local outline = Instance.new("Outline")
        outline.Parent = humanoid
        outline.Color = Color3.green
        outline.Thickness = 2
    end
end

local function Update()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            DrawOutline(player)
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(Update)
