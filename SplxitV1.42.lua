-- Splxit Terminal V1.42 (Improved with Fly, Draggable GUI, and Centered Text)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

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
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
frame.Visible = true

local dragToggle, dragInput, dragStart, startPos
local function updateInput(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 36)
topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topBar.BackgroundTransparency = 0.8
topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 14)

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragToggle then
		updateInput(input)
	end
end)

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
	line.TextXAlignment = Enum.TextXAlignment.Center
	line.TextYAlignment = Enum.TextYAlignment.Top
	line.TextWrapped = true
	line.Text = text
	line.AutomaticSize = Enum.AutomaticSize.Y
end

local function getCommandsList()
	return [[
Available Commands:
- ipleak <ip>   : Show IP information.
- ddos <ip>     : Simulate DDOS operation.
- fly           : Enable flight mode.
- cmds          : Show this command list.
]]
end

local flying = false
local function startFlying()
	if flying then return end
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	flying = true
	appendOutput("Flight enabled. Press F to stop.")

	local bg = Instance.new("BodyGyro", hrp)
	bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bg.P = 9e4
	bg.CFrame = hrp.CFrame

	local bv = Instance.new("BodyVelocity", hrp)
	bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bv.Velocity = Vector3.new(0, 0, 0)

	local cam = workspace.CurrentCamera
	local speed = 60
	local keys = {}

	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		local code = input.KeyCode.Name
		keys[code] = true
		if code == "F" then
			flying = false
			bg:Destroy()
			bv:Destroy()
			appendOutput("Flight disabled.")
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		keys[input.KeyCode.Name] = false
	end)

	task.spawn(function()
		while flying do
			task.wait()
			local dir = Vector3.zero
			if keys.W then dir += cam.CFrame.LookVector end
			if keys.S then dir -= cam.CFrame.LookVector end
			if keys.A then dir -= cam.CFrame.RightVector end
			if keys.D then dir += cam.CFrame.RightVector end
			bv.Velocity = dir.Unit * speed
			bg.CFrame = cam.CFrame
		end
	end)
end

local function executeCommand(text)
	local commandLine = text:match("^%s*(.-)%s*$") or ""
	local args = {}
	for word in commandLine:gmatch("%S+") do
		table.insert(args, word:lower())
	end

	appendOutput("SPLXIT: > " .. text)

	if args[1] == "ipleak" then
		appendOutput("Looking up IP info for " .. (args[2] or "N/A") .. "...")
		appendOutput("[Mocked IP lookup results]")
	elseif args[1] == "ddos" then
		appendOutput("Launching DDOS simulation on " .. (args[2] or "N/A") .. "...")
		appendOutput("[Mocked DDOS output]")
	elseif args[1] == "cmds" then
		appendOutput(getCommandsList())
	elseif args[1] == "fly" then
		startFlying()
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
		TweenService:Create(frame, TweenInfo.new(0.3), { BackgroundTransparency = faded and 0.7 or 0.1 }):Play()
	end
end)

appendOutput("Welcome to Splxit Terminal V1.42")
appendOutput("Type 'cmds' to see available commands.")
inputBox:CaptureFocus()
