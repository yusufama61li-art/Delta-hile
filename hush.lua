-- ============================================
-- 🤫 HUSH: They can hear. - ÖZEL HİLE MENÜSÜ
-- Modern Arayüz + Oyunun Ses Mekaniğine Uygun Hileler
-- ============================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LP = Players.LocalPlayer

pcall(function()
    if CoreGui:FindFirstChild("HushMenu") then CoreGui.HushMenu:Destroy() end
end)

-- ============================================
-- 🎨 TEMA (Koyu, gizemli, hayatta kalma teması)
-- ============================================
local T = {
    Bg          = Color3.fromRGB(10, 10, 15),
    Bg2         = Color3.fromRGB(18, 18, 25),
    Card        = Color3.fromRGB(25, 25, 35),
    CardHover   = Color3.fromRGB(38, 38, 55),
    Accent      = Color3.fromRGB(80, 200, 255), -- Buz mavisi
    Accent2     = Color3.fromRGB(255, 80, 120), -- Kan kırmızısı
    Success     = Color3.fromRGB(80, 255, 150),
    Danger      = Color3.fromRGB(255, 50, 80),
    Text        = Color3.fromRGB(230, 235, 255),
    TextDim     = Color3.fromRGB(120, 130, 160),
    Border      = Color3.fromRGB(50, 55, 80),
}

local Easing = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- ============================================
-- 🔧 GUI OLUŞTURMA
-- ============================================
local gui = Instance.new("ScreenGui")
gui.Name = "HushMenu"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = CoreGui

-- Ana pencere
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.new(0, 680, 0, 460)
Main.Position = UDim2.new(0.5, -340, 0.5, -230)
Main.BackgroundColor3 = T.Bg
Main.BackgroundTransparency = 0.05
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.2
MainStroke.Color = T.Accent

-- Açılış animasyonu
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 680, 0, 460)
}):Play()

-- Gradient arka plan
local bgGrad = Instance.new("UIGradient", Main)
bgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 18, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 12)),
})
bgGrad.Rotation = 135

-- ============================================
-- 🎯 ÜST BAR (Sürükleme + Kapat)
-- ============================================
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundTransparency = 1
TopBar.Active = true

local dragging, dragStart, startPos
TopBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = i.Position
        startPos = Main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Logo
local Logo = Instance.new("Frame", TopBar)
Logo.Size = UDim2.new(0, 10, 0, 10)
Logo.Position = UDim2.new(0, 22, 0.5, -5)
Logo.BackgroundColor3 = T.Accent
Instance.new("UICorner", Logo).CornerRadius = UDim.new(1, 0)

-- Başlık
local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0, 250, 0, 50)
Title.Position = UDim2.new(0, 42, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🤫 HUSH | SESSİZ HİLE"
Title.TextColor3 = T.Text
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Kapat
local Close = Instance.new("TextButton", TopBar)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -42, 0.5, -15)
Close.BackgroundColor3 = T.Danger
Close.BackgroundTransparency = 0.85
Close.Text = "✕"
Close.TextColor3 = T.Danger
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.AutoButtonColor = false
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)

Close.MouseEnter:Connect(function() TweenService:Create(Close, Easing, {BackgroundTransparency = 0.4, TextColor3 = Color3.new(1,1,1)}):Play() end)
Close.MouseLeave:Connect(function() TweenService:Create(Close, Easing, {BackgroundTransparency = 0.85, TextColor3 = T.Danger}):Play() end)
Close.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.3)
    gui:Destroy()
end)

-- Minimize
local Min = Instance.new("TextButton", TopBar)
Min.Size = UDim2.new(0, 30, 0, 30)
Min.Position = UDim2.new(1, -78, 0.5, -15)
Min.BackgroundColor3 = T.Accent
Min.BackgroundTransparency = 0.85
Min.Text = "−"
Min.TextColor3 = T.Accent
Min.Font = Enum.Font.GothamBold
Min.TextSize = 18
Min.AutoButtonColor = false
Instance.new("UICorner", Min).CornerRadius = UDim.new(0, 8)

local minimized = false
Min.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        Size = minimized and UDim2.new(0, 680, 0, 50) or UDim2.new(0, 680, 0, 460)
    }):Play()
end)

