-- Splxit Terminal V1.42 (Fixed and Fly-Enabled)

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

local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 36)
topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topBar.BackgroundTransparency = 0.8
topBar.BorderSizePixel = 0
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

local flying = false
local function startFlying()
	if flying then appendOutput("Already flying.") return end

	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then appendOutput("Error: HumanoidRootPart not found.") return end

	flying = true
	appendOutput("Flight mode enabled. Press F to stop.")

	local bodyGyro = Instance.new("BodyGyro", hrp)
	local bodyVel = Instance.new("BodyVelocity", hrp)
	bodyGyro.P = 9e4
	bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bodyGyro.CFrame = hrp.CFrame
	bodyVel.Velocity = Vector3.new(0, 0, 0)
	bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)

	local keys = {W = false, A = false, S = false, D = false}
	local speed = 50

	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Keyboard then
			local key = input.KeyCode.Name
			if keys[key] ~= nil then keys[key] = true end
			if key == "F" then
				flying = false
				bodyGyro:Destroy()
				bodyVel:Destroy()
				appendOutput("Flight mode disabled.")
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Keyboard then
			local key = input.KeyCode.Name
			if keys[key] ~= nil then keys[key] = false end
		end
	end)
	task.spawn(function()
		while flying do
			local cam = workspace.CurrentCamera
			local dir = Vector3.new()
			if keys.W then dir += cam.CFrame.LookVector end
			if keys.S then dir -= cam.CFrame.LookVector end
			if keys.A then dir -= cam.CFrame.RightVector end
			if keys.D then dir += cam.CFrame.RightVector end
			bodyVel.Velocity = dir.Unit * speed
			bodyGyro.CFrame = cam.CFrame
			task.wait()
		end
	end)
end

local fakeIPData = {
	["8.8.8.8"] = { Location = "Mountain View, California, USA", ISP = "Google LLC", Hostname = "dns.google" },
	["1.1.1.1"] = { Location = "Research, Australia", ISP = "Cloudflare", Hostname = "one.one.one.one" },
}

local function getFakeIPInfo(ip)
	local data = fakeIPData[ip] or {
		Location = "Unknown Location", ISP = "Unknown ISP", Hostname = "Unknown Host"
	}
	return ("IP LEAK REPORT\nIP Address: %s\nLocation: %s\nISP: %s\nHostname: %s"):format(ip, data.Location, data.ISP, data.Hostname)
end

local function getFakeDDOSInfo(ip)
	return ([[
DDOS ATTACK INITIATED ON %s
Target Info:
Name: Jane Doe
Social Security Number: 123-45-6789
Address: 123 Main Street, Anytown
IP Address: %s

Attack Status: SUCCESSFUL
Duration: 120 seconds
Packets Sent: 500 million
]]):format(ip, ip)
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

local function executeCommand(text)
	local commandLine = text:match("^%s*(.-)%s*$") or ""
	local args = {}
	for word in commandLine:gmatch("%S+") do
		table.insert(args, word:lower())
	end
	appendOutput("SPLXIT: > " .. text)
	if args[1] == "ipleak" then
		if args[2] then
			appendOutput("Looking up IP info for " .. args[2] .. "...")
			wait(1)
			appendOutput(getFakeIPInfo(args[2]))
		else
			appendOutput("Usage: ipleak <ip address/domain>")
		end
	elseif args[1] == "ddos" then
		if args[2] then
			appendOutput("Launching DDOS attack on " .. args[2] .. "...")
			wait(1)
			appendOutput(getFakeDDOSInfo(args[2]))
		else
			appendOutput("Usage: ddos <ip address/domain>")
		end
	elseif args[1] == "fly" then
		startFlying()
	elseif args[1] == "cmds" then
		appendOutput(getCommandsList())
	elseif args[1] == "" then
		-- no action
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
		local goal = { BackgroundTransparency = faded and 0.7 or 0.1 }
		TweenService:Create(frame, TweenInfo.new(0.3), goal):Play()
	end
end)

appendOutput("Welcome to Splxit Terminal V1.42")
appendOutput("Type 'cmds' to see available commands.")
inputBox:CaptureFocus()
