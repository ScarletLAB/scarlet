local plr = game:GetService("Players").LocalPlayer
local character = plr.Character

configuration = {
    farm = {
        drones = {
            farmdrones = false,
            distp = false,
            dplat = nil,
        },
        crates = {
            farmcrates = false,
            cistp = false,
            cplat = nil,
            farmspeed = "Faster"
        },
        autobuy = {
            autobuy = false,
            delay = 0.40,
            aplat = nil
        }
    }
}

-- Drone Farm
local function dronefarm()
    task.spawn(function()
        pcall(function()
            while configuration.farm.drones.farmdrones do
                local drone = workspace.ResearchCaches:FindFirstChild("Downed Reaper")
                if drone and drone:IsA("Model") then
                    local targetCFrame = drone:GetModelCFrame()
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        if not configuration.farm.drones.distp then
                            if not configuration.farm.drones.dplat then
                                configuration.farm.drones.dplat = Instance.new("Part")
                                configuration.farm.drones.dplat.Size = Vector3.new(10, 1, 10)
                                configuration.farm.drones.dplat.Anchored = true
                                configuration.farm.drones.dplat.Transparency = 1
                                configuration.farm.drones.dplat.CanCollide = true
                                configuration.farm.drones.dplat.Name = "Platform"
                                configuration.farm.drones.dplat.Parent = workspace
                            end
                            configuration.farm.drones.dplat.Position = targetCFrame.Position - Vector3.new(0, 3, 0)
                            character.HumanoidRootPart.CFrame = targetCFrame
                            configuration.farm.drones.distp = true

                            local interact = drone:FindFirstChild("Interact", true)
                            if interact and interact:IsA("ProximityPrompt") then
                                task.wait(0.1)
                                if not configuration.farm.drones.farmdrones then
                                    break
                                end

                                task.wait(2)
                                if not configuration.farm.drones.farmdrones then
                                    break
                                end

                                interact.HoldDuration = 0
                                fireproximityprompt(interact)

                                if not configuration.farm.drones.farmdrones then
                                    break
                                end

                                local team = plr.Team
                                if team and team.Name then
                                    local success, collector = pcall(function()
                                        return workspace.Tycoon.Tycoons[team.Name].PurchasedObjects["Lab Terminal Screen"]["Research Screen"].Collector
                                    end)
                                    if success and collector and collector:IsA("BasePart") then
                                        task.wait(0.5)
                                        if not configuration.farm.drones.farmdrones then
                                            break
                                        end
                                        character.HumanoidRootPart.CFrame = collector.CFrame
                                        task.wait(9.5)
                                    end
                                end
                                configuration.farm.drones.distp = false
                            end
                        end
                    end
                end
                task.wait(1) 
                if not configuration.farm.drones.farmdrones then
                    break
                end
            end
        end)
    end)
end

