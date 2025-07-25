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
local lockedTarget = nil

local function getClosestTarget()
	local closestPlayer = nil
	local shortestDistance = math.huge
	local camera = workspace.CurrentCamera
	local mousePos = UserInputService:GetMouseLocation()

	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local torsoPos, onScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
			if onScreen then
				local dist = (Vector2.new(torsoPos.X, torsoPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
				if dist < shortestDistance then
					shortestDistance = dist
					closestPlayer = plr
				end
			end
		end
	end
	return closestPlayer
end

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.Y then
		aimbotEnabled = not aimbotEnabled
		if aimbotEnabled then
			lockedTarget = getClosestTarget()
			if lockedTarget then
				appendOutput("Aimbot locked on " .. lockedTarget.Name)
			else
				appendOutput("No target found.")
			end
		else
			lockedTarget = nil
			appendOutput("Aimbot disabled.")
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if aimbotEnabled and lockedTarget and lockedTarget.Character and lockedTarget.Character:FindFirstChild("HumanoidRootPart") then
		local torsoPos = lockedTarget.Character.HumanoidRootPart.Position
		local rng = Random.new()
		if rng:NextNumber() <= 0.6 then
			workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, torsoPos)
		else
			local offset = Vector3.new(rng:NextNumber(-1.5, 1.5), rng:NextNumber(-1.5, 1.5), rng:NextNumber(-1.5, 1.5))
			workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, torsoPos + offset)
		end
	end
end)

local function getCommandsList()
	return [[
Available Commands:
- cmds       : Show this command list.
- aimbot     : Enable aimbot (toggle with Y)
- reset      : Reset your character.
]]
end

local function executeCommand(text)
	appendOutput("SPLXIT: > " .. text)
	local cmd = text:lower()
	if cmd == "cmds" then
		appendOutput(getCommandsList())
	elseif cmd == "aimbot" then
		aimbotEnabled = true
		lockedTarget = getClosestTarget()
		if lockedTarget then
			appendOutput("Aimbot locked on " .. lockedTarget.Name .. ". Press Y to toggle.")
		else
			appendOutput("No target found.")
		end
	elseif cmd == "reset" then
		player:LoadCharacter()
		appendOutput("Character reset.")
	else
		appendOutput("Error: Unknown command. Type 'cmds' to see commands.")
	end
end

inputBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		executeCommand(inputBox.Text)
		inputBox.Text = ""
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	frame.Size = minimized and UDim2.new(0, 300, 0, 40) or UDim2.new(0, 600, 0, 360)
	scrollFrame.Visible = not minimized
	promptFrame.Visible = not minimized
end)

local faded = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		faded = not faded
		TweenService:Create(frame, TweenInfo.new(0.3), {
			BackgroundTransparency = faded and 0.7 or 0.1
		}):Play()
	end
end)

appendOutput("Welcome to Splxit Terminal V1.42")
appendOutput("Type 'cmds' to see available commands.")
inputBox:CaptureFocus()
