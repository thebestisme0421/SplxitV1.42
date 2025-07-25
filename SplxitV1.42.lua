-- QGT GUI with Key System, Aimbot Panel, Animations, and Clean UI
-- Fully JJSploit-Compatible

-- Services
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Helper: Rounded corners
local function roundify(obj, radius)
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, radius)
    uicorner.Parent = obj
end

-- Helper: Tween function
local function tween(obj, props, time)
    local t = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    t:Play()
end

------------------------------------------------
-- Key System
------------------------------------------------
local keyGUI = Instance.new("ScreenGui", player.PlayerGui)
keyGUI.Name = "QGT_KeyGUI"
local keyFrame = Instance.new("Frame", keyGUI)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
roundify(keyFrame, 10)

local keyLabel = Instance.new("TextLabel", keyFrame)
keyLabel.Size = UDim2.new(1, 0, 0, 40)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "Enter Key to Unlock QGT"
keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
keyLabel.Font = Enum.Font.SourceSansBold
keyLabel.TextSize = 20

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Position = UDim2.new(0.1, 0, 0.4, 0)
keyBox.Size = UDim2.new(0.8, 0, 0, 30)
keyBox.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(0, 0, 0)
keyBox.Font = Enum.Font.SourceSans
keyBox.TextSize = 18
roundify(keyBox, 6)

local submitBtn = Instance.new("TextButton", keyFrame)
submitBtn.Position = UDim2.new(0.3, 0, 0.7, 0)
submitBtn.Size = UDim2.new(0.4, 0, 0, 30)
submitBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
submitBtn.Text = "Submit"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.SourceSans
submitBtn.TextSize = 18
roundify(submitBtn, 6)

------------------------------------------------
-- Main GUI (Initially hidden)
------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 550, 0, 320)
main.Position = UDim2.new(0.5, -275, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Visible = false
roundify(main, 12)

-- Header
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "QGT | Right Ctrl to Toggle"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
roundify(title, 10)

-- Sidebar
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.Size = UDim2.new(0, 100, 1, -35)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
roundify(sidebar, 10)

local function makeSideButton(name, icon, y)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.Text = icon .. "  " .. name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    roundify(btn, 6)
    return btn
end

local mainBtn = makeSideButton("Main", "⚡", 5)
local miscBtn = makeSideButton("Misc", "🔧", 45)
local aimbotBtn = makeSideButton("Aimbot", "🎯", 85)

-- Feed / Command Output
local feed = Instance.new("TextLabel", main)
feed.Position = UDim2.new(0, 110, 0, 40)
feed.Size = UDim2.new(1, -120, 0, 45)
feed.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
feed.Text = "Welcome to QGT"
feed.TextColor3 = Color3.fromRGB(255, 255, 255)
feed.Font = Enum.Font.SourceSans
feed.TextSize = 18
feed.TextXAlignment = Enum.TextXAlignment.Left
roundify(feed, 6)

-- Command Box
local cmdBox = Instance.new("TextBox", main)
cmdBox.Position = UDim2.new(0, 110, 0, 95)
cmdBox.Size = UDim2.new(1, -120, 0, 30)
cmdBox.Text = ""
cmdBox.TextColor3 = Color3.fromRGB(0, 0, 0)
cmdBox.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
cmdBox.Font = Enum.Font.SourceSans
cmdBox.TextSize = 18
roundify(cmdBox, 6)

-- Aimbot Panel
local aimbotPanel = Instance.new("Frame", main)
aimbotPanel.Position = UDim2.new(0, 110, 0, 135)
aimbotPanel.Size = UDim2.new(1, -120, 0, 160)
aimbotPanel.BackgroundTransparency = 1
aimbotPanel.Visible = false

local toggleBtn = Instance.new("TextButton", aimbotPanel)
toggleBtn.Position = UDim2.new(0, 0, 0, 0)
toggleBtn.Size = UDim2.new(0, 180, 0, 35)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.Text = "Enable Aimbot"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
roundify(toggleBtn, 6)

local sliderLabel = Instance.new("TextLabel", aimbotPanel)
sliderLabel.Position = UDim2.new(0, 0, 0, 45)
sliderLabel.Size = UDim2.new(0, 180, 0, 25)
sliderLabel.Text = "Smoothness: 50"
sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Font = Enum.Font.SourceSans
sliderLabel.TextSize = 16

local slider = Instance.new("TextButton", aimbotPanel)
slider.Position = UDim2.new(0, 0, 0, 75)
slider.Size = UDim2.new(0, 180, 0, 25)
slider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
slider.Text = ""
roundify(slider, 6)

-- Slider Knob
local knob = Instance.new("Frame", slider)
knob.Size = UDim2.new(0, 10, 1, 0)
knob.Position = UDim2.new(0.5, -5, 0, 0)
knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
roundify(knob, 5)

-- Logic Variables
local aimbotEnabled = false
local smoothness = 50
local target = nil

-- Aimbot Logic
local function getClosest()
    local shortest = math.huge
    local closest = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = p
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local pos = target.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)
        local dir = (pos - camera.CFrame.Position).Unit
        camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, camera.CFrame.Position + dir), smoothness / 100)
    end
end)

-- Key Check
submitBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "sxoncruns420" then
        tween(keyFrame, {Size = UDim2.new(0, 300, 0, 0)}, 0.3)
        wait(0.3)
        keyGUI:Destroy()
        main.Visible = true
    else
        keyLabel.Text = "Invalid Code!"
        keyLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Sidebar Tabs
mainBtn.MouseButton1Click:Connect(function()
    aimbotPanel.Visible = false
    feed.Text = "⚡ Not Coded Yet, Added Soon"
end)
miscBtn.MouseButton1Click:Connect(function()
    aimbotPanel.Visible = false
    feed.Text = "🔧 Not Coded Yet, Added Soon"
end)
aimbotBtn.MouseButton1Click:Connect(function()
    feed.Text = "🎯 Aimbot Panel"
    aimbotPanel.Visible = true
end)

-- Aimbot Toggle Button
toggleBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    toggleBtn.Text = aimbotEnabled and "Disable Aimbot" or "Enable Aimbot"
    if aimbotEnabled then
        target = getClosest()
        feed.Text = "🎯 Aimbot ON"
    else
        feed.Text = "🎯 Aimbot OFF"
        target = nil
    end
end)

-- Smoothness Slider Drag
local dragging = false
slider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)
slider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local x = math.clamp(input.Position.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
        knob.Position = UDim2.new(0, x - 5, 0, 0)
        smoothness = math.floor((x / slider.AbsoluteSize.X) * 100)
        sliderLabel.Text = "Smoothness: " .. tostring(smoothness)
    end
end)

-- Toggle GUI
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        main.Visible = not main.Visible
    end
end)
