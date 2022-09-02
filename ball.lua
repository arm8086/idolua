local bol = Instance.new("Model")
bol.Name = "bol"
bol.WorldPivot = CFrame.new(33.375, 6, -20.625)

local roll1 = Instance.new("Part")
roll1.Name = "roll1"
roll1.BottomSurface = Enum.SurfaceType.Smooth
roll1.TopSurface = Enum.SurfaceType.Smooth
roll1.Color = Color3.fromRGB(27, 42, 53)
roll1.Material = Enum.Material.Metal
roll1.Size = Vector3.new(0.125, 3.75, 3.75)
roll1.CFrame = CFrame.new(25.25, 3.875, -16.8125, 0, 0, 1, 0, 1, 0, -1, 0, 0)
roll1.Shape = Enum.PartType.Cylinder
roll1.Parent = bol

local BTWeld = Instance.new("Weld")
BTWeld.Name = "BTWeld"
BTWeld.C1 = CFrame.new(0.875, -0.044193267822265625, -1.4816951751708984, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld.Parent = roll1

local BTWeld1 = Instance.new("Weld")
BTWeld1.Name = "BTWeld"
BTWeld1.C1 = CFrame.new(0.875, 0, 1.375, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld1.Parent = roll1

local BTWeld2 = Instance.new("Weld")
BTWeld2.Name = "BTWeld"
BTWeld2.C1 = CFrame.new(0.875, -0.0625, -1.4375)
BTWeld2.Parent = roll1

local BTWeld3 = Instance.new("Weld")
BTWeld3.Name = "BTWeld"
BTWeld3.C1 = CFrame.new(0.875, 0, -1.5, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld3.Parent = roll1

local BTWeld4 = Instance.new("Weld")
BTWeld4.Name = "BTWeld"
BTWeld4.C1 = CFrame.new(0.875, -0.04419708251953125, -1.3933038711547852, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld4.Parent = roll1

local BTWeld5 = Instance.new("Weld")
BTWeld5.Name = "BTWeld"
BTWeld5.C1 = CFrame.new(0.875, -0.044193267822265625, 1.481694221496582, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld5.Parent = roll1

local BTWeld6 = Instance.new("Weld")
BTWeld6.Name = "BTWeld"
BTWeld6.C1 = CFrame.new(0.875, -0.0625, 1.4375)
BTWeld6.Parent = roll1

local BTWeld7 = Instance.new("Weld")
BTWeld7.Name = "BTWeld"
BTWeld7.C1 = CFrame.new(0.375, -0.1875, 0.7740383148193359)
BTWeld7.Parent = roll1

local BTWeld8 = Instance.new("Weld")
BTWeld8.Name = "BTWeld"
BTWeld8.C1 = CFrame.new(0.375, -0.1325836181640625, 0.9066219329833984, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld8.Parent = roll1

local BTWeld9 = Instance.new("Weld")
BTWeld9.Name = "BTWeld"
BTWeld9.C1 = CFrame.new(0.375, -0.1325836181640625, -0.6414556503295898, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld9.Parent = roll1

local BTWeld10 = Instance.new("Weld")
BTWeld10.Name = "BTWeld"
BTWeld10.C1 = CFrame.new(0.375, -0.1325836181640625, 0.6414546966552734, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld10.Parent = roll1

local BTWeld11 = Instance.new("Weld")
BTWeld11.Name = "BTWeld"
BTWeld11.C1 = CFrame.new(0.375, -0.1875, -0.7740383148193359)
BTWeld11.Parent = roll1

local BTWeld12 = Instance.new("Weld")
BTWeld12.Name = "BTWeld"
BTWeld12.C1 = CFrame.new(0.375, -0.13258075714111328, -0.9066200256347656, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld12.Parent = roll1

local BTWeld13 = Instance.new("Weld")
BTWeld13.Name = "BTWeld"
BTWeld13.C1 = CFrame.new(0.375, 0, -0.9615383148193359, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld13.Parent = roll1

local BTWeld14 = Instance.new("Weld")
BTWeld14.Name = "BTWeld"
BTWeld14.C1 = CFrame.new(0.875, -0.04419422149658203, 1.3933067321777344, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld14.Parent = roll1

local BTWeld15 = Instance.new("Weld")
BTWeld15.Name = "BTWeld"
BTWeld15.C1 = CFrame.new(0.375, 0, 0.586538553237915, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld15.Parent = roll1

local realweld = Instance.new("Weld")
realweld.Name = "realweld"
realweld.C1 = CFrame.new(-3.375, 0, 0)
realweld.Parent = roll1

local Part = Instance.new("Part")
Part.BottomSurface = Enum.SurfaceType.Smooth
Part.TopSurface = Enum.SurfaceType.Smooth
Part.Color = Color3.fromRGB(255, 255, 0)
Part.Material = Enum.Material.Metal
Part.Size = Vector3.new(1.625, 0.375, 0.375)
Part.CFrame = CFrame.new(23.8125, 3.9375, -15.9375, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Part.Shape = Enum.PartType.Cylinder
Part.Parent = bol

local Part1 = Instance.new("Part")
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Color = Color3.fromRGB(255, 255, 0)
Part1.Material = Enum.Material.Metal
Part1.Size = Vector3.new(1.625, 0.375, 0.375)
Part1.CFrame = CFrame.new(26.6875, 3.9375, -15.9375, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Part1.Shape = Enum.PartType.Cylinder
Part1.Parent = bol

local Part2 = Instance.new("Part")
Part2.BottomSurface = Enum.SurfaceType.Smooth
Part2.TopSurface = Enum.SurfaceType.Smooth
Part2.Color = Color3.fromRGB(255, 255, 0)
Part2.Material = Enum.Material.Metal
Part2.Size = Vector3.new(1.625, 0.375, 0.375)
Part2.CFrame = CFrame.new(25.25, 5.375, -15.9375, 0, -1, 0, 0, 0, 1, -1, 0, 0)
Part2.Shape = Enum.PartType.Cylinder
Part2.Parent = bol

local Part3 = Instance.new("Part")
Part3.BottomSurface = Enum.SurfaceType.Smooth
Part3.TopSurface = Enum.SurfaceType.Smooth
Part3.Color = Color3.fromRGB(255, 255, 0)
Part3.Material = Enum.Material.Metal
Part3.Size = Vector3.new(1.625, 0.375, 0.375)
Part3.CFrame = CFrame.new(25.25, 2.5, -15.9375, 0, -1, 0, 0, 0, 1, -1, 0, 0)
Part3.Shape = Enum.PartType.Cylinder
Part3.Parent = bol

local Part4 = Instance.new("Part")
Part4.BottomSurface = Enum.SurfaceType.Smooth
Part4.TopSurface = Enum.SurfaceType.Smooth
Part4.Color = Color3.fromRGB(255, 255, 0)
Part4.Material = Enum.Material.Metal
Part4.Size = Vector3.new(1.625, 0.375, 0.375)
Part4.CFrame = CFrame.new(26.266468048095703, 4.95396614074707, -15.9375, 0, -0.7071068286895752, 0.7071067690849304, 0, 0.7071067690849304, 0.7071068286895752, -1, 0, 0)
Part4.Shape = Enum.PartType.Cylinder
Part4.Parent = bol

local Part5 = Instance.new("Part")
Part5.BottomSurface = Enum.SurfaceType.Smooth
Part5.TopSurface = Enum.SurfaceType.Smooth
Part5.Color = Color3.fromRGB(255, 255, 0)
Part5.Material = Enum.Material.Metal
Part5.Size = Vector3.new(1.625, 0.375, 0.375)
Part5.CFrame = CFrame.new(24.23353385925293, 2.9210333824157715, -15.9375, 0, -0.7071068286895752, 0.7071067690849304, 0, 0.7071067690849304, 0.7071068286895752, -1, 0, 0)
Part5.Shape = Enum.PartType.Cylinder
Part5.Parent = bol

local Part6 = Instance.new("Part")
Part6.BottomSurface = Enum.SurfaceType.Smooth
Part6.TopSurface = Enum.SurfaceType.Smooth
Part6.Color = Color3.fromRGB(255, 255, 0)
Part6.Material = Enum.Material.Metal
Part6.Size = Vector3.new(1.625, 0.375, 0.375)
Part6.CFrame = CFrame.new(24.23353385925293, 4.953965187072754, -15.9375, 0, 0.7071067690849304, 0.7071068286895752, 0, 0.7071068286895752, -0.7071067690849304, -1, 0, 0)
Part6.Shape = Enum.PartType.Cylinder
Part6.Parent = bol

local Part7 = Instance.new("Part")
Part7.BottomSurface = Enum.SurfaceType.Smooth
Part7.TopSurface = Enum.SurfaceType.Smooth
Part7.Color = Color3.fromRGB(255, 255, 0)
Part7.Material = Enum.Material.Metal
Part7.Size = Vector3.new(1.625, 0.375, 0.375)
Part7.CFrame = CFrame.new(26.26646614074707, 2.921037435531616, -15.9375, 0, 0.7071067690849304, 0.7071068286895752, 0, 0.7071068286895752, -0.7071067690849304, -1, 0, 0)
Part7.Shape = Enum.PartType.Cylinder
Part7.Parent = bol

local Part8 = Instance.new("Part")
Part8.BottomSurface = Enum.SurfaceType.Smooth
Part8.TopSurface = Enum.SurfaceType.Smooth
Part8.Color = Color3.fromRGB(239, 184, 56)
Part8.Material = Enum.Material.Metal
Part8.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part8.CFrame = CFrame.new(24.702672958374023, 4.609829425811768, -16.4375, 0, 0.7071067690849304, 0.7071068286895752, 0, 0.7071068286895752, -0.7071067690849304, -1, 0, 0)
Part8.Shape = Enum.PartType.Cylinder
Part8.Parent = bol

local Part9 = Instance.new("Part")
Part9.BottomSurface = Enum.SurfaceType.Smooth
Part9.TopSurface = Enum.SurfaceType.Smooth
Part9.Color = Color3.fromRGB(239, 184, 56)
Part9.Material = Enum.Material.Metal
Part9.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part9.CFrame = CFrame.new(25.25, 4.836538314819336, -16.4375, 0, -1, 0, 0, 0, 1, -1, 0, 0)
Part9.Shape = Enum.PartType.Cylinder
Part9.Parent = bol

local Part10 = Instance.new("Part")
Part10.BottomSurface = Enum.SurfaceType.Smooth
Part10.TopSurface = Enum.SurfaceType.Smooth
Part10.Color = Color3.fromRGB(239, 184, 56)
Part10.Material = Enum.Material.Metal
Part10.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part10.CFrame = CFrame.new(25.79732894897461, 4.60982608795166, -16.4375, 0, -0.7071068286895752, 0.7071067690849304, 0, 0.7071067690849304, 0.7071068286895752, -1, 0, 0)
Part10.Shape = Enum.PartType.Cylinder
Part10.Parent = bol

local Part11 = Instance.new("Part")
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Color = Color3.fromRGB(239, 184, 56)
Part11.Material = Enum.Material.Metal
Part11.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part11.CFrame = CFrame.new(26.024038314819336, 4.0625, -16.4375, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Part11.Shape = Enum.PartType.Cylinder
Part11.Parent = bol

local Part12 = Instance.new("Part")
Part12.BottomSurface = Enum.SurfaceType.Smooth
Part12.TopSurface = Enum.SurfaceType.Smooth
Part12.Color = Color3.fromRGB(239, 184, 56)
Part12.Material = Enum.Material.Metal
Part12.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part12.CFrame = CFrame.new(25.79732894897461, 3.5151731967926025, -16.4375, 0, 0.7071067690849304, 0.7071068286895752, 0, 0.7071068286895752, -0.7071067690849304, -1, 0, 0)
Part12.Shape = Enum.PartType.Cylinder
Part12.Parent = bol

local Part13 = Instance.new("Part")
Part13.BottomSurface = Enum.SurfaceType.Smooth
Part13.TopSurface = Enum.SurfaceType.Smooth
Part13.Color = Color3.fromRGB(239, 184, 56)
Part13.Material = Enum.Material.Metal
Part13.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part13.CFrame = CFrame.new(25.25, 3.288461446762085, -16.4375, 0, -1, 0, 0, 0, 1, -1, 0, 0)
Part13.Shape = Enum.PartType.Cylinder
Part13.Parent = bol

local Part14 = Instance.new("Part")
Part14.BottomSurface = Enum.SurfaceType.Smooth
Part14.TopSurface = Enum.SurfaceType.Smooth
Part14.Color = Color3.fromRGB(239, 184, 56)
Part14.Material = Enum.Material.Metal
Part14.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part14.CFrame = CFrame.new(24.702672958374023, 3.51517391204834, -16.4375, 0, -0.7071068286895752, 0.7071067690849304, 0, 0.7071067690849304, 0.7071068286895752, -1, 0, 0)
Part14.Shape = Enum.PartType.Cylinder
Part14.Parent = bol

local Part15 = Instance.new("Part")
Part15.BottomSurface = Enum.SurfaceType.Smooth
Part15.TopSurface = Enum.SurfaceType.Smooth
Part15.Color = Color3.fromRGB(239, 184, 56)
Part15.Material = Enum.Material.Metal
Part15.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part15.CFrame = CFrame.new(24.475961685180664, 4.0625, -16.4375, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Part15.Shape = Enum.PartType.Cylinder
Part15.Parent = bol

local cyl1 = Instance.new("Part")
cyl1.Name = "cyl1"
cyl1.BottomSurface = Enum.SurfaceType.Smooth
cyl1.TopSurface = Enum.SurfaceType.Smooth
cyl1.Color = Color3.fromRGB(91, 93, 105)
cyl1.Material = Enum.Material.Metal
cyl1.Size = Vector3.new(6.625, 4.25, 4.25)
cyl1.CFrame = CFrame.new(25.25, 3.875, -20.1875, 0, 0, 1, 0, 1, 0, -1, 0, 0)
cyl1.Shape = Enum.PartType.Cylinder
cyl1.Parent = bol

local bolla = Instance.new("Part")
bolla.Name = "bolla"
bolla.Anchored = true
bolla.BottomSurface = Enum.SurfaceType.Smooth
bolla.Transparency = 0.5
bolla.TopSurface = Enum.SurfaceType.Smooth
bolla.Color = Color3.fromRGB(0, 179, 255)
bolla.Material = Enum.Material.ForceField
bolla.Size = Vector3.new(12, 12, 12)
bolla.CFrame = CFrame.new(33.375, 6, -20.625)
bolla.Shape = Enum.PartType.Ball
bolla.Parent = bol

local cyl2 = Instance.new("Part")
cyl2.Name = "cyl2"
cyl2.BottomSurface = Enum.SurfaceType.Smooth
cyl2.TopSurface = Enum.SurfaceType.Smooth
cyl2.Color = Color3.fromRGB(91, 93, 105)
cyl2.Material = Enum.Material.Metal
cyl2.Size = Vector3.new(6.625, 4.25, 4.25)
cyl2.CFrame = CFrame.new(41.5, 3.875, -20.1875, 0, 0, 1, 0, 1, 0, -1, 0, 0)
cyl2.Shape = Enum.PartType.Cylinder
cyl2.Parent = bol

local BTWeld16 = Instance.new("Weld")
BTWeld16.Name = "BTWeld"
BTWeld16.C1 = CFrame.new(0, 0, 16.25)
BTWeld16.Parent = cyl2

local BTWeld17 = Instance.new("Weld")
BTWeld17.Name = "BTWeld"
BTWeld17.C1 = CFrame.new(8.125, -2.125, 0.4375, 0, 0, 1, 0, 1, 0, -1, 0, 0)
BTWeld17.Parent = cyl2

local Part16 = Instance.new("Part")
Part16.BottomSurface = Enum.SurfaceType.Smooth
Part16.TopSurface = Enum.SurfaceType.Smooth
Part16.Color = Color3.fromRGB(255, 255, 0)
Part16.Material = Enum.Material.Metal
Part16.Size = Vector3.new(1.625, 0.375, 0.375)
Part16.CFrame = CFrame.new(41.28490447998047, 5.233066558837891, -15.9375, 0, 0.9876847267150879, 0.15643426775932312, 0, 0.15643426775932312, -0.9876847267150879, -1, 0, 0)
Part16.Shape = Enum.PartType.Cylinder
Part16.Parent = bol

local Part17 = Instance.new("Part")
Part17.BottomSurface = Enum.SurfaceType.Smooth
Part17.TopSurface = Enum.SurfaceType.Smooth
Part17.Color = Color3.fromRGB(255, 255, 0)
Part17.Material = Enum.Material.Metal
Part17.Size = Vector3.new(1.625, 0.375, 0.375)
Part17.CFrame = CFrame.new(41.734649658203125, 2.3934757709503174, -15.9375, 0, 0.9876847267150879, 0.15643426775932312, 0, 0.15643426775932312, -0.9876847267150879, -1, 0, 0)
Part17.Shape = Enum.PartType.Cylinder
Part17.Parent = bol

local Part18 = Instance.new("Part")
Part18.BottomSurface = Enum.SurfaceType.Smooth
Part18.TopSurface = Enum.SurfaceType.Smooth
Part18.Color = Color3.fromRGB(255, 255, 0)
Part18.Material = Enum.Material.Metal
Part18.Size = Vector3.new(1.625, 0.375, 0.375)
Part18.CFrame = CFrame.new(42.92957305908203, 4.038151741027832, -15.9375, 0, 0.15643426775932312, -0.9876847267150879, 0, -0.9876847267150879, -0.15643426775932312, -1, 0, 0)
Part18.Shape = Enum.PartType.Cylinder
Part18.Parent = bol

local Part19 = Instance.new("Part")
Part19.BottomSurface = Enum.SurfaceType.Smooth
Part19.TopSurface = Enum.SurfaceType.Smooth
Part19.Color = Color3.fromRGB(255, 255, 0)
Part19.Material = Enum.Material.Metal
Part19.Size = Vector3.new(1.625, 0.375, 0.375)
Part19.CFrame = CFrame.new(42.35471725463867, 4.9762372970581055, -15.9375, 0, 0.8090143203735352, -0.5877828001976013, 0, -0.5877828001976013, -0.8090143203735352, -1, 0, 0)
Part19.Shape = Enum.PartType.Cylinder
Part19.Parent = bol

local Part20 = Instance.new("Part")
Part20.BottomSurface = Enum.SurfaceType.Smooth
Part20.TopSurface = Enum.SurfaceType.Smooth
Part20.Color = Color3.fromRGB(255, 255, 0)
Part20.Material = Enum.Material.Metal
Part20.Size = Vector3.new(1.625, 0.375, 0.375)
Part20.CFrame = CFrame.new(42.67273712158203, 2.9683361053466797, -15.9375, 0, -0.5877828001976013, -0.8090143203735352, 0, -0.8090143203735352, 0.5877828001976013, -1, 0, -0)
Part20.Shape = Enum.PartType.Cylinder
Part20.Parent = bol

local Part21 = Instance.new("Part")
Part21.BottomSurface = Enum.SurfaceType.Smooth
Part21.TopSurface = Enum.SurfaceType.Smooth
Part21.Color = Color3.fromRGB(239, 184, 56)
Part21.Material = Enum.Material.Metal
Part21.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part21.CFrame = CFrame.new(40.90312576293945, 4.144781112670898, -16.4375, 0, -0.5877828001976013, -0.8090143203735352, 0, -0.8090143203735352, 0.5877828001976013, -1, 0, -0)
Part21.Shape = Enum.PartType.Cylinder
Part21.Parent = bol

local Part22 = Instance.new("Part")
Part22.BottomSurface = Enum.SurfaceType.Smooth
Part22.TopSurface = Enum.SurfaceType.Smooth
Part22.Color = Color3.fromRGB(239, 184, 56)
Part22.Material = Enum.Material.Metal
Part22.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part22.CFrame = CFrame.new(41.40824508666992, 4.454324722290039, -16.4375, 0, 0.9876847267150879, 0.15643426775932312, 0, 0.15643426775932312, -0.9876847267150879, -1, 0, 0)
Part22.Shape = Enum.PartType.Cylinder
Part22.Parent = bol

local Part23 = Instance.new("Part")
Part23.BottomSurface = Enum.SurfaceType.Smooth
Part23.TopSurface = Enum.SurfaceType.Smooth
Part23.Color = Color3.fromRGB(239, 184, 56)
Part23.Material = Enum.Material.Metal
Part23.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part23.CFrame = CFrame.new(41.98429870605469, 4.316027641296387, -16.4375, 0, 0.8090143203735352, -0.5877828001976013, 0, -0.5877828001976013, -0.8090143203735352, -1, 0, 0)
Part23.Shape = Enum.PartType.Cylinder
Part23.Parent = bol

local Part24 = Instance.new("Part")
Part24.BottomSurface = Enum.SurfaceType.Smooth
Part24.TopSurface = Enum.SurfaceType.Smooth
Part24.Color = Color3.fromRGB(239, 184, 56)
Part24.Material = Enum.Material.Metal
Part24.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part24.CFrame = CFrame.new(42.29383850097656, 3.8109021186828613, -16.4375, 0, 0.15643426775932312, -0.9876847267150879, 0, -0.9876847267150879, -0.15643426775932312, -1, 0, 0)
Part24.Shape = Enum.PartType.Cylinder
Part24.Parent = bol

local Part25 = Instance.new("Part")
Part25.BottomSurface = Enum.SurfaceType.Smooth
Part25.TopSurface = Enum.SurfaceType.Smooth
Part25.Color = Color3.fromRGB(239, 184, 56)
Part25.Material = Enum.Material.Metal
Part25.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part25.CFrame = CFrame.new(42.15554428100586, 3.2348527908325195, -16.4375, 0, -0.5877828001976013, -0.8090143203735352, 0, -0.8090143203735352, 0.5877828001976013, -1, 0, -0)
Part25.Shape = Enum.PartType.Cylinder
Part25.Parent = bol

local Part26 = Instance.new("Part")
Part26.BottomSurface = Enum.SurfaceType.Smooth
Part26.TopSurface = Enum.SurfaceType.Smooth
Part26.Color = Color3.fromRGB(239, 184, 56)
Part26.Material = Enum.Material.Metal
Part26.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part26.CFrame = CFrame.new(41.65041732788086, 2.9253108501434326, -16.4375, 0, 0.9876847267150879, 0.15643426775932312, 0, 0.15643426775932312, -0.9876847267150879, -1, 0, 0)
Part26.Shape = Enum.PartType.Cylinder
Part26.Parent = bol

local roll2 = Instance.new("Part")
roll2.Name = "roll2"
roll2.BottomSurface = Enum.SurfaceType.Smooth
roll2.TopSurface = Enum.SurfaceType.Smooth
roll2.Color = Color3.fromRGB(27, 42, 53)
roll2.Material = Enum.Material.Metal
roll2.Size = Vector3.new(0.125, 3.75, 3.75)
roll2.CFrame = CFrame.new(41.5, 3.875, -16.8125, 0, 0.15643426775932312, -0.9876847267150879, 0, -0.9876847267150879, -0.15643426775932312, -1, 0, -0)
roll2.Shape = Enum.PartType.Cylinder
roll2.Parent = bol

local BTWeld18 = Instance.new("Weld")
BTWeld18.Name = "BTWeld"
BTWeld18.C1 = CFrame.new(0.875, 0, 1.375, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld18.Parent = roll2

local BTWeld19 = Instance.new("Weld")
BTWeld19.Name = "BTWeld"
BTWeld19.C1 = CFrame.new(0.375, -0.1875, -0.7740402221679688)
BTWeld19.Parent = roll2

local BTWeld20 = Instance.new("Weld")
BTWeld20.Name = "BTWeld"
BTWeld20.C1 = CFrame.new(0.875, -0.044189453125, 1.4816932678222656, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld20.Parent = roll2

local BTWeld21 = Instance.new("Weld")
BTWeld21.Name = "BTWeld"
BTWeld21.C1 = CFrame.new(0.875, 0, -1.4999971389770508, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld21.Parent = roll2

local BTWeld22 = Instance.new("Weld")
BTWeld22.Name = "BTWeld"
BTWeld22.C1 = CFrame.new(0.375, -0.13257598876953125, -0.6414566040039062, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld22.Parent = roll2

local BTWeld23 = Instance.new("Weld")
BTWeld23.Name = "BTWeld"
BTWeld23.C1 = CFrame.new(0.875, -0.044189453125, 1.3933143615722656, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld23.Parent = roll2

local BTWeld24 = Instance.new("Weld")
BTWeld24.Name = "BTWeld"
BTWeld24.C1 = CFrame.new(0.375, -0.18749332427978516, 0.7740402221679688)
BTWeld24.Parent = roll2

local BTWeld25 = Instance.new("Weld")
BTWeld25.Name = "BTWeld"
BTWeld25.C1 = CFrame.new(0.375, -0.13257789611816406, -0.9066123962402344, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld25.Parent = roll2

local BTWeld26 = Instance.new("Weld")
BTWeld26.Name = "BTWeld"
BTWeld26.C1 = CFrame.new(0.875, -0.044189453125, -1.4816818237304688, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld26.Parent = roll2

local BTWeld27 = Instance.new("Weld")
BTWeld27.Name = "BTWeld"
BTWeld27.C1 = CFrame.new(0.875, -0.06249189376831055, 1.4375)
BTWeld27.Parent = roll2

local BTWeld28 = Instance.new("Weld")
BTWeld28.Name = "BTWeld"
BTWeld28.C1 = CFrame.new(0.375, -0.13257217407226562, 0.9066181182861328, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld28.Parent = roll2

local BTWeld29 = Instance.new("Weld")
BTWeld29.Name = "BTWeld"
BTWeld29.C1 = CFrame.new(0.375, 0, -0.9615306854248047, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld29.Parent = roll2

local BTWeld30 = Instance.new("Weld")
BTWeld30.Name = "BTWeld"
BTWeld30.C1 = CFrame.new(0.875, -0.044185638427734375, -1.393310546875, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld30.Parent = roll2

local BTWeld31 = Instance.new("Weld")
BTWeld31.Name = "BTWeld"
BTWeld31.C1 = CFrame.new(0.375, -0.13257598876953125, 0.6414642333984375, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld31.Parent = roll2

local BTWeld32 = Instance.new("Weld")
BTWeld32.Name = "BTWeld"
BTWeld32.C1 = CFrame.new(0.375, 0, 0.5865480899810791, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld32.Parent = roll2

local BTWeld33 = Instance.new("Weld")
BTWeld33.Name = "BTWeld"
BTWeld33.C1 = CFrame.new(0.875, -0.06249046325683594, -1.4375)
BTWeld33.Parent = roll2

local realweld1 = Instance.new("Weld")
realweld1.Name = "realweld"
realweld1.C1 = CFrame.new(-3.375, 0, 0)
realweld1.C0 = CFrame.new(0, 0, 1.1175870895385742e-08, 1, 0, 0, 0, -0.9876847267150879, 0.15643426775932312, 0, -0.15643426775932312, -0.9876847267150879)
realweld1.Parent = roll2

local Part27 = Instance.new("Part")
Part27.BottomSurface = Enum.SurfaceType.Smooth
Part27.TopSurface = Enum.SurfaceType.Smooth
Part27.Color = Color3.fromRGB(255, 255, 0)
Part27.Material = Enum.Material.Metal
Part27.Size = Vector3.new(1.625, 0.375, 0.375)
Part27.CFrame = CFrame.new(40.66484451293945, 2.6503243446350098, -15.9375, 0, 0.8090143203735352, -0.5877828001976013, 0, -0.5877828001976013, -0.8090143203735352, -1, 0, 0)
Part27.Shape = Enum.PartType.Cylinder
Part27.Parent = bol

local Part28 = Instance.new("Part")
Part28.BottomSurface = Enum.SurfaceType.Smooth
Part28.TopSurface = Enum.SurfaceType.Smooth
Part28.Color = Color3.fromRGB(255, 255, 0)
Part28.Material = Enum.Material.Metal
Part28.Size = Vector3.new(1.625, 0.375, 0.375)
Part28.CFrame = CFrame.new(40.34682083129883, 4.658216953277588, -15.9375, 0, -0.5877828001976013, -0.8090143203735352, 0, -0.8090143203735352, 0.5877828001976013, -1, 0, -0)
Part28.Shape = Enum.PartType.Cylinder
Part28.Parent = bol

local Part29 = Instance.new("Part")
Part29.BottomSurface = Enum.SurfaceType.Smooth
Part29.TopSurface = Enum.SurfaceType.Smooth
Part29.Color = Color3.fromRGB(239, 184, 56)
Part29.Material = Enum.Material.Metal
Part29.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part29.CFrame = CFrame.new(40.76482391357422, 3.568722724914551, -16.4375, 0, 0.15643426775932312, -0.9876847267150879, 0, -0.9876847267150879, -0.15643426775932312, -1, 0, 0)
Part29.Shape = Enum.PartType.Cylinder
Part29.Parent = bol

local Part30 = Instance.new("Part")
Part30.BottomSurface = Enum.SurfaceType.Smooth
Part30.TopSurface = Enum.SurfaceType.Smooth
Part30.Color = Color3.fromRGB(239, 184, 56)
Part30.Material = Enum.Material.Metal
Part30.Size = Vector3.new(0.8750000596046448, 0.20192310214042664, 0.20192310214042664)
Part30.CFrame = CFrame.new(41.07436752319336, 3.063610553741455, -16.4375, 0, 0.8090143203735352, -0.5877828001976013, 0, -0.5877828001976013, -0.8090143203735352, -1, 0, 0)
Part30.Shape = Enum.PartType.Cylinder
Part30.Parent = bol

local Part31 = Instance.new("Part")
Part31.BottomSurface = Enum.SurfaceType.Smooth
Part31.TopSurface = Enum.SurfaceType.Smooth
Part31.Color = Color3.fromRGB(255, 255, 0)
Part31.Material = Enum.Material.Metal
Part31.Size = Vector3.new(1.625, 0.375, 0.375)
Part31.CFrame = CFrame.new(40.0899772644043, 3.588404893875122, -15.9375, 0, 0.15643426775932312, -0.9876847267150879, 0, -0.9876847267150879, -0.15643426775932312, -1, 0, 0)
Part31.Shape = Enum.PartType.Cylinder
Part31.Parent = bol

local BTWeld34 = Instance.new("Weld")
BTWeld34.Name = "BTWeld"
BTWeld34.C1 = CFrame.new(0, -1.4375, 1.4375, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld34.Parent = Part31

local BTWeld35 = Instance.new("Weld")
BTWeld35.Name = "BTWeld"
BTWeld35.C1 = CFrame.new(-0.5, -0.125, 0.6634597778320312)
BTWeld35.Parent = Part31

local BTWeld36 = Instance.new("Weld")
BTWeld36.Name = "BTWeld"
BTWeld36.C1 = CFrame.new(0, 1.0164680480957031, 2.4539661407470703, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld36.Parent = Part31

local BTWeld37 = Instance.new("Weld")
BTWeld37.Name = "BTWeld"
BTWeld37.C1 = CFrame.new(0, -1.4375, -1.4375, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld37.Parent = Part31

local BTWeld38 = Instance.new("Weld")
BTWeld38.Name = "BTWeld"
BTWeld38.C1 = CFrame.new(-0.5, 0.9280815124511719, 0.33081817626953125, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld38.Parent = Part31

local BTWeld39 = Instance.new("Weld")
BTWeld39.Name = "BTWeld"
BTWeld39.C1 = CFrame.new(0, -1.0164661407470703, 2.453969955444336, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld39.Parent = Part31

local BTWeld40 = Instance.new("Weld")
BTWeld40.Name = "BTWeld"
BTWeld40.C1 = CFrame.new(-0.5, -0.125, 2.2115402221679688)
BTWeld40.Parent = Part31

local BTWeld41 = Instance.new("Weld")
BTWeld41.Name = "BTWeld"
BTWeld41.C1 = CFrame.new(-0.5, -1.1048545837402344, 0.15404129028320312, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld41.Parent = Part31

local BTWeld42 = Instance.new("Weld")
BTWeld42.Name = "BTWeld"
BTWeld42.C1 = CFrame.new(0, -1.0164661407470703, -0.42102813720703125, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld42.Parent = Part31

local BTWeld43 = Instance.new("Weld")
BTWeld43.Name = "BTWeld"
BTWeld43.C1 = CFrame.new(0, 0, 2.875)
BTWeld43.Parent = Part31

local BTWeld44 = Instance.new("Weld")
BTWeld44.Name = "BTWeld"
BTWeld44.C1 = CFrame.new(-0.5, 0.9280815124511719, 1.8788948059082031, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld44.Parent = Part31

local BTWeld45 = Instance.new("Weld")
BTWeld45.Name = "BTWeld"
BTWeld45.C1 = CFrame.new(-0.5, -1.4375, -0.8990383148193359, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld45.Parent = Part31

local BTWeld46 = Instance.new("Weld")
BTWeld46.Name = "BTWeld"
BTWeld46.C1 = CFrame.new(0, 1.0164680480957031, -0.4210319519042969, 1, 0, 0, 0, 0.7071068286895752, 0.7071067690849304, 0, -0.7071067690849304, 0.7071068286895752)
BTWeld46.Parent = Part31

local BTWeld47 = Instance.new("Weld")
BTWeld47.Name = "BTWeld"
BTWeld47.C1 = CFrame.new(-0.5, -1.1048545837402344, 1.702117919921875, 1, 0, 0, 0, 0.7071067690849304, -0.7071068286895752, 0, 0.7071068286895752, 0.7071067690849304)
BTWeld47.Parent = Part31

local BTWeld48 = Instance.new("Weld")
BTWeld48.Name = "BTWeld"
BTWeld48.C1 = CFrame.new(-0.5, -1.4375, 0.649038553237915, 1, 0, 0, 0, 0, -1, 0, 1, 0)
BTWeld48.Parent = Part31

local cube1 = Instance.new("Part")
cube1.Name = "cube1"
cube1.BottomSurface = Enum.SurfaceType.Smooth
cube1.TopSurface = Enum.SurfaceType.Smooth
cube1.Color = Color3.fromRGB(0, 179, 255)
cube1.Material = Enum.Material.Neon
cube1.Size = Vector3.new(3, 3, 3)
cube1.CFrame = CFrame.new(33.375, 6, -20.625)
cube1.Parent = bol

local BTWeld49 = Instance.new("Weld")
BTWeld49.Name = "BTWeld"
BTWeld49.Parent = cube1

local BTWeld50 = Instance.new("Weld")
BTWeld50.Name = "BTWeld"
BTWeld50.Parent = cube1

local cube2 = Instance.new("Part")
cube2.Name = "cube2"
cube2.BottomSurface = Enum.SurfaceType.Smooth
cube2.TopSurface = Enum.SurfaceType.Smooth
cube2.Color = Color3.fromRGB(0, 179, 255)
cube2.Material = Enum.Material.Neon
cube2.Size = Vector3.new(3, 3, 3)
cube2.CFrame = CFrame.new(33.375, 6, -20.625)
cube2.Parent = bol

BTWeld.Part1 = Part4
BTWeld.Part0 = roll1

BTWeld1.Part1 = Part3
BTWeld1.Part0 = roll1

BTWeld2.Part1 = Part1
BTWeld2.Part0 = roll1

BTWeld3.Part1 = Part2
BTWeld3.Part0 = roll1

BTWeld4.Part1 = Part7
BTWeld4.Part0 = roll1

BTWeld5.Part1 = Part6
BTWeld5.Part0 = roll1

BTWeld6.Part1 = Part
BTWeld6.Part0 = roll1

BTWeld7.Part1 = Part15
BTWeld7.Part0 = roll1

BTWeld8.Part1 = Part8
BTWeld8.Part0 = roll1

BTWeld9.Part1 = Part12
BTWeld9.Part0 = roll1

BTWeld10.Part1 = Part14
BTWeld10.Part0 = roll1

BTWeld11.Part1 = Part11
BTWeld11.Part0 = roll1

BTWeld12.Part1 = Part10
BTWeld12.Part0 = roll1

BTWeld13.Part1 = Part9
BTWeld13.Part0 = roll1

BTWeld14.Part1 = Part5
BTWeld14.Part0 = roll1

BTWeld15.Part1 = Part13
BTWeld15.Part0 = roll1

realweld.Part1 = cyl1
realweld.Part0 = roll1

BTWeld16.Part1 = cyl1
BTWeld16.Part0 = cyl2

BTWeld17.Part1 = bolla
BTWeld17.Part0 = cyl2

BTWeld18.Part1 = Part16
BTWeld18.Part0 = roll2

BTWeld19.Part1 = Part29
BTWeld19.Part0 = roll2

BTWeld20.Part1 = Part20
BTWeld20.Part0 = roll2

BTWeld21.Part1 = Part17
BTWeld21.Part0 = roll2

BTWeld22.Part1 = Part21
BTWeld22.Part0 = roll2

BTWeld23.Part1 = Part19
BTWeld23.Part0 = roll2

BTWeld24.Part1 = Part24
BTWeld24.Part0 = roll2

BTWeld25.Part1 = Part30
BTWeld25.Part0 = roll2

BTWeld26.Part1 = Part27
BTWeld26.Part0 = roll2

BTWeld27.Part1 = Part18
BTWeld27.Part0 = roll2

BTWeld28.Part1 = Part25
BTWeld28.Part0 = roll2

BTWeld29.Part1 = Part26
BTWeld29.Part0 = roll2

BTWeld30.Part1 = Part28
BTWeld30.Part0 = roll2

BTWeld31.Part1 = Part23
BTWeld31.Part0 = roll2

BTWeld32.Part1 = Part22
BTWeld32.Part0 = roll2

BTWeld33.Part1 = Part31
BTWeld33.Part0 = roll2

realweld1.Part1 = cyl2
realweld1.Part0 = roll2

BTWeld34.Part1 = Part16
BTWeld34.Part0 = Part31

BTWeld35.Part1 = Part29
BTWeld35.Part0 = Part31

BTWeld36.Part1 = Part20
BTWeld36.Part0 = Part31

BTWeld37.Part1 = Part17
BTWeld37.Part0 = Part31

BTWeld38.Part1 = Part21
BTWeld38.Part0 = Part31

BTWeld39.Part1 = Part19
BTWeld39.Part0 = Part31

BTWeld40.Part1 = Part24
BTWeld40.Part0 = Part31

BTWeld41.Part1 = Part30
BTWeld41.Part0 = Part31

BTWeld42.Part1 = Part27
BTWeld42.Part0 = Part31

BTWeld43.Part1 = Part18
BTWeld43.Part0 = Part31

BTWeld44.Part1 = Part25
BTWeld44.Part0 = Part31

BTWeld45.Part1 = Part26
BTWeld45.Part0 = Part31

BTWeld46.Part1 = Part28
BTWeld46.Part0 = Part31

BTWeld47.Part1 = Part23
BTWeld47.Part0 = Part31

BTWeld48.Part1 = Part22
BTWeld48.Part0 = Part31

BTWeld49.Part1 = cube2
BTWeld49.Part0 = cube1

BTWeld50.Part1 = bolla
BTWeld50.Part0 = cube1

bol.Parent = script

local w, a, s, d, shot = false, false, false, false, false
local walkspeed = 24
local cf = CFrame.new(0, 50, 0)

local rem = Instance.new("RemoteFunction", owner.PlayerGui)
rem.Name = "superball "..tostring(math.random(1, 2048))
NLS([[
local rem = script.Parent
game:service'RunService'.RenderStepped:Wait()
script:Destroy()
local mouse = owner:GetMouse()
mouse.KeyDown:Connect(function(a)
	local key = a:lower()
	if key == "w" then
		rem:InvokeServer("w", true)
	end
	if key == "a" then
		rem:InvokeServer("a", true)
	end
	if key == "s" then
		rem:InvokeServer("s", true)
	end
	if key == "d" then
		rem:InvokeServer("d", true)
	end
	if key == "e" then
		rem:InvokeServer("shoot", true)
	end
end)
mouse.KeyUp:Connect(function(a)
	local key = a:lower()
	if key == "w" then
		rem:InvokeServer("w", false)
	end
	if key == "a" then
		rem:InvokeServer("a", false)
	end
	if key == "s" then
		rem:InvokeServer("s", false)
	end
	if key == "d" then
		rem:InvokeServer("d", false)
	end
	if key == "e" then
		rem:InvokeServer("shoot", false)
	end
end)
]], rem)
rem.OnServerInvoke = function(plr, a1, b)
	if a1 == "shoot" then
		shot = b
	end
	if a1 == "w" then
		w = b
	end
	if a1 == "a" then
		a = b
	end
	if a1 == "s" then
		s = b
	end
	if a1 == "d" then
		d = b
	end
end

local col = Color3.new(
	math.random(),
	math.random(),
	math.random()
)

cube1.Color = col
cube2.Color = col
bolla.Color = col

function guhhhh()
	local ggg = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	while task.wait(1) do
		game:GetService("TweenService"):Create(BTWeld49, ggg, {C0 = CFrame.Angles(math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)))}):Play()
		game:GetService("TweenService"):Create(BTWeld50, ggg, {C0 = CFrame.Angles(math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)))}):Play()
		task.wait(1)
	end
end

coroutine.wrap(guhhhh)()

local minigunvelocity = 0
game:GetService("RunService").Stepped:Connect(function(dt)
	local forwardvelocity = walkspeed * dt
	local potentialCF = CFrame.new()
	if w == true then
		potentialCF *= CFrame.new(0, 0, -forwardvelocity)
	end
	if a == true then
		potentialCF *= CFrame.new(-forwardvelocity, 0, 0)
	end
	if s == true then
		potentialCF *= CFrame.new(0, 0, forwardvelocity)
	end
	if d == true then
		potentialCF *= CFrame.new(forwardvelocity, 0, 0)
	end
	if shot == true then
		minigunvelocity = math.clamp(minigunvelocity+0.5, 0, 30)
	else
		minigunvelocity = math.clamp(minigunvelocity-0.5, 0, 30)
	end
	realweld1.C0 *= CFrame.Angles(math.rad(minigunvelocity), 0, 0)
	realweld.C0 *= CFrame.Angles(math.rad(minigunvelocity), 0, 0)
	cf *= potentialCF
	bolla.CFrame = cf
end)
