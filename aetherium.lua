
print("Running Aetherium v0.00-DEBUG")

-- Load ImGui library and check if it's successful
local success, ImGui = pcall(function()
    return loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()
end)

if not success then
    error("Failed to load ImGui library.")
    return
end
print("ImGui library loaded successfully.")
local defaultWalkSpeed = 16
local defaultJumpPower = 50
local player = game.Players.LocalPlayer

-- Create main window and check if ImGui methods work
local function finishedkey()
local windowSuccess, Window = pcall(function()
    return ImGui:CreateWindow({
        Title = "Aetherium 0.00-DEBUG 81124",
        Size = UDim2.fromOffset(450, 300),
        Position = UDim2.new(0.5, 0, 0, 70),
    })
end)

if not windowSuccess or not Window then
    error("Failed to create ImGui window.")
    return
end
print("Window created successfully.")

local home = Window:CreateTab({
	Name = "Home",
	Visible = false 
})
home:Label({
	Text = "Hello, " .. game.Players.LocalPlayer.Name
})

Window:ShowTab(home)

-- Create Player tab and check for issues
local playerTabSuccess, PlayerTab = pcall(function()
    return Window:CreateTab({
        Name = "Player",
        Visible = true 
    })
end)

if not playerTabSuccess or not PlayerTab then
    error("Failed to create Player tab.")
    return
end
print("Player tab created successfully.")

-- Player tab content
PlayerTab:Label({
    Text = "This is the player tab"
})

local Header = PlayerTab:CollapsingHeader({
	Title = "Movement"
})

Header:Label({
    Text = "Movement Settings"
})


-- WalkSpeed slider
Header:ProgressSlider({
    Label = "Walkspeed",
    Format = "%.d/%s", 
    Value = defaultWalkSpeed,  -- Set the initial WalkSpeed on the slider
    MinValue = 1,
    MaxValue = 128,

    Callback = function(self, wsvalue)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = wsvalue
            print("WalkSpeed updated to:", wsvalue)
        end
    end,
})

-- JumpPower slider
Header:ProgressSlider({
    Label = "JumpPower",
    Format = "%.d/%s", 
    Value = defaultJumpPower,  -- Set the initial JumpPower
    MinValue = 1,
    MaxValue = 128,

    Callback = function(self, jpvalue)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = jpvalue
            print("JumpPower updated to:", jpvalue)
        end
    end,
})

local ServerTab = PlayerTab:CollapsingHeader({
	Title = "Server"
})

-- Server tab content
ServerTab:Label({
    Text = "Server"
})

-- Rejoin server button
ServerTab:Button({
    Text = "Rejoin server",
    Callback = function(self)
        game:GetService("TeleportService"):Teleport(game.PlaceId, player)
        print("Rejoining server...")
    end,
})

-- Lowest player server hop button
ServerTab:Button({
    Text = "Lowest player server hop",
    Callback = function(self)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/SenseiJoshy/Extras/refs/heads/main/Lowest%20Player%20ServerHop.lua'))()
        print("Hopping to lowest player server...")
    end,
})

-- Debug menu tab
local ExampleTab2 = Window:CreateTab({
    Name = "Settings"
})

ExampleTab2:Label({
    Text = "Settings"
})

ExampleTab2:Keybind({
	Label = "Toggle UI",
	Value = Enum.KeyCode.P,
	Callback = function()
		Window:SetVisible(not Window.Visible)
	end,
})

print("GUI setup complete.")
end

local KeySystem = ImGui:CreateWindow({
	Title = "Key system",
	TabsBar = false,
	AutoSize = "Y",
	NoCollapse = true,
	NoResize = true,
	NoClose = true
})
	
local Content = KeySystem:CreateTab({
	Visible = true
})

local Key = Content:InputText({
	Label = "Key",
	PlaceHolder = "Key here",
	Value = "",
})

Content:Button({
	Text = "Enter",
	Callback = function()
		if Key:GetValue() == "a" then
			KeySystem:Close()
			finishedkey()
		else
			Key:SetLabel("Wrong key!")
		end
	end,
})
