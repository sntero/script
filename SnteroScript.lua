--[[
	Project: Sntero Script (Restored Original Style with In-GUI Shift Lock)
	Description: Premium Roblox GUI with Fly, Noclip, WalkSpeed, Infinite Jump, In-GUI Shift Lock, and Lightning Open/Close Button.
	Compatibility: PC & Mobile (Fully Functional)
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Prevent duplicate GUIs
if CoreGui:FindFirstChild("SnteroScriptGUI") then
	CoreGui.SnteroScriptGUI:Destroy()
end

-- ScreenGui Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SnteroScriptGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local success, err = pcall(function()
	screenGui.Parent = CoreGui
end)
if not success then
	screenGui.Parent = player:WaitForChild("PlayerGui")
end

-- Main Frame (Draggable & Premium Design)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 480)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(0, 162, 255)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.3
mainStroke.Parent = mainFrame

-- Top Bar / Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -50, 0, 50)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "SNTERO SCRIPT"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- Hide Button (-) inside GUI
local hideBtn = Instance.new("TextButton")
hideBtn.Name = "HideButton"
hideBtn.Size = UDim2.new(0, 30, 0, 30)
hideBtn.Position = UDim2.new(1, -40, 0, 10)
hideBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
hideBtn.Font = Enum.Font.GothamBold
hideBtn.Text = "-"
hideBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
hideBtn.TextSize = 18
hideBtn.Parent = mainFrame

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 6)
hideCorner.Parent = hideBtn

-- Floating Open Button (زر البرق الأصلي لفتح وإغلاق الواجهة عندما تكون مخفية)
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.new(0, 45, 0, 45)
openBtn.Position = UDim2.new(0, 20, 0.5, -22)
openBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
openBtn.Font = Enum.Font.GothamBold
openBtn.Text = "⚡"
openBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
openBtn.TextSize = 20
openBtn.Visible = false
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 10)
openCorner.Parent = openBtn

local openStroke = Instance.new("UIStroke")
openStroke.Color = Color3.fromRGB(0, 162, 255)
openStroke.Thickness = 1.5
openStroke.Parent = openBtn

hideBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	openBtn.Visible = false
end)

-- Scrolling Container for Features
local scrollContainer = Instance.new("ScrollingFrame")
scrollContainer.Name = "ScrollContainer"
scrollContainer.Size = UDim2.new(1, -20, 1, -65)
scrollContainer.Position = UDim2.new(0, 10, 0, 55)
scrollContainer.BackgroundTransparency = 1
scrollContainer.BorderSizePixel = 0
scrollContainer.CanvasSize = UDim2.new(0, 0, 0, 520)
scrollContainer.ScrollBarThickness = 4
scrollContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 162, 255)
scrollContainer.Parent = mainFrame

local uiLayout = Instance.new("UIListLayout")
uiLayout.Padding = UDim.new(0, 12)
uiLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiLayout.Parent = scrollContainer

--------------------------------------------------------------------------------
-- FEATURE BUILDER HELPER
--------------------------------------------------------------------------------
local function createFeatureCard(name, height)
	local card = Instance.new("Frame")
	card.Name = name .. "Card"
	card.Size = UDim2.new(1, -10, 0, height)
	card.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
	card.BorderSizePixel = 0
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = card
	
	return card
end

--------------------------------------------------------------------------------
-- 1. FLY & FLY SPEED SYSTEM
--------------------------------------------------------------------------------
local flyCard = createFeatureCard("Fly", 115)
local flyContainer = Instance.new("Frame")
flyContainer.Size = UDim2.new(1, 0, 1, 0)
flyContainer.BackgroundTransparency = 1
flyContainer.Parent = flyCard

local flyTitle = Instance.new("TextLabel")
flyTitle.Size = UDim2.new(1, -20, 0, 40)
flyTitle.Position = UDim2.new(0, 15, 0, 0)
flyTitle.BackgroundTransparency = 1
flyTitle.Font = Enum.Font.GothamMedium
flyTitle.Text = "Flight System"
flyTitle.TextColor3 = Color3.fromRGB(220, 220, 225)
flyTitle.TextSize = 14
flyTitle.TextXAlignment = Enum.TextXAlignment.Left
flyTitle.Parent = flyContainer

