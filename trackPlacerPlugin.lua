local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

-- Create a new toolbar section titled "Custom Script Tools"
local toolbar = plugin:CreateToolbar("Peter's plugins")

-- Add a toolbar button named "trackPlacer"
local newScriptButton = toolbar:CreateButton("Track Placer", "Track Placer", "rbxassetid://4458901886")

-- Make button clickable even if 3D viewport is hidden
newScriptButton.ClickableWhenViewportHidden = true

local UserInputService = game:GetService('UserInputService')
local enabled = false
local mouse = plugin:GetMouse()
local trackName = "forwardTrack"
local lastTrackPositon = Vector3(0,0,0)
local lastTrack = nil

function placeTrack(position: CFrame)
	-- places the track
end

function cloneTrack(trackName)
	-- clones the track for placement
	local track = nil

	for i,v in pairs(workspace:GetChildren()) do -- change to GetDescendants if the track is placed inside of a folder or Model
		if v.Name == trackName then
			track = v
		end
	end

	if track == nil then print("Track placing plugin - Could not find the track with the name: " + trackName) else return track end
end

function showHologram(position: CFrame)
	-- displays the track before placing it
	local track = cloneTrack(trackName)
	lastTrack = track

	-- place track at position
end

function bendTrackLeft()
	-- bends the track more to the left

end

function bendTrackRight()
	-- bends the track more to the right

end

function bendTrackForward()
	-- makes the track go forward

end

function onInputBegan(input, something)
	-- check for keybinds to change track shape and mouse click to place tracks
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.C then
			-- change track to right
			bendTrackRight()
		elseif input.KeyCode == Enum.KeyCode.X then
			-- change track to forward
			bendTrackForward()
		elseif input.KeyCode == Enum.KeyCode.Z then
			-- change track to left
			bendTrackLeft()
		end
	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
		-- place track when click
		placeTrack(mouse.Hit)
	end
end

function getClosestConnector(connectorName: string)
	local closestDistance = math.huge
	local closestConnector = nil

	for i,v in pairs(workspace:GetDescendants()) do
		if v.Name == connectorName then
			local currentDistance = (mouse.Hit.Position - v.CFrame.Position).Magnitude

			-- rewrite the variables until you have the closest connector
			if currentDistance < closestDistance then 
				closestDistance = currentDistance
				closestConnector = v
			end
		end
	end
end

game:GetService('RunService').RenderStepped:Connect(function(deltaTime)
	if enabled then
		-- create holograms while wait for input
		local connector = getClosestConnector("connector")

		-- get position to place hologram
		local position = CFrame.new(0,0,0)

		-- display hologram
		showHologram(position)

		-- refresh every render step
	end
end)

local function onClick()
	if not enabled then
		enabled = true
		print("Track placing plugin - started")
	else
		enabled = false
		print("Track placing plugin - stopped")
	end
end

newScriptButton.Click:Connect(onClick)
UserInputService.InputBegan:Connect(onInputBegan)
