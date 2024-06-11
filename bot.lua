game.StarterGui:SetCore("SendNotification", {
	Title = "Swear Bot";
	Text = "LMAO";
	Duration = 3;
})

local Players = game:GetService('Players')

local list = {
	'FAG￰рuѕѕy',
	'FAG￰nіggеr',
	'FAG￰fuсk',
	'FAG￰ѕhіt'
}

local TextChatService = game:GetService('TextChatService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

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
		if message == '.cuss' then
			chatMessage(list[math.random(1,#list)])
		end
	end)
	
else
	
	for i, v in pairs(Players:GetChildren()) do
		v.Chatted:Connect(function(message)
			if message == '.cuss' then
				chatMessage(list[math.random(1,#list)])
			end
		end)
	end
	
end
