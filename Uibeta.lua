local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("SwitchHubUI") then
    CoreGui:FindFirstChild("SwitchHubUI"):Destroy()
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService") -- Thêm TweenService cho Notification

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
ToggleBtn.Image = "rbxassetid://16060333448" -- Avatar ID của bạn
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
MainFrame.Visible = false -- Ẩn lúc đầu
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Kéo thả Main Frame
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

-- 4. Topbar & Nút Xóa UI
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 40)
Topbar.BackgroundTransparency = 1
Topbar.Parent = MainFrame

local IconApp = Instance.new("ImageLabel")
IconApp.Size = UDim2.new(0, 20, 0, 20)
IconApp.Position = UDim2.new(0, 10, 0, 10)
IconApp.BackgroundTransparency = 1
IconApp.Image = "rbxassetid://16060333448"
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

-- Bảng Xác nhận Xóa UI
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

-- 5. Hệ thống Quản lý Trang & Tabs
local PagesFolder = Instance.new("Folder", MainFrame)
local Pages = {}
local SidebarButtons = {}
local InnerTabFrames = {}

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -150, 1, -80)
ContentArea.Position = UDim2.new(0, 150, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Hàm chuyển đổi Trang ở Menu Trái
local function SwitchSidebarTab(targetPageName)
    -- Ẩn tất cả trang và tab con đang mở
    for name, page in pairs(Pages) do
        page.Visible = (name == targetPageName)
        if page:FindFirstChild("CardsGrid") then
            page.CardsGrid.Visible = true -- Reset lại Grid khi vào trang
        end
    end
    for _, tab in pairs(InnerTabFrames) do
        tab.Visible = false
    end
    
    -- Cập nhật màu nút bên trái
    for name, btnData in pairs(SidebarButtons) do
        local isSelected = (name == targetPageName)
        btnData.Btn.BackgroundTransparency = isSelected and 0.93 or 1
        btnData.Icon.ImageColor3 = isSelected and Colors.ButtonBlue or Colors.TextGray
        btnData.Label.TextColor3 = isSelected and Colors.TextWhite or Colors.TextGray
    end
end

-- 6. Sidebar (Menu trái)
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

-- Hàm tạo Nút Sidebar
local function CreateSidebarButton(text, iconId, pageName)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Text = ""
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.Position = UDim2.new(0, 10, 0.5, -8)
    Icon.BackgroundTransparency = 1
    Icon.Image = iconId
    Icon.Parent = Btn
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -35, 1, 0)
    Label.Position = UDim2.new(0, 35, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Btn
    
    SidebarButtons[pageName] = {Btn = Btn, Icon = Icon, Label = Label}
    
    Btn.MouseButton1Click:Connect(function()
        SwitchSidebarTab(pageName)
    end)
end

-- 7. Hàm Tạo Trang và Chức năng (Cards & Click Tab)
local function CreatePage(pageName)
    local Page = Instance.new("Frame")
    Page.Name = pageName
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = ContentArea
    Pages[pageName] = Page
    
    local CardsGrid = Instance.new("Frame")
    CardsGrid.Name = "CardsGrid"
    CardsGrid.Size = UDim2.new(1, -20, 1, -20)
    CardsGrid.Position = UDim2.new(0, 10, 0, 10)
    CardsGrid.BackgroundTransparency = 1
    CardsGrid.Parent = Page

    local UIGridLayout = Instance.new("UIGridLayout")
    UIGridLayout.CellSize = UDim2.new(0.48, 0, 0, 110)
    UIGridLayout.CellPadding = UDim2.new(0.04, 0, 0, 15)
    UIGridLayout.Parent = CardsGrid

    return Page, CardsGrid
end

local function CreateCard(title, desc, parentGrid, pageName)
    local Card = Instance.new("Frame")
    Card.BackgroundColor3 = Colors.CardBG
    Card.BackgroundTransparency = 0.2
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(80, 80, 85)
    Stroke.Parent = Card

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 25)
    TitleLabel.Position = UDim2.new(0, 15, 0, 15)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Colors.TextWhite
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Card

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 15)
    DescLabel.Position = UDim2.new(0, 15, 0, 40)
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

    Card.Parent = parentGrid
    return ClickBtn
end

local function CreateInnerTab(tabName, parentPageName)
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Size = UDim2.new(1, -20, 1, -20)
    TabFrame.Position = UDim2.new(0, 10, 0, 10)
    TabFrame.BackgroundTransparency = 1
    TabFrame.ScrollBarThickness = 2
    TabFrame.Visible = false
    TabFrame.Parent = ContentArea
    InnerTabFrames[tabName] = TabFrame

    local BackBtn = Instance.new("TextButton")
    BackBtn.Size = UDim2.new(0, 80, 0, 25)
    BackBtn.BackgroundColor3 = Colors.CardBG
    BackBtn.Text = "<"
    BackBtn.TextColor3 = Colors.TextWhite
    BackBtn.Font = Enum.Font.GothamSemibold
    BackBtn.Parent = TabFrame
    Instance.new("UICorner", BackBtn).CornerRadius = UDim.new(0, 4)

    -- Nút quay lại: Ẩn tab hiện tại, hiện lại bảng CardsGrid của trang tương ứng
    BackBtn.MouseButton1Click:Connect(function()
        TabFrame.Visible = false
        if Pages[parentPageName] and Pages[parentPageName]:FindFirstChild("CardsGrid") then
            Pages[parentPageName].CardsGrid.Visible = true
        end
    end)
    return TabFrame
