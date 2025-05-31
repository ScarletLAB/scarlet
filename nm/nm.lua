local n = {}
n.__index = n

local c = {
    bg = Color3.fromRGB(33, 38, 45),
    border = Color3.fromRGB(88, 166, 255),
    title = Color3.fromRGB(230, 237, 243),
    desc = Color3.fromRGB(180, 200, 220),
    shadow = Color3.fromRGB(20, 20, 20)
}

function n:Notify(t, ti, d)
    local sg = game:GetService("CoreGui"):FindFirstChild("NotifyModuleGui")
    if not sg then
        sg = Instance.new("ScreenGui")
        sg.Name = "NotifyModuleGui"
        sg.Parent = game:GetService("CoreGui")
    end
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 340, 0, 90)
    f.Position = UDim2.new(1, -360, 1, 120)
    f.BackgroundColor3 = c.bg
    f.BorderColor3 = c.border
    f.BorderSizePixel = 2
    f.BackgroundTransparency = 1
    f.ClipsDescendants = true
    f.Parent = sg
    local sh = Instance.new("ImageLabel")
    sh.AnchorPoint = Vector2.new(0.5, 0.5)
    sh.BackgroundTransparency = 1
    sh.ZIndex = 0
    sh.Image = "rbxassetid://5587865193"
    sh.ImageColor3 = c.shadow
    sh.Size = UDim2.new(1.4, 0, 1.2, 0)
    sh.Position = UDim2.new(0.5, 0, 0.5, 0)
    sh.ImageTransparency = 1
    sh.Parent = f
    local cr = Instance.new("UICorner")
    cr.CornerRadius = UDim.new(0, 12)
    cr.Parent = f
    local tiL = Instance.new("TextLabel")
    tiL.Text = ti
    tiL.Font = Enum.Font.GothamBold
    tiL.TextSize = 20
    tiL.TextColor3 = c.title
    tiL.BackgroundTransparency = 1
    tiL.Size = UDim2.new(1, -24, 0, 32)
    tiL.Position = UDim2.new(0, 16, 0, 10)
    tiL.TextXAlignment = Enum.TextXAlignment.Left
    tiL.Parent = f
    local deL = Instance.new("TextLabel")
    deL.Text = d
    deL.Font = Enum.Font.Code
    deL.TextSize = 15
    deL.TextColor3 = c.desc
    deL.BackgroundTransparency = 1
    deL.Size = UDim2.new(1, -24, 0, 40)
    deL.Position = UDim2.new(0, 16, 0, 40)
    deL.TextXAlignment = Enum.TextXAlignment.Left
    deL.TextYAlignment = Enum.TextYAlignment.Top
    deL.TextWrapped = true
    deL.Parent = f
    f.Visible = true
    f.BackgroundTransparency = 1
    f.Position = UDim2.new(1, -360, 1, 120)
    sh.ImageTransparency = 1
    local ts = game:GetService("TweenService")
    ts:Create(f, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    }):Play()
    ts:Create(sh, TweenInfo.new(0.22), {ImageTransparency = 0.5}):Play()
    wait(0.22)
    ts:Create(f, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -360, 1, -110)
    }):Play()
    wait(0.22)
    delay(t, function()
        ts:Create(f, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, -360, 1, 120)
        }):Play()
        ts:Create(f, TweenInfo.new(0.22), {BackgroundTransparency = 1}):Play()
        ts:Create(sh, TweenInfo.new(0.22), {ImageTransparency = 1}):Play()
        wait(0.22)
        f:Destroy()
    end)
end

return setmetatable({}, n)
