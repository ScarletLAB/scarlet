local Players = game:GetService("Players")
local LogService = game:GetService("LogService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ConsoleMenu"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 350)
frame.Position = UDim2.new(0.5, -200, -0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
frame.Parent = screenGui

local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local targetPosition = UDim2.new(0.5, -200, 0.5, -175)
local tween = TweenService:Create(frame, tweenInfo, { Position = targetPosition })
tween:Play()

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
title.TextColor3 = Color3.new(1, 1, 1)
title.Text = "Console"
title.Font = Enum.Font.SourceSans
title.TextSize = 16
title.Parent = frame

title.Active = true

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local startPos = frame.Position
        local startMousePos = input.Position
        
        local moveConnection, releaseConnection
        
        moveConnection = UserInputService.InputChanged:Connect(function(moveInput)
            if moveInput.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = moveInput.Position - startMousePos
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        releaseConnection = UserInputService.InputEnded:Connect(function(releaseInput)
            if releaseInput.UserInputType == Enum.UserInputType.MouseButton1 then
                moveConnection:Disconnect()
                releaseConnection:Disconnect()
            end
        end)
    end
end)

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -70)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
scrollFrame.ScrollBarThickness = 6
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = frame

local logList = Instance.new("UIListLayout")
logList.Parent = scrollFrame
logList.SortOrder = Enum.SortOrder.LayoutOrder
logList.Padding = UDim.new(0, 2)

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(1, 0, 0, 30)
copyButton.Position = UDim2.new(0, 0, 1, -35)
copyButton.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.Text = "Copy"
copyButton.Font = Enum.Font.SourceSans
copyButton.TextSize = 16
copyButton.Parent = frame

local function addMessage(text, color)
    local messageBox = Instance.new("TextBox")
    messageBox.Size = UDim2.new(1, -10, 0, 20)
    messageBox.AutomaticSize = Enum.AutomaticSize.Y  
    messageBox.BackgroundTransparency = 1
    messageBox.TextColor3 = color
    messageBox.Text = text
    messageBox.TextXAlignment = Enum.TextXAlignment.Left
    messageBox.TextWrapped = true
    messageBox.Font = Enum.Font.Code
    messageBox.TextSize = 16.5
    messageBox.ClearTextOnFocus = false
    messageBox.TextEditable = false
    messageBox.Selectable = true
    messageBox.Parent = scrollFrame
end

LogService.MessageOut:Connect(function(message, messageType)
    local color = Color3.new(216, 215, 215)

    if messageType == Enum.MessageType.MessageWarning then
        color = Color3.fromRGB(236, 202, 65)
    elseif messageType == Enum.MessageType.MessageError then
        color = Color3.fromRGB(161, 73, 63)
    elseif messageType == Enum.MessageType.MessageInfo then
        color = Color3.fromRGB(0, 170, 255)
    end

    addMessage(message, color)
end)

copyButton.MouseButton1Click:Connect(function()
    local messages = {}
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextBox") then
            table.insert(messages, child.Text)
        end
    end

    local copiedText = table.concat(messages, "\n")
    setclipboard(copiedText)
end)
