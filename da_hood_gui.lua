-- RogueX GUI Core Script

-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/tweenjs/uilib/main/main.lua"))()
local Window = Library:CreateWindow("RogueX | Da Hood", Vector2.new(500, 400), Enum.KeyCode.RightControl)

-- Tabs
local CombatTab = Window:CreateTab("Combat")
local MovementTab = Window:CreateTab("Movement")
local UtilityTab = Window:CreateTab("Utility")
local TrollTab = Window:CreateTab("Troll")
local VisualTab = Window:CreateTab("Visuals")

-- Combat
CombatTab:CreateButton("Auto Punch", function()
    local tool = game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if tool then
        tool.Parent = game.Players.LocalPlayer.Character
        while wait(0.3) do
            if not tool then break end
            tool:Activate()
        end
    end
end)

CombatTab:CreateToggle("Reach", false, function(enabled)
    getgenv().reachEnabled = enabled
    while getgenv().reachEnabled do
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(15,15,15)
            end
        end
        wait(0.2)
    end
end)

CombatTab:CreateButton("Anti-Stomp", function()
    local lp = game.Players.LocalPlayer
    lp.Character:FindFirstChild("Humanoid").Health = 0.1
end)

-- Movement
MovementTab:CreateButton("Fly (Press E)", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/xg9xUJK0"))()
end)

MovementTab:CreateToggle("Noclip", false, function(state)
    local RunService = game:GetService("RunService")
    RunService.Stepped:Connect(function()
        if state then
            for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

MovementTab:CreateSlider("WalkSpeed", 16, 100, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

-- Utility
UtilityTab:CreateButton("God Mode", function()
    local plr = game.Players.LocalPlayer
    local char = plr.Character
    char:BreakJoints()
    wait(1)
    plr.Character = nil
    wait(1)
    plr.Character = char
    warn("God mode activated (client-sided)")
end)

UtilityTab:CreateButton("Teleport to Bank", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-451, 39, -285)
end)

UtilityTab:CreateButton("ESP", function()
    loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
end)

-- Troll
TrollTab:CreateButton("Fling Nearest Player", function()
    local lp = game.Players.LocalPlayer
    local char = lp.Character
    local hrp = char:WaitForChild("HumanoidRootPart")
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            hrp.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1)
            hrp.Velocity = Vector3.new(9999,9999,9999)
            break
        end
    end
end)

TrollTab:CreateButton("Fake Chat (Client Side)", function()
    local msg = "ROGUEX > YOU GOT STAND'D"
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = msg;
        Color = Color3.fromRGB(255, 0, 0);
        Font = Enum.Font.SourceSansBold;
        FontSize = Enum.FontSize.Size24;
    })
end)

-- Visuals
VisualTab:CreateButton("Time Stop FX", function()
    local blur = Instance.new("BlurEffect", game.Lighting)
    blur.Size = 24
    wait(5)
    blur:Destroy()
end)

VisualTab:CreateButton("Stand Aura", function()
    local part = Instance.new("Part", game.Players.LocalPlayer.Character)
    part.Anchored = false
    part.CanCollide = false
    part.Size = Vector3.new(3,6,3)
    part.Material = Enum.Material.Neon
    part.BrickColor = BrickColor.new("Royal purple")
    part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local weld = Instance.new("WeldConstraint", part)
    weld.Part0 = part
    weld.Part1 = game.Players.LocalPlayer.Character.HumanoidRootPart
end)
