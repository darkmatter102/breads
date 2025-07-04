--[[
    Grow a Garden Modular Auto Script UI
    Author: GitHub Copilot
    Features: Four-panel UI, auto toggles, remote bindings, anti-AFK, cleanup
--]]

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// RemoteEvent Preload List (add more as needed)
local remoteNames = {
    -- Event Remotes
    "LikeGarden", "SunStrike", "MeteorStrike", "PromptRSVP", "SummerHarvestSubmitRemoteEvent", "FireworkLaunch", "NightQuestRemoteEvent",
    -- Shop Remotes
    "BuySeedStock", "BuyPetEgg", "BuyTravelingMerchantShopStock", "BuyNightEventShopStock", "BuyEasterStock", "BuyGearStock", "BuyCosmeticCrate", "DeveloperPurchase",
    -- Farm Remotes
    "Plant_RE", "HarvestRemote", "Sell_Inventory", "SprinklerService", "Water_RE", "TrowelRemote", "BeeBolt", "FireDrop",
    -- Utility Remotes
    "ClaimableCodeService", "Prompt_Friend", "GiftPet", "SortBackpackEvent", "CraftingGlobalObjectService", "ExperienceNotificationServicePrompterController", "HighlightRemote", "DisplayChatMessage", "PlaySound",
    -- Add all other remotes you want to preload here...
}

--// Remote Cache
local Remotes = {}

local function bindAllRemotes(list)
    local events = ReplicatedStorage:FindFirstChild("GameEvents")
    if events then
        for _, name in ipairs(list) do
            local remote = events:FindFirstChild(name)
            if remote then
                Remotes[name] = remote
            end
        end
    end
    -- Workspace InputGateway remotes (example, expand as needed)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("RemoteEvent") and obj.Name == "Activation" then
            Remotes[obj:GetFullName()] = obj
        end
    end
end

local function FireRemote(name, ...)
    local remote = Remotes[name]
    if remote then
        local ok, err = pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer(...)
            elseif remote:IsA("RemoteFunction") then
                remote:InvokeServer(...)
            end
        end)
        if not ok then warn("[Remote Error]", name, err) end
    else
        warn("[Remote Not Found]", name)
    end
end

--// Utility: Run/Stop Loops
local activeLoops = {}
local function runLoop(flagValue, callback)
    local loopId = {}
    activeLoops[loopId] = true
    local function loop()
        while flagValue.Value and activeLoops[loopId] do
            callback()
            RunService.Heartbeat:Wait()
        end
    end
    task.spawn(loop)
    return function()
        activeLoops[loopId] = nil
    end
end

--// Utility: Anti-AFK
local antiAfkConn
local function antiAfk(flagValue)
    if antiAfkConn then antiAfkConn:Disconnect() end
    if flagValue.Value then
        antiAfkConn = RunService.Heartbeat:Connect(function(dt)
            if tick() % 60 < dt then
                VirtualInputManager:SendMouseButtonEvent(0,0,2,true,game,0)
                VirtualInputManager:SendMouseButtonEvent(0,0,2,false,game,0)
            end
        end)
    end
end

--// UI Creation
local gui = Instance.new("ScreenGui")
gui.Name = "AutoScriptUI"
gui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

local leftMenu = Instance.new("Frame")
leftMenu.Name = "LeftMenu"
leftMenu.Size = UDim2.new(0, 60, 1, 0)
leftMenu.Position = UDim2.new(0, 0, 0, 0)
leftMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
leftMenu.BorderSizePixel = 0
leftMenu.Parent = mainFrame

local rightPanel = Instance.new("Frame")
rightPanel.Name = "RightPanel"
rightPanel.Size = UDim2.new(0, 290, 1, 0)
rightPanel.Position = UDim2.new(0, 60, 0, 0)
rightPanel.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
rightPanel.BorderSizePixel = 0
rightPanel.Parent = mainFrame

--// Panel Switch Logic
local panels = {}
local function switchPanel(panelName)
    for name, panel in pairs(panels) do
        panel.Visible = (name == panelName)
    end
