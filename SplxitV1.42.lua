local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SplxitTerminal"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 360)
frame.Position = UDim2.new(0.5, -300, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- darker grey
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Visible = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Top Bar
local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 32)
topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
topBar.BackgroundTransparency = 0.1
topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)

-- App Title
local title = Instance.new("TextLabel", topBar)
title.Text = "Splxit V1.42"
title.Font = Enum.Font.Code
title.TextColor3 = Color3.fromRGB(230, 230, 230)
title.TextSize = 16
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center

-- Close Button
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 36, 1, 0)
closeBtn.Position = UDim2.new(1, -44, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.Code
closeBtn.TextColor3 = Color3.fromRGB(230, 80, 80)
closeBtn.TextSize = 20
closeBtn.AutoButtonColor = false

-- Minimize Button
local minBtn = Instance.new("TextButton", topBar)
minBtn.Text = "–"
minBtn.Size = UDim2.new(0, 36, 1, 0)
minBtn.Position = UDim2.new(1, -88, 0, 0)
minBtn.BackgroundTransparency = 1
minBtn.Font = Enum.Font.Code
minBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
minBtn.TextSize = 20
minBtn.AutoButtonColor = false

-- Output Scrolling Frame
local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Position = UDim2.new(0, 16, 0, 40)
scrollFrame.Size = UDim2.new(1, -32, 0, 260)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Output TextLabel
local outputLabel = Instance.new("TextLabel", scrollFrame)
outputLabel.Size = UDim2.new(1, -10, 0, 0)
outputLabel.Position = UDim2.new(0, 5, 0, 0)
outputLabel.BackgroundTransparency = 1
outputLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
outputLabel.Font = Enum.Font.Code
outputLabel.TextSize = 14
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.TextYAlignment = Enum.TextYAlignment.Top
outputLabel.TextWrapped = true
outputLabel.Text = "Welcome to Splxit terminal!\nType 'cmds' to see available commands.\n"

-- Input Frame (grey rounded box)
local inputFrame = Instance.new("Frame", frame)
inputFrame.Size = UDim2.new(1, -32, 0, 38)
inputFrame.Position = UDim2.new(0, 16, 1, -54)
inputFrame.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
inputFrame.BorderSizePixel = 0
Instance.new("UICorner", inputFrame).CornerRadius = UDim.new(0, 8)

-- Input Box
local inputBox = Instance.new("TextBox", inputFrame)
inputBox.Size = UDim2.new(1, -16, 1, -10)
inputBox.Position = UDim2.new(0, 8, 0, 5)
inputBox.BackgroundTransparency = 1
inputBox.TextColor3 = Color3.fromRGB(230, 230, 230)
inputBox.Font = Enum.Font.Code
inputBox.TextSize = 15
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.ClearTextOnFocus = false
inputBox.PlaceholderText = "SPLXIT: >"
inputBox.Text = ""
inputBox.TextEditable = true
inputBox.ClipsDescendants = true

-- Utility to append output with scrolling
local function appendOutput(text)
	if outputLabel.Text ~= "" then
		outputLabel.Text = outputLabel.Text .. "\n" .. text
	else
		outputLabel.Text = text
	end
	wait() -- wait for text bounds to update
	outputLabel.Size = UDim2.new(1, -10, 0, outputLabel.TextBounds.Y)
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, outputLabel.TextBounds.Y + 10)
	scrollFrame.CanvasPosition = Vector2.new(0, outputLabel.TextBounds.Y)
end

-- Fake IP Info DB
local fakeLocations = {
	{"New York", "USA", "Verizon", "nyc-gw.verizon.net"},
	{"Tokyo", "Japan", "NTT", "tokyo-ntt.jp"},
	{"London", "UK", "BT", "lndn.bt.net"},
	{"Paris", "France", "Orange", "paris.orange.fr"},
	{"Toronto", "Canada", "Bell", "toronto.bell.ca"},
}

local function getFakeIPInfo(ip)
	local fake = fakeLocations[math.random(1, #fakeLocations)]
	return string.format(
		"IP LEAK REPORT\nIP Address: %s\nLocation: %s, %s\nISP: %s\nHostname: %s",
		ip, fake[1], fake[2], fake[3], fake[4]
	)
end

-- Fake Personal Info DB for DDOS command
local fakePersonalInfos = {
	{
		Name = "John Doe",
		SSN = "123-45-6789",
		Address = "742 Evergreen Terrace, Springfield",
		IP = "192.168.1.100",
	},
	{
		Name = "Jane Smith",
		SSN = "987-65-4321",
		Address = "221B Baker Street, London",
		IP = "10.0.0.5",
	},
	{
		Name = "Alice Johnson",
		SSN = "555-44-3333",
		Address = "12 Grimmauld Place, London",
		IP = "172.16.0.10",
	},
}

local function getFakeDDOSInfo(ip)
	local info = fakePersonalInfos[math.random(1, #fakePersonalInfos)]
	return string.format(
		"DDOS ATTACK INITIATED ON %s\n" ..
		"Target Info:\nName: %s\nSocial Security Number: %s\nAddress: %s\nIP Address: %s\n" ..
		"Attack Status: SUCCESSFUL\nDuration: %d seconds\nPackets Sent: %d million\n",
		ip, info.Name, info.SSN, info.Address, info.IP,
		math.random(10, 120), math.random(100, 1000)
	)
end

-- List all commands text
local function getCommandsList()
	return [[
Available Commands:
- ipleak <ip>   : Simulate IP information lookup.
- ddos <ip>     : Simulate a DDOS attack with fake target info.
- cmds          : Show this command list.
]]
end

-- Input box handler
inputBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local text = inputBox.Text
		local command = text:match("^%s*SPLXIT:%s*>%s*(.+)$") or text -- remove prefix if present
		command = command:lower()
		if command == "" then
			inputBox.Text = ""
			return
		end

		local args = {}
		for word in command:gmatch("%S+") do
			table.insert(args, word)
		end

		appendOutput("SPLXIT: > " .. text)

		if args[1] == "ipleak" and args[2] then
			appendOutput(getFakeIPInfo(args[2]))
		elseif args[1] == "ddos" and args[2] then
			appendOutput(getFakeDDOSInfo(args[2]))
		elseif args[1] == "cmds" then
			appendOutput(getCommandsList())
		else
			appendOutput("Unknown command: " .. (args[1] or ""))
		end
		inputBox.Text = ""
	end
end)

-- Fade toggle function
local visible = true
local function fade(state)
	if state then
		frame.Visible = true
	end
	local goal = {
		BackgroundTransparency = state and 0.05 or 1
	}
	local tween = TweenService:Create(frame, TweenInfo.new(0.3), goal)
	tween:Play()

	for _, v in pairs(frame:GetDescendants()) do
		if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
			local t = TweenService:Create(v, TweenInfo.new(0.3), {
				TextTransparency = state and 0 or 1
			})
			t:Play()
		end
	end

	if not state then
		delay(0.3, function()
			frame.Visible = false
		end)
	end
end

-- Toggle terminal on RightShift
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
		visible = not visible
		fade(visible)
	end
end)

-- Close button behavior
closeBtn.MouseButton1Click:Connect(function()
	visible = false
	fade(false)
end)

-- Minimize button behavior
minBtn.MouseButton1Click:Connect(function()
	visible = false
	fade(false)
end)