-- ============================================
-- 👤 PROFİL KARTI
-- ============================================
local Profile = Instance.new("Frame", Main)
Profile.Size = UDim2.new(0, 210, 0, 100)
Profile.Position = UDim2.new(0, 15, 0, 60)
Profile.BackgroundColor3 = T.Card
Profile.BackgroundTransparency = 0.1
Profile.BorderSizePixel = 0
Instance.new("UICorner", Profile).CornerRadius = UDim.new(0, 14)

local pStroke = Instance.new("UIStroke", Profile)
pStroke.Color = T.Accent
pStroke.Thickness = 1.2
pStroke.Transparency = 0.5

-- Avatar
local AvatarBox = Instance.new("Frame", Profile)
AvatarBox.Size = UDim2.new(0, 64, 0, 64)
AvatarBox.Position = UDim2.new(0, 14, 0.5, -32)
AvatarBox.BackgroundColor3 = T.Accent
Instance.new("UICorner", AvatarBox).CornerRadius = UDim.new(1, 0)

local Avatar = Instance.new("ImageLabel", AvatarBox)
Avatar.Size = UDim2.new(1, -4, 1, -4)
Avatar.Position = UDim2.new(0, 2, 0, 2)
Avatar.BackgroundColor3 = T.Bg2
Avatar.Image = ""
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

pcall(function()
    Avatar.Image = Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end)

-- Online dot
local Status = Instance.new("Frame", AvatarBox)
Status.Size = UDim2.new(0, 16, 0, 16)
Status.Position = UDim2.new(1, -14, 1, -14)
Status.BackgroundColor3 = T.Success
Instance.new("UICorner", Status).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", Status).Color = T.Bg

-- İsim
local NameLbl = Instance.new("TextLabel", Profile)
NameLbl.Size = UDim2.new(1, -95, 0, 22)
NameLbl.Position = UDim2.new(0, 90, 0, 18)
NameLbl.BackgroundTransparency = 1
NameLbl.Text = LP.DisplayName
NameLbl.TextColor3 = T.Text
NameLbl.Font = Enum.Font.GothamBold
NameLbl.TextSize = 15
NameLbl.TextXAlignment = Enum.TextXAlignment.Left

-- @username
local Handle = Instance.new("TextLabel", Profile)
Handle.Size = UDim2.new(1, -95, 0, 16)
Handle.Position = UDim2.new(0, 90, 0, 38)
Handle.BackgroundTransparency = 1
Handle.Text = "@" .. LP.Name
Handle.TextColor3 = T.TextDim
Handle.Font = Enum.Font.GothamMedium
Handle.TextSize = 11
Handle.TextXAlignment = Enum.TextXAlignment.Left

-- Badge
local Badge = Instance.new("Frame", Profile)
Badge.Size = UDim2.new(0, 80, 0, 18)
Badge.Position = UDim2.new(0, 90, 0, 62)
Badge.BackgroundColor3 = T.Accent
Badge.BackgroundTransparency = 0.65
Instance.new("UICorner", Badge).CornerRadius = UDim.new(0, 5)

local BadgeTxt = Instance.new("TextLabel", Badge)
BadgeTxt.Size = UDim2.new(1, 0, 1, 0)
BadgeTxt.BackgroundTransparency = 1
BadgeTxt.Text = "🔊 SESSİZ"
BadgeTxt.TextColor3 = Color3.fromRGB(180, 230, 255)
BadgeTxt.Font = Enum.Font.GothamBold
BadgeTxt.TextSize = 9

-- ============================================
-- 📑 SEKMELER
-- ============================================
local TabsFrame = Instance.new("Frame", Main)
TabsFrame.Size = UDim2.new(0, 210, 0, 285)
TabsFrame.Position = UDim2.new(0, 15, 0, 170)
TabsFrame.BackgroundTransparency = 1
local tabsList = Instance.new("UIListLayout", TabsFrame)
tabsList.Padding = UDim.new(0, 6)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -255, 1, -75)
Content.Position = UDim2.new(0, 240, 0, 60)
Content.BackgroundTransparency = 1

-- ============================================
-- 🔨 YARDIMCILAR (Tab, Button, Toggle, Slider)
-- ============================================
local tabs = {}
local currentFrame = nil

