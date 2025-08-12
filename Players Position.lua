
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerPositionsGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 320)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -20, 0, 35)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Text = "Players Positions (select & copy):"
label.Font = Enum.Font.SourceSansBold
label.TextSize = 24
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = frame

-- TextBox (multi-line, selectable) for displaying positions
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 0, 230)
textBox.Position = UDim2.new(0, 10, 0, 50)
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textBox.TextColor3 = Color3.new(1,1,1)
textBox.Font = Enum.Font.SourceSans
textBox.TextSize = 16
textBox.ClearTextOnFocus = false
textBox.MultiLine = true
textBox.TextWrapped = true
textBox.Text = "Click the button to load player positions."
textBox.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 40)
button.Position = UDim2.new(0, 10, 1, -55)
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 24
button.Text = "Show Players Positions"
button.Parent = frame

local function getPlayerPositionsText()
    local output = {}
    for _, plr in pairs(Players:GetPlayers()) do
        local character = plr.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local pos = hrp.Position
            table.insert(output, plr.Name .. ": Vector3.new(" .. string.format("%.2f, %.2f, %.2f", pos.X, pos.Y, pos.Z) .. ")")
        else
            table.insert(output, plr.Name .. ": HumanoidRootPart not found")
        end
    end
    return table.concat(output, "\n")
end

button.MouseButton1Click:Connect(function()
    textBox.Text = getPlayerPositionsText()
    textBox:CaptureFocus()
    textBox.CursorPosition = 1
end)
