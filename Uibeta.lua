-- ================================================================
--   SWITCH HUB | BLOX FRUIT  —  Vision 2.1
--   By: ObiiSenPai  |  Farm Tab tích hợp đầy đủ
-- ================================================================

local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("SwitchHubUI") then
    CoreGui:FindFirstChild("SwitchHubUI"):Destroy()
end

local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local ReplicatedStorage= game:GetService("ReplicatedStorage")
local RunService       = game:GetService("RunService")
local LocalPlayer      = Players.LocalPlayer

-- ── Màu sắc & hằng số ────────────────────────────────────────────
local Colors = {
    MainBG     = Color3.fromRGB(30,  32,  38),
    SidebarBG  = Color3.fromRGB(22,  24,  28),
    CardBG     = Color3.fromRGB(40,  42,  48),
    ButtonBlue = Color3.fromRGB(44, 117, 216),
    ToggleOn   = Color3.fromRGB(44, 200,  90),
    ToggleOff  = Color3.fromRGB(80,  80,  88),
    TextWhite  = Color3.fromRGB(255,255,255),
    TextGray   = Color3.fromRGB(180,180,180),
}
local TransparencyBG = 0.15

-- ================================================================
--   PHẦN 1 – KHUNG CHÍNH UI
-- ================================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name            = "SwitchHubUI"
ScreenGui.Parent          = CoreGui
ScreenGui.ResetOnSpawn    = false

-- Nút toggle tròn (avatar)
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name             = "ToggleButton"
ToggleBtn.Parent           = ScreenGui
ToggleBtn.Size             = UDim2.new(0,50,0,50)
ToggleBtn.Position         = UDim2.new(0.1,0,0.1,0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
ToggleBtn.Image            = "rbxassetid://16060333448"
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)

-- Kéo thả ToggleBtn
local tb_drag, tb_dragStart, tb_startPos
ToggleBtn.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        tb_drag = true; tb_dragStart = inp.Position; tb_startPos = ToggleBtn.Position
    end
end)
UserInputService.InputChanged:Connect(function(inp)
    if tb_drag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local d = inp.Position - tb_dragStart
        ToggleBtn.Position = UDim2.new(tb_startPos.X.Scale, tb_startPos.X.Offset+d.X, tb_startPos.Y.Scale, tb_startPos.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        tb_drag = false
    end
end)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name                  = "MainFrame"
MainFrame.Parent                = ScreenGui
MainFrame.Size                  = UDim2.new(0,650,0,420)
MainFrame.Position              = UDim2.new(0.5,-325,0.5,-210)
MainFrame.BackgroundColor3      = Colors.MainBG
MainFrame.BackgroundTransparency= TransparencyBG
MainFrame.BorderSizePixel       = 0
MainFrame.ClipsDescendants      = true
MainFrame.Visible               = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,8)

-- Kéo thả MainFrame
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
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
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
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

-- ── Topbar ──────────────────────────────────────────────────────
local Topbar = Instance.new("Frame")
Topbar.Size                  = UDim2.new(1,0,0,40)
Topbar.BackgroundTransparency= 1
Topbar.Parent                = MainFrame

local IconApp = Instance.new("ImageLabel")
IconApp.Size                  = UDim2.new(0,20,0,20)
IconApp.Position              = UDim2.new(0,10,0,10)
IconApp.BackgroundTransparency= 1
IconApp.Image                 = "rbxassetid://16060333448"
IconApp.Parent                = Topbar

local Title = Instance.new("TextLabel")
Title.Size              = UDim2.new(0,260,1,0)
Title.Position          = UDim2.new(0,40,0,0)
Title.BackgroundTransparency= 1
Title.Text              = "Switch Hub | Blox Fruit"
Title.TextColor3        = Colors.TextWhite
Title.TextSize          = 16
Title.Font              = Enum.Font.GothamBold
Title.TextXAlignment    = Enum.TextXAlignment.Left
Title.Parent            = Topbar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size                  = UDim2.new(0,30,0,30)
CloseBtn.Position              = UDim2.new(1,-35,0,5)
CloseBtn.BackgroundTransparency= 1
CloseBtn.Text                  = "✕"
CloseBtn.TextColor3            = Colors.TextGray
CloseBtn.TextSize              = 16
CloseBtn.Font                  = Enum.Font.GothamBold
CloseBtn.Parent                = Topbar

-- Xác nhận đóng UI
local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Size            = UDim2.new(0,250,0,120)
ConfirmFrame.Position        = UDim2.new(0.5,-125,0.5,-60)
ConfirmFrame.BackgroundColor3= Color3.fromRGB(20,20,25)
ConfirmFrame.Visible         = false
ConfirmFrame.ZIndex          = 10
ConfirmFrame.Parent          = MainFrame
Instance.new("UICorner", ConfirmFrame).CornerRadius = UDim.new(0,8)

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Size                  = UDim2.new(1,0,0,50)
ConfirmText.BackgroundTransparency= 1
ConfirmText.Text                  = "Đóng hoàn toàn UI?"
ConfirmText.TextColor3            = Colors.TextWhite
ConfirmText.Font                  = Enum.Font.GothamSemibold
ConfirmText.TextWrapped           = true
ConfirmText.ZIndex                = 11
ConfirmText.Parent                = ConfirmFrame

local YesBtn = Instance.new("TextButton")
YesBtn.Size            = UDim2.new(0,90,0,35)
YesBtn.Position        = UDim2.new(0,20,1,-45)
YesBtn.BackgroundColor3= Color3.fromRGB(200,50,50)
YesBtn.Text            = "Đóng"
YesBtn.TextColor3      = Colors.TextWhite
YesBtn.Font            = Enum.Font.GothamBold
YesBtn.ZIndex          = 11
YesBtn.Parent          = ConfirmFrame
Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0,6)

local NoBtn = Instance.new("TextButton")
NoBtn.Size             = UDim2.new(0,90,0,35)
NoBtn.Position         = UDim2.new(1,-110,1,-45)
NoBtn.BackgroundColor3 = Colors.CardBG
NoBtn.Text             = "Hủy"
NoBtn.TextColor3       = Colors.TextWhite
NoBtn.Font             = Enum.Font.GothamBold
NoBtn.ZIndex           = 11
NoBtn.Parent           = ConfirmFrame
Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0,6)

CloseBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = true end)
NoBtn.MouseButton1Click:Connect(function()    ConfirmFrame.Visible = false end)
YesBtn.MouseButton1Click:Connect(function()   ScreenGui:Destroy() end)

-- ================================================================
--   PHẦN 2 – HỆ THỐNG SIDEBAR & TRANG
-- ================================================================

local Pages         = {}
local SidebarButtons= {}
local InnerTabFrames= {}

