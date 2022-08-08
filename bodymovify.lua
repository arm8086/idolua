local inf = {...}
local part = inf[1]
local offsetCF = inf[2]
local r = Instance.new("RemoteFunction", owner.PlayerGui)
r.Name = game:GetService("HttpService"):GenerateGUID(false)
NLS([[
local r = script.Parent
local part = r:InvokeServer("p")
print(part)
local pos = Instance.new("BodyPosition", part)
local rot = Instance.new("BodyGyro", part)
rot.P = 4500
rot.MaxTorque = Vector3.new(1, 1, 1) * math.huge
rot.D = 350
pos.D = 350
pos.MaxForce = Vector3.new(1, 1, 1) * math.huge
pos.P = 4500
local plr = game:service'Players'.LocalPlayer
local mouse = plr:GetMouse()
local chr = plr.Character
plr.CharacterAdded:Connect(function(char)
	chr = char
end)
local sine = 0
local offsetCF = r:InvokeServer("o")
game:service'RunService'.RenderStepped:Connect(function()
	local yo = chr.HumanoidRootPart.CFrame * offsetCF
	pos.Position = yo.Position
	rot.CFrame = yo
end)
]], r)
r.OnServerInvoke = function(plr, x)
	if x == "p" then
		part.Anchored = false
		part:SetNetworkOwner(owner)
		part.CanCollide = false
		return part
	elseif x == "o" then
		return offsetCF
	end
end
