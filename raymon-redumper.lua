NLS([[
print('Raymond\'s PlayerGui Dumper (V3)!!')
print('Use %dump:list for a list of all PlayerGuis')
print('Use %dump:all for a dump of all PlayerGuis')
print('Use %dump:focus:<playergui names> for a dump of specific PlayerGuis')

function ShowData(Gui, ShowDescendants)
	print(Gui.Name, Gui.ClassName, (ShowDescendants and "(".. #Gui:GetDescendants() .. " descendants)" or ""))
end

local TextData = {}
function Dump(Gui, Path, Header)
	local _Path = Path
	if #TextData >= 20 then
		print(table.concat(TextData, '\n '))
		TextData = {}
	end
	if Gui.Parent == owner.PlayerGui then
		_Path = "\n ### "..Gui.Name.." ### \n\n" .. _Path
	end
	table.insert(TextData, table.concat({_Path, Gui.ClassName, (ShowDescendants and "(".. #Gui:GetDescendants() .. " descendants)" or "")},  " "))
	for _, Descendant in pairs(Gui:GetChildren()) do
		_Path = Path .. '/'..Descendant.Name
		Dump(Descendant, _Path, false)
	end
end

owner.Chatted:Connect(function(message)
	if message:sub(1, #'%dump'):lower() == '%dump' then
		if message:sub(#'%dump'+1, #'%dump'+ 1 + #':list'):lower() == ':list' then
			for _, PlayerGui in pairs(owner.PlayerGui:GetChildren()) do
				if PlayerGui:IsA('ScreenGui') then ShowData(PlayerGui, true) end
			end
		elseif message:sub(#'%dump'+1, #'%dump'+ 1 + #':all'):lower() == ':all' then
			for _, PlayerGui in pairs(owner.PlayerGui:GetChildren()) do
				if PlayerGui:IsA('ScreenGui') then
					Dump(PlayerGui, '~/'..PlayerGui.Name, true)
				end
			end
			print(table.concat(TextData, '\n '))
			TextData = {}
		elseif message:sub(#'%dump'+1, #'%dump' + #':focus:'):lower() == ':focus:' then
			if owner.PlayerGui:FindFirstChild(message:sub(#'%dump'+ 1 + #':focus:')) then
				local Gui = owner.PlayerGui:FindFirstChild(message:sub(#'%dump'+ 1 + #':focus:'))
				Dump(Gui, '~/'..Gui.Name, true)
			end
			print(table.concat(TextData, '\n '))
			TextData = {}
		end
	end
end)
]], owner.PlayerGui)
