
--[[
GAG SCRIPT BY:BREAD
Modern Sidebar GUI (Restarted)
--]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- Main GUI
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GAG_SidebarGUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Sidebar Frame
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 520, 0, 480) -- Increased width and height
sidebar.Position = UDim2.new(0.5, -260, 0.5, -240)
sidebar.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Bright red for visibility
sidebar.BorderSizePixel = 0
sidebar.Parent = screenGui
sidebar.Visible = true

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 44) -- Increased height
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
topBar.BorderSizePixel = 0
topBar.Parent = sidebar

local topBarTitle = Instance.new("TextLabel")
topBarTitle.Name = "TopBarTitle"
topBarTitle.Size = UDim2.new(1, -80, 1, 0)
topBarTitle.Position = UDim2.new(0, 12, 0, 0)
topBarTitle.BackgroundTransparency = 1
topBarTitle.Text = "GAG SCRIPT BY:BREAD"
topBarTitle.Font = Enum.Font.SourceSansBold
topBarTitle.TextSize = 24
topBarTitle.TextColor3 = Color3.fromRGB(40, 40, 40)
topBarTitle.TextXAlignment = Enum.TextXAlignment.Left
topBarTitle.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 32, 1, 0)
minimizeBtn.Position = UDim2.new(1, -64, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
minimizeBtn.Text = "_"
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 22
minimizeBtn.TextColor3 = Color3.fromRGB(0,0,0)
minimizeBtn.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 32, 1, 0)
closeBtn.Position = UDim2.new(1, -32, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 22
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Parent = topBar

-- Sidebar Tabs
local tabNames = {"EVENT", "SHOP", "FARM", "GEAR"} -- Added GEAR tab
local tabButtons = {}
for i, name in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "TabBtn"
    tabBtn.Size = UDim2.new(0, 120, 0, 54) -- Increased width and height
    tabBtn.Position = UDim2.new(0, 0, 0, 44 + (i-1)*54)
    tabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(80, 90, 110)
    tabBtn.Text = name
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 24
    tabBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = sidebar
    tabButtons[name] = tabBtn
    print("[DEBUG] Created tab:", name) -- Debug print
end

-- Vertical Black Line
local navLine = Instance.new("Frame")
navLine.Size = UDim2.new(0, 4, 1, -44)
navLine.Position = UDim2.new(0, 120, 0, 44)
navLine.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
navLine.BorderSizePixel = 0
navLine.Parent = sidebar

-- Main Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -124, 1, -44)
contentFrame.Position = UDim2.new(0, 124, 0, 44)
contentFrame.BackgroundColor3 = Color3.fromRGB(120, 130, 150)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = sidebar

-- Tab Content
local tabContent = {}
for _, name in ipairs(tabNames) do
    local frame = Instance.new("Frame")
    frame.Name = name .. "TabContent"
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = (name == "EVENT")
    frame.Parent = contentFrame
    tabContent[name] = frame
end

-- EVENT TAB CONTENT
local eventFrame = tabContent["EVENT"]
local eventHeader = Instance.new("TextLabel")
eventHeader.Size = UDim2.new(1, -32, 0, 40)
eventHeader.Position = UDim2.new(0, 16, 0, 16)
eventHeader.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
eventHeader.Text = "SUMMER HARVEST"
eventHeader.Font = Enum.Font.SourceSansBold
eventHeader.TextSize = 22
eventHeader.TextColor3 = Color3.fromRGB(255,255,255)
eventHeader.BorderSizePixel = 0
eventHeader.TextXAlignment = Enum.TextXAlignment.Center
eventHeader.Parent = eventFrame

local autoSubmitToggle = Instance.new("TextButton")
autoSubmitToggle.Name = "AutoSubmitToggle"
autoSubmitToggle.Size = UDim2.new(1, -32, 0, 36)
autoSubmitToggle.Position = UDim2.new(0, 16, 0, 64)
autoSubmitToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
autoSubmitToggle.Text = "AUTO SUBMIT:"
autoSubmitToggle.Font = Enum.Font.SourceSansBold
autoSubmitToggle.TextSize = 20
autoSubmitToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoSubmitToggle.BorderSizePixel = 0
autoSubmitToggle.TextXAlignment = Enum.TextXAlignment.Left
autoSubmitToggle.Parent = eventFrame