local flyToggleBtn = Instance.new("TextButton")
flyToggleBtn.Size = UDim2.new(0, 70, 0, 28)
flyToggleBtn.Position = UDim2.new(1, -85, 0, 6)
flyToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
flyToggleBtn.Font = Enum.Font.GothamBold
flyToggleBtn.Text = "OFF"
flyToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
flyToggleBtn.TextSize = 12
flyToggleBtn.Parent = flyContainer
Instance.new("UICorner", flyToggleBtn).CornerRadius = UDim.new(0, 6)

local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Size = UDim2.new(1, -30, 0, 20)
flySpeedLabel.Position = UDim2.new(0, 15, 0, 42)
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.Font = Enum.Font.Gotham
flySpeedLabel.Text = "Fly Speed: 50"
flySpeedLabel.TextColor3 = Color3.fromRGB(170, 170, 180)
flySpeedLabel.TextSize = 12
flySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
flySpeedLabel.Parent = flyContainer

local flySpeedMinus = Instance.new("TextButton")
flySpeedMinus.Size = UDim2.new(0, 35, 0, 26)
flySpeedMinus.Position = UDim2.new(0, 15, 0, 68)
flySpeedMinus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
flySpeedMinus.Font = Enum.Font.GothamBold
flySpeedMinus.Text = "-"
flySpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
flySpeedMinus.TextSize = 14
flySpeedMinus.Parent = flyContainer
Instance.new("UICorner", flySpeedMinus).CornerRadius = UDim.new(0, 6)

local flySpeedPlus = Instance.new("TextButton")
flySpeedPlus.Size = UDim2.new(0, 35, 0, 26)
flySpeedPlus.Position = UDim2.new(0, 55, 0, 68)
flySpeedPlus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
flySpeedPlus.Font = Enum.Font.GothamBold
flySpeedPlus.Text = "+"
flySpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
flySpeedPlus.TextSize = 14
flySpeedPlus.Parent = flyContainer
Instance.new("UICorner", flySpeedPlus).CornerRadius = UDim.new(0, 6)

local flyUpBtn = Instance.new("TextButton")
flyUpBtn.Size = UDim2.new(0, 55, 0, 26)
flyUpBtn.Position = UDim2.new(1, -125, 0, 68)
flyUpBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
flyUpBtn.Font = Enum.Font.GothamBold
flyUpBtn.Text = "UP"
flyUpBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
flyUpBtn.TextSize = 11
flyUpBtn.Parent = flyContainer
Instance.new("UICorner", flyUpBtn).CornerRadius = UDim.new(0, 6)

local flyDownBtn = Instance.new("TextButton")
flyDownBtn.Size = UDim2.new(0, 55, 0, 26)
flyDownBtn.Position = UDim2.new(1, -65, 0, 68)
flyDownBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
flyDownBtn.Font = Enum.Font.GothamBold
flyDownBtn.Text = "DOWN"
flyDownBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
flyDownBtn.TextSize = 11
flyDownBtn.Parent = flyContainer
Instance.new("UICorner", flyDownBtn).CornerRadius = UDim.new(0, 6)

flyCard.Parent = scrollContainer

local flying = false
local flySpeed = 50
local flyUpPressed, flyDownPressed = false, false
local bv, bg

flySpeedMinus.MouseButton1Click:Connect(function()
	flySpeed = math.max(10, flySpeed - 10)
	flySpeedLabel.Text = "Fly Speed: " .. flySpeed
end)

flySpeedPlus.MouseButton1Click:Connect(function()
	flySpeed = math.min(300, flySpeed + 10)
	flySpeedLabel.Text = "Fly Speed: " .. flySpeed
end)

flyUpBtn.MouseButton1Down:Connect(function() flyUpPressed = true end)
flyUpBtn.MouseButton1Up:Connect(function() flyUpPressed = false end)
flyDownBtn.MouseButton1Down:Connect(function() flyDownPressed = true end)
flyDownBtn.MouseButton1Up:Connect(function() flyDownPressed = false end)

