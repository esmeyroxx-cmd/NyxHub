--// NYX SCRIPT HUB - VERSION FINALE CORRIGÉE (Fly, Speed, Jump, ESP, Noclip, Godmode) //--
--// Créateur : Nyx_122 //--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Nettoyage si le hub est déjà ouvert
if playerGui:FindFirstChild("NyxHub_Universal") then
	playerGui.NyxHub_Universal:Destroy()
end

-- Création du ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NyxHub_Universal"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Fenêtre principale (Design sombre & rouge Nyx)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 390)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -195)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(180, 30, 45)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Barre de titre
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -50, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "👑 NYX HUB | Universal Script Hub"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Bouton Fermer (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 45)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Corps de la fenêtre (ScrollingFrame)
local container = Instance.new("ScrollingFrame")
container.Size = UDim2.new(1, -20, 1, -55)
container.Position = UDim2.new(0, 10, 0, 48)
container.BackgroundTransparency = 1
container.ScrollBarThickness = 4
container.ScrollBarImageColor3 = Color3.fromRGB(180, 30, 45)
container.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = container

listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end)

--// FONCTION TOGGLE (ON/OFF) //--
local function addToggle(name, desc, callback)
	local state = false
	
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, -6, 0, 50)
	card.BackgroundColor3 = Color3.fromRGB(25, 25, 36)
	card.BorderSizePixel = 0
	card.Parent = container
	
	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 8)
	cardCorner.Parent = card
	
	local tLabel = Instance.new("TextLabel")
	tLabel.Size = UDim2.new(1, -80, 0, 22)
	tLabel.Position = UDim2.new(0, 12, 0, 5)
	tLabel.BackgroundTransparency = 1
	tLabel.Text = name
	tLabel.TextColor3 = Color3.new(1, 1, 1)
	tLabel.Font = Enum.Font.GothamBold
	tLabel.TextSize = 14
	tLabel.TextXAlignment = Enum.TextXAlignment.Left
	tLabel.Parent = card
	
	local dLabel = Instance.new("TextLabel")
	dLabel.Size = UDim2.new(1, -80, 0, 18)
	dLabel.Position = UDim2.new(0, 12, 0, 26)
	dLabel.BackgroundTransparency = 1
	dLabel.Text = desc
	dLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
	dLabel.Font = Enum.Font.Gotham
	dLabel.TextSize = 11
	dLabel.TextXAlignment = Enum.TextXAlignment.Left
	dLabel.Parent = card
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 55, 0, 28)
	btn.Position = UDim2.new(1, -65, 0.5, -14)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
	btn.Text = "OFF"
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 12
	btn.Parent = card
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = btn
	
	btn.MouseButton1Click:Connect(function()
		state = not state
		if state then
			btn.BackgroundColor3 = Color3.fromRGB(180, 30, 45)
			btn.Text = "ON"
		else
			btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
			btn.Text = "OFF"
		end
		callback(state)
	end)
end

