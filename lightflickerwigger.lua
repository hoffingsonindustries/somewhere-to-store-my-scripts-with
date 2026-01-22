local collectionService = game:GetService("CollectionService")
local sound = game.SoundService.light_flicker_02
local replicatedStorage = game:GetService("ReplicatedStorage")
local textFunction = replicatedStorage:FindFirstChild("TextFunction")

local timeLimit = 5
--if you're somebody who can't script then let me just explain this, this is how long each lights flicker will go for before immediately going back to normal.
-- me me! i can't script, i get the dirty clanka to do it - superbilly



local function lightFlicker(part, light)
	local flickerTime = math.random(1,14)
	local flickerCount = math.random(13, 21)
	print(flickerTime, flickerCount)
	local offOnTime = flickerTime / flickerCount
	local currentTime = os.time()

	if part:IsA("BasePart") and light:IsA("PointLight") then
		local newSound = sound:Clone()
		for i=1, flickerCount do
			if (os.time() - currentTime) >= timeLimit then
				light.Enabled = true
				part.Color = Color3.fromRGB(255, 255, 255)
			else
				newSound.PlaybackSpeed = 1
				newSound.Volume = 0.02
				newSound.Parent = game.SoundService
				part.Color = Color3.fromRGB(0, 0, 0)
				light.Enabled = false
				newSound:Play()
				task.wait(offOnTime)
				part.Color = Color3.fromRGB(255, 255, 255)
				light.Enabled = true
				newSound:Play()
				task.wait(offOnTime)
				newSound:Stop()
				newSound.PlaybackSpeed += 0.1
			end
		end
	end
end

local function lightFlickerAll()
	textFunction:FireAllClients("How weird, it appears that the lights are malfunctioning... but why?")

	for i, model in collectionService:GetTagged("Light") do
		for i, part in model:GetChildren() do
			local light = part:FindFirstChildOfClass("PointLight")
			
			coroutine.wrap(lightFlicker)(part, light)
		end
	end
end

--[[for i, model in collectionService:GetTagged("Light") do
	for i, part in model:GetChildren() do
		local light = part:FindFirstChildOfClass("PointLight")

		coroutine.wrap(lightFlicker)(part, light)
this is diabolical
	end
end]]--

workspace["Value Triggers"]["To be blinded is the pain of flickers."].Changed:Connect(lightFlickerAll)
