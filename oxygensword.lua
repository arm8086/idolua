local char = owner.Character
game:GetService("ContentProvider"):PreloadAsync({"rbxassetid://9085027122"})
local hum = char.Humanoid
local hrp = char.HumanoidRootPart
local rj = char:FindFirstChild("RootJoint",true)
local lh = char:FindFirstChild("Left Hip",true)
local rh = char:FindFirstChild("Right Hip",true)
local ls = char:FindFirstChild("Left Shoulder",true)
local rs = char:FindFirstChild("Right Shoulder",true)
local n = char:FindFirstChild("Neck",true)
local defaults = {}
local rj2 = Instance.new("Weld", rj.Parent)
rj2.C0 = rj.C0
rj2.C1 = rj.C1
rj2.Part0 = rj.Part0
rj2.Part1 = rj.Part1
defaults.rj = rj.C0
rj2.Enabled = false
local lh2 = Instance.new("Weld", lh.Parent)
lh2.C0 = lh.C0
lh2.C1 = lh.C1
lh2.Part0 = lh.Part0
lh2.Part1 = lh.Part1
defaults.lh = lh.C0
lh2.Enabled = false
local rh2 = Instance.new("Weld", rh.Parent)
rh2.C0 = rh.C0
rh2.C1 = rh.C1
rh2.Part0 = rh.Part0
rh2.Part1 = rh.Part1
defaults.rh = rh.C0
rh2.Enabled = false
local ls2 = Instance.new("Weld", ls.Parent)
ls2.C0 = ls.C0
ls2.C1 = ls.C1
ls2.Part0 = ls.Part0
ls2.Part1 = ls.Part1
defaults.ls = ls.C0
ls2.Enabled = false
local rs2 = Instance.new("Weld", rs.Parent)
rs2.C0 = rs.C0
rs2.C1 = rs.C1
rs2.Part0 = rs.Part0
rs2.Part1 = rs.Part1
defaults.rs = rs.C0
rs2.Enabled = false
local n2 = Instance.new("Weld", n.Parent)
n2.C0 = n.C0
n2.C1 = rs.C1
n2.Part0 = n.Part0
n2.Part1 = n.Part1
defaults.n = n.C0
n2.Enabled = false
local swor
do
	swor = Instance.new("Model")
	swor.Name = "swor"
	local Handle = Instance.new("Part")
	Handle.Name = "Handle"
	Handle.BottomSurface = Enum.SurfaceType.Smooth
	Handle.Transparency = 0.5
	Handle.TopSurface = Enum.SurfaceType.Smooth
	Handle.Color = Color3.fromRGB(248, 248, 248)
	Handle.Massless = true
	Handle.Material = Enum.Material.Glass
	Handle.Size = Vector3.new(0.8063358664512634, 0.25112399458885193, 0.13146372139453888)
	Handle.CFrame = CFrame.new(69.59683227539062, 10.36324691772461, 34.67070007324219, 0.12940949201583862, 0.9910221099853516, 0.0334937646985054, 0.8660253286361694, -0.12940911948680878, 0.48296260833740234, 0.4829627275466919, -0.03349338471889496, -0.8749998211860657)
	Handle.Shape = Enum.PartType.Cylinder
	Handle.Parent = swor
	local Weld = Instance.new("Weld")
	Weld.C0 = CFrame.new(0.37488460540771484, 0, 0)
	Weld.Parent = Handle
	local hand = Instance.new("Model")
	hand.Name = "hand"
	hand.WorldPivot = CFrame.new(65.87125396728516, 0.719139575958252, 36.77458190917969)
	hand.Parent = swor
	local Part = Instance.new("Part")
	Part.BottomSurface = Enum.SurfaceType.Smooth
	Part.Transparency = 0.5
	Part.TopSurface = Enum.SurfaceType.Smooth
	Part.Color = Color3.fromRGB(248, 248, 248)
	Part.Massless = true
	Part.Material = Enum.Material.Glass
	Part.Size = Vector3.new(0.10816439986228943, 0.25112399458885193, 0.17999999225139618)
	Part.CFrame = CFrame.new(69.64534759521484, 10.687906265258789, 34.85175704956055, 0.12940949201583862, 0.9910221099853516, 0.0334937646985054, 0.8660253286361694, -0.12940911948680878, 0.48296260833740234, 0.4829627275466919, -0.03349338471889496, -0.8749998211860657)
	Part.Shape = Enum.PartType.Cylinder
	Part.Parent = hand
	local Weld1 = Instance.new("Weld")
	Weld1.C0 = CFrame.new(-0.9454166889190674, -0.00262451171875, -0.0936279296875, 0, 0, 1, -1, 0, 0, 0, -1, 0)
	Weld1.Parent = Part
	local Wedge = Instance.new("WedgePart")
	Wedge.BottomSurface = Enum.SurfaceType.Smooth
	Wedge.Transparency = 0.5
	Wedge.Color = Color3.fromRGB(248, 248, 248)
	Wedge.Massless = true
	Wedge.Material = Enum.Material.Glass
	Wedge.Size = Vector3.new(0.24899999797344208, 0.1899999976158142, 0.210999995470047)
	Wedge.CFrame = CFrame.new(69.51726531982422, 9.824272155761719, 34.477169036865234, -0.9910221099853516, -0.0334937646985054, 0.12940949201583862, 0.12940911948680878, -0.48296260833740234, 0.8660253286361694, 0.03349338471889496, 0.8749998211860657, 0.4829627275466919)
	Wedge.Parent = hand
	local Weld2 = Instance.new("Weld")
	Weld2.C0 = CFrame.new(0, -0.19000244140625, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1)
	Weld2.Parent = Wedge
	local Wedge1 = Instance.new("WedgePart")
	Wedge1.BottomSurface = Enum.SurfaceType.Smooth
	Wedge1.Transparency = 0.5
	Wedge1.Color = Color3.fromRGB(248, 248, 248)
	Wedge1.Massless = true
	Wedge1.Material = Enum.Material.Glass
	Wedge1.Size = Vector3.new(0.24899999797344208, 0.1899999976158142, 0.210999995470047)
	Wedge1.CFrame = CFrame.new(69.52362823486328, 9.916036605834961, 34.310916900634766, 0.9910221099853516, 0.0334937646985054, 0.12940949201583862, -0.12940911948680878, 0.48296260833740234, 0.8660253286361694, -0.03349338471889496, -0.8749998211860657, 0.4829627275466919)
	Wedge1.Parent = hand
	local Weld3 = Instance.new("Weld")
	Weld3.C0 = CFrame.new(0, -0.00006103515625, 0.21054410934448242, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	Weld3.Parent = Wedge1
	local Wedge2 = Instance.new("WedgePart")
	Wedge2.BottomSurface = Enum.SurfaceType.Smooth
	Wedge2.Transparency = 0.5
	Wedge2.Color = Color3.fromRGB(248, 248, 248)
	Wedge2.Massless = true
	Wedge2.Material = Enum.Material.Glass
	Wedge2.Size = Vector3.new(0.24873891472816467, 0.1899999976158142, 0.21137572824954987)
	Wedge2.CFrame = CFrame.new(69.55087280273438, 10.098343849182129, 34.412654876708984, -0.9910221099853516, 0.0334937646985054, -0.12940949201583862, 0.12940911948680878, 0.48296260833740234, -0.8660253286361694, 0.03349338471889496, -0.8749998211860657, -0.4829627275466919)
	Wedge2.Parent = hand
	local Weld4 = Instance.new("Weld")
	Weld4.C0 = CFrame.new(0, -0.19000244140625, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1)
	Weld4.Parent = Wedge2
	local Wedge3 = Instance.new("WedgePart")
	Wedge3.BottomSurface = Enum.SurfaceType.Smooth
	Wedge3.Transparency = 0.5
	Wedge3.Color = Color3.fromRGB(248, 248, 248)
	Wedge3.Massless = true
	Wedge3.Material = Enum.Material.Glass
	Wedge3.Size = Vector3.new(0.24899999797344208, 0.1899999976158142, 0.210999995470047)
	Wedge3.CFrame = CFrame.new(69.54450988769531, 10.006579399108887, 34.57890701293945, 0.9910221099853516, -0.0334937646985054, -0.12940949201583862, -0.12940911948680878, -0.48296260833740234, -0.8660253286361694, -0.03349338471889496, 0.8749998211860657, -0.4829627275466919)
	Wedge3.Parent = hand
	local Weld5 = Instance.new("Weld")
	Weld5.C0 = CFrame.new(0.00262451171875, -0.09368896484375, -0.05416131019592285, 0, 1, 0, 0, 0, -1, -1, 0, 0)
	Weld5.Parent = Wedge3
	local Part1 = Instance.new("Part")
	Part1.BottomSurface = Enum.SurfaceType.Smooth
	Part1.Transparency = 0.5
	Part1.TopSurface = Enum.SurfaceType.Smooth
	Part1.Color = Color3.fromRGB(248, 248, 248)
	Part1.Massless = true
	Part1.Material = Enum.Material.Glass
	Part1.Size = Vector3.new(0.19468232989311218, 0.25112399458885193, 0.17999999225139618)
	Part1.CFrame = CFrame.new(69.55725860595703, 10.098393440246582, 34.52299880981445, 0.12940949201583862, 0.9910221099853516, 0.0334937646985054, 0.8660253286361694, -0.12940911948680878, 0.48296260833740234, 0.4829627275466919, -0.03349338471889496, -0.8749998211860657)
	Part1.Shape = Enum.PartType.Cylinder
	Part1.Parent = hand
	local Weld6 = Instance.new("Weld")
	Weld6.C0 = CFrame.new(0.8861551284790039, -0.00213623046875, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1)
	Weld6.Parent = Part1
	local Part2 = Instance.new("Part")
	Part2.BottomSurface = Enum.SurfaceType.Smooth
	Part2.Transparency = 0.5
	Part2.TopSurface = Enum.SurfaceType.Smooth
	Part2.Color = Color3.fromRGB(248, 248, 248)
	Part2.Massless = true
	Part2.Material = Enum.Material.Glass
	Part2.Size = Vector3.new(0.23999999463558197, 0.2848477065563202, 0.29314547777175903)
	Part2.CFrame = CFrame.new(69.66981506347656, 10.86610221862793, 34.9510498046875, -0.9910221099853516, 0.12940949201583862, 0.0334937646985054, 0.12940911948680878, 0.8660253286361694, 0.48296260833740234, 0.03349338471889496, 0.4829627275466919, -0.8749998211860657)
	Part2.Shape = Enum.PartType.Cylinder
	Part2.Parent = hand
	local Weld7 = Instance.new("Weld")
	Weld7.C0 = CFrame.new(-0.001953125, 0.11198043823242188, -0.00048828125, 0, 0, -1, 0, 1, 0, 1, 0, 0)
	Weld7.Parent = Part2
	local Part3 = Instance.new("Part")
	Part3.BottomSurface = Enum.SurfaceType.Smooth
	Part3.Transparency = 0.5
	Part3.TopSurface = Enum.SurfaceType.Smooth
	Part3.Color = Color3.fromRGB(248, 248, 248)
	Part3.Massless = true
	Part3.Material = Enum.Material.Glass
	Part3.Size = Vector3.new(0.3624950647354126, 0.13987745344638824, 0.11367270350456238)
	Part3.CFrame = CFrame.new(69.68622589111328, 10.962591171264648, 35.0054931640625, 0.0334937646985054, 0.12940949201583862, 0.9910221099853516, 0.48296260833740234, 0.8660253286361694, -0.12940911948680878, -0.8749998211860657, 0.4829627275466919, -0.03349338471889496)
	Part3.Parent = hand
	local Weld8 = Instance.new("Weld")
	Weld8.C0 = CFrame.new(0.39697265625, -0.14198541641235352, 0.0012207030085846782, 0, 0, -1, 0, -1, 0, -0.9999999403953552, 0, 0)
	Weld8.Parent = Part3
	local Wedge4 = Instance.new("WedgePart")
	Wedge4.BottomSurface = Enum.SurfaceType.Smooth
	Wedge4.Transparency = 0.5
	Wedge4.Color = Color3.fromRGB(248, 248, 248)
	Wedge4.Massless = true
	Wedge4.Material = Enum.Material.Glass
	Wedge4.Size = Vector3.new(0.19997842609882355, 0.1940777748823166, 0.4599999785423279)
	Wedge4.CFrame = CFrame.new(69.68235778808594, 11.031192779541016, 34.58952713012695, -0.9910220503807068, -0.12940949201583862, -0.0334937646985054, 0.12940910458564758, -0.8660253286361694, -0.48296260833740234, 0.03349338099360466, -0.4829627275466919, 0.8749998211860657)
	Wedge4.Parent = hand
	local Weld9 = Instance.new("Weld")
	Weld9.C0 = CFrame.new(0.0012207030085846782, 0.0006279945373535156, 0.39697265625, 0, 0, -0.9999999403953552, 0, -1, 0, -1, 0, 0)
	Weld9.Parent = Wedge4
	local Part4 = Instance.new("Part")
	Part4.BottomSurface = Enum.SurfaceType.Smooth
	Part4.Transparency = 0.5
	Part4.TopSurface = Enum.SurfaceType.Smooth
	Part4.Color = Color3.fromRGB(248, 248, 248)
	Part4.Massless = true
	Part4.Material = Enum.Material.Glass
	Part4.Size = Vector3.new(0.3854983448982239, 0.2414352148771286, 0.24545669555664062)
	Part4.CFrame = CFrame.new(69.66777038574219, 10.839083671569824, 34.936614990234375, 0.0334937646985054, 0.12940949201583862, 0.991021990776062, 0.48296260833740234, 0.8660253286361694, -0.1294090896844864, -0.8749998211860657, 0.4829627275466919, -0.03349337726831436)
	Part4.Parent = hand
	local Weld10 = Instance.new("Weld")
	Weld10.C0 = CFrame.new(0.6719970703125, 0.11104321479797363, 0.0012207030085846782, 0, 0, -1, 0, -1, 0, -0.9999999403953552, 0, 0)
	Weld10.Parent = Part4
	local Wedge5 = Instance.new("WedgePart")
	Wedge5.BottomSurface = Enum.SurfaceType.Smooth
	Wedge5.Transparency = 0.5
	Wedge5.Color = Color3.fromRGB(248, 248, 248)
	Wedge5.Massless = true
	Wedge5.Material = Enum.Material.Glass
	Wedge5.Size = Vector3.new(0.19997842609882355, 0.15461884438991547, 0.0899440124630928)
	Wedge5.CFrame = CFrame.new(69.70585632324219, 11.259641647338867, 34.40220642089844, -0.9910219311714172, -0.12940949201583862, -0.0334937646985054, 0.1294090747833252, -0.8660253286361694, -0.48296260833740234, 0.03349337354302406, -0.4829627275466919, 0.8749998211860657)
	Wedge5.Parent = hand
	local Weld11 = Instance.new("Weld")
	Weld11.C0 = CFrame.new(0.0015258779749274254, 0.11041522026062012, 1.06890869140625, -0.9999994039535522, 0, 0, 0, 1, 0, 0, 0, -1)
	Weld11.Parent = Wedge5
	local Wedge6 = Instance.new("WedgePart")
	Wedge6.BottomSurface = Enum.SurfaceType.Smooth
	Wedge6.Transparency = 0.5
	Wedge6.Color = Color3.fromRGB(248, 248, 248)
	Wedge6.Massless = true
	Wedge6.Material = Enum.Material.Glass
	Wedge6.Size = Vector3.new(0.19997842609882355, 0.1940777748823166, 0.4599999785423279)
	Wedge6.CFrame = CFrame.new(69.65425109863281, 10.647974014282227, 35.28422546386719, 0.9910213351249695, -0.12940949201583862, 0.0334937646985054, -0.12940900027751923, -0.8660253286361694, 0.48296260833740234, -0.03349335491657257, -0.4829627275466919, -0.8749998211860657)
	Wedge6.Parent = hand
	local Weld12 = Instance.new("Weld")
	Weld12.C0 = CFrame.new(0.001403807196766138, -0.14162468910217285, -0.01214599609375, 0.9999989867210388, 0, 0, 0, -1, 0, 0, 0, -1)
	Weld12.Parent = Wedge6
	local Wedge7 = Instance.new("WedgePart")
	Wedge7.BottomSurface = Enum.SurfaceType.Smooth
	Wedge7.Transparency = 0.5
	Wedge7.Color = Color3.fromRGB(248, 248, 248)
	Wedge7.Massless = true
	Wedge7.Material = Enum.Material.Glass
	Wedge7.Size = Vector3.new(0.19997842609882355, 0.09106416255235672, 0.4357435703277588)
	Wedge7.CFrame = CFrame.new(69.6735610961914, 10.76457691192627, 35.36320495605469, 0.9910203218460083, 0.12940949201583862, -0.0334937646985054, -0.12940886616706848, 0.8660253286361694, -0.48296260833740234, -0.033493321388959885, 0.4829627275466919, 0.8749998211860657)
	Wedge7.Parent = hand
	local Weld13 = Instance.new("Weld")
	Weld13.C0 = CFrame.new(-0.001403807196766138, -0.031209468841552734, 0.26287841796875, 0.9999989867210388, 0, 0, 0, -1, 0, 0, 0, -1)
	Weld13.Parent = Wedge7
	local Wedge8 = Instance.new("WedgePart")
	Wedge8.BottomSurface = Enum.SurfaceType.Smooth
	Wedge8.Transparency = 0.5
	Wedge8.Color = Color3.fromRGB(248, 248, 248)
	Wedge8.Massless = true
	Wedge8.Material = Enum.Material.Glass
	Wedge8.Size = Vector3.new(0.19997842609882355, 0.15461884438991547, 0.0899440124630928)
	Wedge8.CFrame = CFrame.new(69.6593246459961, 10.610770225524902, 35.57819747924805, 0.9910193085670471, -0.12940949201583862, 0.0334937646985054, -0.12940873205661774, -0.8660253286361694, 0.48296260833740234, -0.0334932878613472, -0.4829627275466919, -0.8749998211860657)
	Wedge8.Parent = hand
	local Weld14 = Instance.new("Weld")
	Weld14.C0 = CFrame.new(0.00012207024701638147, -0.031209468841552734, 1.0810546875, -0.999999463558197, 0, 0, 0, -1, 0, 0, 0, 1)
	Weld14.Parent = Wedge8
	local Wedge9 = Instance.new("WedgePart")
	Wedge9.BottomSurface = Enum.SurfaceType.Smooth
	Wedge9.Transparency = 0.5
	Wedge9.Color = Color3.fromRGB(248, 248, 248)
	Wedge9.Massless = true
	Wedge9.Material = Enum.Material.Glass
	Wedge9.Size = Vector3.new(0.19997842609882355, 0.09106416255235672, 0.4357435703277588)
	Wedge9.CFrame = CFrame.new(69.69969177246094, 11.159891128540039, 34.647342681884766, -0.9910187721252441, 0.12940949201583862, 0.0334937646985054, 0.12940865755081177, 0.8660253286361694, 0.48296260833740234, 0.033493269234895706, 0.4829627275466919, -0.8749998211860657)
	Wedge9.Parent = hand
	local Weld15 = Instance.new("Weld")
	Weld15.C0 = CFrame.new(-0.0003662109375, 2.80252742767334, -0.49102783203125)
	Weld15.Parent = Wedge9
	local Blade = Instance.new("Model")
	Blade.Name = "Blade"
	Blade.WorldPivot = CFrame.new(65.8716812133789, 2.9056320190429688, 36.77555847167969)
	Blade.Parent = swor
	local Wedge10 = Instance.new("WedgePart")
	Wedge10.BottomSurface = Enum.SurfaceType.Smooth
	Wedge10.Transparency = 0.5
	Wedge10.Color = Color3.fromRGB(248, 248, 248)
	Wedge10.Massless = true
	Wedge10.Material = Enum.Material.Neon
	Wedge10.Size = Vector3.new(0.07206401228904724, 0.4755442440509796, 0.16262273490428925)
	Wedge10.CFrame = CFrame.new(70.04627990722656, 13.34975528717041, 36.43049621582031, -0.9910187721252441, 0.12940949201583862, 0.0334937646985054, 0.12940865755081177, 0.8660253286361694, 0.48296260833740234, 0.033493269234895706, 0.4829627275466919, -0.8749998211860657)
	Wedge10.Parent = Blade
	local Weld16 = Instance.new("Weld")
	Weld16.C0 = CFrame.new(0.00018310546875, -1.5025229454040527, 0.0819091796875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
	Weld16.Parent = Wedge10
	local Part5 = Instance.new("Part")
	Part5.BottomSurface = Enum.SurfaceType.Smooth
	Part5.Transparency = 0.5
	Part5.TopSurface = Enum.SurfaceType.Smooth
	Part5.Color = Color3.fromRGB(248, 248, 248)
	Part5.Massless = true
	Part5.Material = Enum.Material.Neon
	Part5.Reflectance = 1
	Part5.Size = Vector3.new(0.2032298743724823, 2.5299999713897705, 0.07145275175571442)
	Part5.CFrame = CFrame.new(69.85440063476562, 12.088115692138672, 35.63317108154297, 0.0334937646985054, 0.12940949201583862, 0.9910187721252441, 0.48296260833740234, 0.8660253286361694, -0.12940865755081177, -0.8749998211860657, 0.4829627275466919, -0.033493269234895706)
	Part5.Parent = Blade
	local Weld17 = Instance.new("Weld")
	Weld17.C0 = CFrame.new(0.0830078125, 1.5025229454040527, 0.00018310546875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
	Weld17.Parent = Part5
	local Wedge11 = Instance.new("WedgePart")
	Wedge11.BottomSurface = Enum.SurfaceType.Smooth
	Wedge11.Transparency = 0.5
	Wedge11.Color = Color3.fromRGB(248, 248, 248)
	Wedge11.Massless = true
	Wedge11.Material = Enum.Material.Neon
	Wedge11.Size = Vector3.new(0.07206401228904724, 0.4755442440509796, 0.16880720853805542)
	Wedge11.CFrame = CFrame.new(70.05180358886719, 13.429404258728027, 36.28619384765625, 0.9910187721252441, 0.12940949201583862, -0.0334937646985054, -0.12940865755081177, 0.8660253286361694, -0.48296260833740234, -0.033493269234895706, 0.4829627275466919, 0.8749998211860657)
	Wedge11.Parent = Blade
	local Weld18 = Instance.new("Weld")
	Weld18.C0 = CFrame.new(0, -1.2049551010131836, -0.0477294921875, -1, 0, 0, 0, -1, 0, 0, 0, 1)
	Weld18.Parent = Wedge11
	local Wedge12 = Instance.new("WedgePart")
	Wedge12.BottomSurface = Enum.SurfaceType.Smooth
	Wedge12.Transparency = 0.5
	Wedge12.Color = Color3.fromRGB(248, 248, 248)
	Wedge12.Massless = true
	Wedge12.Material = Enum.Material.Neon
	Wedge12.Size = Vector3.new(0.07206401228904724, 1.936046838760376, 0.07197457551956177)
	Wedge12.CFrame = CFrame.new(69.89746856689453, 12.408933639526367, 35.66248321533203, -0.9910187721252441, -0.12940949201583862, -0.0334937646985054, 0.12940865755081177, -0.8660253286361694, -0.48296260833740234, 0.033493269234895706, -0.4829627275466919, 0.8749998211860657)
	Wedge12.Parent = Blade
	local Weld19 = Instance.new("Weld")
	Weld19.C0 = CFrame.new(0, 0.00005507469177246094, 0.26129150390625, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	Weld19.Parent = Wedge12
	local Wedge13 = Instance.new("WedgePart")
	Wedge13.BottomSurface = Enum.SurfaceType.Smooth
	Wedge13.Transparency = 0.5
	Wedge13.Color = Color3.fromRGB(248, 248, 248)
	Wedge13.Massless = true
	Wedge13.Material = Enum.Material.Neon
	Wedge13.Size = Vector3.new(0.07206401228904724, 1.9350239038467407, 0.0720483809709549)
	Wedge13.CFrame = CFrame.new(69.88871002197266, 12.282691955566406, 35.89108657836914, 0.9910187721252441, -0.12940949201583862, 0.0334937646985054, -0.12940865755081177, -0.8660253286361694, 0.48296260833740234, -0.033493269234895706, -0.4829627275466919, -0.8749998211860657)
	Wedge13.Parent = Blade
	local Weld20 = Instance.new("Weld")
	Weld20.C0 = CFrame.new(0, 0.8255703449249268, 0.25775146484375, 1, 0, 0, 0, -1, 0, 0, 0, -1)
	Weld20.Parent = Wedge13
	local Wedge14 = Instance.new("WedgePart")
	Wedge14.BottomSurface = Enum.SurfaceType.Smooth
	Wedge14.Transparency = 0.5
	Wedge14.Color = Color3.fromRGB(248, 248, 248)
	Wedge14.Massless = true
	Wedge14.Material = Enum.Material.Neon
	Wedge14.Size = Vector3.new(0.07206401228904724, 1.403694748878479, 0.0675637274980545)
	Wedge14.CFrame = CFrame.new(69.7905044555664, 11.692211151123047, 35.2668342590332, 0.9910187721252441, 0.12940949201583862, -0.0334937646985054, -0.12940865755081177, 0.8660253286361694, -0.48296260833740234, -0.033493269234895706, 0.4829627275466919, 0.8749998211860657)
	Wedge14.Parent = Blade
	local Weld21 = Instance.new("Weld")
	Weld21.C0 = CFrame.new(0.00030517575214616954, -0.008490562438964844, 0.25439453125, -0.9999999403953552, 0, 0, 0, 1, 0, 0, 0, -1)
	Weld21.Parent = Wedge14
	local Wedge15 = Instance.new("WedgePart")
	Wedge15.BottomSurface = Enum.SurfaceType.Smooth
	Wedge15.Transparency = 0.5
	Wedge15.Color = Color3.fromRGB(248, 248, 248)
	Wedge15.Massless = true
	Wedge15.Material = Enum.Material.Neon
	Wedge15.Size = Vector3.new(0.07199999690055847, 1.4040000438690186, 0.06800000369548798)
	Wedge15.CFrame = CFrame.new(69.78118896484375, 11.561955451965332, 35.48531723022461, -0.9910187125205994, 0.12940949201583862, 0.0334937646985054, 0.12940864264965057, 0.8660253286361694, 0.48296260833740234, 0.03349326550960541, 0.4829627275466919, -0.8749998211860657)
	Wedge15.Parent = Blade
	Weld.Part1 = Part
	Weld.Part0 = Handle
	Weld1.Part1 = Wedge
	Weld1.Part0 = Part
	Weld2.Part1 = Wedge1
	Weld2.Part0 = Wedge
	Weld3.Part1 = Wedge2
	Weld3.Part0 = Wedge1
	Weld4.Part1 = Wedge3
	Weld4.Part0 = Wedge2
	Weld5.Part1 = Part1
	Weld5.Part0 = Wedge3
	Weld6.Part1 = Part2
	Weld6.Part0 = Part1
	Weld7.Part1 = Part3
	Weld7.Part0 = Part2
	Weld8.Part1 = Wedge4
	Weld8.Part0 = Part3
	Weld9.Part1 = Part4
	Weld9.Part0 = Wedge4
	Weld10.Part1 = Wedge5
	Weld10.Part0 = Part4
	Weld11.Part1 = Wedge6
	Weld11.Part0 = Wedge5
	Weld12.Part1 = Wedge7
	Weld12.Part0 = Wedge6
	Weld13.Part1 = Wedge8
	Weld13.Part0 = Wedge7
	Weld14.Part1 = Wedge9
	Weld14.Part0 = Wedge8
	Weld15.Part1 = Wedge10
	Weld15.Part0 = Wedge9
	Weld16.Part1 = Part5
	Weld16.Part0 = Wedge10
	Weld17.Part1 = Wedge11
	Weld17.Part0 = Part5
	Weld18.Part1 = Wedge12
	Weld18.Part0 = Wedge11
	Weld19.Part1 = Wedge13
	Weld19.Part0 = Wedge12
	Weld20.Part1 = Wedge14
	Weld20.Part0 = Wedge13
	Weld21.Part1 = Wedge15
	Weld21.Part0 = Wedge14
	for i,v in pairs(swor:GetDescendants()) do
		pcall(function()
			v.Transparency = 1
			v.CanCollide = false
		end)
		task.wait()
	end
	swor.Parent = script
end
function new(instance, properties)
	local ins = Instance.new(instance)
	for i,v in properties do
		ins[i] = v
	end
	return ins
end
function deb(object, time_)
	game:GetService("Debris"):AddItem(object, time_)
end
local tweens = game:GetService("TweenService")
local armwel = Instance.new("Weld", swor.Handle)
armwel.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90), math.rad(180), math.rad(90))
armwel.Part0 = char["Right Arm"]
armwel.Part1 = swor.Handle
hum.Died:Connect(function()
	armwel.Enabled = false
	swor.Handle.Anchored = true
end)
owner.CharacterAdded:Connect(function(ch)
	armwel.Enabled = false
	swor.Handle.Anchored = true
	char = ch
	hum = char.Humanoid
	hrp = char.HumanoidRootPart
	rj = char:FindFirstChild("RootJoint",true)
	lh = char:FindFirstChild("Left Hip",true)
	rh = char:FindFirstChild("Right Hip",true)
	ls = char:FindFirstChild("Left Shoulder",true)
	rs = char:FindFirstChild("Right Shoulder",true)
	n = char:FindFirstChild("Neck",true)
	rj2 = Instance.new("Weld", rj.Parent)
	rj2.C0 = rj.C0
	rj2.C1 = rj.C1
	rj2.Part0 = rj.Part0
	rj2.Part1 = rj.Part1
	rj2.Enabled = false
	lh2 = Instance.new("Weld", lh.Parent)
	lh2.C0 = lh.C0
	lh2.C1 = lh.C1
	lh2.Part0 = lh.Part0
	lh2.Part1 = lh.Part1
	lh2.Enabled = false
	rh2 = Instance.new("Weld", rh.Parent)
	rh2.C0 = rh.C0
	rh2.C1 = rh.C1
	rh2.Part0 = rh.Part0
	rh2.Part1 = rh.Part1
	rh2.Enabled = false
	ls2 = Instance.new("Weld", ls.Parent)
	ls2.C0 = ls.C0
	ls2.C1 = ls.C1
	ls2.Part0 = ls.Part0
	ls2.Part1 = ls.Part1
	ls2.Enabled = false
	rs2 = Instance.new("Weld", rs.Parent)
	rs2.C0 = rs.C0
	rs2.C1 = rs.C1
	rs2.Part0 = rs.Part0
	rs2.Part1 = rs.Part1
	rs2.Enabled = false
	n2 = Instance.new("Weld", n.Parent)
	n2.C0 = n.C0
	n2.C1 = rs.C1
	n2.Part0 = n.Part0
	n2.Part1 = n.Part1
	n2.Enabled = false
	swor.Handle.Anchored = false
	armwel = Instance.new("Weld", swor.Handle)
	armwel.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90), math.rad(180), math.rad(90))
	armwel.Part0 = char["Right Arm"]
	armwel.Part1 = swor.Handle
end)
function tsp(a, b, t, t2, t3)
	for i,v in pairs(a:GetDescendants()) do
		if v:IsA("BasePart") then
			tweens:Create(v, TweenInfo.new(t, t2, t3), {Transparency = b}):Play()
		end
	end
