-- // https://www.roblox.com/games/9437926290/

if game.CoreGui:FindFirstChild("5013109572") then
	game.CoreGui:FindFirstChild("5013109572"):Destroy()
end  
 
local function getNearestObjects()
	local TargetDistance = math.huge
	local Target
	for _, v in pairs(game:GetService("Workspace").Worlds[tostring(SelectedIsland)].Enemies:GetChildren()) do
		if v.ClassName == 'Model' then
			local Mag = (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if Mag <= TargetDistance then
				TargetDistance = Mag
				Target = v
			end
		end
	end
	return Target
end;


local islands = {}
for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.Teleport.ScrollingFrame:GetChildren()) do
	if v.ClassName == 'Frame' then
		table.insert(islands, v.Name)
	end
end

local eggs = {}
for i, v in pairs(game:GetService("ReplicatedStorage").EggModels:GetChildren()) do
	table.insert(eggs, v.Name)
	table.sort(eggs)
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/kederal/UI-Libs/main/venyx2.txt"))();
local venyx = library.new("System Ked | Anime Plush Simulator", 5013109572);

local Home = venyx:addPage("Home", 5012544693)
local HomeSection1 = Home:addSection("Credits")
local HomeSection2 = Home:addSection("Updates:")
HomeSection1:addButton("kederal#0565", function()
	setclipboard('kederal#0565')
	print("Clicked")
end)

HomeSection1:addButton(".gg/TFctbxdFqu", function()
	setclipboard('https://discord.gg/TFctbxdFqu')
	print("Clicked")
end)

HomeSection2:addButton("[+] New Script", function()
	print("Clicked")
end)

local FarmPage = venyx:addPage("Farm", 5012544693) 
local FarmSection = FarmPage:addSection("Farm") 
local EggSection = FarmPage:addSection("Eggs") 


FarmSection:addDropdown("Select a island", islands, function(text)
	SelectedIsland = text
	print("Selected", text)
end)

FarmSection:addToggle("Autofarm", nil, function(value)
	Autofarm = value
	while Autofarm do
		task.wait(.1)
		pcall(function()
			fireclickdetector(getNearestObjects().ClickDetector)
		end)
	end
	print("Toggled", value)
end)
 
FarmSection:addToggle("Auto Click", nil, function(value)
	Autofarm = value
	while Autofarm do
		task.wait()
		game:GetService("ReplicatedStorage").Events.ClickDamage:FireServer()
	end
	print("Toggled", value)
end)

FarmSection:addToggle("Auto Collect", nil, function(value)
	AutoCollect = value
	while AutoCollect do
		task.wait(.25)
		for i, v in pairs(game:GetService("Workspace").Drops:GetChildren()) do
			v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		end
	end
	print("Toggled", value)
end)

EggSection:addDropdown("Select an egg", eggs, function(text)
	SelectedEgg = text
	print("Selected", text)
end)

EggSection:addToggle("Auto Hatch", nil, function(value)
	AutoHatch = value
	while AutoHatch do
		task.wait(.25)
		game:GetService("ReplicatedStorage").Events.PurchaseEgg:FireServer(tostring(SelectedEgg), 1)
	end
	print("Toggled", value)
end)

EggSection:addToggle("Auto Triple Hatch", nil, function(value)
	AutoTripleHatch = value
	while AutoTripleHatch do
		task.wait(.25)
		game:GetService("ReplicatedStorage").Events.PurchaseEgg:FireServer(tostring(SelectedEgg), 3)
	end
	print("Toggled", value)
end)

venyx:SelectPage(venyx.pages[1], true)
