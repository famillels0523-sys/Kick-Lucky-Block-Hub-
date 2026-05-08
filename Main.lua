-- [[ ADMIN PANEL SUPREMACY ]]
-- Architecte : famillels0523-sys
-- Focus : Player Control, Advanced Graphics & World Admin

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "ADMIN PANEL",
    SubTitle = "by famillels0523-sys",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

-- // SERVICES
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- // TABS
local Tabs = {
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Visuals = Window:AddTab({ Title = "Graphics", Icon = "image" }),
    World = Window:AddTab({ Title = "World", Icon = "globe" })
}

local Options = Fluent.Options

-- // 1. ONGLET PLAYER (Mouvements & Physique)
Tabs.Player:AddSlider("WalkSpeed", {Title = "Vitesse de marche", Default = 16, Min = 16, Max = 500, Rounding = 1})
Options.WalkSpeed:OnChanged(function(Value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
end)

Tabs.Player:AddSlider("JumpPower", {Title = "Puissance de saut", Default = 50, Min = 50, Max = 1000, Rounding = 1})
Options.JumpPower:OnChanged(function(Value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = Value
    end
end)

Tabs.Player:AddToggle("InfJump", {Title = "Saut Infini", Default = false})
UserInputService.JumpRequest:Connect(function()
    if Options.InfJump and Options.InfJump.Value then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

Tabs.Player:AddButton({
    Title = "Reset Character",
    Callback = function()
        LocalPlayer.Character:BreakJoints()
    end
})

-- // 2. ONGLET GRAPHICS (Post-Process & Effets)
local ColorCorrection = Lighting:FindFirstChild("AdminHubCC") or Instance.new("ColorCorrectionEffect")
ColorCorrection.Name = "AdminHubCC"
ColorCorrection.Parent = Lighting

Tabs.Visuals:AddSlider("Brightness", {Title = "Exposition (Brightness)", Default = 0, Min = -1, Max = 2, Rounding = 0.1})
Options.Brightness:OnChanged(function(Value) ColorCorrection.Brightness = Value end)

Tabs.Visuals:AddSlider("Contrast", {Title = "Contraste", Default = 0, Min = -1, Max = 4, Rounding = 0.1})
Options.Contrast:OnChanged(function(Value) ColorCorrection.Contrast = Value end)

Tabs.Visuals:AddSlider("Saturation", {Title = "Saturation (Couleurs)", Default = 0, Min = -1, Max = 4, Rounding = 0.1})
Options.Saturation:OnChanged(function(Value) ColorCorrection.Saturation = Value end)

Tabs.Visuals:AddSlider("FieldOfView", {Title = "FOV (Champ de vision)", Default = 70, Min = 30, Max = 120, Rounding = 1})
Options.FieldOfView:OnChanged(function(Value) workspace.CurrentCamera.FieldOfView = Value end)

Tabs.Visuals:AddButton({
    Title = "Full Bright (No Shadows)",
    Callback = function()
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    end
})

-- // 3. ONGLET WORLD (Environnement)
Tabs.World:AddSlider("TimeOfDay", {Title = "Heure du jour", Default = 12, Min = 0, Max = 24, Rounding = 0.1})
Options.TimeOfDay:OnChanged(function(Value) Lighting.ClockTime = Value end)

Tabs.World:AddToggle("AntiLag", {Title = "Mode Performance (FPS+)", Default = false})
Options.AntiLag:OnChanged(function(Value)
    if Value then
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end)

Tabs.World:AddButton({
    Title = "Delete Map Textures",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                v:Destroy()
            end
        end
    end
})

-- Finition
Window:SelectTab(1)
Fluent:Notify({
    Title = "ADMIN READY",
    Content = "Panneau de contrôle activé.",
    Duration = 5
})
