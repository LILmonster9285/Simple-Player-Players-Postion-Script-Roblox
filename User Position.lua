local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerPositionsGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Title Label
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -20, 0, 35)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Text = "Players Positions:"
label.Font = Enum.Font.SourceSansBold
label.TextSize = 24
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = frame

-- ScrollingFrame for text
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 0, 230)
scrollFrame.Position = UDim2.new(0, 10, 0, 50)
scrollFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 8
scrollFrame.Parent = frame

-- TextLabel inside scrollFrame to hold positions text
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -10, 0, 0)
textLabel.Position = UDim2.new(0, 5, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1,1,1)
textLabel.TextWrapped = true
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.TextYAlignment = Enum.TextYAlignment.Top
textLabel.Font = Enum.Font.SourceSans
textLabel.TextSize = 16
textLabel.Parent = scrollFrame

-- Button to populate positions
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 35)
button.Position = UDim2.new(0, 10, 1, -40)
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.Text = "Show Players Positions"
button.Parent = frame

-- Helper function to format player positions
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

-- Update textLabel and scroll size
local function updateText(text)
    textLabel.Text = text
    local lines = select(2, text:gsub('\n', '\n')) + 1
    local lineHeight = 20
    local height = lines * lineHeight
    textLabel.Size = UDim2.new(1, -10, 0, height)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, height)
end

-- Button click event
button.MouseButton1Click:Connect(function()
    local positionsText = getPlayerPositionsText()
    updateText(positionsText)
end)