local ContentArea = Instance.new("Frame")
ContentArea.Size                  = UDim2.new(1,-150,1,-80)
ContentArea.Position              = UDim2.new(0,150,0,40)
ContentArea.BackgroundTransparency= 1
ContentArea.Parent                = MainFrame

local function SwitchSidebarTab(targetPageName)
    for name, page in pairs(Pages) do
        page.Visible = (name == targetPageName)
        if page:FindFirstChild("CardsGrid") then
            page.CardsGrid.Visible = true
        end
    end
    for _, tab in pairs(InnerTabFrames) do tab.Visible = false end
    for name, btnData in pairs(SidebarButtons) do
        local sel = (name == targetPageName)
        btnData.Btn.BackgroundTransparency = sel and 0.93 or 1
        btnData.Icon.ImageColor3  = sel and Colors.ButtonBlue or Colors.TextGray
        btnData.Label.TextColor3  = sel and Colors.TextWhite  or Colors.TextGray
    end
end

-- ── Sidebar ─────────────────────────────────────────────────────
local Sidebar = Instance.new("Frame")
Sidebar.Size                  = UDim2.new(0,150,1,-80)
Sidebar.Position              = UDim2.new(0,0,0,40)
Sidebar.BackgroundColor3      = Colors.SidebarBG
Sidebar.BackgroundTransparency= 0.5
Sidebar.BorderSizePixel       = 0
Sidebar.Parent                = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent  = Sidebar
SidebarLayout.Padding = UDim.new(0,5)

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.Parent       = Sidebar
SidebarPadding.PaddingTop   = UDim.new(0,10)
SidebarPadding.PaddingLeft  = UDim.new(0,10)
SidebarPadding.PaddingRight = UDim.new(0,10)

local function CreateSidebarButton(text, iconId, pageName)
    local Btn = Instance.new("TextButton")
    Btn.Size             = UDim2.new(1,0,0,32)
    Btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Btn.Text             = ""
    Btn.Parent           = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)

    local Icon = Instance.new("ImageLabel")
    Icon.Size                  = UDim2.new(0,16,0,16)
    Icon.Position              = UDim2.new(0,10,0.5,-8)
    Icon.BackgroundTransparency= 1
    Icon.Image                 = iconId
    Icon.Parent                = Btn

    local Label = Instance.new("TextLabel")
    Label.Size                  = UDim2.new(1,-35,1,0)
    Label.Position              = UDim2.new(0,35,0,0)
    Label.BackgroundTransparency= 1
    Label.Text                  = text
    Label.Font                  = Enum.Font.GothamSemibold
    Label.TextSize              = 13
    Label.TextXAlignment        = Enum.TextXAlignment.Left
    Label.Parent                = Btn

    SidebarButtons[pageName] = {Btn=Btn, Icon=Icon, Label=Label}
    Btn.MouseButton1Click:Connect(function() SwitchSidebarTab(pageName) end)
end

-- ── Helpers: Page / Card / InnerTab ─────────────────────────────
local function CreatePage(pageName)
    local Page = Instance.new("Frame")
    Page.Name                  = pageName
    Page.Size                  = UDim2.new(1,0,1,0)
    Page.BackgroundTransparency= 1
    Page.Visible               = false
    Page.Parent                = ContentArea
    Pages[pageName] = Page

    local CardsGrid = Instance.new("Frame")
    CardsGrid.Name                  = "CardsGrid"
    CardsGrid.Size                  = UDim2.new(1,-20,1,-20)
    CardsGrid.Position              = UDim2.new(0,10,0,10)
    CardsGrid.BackgroundTransparency= 1
    CardsGrid.Parent                = Page

    local UIGrid = Instance.new("UIGridLayout")
    UIGrid.CellSize    = UDim2.new(0.48,0,0,110)
    UIGrid.CellPadding = UDim2.new(0.04,0,0,15)
    UIGrid.Parent      = CardsGrid

    return Page, CardsGrid
end

local function CreateCard(title, desc, parentGrid)
    local Card = Instance.new("Frame")
    Card.BackgroundColor3      = Colors.CardBG
    Card.BackgroundTransparency= 0.2
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0,8)

    local Stroke = Instance.new("UIStroke")
    Stroke.Color  = Color3.fromRGB(80,80,85)
    Stroke.Parent = Card

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size                  = UDim2.new(1,-20,0,25)
    TitleLabel.Position              = UDim2.new(0,15,0,15)
    TitleLabel.BackgroundTransparency= 1
    TitleLabel.Text                  = title
    TitleLabel.TextColor3            = Colors.TextWhite
    TitleLabel.Font                  = Enum.Font.GothamBold
    TitleLabel.TextSize              = 18
    TitleLabel.TextXAlignment        = Enum.TextXAlignment.Left
    TitleLabel.Parent                = Card

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size                  = UDim2.new(1,-20,0,15)
    DescLabel.Position              = UDim2.new(0,15,0,40)
    DescLabel.BackgroundTransparency= 1
    DescLabel.Text                  = desc
    DescLabel.TextColor3            = Colors.TextGray
    DescLabel.Font                  = Enum.Font.Gotham
    DescLabel.TextSize              = 12
    DescLabel.TextXAlignment        = Enum.TextXAlignment.Left
    DescLabel.Parent                = Card

    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Size             = UDim2.new(1,-20,0,25)
    ClickBtn.Position         = UDim2.new(0,10,1,-35)
    ClickBtn.BackgroundColor3 = Colors.ButtonBlue
    ClickBtn.Text             = "Click Tab"
    ClickBtn.TextColor3       = Colors.TextWhite
    ClickBtn.Font             = Enum.Font.GothamBold
    ClickBtn.TextSize         = 14
    ClickBtn.Parent           = Card
    Instance.new("UICorner", ClickBtn).CornerRadius = UDim.new(0,4)

    Card.Parent = parentGrid
    return ClickBtn
end

local function CreateInnerTab(tabName, parentPageName)
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Size                = UDim2.new(1,-20,1,-20)
    TabFrame.Position            = UDim2.new(0,10,0,10)
    TabFrame.BackgroundTransparency= 1
    TabFrame.ScrollBarThickness  = 3
    TabFrame.Visible             = false
    TabFrame.Parent              = ContentArea
    TabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    InnerTabFrames[tabName] = TabFrame

    local Layout = Instance.new("UIListLayout")
    Layout.Parent          = TabFrame
    Layout.Padding         = UDim.new(0,6)
    Layout.SortOrder       = Enum.SortOrder.LayoutOrder

    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop    = UDim.new(0,36)
    Padding.PaddingLeft   = UDim.new(0,4)
    Padding.PaddingRight  = UDim.new(0,4)
    Padding.Parent        = TabFrame

    local BackBtn = Instance.new("TextButton")
    BackBtn.Size             = UDim2.new(0,70,0,24)
    BackBtn.Position         = UDim2.new(0,0,0,6)
    BackBtn.BackgroundColor3 = Colors.CardBG
    BackBtn.Text             = "← Back"
    BackBtn.TextColor3       = Colors.TextWhite
    BackBtn.Font             = Enum.Font.GothamSemibold
    BackBtn.TextSize         = 12
    BackBtn.ZIndex           = 5
    BackBtn.Parent           = TabFrame
    Instance.new("UICorner", BackBtn).CornerRadius = UDim.new(0,4)

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

