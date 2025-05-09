--[[
To log messages in console before script executed, paste this codeblock in your main script:
if not _G.__LOGS_BEFORE then
    _G.__LOGS_BEFORE = {}
    _G.__INSERTING_LOGS = {}

    local LogService = game:GetService("LogService")
    LogService.MessageOut:Connect(function(msg, msgType)
        table.insert(_G.__LOGS_BEFORE, {text = msg, type = msgType, time = os.time()})
        for _, fn in ipairs(_G.__INSERTING_LOGS) do
            pcall(fn, msg, msgType)
        end
    end)
end

function _G.__INSERT_LOGS(fn)
    table.insert(_G.__INSERTING_LOGS, fn)
    return _G.__LOGS_BEFORE
end
]]

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

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(1, 0, 0, 30)
copyButton.Position = UDim2.new(0, 0, 1, -35)
copyButton.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.Text = "Copy"
copyButton.Font = Enum.Font.SourceSans
copyButton.TextSize = 16
copyButton.Parent = frame

local logList = Instance.new("UIListLayout")
logList.Parent = scrollFrame
logList.SortOrder = Enum.SortOrder.LayoutOrder
logList.Padding = UDim.new(0, 2)

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

    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(1, -10, 0, 1)
    divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    divider.BackgroundTransparency = 0.95 
    divider.Parent = scrollFrame
end

if _G.__INSERT_LOGS then
    local logs = _G.__INSERT_LOGS(function(msg, msgType)
        local color = Color3.new(216, 215, 215)
        if msgType == Enum.MessageType.MessageWarning then
            color = Color3.fromRGB(236, 202, 65)
        elseif msgType == Enum.MessageType.MessageError then
            color = Color3.fromRGB(161, 73, 63)
        elseif msgType == Enum.MessageType.MessageInfo then
            color = Color3.fromRGB(0, 170, 255)
        end
        addMessage(msg, color)
    end)
    for _, entry in ipairs(logs) do
        local color = Color3.new(216, 215, 215)
        if entry.type == Enum.MessageType.MessageWarning then
            color = Color3.fromRGB(236, 202, 65)
        elseif entry.type == Enum.MessageType.MessageError then
            color = Color3.fromRGB(161, 73, 63)
        elseif entry.type == Enum.MessageType.MessageInfo then
            color = Color3.fromRGB(0, 170, 255)
        end
        addMessage(entry.text, color)
    end
else
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
end

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = title.BackgroundColor3
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Text = "×"
closeButton.Font = Enum.Font.SourceSans
closeButton.TextSize = 24
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    local exitTween = TweenService:Create(frame, tweenInfo, { Position = UDim2.new(0.5, -200, -0.5, -175) })
    exitTween:Play()
    exitTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
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
