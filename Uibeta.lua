-- Switch Hub Blox Fruit UI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SwitchHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame (Khung chính)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Góc bo tròn cho mainFrame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Stroke cho mainFrame
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(65, 65, 75)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Title Bar (Thanh tiêu đề)
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Title Background (Nền tiêu đề)
local titleBg = Instance.new("Frame")
titleBg.Name = "TitleBg"
titleBg.Size = UDim2.new(1, -20, 1, -10)
titleBg.Position = UDim2.new(0, 10, 0, 5)
titleBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
titleBg.BorderSizePixel = 0
titleBg.Parent = titleBar

local titleBgCorner = Instance.new("UICorner")
titleBgCorner.CornerRadius = UDim.new(0, 8)
titleBgCorner.Parent = titleBg

-- Title Stroke
local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(60, 60, 75)
titleStroke.Thickness = 1
titleStroke.Parent = titleBg

-- Logo (Biểu tượng lá)
local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(0, 32, 0, 32)
logo.Position = UDim2.new(0, 15, 0.5, -16)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://6031086208" -- Leaf icon, thay bằng ID thực tế
logo.ImageColor3 = Color3.fromRGB(0, 255, 127)
logo.Parent = titleBg

-- Title Text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -70, 1, 0)
titleText.Position = UDim2.new(0, 55, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Switch Hub | Blox Fruit"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBg

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -90, 0.5, -15)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.Gotham
minimizeBtn.Parent = titleBg

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeBtn

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -50, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBg

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Left Sidebar (Thanh bên trái)
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 180, 1, -60)
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.BackgroundTransparency = 1
sidebar.Parent = mainFrame

-- Sidebar Items
local sidebarItems = {
    {name = "Farming", icon = "rbxassetid://6035048492", selected = false},
    {name = "Tools Beta", icon = "rbxassetid://6031090957", selected = true},
    {name = "Setting", icon = "rbxassetid://6031090262", selected = false},
    {name = "Information", icon = "rbxassetid://6031090957", selected = false}
}

for i, item in ipairs(sidebarItems) do
    local itemFrame = Instance.new("Frame")
    itemFrame.Name = item.name
    itemFrame.Size = UDim2.new(1, -10, 0, 40)
    itemFrame.Position = UDim2.new(0, 5, 0, (i-1) * 45 + 10)
    itemFrame.BackgroundTransparency = 1
    itemFrame.Parent = sidebar
    
    local itemIcon = Instance.new("ImageLabel")
    itemIcon.Name = "Icon"
    itemIcon.Size = UDim2.new(0, 24, 0, 24)
    itemIcon.Position = UDim2.new(0, 10, 0.5, -12)
    itemIcon.BackgroundTransparency = 1
    itemIcon.Image = item.icon
    itemIcon.ImageColor3 = item.selected and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(150, 150, 160)
    itemIcon.Parent = itemFrame
    
    local itemText = Instance.new("TextLabel")
    itemText.Name = "Text"
    itemText.Size = UDim2.new(1, -45, 1, 0)
    itemText.Position = UDim2.new(0, 40, 0, 0)
    itemText.BackgroundTransparency = 1
    itemText.Text = item.name
    itemText.TextColor3 = item.selected and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(180, 180, 190)
    itemText.TextScaled = true
    itemText.Font = Enum.Font.Gotham
    itemText.TextXAlignment = Enum.TextXAlignment.Left
    itemText.Parent = itemFrame
    
    -- Selection indicator
    if item.selected then
        local selectionIndicator = Instance.new("Frame")
        selectionIndicator.Name = "SelectionIndicator"
        selectionIndicator.Size = UDim2.new(0, 3, 1, 0)
        selectionIndicator.Position = UDim2.new(0, -3, 0, 0)
        selectionIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
        selectionIndicator.BorderSizePixel = 0
        selectionIndicator.Parent = itemFrame
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(0, 2)
        indicatorCorner.Parent = selectionIndicator
    end
end