-- ================================================================
--   PHẦN 3 – HELPER: thêm phần tử vào InnerTab
-- ================================================================

-- Tiêu đề section trong tab
local function AddSection(parent, text)
    local F = Instance.new("Frame")
    F.Size                  = UDim2.new(1,0,0,22)
    F.BackgroundTransparency= 1
    F.LayoutOrder           = 0
    F.Parent                = parent

    local L = Instance.new("TextLabel")
    L.Size                  = UDim2.new(1,0,1,0)
    L.BackgroundTransparency= 1
    L.Text                  = "── " .. text .. " ──"
    L.TextColor3            = Colors.ButtonBlue
    L.Font                  = Enum.Font.GothamBold
    L.TextSize              = 11
    L.TextXAlignment        = Enum.TextXAlignment.Left
    L.Parent                = F
    return F
end

-- Toggle bật/tắt
local function AddToggle(parent, labelText, globalKey, order, callback)
    local Row = Instance.new("Frame")
    Row.Size             = UDim2.new(1,0,0,34)
    Row.BackgroundColor3 = Colors.CardBG
    Row.BackgroundTransparency= 0.3
    Row.LayoutOrder      = order or 0
    Row.Parent           = parent
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0,6)

    local Lbl = Instance.new("TextLabel")
    Lbl.Size                  = UDim2.new(1,-60,1,0)
    Lbl.Position              = UDim2.new(0,10,0,0)
    Lbl.BackgroundTransparency= 1
    Lbl.Text                  = labelText
    Lbl.TextColor3            = Colors.TextWhite
    Lbl.Font                  = Enum.Font.GothamSemibold
    Lbl.TextSize              = 13
    Lbl.TextXAlignment        = Enum.TextXAlignment.Left
    Lbl.Parent                = Row

    -- Pill toggle
    local Track = Instance.new("Frame")
    Track.Size             = UDim2.new(0,40,0,20)
    Track.Position         = UDim2.new(1,-48,0.5,-10)
    Track.BackgroundColor3 = Colors.ToggleOff
    Track.Parent           = Row
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("Frame")
    Knob.Size             = UDim2.new(0,16,0,16)
    Knob.Position         = UDim2.new(0,2,0.5,-8)
    Knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Knob.Parent           = Track
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

    local state = false
    _G[globalKey] = false

    local function SetState(v)
        state = v
        _G[globalKey] = v
        TweenService:Create(Track, TweenInfo.new(0.15), {BackgroundColor3 = v and Colors.ToggleOn or Colors.ToggleOff}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.15), {Position = v and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)}):Play()
        if callback then callback(v) end
    end

    Track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            SetState(not state)
        end
    end)
    Row.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            SetState(not state)
        end
    end)

    return Row, function(v) SetState(v) end
end

