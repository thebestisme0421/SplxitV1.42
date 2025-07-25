-- Splxit Terminal V1.42
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
title.TextYAlignment = Enum.TextYAlignment.Center

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 36, 1, 0)
closeBtn.Position = UDim2.new(1, -44, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.Code
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.TextSize = 22
closeBtn.AutoButtonColor = false
closeBtn.ToolTip = "Close Terminal"

local minBtn = Instance.new("TextButton", topBar)
minBtn.Text = "–"
minBtn.Size = UDim2.new(0, 36, 1, 0)
minBtn.Position = UDim2.new(1, -88, 0, 0)
minBtn.BackgroundTransparency = 1
minBtn.Font = Enum.Font.Code
minBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
minBtn.TextSize = 26
minBtn.AutoButtonColor = false
minBtn.ToolTip = "Minimize Terminal"

local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Position = UDim2.new(0, 16, 0, 46)
scrollFrame.Size = UDim2.new(1, -32, 0, 260)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ClipsDescendants = true

local outputLabel = Instance.new("TextLabel", scrollFrame)
outputLabel.Size = UDim2.new(1, -10, 0, 0)
outputLabel.Position = UDim2.new(0, 5, 0, 0)
outputLabel.BackgroundTransparency = 1
outputLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
outputLabel.Font = Enum.Font.Code
outputLabel.TextSize = 14
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.TextYAlignment = Enum.TextYAlignment.Top
outputLabel.TextWrapped = true
outputLabel.Text = ""

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
promptLabel.TextYAlignment = Enum.TextYAlignment.Center

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
	if outputLabel.Text ~= "" then
		outputLabel.Text = outputLabel.Text .. "\n" .. text
	else
		outputLabel.Text = text
	end
	wait()
	outputLabel.Size = UDim2.new(1, -10, 0, outputLabel.TextBounds.Y)
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, outputLabel.TextBounds.Y + 10)
	scrollFrame.CanvasPosition = Vector2.new(0, outputLabel.TextBounds.Y)
end

local fakeIPData = {
	["8.8.8.8"] = {
		Location = "Mountain View, California, USA",
		ISP = "Google LLC",
		Hostname = "dns.google"
	},
	["1.1.1.1"] = {
		Location = "Research, Australia",
		ISP = "Cloudflare",
		Hostname = "one.one.one.one"
	},
}

local function getFakeIPInfo(ip)
	local data = fakeIPData[ip] or {
		Location = "Unknown Location",
		ISP = "Unknown ISP",
		Hostname = "Unknown Host"
	}
	return ("IP LEAK REPORT\nIP Address: %s\nLocation: %s\nISP: %s\nHostname: %s"):format(
		ip, data.Location, data.ISP, data.Hostname
	)
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
- ipleak <ip>   : Show fake IP info.
- ddos <ip>     : Simulate fake DDOS attack.
- cmds          : Show this command list.
]]
end

local function executeCommand(text)
	local commandLine = text:match("^%s*(.-)%s*$") or ""
	local args = {}
	for word in commandLine:gmatch("%S+") do
		table.insert(args, word)
	end

	appendOutput("SPLXIT: > " .. text)

	if args[1] == "ipleak" and args[2] then
		appendOutput("Looking up IP info for " .. args[2] .. "...")
		wait(1)
		appendOutput(getFakeIPInfo(args[2]))
	elseif args[1] == "ddos" and args[2] then
		appendOutput("Launching DDOS attack on " .. args[2] .. "...")
		wait(1)
		appendOutput(getFakeDDOSInfo(args[2]))
	elseif args[1] == "cmds" then
		appendOutput(getCommandsList())
	elseif args[1] == "" then
		-- Do nothing on empty command
	else
		appendOutput("Error: Unknown command. Type 'cmds' to see commands.")
	end
end

inputBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local cmd = inputBox.Text
		executeCommand(cmd)
		inputBox.Text = ""
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		frame.Size = UDim2.new(0, 300, 0, 40)
		scrollFrame.Visible = false
		promptFrame.Visible = false
	else
		frame.Size = UDim2.new(0, 600, 0, 360)
		scrollFrame.Visible = true
		promptFrame.Visible = true
	end
end)

local faded = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		faded = not faded
		local goal = {}
		if faded then
			goal.BackgroundTransparency = 0.7
		else
			goal.BackgroundTransparency = 0.1
		end
		TweenService:Create(frame, TweenInfo.new(0.3), goal):Play()
	end
end)

appendOutput("Welcome to Splxit Terminal V1.42")
appendOutput("Type 'cmds' to see available commands.")

inputBox:CaptureFocus()