-- Content Area (Khu vực nội dung chính)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -190, 1, -60)
contentFrame.Position = UDim2.new(0, 180, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Tab Buttons Row 1
local tabRow1 = Instance.new("Frame")
tabRow1.Name = "TabRow1"
tabRow1.Size = UDim2.new(1, -20, 0, 120)
tabRow1.Position = UDim2.new(0, 10, 0, 10)
tabRow1.BackgroundTransparency = 1
tabRow1.Parent = contentFrame

-- Auto Fruits Tab
local autoFruitsTab = Instance.new("TextButton")
autoFruitsTab.Name = "AutoFruitsTab"
autoFruitsTab.Size = UDim2.new(0, 160, 0, 100)
autoFruitsTab.Position = UDim2.new(0, 10, 0, 10)
autoFruitsTab.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
autoFruitsTab.BorderSizePixel = 0
autoFruitsTab.Text = ""
autoFruitsTab.Parent = tabRow1

local autoFruitsCorner = Instance.new("UICorner")
autoFruitsCorner.CornerRadius = UDim.new(0, 10)
autoFruitsCorner.Parent = autoFruitsTab

local autoFruitsStroke = Instance.new("UIStroke")
autoFruitsStroke.Color = Color3.fromRGB(65, 65, 75)
autoFruitsStroke.Thickness = 1
autoFruitsStroke.Parent = autoFruitsTab

-- Auto Fruits Icon (Quả bóng)
local fruitsIcon = Instance.new("ImageLabel")
fruitsIcon.Name = "Icon"
fruitsIcon.Size = UDim2.new(0, 60, 0, 60)
fruitsIcon.Position = UDim2.new(0.5, -30, 0, 10)
fruitsIcon.BackgroundTransparency = 1
fruitsIcon.Image = "rbxassetid://6035048492" -- Fruit icon
fruitsIcon.ImageColor3 = Color3.fromRGB(255, 200, 0)
fruitsIcon.Parent = autoFruitsTab

-- Auto Fruits Title
local autoFruitsTitle = Instance.new("TextLabel")
autoFruitsTitle.Name = "Title"
autoFruitsTitle.Size = UDim2.new(1, 0, 0, 20)
autoFruitsTitle.Position = UDim2.new(0, 0, 0, 75)
autoFruitsTitle.BackgroundTransparency = 1
autoFruitsTitle.Text = "Auto Fruits"
autoFruitsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFruitsTitle.TextScaled = true
autoFruitsTitle.Font = Enum.Font.GothamSemibold
autoFruitsTitle.Parent = autoFruitsTab

-- Auto Fruits Subtitle
local autoFruitsSubtitle = Instance.new("TextLabel")
autoFruitsSubtitle.Name = "Subtitle"
autoFruitsSubtitle.Size = UDim2.new(1, 0, 0, 15)
autoFruitsSubtitle.Position = UDim2.new(0, 0, 0, 95)
autoFruitsSubtitle.BackgroundTransparency = 1
autoFruitsSubtitle.Text = "Mua tự động trái cây"
autoFruitsSubtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
autoFruitsSubtitle.TextScaled = true
autoFruitsSubtitle.Font = Enum.Font.Gotham
autoFruitsSubtitle.Parent = autoFruitsTab

-- Click Tab Button
local clickTabBtn = Instance.new("TextButton")
clickTabBtn.Name = "ClickTabBtn"
clickTabBtn.Size = UDim2.new(0, 80, 0, 30)
clickTabBtn.Position = UDim2.new(0.5, -40, 1, -40)
clickTabBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
clickTabBtn.BorderSizePixel = 0
clickTabBtn.Text = "Click Tab"
clickTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clickTabBtn.TextScaled = true
clickTabBtn.Font = Enum.Font.GothamBold
clickTabBtn.Parent = autoFruitsTab

local clickTabCorner = Instance.new("UICorner")
clickTabCorner.CornerRadius = UDim.new(0, 6)
clickTabCorner.Parent = clickTabBtn

-- Teleport/Time Tab
local teleportTab = Instance.new("TextButton")
teleportTab.Name = "TeleportTab"
teleportTab.Size = UDim2.new(0, 160, 0, 100)
teleportTab.Position = UDim2.new(0, 180, 0, 10)
teleportTab.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
teleportTab.BorderSizePixel = 0
teleportTab.Text = ""
teleportTab.Parent = tabRow1

local teleportCorner = Instance.new("UICorner")
teleportCorner.CornerRadius = UDim.new(0, 10)
teleportCorner.Parent = teleportTab

local teleportStroke = Instance.new("UIStroke")
teleportStroke.Color = Color3.fromRGB(65, 65, 75)
teleportStroke.Thickness = 1
teleportStroke.Parent = teleportTab

-- Teleport Icon (Bản đồ)
local teleportIcon = Instance.new("ImageLabel")
teleportIcon.Name = "Icon"
teleportIcon.Size = UDim2.new(0, 60, 0, 60)
teleportIcon.Position = UDim2.new(0.5, -30, 0, 10)
teleportIcon.BackgroundTransparency = 1
teleportIcon.Image = "rbxassetid://6031090262" -- Map icon
teleportIcon.ImageColor3 = Color3.fromRGB(100, 200, 255)
teleportIcon.Parent = teleportTab

-- Teleport Title
local teleportTitle = Instance.new("TextLabel")
teleportTitle.Name = "Title"
teleportTitle.Size = UDim2.new(1, 0, 0, 20)
teleportTitle.Position = UDim2.new(0, 0, 0, 75)
teleportTitle.BackgroundTransparency = 1
teleportTitle.Text = "Teleport/Time"
teleportTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportTitle.TextScaled = true
teleportTitle.Font = Enum.Font.GothamSemibold
teleportTitle.Parent = teleportTab

-- Teleport Subtitle
local teleportSubtitle = Instance.new("TextLabel")
teleportSubtitle.Name = "Subtitle"
teleportSubtitle.Size = UDim2.new(1, 0, 0, 15)
teleportSubtitle.Position = UDim2.new(0, 0, 0, 95)
teleportSubtitle.BackgroundTransparency = 1
teleportSubtitle.Text = "Di chuyển nhanh/Giờ"
teleportSubtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
teleportSubtitle.TextScaled = true
teleportSubtitle.Font = Enum.Font.Gotham
teleportSubtitle.Parent = teleportTab

-- Teleport Click Tab
local teleportClickBtn = Instance.new("TextButton")
teleportClickBtn.Name = "TeleportClickBtn"
teleportClickBtn.Size = UDim2.new(0, 80, 0, 30)
teleportClickBtn.Position = UDim2.new(0.5, -40, 1, -40)
teleportClickBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
teleportClickBtn.BorderSizePixel = 0
teleportClickBtn.Text = "Click Tab"
teleportClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportClickBtn.TextScaled = true
teleportClickBtn.Font = Enum.Font.GothamBold
teleportClickBtn.Parent = teleportTab

local teleportClickCorner = Instance.new("UICorner")
teleportClickCorner.CornerRadius = UDim.new(0, 6)
teleportClickCorner.Parent = teleportClickBtn

-- Tab Row 2
local tabRow2 = Instance.new("Frame")
tabRow2.Name = "TabRow2"
tabRow2.Size = UDim2.new(1, -20, 0, 120)
tabRow2.Position = UDim2.new(0, 10, 0, 140)
tabRow2.BackgroundTransparency = 1
tabRow2.Parent = contentFrame

-- Farming Tab
local farmingTab = Instance.new("TextButton")
farmingTab.Name = "FarmingTab"
farmingTab.Size = UDim2.new(0, 160, 0, 100)
farmingTab.Position = UDim2.new(0, 10, 0, 10)
farmingTab.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
farmingTab.BorderSizePixel = 0
farmingTab.Text = ""
farmingTab.Parent = tabRow2

local farmingCorner = Instance.new("UICorner")
farmingCorner.CornerRadius = UDim.new(0, 10)
farmingCorner.Parent = farmingTab

local farmingStroke = Instance.new("UIStroke")
farmingStroke.Color = Color3.fromRGB(65, 65, 75)
farmingStroke.Thickness = 1
farmingStroke.Parent = farmingTab

-- Farming Icon (Bò)
local farmingIcon = Instance.new("ImageLabel")
farmingIcon.Name = "Icon"
farmingIcon.Size = UDim2.new(0, 60, 0, 60)
farmingIcon.Position = UDim2.new(0.5, -30, 0, 10)
farmingIcon.BackgroundTransparency = 1
farmingIcon.Image = "rbxassetid://6035048492" -- Cow icon
farmingIcon.ImageColor3 = Color3.fromRGB(255, 150, 0)
farmingIcon.Parent = farmingTab

-- Farming Title
local farmingTitle = Instance.new("TextLabel")
farmingTitle.Name = "Title"
farmingTitle.Size = UDim2.new(1, 0, 0, 20)
farmingTitle.Position = UDim2.new(0, 0, 0, 75)
farmingTitle.BackgroundTransparency = 1
farmingTitle.Text = "Farming"
farmingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
farmingTitle.TextScaled = true
farmingTitle.Font = Enum.Font.GothamSemibold
farmingTitle.Parent = farmingTab

-- Farming Subtitle
local farmingSubtitle = Instance.new("TextLabel")
farmingSubtitle.Name = "Subtitle"
farmingSubtitle.Size = UDim2.new(1, 0, 0, 15)
farmingSubtitle.Position = UDim2.new(0, 0, 0, 95)
farmingSubtitle.BackgroundTransparency = 1
farmingSubtitle.Text = "Nông trại tự động..."
farmingSubtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
farmingSubtitle.TextScaled = true
farmingSubtitle.Font = Enum.Font.Gotham
farmingSubtitle.Parent = farmingTab

-- Farming Click Tab
local farmingClickBtn = Instance.new("TextButton")
farmingClickBtn.Name = "FarmingClickBtn"
farmingClickBtn.Size = UDim2.new(0, 80, 0, 30)
farmingClickBtn.Position = UDim2.new(0.5, -40, 1, -40)
farmingClickBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
farmingClickBtn.BorderSizePixel = 0
farmingClickBtn.Text = "Click Tab"
farmingClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
farmingClickBtn.TextScaled = true
farmingClickBtn.Font = Enum.Font.GothamBold
farmingClickBtn.Parent = farmingTab

local farmingClickCorner = Instance.new("UICorner")
farmingClickCorner.CornerRadius = UDim.new(0, 6)
farmingClickCorner.Parent = farmingClickBtn

-- ESP Local Tab
local espTab = Instance.new("TextButton")
espTab.Name = "EspTab"
espTab.Size = UDim2.new(0, 160, 0, 100)
espTab.Position = UDim2.new(0, 180, 0, 10)
espTab.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
espTab.BorderSizePixel = 0
espTab.Text = ""
espTab.Parent = tabRow2

local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 10)
espCorner.Parent = espTab

