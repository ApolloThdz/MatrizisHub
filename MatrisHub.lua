local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "MatrisHub", HidePremium = false, SaveConfig = true, ConfigFolder = "MatrisHub"})

local Tab = Window:MakeTab({
    Name = "Auto parry",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Parry"
})

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

local BallFolder = Workspace.Balls
local IndicatorPart = Instance.new("Part")
IndicatorPart.Size = Vector3.new(5, 5, 5)
IndicatorPart.Anchored = true
IndicatorPart.CanCollide = false
IndicatorPart.Transparency = 1
IndicatorPart.BrickColor = BrickColor.new("Bright red")
IndicatorPart.Parent = Workspace

local LastBallPressed = nil
local IsKeyPressed = false

local function CalculatePredictionTime(ball, player)
    local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return math.huge end
    
    local relativePosition = ball.Position - humanoidRootPart.Position
    local velocity = ball.Velocity + humanoidRootPart.Velocity 
    local a = ball.Size.magnitude * 0.5
    local b = relativePosition.magnitude
    local c = (a * a + b * b) ^ 0.5
    local timeToCollision = (c - a) / velocity.magnitude
    return timeToCollision
end

local function UpdateIndicatorPosition(ball)
    IndicatorPart.Position = ball.Position
end

local function CheckProximityToPlayer(ball, player)
    local predictionTime = CalculatePredictionTime(ball, player)
    local realBallAttribute = ball:GetAttribute("realBall")
    local target = ball:GetAttribute("target")
    local ballSpeedThreshold = math.max(0.4, 0.6 - ball.Velocity.magnitude * 0.01)

    if predictionTime <= ballSpeedThreshold and realBallAttribute == true and target == player.Name and not IsKeyPressed then
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
        wait(0.005)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
        LastBallPressed = ball
        IsKeyPressed = true
    elseif LastBallPressed == ball and (predictionTime > ballSpeedThreshold or realBallAttribute ~= true or target ~= player.Name) then
        IsKeyPressed = false
    end
end

local function CheckBallsProximity()
    local player = Players.LocalPlayer
    if player then
        for _, ball in pairs(BallFolder:GetChildren()) do
            CheckProximityToPlayer(ball, player)
            UpdateIndicatorPosition(ball)
        end
    end
end

local function AutoParryToggle(value)
    if value then
        RunService.Heartbeat:Connect(CheckBallsProximity)
    else
        RunService.Heartbeat:Disconnect()
    end
end


Tab:AddToggle({
    Name = "Auto Parry",
    Default = false,
    Callback = OnToggle
})

-- Main Script End


