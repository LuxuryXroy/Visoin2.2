local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("SwitchHubUI") then
    CoreGui:FindFirstChild("SwitchHubUI"):Destroy()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Thông số màu sắc & UI
local Colors = {
    MainBG = Color3.fromRGB(30, 32, 38),
    SidebarBG = Color3.fromRGB(22, 24, 28),
    CardBG = Color3.fromRGB(40, 42, 48),
    ButtonBlue = Color3.fromRGB(44, 117, 216),
    TextWhite = Color3.fromRGB(255, 255, 255),
    TextGray = Color3.fromRGB(180, 180, 180)
}
local TransparencyBG = 0.15 

-- 1. Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SwitchHubUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- 2. Nút Bật/Tắt UI (Hình tròn có Avatar)
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Image = "rbxassetid://16060333448" -- Thay ID Avatar của bạn vào đây
local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

-- 3. Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 650, 0, 400)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
MainFrame.BackgroundColor3 = Colors.MainBG
MainFrame.BackgroundTransparency = TransparencyBG
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- 4. Topbar
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 40)
Topbar.BackgroundTransparency = 1
Topbar.Parent = MainFrame

local IconApp = Instance.new("ImageLabel")
IconApp.Size = UDim2.new(0, 20, 0, 20)
IconApp.Position = UDim2.new(0, 10, 0, 10)
IconApp.BackgroundTransparency = 1
IconApp.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png" -- Bạn có thể thay ID icon cỏ 4 lá vào đây
IconApp.Parent = Topbar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 40, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Switch Hub | Blox Fruit"
Title.TextColor3 = Colors.TextWhite
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Topbar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.TextGray
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Topbar

-- 5. Bảng Xác nhận Xóa UI
local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Size = UDim2.new(0, 250, 0, 120)
ConfirmFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ConfirmFrame.Visible = false
ConfirmFrame.ZIndex = 10
ConfirmFrame.Parent = MainFrame
Instance.new("UICorner", ConfirmFrame).CornerRadius = UDim.new(0, 8)

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Size = UDim2.new(1, 0, 0, 50)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "Đóng hoàn toàn UI?"
ConfirmText.TextColor3 = Colors.TextWhite
ConfirmText.Font = Enum.Font.GothamSemibold
ConfirmText.TextWrapped = true
ConfirmText.ZIndex = 11
ConfirmText.Parent = ConfirmFrame

local YesBtn = Instance.new("TextButton")
YesBtn.Size = UDim2.new(0, 90, 0, 35)
YesBtn.Position = UDim2.new(0, 20, 1, -45)
YesBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
YesBtn.Text = "Đóng"
YesBtn.TextColor3 = Colors.TextWhite
YesBtn.Font = Enum.Font.GothamBold
YesBtn.ZIndex = 11
YesBtn.Parent = ConfirmFrame
Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0, 6)

local NoBtn = Instance.new("TextButton")
NoBtn.Size = UDim2.new(0, 90, 0, 35)
NoBtn.Position = UDim2.new(1, -110, 1, -45)
NoBtn.BackgroundColor3 = Colors.CardBG
NoBtn.Text = "Hủy"
NoBtn.TextColor3 = Colors.TextWhite
NoBtn.Font = Enum.Font.GothamBold
NoBtn.ZIndex = 11
NoBtn.Parent = ConfirmFrame
Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = true end)
NoBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = false end)
YesBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- 6. BỔ SUNG: Sidebar & Các Nút Menu
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, -80)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Colors.SidebarBG
Sidebar.BackgroundTransparency = 0.5
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.Padding = UDim.new(0, 5)

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.Parent = Sidebar
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.PaddingLeft = UDim.new(0, 10)
SidebarPadding.PaddingRight = UDim.new(0, 10)

