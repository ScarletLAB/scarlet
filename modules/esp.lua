local plrs = game:GetService("Players")
local cam = game.Workspace.CurrentCamera
local plr = plrs.LocalPlayer
local rs = game:GetService("RunService")
local mouse = plr:GetMouse()
local cgui = game:GetService("CoreGui")

params = {
    nameesp = false,
    gunesp = false,
    boxes = false,
    healthbar = false,
    tracers = false,
    chams = false,
    box3d = false,
    skeleton = false,
    tracerpos = "Bottom",
    box3dcolor = Color3.fromRGB(255, 255, 255),
    namecolor = Color3.fromRGB(255, 255, 255),
    gunespcolor = Color3.fromRGB(255, 255, 255),
    boxcolor = Color3.fromRGB(255, 255, 255),
    tracercolor = Color3.fromRGB(255, 255, 255),
    skeletoncolor = Color3.fromRGB(255, 255, 255),
    chamscolor = Color3.fromRGB(111, 206, 174),
    healthbarmaxcolor = Color3.fromRGB(111, 206, 174),
    healthbarmincolor = Color3.fromRGB(255, 255, 255), 
}

-- ESP Functional
local espbase = {}
espbase.__index = espbase

function espbase:new(player)
    local self = setmetatable({}, espbase)
    self.player = player
    return self
end

function espbase:Create()
end
function espbase:Update()
end
function espbase:Remove()
end

local function createDrawing(type, properties)
    local drawing = Drawing.new(type)
    for prop, value in pairs(properties) do
        drawing[prop] = value
    end
    return drawing
end

local function updateDrawing(drawing, visible)
    if drawing then
        drawing.Visible = visible
    end
end

-- Nametags
local nametags = setmetatable({}, {
    __index = espbase
})
nametags.__index = nametags

function nametags:new(player)
    local self = espbase.new(self, player)
    self.gui = nil
    self.textLabel = nil
    return setmetatable(self, nametags)
end

function nametags:Create()
    task.spawn(function()
        pcall(function()
            self.gui = Instance.new("BillboardGui")
            self.gui.Name = "Nametag_" .. self.player.Name
            self.gui.Adornee = nil
            self.gui.Size = UDim2.new(0, 150, 0, 15)
            self.gui.StudsOffset = Vector3.new(0, 6, 0)
            self.gui.AlwaysOnTop = true
            self.gui.LightInfluence = 0
            self.gui.Parent = cgui
            
            self.textLabel = Instance.new("TextLabel")
            self.textLabel.Size = UDim2.new(1, 0, 1, 0)
            self.textLabel.BackgroundTransparency = 1
            self.textLabel.Text = ""
                self.textLabel.TextColor3 = params.namecolor
            self.textLabel.TextScaled = true
            self.textLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
            self.textLabel.TextStrokeTransparency = 0
            self.textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            self.textLabel.Parent = self.gui
        end)
    end)
end

function nametags:Update()
    task.spawn(function()
        pcall(function()
            local character = self.player.Character
            local head = character and character:FindFirstChild("Head")
            
            if head and self.gui and self.textLabel then
                self.gui.Adornee = head
                self.textLabel.Text = "[ " .. self.player.Name .. " ]"
                    self.textLabel.TextColor3 = params.namecolor
                self.gui.Enabled = true
            elseif self.gui then
                self.gui.Enabled = false
            end
        end)
    end)
end

function nametags:Remove()
    task.spawn(function()
        pcall(function()
            if self.gui then
                self.gui:Destroy()
                self.gui = nil
                self.textLabel = nil
            end
        end)
    end)
end

-- Guntags
local guntags = setmetatable({}, {
    __index = espbase
})
guntags.__index = guntags

function guntags:new(player)
    local self = espbase.new(self, player)
    self.gui = nil
    self.textLabel = nil
    return setmetatable(self, guntags)
end

function guntags:Create()
    task.spawn(function()
        pcall(function()
            self.gui = Instance.new("BillboardGui")
            self.gui.Name = "Guntag_" .. self.player.Name
            self.gui.Adornee = nil
            self.gui.Size = UDim2.new(0, 150, 0, 15)
            self.gui.StudsOffset = Vector3.new(0, - 6, 0)
            self.gui.AlwaysOnTop = true
            self.gui.LightInfluence = 0
            self.gui.Parent = cgui
            
            self.textLabel = Instance.new("TextLabel")
            self.textLabel.Size = UDim2.new(1, 0, 1, 0)
            self.textLabel.BackgroundTransparency = 1
            self.textLabel.Text = ""
                self.textLabel.TextColor3 = params.gunespcolor
            self.textLabel.TextScaled = true
            self.textLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
            self.textLabel.TextStrokeTransparency = 0
            self.textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            self.textLabel.Parent = self.gui
        end)
    end)