-- Dropdown đơn giản
local function AddDropdown(parent, labelText, options, globalKey, order, callback)
    local ITEM_H = 26

    local Wrapper = Instance.new("Frame")
    Wrapper.Size             = UDim2.new(1,0,0,34)
    Wrapper.BackgroundColor3 = Colors.CardBG
    Wrapper.BackgroundTransparency= 0.3
    Wrapper.LayoutOrder      = order or 0
    Wrapper.ClipsDescendants = false
    Wrapper.ZIndex           = 3
    Wrapper.Parent           = parent
    Instance.new("UICorner", Wrapper).CornerRadius = UDim.new(0,6)

    local Header = Instance.new("TextButton")
    Header.Size             = UDim2.new(1,0,0,34)
    Header.BackgroundTransparency= 1
    Header.Text             = ""
    Header.ZIndex           = 4
    Header.Parent           = Wrapper

    local Lbl = Instance.new("TextLabel")
    Lbl.Size                  = UDim2.new(1,-110,1,0)
    Lbl.Position              = UDim2.new(0,10,0,0)
    Lbl.BackgroundTransparency= 1
    Lbl.Text                  = labelText
    Lbl.TextColor3            = Colors.TextWhite
    Lbl.Font                  = Enum.Font.GothamSemibold
    Lbl.TextSize              = 13
    Lbl.TextXAlignment        = Enum.TextXAlignment.Left
    Lbl.ZIndex                = 4
    Lbl.Parent                = Header

    local ValLbl = Instance.new("TextLabel")
    ValLbl.Size                  = UDim2.new(0,95,0,22)
    ValLbl.Position              = UDim2.new(1,-102,0.5,-11)
    ValLbl.BackgroundColor3      = Color3.fromRGB(55,57,65)
    ValLbl.BackgroundTransparency= 0
    ValLbl.Text                  = options[1] or "---"
    ValLbl.TextColor3            = Colors.TextWhite
    ValLbl.Font                  = Enum.Font.GothamSemibold
    ValLbl.TextSize              = 11
    ValLbl.ZIndex                = 4
    ValLbl.Parent                = Header
    Instance.new("UICorner", ValLbl).CornerRadius = UDim.new(0,4)

    _G[globalKey] = options[1]

    -- Dropdown list
    local DropList = Instance.new("Frame")
    DropList.Size             = UDim2.new(1,0,0,#options * ITEM_H)
    DropList.Position         = UDim2.new(0,0,0,34)
    DropList.BackgroundColor3 = Color3.fromRGB(30,32,38)
    DropList.Visible          = false
    DropList.ZIndex           = 20
    DropList.Parent           = Wrapper
    Instance.new("UICorner", DropList).CornerRadius = UDim.new(0,6)
    Instance.new("UIListLayout", DropList).SortOrder = Enum.SortOrder.LayoutOrder

    for i, opt in ipairs(options) do
        local Item = Instance.new("TextButton")
        Item.Size             = UDim2.new(1,0,0,ITEM_H)
        Item.BackgroundTransparency= 1
        Item.Text             = opt
        Item.TextColor3       = Colors.TextGray
        Item.Font             = Enum.Font.GothamSemibold
        Item.TextSize         = 12
        Item.LayoutOrder      = i
        Item.ZIndex           = 21
        Item.Parent           = DropList

        Item.MouseButton1Click:Connect(function()
            _G[globalKey] = opt
            ValLbl.Text      = opt
            DropList.Visible = false
            Wrapper.Size     = UDim2.new(1,0,0,34)
            if callback then callback(opt) end
        end)
    end

    Header.MouseButton1Click:Connect(function()
        DropList.Visible = not DropList.Visible
        Wrapper.Size = DropList.Visible
            and UDim2.new(1,0,0,34 + #options*ITEM_H)
            or  UDim2.new(1,0,0,34)
    end)

    return Wrapper
end

-- Thông tin text (paragraph)
local function AddParagraph(parent, title, body, order)
    local F = Instance.new("Frame")
    F.Size                  = UDim2.new(1,0,0,50)
    F.BackgroundColor3      = Colors.CardBG
    F.BackgroundTransparency= 0.5
    F.LayoutOrder           = order or 0
    F.Parent                = parent
    Instance.new("UICorner", F).CornerRadius = UDim.new(0,6)

    local T = Instance.new("TextLabel")
    T.Size                  = UDim2.new(1,-10,0,20)
    T.Position              = UDim2.new(0,8,0,5)
    T.BackgroundTransparency= 1
    T.Text                  = title
    T.TextColor3            = Colors.ButtonBlue
    T.Font                  = Enum.Font.GothamBold
    T.TextSize              = 11
    T.TextXAlignment        = Enum.TextXAlignment.Left
    T.Parent                = F

    local B = Instance.new("TextLabel")
    B.Size                  = UDim2.new(1,-10,0,22)
    B.Position              = UDim2.new(0,8,0,22)
    B.BackgroundTransparency= 1
    B.Text                  = body
    B.TextColor3            = Colors.TextGray
    B.Font                  = Enum.Font.Gotham
    B.TextSize              = 11
    B.TextXAlignment        = Enum.TextXAlignment.Left
    B.Parent                = F

    return F, B -- trả về label body để cập nhật text
end

-- ================================================================
--   PHẦN 4 – ĐĂNG KÝ SIDEBAR & CÁC TRANG
-- ================================================================

CreateSidebarButton("Main Farming", "rbxassetid://7733674079", "FarmingPage")
CreateSidebarButton("</> Tools Beta","rbxassetid://7733765045","ToolsPage")
CreateSidebarButton("Setting",       "rbxassetid://7733679610","SettingPage")
CreateSidebarButton("Information",   "rbxassetid://7733677306","InfoPage")

-- TRANG 1: FARMING
local PageFarming, GridFarming = CreatePage("FarmingPage")
local c1 = CreateCard("Auto Fruits",   "Nhặt Trái/Quay/lưu trữ", GridFarming)
local c2 = CreateCard("Teleport/Time", "Dịch Chuyển/thời gian",  GridFarming)
local c3 = CreateCard("Farming",       "Level/Boss/Material...",  GridFarming)
local c4 = CreateCard("Esp Local",     "Định vị...",              GridFarming)

BindClickTab(c1, CreateInnerTab("AutoFruits_Tab","FarmingPage"), GridFarming)
BindClickTab(c2, CreateInnerTab("Teleport_Tab",  "FarmingPage"), GridFarming)
local FarmTab = CreateInnerTab("Farm_Tab","FarmingPage")
BindClickTab(c3, FarmTab, GridFarming)
BindClickTab(c4, CreateInnerTab("ESP_Tab","FarmingPage"), GridFarming)

-- TRANG 2: TOOLS BETA
local PageTools, GridTools = CreatePage("ToolsPage")
local c5 = CreateCard("Server Hop","Đổi máy chủ tự động",GridTools)
BindClickTab(c5, CreateInnerTab("ServerHop_Tab","ToolsPage"), GridTools)

-- TRANG 3: SETTING
local PageSetting, GridSetting = CreatePage("SettingPage")
local c6 = CreateCard("Theme Color","Đổi màu giao diện",GridSetting)
local c7 = CreateCard("Binds","Cài đặt phím tắt",GridSetting)
BindClickTab(c6, CreateInnerTab("Theme_Tab","SettingPage"), GridSetting)
BindClickTab(c7, CreateInnerTab("Binds_Tab","SettingPage"), GridSetting)

-- TRANG 4: INFORMATION
local PageInfo, GridInfo = CreatePage("InfoPage")
local c8 = CreateCard("About Script","Thông tin phiên bản",GridInfo)
BindClickTab(c8, CreateInnerTab("About_Tab","InfoPage"), GridInfo)

SwitchSidebarTab("FarmingPage")

-- ================================================================
--   PHẦN 5 – FARM TAB: LOGIC & UI
-- ================================================================

-- ── Biến toàn cục farming ───────────────────────────────────────
_G.AutoFarm         = false
_G.AutoNear         = false
_G.AutoBoss         = false
_G.AutoFarmMaterial = false
_G.SelectWeapon     = "Melee"
_G.SelectBoss       = nil
_G.SelectMaterial   = nil
_G.Fast_Delay       = 0

local SUBMERGED_Y       = -1400
local SUB_NPC           = CFrame.new(-16246.041, 38.48, 1376.539)
local TravelingSubmerged= false
local CurrentTween      = nil
local StartBring        = false
local MonFarm           = ""
local PosMon            = CFrame.new()
-- Quest vars (legacy worlds 1-2)
local Mon, NameMon, NameQuest, LevelQuest, CFrameQuest, CFrameMon
-- Quest vars (world 3 submerged)
local MonNew, NameMonNew, NameQuestNew, LevelQuestNew, CFrameQuestNew, CFrameMonNew

-- Phát hiện world
local World1 = (game:GetService("ReplicatedStorage"):FindFirstChild("WorldInfo") and
                game:GetService("ReplicatedStorage").WorldInfo.Value == 1) or false
local World2 = (game:GetService("ReplicatedStorage"):FindFirstChild("WorldInfo") and
                game:GetService("ReplicatedStorage").WorldInfo.Value == 2) or false
local World3 = (game:GetService("ReplicatedStorage"):FindFirstChild("WorldInfo") and
                game:GetService("ReplicatedStorage").WorldInfo.Value == 3) or false

-- ── Hàm tiện ích ────────────────────────────────────────────────
local function HRP()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local function IsInSubmerged()
    local hrp = HRP()
    return hrp and hrp.Position.Y < SUBMERGED_Y
end

local function StopTween(st)
    if not st and CurrentTween then
        pcall(function() CurrentTween:Cancel() end)
        CurrentTween = nil
    end
end

local function topos(cf)
    pcall(function()
        local hrp = HRP()
        if hrp then hrp.CFrame = cf end
    end)
end

local function TP1(cf)
    topos(cf)
end

local function EquipWeapon(weapName)
    pcall(function()
        for _, t in pairs(LocalPlayer.Backpack:GetChildren()) do
            if t.Name == weapName then
                LocalPlayer.Character.Humanoid:EquipTool(t)
                return
            end
        end
    end)
end

local function UnEquipWeapon()
    pcall(function()
        LocalPlayer.Character.Humanoid:UnequipTools()
    end)
end

local function AutoHaki()
    pcall(function()
        if LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(11)
        end
    end)
end

local function TweenTo(cf)
    if not _G.AutoFarm then return end
    local hrp = HRP()
    if not hrp then return end
    if CurrentTween then pcall(function() CurrentTween:Cancel() end) end
    local dist  = (hrp.Position - cf.Position).Magnitude
    local t     = dist / 300
    CurrentTween = TweenService:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = cf})
    CurrentTween:Play()
    while _G.AutoFarm and CurrentTween and CurrentTween.PlaybackState == Enum.PlaybackState.Playing do
        task.wait()
    end
    if CurrentTween then pcall(function() CurrentTween:Cancel() end) end
    CurrentTween = nil