local function switchTab(tab)
    for _, t in ipairs(tabs) do
        t.frame.Visible = false
        TweenService:Create(t.btn, Easing, {BackgroundColor3 = T.Card, BackgroundTransparency = 0.4}):Play()
        TweenService:Create(t.label, Easing, {TextColor3 = T.TextDim}):Play()
        TweenService:Create(t.icon, Easing, {TextColor3 = T.TextDim}):Play()
    end
    tab.frame.Visible = true
    currentFrame = tab.frame
    TweenService:Create(tab.btn, Easing, {BackgroundColor3 = T.Accent, BackgroundTransparency = 0.7}):Play()
    TweenService:Create(tab.label, Easing, {TextColor3 = T.Text}):Play()
    TweenService:Create(tab.icon, Easing, {TextColor3 = T.Accent2}):Play()
end

local function CreateTab(icon, name)
    local btn = Instance.new("TextButton", TabsFrame)
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = T.Card
    btn.BackgroundTransparency = 0.4
    btn.Text = ""
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    local ind = Instance.new("Frame", btn)
    ind.Size = UDim2.new(0, 3, 0, 22)
    ind.Position = UDim2.new(0, 0, 0.5, -11)
    ind.BackgroundColor3 = T.Accent
    ind.Visible = false
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    local ic = Instance.new("TextLabel", btn)
    ic.Size = UDim2.new(0, 26, 1, 0)
    ic.Position = UDim2.new(0, 14, 0, 0)
    ic.BackgroundTransparency = 1
    ic.Text = icon
    ic.TextColor3 = T.TextDim
    ic.Font = Enum.Font.GothamBold
    ic.TextSize = 15

    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(1, -50, 1, 0)
    lbl.Position = UDim2.new(0, 46, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = T.TextDim
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local frame = Instance.new("ScrollingFrame", Content)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 3
    frame.ScrollBarImageColor3 = T.Accent
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.Visible = false

    local list = Instance.new("UIListLayout", frame)
    list.Padding = UDim.new(0, 8)
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        frame.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 10)
    end)
    Instance.new("UIPadding", frame).PaddingRight = UDim.new(0, 8)

    local data = {btn = btn, frame = frame, indicator = ind, label = lbl, icon = ic}
    table.insert(tabs, data)

    btn.MouseEnter:Connect(function()
        if currentFrame ~= frame then TweenService:Create(btn, Easing, {BackgroundTransparency = 0.1}):Play() end
    end)
    btn.MouseLeave:Connect(function()
        if currentFrame ~= frame then TweenService:Create(btn, Easing, {BackgroundTransparency = 0.4}):Play() end
    end)
    btn.MouseButton1Click:Connect(function()
        ind.Visible = true
        switchTab(data)
    end)

    return frame
end

