--wsandjp.lua - A script you can use in chat to change walk speed (ws) and jump power (jp). Use /walkspeed (number) to change your walk speed to that number, and the same for /jumppower

local player = game.Players.LocalPlayer
local textChatService = game:GetService("TextChatService")

local function handleCommand(msg)
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local jpValue = string.match(msg, "^/jumppower%s+(%d+)$")
	if jpValue then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = tonumber(jpValue)
		return
	end

	local wsValue = string.match(msg, "^/walkspeed%s+([%d%.]+)$")
	if wsValue then
		humanoid.WalkSpeed = tonumber(wsValue)
		return
	end

	if msg == "/reset" then
		humanoid.JumpPower = 50
		humanoid.WalkSpeed = 16
	end
end

player.Chatted:Connect(handleCommand)

textChatService.OnIncomingMessage = function(msg)
	if msg.TextSource and msg.TextSource.UserId == player.UserId then
		handleCommand(msg.Text)
	end
end
