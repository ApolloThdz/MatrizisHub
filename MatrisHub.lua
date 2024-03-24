local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "MatrisHub", HidePremium = false, SaveConfig = true, ConfigFolder = "MatrisHub"})

local Tab = Window:MakeTab({
	Name = "Super Farming",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Farming Options"
})

Tab:AddDropdown({
	Name = "Weapon",
	Default = "Meele",
	Options = {"Meele", "Fruit"},
	Callback = function(Value)
		print(Value)
	end    
})

Tab:AddToggle({
	Name = "Skypea Farming",
	Default = false,
	Callback = function(Value)
		print(Value)
	end    
})


Tab:AddToggle({
	Name = "This is a toggle!",
	Default = false,
	Callback = function(Value)
		print(Value)
	end    
})