local function Button(parent, icon, text, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 44)
    b.BackgroundColor3 = T.Card
    b.BackgroundTransparency = 0.15
    b.Text = ""
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke", b)
    s.Color = T.Border
    s.Thickness = 1
    s.Transparency = 0.6

    local ic = Instance.new("TextLabel", b)
    ic.Size = UDim2.new(0, 30, 1, 0)
    ic.Position = UDim2.new(0, 14, 0, 0)
    ic.BackgroundTransparency = 1
    ic.Text = icon
    ic.TextColor3 = T.Accent
    ic.Font = Enum.Font.GothamBold
    ic.TextSize = 16

    local lbl = Instance.new("TextLabel", b)
    lbl.Size = UDim2.new(1, -55, 1, 0)
    lbl.Position = UDim2.new(0, 50, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = T.Text
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    b.MouseEnter:Connect(function()
        TweenService:Create(b, Easing, {BackgroundColor3 = T.CardHover}):Play()
        TweenService:Create(s, Easing, {Transparency = 0, Color = T.Accent}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, Easing, {BackgroundColor3 = T.Card}):Play()
        TweenService:Create(s, Easing, {Transparency = 0.6, Color = T.Border}):Play()
    end)
    b.MouseButton1Click:Connect(cb)
    return b
end

local function Toggle(parent, icon, text, default, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 44)
    f.BackgroundColor3 = T.Card
    f.BackgroundTransparency = 0.15
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke", f)
    s.Color = T.Border
    s.Thickness = 1
    s.Transparency = 0.6

    local ic = Instance.new("TextLabel", f)
    ic.Size = UDim2.new(0, 30, 1, 0)
    ic.Position = UDim2.new(0, 14, 0, 0)
    ic.BackgroundTransparency = 1
    ic.Text = icon
    ic.TextColor3 = T.Accent
    ic.Font = Enum.Font.GothamBold
    ic.TextSize = 16

    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(1, -120, 1, 0)
    lbl.Position = UDim2.new(0, 50, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = T.Text
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local sw = Instance.new("TextButton", f)
    sw.Size = UDim2.new(0, 46, 0, 24)
    sw.Position = UDim2.new(1, -60, 0.5, -12)
    sw.BackgroundColor3 = default and T.Success or Color3.fromRGB(60, 60, 85)
    sw.Text = ""
    sw.AutoButtonColor = false
    Instance.new("UICorner", sw).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame", sw)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local state = default
    sw.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(sw, Easing, {BackgroundColor3 = state and T.Success or Color3.fromRGB(60, 60, 85)}):Play()
        TweenService:Create(knob, Easing, {Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}):Play()
        if cb then cb(state) end
    end)
    return f
end

local function Slider(parent, icon, text, min, max, def, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 64)
    f.BackgroundColor3 = T.Card
    f.BackgroundTransparency = 0.15
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke", f)
    s.Color = T.Border
    s.Thickness = 1
    s.Transparency = 0.6

    local ic = Instance.new("TextLabel", f)
    ic.Size = UDim2.new(0, 30, 0, 30)
    ic.Position = UDim2.new(0, 14, 0, 6)
    ic.BackgroundTransparency = 1
    ic.Text = icon
    ic.TextColor3 = T.Accent
    ic.Font = Enum.Font.GothamBold
    ic.TextSize = 16

    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(1, -140, 0, 30)
    lbl.Position = UDim2.new(0, 50, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = T.Text
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local val = Instance.new("TextLabel", f)
    val.Size = UDim2.new(0, 70, 0, 30)
    val.Position = UDim2.new(1, -84, 0, 6)
    val.BackgroundTransparency = 1
    val.Text = tostring(def)
    val.TextColor3 = T.Accent2
    val.Font = Enum.Font.GothamBold
    val.TextSize = 14
    val.TextXAlignment = Enum.TextXAlignment.Right

    local track = Instance.new("Frame", f)
    track.Size = UDim2.new(1, -28, 0, 6)
    track.Position = UDim2.new(0, 14, 0, 44)
    track.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", track)
    fill.Size = UDim2.new((def - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = T.Accent
    fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dot = Instance.new("Frame", track)
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = UDim2.new((def - min) / (max - min), -7, 0.5, -7)
    dot.BackgroundColor3 = Color3.new(1, 1, 1)
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", dot).Color = T.Accent

    local drag = false
    local function setFromX(mx)
        local abs = track.AbsolutePosition.X
        local w = track.AbsoluteSize.X
        local rel = math.clamp((mx - abs) / w, 0, 1)
        local v = math.floor(min + (max - min) * rel + 0.5)
        val.Text = tostring(v)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        dot.Position = UDim2.new(rel, -7, 0.5, -7)
        if cb then cb(v) end
    end
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            setFromX(i.Position.X)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            setFromX(i.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
    return f
end

-- ============================================
-- 🔔 BİLDİRİM SİSTEMİ
-- ============================================
local NotiContainer = Instance.new("Frame", gui)
NotiContainer.Size = UDim2.new(0, 300, 1, 0)
NotiContainer.Position = UDim2.new(1, -320, 0, 0)
NotiContainer.BackgroundTransparency = 1
local NotiList = Instance.new("UIListLayout", NotiContainer)
NotiList.Padding = UDim.new(0, 8)
NotiList.VerticalAlignment = Enum.VerticalAlignment.Center
NotiList.HorizontalAlignment = Enum.HorizontalAlignment.Right

local function Notify(text, isError)
    local n = Instance.new("Frame", NotiContainer)
    n.Size = UDim2.new(0, 280, 0, 50)
    n.BackgroundColor3 = T.Card
    n.BorderSizePixel = 0
    n.Position = UDim2.new(1, 300, 0, 0)
    Instance.new("UICorner", n).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke", n)
    s.Color = isError and T.Danger or T.Success
    s.Thickness = 1.5

    local bar = Instance.new("Frame", n)
    bar.Size = UDim2.new(0, 4, 1, 0)
    bar.BackgroundColor3 = isError and T.Danger or T.Success
    bar.BorderSizePixel = 0
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local t = Instance.new("TextLabel", n)
    t.Size = UDim2.new(1, -30, 1, 0)
    t.Position = UDim2.new(0, 18, 0, 0)
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextColor3 = T.Text
    t.Font = Enum.Font.GothamSemibold
    t.TextSize = 12
    t.TextXAlignment = Enum.TextXAlignment.Left

    TweenService:Create(n, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(2.5)
    TweenService:Create(n, TweenInfo.new(0.3), {Position = UDim2.new(1, 300, 0, 0)}):Play()
    task.wait(0.3)
    n:Destroy()
end

-- ============================================
-- 📑 SEKMELERİ OLUŞTUR
-- ============================================
local HayattaKalmaTab = CreateTab("🏃", "Hayatta Kalma")
local GorselTab = CreateTab("👁️", "Görsel / ESP")
local GanimetTab = CreateTab("💰", "Ganimet")
local AyarlarTab = CreateTab("⚙️", "Ayarlar")

switchTab(tabs[1])

-- ============================================
-- 🏃 HAYATTA KALMA SEKMESİ
-- ============================================
-- Sessiz Mod (oyunun ana mekaniği için kritik)
Toggle(HayattaKalmaTab, "🤫", "Sessiz Mod (Gizlilik)", false, function(s)
    _G.HushSilent = s
    if s then
        Notify("Sessiz mod açık - adımların duyulmuyor!", false)
    end
end)

task.spawn(function()
    RunService.Heartbeat:Connect(function()
        if _G.HushSilent then
            local char = LP.Character
            if char and char:FindFirstChild("Humanoid") then
                -- Humanoid'in ses çıkarma özelliklerini devre dışı bırak
                pcall(function()
                    char.Humanoid.WalkSpeed = 16 -- Normal hız ama ses yok
                    char.Humanoid.JumpPower = 50
                end)
                -- Eğer oyunda "Noise" veya "Sound" attribute'u varsa sıfırla
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("Sound") or v.Name:lower():find("noise") or v.Name:lower():find("sound") then
                        pcall(function() v.Volume = 0 end)
                    end
                end
            end
        end
    end)
end)

-- Sonsuz Stamina
Toggle(HayattaKalmaTab, "⚡", "Sonsuz Stamina", false, function(s)
    _G.InfStamina = s
    if s then
        Notify("Sonsuz stamina açık! Koşarken yorulmayacaksın.", false)
    end
end)

task.spawn(function()
    RunService.Heartbeat:Connect(function()
        if _G.InfStamina then
            local char = LP.Character
            if char then
                pcall(function()
                    -- Yaygın stamina attribute'larını doldur
                    for _, v in pairs(char:GetDescendants()) do
                        if v:IsA("NumberValue") and (v.Name:lower():find("stamina") or v.Name:lower():find("energy")) then
                            v.Value = 100
                        end
                    end
                end)
            end
        end
    end)
end)

-- Hız Ayarı
Slider(HayattaKalmaTab, "🏃", "Yürüme Hızı", 16, 100, 16, function(v)
    local c = LP.Character
    if c and c:FindFirstChildOfClass("Humanoid") then
        c:FindFirstChildOfClass("Humanoid").WalkSpeed = v
    end
end)

-- Zıplama Ayarı
Slider(HayattaKalmaTab, "🦘", "Zıplama Gücü", 50, 200, 50, function(v)
    local c = LP.Character
    if c and c:FindFirstChildOfClass("Humanoid") then
        c:FindFirstChildOfClass("Humanoid").JumpPower = v
    end
end)

-- Işınlanma (Güvenli Bölge)
Button(HayattaKalmaTab, "🏠", "Güvenli Bölgeye Işınlan", function()
    local c = LP.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        -- Spawn noktasına veya haritanın başlangıcına ışınla
        c.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
        Notify("Güvenli bölgeye ışınlandın!", false)
    end
end)

-- ============================================
-- 👁️ GÖRSEL / ESP SEKMESİ
-- ============================================
-- Zombi ESP
Toggle(GorselTab, "🧟", "Zombi ESP", false, function(s)
    _G.ZombieESP = s
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and (v.Name:lower():find("zombie") or v.Name:lower():find("infected") or v.Name:lower():find("walker")) then
            local hl = v:FindFirstChild("Z_ESP")
            if s and not hl then
                local h = Instance.new("Highlight", v)
                h.Name = "Z_ESP"
                h.FillColor = Color3.fromRGB(255, 50, 50)
                h.OutlineColor = Color3.fromRGB(255, 255, 255)
                h.FillTransparency = 0.5
            elseif not s and hl then
                hl:Destroy()
            end
        end
    end
end)

-- Oyuncu ESP
Toggle(GorselTab, "👥", "Oyuncu ESP", false, function(s)
    _G.PlayerESP = s
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local hl = p.Character:FindFirstChild("P_ESP")
            if s and not hl then
                local h = Instance.new("Highlight", p.Character)
                h.Name = "P_ESP"
                h.FillColor = T.Accent
                h.OutlineColor = T.Accent2
                h.FillTransparency = 0.6
            elseif not s and hl then
                hl:Destroy()
            end
        end
    end
end)

-- Çıkış Noktası ESP (Exit ESP)
Toggle(GorselTab, "🚪", "Çıkış Noktası ESP", false, function(s)
    _G.ExitESP = s
    -- Oyunun exit'lerini bul (genellikle "Exit", "Extract", "Escape" isimli parçalar)
    for _, v in ipairs(Workspace:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("Model")) and (v.Name:lower():find("exit") or v.Name:lower():find("extract") or v.Name:lower():find("escape")) then
            local hl = v:FindFirstChild("Exit_ESP")
            if s and not hl then
                local h = Instance.new("Highlight", v)
                h.Name = "Exit_ESP"
                h.FillColor = T.Success
                h.OutlineColor = Color3.fromRGB(255, 255, 255)
                h.FillTransparency = 0.3
            elseif not s and hl then
                hl:Destroy()
            end
        end
    end
end)

-- Fullbright (Karanlıkta görüş)
Toggle(GorselTab, "💡", "Fullbright (Karanlıkta Gör)", false, function(s)
    if s then
        Lighting.Brightness = 5
        Lighting.ClockTime = 12
        Lighting.FogEnd = 1e6
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 2
        Lighting.ClockTime = 0
        Lighting.FogEnd = 1000
        Lighting.GlobalShadows = true
    end
end)

-- ============================================
-- 💰 GANİMET SEKMESİ
-- ============================================
-- Ganimet Konteyner ESP
Toggle(GanimetTab, "📦", "Ganimet Konteyner ESP", false, function(s)
    _G.LootESP = s
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and (v.Name:lower():find("loot") or v.Name:lower():find("container") or v.Name:lower():find("chest") or v.Name:lower():find("crate")) then
            local hl = v:FindFirstChild("Loot_ESP")
            if s and not hl then
                local h = Instance.new("Highlight", v)
                h.Name = "Loot_ESP"
                h.FillColor = Color3.fromRGB(255, 200, 50)
                h.OutlineColor = Color3.fromRGB(255, 255, 255)
                h.FillTransparency = 0.4
            elseif not s and hl then
                hl:Destroy()
            end
        end
    end
end)

-- Anında ProximityPrompt (Hızlı Ganimet)
Toggle(GanimetTab, "⚡", "Anında Ganimet (Instant Loot)", false, function(s)
    _G.InstantLoot = s
    if s then
        Notify("Anında ganimet açık - eşyaları beklemeden al!", false)
    end
end)

task.spawn(function()
    RunService.Heartbeat:Connect(function()
        if _G.InstantLoot then
            -- Tüm ProximityPrompt'ları otomatik tetikle
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    pcall(function()
                        v.HoldDuration = 0
                    end)
                end
            end
        end
    end)
end)

-- Zaman Değiştirici (Raif süresi)
Slider(GanimetTab, "⏱️", "Kalan Süre (saniye)", 60, 1200, 1200, function(v)
    _G.TimeLeft = v
    -- Oyunun timer'ını bul ve değiştir
    pcall(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("NumberValue") and (v.Name:lower():find("time") or v.Name:lower():find("timer")) then
                v.Value = v
            end
        end
    end)
end)

-- ============================================
-- ⚙️ AYARLAR SEKMESİ
-- ============================================
Button(AyarlarTab, "ℹ️", "Bilgi Göster", function()
    Notify("HUSH Menü v1.0 | " .. LP.Name .. " | Oyun: BETA", false)
end)

Button(AyarlarTab, "🔔", "Test Bildirimi", function()
    Notify("Ses seni duymuyor... ya da duyuyor mu? 🤫", false)
end)

Button(AyarlarTab, "🗑️", "Menüyü Kapat", function()
    gui:Destroy()
end)

-- ============================================
-- ✅ HAZIR
-- ============================================
task.wait(0.5)
Notify("HUSH menüsü yüklendi! 🤫 Sessiz ol...", false)

print("[HUSH Menu] Başarıyla yüklendi!")
print("[HUSH Menu] Oyun: Hush: They can hear. (BETA)")