local check = Instance.new("TextLabel")
check.Name = "Checkmark"
check.Size = UDim2.new(0, 32, 1, 0)
check.Position = UDim2.new(1, -36, 0, 0)
check.BackgroundTransparency = 1
check.Font = Enum.Font.SourceSansBold
check.TextSize = 24
check.TextColor3 = Color3.fromRGB(220, 220, 220)
check.Text = ""
check.Parent = autoSubmitToggle

local autoSubmitState = false
local function updateAutoSubmitToggle()
    autoSubmitToggle.BackgroundColor3 = autoSubmitState and Color3.fromRGB(40, 90, 180) or Color3.fromRGB(60, 90, 130)
    check.Text = autoSubmitState and "✔" or ""
end
updateAutoSubmitToggle()
autoSubmitToggle.MouseButton1Click:Connect(function()
    autoSubmitState = not autoSubmitState
    updateAutoSubmitToggle()
end)

-- SHOP TAB CONTENT
local shopFrame = tabContent["SHOP"]

-- Toggles (create these first so updateShopToggle can reference them)
local autoBuyEggToggle = Instance.new("TextButton")
autoBuyEggToggle.Name = "AutoBuyEggToggle"
autoBuyEggToggle.Size = UDim2.new(1, -32, 0, 36)
autoBuyEggToggle.Position = UDim2.new(0, 16, 0, 64)
autoBuyEggToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
autoBuyEggToggle.Text = "AUTO BUY EGG"
autoBuyEggToggle.Font = Enum.Font.SourceSansBold
autoBuyEggToggle.TextSize = 20
autoBuyEggToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoBuyEggToggle.BorderSizePixel = 0
autoBuyEggToggle.TextXAlignment = Enum.TextXAlignment.Left
autoBuyEggToggle.Parent = shopFrame

local eggCheck = Instance.new("TextLabel")
eggCheck.Name = "Checkmark"
eggCheck.Size = UDim2.new(0, 32, 1, 0)
eggCheck.Position = UDim2.new(1, -36, 0, 0)
eggCheck.BackgroundTransparency = 1
eggCheck.Font = Enum.Font.SourceSansBold
eggCheck.TextSize = 24
eggCheck.TextColor3 = Color3.fromRGB(220, 220, 220)
eggCheck.Text = ""
eggCheck.Parent = autoBuyEggToggle

local autoBuyEggState = false
local autoBuyEggLoopRunning = false
local function updateAutoBuyEggToggle()
    if autoBuyEggState then
        autoBuyEggToggle.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
        eggCheck.Text = "✅"
    else
        autoBuyEggToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
        eggCheck.Text = ""
    end
end
updateAutoBuyEggToggle()

-- Only one connection for auto-buy egg toggle, fully automatic
autoBuyEggToggle.MouseButton1Click:Connect(function()
    autoBuyEggState = not autoBuyEggState
    updateAutoBuyEggToggle()
    if autoBuyEggState and not autoBuyEggLoopRunning then
        autoBuyEggLoopRunning = true
        task.spawn(function()
            while autoBuyEggState do
                for _, egg in ipairs(selectedEggs) do
                    if isEggInStock(egg) then
                        if buyEggRemote then
                            buyEggRemote:FireServer(egg)
                        end
                    end
                end
                task.wait(0.1)
            end
            autoBuyEggLoopRunning = false
        end)
    end
end)

local autoBuySeedToggle = Instance.new("TextButton")
autoBuySeedToggle.Name = "AutoBuySeedToggle"
autoBuySeedToggle.Size = UDim2.new(1, -32, 0, 36)
autoBuySeedToggle.Position = UDim2.new(0, 16, 0, 104)
autoBuySeedToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
autoBuySeedToggle.Text = "AUTO BUY SEED"
autoBuySeedToggle.Font = Enum.Font.SourceSansBold
autoBuySeedToggle.TextSize = 20
autoBuySeedToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoBuySeedToggle.BorderSizePixel = 0
autoBuySeedToggle.TextXAlignment = Enum.TextXAlignment.Left
autoBuySeedToggle.Parent = shopFrame

