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
})]]