end

function guntags:Update()
    task.spawn(function()
        pcall(function()
            local character = self.player.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and rootPart and self.gui and self.textLabel then
                local tool = humanoid:FindFirstChild("Tool") or character:FindFirstChildOfClass("Tool")
                local gunName = "None"

                if tool then
                    gunName = tool.Name
                end

                self.gui.Adornee = rootPart
                self.textLabel.Text = "[ " .. gunName .. " ]"
                self.textLabel.TextColor3 = params.gunespcolor
                self.gui.Enabled = true
            elseif self.gui then
                self.gui.Enabled = false
            end
        end)
    end)
end

function guntags:Remove()
    task.spawn(function()
        pcall(function()
            if self.gui then
                self.gui:Destroy()
                self.gui = nil
                self.textLabel = nil
            end
        end)
    end)
end

-- Skeleton
-- govno ebannoe
local skeleton = setmetatable({}, {
    __index = espbase
})
skeleton.__index = skeleton

function skeleton:new(player)
    local self = espbase.new(self, player)
    self.drawings = {
        Lines = {}
    }
    return setmetatable(self, skeleton)
end

function skeleton:Create()
    task.spawn(function()
        pcall(function()
            for i = 1, 15 do
                self.drawings.Lines[i] = createDrawing("Line", {
                    Visible = false,
                        Color = params.skeletoncolor or Color3.fromRGB(255, 255, 255),
                    Thickness = 1.5,
                    ZIndex = 2
                })
            end
        end)
    end)
end

function skeleton:Update()
    task.spawn(function()
        pcall(function()
            local character = self.player.Character
            if character and self.drawings then
                local head = character:FindFirstChild("Head")
                local upperTorso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
                local lowerTorso = character:FindFirstChild("LowerTorso")
                local leftUpperArm = character:FindFirstChild("LeftUpperArm") or character:FindFirstChild("Left Arm")
                local leftLowerArm = character:FindFirstChild("LeftLowerArm")
                local leftHand = character:FindFirstChild("LeftHand")
                local rightUpperArm = character:FindFirstChild("RightUpperArm") or character:FindFirstChild("Right Arm")
                local rightLowerArm = character:FindFirstChild("RightLowerArm")
                local rightHand = character:FindFirstChild("RightHand")
                local leftUpperLeg = character:FindFirstChild("LeftUpperLeg") or character:FindFirstChild("Left Leg")
                local leftLowerLeg = character:FindFirstChild("LeftLowerLeg")
                local leftFoot = character:FindFirstChild("LeftFoot")
                local rightUpperLeg = character:FindFirstChild("RightUpperLeg") or character:FindFirstChild("Right Leg")
                local rightLowerLeg = character:FindFirstChild("RightLowerLeg")
                local rightFoot = character:FindFirstChild("RightFoot")
                local bodyParts = {
                    {
                        head,
                        upperTorso
                    },
                    {
                        upperTorso,
                        lowerTorso
                    },
                    {
                        upperTorso,
                        leftUpperArm
                    },
                    {
                        leftUpperArm,
                        leftLowerArm
                    },
                    {
                        leftLowerArm,
                        leftHand
                    },
                    {
                        upperTorso,
                        rightUpperArm
                    },
                    {
                        rightUpperArm,
                        rightLowerArm
                    },
                    {
                        rightLowerArm,
                        rightHand
                    },
                    {
                        lowerTorso or upperTorso,
                        leftUpperLeg
                    },
                    {
                        leftUpperLeg,
                        leftLowerLeg
                    },
                    {
                        leftLowerLeg,
                        leftFoot
                    },
                    {
                        lowerTorso or upperTorso,
                        rightUpperLeg
                    },
                    {
                        rightUpperLeg,
                        rightLowerLeg
                    },
                    {
                        rightLowerLeg,
                        rightFoot
                    }
                }
                local Connections = 0
                for i, connection in ipairs(bodyParts) do
                    local part1, part2 = connection[1], connection[2]
                    if part1 and part2 and self.drawings.Lines[i] then
                        local pos1, onScreen1 = cam:WorldToViewportPoint(part1.Position)
                        local pos2, onScreen2 = cam:WorldToViewportPoint(part2.Position)
                        if onScreen1 and onScreen2 then
                            self.drawings.Lines[i].From = Vector2.new(pos1.X, pos1.Y)
                            self.drawings.Lines[i].To = Vector2.new(pos2.X, pos2.Y)
                                self.drawings.Lines[i].Color = params.skeletoncolor
                            self.drawings.Lines[i].Visible = true
                            Connections = Connections + 1
                        else
                            self.drawings.Lines[i].Visible = false
                        end
                    elseif self.drawings.Lines[i] then
                        self.drawings.Lines[i].Visible = false
                    end
                end
                for i = # bodyParts + 1, 15 do
                    if self.drawings.Lines[i] then
                        self.drawings.Lines[i].Visible = false
                    end
                end
            elseif self.drawings then
                for i = 1, 15 do
                    if self.drawings.Lines[i] then
                        self.drawings.Lines[i].Visible = false
                    end
                end
            end
        end)
    end)