-- Crate Farm
local function cratefarm()
    task.spawn(function()
        pcall(function()
            while configuration.farm.crates.farmcrates do
                pcall(function()
                    for _, a in pairs(workspace.Tycoon.Tycoons:GetChildren()) do
                        if not configuration.farm.crates.farmcrates then
                            break
                        end
                        if a.Owner.Value == plr then
                            local crates = workspace["Game Systems"]["Crate Workspace"]:GetChildren()
                            if # crates > 0 then
                                for _, v in pairs(crates) do
                                    if not configuration.farm.crates.farmcrates then
                                        break
                                    end
                                    local crateOwner = v:GetAttribute("Owner")
                                    if not crateOwner or crateOwner ~= plr.Name then
                                        if not configuration.farm.crates.cplat then
                                            configuration.farm.crates.cplat = Instance.new("Part")
                                            configuration.farm.crates.cplat.Size = Vector3.new(10, 1, 10)
                                            configuration.farm.crates.cplat.Anchored = true
                                            configuration.farm.crates.cplat.Transparency = 1
                                            configuration.farm.crates.cplat.CanCollide = true
                                            configuration.farm.crates.cplat.Name = "SafePlatform"
                                            configuration.farm.crates.cplat.Parent = workspace
                                        end
                                        configuration.farm.crates.cplat.Position = v.CFrame.Position - Vector3.new(0, 3, 0)
                                        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                            plr.Character.HumanoidRootPart.CFrame = v.CFrame
                                        end
                                        task.wait((configuration.farm.crates.farmspeed == "Slower") and 1 or 0.35)
                                        if not configuration.farm.crates.farmcrates then
                                            break
                                        end
                                        fireproximityprompt(v.StealPrompt)
                                        task.wait((configuration.farm.crates.farmspeed == "Slower") and 1 or 0.6)
                                        if not configuration.farm.crates.farmcrates then
                                            break
                                        end
                                        if a and a:FindFirstChild("Essentials") and a.Essentials:FindFirstChild("Oil Collector") then
                                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                                plr.Character.HumanoidRootPart.CFrame = a.Essentials["Oil Collector"].CratePromptPart.CFrame
                                            end
                                            task.wait((configuration.farm.crates.farmspeed == "Slower") and 1 or 0.35)
                                            if not configuration.farm.crates.farmcrates then
                                                break
                                            end
                                            fireproximityprompt(a.Essentials["Oil Collector"].CratePromptPart.SellPrompt)
                                            task.wait((configuration.farm.crates.farmspeed == "Slower") and 2 or 1)
                                        end
                                    end
                                end
                            else
                                local coords = {
                                    Vector3.new(- 703, 112, - 4855),
                                    Vector3.new(255, 112, - 4821),
                                    Vector3.new(1258, 139, - 4402),
                                    Vector3.new(2326, 76, - 3448),
                                    Vector3.new(2753, 91, - 2295),
                                    Vector3.new(3149, 76, 15),
                                    Vector3.new(2960, 83, 1176),
                                    Vector3.new(2707, 84, 2248),
                                    Vector3.new(348, 83, 3688),
                                    Vector3.new(- 898, 87, 3792),
                                    Vector3.new(- 2743, 66, 2052),
                                    Vector3.new(- 3092, 65, 932),
                                    Vector3.new(- 3506, 112, 58),
                                    Vector3.new(- 3791, 124, - 824)
                                }
                                for _, pos in ipairs(coords) do
                                    if not configuration.farm.crates.farmcrates then
                                        break
                                    end
                                    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                        plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
                                    end
                                    task.wait((configuration.farm.crates.farmspeed == "Slower") and 1 or 0.35)
                                    if not configuration.farm.crates.farmcrates then
                                        break
                                    end
                                    local newCrates = workspace["Game Systems"]["Crate Workspace"]:GetChildren()
                                    if # newCrates > 0 then
                                        break
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(1)
                if not configuration.farm.crates.farmcrates then
                    break
                end
            end
        end)
    end)
end

-- Ultra buggy autobuy. Works well only on 1-2 rebirths
local function autobuy()
    task.spawn(function()
        pcall(function()
            while configuration.farm.autobuy.autobuy do
                local team = plr.Team
                if team and team.Name then
                    local tycoons = workspace:FindFirstChild("Tycoon") and workspace.Tycoon:FindFirstChild("Tycoons") and workspace.Tycoon.Tycoons
                    if tycoons then
                        local tycoon = tycoons:FindFirstChild(team.Name)
                        if not tycoon then
                            for _, t in ipairs(tycoons:GetChildren()) do
                                local owner = t:FindFirstChild("Owner")
                                if owner and owner.Value == plr then
                                    tycoon = t
                                    break
                                end
                            end
                        end
                        if tycoon then
                            local buttons = tycoon:FindFirstChild("UnpurchasedButtons")
                            if buttons then
                                for _, btn in ipairs(buttons:GetChildren()) do
                                    if not configuration.farm.autobuy.autobuy then
                                        break
                                    end
                                    local neon = btn:FindFirstChild("Neon", true)
                                    local color
                                    if neon then
                                        local ok, val = pcall(function()
                                            return neon:GetValue()
                                        end)
                                        if ok then
                                            color = val
                                        elseif neon:IsA("Color3Value") then
                                            color = neon.Value
                                        elseif neon:IsA("BrickColorValue") then
                                            color = neon.Value.Color
                                        elseif neon:IsA("BasePart") then
                                            color = neon.Color
                                        elseif neon:IsA("Highlight") then
                                            color = neon.FillColor
                                        end
                                    end
                                    local function buyable(c)
                                        if typeof(c) == "Color3" then
                                            local eps = 0.01
                                            return math.abs(c.R - 0) < eps and math.abs(c.G - 1) < eps and math.abs(c.B - 0) < eps
                                        end
                                        return false
                                    end
                                    local requiredRebirths = 0
                                    do
                                        local ra = btn:FindFirstChild("RebirthAmount", true)
                                        if ra then
                                            local okRA, valRA = pcall(function()
                                                return ra:GetValue()
                                            end)
                                            if okRA and type(valRA) == "number" then
                                                requiredRebirths = valRA
                                            elseif ra.Value ~= nil then
                                                local num = tonumber(ra.Value)
                                                if num then
                                                    requiredRebirths = num
                                                end
                                            end
                                        end
                                    end

                                    local currentRebirths = 0
                                    do
                                        local ls = plr:FindFirstChild("leaderstats")
                                        if ls then
                                            local rb = ls:FindFirstChild("Rebirths")
                                            if rb then
                                                local okRB, valRB = pcall(function()
                                                    return rb:GetValue()
                                                end)
                                                if okRB and type(valRB) == "number" then
                                                    currentRebirths = valRB
                                                elseif rb.Value ~= nil then
                                                    local num = tonumber(rb.Value)
                                                    if num then
                                                        currentRebirths = num
                                                    end
                                                end
                                            end
                                        end
                                    end

                                    if neon and color and buyable(color) and currentRebirths >= requiredRebirths then
                                        local targetCFrame
                                        if btn:IsA("BasePart") then
                                            targetCFrame = btn.CFrame
                                        elseif btn:IsA("Model") then
                                            local ok2, cf = pcall(function()
                                                return btn:GetModelCFrame()
                                            end)
                                            if ok2 and cf then
                                                targetCFrame = cf
                                            else
                                                local pp = btn.PrimaryPart
                                                if pp then
                                                    targetCFrame = pp.CFrame
                                                end
                                            end
                                        end
                                        if targetCFrame then
                                            if not configuration.farm.autobuy.aplat then
                                                configuration.farm.autobuy.aplat = Instance.new("Part")
                                                configuration.farm.autobuy.aplat.Size = Vector3.new(10, 1, 10)
                                                configuration.farm.autobuy.aplat.Anchored = true
                                                configuration.farm.autobuy.aplat.Transparency = 1
                                                configuration.farm.autobuy.aplat.CanCollide = true
                                                configuration.farm.autobuy.aplat.Name = "AutoBuyPlatform"
                                                configuration.farm.autobuy.aplat.Parent = workspace
                                            end
                                            configuration.farm.autobuy.aplat.Position = targetCFrame.Position - Vector3.new(0, 3, 0)
                                            local ch = plr.Character
                                            if ch and ch:FindFirstChild("HumanoidRootPart") then
                                                local pos = (typeof(targetCFrame) == "CFrame") and targetCFrame.Position or targetCFrame.p
                                                ch.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 7, 0))
                                            end
                                            task.wait(configuration.farm.autobuy.delay)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                task.wait(0.2)
            end
        end)
    end)