local espStroke = Instance.new("UIStroke")
espStroke.Color = Color3.fromRGB(65, 65, 75)
espStroke.Thickness = 1
espStroke.Parent = espTab

-- ESP Icon (Mắt)
local espIcon = Instance.new("ImageLabel")
espIcon.Name = "Icon"
espIcon.Size = UDim2.new(0, 60, 0, 60)
espIcon.Position = UDim2.new(0.5, -30, 0, 10)
espIcon.BackgroundTransparency = 1
espIcon.Image = "rbxassetid://6031090957" -- Eye icon
espIcon.ImageColor3 = Color3.fromRGB(255, 100, 100)
espIcon.Parent = espTab

-- ESP Title
local espTitle = Instance.new("TextLabel")
espTitle.Name = "Title"
espTitle.Size = UDim2.new(1, 0, 0, 20)
espTitle.Position = UDim2.new(0, 0, 0, 75)
espTitle.BackgroundTransparency = 1
espTitle.Text = "Esp Local"
espTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
espTitle.TextScaled = true
espTitle.Font = Enum.Font.GothamSemibold
espTitle.Parent = espTab

-- ESP Subtitle
local espSubtitle = Instance.new("TextLabel")
espSubtitle.Name = "Subtitle"
espSubtitle.Size = UDim2.new(1, 0, 0, 15)
espSubtitle.Position = UDim2.new(0, 0, 0, 95)
espSubtitle.BackgroundTransparency = 1
espSubtitle.Text = "Phát hiện..."
espSubtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
espSubtitle.TextScaled = true
espSubtitle.Font = Enum.Font.Gotham
espSubtitle.Parent = espTab

