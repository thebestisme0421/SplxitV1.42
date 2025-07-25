local flying = false

local function startFlying()
	if flying then
		appendOutput("Already flying.")
		return
	end

	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then
		appendOutput("Error: Character not found.")
		return
	end

	flying = true
	appendOutput("Flight mode enabled. Press F to stop.")

	local hrp = char.HumanoidRootPart
	local bodyGyro = Instance.new("BodyGyro", hrp)
	local bodyVel = Instance.new("BodyVelocity", hrp)
	bodyGyro.P = 9e4
	bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bodyGyro.CFrame = hrp.CFrame

	bodyVel.Velocity = Vector3.new(0, 0, 0)
	bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)

	local speed = 50
	local keys = {W = false, A = false, S = false, D = false}

	local function flyLoop()
		while flying and hrp and bodyVel and bodyGyro do
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
	end

	local function keyPressed(input)
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
	end

	local function keyReleased(input)
		if input.UserInputType == Enum.UserInputType.Keyboard then
			local key = input.KeyCode.Name
			if keys[key] ~= nil then keys[key] = false end
		end
	end

	UserInputService.InputBegan:Connect(keyPressed)
	UserInputService.InputEnded:Connect(keyReleased)

	task.spawn(flyLoop)
end