local function toggleFly(state)
	flying = state
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local hrp = char.HumanoidRootPart
	local humanoid = char:FindFirstChildOfClass("Humanoid")

	if flying then
		flyToggleBtn.Text = "ON"
		flyToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		flyToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
		
		if humanoid then humanoid.PlatformStand = true end
		
		bv = Instance.new("BodyVelocity")
		bv.Name = "SnteroFlyVelocity"
		bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv.Velocity = Vector3.new(0, 0, 0)
		bv.Parent = hrp
		
		bg = Instance.new("BodyGyro")
		bg.Name = "SnteroFlyGyro"
		bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bg.CFrame = hrp.CFrame
		bg.Parent = hrp
	else
		flyToggleBtn.Text = "OFF"
		flyToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
		flyToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
		
		if humanoid then humanoid.PlatformStand = false end
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
	end
end

flyToggleBtn.MouseButton1Click:Connect(function()
	toggleFly(not flying)
end)

RunService.RenderStepped:Connect(function()
	if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = player.Character.HumanoidRootPart
		local camera = workspace.CurrentCamera
		if bv and bg then
			bg.CFrame = camera.CFrame
			
			local moveDir = Vector3.new(0, 0, 0)
			
			local successModule, controlsModule = pcall(function()
				return require(player.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
			end)
			
			if successModule and controlsModule then
				local moveInput = controlsModule:GetMoveVector()
				moveDir = (camera.CFrame.RightVector * moveInput.X) - (camera.CFrame.LookVector * moveInput.Z)
			end
			
			if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then
				moveDir = moveDir + camera.CFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then
				moveDir = moveDir - camera.CFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then
				moveDir = moveDir - camera.CFrame.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then
				moveDir = moveDir + camera.CFrame.RightVector
			end
			
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) or flyUpPressed then
				moveDir = moveDir + Vector3.new(0, 1, 0)
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or flyDownPressed then
				moveDir = moveDir - Vector3.new(0, 1, 0)
			end
			
			bv.Velocity = moveDir * flySpeed
		end
	end
end)

--------------------------------------------------------------------------------
-- 2. NOCLIP SYSTEM
--------------------------------------------------------------------------------
local noclipCard = createFeatureCard("Noclip", 60)
local noclipContainer = Instance.new("Frame")
noclipContainer.Size = UDim2.new(1, 0, 1, 0)
noclipContainer.BackgroundTransparency = 1
noclipContainer.Parent = noclipCard

local noclipTitle = Instance.new("TextLabel")
noclipTitle.Size = UDim2.new(1, -20, 1, 0)
noclipTitle.Position = UDim2.new(0, 15, 0, 0)
noclipTitle.BackgroundTransparency = 1
noclipTitle.Font = Enum.Font.GothamMedium
noclipTitle.Text = "Noclip (Pass Walls)"
noclipTitle.TextColor3 = Color3.fromRGB(220, 220, 225)
noclipTitle.TextSize = 14
noclipTitle.TextXAlignment = Enum.TextXAlignment.Left
noclipTitle.Parent = noclipContainer

local noclipToggleBtn = Instance.new("TextButton")
noclipToggleBtn.Size = UDim2.new(0, 70, 0, 28)
noclipToggleBtn.Position = UDim2.new(1, -85, 0.5, -14)
noclipToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
noclipToggleBtn.Font = Enum.Font.GothamBold
noclipToggleBtn.Text = "OFF"
noclipToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
noclipToggleBtn.TextSize = 12
noclipToggleBtn.Parent = noclipContainer
Instance.new("UICorner", noclipToggleBtn).CornerRadius = UDim.new(0, 6)

noclipCard.Parent = scrollContainer

local noclipEnabled = false

noclipToggleBtn.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	if noclipEnabled then
		noclipToggleBtn.Text = "ON"
		noclipToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		noclipToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
	else
		noclipToggleBtn.Text = "OFF"
		noclipToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
		noclipToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
	end
end)