end

--// Button Factory
local function createMenuButton(text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, (order-1)*50)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = leftMenu
    btn.MouseButton1Click:Connect(callback)
    return btn
end

--// Toggle Factory
local function createToggle(name, parent, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 36)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(220,220,220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.3, -10, 0.7, 0)
    toggle.Position = UDim2.new(0.7, 10, 0.15, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    toggle.Text = "OFF"
    toggle.Font = Enum.Font.SourceSansBold
    toggle.TextSize = 16
    toggle.TextColor3 = Color3.fromRGB(255,255,255)
    toggle.Parent = container

    local flag = Instance.new("BoolValue")
    flag.Value = false

    local function update()
        toggle.Text = flag.Value and "ON" or "OFF"
        toggle.BackgroundColor3 = flag.Value and Color3.fromRGB(60, 180, 100) or Color3.fromRGB(80, 80, 120)
    end
    update()

    toggle.MouseButton1Click:Connect(function()
        flag.Value = not flag.Value
        update()
        if callback then callback(flag) end
    end)

    return flag
end

--// Panel Definitions
local function makePanel(name)
    local panel = Instance.new("Frame")
    panel.Name = name .. "Panel"
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.BackgroundTransparency = 1
    panel.Visible = false
    panel.Parent = rightPanel

    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 40)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundTransparency = 1
    header.Text = name
    header.Font = Enum.Font.SourceSansBold
    header.TextSize = 24
    header.TextColor3 = Color3.fromRGB(255,255,255)
    header.Parent = panel

    return panel
end

--// Event Panel
local eventPanel = makePanel("Events")
panels["Event"] = eventPanel
local eventToggles = {
    {"Auto Summer Harvest Submit", function(flag) runLoop(flag, function() FireRemote("SummerHarvestSubmitRemoteEvent") end) end},
    {"Auto Like Garden", function(flag) runLoop(flag, function() FireRemote("LikeGarden") end) end},
    {"Auto Sun Strike", function(flag) runLoop(flag, function() FireRemote("SunStrike") end) end},
    {"Auto Meteor Shower", function(flag) runLoop(flag, function() FireRemote("MeteorStrike") end) end},
    {"Auto Night Quest", function(flag) runLoop(flag, function() FireRemote("NightQuestRemoteEvent") end) end},
    {"Auto Prompt RSVP", function(flag) runLoop(flag, function() FireRemote("PromptRSVP") end) end},
    {"Auto Firework Launch", function(flag) runLoop(flag, function() FireRemote("FireworkLaunch") end) end},
}
for i, v in ipairs(eventToggles) do
    createToggle(v[1], eventPanel, v[2]).Parent.Position = UDim2.new(0, 10, 0, 40 + (i-1)*38)
end

--// Shop Panel
local shopPanel = makePanel("Shop")
panels["Shop"] = shopPanel
local shopToggles = {
    {"Auto Buy Egg", function(flag) runLoop(flag, function() FireRemote("BuyPetEgg") end) end},
    {"Auto Buy Seed", function(flag) runLoop(flag, function() FireRemote("BuySeedStock") end) end},
    {"Auto Buy Traveling Merchant Stock", function(flag) runLoop(flag, function() FireRemote("BuyTravelingMerchantShopStock") end) end},
    {"Auto Buy Pet Egg", function(flag) runLoop(flag, function() FireRemote("BuyPetEgg") end) end},
    {"Auto Buy Night Event Stock", function(flag) runLoop(flag, function() FireRemote("BuyNightEventShopStock") end) end},
    {"Auto Buy Easter Stock", function(flag) runLoop(flag, function() FireRemote("BuyEasterStock") end) end},
    {"Auto Buy Gear Stock", function(flag) runLoop(flag, function() FireRemote("BuyGearStock") end) end},
    {"Auto Buy Cosmetic Crates", function(flag) runLoop(flag, function() FireRemote("BuyCosmeticCrate") end) end},
    {"Auto Developer Purchase", function(flag) runLoop(flag, function() FireRemote("DeveloperPurchase") end) end},
}
for i, v in ipairs(shopToggles) do
    createToggle(v[1], shopPanel, v[2]).Parent.Position = UDim2.new(0, 10, 0, 40 + (i-1)*38)