local seedCheck = Instance.new("TextLabel")
seedCheck.Name = "Checkmark"
seedCheck.Size = UDim2.new(0, 32, 1, 0)
seedCheck.Position = UDim2.new(1, -36, 0, 0)
seedCheck.BackgroundTransparency = 1
seedCheck.Font = Enum.Font.SourceSansBold
seedCheck.TextSize = 24
seedCheck.TextColor3 = Color3.fromRGB(220, 220, 220)
seedCheck.Text = ""
seedCheck.Parent = autoBuySeedToggle

local autoBuySeedState = false
local autoBuySeedLoopRunning = false
local function updateAutoBuySeedToggle()
    if autoBuySeedState then
        autoBuySeedToggle.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
        seedCheck.Text = "✅"
    else
        autoBuySeedToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
        seedCheck.Text = ""
    end
end
updateAutoBuySeedToggle()

-- Only one connection for auto-buy seed toggle, fully automatic
autoBuySeedToggle.MouseButton1Click:Connect(function()
    autoBuySeedState = not autoBuySeedState
    updateAutoBuySeedToggle()
    if autoBuySeedState and not autoBuySeedLoopRunning then
        autoBuySeedLoopRunning = true
        task.spawn(function()
            while autoBuySeedState do
                for _, seed in ipairs(selectedSeeds) do
                    if isSeedInStock(seed) then
                        if buySeedRemote then
                            buySeedRemote:FireServer(seed)
                        end
                    end
                end
                task.wait(0.1)
            end
            autoBuySeedLoopRunning = false
        end)
    end
end)

-- Egg Dropdown Button
local eggDropdownBtn = Instance.new("TextButton")
eggDropdownBtn.Name = "EggDropdownBtn"
eggDropdownBtn.Size = UDim2.new(1, -40, 0, 44) -- Larger
eggDropdownBtn.Position = UDim2.new(0, 20, 0, 20)
eggDropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
eggDropdownBtn.Text = "BUY EGG:"
eggDropdownBtn.Font = Enum.Font.SourceSansBold
eggDropdownBtn.TextSize = 22
eggDropdownBtn.TextColor3 = Color3.fromRGB(255,255,255)
eggDropdownBtn.BorderSizePixel = 0
eggDropdownBtn.TextXAlignment = Enum.TextXAlignment.Center
eggDropdownBtn.Parent = shopFrame
eggDropdownBtn.ZIndex = 2

-- Egg Dropdown ScrollingFrame
local eggDropdownList = Instance.new("ScrollingFrame")
eggDropdownList.Name = "EggDropdownList"
eggDropdownList.Size = UDim2.new(1, -40, 0, 0)
eggDropdownList.Position = UDim2.new(0, 20, 0, 64)
eggDropdownList.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
eggDropdownList.BorderSizePixel = 0
eggDropdownList.Visible = false
eggDropdownList.Parent = shopFrame
eggDropdownList.ZIndex = 3
eggDropdownList.ClipsDescendants = true
eggDropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
eggDropdownList.ScrollBarThickness = 10 -- Thicker scrollbar