RunService.Stepped:Connect(function()
	if noclipEnabled and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

--------------------------------------------------------------------------------
-- 3. WALK SPEED SYSTEM
--------------------------------------------------------------------------------
local speedCard = createFeatureCard("WalkSpeed", 90)
local speedContainer = Instance.new("Frame")
speedContainer.Size = UDim2.new(1, 0, 1, 0)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = speedCard

local speedTitle = Instance.new("TextLabel")
speedTitle.Size = UDim2.new(1, -20, 0, 40)
speedTitle.Position = UDim2.new(0, 15, 0, 0)
speedTitle.BackgroundTransparency = 1
speedTitle.Font = Enum.Font.GothamMedium
speedTitle.Text = "Walk Speed Modifier"
speedTitle.TextColor3 = Color3.fromRGB(220, 220, 225)
speedTitle.TextSize = 14
speedTitle.TextXAlignment = Enum.TextXAlignment.Left
speedTitle.Parent = speedContainer

local speedValueLabel = Instance.new("TextLabel")
speedValueLabel.Size = UDim2.new(0, 70, 0, 28)
speedValueLabel.Position = UDim2.new(1, -85, 0, 6)
speedValueLabel.BackgroundTransparency = 1
speedValueLabel.Font = Enum.Font.GothamBold
speedValueLabel.Text = "16"
speedValueLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
speedValueLabel.TextSize = 14
speedValueLabel.TextXAlignment = Enum.TextXAlignment.Right
speedValueLabel.Parent = speedContainer

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0, 35, 0, 26)
speedMinus.Position = UDim2.new(0, 15, 0, 45)
speedMinus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
speedMinus.Font = Enum.Font.GothamBold
speedMinus.Text = "-"
speedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
speedMinus.TextSize = 14
speedMinus.Parent = speedContainer
Instance.new("UICorner", speedMinus).CornerRadius = UDim.new(0, 6)

local speedPlus = Instance.new("TextButton")
speedPlus.Size = UDim2.new(0, 35, 0, 26)
speedPlus.Position = UDim2.new(0, 55, 0, 45)
speedPlus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
speedPlus.Font = Enum.Font.GothamBold
speedPlus.Text = "+"
speedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
speedPlus.TextSize = 14
speedPlus.Parent = speedContainer
Instance.new("UICorner", speedPlus).CornerRadius = UDim.new(0, 6)

local speedReset = Instance.new("TextButton")
speedReset.Size = UDim2.new(0, 80, 0, 26)
speedReset.Position = UDim2.new(0, 98, 0, 45)
speedReset.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
speedReset.Font = Enum.Font.GothamBold
speedReset.Text = "Default"
speedReset.TextColor3 = Color3.fromRGB(150, 150, 160)
speedReset.TextSize = 12
speedReset.Parent = speedContainer
Instance.new("UICorner", speedReset).CornerRadius = UDim.new(0, 6)

speedCard.Parent = scrollContainer

local currentWalkSpeed = 16

local function updateWalkSpeed(val)
	currentWalkSpeed = val
	speedValueLabel.Text = tostring(val)
	local char = player.Character
	if char then
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = currentWalkSpeed
		end
	end
end

speedMinus.MouseButton1Click:Connect(function()
	updateWalkSpeed(math.max(16, currentWalkSpeed - 4))
end)

speedPlus.MouseButton1Click:Connect(function()
	updateWalkSpeed(math.min(200, currentWalkSpeed + 8))
end)

speedReset.MouseButton1Click:Connect(function()
	updateWalkSpeed(16)
end)

--------------------------------------------------------------------------------
-- 4. INFINITE JUMP SYSTEM
--------------------------------------------------------------------------------
local infJumpCard = createFeatureCard("InfJump", 60)
local infJumpContainer = Instance.new("Frame")
infJumpContainer.Size = UDim2.new(1, 0, 1, 0)
infJumpContainer.BackgroundTransparency = 1
infJumpContainer.Parent = infJumpCard

local infJumpTitle = Instance.new("TextLabel")
infJumpTitle.Size = UDim2.new(1, -20, 1, 0)
infJumpTitle.Position = UDim2.new(0, 15, 0, 0)
infJumpTitle.BackgroundTransparency = 1
infJumpTitle.Font = Enum.Font.GothamMedium
infJumpTitle.Text = "Infinite Jump"
infJumpTitle.TextColor3 = Color3.fromRGB(220, 220, 225)
infJumpTitle.TextSize = 14
infJumpTitle.TextXAlignment = Enum.TextXAlignment.Left
infJumpTitle.Parent = infJumpContainer

