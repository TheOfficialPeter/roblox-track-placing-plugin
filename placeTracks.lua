local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

-- Create a new toolbar section titled "Custom Script Tools"
local toolbar = plugin:CreateToolbar("Peter's plugins")

-- Add a toolbar button named "trackPlacer"
local newScriptButton = toolbar:CreateButton("Track Placer", "Track Placer", "rbxassetid://4458901886")

-- Make button clickable even if 3D viewport is hidden
newScriptButton.ClickableWhenViewportHidden = true

local closestDistance = math.huge
local currentTrack = "forwardTrack"
local closestConnector = nil
local UserInputService = game:GetService("UserInputService")
local enabled = false
local mouse = game.Players.LocalPlayer:GetMouse()

game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
	if enabled then
		
		-- get the closest track end to the mouse
		for _,part in pairs(game.Workspace:GetDescendants()) do
			if part.Name == "trackConnector" then
				local distance = (mouse.Hit.Position - part.CFrame.Position).Magnitude
				if distance < closestDistance then
					closestConnector = part
					closestDistance = distance
				end
			end
		end
		
		-- check if there was a track connector on the map
		if closestConnector ~= nil then
			
		end
	end
end)

local function onInputBegan(input, _gameProcessed)
	if enabled then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.C then
				currentTrack = "rightTrack"
			elseif input.KeyCode == Enum.KeyCode.Z then
				currentTrack = "leftTrack"
			elseif input.KeyCode == Enum.KeyCode.X then
				currentTrack = "forwardTrack"
			end
		elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
			-- check if everything is ready and then place the track
		end
	end
end

UserInputService.InputBegan:Connect(onInputBegan)

local function onNewScriptButtonClicked()
	enabled = not enabled
	
	if enabled then
		print('started track placing!')
	else
		print("track placing stopped!")
	end
end

newScriptButton.Click:Connect(onNewScriptButtonClicked)
