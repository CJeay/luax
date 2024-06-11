repeat task.wait() until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AnthonyIsntHere/anthonysrepository/main/scripts/AntiChatLogger.lua", true))()
wait()

local custom_chars = {
	[" "] = "￰",
	["i"] = "і",
	["e"] = "е",
	["g"] = "g",
	["c"] = "с",
	["o"] = "о",
	["p"] = "р",
	["s"] = "ѕ",
	["u"] = "u",
	["I"] = "Ӏ",
	["E"] = "Е",
	["G"] = "ꓖ",
	["C"] = "С",
	["O"] = "О",
	["P"] = "Р",
	["S"] = "Ѕ",
	["U"] = "𐓎"
}

local default = " ိ"

game.StarterGui:SetCore("SendNotification", {
	Title = "Swear Bot";
	Text = "LMAO";
	Duration = 3;
})

local Players = game:GetService('Players')

local list = {
	'pussy',
	'nigger',
	'fuck',
	'shit'
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
			local newMessage = list[math.random(1,#list)]
			for i,v in pairs(custom_chars) do
				local rep = string.gsub(newMessage, i, v .. "⁥")
				newMessage = rep
			end
			newMessage = "FAG￰" .. newMessage .. default

			chatMessage(newMessage)
		end
	end)
	
else
	
	for i, v in pairs(Players:GetChildren()) do
		v.Chatted:Connect(function(message)
			if message == '.cuss' then
				local newMessage = list[math.random(1,#list)]
				for i,v in pairs(custom_chars) do
					local rep = string.gsub(newMessage, i, v .. "⁥")
					newMessage = rep
				end
				newMessage = "FAG￰" .. newMessage .. default

				chatMessage(newMessage)
			end
		end)
	end
	
end

chatMessage('I am the cuss bot! say .cuss for me to cuss!')
