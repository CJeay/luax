game.StarterGui:SetCore("SendNotification", {
	Title = "Bot";
	Text = "LMAO";
	Duration = 3;
})

local Players = game:GetService('Players')

local TextChatService = game:GetService('TextChatService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

currentlyfollowing = nil

task.spawn(function()
	if currentlyfollowing then
		local PathfindingService = game:GetService("PathfindingService")
		local Path = PathfindingService:CreatePath({
			AgentRadius = 3,
			AgentHeight = 6,
			AgentCanJump = true,
			Costs = {
				Water = 20
			}
		})

		while true do
			local playerRoot = currentlyfollowing.Character:FindFirstChild("HumanoidRootPart")
				if playerRoot then
					Path:ComputeAsync(script.Parent.HumanoidRootPart.Position, playerRoot.Position)
					local Waypoints = Path:GetWaypoints()

					for _, waypoint in pairs(Waypoints) do
						if waypoint.Action == Enum.HumanoidStateType.Jumping then
							script.Parent.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						end
						script.Parent.Humanoid:MoveTo(waypoint.Position)
					end

					script.Parent.Humanoid.MoveToFinished:Wait()
				end
			task.wait(1)
		end
	end
end)

function chatMessage(str)
	str = tostring(str)
	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		TextChatService.TextChannels.RBXGeneral:SendAsync(str)
	else
		ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(str, "All")
	end
end

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
	
	TextChatService.MessageReceived:Connect(function(message)
		local split = message.Text:split(" ")
		if split[1] == '.follow' then
			chatMessage('Following '..split[2])
			currentlyfollowing = Players[split[2]]
		end
	end)
	
else
	
	game.Players.LocalPlayer.Chatted:Connect(function(message)
		local split = message:split(" ")
		if split[1] == '.follow' then
			chatMessage('Following '..split[2])
			currentlyfollowing = Players[split[2]]
		end
	end)
	
end