end

local function BindClickTab(clickBtn, tabFrame, parentGrid)
    clickBtn.MouseButton1Click:Connect(function()
        parentGrid.Visible = false
        for _, v in pairs(InnerTabFrames) do v.Visible = false end
        tabFrame.Visible = true
    end)
end

-- ================= CÀI ĐẶT CÁC TRANG & NÚT =================

-- Nút bên Sidebar với Icon
CreateSidebarButton("Farming", "rbxassetid://7733674079", "FarmingPage") 
CreateSidebarButton("</> Tools Beta", "rbxassetid://7733765045", "ToolsPage")
CreateSidebarButton("Setting", "rbxassetid://7733679610", "SettingPage")
CreateSidebarButton("Information", "rbxassetid://7733677306", "InfoPage")

-- TRANG 1: FARMING
local PageFarming, GridFarming = CreatePage("FarmingPage")
local c1 = CreateCard("Auto Fruits", "Nhặt Trái/Quay/lưu trữ", GridFarming, "FarmingPage")
local c2 = CreateCard("Teleport/Time", "Dịch Chuyển/thời gian", GridFarming, "FarmingPage")
local c3 = CreateCard("Farming", "Xương/Vua bột...", GridFarming, "FarmingPage")
local c4 = CreateCard("Esp Local", "Định vị...", GridFarming, "FarmingPage")

BindClickTab(c1, CreateInnerTab("AutoFruits_Tab", "FarmingPage"), GridFarming)
BindClickTab(c2, CreateInnerTab("Teleport_Tab", "FarmingPage"), GridFarming)
BindClickTab(c3, CreateInnerTab("Farm_Tab", "FarmingPage"), GridFarming)
BindClickTab(c4, CreateInnerTab("ESP_Tab", "FarmingPage"), GridFarming)

-- TRANG 2: TOOLS BETA
local PageTools, GridTools = CreatePage("ToolsPage")
local c5 = CreateCard("Server Hop", "Đổi máy chủ tự động", GridTools, "ToolsPage")
BindClickTab(c5, CreateInnerTab("ServerHop_Tab", "ToolsPage"), GridTools)

-- TRANG 3: SETTING
local PageSetting, GridSetting = CreatePage("SettingPage")
local c6 = CreateCard("Theme Color", "Đổi màu giao diện", GridSetting, "SettingPage")
local c7 = CreateCard("Binds", "Cài đặt phím tắt", GridSetting, "SettingPage")
BindClickTab(c6, CreateInnerTab("Theme_Tab", "SettingPage"), GridSetting)
BindClickTab(c7, CreateInnerTab("Binds_Tab", "SettingPage"), GridSetting)

-- TRANG 4: INFORMATION
local PageInfo, GridInfo = CreatePage("InfoPage")
local c8 = CreateCard("About Script", "Thông tin phiên bản", GridInfo, "InfoPage")
BindClickTab(c8, CreateInnerTab("About_Tab", "InfoPage"), GridInfo)

-- Mặc định mở tab Farming đầu tiên
SwitchSidebarTab("FarmingPage")


-- 8. Footer (Thanh dưới cùng)
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

-- ================= HỆ THỐNG THÔNG BÁO (NOTIFICATION) =================
local function SendNotification(title, text, duration)
    -- Tạo Frame thông báo
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 260, 0, 70)
    NotifFrame.Position = UDim2.new(1, 50, 1, -100) -- Bắt đầu ở ngoài màn hình (góc dưới phải)
    NotifFrame.BackgroundColor3 = Colors.CardBG
    NotifFrame.BorderSizePixel = 0
    NotifFrame.ZIndex = 100
    NotifFrame.Parent = ScreenGui
    
    -- Bo góc cho thông báo
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = NotifFrame
    
    -- Viền mỏng trang trí
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Colors.ButtonBlue
    Stroke.Thickness = 1.5
    Stroke.Parent = NotifFrame

    -- Tiêu đề
    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Size = UDim2.new(1, -20, 0, 30)
    TitleLbl.Position = UDim2.new(0, 10, 0, 5)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = title
    TitleLbl.TextColor3 = Colors.TextWhite
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.TextSize = 14
    TitleLbl.ZIndex = 101
    TitleLbl.Parent = NotifFrame

    -- Nội dung
    local MsgLbl = Instance.new("TextLabel")
    MsgLbl.Size = UDim2.new(1, -20, 0, 30)
    MsgLbl.Position = UDim2.new(0, 10, 0, 30)
    MsgLbl.BackgroundTransparency = 1
    MsgLbl.Text = text
    MsgLbl.TextColor3 = Color3.fromRGB(85, 255, 127) -- Màu xanh lá báo thành công
    MsgLbl.Font = Enum.Font.GothamSemibold
    MsgLbl.TextSize = 14
    MsgLbl.ZIndex = 101
    MsgLbl.Parent = NotifFrame

    -- Hiệu ứng trượt vào
    local tweenIn = TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -280, 1, -100)})
    tweenIn:Play()

    -- Đợi hết thời gian và trượt ra
    task.delay(duration, function()
        local tweenOut = TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 50, 1, -100)})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        NotifFrame:Destroy() -- Xóa UI Notification để giải phóng bộ nhớ
    end)
end

-- Kích hoạt thông báo khi vừa chạy script xong
SendNotification(" Switch Hub | Blox Fruits ", " Notification Thành Công ", 3.5)