end

local function GoSubmerged()
    if not _G.AutoFarm then return end
    if TravelingSubmerged or IsInSubmerged() then return end
    local ok, lvl = pcall(function() return LocalPlayer.Data.Level.Value end)
    if not ok or lvl < 2600 then return end
    TravelingSubmerged = true
    TweenTo(SUB_NPC + Vector3.new(0,60,0))
    if not _G.AutoFarm then TravelingSubmerged = false; return end
    TweenTo(SUB_NPC)
    if not _G.AutoFarm then TravelingSubmerged = false; return end
    pcall(function()
        ReplicatedStorage.Modules.Net["RF/SubmarineWorkerSpeak"]:InvokeServer("TravelToSubmergedIsland")
    end)
    while _G.AutoFarm and not IsInSubmerged() do task.wait(0.5) end
    TravelingSubmerged = false
end

-- ── CheckQuest (world 1-2) ───────────────────────────────────────
local function CheckQuest()
    pcall(function()
        local lvl = LocalPlayer.Data.Level.Value
        if lvl < 15 then
            Mon="Bandit";NameMon="Bandit";NameQuest="Quest1";LevelQuest=1
            CFrameQuest=CFrame.new(-1212.73,4.78,3883.1);CFrameMon=CFrame.new(-1212.73,4.78,3883.1)
        elseif lvl < 30 then
            Mon="Bandit";NameMon="Bandit";NameQuest="Quest1";LevelQuest=2
            CFrameQuest=CFrame.new(-1212.73,4.78,3883.1);CFrameMon=CFrame.new(-1212.73,4.78,3883.1)
        elseif lvl < 60 then
            Mon="Monkey";NameMon="Monkey";NameQuest="Quest2";LevelQuest=1
            CFrameQuest=CFrame.new(953.8,15.7,672.5);CFrameMon=CFrame.new(953.8,15.7,672.5)
        elseif lvl < 90 then
            Mon="Pirate";NameMon="Pirate";NameQuest="PirateQuest1";LevelQuest=1
            CFrameQuest=CFrame.new(-1236.5,4.78,4014);CFrameMon=CFrame.new(-1236.5,4.78,4014)
        elseif lvl < 120 then
            Mon="Brute";NameMon="Brute";NameQuest="Quest3";LevelQuest=1
            CFrameQuest=CFrame.new(-1133.42,14.84,4293.3);CFrameMon=CFrame.new(-1133.42,14.84,4293.3)
        else
            Mon="Pirate";NameMon="Pirate";NameQuest="PirateQuest1";LevelQuest=2
            CFrameQuest=CFrame.new(-1236.5,4.78,4014);CFrameMon=CFrame.new(-1236.5,4.78,4014)
        end
    end)
end

-- ── CheckQuestNew (world 3 submerged) ───────────────────────────
local function CheckQuestNew()
    pcall(function()
        local lvl = LocalPlayer.Data.Level.Value
        if lvl >= 2725 then
            MonNew="Grand Devotee";LevelQuestNew=2;NameQuestNew="SubmergedQuest3";NameMonNew="Grand Devotee"
            CFrameQuestNew=CFrame.new(9636.524,-1992.195,9609.528)
            CFrameMonNew=CFrame.new(9557.585,-1928.040,9859.183)
        elseif lvl >= 2700 then
            MonNew="High Disciple";LevelQuestNew=1;NameQuestNew="SubmergedQuest3";NameMonNew="High Disciple"
            CFrameQuestNew=CFrame.new(9636.524,-1992.195,9609.528)
            CFrameMonNew=CFrame.new(9828.088,-1940.909,9693.064)
        elseif lvl >= 2675 then
            MonNew="Ocean Prophet";LevelQuestNew=2;NameQuestNew="SubmergedQuest2";NameMonNew="Ocean Prophet"
            CFrameQuestNew=CFrame.new(10882.264,-2086.322,10034.226)
            CFrameMonNew=CFrame.new(11056.1445,-2001.6717,10117.4493)
        elseif lvl >= 2650 then
            MonNew="Sea Chanter";LevelQuestNew=1;NameQuestNew="SubmergedQuest2";NameMonNew="Sea Chanter"
            CFrameQuestNew=CFrame.new(10882.264,-2086.322,10034.226)
            CFrameMonNew=CFrame.new(10621.0342,-2087.844,10102.0332)
        elseif lvl >= 2600 then
            MonNew="Reef Bandit";LevelQuestNew=1;NameQuestNew="SubmergedQuest1";NameMonNew="Reef Bandit"
            CFrameQuestNew=CFrame.new(10882.264,-2086.322,10034.226)
            CFrameMonNew=CFrame.new(10736.6191,-2087.8439,9338.4882)
        else
            MonNew="Coral Pirate";LevelQuestNew=2;NameQuestNew="SubmergedQuest1";NameMonNew="Coral Pirate"
            CFrameQuestNew=CFrame.new(10882.264,-2086.322,10034.226)
            CFrameMonNew=CFrame.new(10965.1025,-2158.8842,9177.2597)
        end
    end)
end