end

function skeleton:Remove()
    task.spawn(function()
        pcall(function()
            if self.drawings then
                for i = 1, 15 do
                    pcall(function()
                        if self.drawings.Lines[i] then
                            self.drawings.Lines[i]:Remove()
                        end
                    end)
                end
                self.drawings = nil
            end
        end)
    end)
end

-- Boxes
local boxes = setmetatable({}, {
    __index = espbase
})
boxes.__index = boxes

function boxes:new(player)
    local self = espbase.new(self, player)
    self.drawings = {
        Corners = {}  -- { TL = { H = {outline, line}, V = {...} }, ... }
    }
    return setmetatable(self, boxes)
end

function boxes:Create()
    task.spawn(function()
        pcall(function()
            for _, corner in ipairs({
                "TL",
                "TR",
                "BL",
                "BR"
            }) do
                local outlineH = createDrawing("Line", {
                    Visible = false,
                    Color = Color3.new(0, 0, 0),
                    Thickness = 3,
                    ZIndex = 1
                })
                local outlineV = createDrawing("Line", {
                    Visible = false,
                    Color = Color3.new(0, 0, 0),
                    Thickness = 3,
                    ZIndex = 1
                })
                local lineH = createDrawing("Line", {
                    Visible = false,
                    Color = params.boxcolor,
                    Thickness = 1,
                    ZIndex = 2
                })
                local lineV = createDrawing("Line", {
                    Visible = false,
                    Color = params.boxcolor,
                    Thickness = 1,
                    ZIndex = 2
                })
                self.drawings.Corners[corner] = {
                    H = {
                        outline = outlineH,
                        line = lineH
                    },
                    V = {
                        outline = outlineV,
                        line = lineV
                    }
                }
            end
        end)
    end)
end

