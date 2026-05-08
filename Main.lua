-- [[ KICK A LUCKY BLOCK - VERSION ULTIME ]]
-- Optimisé pour : Delta, Fluxus, Codex et PC
-- Auteur : famillels0523-sys

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "LUCKY BLOCK HUB",
    SubTitle = "par famillels0523-sys",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Auto-Farm", Icon = "rbxassetid://4483345998" }),
    Misc = Window:AddTab({ Title = "Divers", Icon = "settings" })
}

local Options = Fluent.Options

task.spawn(function()
    while task.wait(0.1) do
        if Options.AutoBrainrot and Options.AutoBrainrot.Value then
            local r = game:GetService("ReplicatedStorage"):FindFirstChild("Kick", true) or game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent", true)
            if r then r:FireServer("Perfect", 100) end
        end

        if Options.AutoStrength and Options.AutoStrength.Value then
            local r = game:GetService("ReplicatedStorage"):FindFirstChild("Train", true) or game:GetService("ReplicatedStorage"):FindFirstChild("AddStrength", true)
            if r then r:FireServer() end
            local tool = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end

        if Options.AutoCash and Options.AutoCash.Value then
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name:find("Cash") or v:FindFirstChild("TouchInterest") then
                        v.CFrame = hrp.CFrame
                    end
                end
            end
        end
    end
end)

Tabs.Main:AddToggle("AutoBrainrot", {Title = "Auto Brainrot (Perfect Kick)", Default = false})
Tabs.Main:AddToggle("AutoStrength", {Title = "Auto Farm Strength (Force x2)", Default = false})
Tabs.Main:AddToggle("AutoCash", {Title = "Auto Collect Cash", Default = false})

Fluent:Notify({Title = "HUB CHARGÉ", Content = "Script prêt par famillels0523-sys !", Duration = 5})

        if Options.AutoCash and Options.AutoCash.Value then
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name:find("Cash") or v:FindFirstChild("TouchInterest") then
                        v.CFrame = hrp.CFrame
                    end
                end
            end
        end
    end
end)

Tabs.Main:AddToggle("AutoBrainrot", {Title = "Auto Brainrot (Perfect Kick)", Default = false})
Tabs.Main:AddToggle("AutoStrength", {Title = "Auto Farm Strength (Force x2)", Default = false})
Tabs.Main:AddToggle("AutoCash", {Title = "Auto Collect Cash", Default = false})

Fluent:Notify({Title = "HUB CHARGÉ", Content = "Script prêt !", Duration = 5})
