-- // https://www.roblox.com/games/9602700094/

if game.CoreGui:FindFirstChild("5013109572") then
   game.CoreGui:FindFirstChild("5013109572"):Destroy()
end   

function calcReb()
	return game:GetService("ReplicatedStorage"):WaitForChild("ItemDictionary").SimulatorSettings.RebirthsSettings.Version.Version1StartingAmount.Value * 2 ^ game:GetService("ReplicatedStorage"):WaitForChild("ServerStats"):WaitForChild(game.Players.LocalPlayer.Name).Rebirths.Value;
end;

local Cash = game:GetService("ReplicatedStorage"):WaitForChild("ServerStats"):WaitForChild(game.Players.LocalPlayer.Name).Cash.Value

local function getNearestObjects()
    local TargetDistance = math.huge
    local Target
    for _, v in pairs(game:GetService("Workspace").Objects:GetChildren()) do
        if v.ClassName == 'MeshPart' then
            local Mag = (v.HitBox.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Mag <= TargetDistance then
                TargetDistance = Mag
                Target = v
            end
        end
    end
    return Target
end;

local library = loadstring(game:HttpGet("http://void-scripts.com/UI/VenyxUi2.lua"))()
local venyx = library.new("System Cockdus - Open Source", 5013109572)


local themes = {
	Background = Color3.fromRGB(24, 24, 24),
	Glow = Color3.fromRGB(0, 0, 0),
	Accent = Color3.fromRGB(10, 10, 10),
	LightContrast = Color3.fromRGB(20, 20, 20),
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

local Home = venyx:addPage("Home", 5012544693)
local HomeSection1 = Home:addSection("Credits")
local HomeSection2 = Home:addSection("Updates:")

local Farm = venyx:addPage("Farm", 5012544693)
local FarmSection = Farm:addSection("Farm")

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


FarmSection:addToggle("Autofarm", nil, function(value)
    Autofarm = value
    while Autofarm do task.wait(.25)
    pcall(function()
    game:GetService("ReplicatedStorage").Communication.RE:FireServer("SelectObject",getNearestObjects().HitBox)    
    end)
    end    
	print("Toggled", value)
end)

FarmSection:addToggle("Auto Rebirth", nil, function(value)
    AutoRebirth = value
    while AutoRebirth do task.wait(.25)
    if calcReb() < Cash then
    game:GetService("ReplicatedStorage").Communication.RE:FireServer("RebirthRequest")
    end      
    end    
	print("Toggled", value)
end)

venyx:SelectPage(venyx.pages[1], true)