-- ESP Click Tab
local espClickBtn = Instance.new("TextButton")
espClickBtn.Name = "EspClickBtn"
espClickBtn.Size = UDim2.new(0, 80, 0, 30)
espClickBtn.Position = UDim2.new(0.5, -40, 1, -40)
espClickBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espClickBtn.BorderSizePixel = 0
espClickBtn.Text = "Click Tab"
espClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espClickBtn.TextScaled = true
espClickBtn.Font = Enum.Font.GothamBold
espClickBtn.Parent = espTab

local espClickCorner = Instance.new("UICorner")
espClickCorner.CornerRadius = UDim.new(0, 6)
espClickCorner.Parent = espClickBtn

-- Bottom Bar (Thanh dưới cùng)
local bottomBar = Instance.new("Frame")
bottomBar.Name = "BottomBar"
bottomBar.Size = UDim2.new(1, -20, 0, 30)
bottomBar.Position = UDim2.new(0, 10, 1, -40)
bottomBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
bottomBar.BorderSizePixel = 0
bottomBar.Parent = contentFrame

local bottomCorner = Instance.new("UICorner")
bottomCorner.CornerRadius = UDim.new(0, 8)
bottomCorner.Parent = bottomBar

local bottomStroke = Instance.new("UIStroke")
bottomStroke.Color = Color3.fromRGB(50, 50, 60)
bottomStroke.Thickness = 1
bottomStroke.Parent = bottomBar