local infJumpToggleBtn = Instance.new("TextButton")
infJumpToggleBtn.Size = UDim2.new(0, 70, 0, 28)
infJumpToggleBtn.Position = UDim2.new(1, -85, 0.5, -14)
infJumpToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
infJumpToggleBtn.Font = Enum.Font.GothamBold
infJumpToggleBtn.Text = "OFF"
infJumpToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
infJumpToggleBtn.TextSize = 12
infJumpToggleBtn.Parent = infJumpContainer
Instance.new("UICorner", infJumpToggleBtn).CornerRadius = UDim.new(0, 6)

infJumpCard.Parent = scrollContainer

local infJumpEnabled = false

infJumpToggleBtn.MouseButton1Click:Connect(function()
	infJumpEnabled = not infJumpEnabled
	if infJumpEnabled then
		infJumpToggleBtn.Text = "ON"
		infJumpToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		infJumpToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
	else
		infJumpToggleBtn.Text = "OFF"
		infJumpToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
		infJumpToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
	end
end)

UserInputService.JumpRequest:Connect(function()
	if infJumpEnabled and player.Character then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

--------------------------------------------------------------------------------
-- 5. SHIFT LOCK SYSTEM (داخل الواجهة نفسه)
--------------------------------------------------------------------------------
local shiftLockCard = createFeatureCard("ShiftLock", 60)
local shiftLockContainer = Instance.new("Frame")
shiftLockContainer.Size = UDim2.new(1, 0, 1, 0)
shiftLockContainer.BackgroundTransparency = 1
shiftLockContainer.Parent = shiftLockCard

local shiftLockTitle = Instance.new("TextLabel")
shiftLockTitle.Size = UDim2.new(1, -20, 1, 0)
shiftLockTitle.Position = UDim2.new(0, 15, 0, 0)
shiftLockTitle.BackgroundTransparency = 1
shiftLockTitle.Font = Enum.Font.GothamMedium
shiftLockTitle.Text = "Shift Lock"
shiftLockTitle.TextColor3 = Color3.fromRGB(220, 220, 225)
shiftLockTitle.TextSize = 14
shiftLockTitle.TextXAlignment = Enum.TextXAlignment.Left
shiftLockTitle.Parent = shiftLockContainer

local shiftLockToggleBtn = Instance.new("TextButton")
shiftLockToggleBtn.Size = UDim2.new(0, 70, 0, 28)
shiftLockToggleBtn.Position = UDim2.new(1, -85, 0.5, -14)
shiftLockToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
shiftLockToggleBtn.Font = Enum.Font.GothamBold
shiftLockToggleBtn.Text = "OFF"
shiftLockToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
shiftLockToggleBtn.TextSize = 12
shiftLockToggleBtn.Parent = shiftLockContainer
Instance.new("UICorner", shiftLockToggleBtn).CornerRadius = UDim.new(0, 6)

shiftLockCard.Parent = scrollContainer

local shiftLockActive = false

shiftLockToggleBtn.MouseButton1Click:Connect(function()
	shiftLockActive = not shiftLockActive
	if shiftLockActive then
		shiftLockToggleBtn.Text = "ON"
		shiftLockToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		shiftLockToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
	else
		shiftLockToggleBtn.Text = "OFF"
		shiftLockToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
		shiftLockToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
	end
end)

RunService.RenderStepped:Connect(function()
	if shiftLockActive and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.AutoRotate = false
			local camera = workspace.CurrentCamera
			local camVector = camera.CFrame.LookVector
			local root = player.Character.HumanoidRootPart
			local targetLook = Vector3.new(camVector.X, 0, camVector.Z)
			if targetLook.Magnitude > 0 then
				root.CFrame = CFrame.new(root.Position, root.Position + targetLook)
			end
		end
	elseif not shiftLockActive and player.Character then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid and not flying then
			humanoid.AutoRotate = true
		end
	end
end)

--------------------------------------------------------------------------------
-- CHARACTER RESET CLEANUP
--------------------------------------------------------------------------------
player.CharacterAdded:Connect(function(newChar)
	if flying then
		toggleFly(false)
	end
	if shiftLockActive then
		shiftLockActive = false
		shiftLockToggleBtn.Text = "OFF"
		shiftLockToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
		shiftLockToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
	end
	task.wait(0.5)
	local humanoid = newChar:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = currentWalkSpeed
	end
end)

print("Sntero Script loaded successfully!")
