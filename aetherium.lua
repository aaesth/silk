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
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local usernameCheckURL = "https://raw.githubusercontent.com/aaesth/files/refs/heads/main/pastebinauth"

local function isUsernameInFile()
    local success, result = pcall(function()
        return game:HttpGet(usernameCheckURL)
    end)
    
    if success then
        local usernames = string.split(result, "\n")
        for _, username in ipairs(usernames) do
            if username == player.Name then
                print("dev")
                return true
            end
        end
        print("not dev")
        return false
    else
        warn("Failed to fetch usernames file: " .. tostring(result))
        return false
    end
end

-- Create main window and check if ImGui methods work
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
    Text = "Hello, " .. player.Name
})

if isUsernameInFile() then
    print("add dev to home page")
    home:Label({
        Text = "You have developer access"
    })
else
    print("e")
    home:Label({
        Text = "Couldn't verify your account so you don't have developer access"
    })
end

local FPSLabel = home:Label()
local TimeLabel = home:Label()

RunService.RenderStepped:Connect(function(v)
    FPSLabel.Text = "FPS: " .. math.round(1 / v)
    TimeLabel.Text = "The time is " .. DateTime.now():FormatLocalTime("dddd h:mm:ss A", "en-us")
end)

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
    Value = defaultWalkSpeed,
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
    Value = defaultJumpPower,
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

local gamespecific = Window:CreateTab({
    Name = "Games"
})

local jjj = gamespecific:CollapsingHeader({
    Title = "Natural Disaster"
})

jjj:Label({
    Text = "test"
})

jjj:Button({
    Text = "Teleport to Spawn",
    Callback = function(self)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-313, 180, 372)
    end,
})

jjj:Button({
    Text = "Teleport to Map",
    Callback = function(self)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-132, 48, 5)
    end,
})

jjj:Button({
    Text = "Autofarm",
    Callback = function(self, Value)
        while Value do
            wait(5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-290, 178, 379)
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
        end
    end,
})

jjj:Button({
    Text = "Teleport unanchored parts",
    Callback = function(self, Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/aaesth/aetherium/refs/heads/main/tpua.lua", true))()
    end,
})

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

Window:ShowTab(home)
print("GUI setup complete.")