end

--// Farm Panel
local farmPanel = makePanel("Farm")
panels["Farm"] = farmPanel
local farmToggles = {
    {"Auto Plant", function(flag) runLoop(flag, function() FireRemote("Plant_RE") end) end},
    {"Auto Harvest", function(flag) runLoop(flag, function() FireRemote("HarvestRemote") end) end},
    {"Auto Sell", function(flag) runLoop(flag, function() FireRemote("Sell_Inventory") end) end},
    {"Auto Sprinkler Service", function(flag) runLoop(flag, function() FireRemote("SprinklerService") end) end},
    {"Auto Water", function(flag) runLoop(flag, function() FireRemote("Water_RE") end) end},
    {"Auto Trowel", function(flag) runLoop(flag, function() FireRemote("TrowelRemote") end) end},
    {"Auto BeeBolt Attacks", function(flag) runLoop(flag, function() FireRemote("BeeBolt") end) end},
    {"Auto FireDrop Effects", function(flag) runLoop(flag, function() FireRemote("FireDrop") end) end},
}
for i, v in ipairs(farmToggles) do
    createToggle(v[1], farmPanel, v[2]).Parent.Position = UDim2.new(0, 10, 0, 40 + (i-1)*38)
end

--// Utility Panel
local utilityPanel = makePanel("Utility")
panels["Utility"] = utilityPanel
local utilityToggles = {
    {"Anti-AFK", antiAfk},
    {"Auto Redeem Codes", function(flag) runLoop(flag, function() FireRemote("ClaimableCodeService", "CODE") end) end},
    {"Auto Accept/Prompt Friend Requests", function(flag) runLoop(flag, function() FireRemote("Prompt_Friend", player.UserId) end) end},
    {"Auto Gift Pets", function(flag) runLoop(flag, function() FireRemote("GiftPet", 1, player.UserId) end) end},
    {"Auto Claim Starter Pack & Daily Reward", function(flag) runLoop(flag, function() FireRemote("PromptStarterPack") end) end},
    {"Auto Sort Backpack", function(flag) runLoop(flag, function() FireRemote("SortBackpackEvent") end) end},
    {"Auto Crafting", function(flag) runLoop(flag, function() FireRemote("CraftingGlobalObjectService", 1) end) end},
    {"Auto Experience Notifications", function(flag) runLoop(flag, function() FireRemote("ExperienceNotificationServicePrompterController") end) end},
    {"Auto Highlight Remote", function(flag) runLoop(flag, function() FireRemote("HighlightRemote") end) end},
    {"Auto Display Chat", function(flag) runLoop(flag, function() FireRemote("DisplayChatMessage", "Auto Chat!") end) end},
    {"Auto Play Sound", function(flag) runLoop(flag, function() FireRemote("PlaySound") end) end},
}
for i, v in ipairs(utilityToggles) do
    createToggle(v[1], utilityPanel, v[2]).Parent.Position = UDim2.new(0, 10, 0, 40 + (i-1)*38)
end

--// Menu Buttons
createMenuButton("Event", 1, function() switchPanel("Event") end)
createMenuButton("Shop", 2, function() switchPanel("Shop") end)
createMenuButton("Farm", 3, function() switchPanel("Farm") end)
createMenuButton("Utility", 4, function() switchPanel("Utility") end)

--// Initial State
switchPanel("Event")
bindAllRemotes(remoteNames)

--// Cleanup
local function cleanup()
    for k in pairs(activeLoops) do activeLoops[k] = nil end
    if antiAfkConn then antiAfkConn:Disconnect() end
    if gui then gui:Destroy() end
    table.clear(Remotes)
end

gui.AncestryChanged:Connect(function(_, parent)
    if not parent then cleanup() end
end)

--// End of Script