end

-- UI (RAYFIELD LIB)
--[[farm:CreateToggle({
    Name = "Farm Drones",
    CurrentValue = configuration.farm.drones.farmdrones,
    Flag = "FarmDrones",
    Callback = function(Value)
        configuration.farm.drones.farmdrones = Value
        if Value then
            configuration.farm.drones.distp = false
            dronefarm()
        else
            if configuration.farm.drones.dplat and configuration.farm.drones.dplat.Parent then
                configuration.farm.drones.dplat:Destroy()
                configuration.farm.drones.dplat = nil
            end
            configuration.farm.crates.distp = false
        end
    end
})

farm:CreateDivider()

farm:CreateToggle({
    Name = "Farm Crates",
    CurrentValue = configuration.farm.crates.farmcrates,
    Flag = "FarmCrates",
    Callback = function(Value)
        configuration.farm.crates.farmcrates = Value
        if Value then
            configuration.farm.crates.cistp = false
            cratefarm()
        else
            if configuration.farm.crates.cplat and configuration.farm.crates.cplat.Parent then
                configuration.farm.crates.cplat:Destroy()
                configuration.farm.crates.cplat = nil
            end
            configuration.farm.crates.cistp = false
        end
    end,
})

farm:CreateDivider()

farm:CreateToggle({
    Name = "Auto Buy | ALPHA",
    CurrentValue = configuration.farm.autobuy.autobuy,
    Flag = "AutoBuy",
    Callback = function(Value)
        configuration.farm.autobuy.autobuy = Value
        if Value then
            autobuy()
        else
            if configuration.farm.autobuy.aplat and configuration.farm.autobuy.aplat.Parent then
                configuration.farm.autobuy.aplat:Destroy()
                configuration.farm.autobuy.aplat = nil
            end
        end
    end,
})

farm:CreateSlider({
   Name = "TP Delay",
   Range = {0.10, 2},
   Increment = 0.10,
   Suffix = "Delay",
   CurrentValue = configuration.farm.autobuy.delay,
   Flag = "Slider1", 
   Callback = function(Value)
        configuration.farm.autobuy.delay = Value
   end,
})]]
