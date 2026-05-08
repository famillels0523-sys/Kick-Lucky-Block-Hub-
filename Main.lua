-- [[ ADMIN PANEL SUPREMACY - V3 ULTIMATE ]]
-- Architecte : famillels0523-sys
-- Niveau : Expert / Senior

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "SUPREMACY ADMIN HUB",
    SubTitle = "by famillels0523-sys",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

-- // SERVICES
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local LP = Players.LocalPlayer

-- // INITIALISATION DES EFFETS
local CC = Lighting:FindFirstChild("EliteCC") or Instance.new("ColorCorrectionEffect", Lighting)
CC.Name = "EliteCC"

-- // TABS
local Tabs = {
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Visuals = Window:AddTab({ Title = "Visuals/ESP", Icon = "eye" }),
    Graphics = Window:AddTab({ Title = "Graphics", Icon = "image" }),
    Server = Window:AddTab({ Title = "Server", Icon = "server" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- // --- ONGLET PLAYER ---
Tabs.Player:AddSlider("WS", {Title = "Vitesse", Default = 16, Min = 16, Max = 500, Rounding = 1})
Options.WS:OnChanged(function(V) if LP.Character then LP.Character.Humanoid.WalkSpeed = V end end)

Tabs.Player:AddSlider("JP", {Title = "Saut", Default = 50, Min = 50, Max = 1000, Rounding = 1})
Options.JP:OnChanged(function(V) if LP.Character then LP.Character.Humanoid.UseJumpPower = true LP.Character.Humanoid.JumpPower = V end end)

Tabs.Player:AddToggle("InfJ", {Title = "Saut Infini", Default = false})
game:GetService("UserInputService").JumpRequest:Connect(function()
    if Options.InfJ and Options.InfJ.Value then LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end
end)

Tabs.Player:AddToggle("Noclip", {Title = "Noclip (Passer les murs)", Default = false})
RunService.Stepped:Connect(function()
    if Options.Noclip and Options.Noclip.Value and LP.Character then
        for _, v in pairs(LP.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- // --- ONGLET VISUALS (ESP) ---
Tabs.Visuals:AddToggle("EspBox", {Title = "Player Boxes", Default = false})
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local box = p.Character:FindFirstChild("ESP_BOX") or Instance.new("BoxHandleAdornment", p.Character)
            box.Name = "ESP_BOX"
            box.Adornee = p.Character
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Size = Vector3.new(4, 6, 1)
            box.Transparency = Options.EspBox.Value and 0.7 or 1
            box.Color3 = Color3.new(1, 0, 0)
        end
    end
end)

-- // --- ONGLET GRAPHICS ---
Tabs.Graphics:AddSlider("Bri", {Title = "Luminosité (Expo)", Default = 0, Min = -1, Max = 3, Rounding = 0.1})
Options.Bri:OnChanged(function(V) CC.Brightness = V end)

Tabs.Graphics:AddSlider("Sat", {Title = "Saturation (Couleurs)", Default = 0, Min = -1, Max = 4, Rounding = 0.1})
Options.Sat:OnChanged(function(V) CC.Saturation = V end)

Tabs.Graphics:AddSlider("Con", {Title = "Contraste", Default = 0, Min = -1, Max = 4, Rounding = 0.1})
Options.Con:OnChanged(function(V) CC.Contrast = V end)

Tabs.Graphics:AddSlider("FOV", {Title = "Field of View", Default = 70, Min = 30, Max = 120, Rounding = 1})
Options.FOV:OnChanged(function(V) workspace.CurrentCamera.FieldOfView = V end)

Tabs.Graphics:AddButton({
    Title = "RTX Mode / FullBright",
    Callback = function()
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    end
})

-- // --- ONGLET SERVER ---
Tabs.Server:AddButton({
    Title = "Rejoin Server",
    Callback = function() TeleportService:Teleport(game.PlaceId, LP) end
})

Tabs.Server:AddButton({
    Title = "Server Hop (Changer de serveur)",
    Callback = function()
        local Servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in pairs(Servers.data) do
            if s.playing < s.maxPlayers then TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id) break end
        end
    end
})

-- // FINITION
Window:SelectTab(1)
Fluent:Notify({Title = "SUPREMACY LOADED", Content = "Panel Elite activé, famillels0523-sys.", Duration = 5})

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
