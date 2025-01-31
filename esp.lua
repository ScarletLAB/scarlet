local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- // esp func
local ESP = {
    NameESP = {},
    BoxESP = {},
    TracerESP = {},
    Chams = {}
}

local function createDrawing(type, properties)
    local drawing = Drawing.new(type)
    for prop, value in pairs(properties) do
        drawing[prop] = value
    end
    return drawing
end

-- // esp (name/dist)
function ESP.NameESP:Create(player)
    self[player] = createDrawing("Text", {
        Visible = false,
        Color = Color3.fromRGB(255, 255, 255),
        Size = 12.5,
        Center = true,
        Font = 3
    })
end

function ESP.NameESP:Update(player)
    local character, text = player.Character, self[player]
    local rootPart = character and character:FindFirstChild("Head")

    if rootPart and text then
        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        if onScreen then
            local distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude)
            text.Text = player.Name .. " | " .. tostring(distance) .. "м"
            text.Position = Vector2.new(screenPos.X, screenPos.Y - (2500 / screenPos.Z) / 2 - 10)
            text.Visible = true
        else
            text.Visible = false
        end
    else
        text.Visible = false
    end
end

function ESP.NameESP:Remove(player)
    if self[player] then
        self[player]:Remove()
        self[player] = nil
    end
end

-- // box
function ESP.BoxESP:Create(player)
    self[player] = createDrawing("Square", {
        Visible = false,
        Color = Color3.new(1, 1, 1),
        Thickness = 1,
        Filled = false
    })
end

function ESP.BoxESP:Update(player)
    local character, box = player.Character, self[player]
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

    if rootPart and box then
        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        if onScreen then
            local scaleFactor = screenPos.Z
            local size = Vector2.new(2250 / scaleFactor, 3800 / scaleFactor)
            box.Size = size
            box.Position = Vector2.new(screenPos.X - size.X / 2, screenPos.Y - size.Y / 2)
            box.Visible = true
        else
            box.Visible = false
        end
    else
        box.Visible = false
    end
end

function ESP.BoxESP:Remove(player)
    if self[player] then
        self[player]:Remove()
        self[player] = nil
    end
end

-- // tracers
function ESP.TracerESP:Create(player)
    self[player] = createDrawing("Line", {
        Visible = false,
        Color = Color3.new(1, 1, 1),
        Thickness = 1
    })
end

function ESP.TracerESP:Update(player)
    local character, tracer = player.Character, self[player]
    local rootPart = character and character:FindFirstChild("Head")

    if rootPart and tracer then
        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        if onScreen then
            tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            tracer.To = Vector2.new(screenPos.X, screenPos.Y)
            tracer.Visible = true
        else
            tracer.Visible = false
        end
    else
        tracer.Visible = false
    end
end

function ESP.TracerESP:Remove(player)
    if self[player] then
        self[player]:Remove()
        self[player] = nil
    end
end

-- // chams
function ESP.Chams:Create(player)
    if player == LocalPlayer then
        return
    end

        local highlight = Instance.new("Highlight")
        highlight.Adornee = character
        highlight.Parent = character
        highlight.FillColor = TColorpicker.Value
        highlight.OutlineColor = TColorpicker.Value
        highlight.FillTransparency = TColorpicker.Transparency
        highlight.OutlineTransparency = TColorpicker.Transparency
        self[player] = highlight

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                self:Remove(player)
    end)
end

    if player.Character then
        setupHighlight(player.Character)
    end

    player.CharacterAdded:Connect(function(character)
        setupHighlight(character)
    end)
end

function ESP.Chams:Remove(player)
    local highlight = self[player]
    if highlight then
        highlight:Destroy()
        self[player] = nil
    end
end
