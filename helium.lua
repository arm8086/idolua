if game:GetService("RunService"):IsStudio() then owner = game:GetService("Players").PlayerAdded:Wait() end
local qreq = require
local function require(ik)
	local u = "https://raw.githubusercontent.com/arm8086/hydrogen/main/utils/%s"
	if type(ik) ~= "string" then
		return qreq(ik)
	end
	return loadstring(game:GetService("HttpService"):GetAsync(u:format(ik)))
end

local bmh

if game:GetService("RunService"):IsStudio() then
	bmh = require(script.bmh)
	NLS = require(script.nls)
else
	bmh = require("BodyMoverHelper.lua")
end

owner.CharacterAppearanceLoaded:Wait()

local c = Instance.new("Part")
c.Anchored = true
c.CanCollide = false
c.Transparency = 1
c.CanQuery = false
c.Size = Vector3.new(9.6, 5.4, 0.1)

g = Instance.new("SurfaceGui")
g.Adornee = c
g.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
g.CanvasSize = Vector2.new(640, 480)
g.Parent = script

c.Parent = script

function _detect()
	local m = Instance.new("Frame")
	m.BackgroundTransparency = 1
	m.Size = UDim2.fromScale(1, 1)
	m.Name = "_movement"
	m.Parent = g
end

function new(s, a)
	local q = Instance.new(s)
	for i, v in a do
		q[i] = v
	end
	return q
end

function idg()
	return game:GetService("HttpService"):GenerateGUID()
end

-- heFAT functions

_volumes = {}

function NewVolume(TotalSizeNum)
	local vol = {
		id = idg(),
		size = TotalSizeNum,
		_partitions = {}
	}
	table.insert(_volumes, vol)
	return vol.id
end

function NewPartition(Volume, Name)
	local part = {
		fname = Name,
		id = idg(),
		_files = {}
	}
	table.insert(Volume, part)
end

Mouse = {Position = Vector2.new()}

local osrom = [[
local output = new("TextBox", {
Size = UDim2.fromScale(1,1),
BackgroundColor3 = Color3.new(),
Font = Enum.Font.RobotoMono,
TextSize = 15,
TextColor3 = Color3.new(1,1,1),
Text = "",
TextXAlignment = "Left",
TextYAlignment = "Top"
})
local linecount = g.CanvasSize.Y/15
local lines = {}
output.Parent = g
local function puts(s)
	table.insert(lines, s)
	if #lines > linecount then
		table.remove(lines, 1)
	end
	output.Text = table.concat(lines, "\n")
end
for i = 1, 200 do
	puts(math.random())
	task.wait(0.1)
end
]]

local mc = Instance.new("RemoteEvent", owner.PlayerGui)
mc.Name = idg()

function loadrom()
	g:ClearAllChildren()
	_detect()
	mc:FireClient(owner, 0, g._movement)
	g.CanvasSize = Vector2.new(640, 480)
	loadstring(osrom)()
end

bmh:HookPart(c, CFrame.new(0, 1.5, -4) * CFrame.Angles(0, math.pi, 0), owner)

NLS([[
local r = script.Parent
local m = owner:GetMouse()
local movement
local movc
function mf(x, y)
	r:FireServer(x, y)
end
r.OnClientEvent:Connect(function(n, q)
	if n == 0 then
		movement = q
		movc = movement.MouseMoved:Connect(mf)
	end
end)
]], mc)

mc.OnServerEvent:Connect(function(_, x, y)
	Mouse.Position = Vector2.new(x, y)
end)

loadrom()