-- Lệnh tạo nút bên Menu trái
local function CreateSidebarButton(text, isSelected)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.BackgroundTransparency = isSelected and 0.93 or 1 -- Nút được chọn sẽ sáng nhẹ lên
    Btn.Text = ""
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.Position = UDim2.new(0, 10, 0.5, -8)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png" -- Cần thay ID icon tương ứng
    Icon.ImageColor3 = isSelected and Colors.ButtonBlue or Colors.TextGray
    Icon.Parent = Btn
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -35, 1, 0)
    Label.Position = UDim2.new(0, 35, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = isSelected and Colors.TextWhite or Colors.TextGray
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Btn
    
    return Btn
end

-- Tạo 4 nút như trong ảnh
local SidebarBtn1 = CreateSidebarButton("Farming", true) 
local SidebarBtn2 = CreateSidebarButton("</> Tools Beta", false)
local SidebarBtn3 = CreateSidebarButton("Setting", false)
local SidebarBtn4 = CreateSidebarButton("Information", false)

-- 7. Khu vực Nội dung chính (Các thẻ bên phải)
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -150, 1, -80)
ContentArea.Position = UDim2.new(0, 150, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local CardsGrid = Instance.new("Frame")
CardsGrid.Size = UDim2.new(1, -20, 1, -20)
CardsGrid.Position = UDim2.new(0, 10, 0, 10)
CardsGrid.BackgroundTransparency = 1
CardsGrid.Parent = ContentArea

local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.CellSize = UDim2.new(0.48, 0, 0, 110)
UIGridLayout.CellPadding = UDim2.new(0.04, 0, 0, 15)
UIGridLayout.Parent = CardsGrid

-- Hàm tạo các Thẻ (Card)
local function CreateCard(title, desc, parent)
    local Card = Instance.new("Frame")
    Card.BackgroundColor3 = Colors.CardBG
    Card.BackgroundTransparency = 0.2
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(80, 80, 85)
    Stroke.Parent = Card

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -60, 0, 25)
    TitleLabel.Position = UDim2.new(0, 60, 0, 15)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Colors.TextWhite
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Card

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -60, 0, 15)
    DescLabel.Position = UDim2.new(0, 60, 0, 40)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = desc
    DescLabel.TextColor3 = Colors.TextGray
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 12
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = Card

    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Size = UDim2.new(1, -20, 0, 25)
    ClickBtn.Position = UDim2.new(0, 10, 1, -35)
    ClickBtn.BackgroundColor3 = Colors.ButtonBlue
    ClickBtn.Text = "Click Tab"
    ClickBtn.TextColor3 = Colors.TextWhite
    ClickBtn.Font = Enum.Font.GothamBold
    ClickBtn.TextSize = 14
    ClickBtn.Parent = Card
    Instance.new("UICorner", ClickBtn).CornerRadius = UDim.new(0, 4)

    Card.Parent = parent
    return ClickBtn, Card
end

-- 8. Tạo Tabs & Logic chuyển đổi Tab
local TabFrames = {}
local function CreateTab(name)
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Size = UDim2.new(1, -20, 1, -20)
    TabFrame.Position = UDim2.new(0, 10, 0, 10)
    TabFrame.BackgroundTransparency = 1
    TabFrame.ScrollBarThickness = 2
    TabFrame.Visible = false
    TabFrame.Parent = ContentArea
    TabFrames[name] = TabFrame

    local BackBtn = Instance.new("TextButton")
    BackBtn.Size = UDim2.new(0, 80, 0, 25)
    BackBtn.BackgroundColor3 = Colors.CardBG
    BackBtn.Text = "< Quay Lại"
    BackBtn.TextColor3 = Colors.TextWhite
    BackBtn.Font = Enum.Font.GothamSemibold
    BackBtn.Parent = TabFrame
    Instance.new("UICorner", BackBtn).CornerRadius = UDim.new(0, 4)

    BackBtn.MouseButton1Click:Connect(function()
        TabFrame.Visible = false
        CardsGrid.Visible = true
    end)
    return TabFrame
end

local btn1 = CreateCard("Auto Fruits", "Nhặt Trái/Quay/lưu trữ", CardsGrid)
local btn2 = CreateCard("Teleport/Time", "Dịch Chuyển/thời gian", CardsGrid)
local btn3 = CreateCard("Farming", "Xương/Vua bột...", CardsGrid)
local btn4 = CreateCard("Esp Local", "Định vị...", CardsGrid)

local tab1 = CreateTab("Auto Fruits")
local tab2 = CreateTab("Teleport/Time")
local tab3 = CreateTab("Farming")
local tab4 = CreateTab("Esp Local")

local function bindTabBtn(btn, tabFrame)
    btn.MouseButton1Click:Connect(function()
        CardsGrid.Visible = false
        for _, v in pairs(TabFrames) do v.Visible = false end
        tabFrame.Visible = true
    end)
end
bindTabBtn(btn1, tab1); bindTabBtn(btn2, tab2); bindTabBtn(btn3, tab3); bindTabBtn(btn4, tab4)

-- 9. Footer (Thanh dưới cùng)
local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, 0, 0, 40)
Footer.Position = UDim2.new(0, 0, 1, -40)
Footer.BackgroundTransparency = 1
Footer.Parent = MainFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0, 150, 0, 24)
SearchBox.Position = UDim2.new(0, 160, 0.5, -12)
SearchBox.BackgroundColor3 = Colors.CardBG
SearchBox.Text = "  🔍 Search..."
SearchBox.TextColor3 = Colors.TextGray
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.Parent = Footer
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 12)

local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(0, 300, 1, 0)
Watermark.Position = UDim2.new(1, -310, 0, 0)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Vision 2.1 | Blox Fruit | By - ObiiSenPai"
Watermark.TextColor3 = Colors.TextWhite
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 12
Watermark.TextXAlignment = Enum.TextXAlignment.Right
Watermark.Parent = Footer