-- ── getConfigMaterial ────────────────────────────────────────────
local MaterialMon, MaterialPos
local function getConfigMaterial(mat)
    if mat == "Radioactive" and World2 then
        MaterialMon={"Factory Staff"};MaterialPos=CFrame.new(-507.78,73,-126.45)
    elseif mat == "Mystic Droplet" and World2 then
        MaterialMon={"Water Fighter"};MaterialPos=CFrame.new(-3352.9,285.01,-10534.84)
    elseif mat == "Magma Ore" and World1 then
        MaterialMon={"Military Spy"};MaterialPos=CFrame.new(-5850.28,77.28,8848.67)
    elseif mat == "Magma Ore" and World2 then
        MaterialMon={"Lava Pirate"};MaterialPos=CFrame.new(-5234.6,51.95,-4732.27)
    elseif mat == "Angel Wings" and World1 then
        MaterialMon={"Royal Soldier"};MaterialPos=CFrame.new(-7827.15,5606.91,-1705.58)
    elseif mat == "Leather" and World1 then
        MaterialMon={"Pirate"};MaterialPos=CFrame.new(-1211.87,4.78,3916.83)
    elseif mat == "Leather" and World2 then
        MaterialMon={"Marine Captain"};MaterialPos=CFrame.new(-2010.5,73,-3326.62)
    elseif mat == "Leather" and World3 then
        MaterialMon={"Jungle Pirate"};MaterialPos=CFrame.new(-11975.78,331.77,-10620.03)
    elseif mat == "Ectoplasm" and World2 then
        MaterialMon={"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer"}
        MaterialPos=CFrame.new(911.35,125.95,33159.53)
    elseif mat == "Scrap Metal" and World1 then
        MaterialMon={"Brute"};MaterialPos=CFrame.new(-1132.42,14.84,4293.3)
    elseif mat == "Scrap Metal" and World2 then
        MaterialMon={"Mercenary"};MaterialPos=CFrame.new(-972.3,73.04,1419.29)
    elseif mat == "Scrap Metal" and World3 then
        MaterialMon={"Pirate Millionaire"};MaterialPos=CFrame.new(-289.63,43.82,5583.66)
    elseif mat == "Conjured Cocoa" and World3 then
        MaterialMon={"Chocolate Bar Battler"};MaterialPos=CFrame.new(744.79,24.76,-12637.72)
    elseif mat == "Dragon Scale" and World3 then
        MaterialMon={"Dragon Crew Warrior"};MaterialPos=CFrame.new(5824.06,51.38,-1106.69)
    elseif mat == "Gunpowder" and World3 then
        MaterialMon={"Pistol Billionaire"};MaterialPos=CFrame.new(-379.61,73.84,5928.52)
    elseif mat == "Fish Tail" and World3 then
        MaterialMon={"Fishman Captain"};MaterialPos=CFrame.new(-10961.01,331.79,-8914.29)
    elseif mat == "Mini Tusk" and World3 then
        MaterialMon={"Mithological Pirate"};MaterialPos=CFrame.new(-13516.04,469.81,-6899.16)
    end
end

-- ================================================================
--   PHẦN 6 – FARM TAB UI: THÊM CÁC NÚT
-- ================================================================

local ord = 1

-- ── Section: Cài đặt vũ khí ─────────────────────────────────────
AddSection(FarmTab, "Cài đặt Vũ khí"); ord=ord+1

AddDropdown(FarmTab, "Chọn Vũ khí",
    {"Melee","Sword","Gun","Blox Fruit"},
    "SelectWeapon", ord,
    function(v) _G.SelectWeapon = v end
); ord=ord+1

-- ── Section: Farm Level ──────────────────────────────────────────
AddSection(FarmTab, "Farm Level"); ord=ord+1

AddToggle(FarmTab, "Auto Farm Level", "AutoFarm", ord,
    function(st) _G.AutoFarm = st; StopTween(_G.AutoFarm) end
); ord=ord+1

AddToggle(FarmTab, "Auto Farm Nearest", "AutoNear", ord,
    function(st) _G.AutoNear = st; StopTween(_G.AutoNear) end
); ord=ord+1

-- ── Section: Boss ────────────────────────────────────────────────
AddSection(FarmTab, "Boss"); ord=ord+1

local bossList = {}
if World3 then
    bossList = {"Beast Pirates","Darkbeard","rip_indra","rip_indra True Form",
                "Longma","Soul Reaper","Cake Queen","Cursed Captain","Order","Awakened Ice Admiral"}
elseif World2 then
    bossList = {"Diamond","Jeremy","Fajita","Don Swan","Smoke Admiral",
                "Cursed Captain","Darkbeard","Order","Awakened Ice Admiral","Tide Keeper"}
else
    bossList = {"Gorilla King","Bobby","Yeti","mob_ship_captain",
                "Saber Expert","Wysper","Fishman Lord"}
end
_G.SelectBoss = bossList[1]

AddDropdown(FarmTab, "Chọn Boss", bossList, "SelectBoss", ord,
    function(v) _G.SelectBoss = v end
); ord=ord+1

AddToggle(FarmTab, "Auto Kill Boss", "AutoBoss", ord,
    function(st) _G.AutoBoss = st; StopTween(_G.AutoBoss) end
); ord=ord+1

-- ── Section: Material ────────────────────────────────────────────
AddSection(FarmTab, "Material (Nguyên liệu)"); ord=ord+1

local matList = {}
if World2 then
    matList = {"Radioactive","Mystic Droplet","Magma Ore","Leather","Ectoplasm","Scrap Metal"}
elseif World3 then
    matList = {"Leather","Scrap Metal","Conjured Cocoa","Dragon Scale","Gunpowder","Fish Tail","Mini Tusk"}
else
    matList = {"Magma Ore","Angel Wings","Leather","Scrap Metal"}
end
_G.SelectMaterial = matList[1]

AddDropdown(FarmTab, "Chọn Material", matList, "SelectMaterial", ord,
    function(v) _G.SelectMaterial = v end
); ord=ord+1

AddToggle(FarmTab, "Auto Farm Material", "AutoFarmMaterial", ord,
    function(st) _G.AutoFarmMaterial = st; StopTween(_G.AutoFarmMaterial) end
); ord=ord+1

-- ── Section: World 3 extras ──────────────────────────────────────
if World3 then
    AddSection(FarmTab, "World 3 – Extra"); ord=ord+1

    AddToggle(FarmTab, "Auto Pirates Sea (Raid)", "AutoRaidPirate", ord,
        function(st) _G.AutoRaidPirate = st; StopTween(_G.AutoRaidPirate) end
    ); ord=ord+1

    AddToggle(FarmTab, "Auto Farm Tyrant", "FarmDaiBan", ord,
        function(st) _G.FarmDaiBan = st; StopTween(_G.FarmDaiBan) end
    ); ord=ord+1

    local _, eyeLabel = AddParagraph(FarmTab,
        "Eye Status (Tyrant Spawn)", "Loading...", ord); ord=ord+1

    -- Cập nhật trạng thái mắt mỗi giây
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                local count = 0
                local eyes = {
                    workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye1"),
                    workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye2"),
                    workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye3"),
                    workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye4"),
                }
                for _,e in ipairs(eyes) do
                    if e and e:IsA("BasePart") and e.Transparency == 0 then count=count+1 end
                end
                eyeLabel.Text = "Eyes Lit: " .. count .. " / 4"
            end)
        end
    end)

    -- Auto Safe Mode
    AddToggle(FarmTab, "Safe Mode (Fly Up)", "SafeMode", ord,
        function(st) _G.SafeMode = st end
    ); ord=ord+1
end

if World2 then
    AddSection(FarmTab, "World 2 – Extra"); ord=ord+1
    AddToggle(FarmTab, "Auto Factory (Core)", "AutoFactory", ord,
        function(st) _G.AutoFactory = st; StopTween(_G.AutoFactory) end
    ); ord=ord+1
end

-- ================================================================
--   PHẦN 7 – LOOPS FARMING (chạy nền)
-- ================================================================