-- Full Egg List (Name, Price, Details)
local eggOptions = {
    "Common Egg",
    "Uncommon Egg",
    "Rare Egg",
    "Legendary Egg",
    "Mythical Egg",
    "Bug Egg",
    "Exotic Bug Egg",
    "Night Egg",
    "Premium Night Egg",
    "Bee Egg",
    "Anti Bee Egg",
    "Premium Anti Bee Egg",
    "Common Summer Egg",
    "Rare Summer Egg",
    "Paradise Egg",
    "Oasis Egg",
    "Premium Oasis Egg"
}
local eggDetails = {
    ["Common Egg"] = "50,000 | Golden Lab, Dog, Bunny (33.33% each)",
    ["Uncommon Egg"] = "150,000 | Black Bunny, Chicken, Cat, Deer (25% each)",
    ["Rare Egg"] = "600,000 | Orange Tabby, Spotted Deer, Pig, Rooster, Monkey",
    ["Legendary Egg"] = "3,000,000 | Cow, Silver Monkey, Sea Otter, Turtle, Polar Bear",
    ["Mythical Egg"] = "8,000,000 | Grey Mouse, Brown Mouse, Squirrel, Red Giant Ant, Red Fox",
    ["Bug Egg"] = "50,000,000 | Snail, Giant Ant, Caterpillar, Praying Mantis, Dragonfly",
    ["Exotic Bug Egg"] = "Limited Time Shop",
    ["Night Egg"] = "25M/50M | Hedgehog, Mole, Frog, Echo Frog, Night Owl, Raccoon",
    ["Premium Night Egg"] = "199 | Hedgehog, Mole, Frog, Echo Frog, Night Owl, Raccoon",
    ["Bee Egg"] = "18 | Bee, Honey Bee, Bear Bee, Petal Bee, Queen Bee",
    ["Anti Bee Egg"] = "Crafting | Wasp, Tarantula Hawk, Moth, Butterfly, Disco Bee",
    ["Premium Anti Bee Egg"] = "199 | Limited Time Shop",
    ["Common Summer Egg"] = "1,000,000 | Starfish, Seagull, Crab",
    ["Rare Summer Egg"] = "25,000,000 | Flamingo, Toucan, Sea Turtle, Orangutan, Seal",
    ["Paradise Egg"] = "50,000,000 | Ostrich, Peacock, Capybara, Scarlet Macaw, Mimic Octopus",
    ["Oasis Egg"] = "10 | Meerkat, Sand Snake, Axolotl, Hyacinth Macaw, Fennec Fox",
    ["Premium Oasis Egg"] = "199 | Limited Time Shop"
}
local selectedEggs = {}
local function updateEggDropdownText()
    if #selectedEggs == 0 then
        eggDropdownBtn.Text = "BUY EGG:"
    else
        eggDropdownBtn.Text = "BUY EGG: " .. table.concat(selectedEggs, ", ")
    end
end
for i, name in ipairs(eggOptions) do
    local opt = Instance.new("TextButton")
    opt.Size = UDim2.new(1, 0, 0, 38)
    opt.Position = UDim2.new(0, 0, 0, (i-1)*38)
    opt.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    opt.Text = name
    opt.Font = Enum.Font.SourceSans
    opt.TextSize = 20
    opt.TextColor3 = Color3.fromRGB(255,255,255)
    opt.BorderSizePixel = 0
    opt.Parent = eggDropdownList
    opt.ZIndex = 4
    -- Tooltip for details
    opt.MouseEnter:Connect(function()
        opt.Text = name .. "\n" .. (eggDetails[name] or "")
        opt.TextWrapped = true
    end)
    opt.MouseLeave:Connect(function()
        opt.Text = name
        opt.TextWrapped = false
    end)
    opt.MouseButton1Click:Connect(function()
        local found = false
        for j, v in ipairs(selectedEggs) do
            if v == name then table.remove(selectedEggs, j) found = true break end
        end
        if not found then table.insert(selectedEggs, name) end
        updateEggDropdownText()
        opt.BackgroundColor3 = found and Color3.fromRGB(100, 170, 220) or Color3.fromRGB(60, 200, 120)
    end)