end
function equipanim()
	local inf = TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local inf2 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	rj2.Enabled = true lh2.Enabled = true rh2.Enabled = true ls2.Enabled = true rs2.Enabled = true n2.Enabled = true
	tweens:Create(rj2, inf, {C0 = CFrame.new(0 + (0),0 + (0),0 + (0)) * CFrame.Angles(math.rad(-80 + (0)),math.rad(3 + (0)),math.rad(-165 + (0)))}):Play()
	tweens:Create(lh2, inf, {C0 = CFrame.new(-1 + (0),-1 + (0),0 + (0)) * CFrame.Angles(math.rad(-20 + (0)),math.rad(-75 + (0)),math.rad(-0 + (0)))}):Play()
	tweens:Create(rh2, inf, {C0 = CFrame.new(1 + (0),-1 + (0),0 + (0)) * CFrame.Angles(math.rad(-10 + (0)),math.rad(65 + (0)),math.rad(0 + (0)))}):Play()
	tweens:Create(ls2, inf, {C0 = CFrame.new(-1 + (0),0.5 + (0),0 + (0)) * CFrame.Angles(math.rad(-30 + (0)),math.rad(-90 + (0)),math.rad(0 + (0)))}):Play()
	tweens:Create(rs2, inf, {C0 = CFrame.new(1 + (0),0.5 + (0),0 + (0)) * CFrame.Angles(math.rad(20 + (0)),math.rad(75 + (0)),math.rad(90 + (0)))}):Play()
	tweens:Create(n2, inf, {C0 = CFrame.new(0 + (0),1 + (0),0 + (0)) * CFrame.Angles(math.rad(-100 + (0)),math.rad(90 + (0)),math.rad(165 + (0)))}):Play()
	task.wait(0.7)
	task.spawn(tsp, swor, 0.5, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	task.wait(0.5)
	tweens:Create(rj2, inf2, {C0 = defaults.rj}):Play()
	tweens:Create(lh2, inf2, {C0 = defaults.lh}):Play()
	tweens:Create(rh2, inf2, {C0 = defaults.rh}):Play()
	tweens:Create(ls2, inf2, {C0 = defaults.ls}):Play()
	tweens:Create(rs2, inf2, {C0 = defaults.rs}):Play()
	tweens:Create(n2,  inf2, {C0 = defaults.n }):Play()
	task.wait(0.5)
	rj2.Enabled = false lh2.Enabled = false rh2.Enabled = false ls2.Enabled = false rs2.Enabled = false n2.Enabled = false
end
function dequipanim()
	local inf = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	rs2.Enabled = true
	tweens:Create(rs2, inf, {C0 = CFrame.new(1 + (0),0.5 + (0),-0 + (0)) * CFrame.Angles(math.rad(-180 + (0)),math.rad(90 + (0)),math.rad(-90 + (0)))}):Play()
	task.wait(0.5)
	task.spawn(tsp, swor, 1, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local fun = new("Sound", {
		SoundId = "rbxassetid://9085027122",
		Volume = 1,
		TimePosition = 0.55,
		Parent = swor.Handle
	})
	fun.Playing = true
	deb(fun, 0.425)
	tweens:Create(rs2, inf, {C0 = defaults.rs}):Play()
	task.wait(0.5)
	rs2.Enabled = false
end
local daw = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90), math.rad(180), math.rad(90))
function attack1(hit)
	local inf = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	armwel.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(180), math.rad(180), math.rad(90))
	rs2.Enabled = true
	tweens:Create(rs2, inf, {C0 = CFrame.new(1 + (0),0.5 + (0),-0 + (0)) * CFrame.Angles(math.rad(174 + (0)),math.rad(90 + (0)),math.rad(7 + (0)))}):Play()
	task.wait(0.5)
	-- wip
	task.wait(0.75)
	tweens:Create(rs2, inf, {C0 = defaults.rs}):Play()
	armwel.C0 = daw
	task.wait(0.5)
	rs2.Enabled = false
