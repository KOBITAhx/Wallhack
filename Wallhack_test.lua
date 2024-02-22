
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UIS = game:GetService("UIS")

-- Variables
local aimbotActive = false
local targetPlayer = nil

-- Función para encontrar el jugador más cercano
function FindClosestPlayer()
  local closestPlayer = nil
  local closestDistance = math.huge

  for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character then
      local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
      if distance < closestDistance then
        closestDistance = distance
        closestPlayer = player
      end
    end
  end

  return closestPlayer
end

-- Función para actualizar el objetivo del aimbot
function UpdateTarget()
  targetPlayer = FindClosestPlayer()
end

-- Función para el aimbot
function Aimbot()
  if targetPlayer and targetPlayer.Character and not targetPlayer.Character:FindFirstChild("Head") then
    local targetPosition = targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1, 0)
    Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition)
  end
end

-- Función para la casilla de desactivación
function CreateToggleItem()
  local item = Instance.new("Tool")
  item.Name = "Desactivar Aimbot"
  item.Parent = LocalPlayer.Backpack
  item.Activated:Connect(function()
    aimbotActive = not aimbotActive
  end)
end

-- Inicialización
CreateToggleItem()

-- Bucle principal
while wait() do
  if aimbotActive then
    UpdateTarget()
    Aimbot()
  end
end

-- Mensaje de script
print("Script by KOBITA")