end
updateEggDropdownText()
eggDropdownList.CanvasSize = UDim2.new(0, 0, 0, #eggOptions * 38)

-- Seed Dropdown Button
local seedDropdownBtn = Instance.new("TextButton")
seedDropdownBtn.Name = "SeedDropdownBtn"
seedDropdownBtn.Size = UDim2.new(1, -40, 0, 44)
seedDropdownBtn.Position = UDim2.new(0, 20, 0, 74 + (#eggOptions > 0 and (#eggOptions * 38) or 0))
seedDropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
seedDropdownBtn.Text = "BUY SEEDS:"
seedDropdownBtn.Font = Enum.Font.SourceSansBold
seedDropdownBtn.TextSize = 22
seedDropdownBtn.TextColor3 = Color3.fromRGB(255,255,255)
seedDropdownBtn.BorderSizePixel = 0
seedDropdownBtn.TextXAlignment = Enum.TextXAlignment.Center
seedDropdownBtn.Parent = shopFrame
seedDropdownBtn.ZIndex = 2

-- Seed Dropdown ScrollingFrame
local seedDropdownList = Instance.new("ScrollingFrame")
seedDropdownList.Name = "SeedDropdownList"
seedDropdownList.Size = UDim2.new(1, -40, 0, 0)
seedDropdownList.Position = UDim2.new(0, 20, 0, 118 + (#eggOptions > 0 and (#eggOptions * 38) or 0))
seedDropdownList.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
seedDropdownList.BorderSizePixel = 0
seedDropdownList.Visible = false
seedDropdownList.Parent = shopFrame
seedDropdownList.ZIndex = 3
seedDropdownList.ClipsDescendants = true
seedDropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
seedDropdownList.ScrollBarThickness = 10

-- Full Seed List (Name, Price, etc)
local seedOptions = {
    "Carrot",
    "Strawberry",
    "Blueberry",
    "Tomato",
    "Cauliflower",
    "Watermelon",
    "Rafflesia",
    "Green Apple",
    "Avocado",
    "Banana",
    "Pineapple",
    "Kiwi",
    "Bell Pepper",
    "Prickly Pear",
    "Loquat",
    "Feijoa",
    "Pitcher Plant",
    "Sugar Apple"
}
local seedDetails = {
    ["Carrot"] = "10 | Common | 5-25 | ✗/✓",
    ["Strawberry"] = "50 | Common | 1-6 | ✓/✓",
    ["Blueberry"] = "400 | Uncommon | 1-5 | ✓/✓",
    ["Tomato"] = "800 | Rare | 1-3 | ✓/✓",
    ["Cauliflower"] = "1,300 | Rare | 1-4 | ✓/✓",
    ["Watermelon"] = "2,500 | Rare | 1-7 | ✗/✓",
    ["Rafflesia"] = "3,200 | Legendary | 1-? | ✗/✓",
    ["Green Apple"] = "3,500 | Legendary | 1 | ✓/✓",
    ["Avocado"] = "5,000 | Legendary | 1 | ✓/✓",
    ["Banana"] = "7,000 | Legendary | 1 | ✓/✓",
    ["Pineapple"] = "7,500 | Mythical | 1 | ✓/✓",
    ["Kiwi"] = "10,000 | Mythical | 1 | ✓/✓",
    ["Bell Pepper"] = "55,000 | Mythical | 1 | ✓/✓",
    ["Prickly Pear"] = "555,000 | Mythical | 1 | ✓/✓",
    ["Loquat"] = "900,000 | Divine | 1 | ✓/✓",
    ["Feijoa"] = "2,750,000 | Divine | 1 | ✓/✓",
    ["Pitcher Plant"] = "7,500,000 | Divine | 1 | ✓/✓",
    ["Sugar Apple"] = "25,000,000 | Prismatic | 1"
}
local selectedSeeds = {}
local function updateSeedDropdownText()
    if #selectedSeeds == 0 then
        seedDropdownBtn.Text = "BUY SEEDS:"
    else
        seedDropdownBtn.Text = "BUY SEEDS: " .. table.concat(selectedSeeds, ", ")
    end
end
for i, name in ipairs(seedOptions) do
    local opt = Instance.new("TextButton")
    opt.Size = UDim2.new(1, 0, 0, 38)
    opt.Position = UDim2.new(0, 0, 0, (i-1)*38)
    opt.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    opt.Text = name
    opt.Font = Enum.Font.SourceSans
    opt.TextSize = 20
    opt.TextColor3 = Color3.fromRGB(255,255,255)
    opt.BorderSizePixel = 0
    opt.Parent = seedDropdownList
    opt.ZIndex = 4
    -- Tooltip for details
    opt.MouseEnter:Connect(function()
        opt.Text = name .. "\n" .. (seedDetails[name] or "")
        opt.TextWrapped = true
    end)
    opt.MouseLeave:Connect(function()
        opt.Text = name
        opt.TextWrapped = false
    end)
    opt.MouseButton1Click:Connect(function()
        local found = false
        for j, v in ipairs(selectedSeeds) do
            if v == name then table.remove(selectedSeeds, j) found = true break end
        end
        if not found then table.insert(selectedSeeds, name) end
        updateSeedDropdownText()
        opt.BackgroundColor3 = found and Color3.fromRGB(100, 170, 220) or Color3.fromRGB(60, 200, 120)
    end)
end
updateSeedDropdownText()
seedDropdownList.CanvasSize = UDim2.new(0, 0, 0, #seedOptions * 38)

-- GEAR TAB CONTENT
local gearFrame = tabContent["GEAR"]
local gearHeader = Instance.new("TextLabel")
gearHeader.Size = UDim2.new(1, -32, 0, 40)
gearHeader.Position = UDim2.new(0, 16, 0, 16)
gearHeader.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
gearHeader.Text = "GEAR SHOP"
gearHeader.Font = Enum.Font.SourceSansBold
gearHeader.TextSize = 22
gearHeader.TextColor3 = Color3.fromRGB(255,255,255)
gearHeader.BorderSizePixel = 0
gearHeader.TextXAlignment = Enum.TextXAlignment.Center
gearHeader.Parent = gearFrame

local gearListFrame = Instance.new("ScrollingFrame")
gearListFrame.Name = "GearListFrame"
gearListFrame.Size = UDim2.new(1, -32, 1, -120)
gearListFrame.Position = UDim2.new(0, 16, 0, 56)
gearListFrame.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
gearListFrame.BorderSizePixel = 0
gearListFrame.ScrollBarThickness = 10
gearListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
gearListFrame.Parent = gearFrame
gearListFrame.ClipsDescendants = true

local gearOptions = {
    {name = "Watering Can", display = "Watering Can", rarity = "Common", uses = "10 Uses", effect = "Speeds Plant Growth", price = "50,000"},
    {name = "Trowel", display = "Trowel", rarity = "Uncommon", uses = "5 Uses", effect = "Helps to move plants", price = "100,000"},
    {name = "Recall Wrench", display = "Recall Wrench", rarity = "Uncommon", uses = "5 Uses", effect = "Teleports to the Gear Shop", price = "150,000"},
    {name = "Basic Sprinkler", display = "Basic Sprinkler", rarity = "Rare", uses = "5 mins", effect = "Speeds plant growth and increases fruit size", price = "20,000"},
    {name = "Advanced Sprinkler", display = "Advanced Sprinkler", rarity = "Legendary", uses = "5 mins", effect = "Increases plant growth, increases mutation chances, and runs for 5 minutes after placing", price = "50,000"},
    {name = "Godly Sprinkler", display = "Godly Sprinkler", rarity = "Mythical", uses = "5 mins", effect = "Speeds plant growth, increases mutation chances, increases fruit size, and runs for 5 minutes after placing", price = "100,000"},
    {name = "Magnifying Glass", display = "Magnifying Glass", rarity = "Mythical", uses = "10 Uses", effect = "Inspect fruits to reveal their price, without collecting them", price = "10,000,000"},
    {name = "Tanning Mirror", display = "Tanning Mirror", rarity = "Mythical", uses = "10 Uses", effect = "Redirects the Sun’s Beams towards random plants", price = "1,000,000"},
    {name = "Master Sprinkler", display = "Master Sprinkler", rarity = "Divine", uses = "10 mins", effect = "Speeds up plant growth, increases mutation chances, increases fruit size, and runs for 10 minutes after placing", price = "10,000,000"},
    {name = "Cleaning Spray", display = "Cleaning Spray", rarity = "Divine", uses = "10 Uses", effect = "Removes all mutations from a fruit.", price = "15,000,000"},
    {name = "Favorite Tool", display = "Favorite Tool", rarity = "Divine", uses = "20 Uses", effect = "Lock and unlock the best fruits to avoid accidental harvest", price = "20,000,000"},
    {name = "Harvest Tool", display = "Harvest Tool", rarity = "Divine", uses = "5 Uses", effect = "Harvests all fruits from the plant you select", price = "30,000,000"},
    {name = "Friendship Pot", display = "Friendship Pot", rarity = "Divine", uses = "1 Use", effect = "Links with other players to maintain a streak of growing plants together", price = "15,000,000"},
}

local selectedGear = {}
local function updateGearSelection()
    for _, btn in ipairs(gearListFrame:GetChildren()) do
        if btn:IsA("TextButton") then
            local isSelected = false
            for _, v in ipairs(selectedGear) do
                if v == btn.Name then isSelected = true break end
            end
            btn.BackgroundColor3 = isSelected and Color3.fromRGB(60, 200, 120) or Color3.fromRGB(100, 170, 220)
        end
    end
end

for i, gear in ipairs(gearOptions) do
    local btn = Instance.new("TextButton")
    btn.Name = gear.name
    btn.Size = UDim2.new(1, 0, 0, 54)
    btn.Position = UDim2.new(0, 0, 0, (i-1)*56)
    btn.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    btn.Text = string.format("%s [%s]\n%s | %s | %s Coins", gear.display, gear.rarity, gear.uses, gear.effect, gear.price)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BorderSizePixel = 0
    btn.TextWrapped = true
    btn.ZIndex = 2
    btn.Parent = gearListFrame
    btn.MouseButton1Click:Connect(function()
        local found = false
        for j, v in ipairs(selectedGear) do
            if v == gear.name then table.remove(selectedGear, j) found = true break end
        end
        if not found then table.insert(selectedGear, gear.name) end
        updateGearSelection()
    end)
end
gearListFrame.CanvasSize = UDim2.new(0, 0, 0, #gearOptions * 56)
updateGearSelection()

-- Buy Gear Button
local buyGearBtn = Instance.new("TextButton")
buyGearBtn.Name = "BuyGearBtn"
buyGearBtn.Size = UDim2.new(1, -32, 0, 48)
buyGearBtn.Position = UDim2.new(0, 16, 1, -56)
buyGearBtn.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
buyGearBtn.Text = "BUY SELECTED GEAR"
buyGearBtn.Font = Enum.Font.SourceSansBold
buyGearBtn.TextSize = 22
buyGearBtn.TextColor3 = Color3.fromRGB(255,255,255)
buyGearBtn.BorderSizePixel = 0
buyGearBtn.Parent = gearFrame

local buyGearRemote = ReplicatedStorage:FindFirstChild("GameEvents"):FindFirstChild("BuyGearStock")
buyGearBtn.MouseButton1Click:Connect(function()
    for _, gear in ipairs(selectedGear) do
        if buyGearRemote then
            print("[DEBUG] Buying gear:", gear)
            buyGearRemote:FireServer(gear)
        else
            warn("[DEBUG] BuyGearStock remote not found!")
        end
    end
end)

-- Helper to update toggle positions based on dropdowns
function updateShopTogglePositions()
    local y = 20
    local contentBottom = shopFrame.AbsolutePosition.Y + shopFrame.AbsoluteSize.Y
    -- Egg Dropdown Button
    eggDropdownBtn.Position = UDim2.new(0, 20, 0, y)
    y = y + 44
    -- Egg Dropdown List
    if eggDropdownList.Visible then
        local dropdownTop = shopFrame.AbsolutePosition.Y + y
        local maxHeight = contentBottom - dropdownTop - 20
        local needed = #eggOptions * 38
        local showHeight = math.max(0, math.min(needed, maxHeight))
        eggDropdownList.Position = UDim2.new(0, 20, 0, y)
        eggDropdownList.Size = UDim2.new(1, -40, 0, showHeight)
        eggDropdownList.CanvasSize = UDim2.new(0, 0, 0, needed)
        y = y + showHeight
    else
        eggDropdownList.Position = UDim2.new(0, 20, 0, y)
        eggDropdownList.Size = UDim2.new(1, -40, 0, 0)
    end
    -- Seed Dropdown Button
    seedDropdownBtn.Position = UDim2.new(0, 20, 0, y)
    y = y + 44
    -- Seed Dropdown List
    if seedDropdownList.Visible then
        local dropdownTop = shopFrame.AbsolutePosition.Y + y
        local maxHeight = contentBottom - dropdownTop - 20
        local needed = #seedOptions * 38
        local showHeight = math.max(0, math.min(needed, maxHeight))
        seedDropdownList.Position = UDim2.new(0, 20, 0, y)
        seedDropdownList.Size = UDim2.new(1, -40, 0, showHeight)
        seedDropdownList.CanvasSize = UDim2.new(0, 0, 0, needed)
        y = y + showHeight
    else
        seedDropdownList.Position = UDim2.new(0, 20, 0, y)
        seedDropdownList.Size = UDim2.new(1, -40, 0, 0)
    end
    -- Toggles
    autoBuyEggToggle.Position = UDim2.new(0, 20, 0, y + 18)
    autoBuySeedToggle.Position = UDim2.new(0, 20, 0, y + 18 + 54)
end

eggDropdownBtn.MouseButton1Click:Connect(function()
    eggDropdownList.Visible = not eggDropdownList.Visible
    updateShopTogglePositions()
end)

seedDropdownBtn.MouseButton1Click:Connect(function()
    seedDropdownList.Visible = not seedDropdownList.Visible
    updateShopTogglePositions()
end)

-- Hide dropdowns if clicking elsewhere
UserInputService.InputBegan:Connect(function(input, processed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local changed = false
        if eggDropdownList.Visible and not eggDropdownBtn:IsAncestorOf(input.Target) then
            eggDropdownList.Visible = false
            changed = true
        end
        if seedDropdownList.Visible and not seedDropdownBtn:IsAncestorOf(input.Target) then
            seedDropdownList.Visible = false
            changed = true
        end
        if changed then updateShopTogglePositions() end
    end
end)

-- Automation Remotes
local buyEggRemote = ReplicatedStorage:FindFirstChild("GameEvents"):FindFirstChild("BuyPetEgg")
local buySeedRemote = ReplicatedStorage:FindFirstChild("GameEvents"):FindFirstChild("BuySeedStock")

-- Helper: Check if an egg/seed is in stock (stub, should be replaced with real stock check if available)
local function isEggInStock(eggName)
    -- TODO: Replace with real stock check if possible
    return true -- Assume always in stock for now
end
local function isSeedInStock(seedName)
    -- TODO: Replace with real stock check if possible
    return true -- Assume always in stock for now
end

-- Auto-buy logic
local autoBuyEggLoopRunning = false
local autoBuySeedLoopRunning = false

-- Start auto-buy egg loop on script load
if not autoBuyEggLoopRunning then
    autoBuyEggLoopRunning = true
    task.spawn(function()
        while true do
            if autoBuyEggState then
                for _, egg in ipairs(selectedEggs) do
                    if isEggInStock(egg) then
                        if buyEggRemote then
                            buyEggRemote:FireServer(egg)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

-- Start auto-buy seed loop on script load
if not autoBuySeedLoopRunning then
    autoBuySeedLoopRunning = true
    task.spawn(function()
        while true do
            if autoBuySeedState then
                for _, seed in ipairs(selectedSeeds) do
                    if isSeedInStock(seed) then
                        if buySeedRemote then
                            buySeedRemote:FireServer(seed)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

-- Tab Switching Logic
local function selectTab(tabName)
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(80, 90, 110)
    end
    for name, frame in pairs(tabContent) do
        frame.Visible = (name == tabName)
    end
end
for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        selectTab(name)
    end)
end

-- Hide/Show Logic
local showUIButton = Instance.new("TextButton")
showUIButton.Name = "ShowUIButton"
showUIButton.Size = UDim2.new(0, 140, 0, 36)
showUIButton.Position = UDim2.new(0, 20, 0, 20)
showUIButton.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
showUIButton.Text = "Show GAG UI"
showUIButton.Font = Enum.Font.SourceSansBold
showUIButton.TextSize = 20
showUIButton.TextColor3 = Color3.fromRGB(255,255,255)
showUIButton.Visible = false
showUIButton.Parent = screenGui

local function hideUI()
    sidebar.Visible = false
    showUIButton.Visible = true
end
local function showUI()
    sidebar.Visible = true
    showUIButton.Visible = false
end
closeBtn.MouseButton1Click:Connect(hideUI)
showUIButton.MouseButton1Click:Connect(showUI)
minimizeBtn.MouseButton1Click:Connect(function()
    sidebar.Visible = not sidebar.Visible
    showUIButton.Visible = not sidebar.Visible
end)
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightShift then
        if sidebar.Visible then
            hideUI()
        else
            showUI()
        end
    end
end)

-- Initial tab selection
selectTab("EVENT")