end
function attack2(hit)
	local inf = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local inf2 = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
	local inf3 = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	armwel.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(180), math.rad(180), math.rad(90))
	rs2.Enabled = true
	tweens:Create(rs2, inf, {C0 = CFrame.new(1 + (0),0.5 + (0),-0 + (0)) * CFrame.Angles(math.rad(-180 + (0)),math.rad(90 + (0)),math.rad(-90 + (0)))}):Play()
	local partty = Instance.new("Part", script)
	partty.Anchored = true
	partty.Material = Enum.Material.Glass
	partty.Transparency = 0.5
	partty.Reflectance = 1
	partty.Color = Color3.new(1,1,1)
	partty.CFrame = CFrame.new(hit)
	partty.Size = Vector3.new(4, 0, 4)
	partty.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChildOfClass("Humanoid") then
			local j = {unpack(hit.Parent.Torso:GetChildren())}
			local rj = j[math.random(1,#j)]
			if rj:IsA("Motor6D") then
				local p = rj.Part1
				rj:Destroy()
				p:SetNetworkOwner(nil)
				p.Parent = script
				p:ClearAllChildren()
				p.Anchored = true
				p.CanCollide = false
				p.Shape = Enum.PartType.Ball
				p.Size = Vector3.one
				p.Material = Enum.Material.Neon
				p.Color = Color3.new(1,1,1)
				tweens:Create(p, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {CFrame = swor.Handle.CFrame}):Play()
				deb(p, 1.5)
			else
				repeat
					rj = j[math.random(1,#j)]
					task.wait()
				until rj:IsA("Motor6D")
			end
		end
		if hit.Anchored == false then
			task.spawn(function()
				local vel = Instance.new("BodyVelocity", hit)
				vel.Velocity = Vector3.new(0, 20, 0)
				task.wait(0.7)
				vel:Destroy()
			end)
		end
	end)
	tweens:Create(partty, inf2, {Size = Vector3.new(4, 12, 4), CFrame = CFrame.new(hit + Vector3.new(0, 6, 0))}):Play()
	task.wait(0.35)
	tweens:Create(partty, inf3, {Size = Vector3.new(4, 0, 4), CFrame = CFrame.new(hit + Vector3.new(0, 12, 0))}):Play()
	deb(partty, 0.35)
	armwel.C0 = daw
	tweens:Create(rs2, inf2, {C0 = defaults.rs}):Play()
	task.wait(0.35)
	rs2.Enabled = false
end
local remote = Instance.new("RemoteEvent", owner.PlayerGui)
remote.Name = "OxygenSword"
NLS([[
warn("q: equip/dequip")
warn("e: spikes")
warn("r: pillar")
local mouse = owner:GetMouse()
local remote = script.Parent
mouse.KeyDown:Connect(function(key)
	if key:lower() == "q" then
		remote:FireServer("sp")
	elseif key:lower() == "e" then
		remote:FireServer("a1", {hit = mouse.Hit})
	elseif key:lower() == "r" then
		remote:FireServer("a2", {hit = mouse.Hit})
	end
end)
]], remote)
local equipped = false
remote.OnServerEvent:Connect(function(plr, method, extra)
	if method == "sp" then
		if equipped == true then
			task.spawn(dequipanim)
			equipped = false
		elseif equipped == false then
			task.spawn(equipanim)
			equipped = true
		end
	elseif method == "a1" then
		task.spawn(attack1, extra.hit.Position)
	elseif method == "a2" then
		task.spawn(attack2, extra.hit.Position)
	end
end)
