function onRender()
  for i, player in pairs(game.Players:GetChildren()) do
    if player ~= game.Players.LocalPlayer then
      local humanoid = player:FindFirstChildOfClass("Humanoid")
      if humanoid then
        local head = humanoid:FindFirstChild("Head")
        local torso = humanoid:FindFirstChild("Torso")
        if head and torso then
          local headPos = head.Position
          local torsoPos = torso.Position
          local centerPos = (headPos + torsoPos) / 2
          drawBox(centerPos, Vector3.new(1, 1, 1), Color3.green)
        end
      end
    end
  end
end

function drawBox(position, size, color)
  local x, y, z = position.x, position.y, position.z
  local sx, sy, sz = size.x, size.y, size.z
  local vertices = {
    {x - sx, y - sy, z - sz},
    {x + sx, y - sy, z - sz},
    {x + sx, y + sy, z - sz},
    {x - sx, y + sy, z - sz},
    {x - sx, y - sy, z + sz},
    {x + sx, y - sy, z + sz},
    {x + sx, y + sy, z + sz},
    {x - sx, y + sy, z + sz},
  }
  for i = 1, #vertices do
    local v1 = vertices[i]
    local v2 = vertices[i % #vertices + 1]
    drawLine(v1, v2, color)
  end
end

function drawLine(start, end, color)
  local dx = end.x - start.x
  local dy = end.y - start.y
  local dz = end.z - start.z
  local length = math.sqrt(dx^2 + dy^2 + dz^2)
  local dir = Vector3.new(dx, dy, dz) / length
  local offset = 0.05
  local vertices = {
    start + dir * offset,
    start - dir * offset,
    end - dir * offset,
    end + dir * offset,
  }
  for i = 1, #vertices do
    local v1 = vertices[i]
    local v2 = vertices[i % #vertices + 1]
    render.DrawLine(v1, v2, color, 2)
  end
end

game:GetService("RunService").RenderStepped:Connect(onRender)