-- Version Text
local versionText = Instance.new("TextLabel")
versionText.Name = "VersionText"
versionText.Size = UDim2.new(1, -10, 1, 0)
versionText.Position = UDim2.new(0, 5, 0, 0)
versionText.BackgroundTransparency = 1
versionText.Text = "Version 2.1 | Blox Fruit | By ObiSenPai"
versionText.TextColor3 = Color3.fromRGB(120, 120, 130)
versionText.TextScaled = true
versionText.Font = Enum.Font.Gotham
versionText.TextXAlignment = Enum.TextXAlignment.Left
versionText.Parent = bottomBar

-- Star decoration
local star = Instance.new("TextLabel")
star.Name = "Star"
star.Size = UDim2.new(0, 20, 1, 0)
star.Position = UDim2.new(1, -25, 0, 0)
star.BackgroundTransparency = 1
star.Text = "✦"
star.TextColor3 = Color3.fromRGB(100, 200, 255)
star.TextScaled = true
star.Font = Enum.Font.SourceSans
star.TextXAlignment = Enum.TextXAlignment.Right
star.Parent = bottomBar

-- Animation Functions
local function createHoverEffect(button)
    local originalColor = button.BackgroundColor3
    local hoverColor = Color3.fromRGB(originalColor.R * 255 + 20, originalColor.G * 255 + 20, originalColor.B * 255 + 20)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(hoverColor.R, hoverColor.G, hoverColor.B)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
    end)
end

-- Apply hover effects
local buttons = {minimizeBtn, closeBtn, clickTabBtn, teleportClickBtn, farmingClickBtn, espClickBtn}
for _, btn in ipairs(buttons) do
    createHoverEffect(btn)
end

-- Close button functionality
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Minimize button functionality
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Tab button functionality (example)
local function createTabClick(tabBtn, contentName)
    tabBtn.MouseButton1Click:Connect(function()
        print("Clicked " .. contentName .. " tab")
        -- Add your tab switching logic here
    end)
end

createTabClick(autoFruitsTab, "Auto Fruits")
createTabClick(teleportTab, "Teleport/Time")
createTabClick(farmingTab, "Farming")
createTabClick(espTab, "ESP Local")

-- Sidebar selection
local function updateSidebarSelection(selectedItem)
    for _, child in ipairs(sidebar:GetChildren()) do
        if child:IsA("Frame") then
            local indicator = child:FindFirstChild("SelectionIndicator")
            local icon = child:FindFirstChild("Icon")
            local text = child:FindFirstChild("Text")
            
            if child.Name == selectedItem then
                if indicator then indicator:Destroy() end
                
                local newIndicator = Instance.new("Frame")
                newIndicator.Name = "SelectionIndicator"
                newIndicator.Size = UDim2.new(0, 3, 1, 0)
                newIndicator.Position = UDim2.new(0, -3, 0, 0)
                newIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
                newIndicator.BorderSizePixel = 0
                newIndicator.Parent = child
                
                local indCorner = Instance.new("UICorner")
                indCorner.CornerRadius = UDim.new(0, 2)
                indCorner.Parent = newIndicator
                
                if icon then icon.ImageColor3 = Color3.fromRGB(0, 255, 127) end
                if text then text.TextColor3 = Color3.fromRGB(0, 255, 127) end
            else
                if indicator then indicator:Destroy() end
                if icon then icon.ImageColor3 = Color3.fromRGB(150, 150, 160) end
                if text then text.TextColor3 = Color3.fromRGB(180, 180, 190) end
            end
        end
    end
end

-- Make draggable
local dragging = false
local dragStart = nil
local startPos = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Initial sidebar selection
updateSidebarSelection("Tools Beta")

print("Switch Hub UI loaded successfully!")
