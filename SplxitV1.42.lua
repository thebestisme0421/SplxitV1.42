-- Part 1: GUI Setup and Base Terminal
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SplxitTerminal"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 600, 0, 360)
frame.Position = UDim2.new(0.5, -300, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 36)
topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topBar.BackgroundTransparency = 0.8
topBar.BorderSizePixel = 0
topBar.Active = true
topBar.Draggable = true
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", topBar)
title.Text = "Splxit V1.42"
title.Font = Enum.Font.Code
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 36, 1, 0)
closeBtn.Position = UDim2.new(1, -44, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.Code
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.TextSize = 22
closeBtn.AutoButtonColor = false
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local minBtn = Instance.new("TextButton", topBar)
minBtn.Text = "–"
minBtn.Size = UDim2.new(0, 36, 1, 0)
minBtn.Position = UDim2.new(1, -88, 0, 0)
minBtn.BackgroundTransparency = 1
minBtn.Font = Enum.Font.Code
minBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
minBtn.TextSize = 26
minBtn.AutoButtonColor = false
minBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Position = UDim2.new(0, 16, 0, 46)
scrollFrame.Size = UDim2.new(1, -32, 0, 260)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.CanvasSize = UDim2.new(0, 0, 1, 0)

local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 2)

local promptFrame = Instance.new("Frame", frame)
promptFrame.Size = UDim2.new(1, -32, 0, 38)
promptFrame.Position = UDim2.new(0, 16, 1, -54)
promptFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
promptFrame.BorderSizePixel = 0
Instance.new("UICorner", promptFrame).CornerRadius = UDim.new(0, 10)

local promptLabel = Instance.new("TextLabel", promptFrame)
promptLabel.Text = "SPLXIT: >"
promptLabel.Font = Enum.Font.Code
promptLabel.TextSize = 15
promptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
promptLabel.BackgroundTransparency = 1
promptLabel.Size = UDim2.new(0, 90, 1, 0)
promptLabel.Position = UDim2.new(0, 8, 0, 0)
promptLabel.TextXAlignment = Enum.TextXAlignment.Left

local inputBox = Instance.new("TextBox", promptFrame)
inputBox.Size = UDim2.new(1, -110, 1, 0)
inputBox.Position = UDim2.new(0, 100, 0, 0)
inputBox.BackgroundTransparency = 1
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.Code
inputBox.TextSize = 15
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.ClearTextOnFocus = false
inputBox.Text = ""
inputBox.PlaceholderText = "Enter command..."

local function appendOutput(text)
	local line = Instance.new("TextLabel", scrollFrame)
	line.Size = UDim2.new(1, -10, 0, 0)
	line.BackgroundTransparency = 1
	line.TextColor3 = Color3.fromRGB(200, 230, 255)
	line.Font = Enum.Font.Code
	line.TextSize = 14
	line.TextXAlignment = Enum.TextXAlignment.Left
	line.TextYAlignment = Enum.TextYAlignment.Top
	line.TextWrapped = true
	line.Text = text
	line.AutomaticSize = Enum.AutomaticSize.Y
end

local minBtn = Instance.new("TextButton", topBar)
minBtn.Text = "–"
minBtn.Size = UDim2.new(0, 36, 1, 0)
minBtn.Position = UDim2.new(1, -88, 0, 0)
minBtn.BackgroundTransparency = 1
minBtn.Font = Enum.Font.Code
minBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
minBtn.TextSize = 26
minBtn.AutoButtonColor = false

local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Position = UDim2.new(0, 16, 0, 46)
scrollFrame.Size = UDim2.new(1, -32, 0, 260)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.CanvasSize = UDim2.new(0, 0, 1, 0)

local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 2)

local promptFrame = Instance.new("Frame", frame)
promptFrame.Size = UDim2.new(1, -32, 0, 38)
promptFrame.Position = UDim2.new(0, 16, 1, -54)
promptFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
promptFrame.BorderSizePixel = 0
Instance.new("UICorner", promptFrame).CornerRadius = UDim.new(0, 10)

local promptLabel = Instance.new("TextLabel", promptFrame)
promptLabel.Text = "SPLXIT: >"
promptLabel.Font = Enum.Font.Code
promptLabel.TextSize = 15
promptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
promptLabel.BackgroundTransparency = 1
promptLabel.Size = UDim2.new(0, 90, 1, 0)
promptLabel.Position = UDim2.new(0, 8, 0, 0)
promptLabel.TextXAlignment = Enum.TextXAlignment.Left