--// FONCTION SLIDER //--
local function addSlider(name, minVal, maxVal, defaultVal, callback)
	local currentVal = defaultVal
	local dragging = false
	
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, -6, 0, 62)
	card.BackgroundColor3 = Color3.fromRGB(25, 25, 36)
	card.BorderSizePixel = 0
	card.Parent = container
	
	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 8)
	cardCorner.Parent = card
	
	local tLabel = Instance.new("TextLabel")
	tLabel.Size = UDim2.new(1, -80, 0, 22)
	tLabel.Position = UDim2.new(0, 12, 0, 6)
	tLabel.BackgroundTransparency = 1
	tLabel.Text = name
	tLabel.TextColor3 = Color3.new(1, 1, 1)
	tLabel.Font = Enum.Font.GothamBold
	tLabel.TextSize = 14
	tLabel.TextXAlignment = Enum.TextXAlignment.Left
	tLabel.Parent = card
	
	local valLabel = Instance.new("TextLabel")
	valLabel.Size = UDim2.new(0, 50, 0, 22)
	valLabel.Position = UDim2.new(1, -62, 0, 6)
	valLabel.BackgroundTransparency = 1
	valLabel.Text = tostring(defaultVal)
	valLabel.TextColor3 = Color3.fromRGB(220, 50, 65)
	valLabel.Font = Enum.Font.GothamBold
	valLabel.TextSize = 14
	valLabel.TextXAlignment = Enum.TextXAlignment.Right
	valLabel.Parent = card
	
	local track = Instance.new("TextButton")
	track.Size = UDim2.new(1, -24, 0, 8)
	track.Position = UDim2.new(0, 12, 0, 38)
	track.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
	track.Text = ""
	track.AutoButtonColor = false
	track.Parent = card
	
	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track
	
	local fill = Instance.new("Frame")
	local startPercent = (defaultVal - minVal) / (maxVal - minVal)
	fill.Size = UDim2.new(startPercent, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(180, 30, 45)
	fill.BorderSizePixel = 0
	fill.Parent = track
	
	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill
	
	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 16, 0, 16)
	knob.Position = UDim2.new(1, -8, 0.5, -8)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.Parent = fill
	
	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob
	
	local function updateSlider(input)
		local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		fill.Size = UDim2.new(pos, 0, 1, 0)
		currentVal = math.floor(minVal + ((maxVal - minVal) * pos))
		valLabel.Text = tostring(currentVal)
		callback(currentVal)
	end
	
	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			mainFrame.Draggable = false
			updateSlider(input)
		end
	end)
	
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			mainFrame.Draggable = true
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			updateSlider(input)
		end
	end)
end

--// MODULES //--

-- 1. WalkSpeed Slider
addSlider("⚡ WalkSpeed (Vitesse)", 16, 250, 16, function(val)
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = val end
end)

-- 2. JumpPower Slider
addSlider("🦘 JumpPower (Saut)", 50, 300, 50, function(val)
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.UseJumpPower = true
		hum.JumpPower = val
	end
end)

-- 3. NOCLIP
local noclipEnabled = false
RunService.Stepped:Connect(function()
	if noclipEnabled and player.Character then
		for _, part in ipairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

addToggle("👻 Noclip", "Traverser les murs et les objets", function(enabled)
	noclipEnabled = enabled
end)

-- 4. GODMODE (Anti-mort / Reset des dégâts)
local godmodeEnabled = false
RunService.Heartbeat:Connect(function()
	if godmodeEnabled and player.Character then
		local hum = player.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.Health = hum.MaxHealth
		end
	end
end)

addToggle("🛡️ Godmode", "Invincibilité (vie toujours pleine)", function(enabled)
	godmodeEnabled = enabled
end)

-- 5. FLY MODE
local flying = false
local flySpeed = 50
local bodyGyro, bodyVel

addToggle("✈️ Fly Mode", "Permet de voler librement", function(enabled)
	flying = enabled
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	
	if flying and hrp and hum then
		hum.PlatformStand = true
		bodyGyro = Instance.new("BodyGyro")
		bodyGyro.P = 9e4
		bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.CFrame = hrp.CFrame
		bodyGyro.Parent = hrp
		
		bodyVel = Instance.new("BodyVelocity")
		bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		bodyVel.Velocity = Vector3.zero
		bodyVel.Parent = hrp
	else
		if bodyGyro then bodyGyro:Destroy() end
		if bodyVel then bodyVel:Destroy() end
		if hum then hum.PlatformStand = false end
	end
end)

RunService.RenderStepped:Connect(function()
	if flying and bodyGyro and bodyVel then
		local cam = workspace.CurrentCamera
		local moveDir = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0, 1, 0) end
		
		bodyGyro.CFrame = cam.CFrame
		bodyVel.Velocity = moveDir * flySpeed
	end
end)

-- 6. ESP
local espEnabled = false
local function updateESP()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local h = p.Character:FindFirstChild("NyxESPBox")
			if espEnabled then
				if not h then
					local hl = Instance.new("Highlight")
					hl.Name = "NyxESPBox"
					hl.FillColor = Color3.fromRGB(200, 30, 45)
					hl.OutlineColor = Color3.new(1, 1, 1)
					hl.FillTransparency = 0.5
					hl.Parent = p.Character
				end
			else
				if h then h:Destroy() end
			end
		end
	end
end

addToggle("👁️ Player ESP", "Voir les joueurs à travers les murs", function(enabled)
	espEnabled = enabled
	updateESP()
end)