function boxes:Update()
    task.spawn(function()
        pcall(function()
            local character = self.player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChild("Humanoid")
            if not (rootPart and humanoid and self.drawings) then
                for _, cornerTbl in pairs(self.drawings.Corners) do
                    cornerTbl.H.outline.Visible = false
                    cornerTbl.H.line.Visible = false
                    cornerTbl.V.outline.Visible = false
                    cornerTbl.V.line.Visible = false
                end
                return
            end

            local rootPos = rootPart.Position
            local screenPos, onScreen = cam:WorldToViewportPoint(rootPos)
            if not onScreen or screenPos.Z <= 0 then
                for _, cornerTbl in pairs(self.drawings.Corners) do
                    cornerTbl.H.outline.Visible = false
                    cornerTbl.H.line.Visible = false
                    cornerTbl.V.outline.Visible = false
                    cornerTbl.V.line.Visible = false
                end
                return
            end

            local Size = character:GetExtentsSize()

            local clampedW = math.min(Size.X, 4)
            local clampedH = math.min(Size.Y, 5)

            local scaleFact = 1000 / screenPos.Z
            local halfW = (clampedW * scaleFact) / 2
            local halfH = (clampedH * scaleFact) / 2
            local TL = Vector2.new(screenPos.X - halfW, screenPos.Y - halfH)
            local TR = Vector2.new(screenPos.X + halfW, screenPos.Y - halfH)
            local BL = Vector2.new(screenPos.X - halfW, screenPos.Y + halfH)
            local BR = Vector2.new(screenPos.X + halfW, screenPos.Y + halfH)

            local cornerLenX = halfW * 0.3
            local cornerLenY = halfH * 0.3

            local function showLine(draw, from, to)
                draw.outline.From = from
                draw.outline.To = to
                draw.outline.Visible = true
                draw.line.From = from
                draw.line.To = to
                draw.line.Color = params.boxcolor
                draw.line.Visible = true
            end

            showLine(self.drawings.Corners["TL"].H, TL, TL + Vector2.new(cornerLenX, 0))
            showLine(self.drawings.Corners["TL"].V, TL, TL + Vector2.new(0, cornerLenY))

            showLine(self.drawings.Corners["TR"].H, TR, TR + Vector2.new(- cornerLenX, 0))
            showLine(self.drawings.Corners["TR"].V, TR, TR + Vector2.new(0, cornerLenY))

            showLine(self.drawings.Corners["BL"].H, BL, BL + Vector2.new(cornerLenX, 0))
            showLine(self.drawings.Corners["BL"].V, BL, BL + Vector2.new(0, - cornerLenY))

            showLine(self.drawings.Corners["BR"].H, BR, BR + Vector2.new(- cornerLenX, 0))
            showLine(self.drawings.Corners["BR"].V, BR, BR + Vector2.new(0, - cornerLenY))
        end)
    end)
end

function boxes:Remove()
    task.spawn(function()
        pcall(function()
            for _, cornerTbl in pairs(self.drawings.Corners) do
                pcall(function()
                    cornerTbl.H.outline:Remove()
                end)
                pcall(function()
                    cornerTbl.H.line:Remove()
                end)
                pcall(function()
                    cornerTbl.V.outline:Remove()
                end)
                pcall(function()
                    cornerTbl.V.line:Remove()
                end)
            end
            self.drawings = nil
        end)
    end)
end


-- 3D Boxes
-- govno
local boxes3d = setmetatable({}, {
    __index = espbase
})
boxes3d.__index = boxes3d

function boxes3d:new(player)
    local self = espbase.new(self, player)
    self.drawings = {
        Lines = {}
    }
    return setmetatable(self, boxes3d)
end

function boxes3d:Create()
    task.spawn(function()
        pcall(function()
            for i = 1, 12 do
                self.drawings.Lines[i] = createDrawing("Line", {
                    Visible = false,
                    Color = params.box3dcolor,
                    Thickness = 1.5,
                    ZIndex = 2
                })
            end
        end)
    end)
end

function boxes3d:Update()
    task.spawn(function()
        pcall(function()
            local character = self.player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            if rootPart and self.drawings and self.drawings.Lines[1] then
                local rootPos = rootPart.Position
                local screenPos, onScreen = cam:WorldToViewportPoint(rootPos)
                
                if onScreen and screenPos.Z > 0 then
                    local boxSize = Vector3.new(4, 6, 4)
                    
                    local corners = {}
                    local halfSize = boxSize / 2
                    
                    corners[1] = rootPos + Vector3.new(- halfSize.X, - halfSize.Y, - halfSize.Z)
                    corners[2] = rootPos + Vector3.new(halfSize.X, - halfSize.Y, - halfSize.Z) 
                    corners[3] = rootPos + Vector3.new(halfSize.X, - halfSize.Y, halfSize.Z)  
                    corners[4] = rootPos + Vector3.new(- halfSize.X, - halfSize.Y, halfSize.Z) 
                    
                    corners[5] = rootPos + Vector3.new(- halfSize.X, halfSize.Y, - halfSize.Z) 
                    corners[6] = rootPos + Vector3.new(halfSize.X, halfSize.Y, - halfSize.Z)  
                    corners[7] = rootPos + Vector3.new(halfSize.X, halfSize.Y, halfSize.Z)   
                    corners[8] = rootPos + Vector3.new(- halfSize.X, halfSize.Y, halfSize.Z)  
                    
                    local screenCorners = {}
                    local allVisible = true
                    
                    for i = 1, 8 do
                        local screenCorner, visible = cam:WorldToViewportPoint(corners[i])
                        screenCorners[i] = Vector2.new(screenCorner.X, screenCorner.Y)
                        if not visible then
                            allVisible = false
                        end
                    end
                    
                    if allVisible then
                        local edges = {
                            {1, 2}, {2, 3}, {3, 4}, {4, 1}, -- bottom egdes
                            {5, 6}, {6, 7}, {7, 8}, {8, 5}, -- top edges
                            {1, 5}, {2, 6}, {3, 7}, {4, 8} -- vertica edges
                        }
                        
                        for i = 1, 12 do
                            local edge = edges[i]
                            local line = self.drawings.Lines[i]
                            
                            line.From = screenCorners[edge[1]]
                            line.To = screenCorners[edge[2]]
                            line.Color = params.box3dcolor or Color3.fromRGB(255, 255, 255)
                            line.Visible = true
                        end
                    else
                        for i = 1, 12 do
                            self.drawings.Lines[i].Visible = false
                        end
                    end
                else
                    for i = 1, 12 do
                        self.drawings.Lines[i].Visible = false
                    end
                end
            elseif self.drawings then
                for i = 1, 12 do
                    if self.drawings.Lines[i] then
                        self.drawings.Lines[i].Visible = false
                    end
                end
            end
        end)
    end)