-- Auto chọn vũ khí đúng type
task.spawn(function()
    while task.wait() do
        pcall(function()
            local wep = _G.SelectWeapon
            if wep == "Melee" or wep == "Sword" or wep == "Gun" or wep == "Blox Fruit" then
                local tooltip = wep == "Blox Fruit" and "Blox Fruit" or wep
                for _, t in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if t.ToolTip == tooltip then _G.SelectWeapon = t.Name; break end
                end
            end
        end)
    end
end)

-- ── Auto Farm Level ──────────────────────────────────────────────
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local ok, lvl = pcall(function() return LocalPlayer.Data.Level.Value end)
                if not ok then return end

                if lvl >= 2600 and World3 then
                    if not IsInSubmerged() then GoSubmerged() end
                    if IsInSubmerged() then
                        CheckQuestNew()
                        local questGui = LocalPlayer.PlayerGui.Main.Quest
                        if not questGui.Visible then
                            StartBring = false
                            if (HRP().Position - CFrameQuestNew.Position).Magnitude > 20 then
                                TweenTo(CFrameQuestNew)
                            else
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuestNew, LevelQuestNew)
                            end
                        else
                            local questText = questGui.Container.QuestTitle.Title.Text
                            if not string.find(questText, NameMonNew) then
                                StartBring = false
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                            else
                                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                                    if mob.Name == MonNew and mob:FindFirstChild("HumanoidRootPart")
                                        and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            AutoHaki()
                                            topos(mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                            mob.HumanoidRootPart.CanCollide = false
                                            mob.Humanoid.WalkSpeed = 0
                                            mob.Head.CanCollide    = false
                                            mob.HumanoidRootPart.Size = Vector3.new(70,70,70)
                                            StartBring = true; MonFarm = mob.Name
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                        until not _G.AutoFarm or mob.Humanoid.Health<=0 or not mob.Parent or not questGui.Visible
                                    end
                                end
                                if not workspace.Enemies:FindFirstChild(MonNew) then
                                    TweenTo(CFrameMonNew); StartBring = false
                                end
                            end
                        end
                    end
                else
                    -- Farm thế giới 1-2
                    CheckQuest()
                    local questGui = LocalPlayer.PlayerGui.Main.Quest
                    if questGui.Visible then
                        local txt = questGui.Container.QuestTitle.Title.Text
                        if not string.find(txt, NameMon) then
                            StartBring = false
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                        else
                            if workspace.Enemies:FindFirstChild(Mon) then
                                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                                    if mob.Name == Mon and mob:FindFirstChild("HumanoidRootPart")
                                        and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            AutoHaki()
                                            PosMon = mob.HumanoidRootPart.CFrame
                                            topos(mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                            mob.HumanoidRootPart.CanCollide = false
                                            mob.Humanoid.WalkSpeed = 0
                                            mob.Head.CanCollide    = false
                                            mob.HumanoidRootPart.Size = Vector3.new(70,70,70)
                                            StartBring = true; MonFarm = mob.Name
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                        until not _G.AutoFarm or mob.Humanoid.Health<=0 or not mob.Parent or not questGui.Visible
                                    end
                                end
                            else
                                TP1(CFrameMon); StartBring = false
                                if ReplicatedStorage:FindFirstChild(Mon) then
                                    TP1(ReplicatedStorage:FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                end
                            end
                        end
                    else
                        StartBring = false
                        TP1(CFrameQuest)
                        if (LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 20 then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                        end
                    end
                end
            end)
        end
    end
end)

-- ── Auto Farm Nearest ────────────────────────────────────────────
task.spawn(function()
    while task.wait() do
        if _G.AutoNear then
            pcall(function()
                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart")
                        and mob.Humanoid.Health > 0
                        and (LocalPlayer.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude <= 5000 then
                        repeat
                            task.wait(_G.Fast_Delay)
                            StartBring = true
                            AutoHaki()
                            EquipWeapon(_G.SelectWeapon)
                            topos(mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                            mob.HumanoidRootPart.Size        = Vector3.new(60,60,60)
                            mob.HumanoidRootPart.Transparency= 1
                            mob.Humanoid.JumpPower           = 0
                            mob.Humanoid.WalkSpeed           = 0
                            mob.HumanoidRootPart.CanCollide  = false
                            MonFarm = mob.Name
                        until not _G.AutoNear or not mob.Parent or mob.Humanoid.Health <= 0
                        StartBring = false
                    end
                end
            end)
        end
    end
end)

-- ── Auto Kill Boss ───────────────────────────────────────────────
task.spawn(function()
    while task.wait() do
        if _G.AutoBoss and _G.SelectBoss then
            pcall(function()
                if not workspace.Enemies:FindFirstChild(_G.SelectBoss) then
                    if ReplicatedStorage:FindFirstChild(_G.SelectBoss) then
                        topos(ReplicatedStorage:FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame * CFrame.new(5,10,2))
                    end
                else
                    for _, mob in pairs(workspace.Enemies:GetChildren()) do
                        if mob.Name == _G.SelectBoss and mob:FindFirstChild("Humanoid")
                            and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                AutoHaki()
                                EquipWeapon(_G.SelectWeapon)
                                mob.HumanoidRootPart.CanCollide  = false
                                mob.Humanoid.WalkSpeed           = 0
                                mob.HumanoidRootPart.Size        = Vector3.new(80,80,80)
                                topos(mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                pcall(function()
                                    sethiddenproperty(LocalPlayer,"SimulationRadius",math.huge)
                                end)
                            until not _G.AutoBoss or not mob.Parent or mob.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

-- ── Auto Farm Material ───────────────────────────────────────────
task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoFarmMaterial and _G.SelectMaterial then
            pcall(function()
                getConfigMaterial(_G.SelectMaterial)
                if not MaterialMon then return end
                for _, monName in pairs(MaterialMon) do
                    if workspace.Enemies:FindFirstChild(monName) then
                        for _, mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob.Name == monName and mob:FindFirstChild("Humanoid")
                                and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    PosMon  = mob.HumanoidRootPart.CFrame
                                    MonFarm = mob.Name
                                    topos(mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                until not _G.AutoFarmMaterial or not mob.Parent or mob.Humanoid.Health <= 0
                            end
                        end
                    else
                        UnEquipWeapon()
                        if _G.SelectMaterial == "Ectoplasm" then
                            local dist = (Vector3.new(923.21,126.97,32852.83) - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if dist > 18000 then
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21,126.97,32852.83))
                            end
                        end
                        topos(MaterialPos)
                    end
                end
            end)
        end
    end
end)

-- ── World 3 – Auto Pirates Sea ───────────────────────────────────
if World3 then
    task.spawn(function()
        while task.wait() do
            if _G.AutoRaidPirate then
                pcall(function()
                    local raidCF = CFrame.new(-5496.17,313.77,-2841.53)
                    local center = Vector3.new(-5539.31,313.80,-2972.37)
                    if (center - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                        for _, mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid")
                                and mob.Humanoid.Health > 0
                                and (mob.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    mob.HumanoidRootPart.CanCollide = false
                                    mob.HumanoidRootPart.Size       = Vector3.new(60,60,60)
                                    topos(mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                until mob.Humanoid.Health<=0 or not mob.Parent or not _G.AutoRaidPirate
                            end
                        end
                    else
                        TP1(raidCF)
                    end
                end)
            end
        end
    end)

    -- Auto Farm Tyrant
    task.spawn(function()
        while task.wait() do
            if _G.FarmDaiBan then
                pcall(function()
                    local tyrantBase = CFrame.new(-16194.0,155.2,1420.7)
                    if not workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                        local spawns = {
                            CFrame.new(-1436.86,167.75,-12296.95),
                            CFrame.new(-2383.78,150.45,-12126.49),
                            CFrame.new(-2231.27,168.25,-12845.75),
                        }
                        local miniMobs = {"Isle Outlaw","Island Boy","Isle Champion","Serpent Hunter","Skull Slayer"}
                        local found = false
                        for _, n in ipairs(miniMobs) do
                            if workspace.Enemies:FindFirstChild(n) then found=true; break end
                        end
                        if found then
                            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                                local isMini = false
                                for _,n in ipairs(miniMobs) do if mob.Name==n then isMini=true;break end end
                                if isMini and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health>0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        mob.HumanoidRootPart.CanCollide = false
                                        mob.Humanoid.WalkSpeed          = 0
                                        mob.HumanoidRootPart.Size       = Vector3.new(50,50,50)
                                        PosMon = mob.HumanoidRootPart.CFrame; MonFarm = mob.Name
                                        topos(mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.FarmDaiBan or not mob.Parent or mob.Humanoid.Health<=0
                                end
                            end
                        else
                            topos(spawns[math.random(1,#spawns)])
                        end
                        topos(tyrantBase)
                    else
                        for _, mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob.Name=="Tyrant of the Skies" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health>0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    mob.HumanoidRootPart.CanCollide = false
                                    mob.Humanoid.WalkSpeed          = 0
                                    mob.HumanoidRootPart.Size       = Vector3.new(50,50,50)
                                    topos(mob.HumanoidRootPart.CFrame * CFrame.new(0,40,0))
                                until not _G.FarmDaiBan or not mob.Parent or mob.Humanoid.Health<=0
                                task.wait(1)
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- Safe Mode
    task.spawn(function()
        while task.wait() do
            pcall(function()
                if _G.SafeMode and LocalPlayer.Character then
                    LocalPlayer.Character.HumanoidRootPart.CFrame =
                        LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,200,0)
                end
            end)
        end
    end)
end

-- ── World 2 – Auto Factory ───────────────────────────────────────
if World2 then
    task.spawn(function()
        while task.wait() do
            if _G.AutoFactory then
                pcall(function()
                    if workspace.Enemies:FindFirstChild("Core") then
                        for _, mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob.Name=="Core" and mob.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(CFrame.new(448.46,199.35,-441.38))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                until mob.Humanoid.Health<=0 or not _G.AutoFactory
                            end
                        end
                    else
                        topos(CFrame.new(448.46,199.35,-441.38))
                    end
                end)
            end
        end
    end)
end

-- ================================================================
--   PHẦN 8 – FOOTER & NOTIFICATION
-- ================================================================

local Footer = Instance.new("Frame")
Footer.Size                  = UDim2.new(1,0,0,40)
Footer.Position              = UDim2.new(0,0,1,-40)
Footer.BackgroundTransparency= 1
Footer.Parent                = MainFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size             = UDim2.new(0,150,0,24)
SearchBox.Position         = UDim2.new(0,160,0.5,-12)
SearchBox.BackgroundColor3 = Colors.CardBG
SearchBox.Text             = "  🔍 Search..."
SearchBox.TextColor3       = Colors.TextGray
SearchBox.TextXAlignment   = Enum.TextXAlignment.Left
SearchBox.Font             = Enum.Font.Gotham
SearchBox.TextSize         = 12
SearchBox.Parent           = Footer
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0,12)

local Watermark = Instance.new("TextLabel")
Watermark.Size             = UDim2.new(0,300,1,0)
Watermark.Position         = UDim2.new(1,-310,0,0)
Watermark.BackgroundTransparency= 1
Watermark.Text             = "Vision 2.1 | Blox Fruit | By - ObiiSenPai"
Watermark.TextColor3       = Colors.TextWhite
Watermark.Font             = Enum.Font.GothamBold
Watermark.TextSize         = 12
Watermark.TextXAlignment   = Enum.TextXAlignment.Right
Watermark.Parent           = Footer

-- Notification
local function SendNotification(title, text, duration)
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size             = UDim2.new(0,260,0,70)
    NotifFrame.Position         = UDim2.new(1,50,1,-100)
    NotifFrame.BackgroundColor3 = Colors.CardBG
    NotifFrame.BorderSizePixel  = 0
    NotifFrame.ZIndex           = 100
    NotifFrame.Parent           = ScreenGui
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0,6)

    local Stroke = Instance.new("UIStroke")
    Stroke.Color     = Colors.ButtonBlue
    Stroke.Thickness = 1.5
    Stroke.Parent    = NotifFrame

    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Size                  = UDim2.new(1,-20,0,30)
    TitleLbl.Position              = UDim2.new(0,10,0,5)
    TitleLbl.BackgroundTransparency= 1
    TitleLbl.Text                  = title
    TitleLbl.TextColor3            = Colors.TextWhite
    TitleLbl.Font                  = Enum.Font.GothamBold
    TitleLbl.TextSize              = 14
    TitleLbl.ZIndex                = 101
    TitleLbl.Parent                = NotifFrame

    local MsgLbl = Instance.new("TextLabel")
    MsgLbl.Size                  = UDim2.new(1,-20,0,30)
    MsgLbl.Position              = UDim2.new(0,10,0,30)
    MsgLbl.BackgroundTransparency= 1
    MsgLbl.Text                  = text
    MsgLbl.TextColor3            = Color3.fromRGB(85,255,127)
    MsgLbl.Font                  = Enum.Font.GothamSemibold
    MsgLbl.TextSize              = 14
    MsgLbl.ZIndex                = 101
    MsgLbl.Parent                = NotifFrame

    TweenService:Create(NotifFrame, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
        {Position = UDim2.new(1,-280,1,-100)}):Play()

    task.delay(duration, function()
        local tweenOut = TweenService:Create(NotifFrame, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),
            {Position = UDim2.new(1,50,1,-100)})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        NotifFrame:Destroy()
    end)
end

SendNotification("[ Switch Hub | Blox Fruits ]", "[ Thành Công – Farm Tab Ready ]", 4)
