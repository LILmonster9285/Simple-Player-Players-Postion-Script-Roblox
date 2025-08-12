local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PositionGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 120)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Create TextLabel
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -20, 0, 30)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Text = "Your Position:"
label.Font = Enum.Font.SourceSansBold
label.TextSize = 20
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = frame

-- Create TextBox to display position
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 0, 40)
textBox.Position = UDim2.new(0, 10, 0, 45)
textBox.ClearTextOnFocus = false
textBox.Text = "Click 'Get Position' to show coords"
textBox.Font = Enum.Font.SourceSans
textBox.TextSize = 18
textBox.TextColor3 = Color3.new(1,1,1)
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textBox.Parent = frame

-- Create Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 30)
button.Position = UDim2.new(0, 10, 1, -40)
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.Text = "Get Position"
button.Parent = frame

-- When button clicked, update textbox with current position
button.MouseButton1Click:Connect(function()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position
        local posString = string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
        textBox.Text = posString
        -- Select all text in textbox to make copying easier
        textBox:CaptureFocus()
        textBox.SelectionStart = 1
        textBox.SelectionLength = #posString
    else
        textBox.Text = "HumanoidRootPart not found"
    end
end)