end

function boxes3d:Remove()
    task.spawn(function()
        pcall(function()
            if self.drawings then
                for i = 1, 12 do
                    pcall(function()
                        if self.drawings.Lines[i] then
                            self.drawings.Lines[i]:Remove()
                        end
                    end)
                end
                self.drawings = nil
            end
        end)
    end)
end

-- Healthbar
local healthbar = setmetatable({}, {
    __index = espbase
})
healthbar.__index = healthbar

function healthbar:new(player)
    local self = espbase.new(self, player)
    self.drawings = {
        Background = nil,
        HealthBar = nil,
        Outline = nil
    }
    return setmetatable(self, healthbar)
end

function healthbar:Create() -- outline, background, healthbar
    task.spawn(function()
        pcall(function()
            self.drawings.Outline = createDrawing("Line", {
                Visible = false,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
                ZIndex = 1
            })
            
            self.drawings.Background = createDrawing("Line", {
                Visible = false,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 1,
                ZIndex = 2
            })
            
            self.drawings.HealthBar = createDrawing("Line", {
                Visible = false,
                Color = Color3.fromRGB(50, 170, 80),
                Thickness = 1,
                ZIndex = 3
            })
        end)
    end)
end

function healthbar:Update()
    task.spawn(function()
        pcall(function()
            local character = self.player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChild("Humanoid")
            
            if rootPart and humanoid and self.drawings and self.drawings.Outline then
                local rootPos = rootPart.Position
                local screenPos, onScreen = cam:WorldToViewportPoint(rootPos)
                
                if onScreen and screenPos.Z > 0 then
                    local character_size = character:GetExtentsSize()
                    local scaleFactor = 1000 / screenPos.Z

                    local worldHeight = math.min(character_size.Y, 5)
                    
                    local boxHeight = (worldHeight * scaleFactor) / 2

                    local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)

                        local minColor = params.healthbarmincolor
                        local maxColor = params.healthbarmaxcolor

                    local red = math.floor(minColor.R * 255 * (1 - healthPercent) + maxColor.R * 255 * healthPercent)
                    local green = math.floor(minColor.G * 255 * (1 - healthPercent) + maxColor.G * 255 * healthPercent)
                    local blue = math.floor(minColor.B * 255 * (1 - healthPercent) + maxColor.B * 255 * healthPercent)
                    
                    local healthColor = Color3.fromRGB(red, green, blue)
                    
                    local healthbarWidth = 3.5
                    local fullHealthbarHeight = boxHeight * 2
                    local currentHealthHeight = fullHealthbarHeight * healthPercent
                    
                    local healthbarX = screenPos.X - (character_size.X * scaleFactor) / 2 - healthbarWidth - 8
                    local healthbarTopY = screenPos.Y - boxHeight
                    local healthbarBottomY = screenPos.Y + boxHeight
                    local currentHealthTopY = healthbarBottomY - currentHealthHeight

                    self.drawings.Outline.From = Vector2.new(healthbarX - 1, healthbarTopY - 1)
                    self.drawings.Outline.To = Vector2.new(healthbarX - 1, healthbarBottomY + 1)
                    self.drawings.Outline.Visible = true

                    self.drawings.Background.From = Vector2.new(healthbarX, healthbarTopY)
                    self.drawings.Background.To = Vector2.new(healthbarX, healthbarBottomY)
                    self.drawings.Background.Thickness = healthbarWidth
                    self.drawings.Background.Visible = true
                    
                    if healthPercent > 0 then
                        self.drawings.HealthBar.From = Vector2.new(healthbarX, currentHealthTopY)
                        self.drawings.HealthBar.To = Vector2.new(healthbarX, healthbarBottomY)
                        self.drawings.HealthBar.Thickness = healthbarWidth
                        self.drawings.HealthBar.Color = healthColor
                        self.drawings.HealthBar.Visible = true
                    else
                        self.drawings.HealthBar.Visible = false
                    end
                else
                    self.drawings.Outline.Visible = false
                    self.drawings.Background.Visible = false
                    self.drawings.HealthBar.Visible = false
                end
            elseif self.drawings then
                self.drawings.Outline.Visible = false
                self.drawings.Background.Visible = false
                self.drawings.HealthBar.Visible = false
            end
        end)
    end)