local inputBox = Instance.new("TextBox", promptFrame)
inputBox.Size = UDim2.new(1, -110, 1, 0)
inputBox.Position = UDim2.new(0, 100, 0, 0)
inputBox.BackgroundTransparency = 1
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.Code
inputBox.TextSize = 15
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.ClearTextOnFocus = false
inputBox.Text = ""
inputBox.PlaceholderText = "Enter command..."

local function appendOutput(text)
	local line = Instance.new("TextLabel", scrollFrame)
	line.Size = UDim2.new(1, -10, 0, 0)
	line.BackgroundTransparency = 1
	line.TextColor3 = Color3.fromRGB(200, 230, 255)
	line.Font = Enum.Font.Code
	line.TextSize = 14
	line.TextXAlignment = Enum.TextXAlignment.Left
	line.TextYAlignment = Enum.TextYAlignment.Top
	line.TextWrapped = true
	line.Text = text
	line.AutomaticSize = Enum.AutomaticSize.Y
end

local aimbotEnabled = false
local currentTarget = nil
local espEnabled = false
local espObjects = {}

local function getPing()
	local stats = player:FindFirstChild("NetworkClient") and player.NetworkClient:FindFirstChild("Ping")
	if stats then return stats:GetValue() end
	return 60
end

RunService.RenderStepped:Connect(function()
	if aimbotEnabled and currentTarget and currentTarget.Character then
		local hrp = currentTarget.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local cam = workspace.CurrentCamera
			local ping = getPing()
			local accuracy = 1
			if ping <= 30 then accuracy = 1
			elseif ping <= 80 then accuracy = 0.8
			elseif ping <= 100 then accuracy = 0.6
			elseif ping >= 155 then accuracy = 0.4 end
			local offset = Vector3.new(math.random(), math.random(), 0) * (1 - accuracy)
			local dir = (hrp.Position + offset - cam.CFrame.Position).Unit
			cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, cam.CFrame.Position + dir), 0.2)
		end
	end
end)

local function createESP(plr)
	if espObjects[plr] then return end
	local box = Drawing.new("Square")
	box.Size = Vector2.new(40, 40)
	box.Thickness = 1
	box.Color = Color3.new(1, 1, 1)
	box.Visible = true
	box.Filled = false

	local name = Drawing.new("Text")
	name.Text = plr.Name
	name.Size = 13
	name.Center = true
	name.Outline = true
	name.Color = Color3.fromRGB(180, 180, 180)
	name.OutlineColor = Color3.fromRGB(255, 255, 255)
	name.Visible = true

	espObjects[plr] = {box = box, name = name}

	RunService.RenderStepped:Connect(function()
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local pos = plr.Character.HumanoidRootPart.Position
			local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(pos)
			box.Visible = onScreen and espEnabled
			name.Visible = onScreen and espEnabled
			if onScreen then
				box.Position = Vector2.new(screenPos.X - 20, screenPos.Y - 20)
				name.Position = Vector2.new(screenPos.X, screenPos.Y - 35)
			end
		else
			box.Visible = false
			name.Visible = false
		end
	end)
end

local function removeESP()
	for _, v in pairs(espObjects) do
		if v.box then v.box:Remove() end
		if v.name then v.name:Remove() end
	end
	espObjects = {}
end

inputBox.FocusLost:Connect(function(enter)
	if not enter then return end
	local input = inputBox.Text:lower()
	inputBox.Text = ""

	if input == "aimbot" then
		aimbotEnabled = not aimbotEnabled
		currentTarget = nil
		appendOutput("Aimbot toggled: " .. tostring(aimbotEnabled))
	elseif input:match("^hitbox %d+$") then
		local size = tonumber(input:match("%d+"))
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local part = plr.Character.HumanoidRootPart
				part.Size = Vector3.new(size, size, size)
				part.Transparency = 0.7
			end
		end
		appendOutput("Set hitbox size to " .. size)
	elseif input == "esp on" then
		espEnabled = true
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= player then createESP(plr) end
		end
		appendOutput("ESP enabled.")
	elseif input == "esp off" then
		espEnabled = false
		removeESP()
		appendOutput("ESP disabled.")
	elseif input == "cmds" then
		appendOutput("Commands: aimbot, hitbox <1-25>, esp on, esp off")
	else
		appendOutput("Unknown command: " .. input)
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Y then
		aimbotEnabled = not aimbotEnabled
		currentTarget = nil
		appendOutput("Aimbot toggled (Y): " .. tostring(aimbotEnabled))
	end
	if input.KeyCode == Enum.KeyCode.X then
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = 120
			appendOutput("WalkSpeed set to 120 (X key)")
		end
	end
end)

-- Force crosshair cursor
local mouse = player:GetMouse()
pcall(function() mouse.Icon = "rbxasset://textures/Cursors/CrossMouseIcon.png" end)