end

function healthbar:Remove()
    task.spawn(function()
        pcall(function()
            if self.drawings then
                pcall(function()
                    self.drawings.Outline:Remove()
                end)
                pcall(function()
                    self.drawings.Background:Remove()
                end)
                pcall(function()
                    self.drawings.HealthBar:Remove()
                end)
                self.drawings = nil
            end
        end)
    end)
end

-- Tracers
local tracers = setmetatable({}, {
    __index = espbase
})
tracers.__index = tracers

function tracers:new(player)
    local self = espbase.new(self, player)
    self.line = nil
    return setmetatable(self, tracers)
end

function tracers:Create()
    task.spawn(function()
        pcall(function()
                self.line = createDrawing("Line", {
                Visible = false,
                Color = params.tracercolor,
                Thickness = 1
            })
        end)
    end)
end

function tracers:Update()
    task.spawn(function()
        pcall(function()
            local character = self.player.Character
            local head = character and character:FindFirstChild("Head")
            if head and self.line then
                local screenPos, onScreen = cam:WorldToViewportPoint(head.Position)
                if onScreen then
                    local fromPos

                    if params.tracerpos == "Bottom" then
                        fromPos = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                    elseif params.tracerpos == "Center" then
                        fromPos = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                    elseif params.tracerpos == "Top" then
                        fromPos = Vector2.new(cam.ViewportSize.X / 2, 0)
                    elseif params.tracerpos == "Cursor" then
                        fromPos = Vector2.new(mouse.X, mouse.Y)
                    else
                        fromPos = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                    end
                    
                    self.line.From = fromPos
                    self.line.To = Vector2.new(screenPos.X, screenPos.Y)
                    self.line.Color = params.tracercolor
                    self.line.Visible = true
                else
                    self.line.Visible = false
                end
            elseif self.line then
                self.line.Visible = false
            end
        end)
    end)
end

function tracers:Remove()
    task.spawn(function()
        pcall(function()
            if self.line then
                pcall(function()
                    self.line:Remove()
                end)
                self.line = nil
            end
        end)
    end)
end

-- Chams
local chams = setmetatable({}, { __index = espbase })
chams.__index = chams

function chams:new(player)
    local self = espbase.new(self, player)
    self.highlight = nil
    self.charConn = nil
    return setmetatable(self, chams)
end

function chams:Create()
    local function setupHighlight(character)
        if self.highlight then
            self.highlight:Destroy()
            self.highlight = nil
        end
        if character then
            self.highlight = Instance.new("Highlight")
            self.highlight.Name = "Chams_" .. self.player.Name
            self.highlight.Adornee = character
            self.highlight.FillColor = params.chamscolor
            self.highlight.OutlineColor = Color3.new(0,0,0)
            self.highlight.FillTransparency = 0.5
            self.highlight.OutlineTransparency = 0
            self.highlight.Parent = cgui
        end
    end

    task.spawn(function()
        pcall(function()
            if self.charConn then self.charConn:Disconnect() end
            if self.player.Character then
                setupHighlight(self.player.Character)
            end
            self.charConn = self.player.CharacterAdded:Connect(function(char)
                setupHighlight(char)
            end)
        end)
    end)
end

function chams:Update()
    task.spawn(function()
        pcall(function()
            if self.highlight then
                self.highlight.FillColor = params.chamscolor
                self.highlight.Enabled = true
            end
        end)
    end)
end

function chams:Remove()
    task.spawn(function()
        pcall(function()
            if self.charConn then
                self.charConn:Disconnect()
                self.charConn = nil
            end
            if self.highlight then
                self.highlight:Destroy()
                self.highlight = nil
            end
        end)
    end)
end

-- ESP Service
local espservice = {}
espservice.__index = espservice

function espservice:new()
    local self = setmetatable({}, espservice)
    self.playersESP = {}
    
    for _, player in pairs(plrs:GetPlayers()) do
        if player ~= plr then
            self:Add(player)
        end
    end
    
    self:ConnectEvents()
    
    return self
end

function espservice:ConnectEvents()
    rs.RenderStepped:Connect(function()
        self:UpdateAll()
    end)
    
    plrs.PlayerAdded:Connect(function(player)
        if player ~= plr then
            self:Add(player)
        end
    end)

    plrs.PlayerRemoving:Connect(function(player)
        self:Remove(player)
    end)
end

function espservice:Add(player)
    self.playersESP[player] = {
    Box = params.boxes and boxes:new(player) or nil,
    Box3D = params.box3d and boxes3d:new(player) or nil,
    Tracer = params.tracers and tracers:new(player) or nil,
    Chams = params.chams and chams:new(player) or nil,
    Healthbar = params.healthbar and healthbar:new(player) or nil,
    Skeleton = params.skeleton and skeleton:new(player) or nil,
    Nametags = params.nameesp and nametags:new(player) or nil,
    Guntags = params.gunesp and guntags:new(player) or nil
    }
    
    if self.playersESP[player].Box then
        self.playersESP[player].Box:Create()
    end
    if self.playersESP[player].Box3D then
        self.playersESP[player].Box3D:Create()
    end
    if self.playersESP[player].Tracer then
        self.playersESP[player].Tracer:Create()
    end
    if self.playersESP[player].Chams then
        self.playersESP[player].Chams:Create()
    end
    if self.playersESP[player].Healthbar then
        self.playersESP[player].Healthbar:Create()
    end
    if self.playersESP[player].Skeleton then
        self.playersESP[player].Skeleton:Create()
    end
    if self.playersESP[player].Nametags then
        self.playersESP[player].Nametags:Create()
    end
    if self.playersESP[player].Guntags then
        self.playersESP[player].Guntags:Create()
    end
end

function espservice:Remove(player)
    local esp = self.playersESP[player]
    if esp then
        if esp.Box then
                esp.Box:Remove()
            end
            if esp.Box3D then
                esp.Box3D:Remove()
            end
            if esp.Tracer then
                esp.Tracer:Remove()
            end
            if esp.Chams then
                esp.Chams:Remove()
            end
            if esp.Healthbar then
                esp.Healthbar:Remove()
            end
            if esp.Skeleton then
                esp.Skeleton:Remove()
            end
            if esp.Nametags then
                esp.Nametags:Remove()
            end
            if esp.Guntags then
                esp.Guntags:Remove()
            end
        self.playersESP[player] = nil
    end
end

function espservice:UpdateAll()
    for player, esp in pairs(self.playersESP) do
        if player ~= plr then
            if esp.Box then
                esp.Box:Update()
            end
            if esp.Box3D then
                esp.Box3D:Update()
            end
            if esp.Tracer then
                esp.Tracer:Update()
            end
            if esp.Chams then
                esp.Chams:Update()
            end
            if esp.Healthbar then
                esp.Healthbar:Update()
            end
            if esp.Skeleton then
                esp.Skeleton:Update()
            end
            if esp.Nametags then
                esp.Nametags:Update()
            end
            if esp.Guntags then
                esp.Guntags:Update()
            end
        end
    end
end

local espservice = espservice:new()

for _, player in pairs(plrs:GetPlayers()) do
    if player ~= plr then
        espservice:Add(player)
    end
end

print("ESPModule: Running version 1.0pts")

return {
    params = params,
    espservice = espservice,
    nametags = nametags,
    guntags = guntags,
    skeleton = skeleton,
    boxes = boxes,
    boxes3d = boxes3d,
    healthbar = healthbar,
    tracers = tracers,
    chams = chams
}
