local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local Mouse = LocalPlayer:GetMouse()

local Library = {}
Library.__index = Library

local Theme = {
    WindowWidth = 540, WindowHeight = 440,
    Background = Color3.fromRGB(8, 8, 12), Panel = Color3.fromRGB(18, 18, 24),
    PanelAlt = Color3.fromRGB(14, 14, 20), PanelDark = Color3.fromRGB(10, 10, 16),
    Accent = Color3.fromRGB(70, 170, 255), AccentDark = Color3.fromRGB(35, 110, 200),
    AccentGlow = Color3.fromRGB(50, 150, 240), Text = Color3.fromRGB(242, 242, 248),
    TextDim = Color3.fromRGB(145, 145, 162), TextMuted = Color3.fromRGB(95, 95, 112),
    Button = Color3.fromRGB(35, 35, 44), ButtonHover = Color3.fromRGB(52, 52, 64),
    ButtonActive = Color3.fromRGB(58, 58, 72), Stroke = Color3.fromRGB(38, 38, 48),
    StrokeLight = Color3.fromRGB(55, 55, 68), Shadow = Color3.fromRGB(0, 0, 0),
    Success = Color3.fromRGB(50, 215, 125), Danger = Color3.fromRGB(225, 60, 70),
    Warning = Color3.fromRGB(245, 185, 45), Info = Color3.fromRGB(70, 170, 255),
    Corner = 14, CornerSmall = 8, CornerMini = 4
}

local function new(class, props)
    local ins = Instance.new(class)
    if props then for k, v in pairs(props) do pcall(function() ins[k] = v end) end end
    return ins
end

local function createShadow(parent, size)
    local s = new("ImageLabel", {
        Name = "Shadow", Image = "rbxassetid://6015897843", ImageColor3 = Theme.Shadow,
        BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 50, 50),
        Size = UDim2.new(1, size or 22, 1, size or 22),
        Position = UDim2.new(0, -(size or 22) / 2, 0, -(size or 22) / 2),
        ZIndex = -2, Parent = parent
    })
    return s
end

local function createStroke(parent, color, thickness, transparency)
    local st = new("UIStroke", {
        Color = color or Theme.Stroke, Thickness = thickness or 1,
        Transparency = transparency or 0.78, Parent = parent
    })
    return st
end

local function createGradient(parent, angle, c1, c2)
    local g = new("UIGradient", {
        Rotation = angle or 90,
        Color = ColorSequence.new({ColorSequenceKeypoint.new(0, c1), ColorSequenceKeypoint.new(1, c2)}),
        Parent = parent
    })
    return g
end

local function createRipple(btn, x, y)
    local size = btn.AbsoluteSize
    local maxDim = math.max(size.X, size.Y) * 1.9
    local ripple = new("Frame", {
        Name = "Ripple", Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0, x, 0, y),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.65, ZIndex = btn.ZIndex + 10, Parent = btn
    })
    new("UICorner", {CornerRadius = UDim.new(0, maxDim / 2), Parent = ripple})
    local tw = TweenService:Create(ripple, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, maxDim, 0, maxDim),
        Position = UDim2.new(0, x - maxDim / 2, 0, y - maxDim / 2),
        BackgroundTransparency = 1
    })
    tw:Play()
    tw.Completed:Connect(function() ripple:Destroy() end)
end

local function createParticles(btn, x, y, count, color)
    for i = 1, count or 5 do
        local p = new("Frame", {
            Size = UDim2.new(0, 2, 0, 2), Position = UDim2.new(0, x, 0, y),
            BackgroundColor3 = color or Theme.Accent, BorderSizePixel = 0, Parent = btn
        })
        new("UICorner", {CornerRadius = UDim.new(0, 1), Parent = p})
        local angle = math.random() * 6.28
        local dist = math.random(25, 55)
        TweenService:Create(p, TweenInfo.new(0.3 + math.random() * 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, x + math.cos(angle) * dist, 0, y + math.sin(angle) * dist),
            BackgroundTransparency = 1, Size = UDim2.new(0, 1, 0, 1)
        }):Play()
        task.delay(0.4, function() p:Destroy() end)
    end
end

local clickSound = new("Sound", {
    Parent = SoundService, SoundId = "rbxassetid://9120386432", Volume = 2.5, Pitch = 1.15
})

local function playClick()
    local clone = clickSound:Clone()
    clone.Parent = SoundService
    clone:Play()
    clone.Ended:Connect(function() clone:Destroy() end)
end

local function createScreenGui(name)
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local sg = new("ScreenGui", {
        Name = name or "RixerXHubV2", ResetOnSpawn = false,
        DisplayOrder = 100, IgnoreGuiInset = true, Parent = playerGui
    })
    return sg
end

local function getAvatarUrl(userId)
    return "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(userId or LocalPlayer.UserId) .. "&width=420&height=420&format=png"
end

local function applyBtnHover(btn, hoverColor, normalColor)
    hoverColor = hoverColor or Theme.ButtonHover
    normalColor = normalColor or Theme.Button
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = hoverColor}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.14), {BackgroundColor3 = normalColor}):Play()
    end)
end

function Library:MakeWindow(opts)
    opts = opts or {}
    local name = opts.Name or "Rixer X Hub V2"

    local screenGui = createScreenGui("RixerXHubV2")

    local main = new("Frame", {
        Name = "Main",
        Size = UDim2.new(0, Theme.WindowWidth, 0, Theme.WindowHeight),
        Position = UDim2.new(0.5, -Theme.WindowWidth / 2, 0.5, -Theme.WindowHeight / 2),
        BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Parent = screenGui
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.Corner), Parent = main})
    createStroke(main, Theme.StrokeLight, 1.2, 0.72)
    createShadow(main, 26)

    local glowBorder = new("Frame", {
        Name = "GlowBorder", Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1, ZIndex = 5, Parent = main
    })
    new("UIStroke", {Color = Theme.AccentGlow, Thickness = 1.5, Transparency = 0.78, Parent = glowBorder})
    new("UICorner", {CornerRadius = UDim.new(0, Theme.Corner), Parent = glowBorder})

    local header = new("Frame", {
        Name = "Header", Size = UDim2.new(1, 0, 0, 54),
        BackgroundTransparency = 1, Parent = main
    })

    local headerBg = new("Frame", {
        Name = "HeaderBg", Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Theme.Panel, BorderSizePixel = 0, Parent = header
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.Corner), Parent = headerBg})
    createGradient(headerBg, 90, Theme.Panel, Theme.PanelAlt)
    local headerClip = new("Frame", {
        Name = "HeaderClip", Size = UDim2.new(1, 0, 1, 4),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1, ClipsDescendants = true, Parent = headerBg
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.Corner), Parent = headerClip})

    local headerGlow = new("Frame", {
        Name = "HeaderGlow", Size = UDim2.new(0.8, 0, 0, 2),
        Position = UDim2.new(0.1, 0, 1, -2),
        BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.88,
        BorderSizePixel = 0, Parent = headerBg
    })
    new("UICorner", {CornerRadius = UDim.new(0, 1), Parent = headerGlow})

    local headerLine = new("Frame", {
        Name = "HeaderLine", Size = UDim2.new(1, -24, 0, 1),
        Position = UDim2.new(0, 12, 1, -1),
        BackgroundColor3 = Theme.StrokeLight, BackgroundTransparency = 0.85,
        BorderSizePixel = 0, Parent = headerBg
    })

    local title = new("TextLabel", {
        Name = "Title", Text = name, TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold, TextSize = 20,
        BackgroundTransparency = 1, Position = UDim2.new(0, 16, 0, 0),
        Size = UDim2.new(0.7, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = header
    })
    createGradient(title, 45, Theme.Text, Theme.Accent)

    local versionLabel = new("TextLabel", {
        Name = "Version", Text = "2.0", TextColor3 = Theme.TextMuted,
        Font = Enum.Font.Gotham, TextSize = 9, BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 30), Size = UDim2.new(0.4, 0, 0, 14),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = header
    })

    local avatarContainer = new("Frame", {
        Name = "AvatarContainer", Size = UDim2.new(0, 38, 0, 38),
        Position = UDim2.new(0.5, -19, 0.5, -19),
        BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Parent = header
    })
    new("UICorner", {CornerRadius = UDim.new(0, 19), Parent = avatarContainer})
    createStroke(avatarContainer, Theme.Accent, 1.8, 0.45)
    local avatarRing = new("Frame", {
        Name = "AvatarRing", Size = UDim2.new(1, 6, 1, 6),
        Position = UDim2.new(0.5, -3, 0.5, -3),
        BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.88,
        BorderSizePixel = 0, Parent = avatarContainer, ZIndex = -1
    })
    new("UICorner", {CornerRadius = UDim.new(0, 22), Parent = avatarRing})

    local logo = new("ImageLabel", {
        Name = "LogoAvatar", Image = getAvatarUrl(),
        BackgroundTransparency = 1, Size = UDim2.new(0, 34, 0, 34),
        Position = UDim2.new(0.5, -17, 0.5, -17), Parent = avatarContainer
    })
    new("UICorner", {CornerRadius = UDim.new(0, 17), Parent = logo})

    local pingLabel = new("TextLabel", {
        Name = "Ping", Text = "● Online", TextColor3 = Theme.Success,
        Font = Enum.Font.GothamBold, TextSize = 9, BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 22, 0.5, -9), Parent = header
    })

    local function makeHeaderBtn(txt, posX)
        local btn = new("TextButton", {
            Name = "HBtn_" .. txt, Size = UDim2.new(0, 34, 0, 34),
            Position = UDim2.new(1, posX, 0.5, -17),
            BackgroundColor3 = Theme.Button, Text = txt,
            TextColor3 = Theme.Text, Font = Enum.Font.GothamBold,
            TextSize = 20, BorderSizePixel = 0, Parent = header
        })
        new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = btn})
        createStroke(btn, Theme.Stroke, 1, 0.72)
        return btn
    end

    local toggleBtn = makeHeaderBtn("—", -84)
    local closeBtn = makeHeaderBtn("✕", -44)

    applyBtnHover(toggleBtn)
    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(110, 30, 35)}):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.14), {BackgroundColor3 = Theme.Button}):Play()
    end)

    local content = new("Frame", {
        Name = "Content", Position = UDim2.new(0, 12, 0, 64),
        Size = UDim2.new(1, -24, 1, -78),
        BackgroundTransparency = 1, Parent = main
    })

    local tabsColumn = new("ScrollingFrame", {
        Name = "TabsColumn", Size = UDim2.new(0, 148, 1, 0),
        BackgroundColor3 = Theme.PanelAlt, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.AccentDark,
        Parent = content, CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = tabsColumn})
    createStroke(tabsColumn, Theme.Stroke, 1, 0.72)
    createGradient(tabsColumn, 180, Theme.PanelAlt, Theme.PanelDark)

    local tabsLayout = new("UIListLayout", {
        Parent = tabsColumn, SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center
    })
    local tabsPadding = new("UIPadding", {
        Parent = tabsColumn, PaddingTop = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5)
    })

    local pages = new("Frame", {
        Name = "Pages", Position = UDim2.new(0, 160, 0, 0),
        Size = UDim2.new(1, -166, 1, 0),
        BackgroundColor3 = Theme.PanelAlt, BorderSizePixel = 0, Parent = content
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = pages})
    createStroke(pages, Theme.Stroke, 1, 0.72)

    local pagesHeader = new("Frame", {
        Name = "PagesHeader", Size = UDim2.new(1, 0, 0, 26),
        BackgroundColor3 = Theme.PanelDark, BorderSizePixel = 0, Parent = pages
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = pagesHeader})

    local pageTitle = new("TextLabel", {
        Name = "PageTitle", Text = "Accueil", TextColor3 = Theme.TextDim,
        Font = Enum.Font.GothamBold, TextSize = 11,
        BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0.8, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = pagesHeader
    })

    local pagesInner = new("ScrollingFrame", {
        Name = "PagesInner", Size = UDim2.new(1, -12, 1, -32),
        Position = UDim2.new(0, 6, 0, 32),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.AccentDark,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = pages
    })
    local pagesLayout = new("UIListLayout", {
        Parent = pagesInner, SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center
    })
    local pagesPad = new("UIPadding", {
        Parent = pagesInner, PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8)
    })

    do
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        header.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        RunService.Heartbeat:Connect(function()
            if dragging and dragInput then pcall(function() update(dragInput) end) end
        end)
    end

    local Window = {}
    Window._screenGui = screenGui
    Window._main = main
    Window._tabs = {}
    Window._active = nil
    Window._content = content
    Window._tabsColumn = tabsColumn
    Window._pages = pagesInner
    Window._pageTitle = pageTitle

    local minimized = false
    local savedSize = main.Size
    toggleBtn.MouseButton1Click:Connect(function()
        playClick()
        minimized = not minimized
        if minimized then
            for _, obj in ipairs(content:GetChildren()) do
                if obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
                    TweenService:Create(obj, TweenInfo.new(0.2), {Transparency = 1}):Play()
                end
                for _, child in ipairs(obj:GetDescendants()) do
                    if child:IsA("Frame") or child:IsA("ScrollingFrame") or child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("ImageLabel") then
                        pcall(function() TweenService:Create(child, TweenInfo.new(0.2), {Transparency = 1}):Play() end)
                    end
                end
            end
            TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, Theme.WindowWidth, 0, 56)}):Play()
            TweenService:Create(glowBorder, TweenInfo.new(0.2), {Transparency = 1}):Play()
            task.wait(0.25)
            content.Visible = false
        else
            content.Visible = true
            TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = savedSize}):Play()
            TweenService:Create(glowBorder, TweenInfo.new(0.35), {Transparency = 0.78}):Play()
            for _, obj in ipairs(content:GetChildren()) do
                if obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
                    TweenService:Create(obj, TweenInfo.new(0.25), {Transparency = 0}):Play()
                end
                for _, child in ipairs(obj:GetDescendants()) do
                    if child:IsA("Frame") or child:IsA("ScrollingFrame") or child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("ImageLabel") then
                        pcall(function() TweenService:Create(child, TweenInfo.new(0.25), {Transparency = 0}):Play() end)
                    end
                end
            end
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        playClick()
        TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.25)
        screenGui:Destroy()
    end)

    function Window:MakeTab(tabInfo)
        tabInfo = tabInfo or {}
        local tabName = tabInfo.Name or "Tab"
        local tabIcon = tabInfo.Icon or ""

        local tabBtn = new("TextButton", {
            Name = "TabBtn_" .. tabName, Size = UDim2.new(1, 0, 0, 44),
            BackgroundColor3 = Theme.Button, BorderSizePixel = 0, Text = "", Parent = tabsColumn
        })
        new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = tabBtn})
        createStroke(tabBtn, Theme.Stroke, 1, 0.68)

        local tabContent = new("Frame", {
            Name = "TabContent", Size = UDim2.new(1, -12, 1, 0),
            Position = UDim2.new(0, 6, 0, 0), BackgroundTransparency = 1, Parent = tabBtn
        })

        if tabIcon ~= "" then
            local icon = new("ImageLabel", {
                Name = "Icon", Image = tabIcon, BackgroundTransparency = 1,
                Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0, 2, 0.5, -10), Parent = tabContent
            })
            local label = new("TextLabel", {
                Name = "Label", Text = tabName, TextColor3 = Theme.Text,
                Font = Enum.Font.GothamBold, TextSize = 13, BackgroundTransparency = 1,
                Position = UDim2.new(0, 26, 0, 0), Size = UDim2.new(0.72, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = tabContent
            })
        else
            local label = new("TextLabel", {
                Name = "Label", Text = tabName, TextColor3 = Theme.Text,
                Font = Enum.Font.GothamBold, TextSize = 14, BackgroundTransparency = 1,
                Position = UDim2.new(0, 6, 0, 0), Size = UDim2.new(0.8, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = tabContent
            })
        end

        local dot = new("Frame", {
            Name = "Dot", Size = UDim2.new(0, 5, 0, 5),
            Position = UDim2.new(1, -12, 0.5, -2.5),
            BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.6,
            BorderSizePixel = 0, Parent = tabContent
        })
        new("UICorner", {CornerRadius = UDim.new(0, 2.5), Parent = dot})

        local indicator = new("Frame", {
            Name = "Indicator", Size = UDim2.new(0, 3, 0, 0),
            Position = UDim2.new(1, -1, 0.5, 0),
            BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = tabBtn
        })
        new("UICorner", {CornerRadius = UDim.new(0, 2), Parent = indicator})

        local page = new("ScrollingFrame", {
            Name = "Page_" .. tabName, Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1, BorderSizePixel = 0, Parent = pagesInner,
            ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.AccentDark,
            CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y
        })
        local pageLayout = new("UIListLayout", {
            Parent = page, SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center
        })
        local pagePad = new("UIPadding", {
            Parent = page, PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8)
        })

        local tabObj = {Name = tabName, Button = tabBtn, Page = page, Elements = {}}

        local function activate()
            playClick()
            for _, t in pairs(Window._tabs) do
                t.Page.Visible = false
                TweenService:Create(t.Button, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundColor3 = Theme.Button}):Play()
                for _, child in ipairs(t.Button:GetDescendants()) do
                    if child.Name == "Indicator" then
                        TweenService:Create(child, TweenInfo.new(0.18), {Size = UDim2.new(0, 3, 0, 0)}):Play()
                    end
                    if child:IsA("TextLabel") and child.Name == "Label" then
                        TweenService:Create(child, TweenInfo.new(0.18), {TextColor3 = Theme.Text}):Play()
                    end
                    if child.Name == "Dot" then
                        TweenService:Create(child, TweenInfo.new(0.18), {BackgroundTransparency = 0.6, Size = UDim2.new(0, 5, 0, 5)}):Play()
                    end
                end
            end
            page.Visible = true
            Window._pageTitle.Text = "◈ " .. tabName
            TweenService:Create(tabBtn, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundColor3 = Theme.ButtonActive}):Play()
            for _, child in ipairs(tabBtn:GetDescendants()) do
                if child.Name == "Indicator" then
                    TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, 3, 1, -10)
                    }):Play()
                end
                if child:IsA("TextLabel") and child.Name == "Label" then
                    TweenService:Create(child, TweenInfo.new(0.18), {TextColor3 = Theme.Accent}):Play()
                end
                if child.Name == "Dot" then
                    TweenService:Create(child, TweenInfo.new(0.25), {
                        BackgroundTransparency = 0, Size = UDim2.new(0, 7, 0, 7),
                        Position = UDim2.new(1, -14, 0.5, -3.5)
                    }):Play()
                end
            end
            Window._active = tabObj
        end

        if #Window._tabs == 0 then activate() else page.Visible = false end

        tabBtn.MouseButton1Click:Connect(activate)
        tabBtn.MouseEnter:Connect(function()
            if Window._active ~= tabObj then
                TweenService:Create(tabBtn, TweenInfo.new(0.1), {BackgroundColor3 = Theme.ButtonHover}):Play()
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if Window._active ~= tabObj then
                TweenService:Create(tabBtn, TweenInfo.new(0.14), {BackgroundColor3 = Theme.Button}):Play()
            end
        end)

        function tabObj:AddButton(opts)
            opts = opts or {}
            local btnName = opts.Name or "Button"
            local callback = opts.Callback or function() end

            local btn = new("TextButton", {
                Name = "Btn_" .. btnName,
                Size = UDim2.new(1, -10, 0, 48),
                BackgroundColor3 = Theme.Button,
                BorderSizePixel = 0,
                Text = "",
                Parent = page
            })
            new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = btn})
            createStroke(btn, Theme.Stroke, 1, 0.65)

            local iconCont = new("Frame", {
                Name = "IconContainer", Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(0, 10, 0.5, -15),
                BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Parent = btn
            })
            new("UICorner", {CornerRadius = UDim.new(0, 8), Parent = iconCont})
            createStroke(iconCont, Theme.Stroke, 1, 0.68)

            local icon = new("ImageLabel", {
                Name = "Icon", Image = "rbxassetid://9468220156",
                BackgroundTransparency = 1, Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(0.5, -10, 0.5, -10), Parent = iconCont
            })

            local label = new("TextLabel", {
                Name = "Label", Text = btnName, TextColor3 = Theme.Text,
                Font = Enum.Font.Gotham, TextSize = 14, BackgroundTransparency = 1,
                Position = UDim2.new(0, 48, 0, 0), Size = UDim2.new(0.65, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = btn
            })

            local hint = new("TextLabel", {
                Name = "Hint", Text = "Cliquez pour exécuter", TextColor3 = Theme.TextMuted,
                Font = Enum.Font.Gotham, TextSize = 9, BackgroundTransparency = 1,
                Position = UDim2.new(0, 48, 0, 24), Size = UDim2.new(0.6, 0, 0, 16),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = btn
            })

            local arrowCont = new("Frame", {
                Name = "ArrowContainer", Size = UDim2.new(0, 22, 0, 22),
                Position = UDim2.new(1, -30, 0.5, -11),
                BackgroundColor3 = Theme.Background, BackgroundTransparency = 0.6,
                BorderSizePixel = 0, Parent = btn
            })
            new("UICorner", {CornerRadius = UDim.new(0, 6), Parent = arrowCont})

            local arrow = new("TextLabel", {
                Name = "Arrow", Text = "›", TextColor3 = Theme.TextDim,
                Font = Enum.Font.GothamBold, TextSize = 20, BackgroundTransparency = 1,
                Position = UDim2.new(0.5, -6, 0.5, -12), Size = UDim2.new(0, 12, 0, 24), Parent = arrowCont
            })

            local stateDot = new("Frame", {
                Name = "StateDot", Size = UDim2.new(0, 5, 0, 5),
                Position = UDim2.new(1, -14, 0.5, -2.5),
                BackgroundColor3 = Theme.Success, BackgroundTransparency = 0.5,
                BorderSizePixel = 0, Parent = btn
            })
            new("UICorner", {CornerRadius = UDim.new(0, 2.5), Parent = stateDot})

            local btnGlow = new("Frame", {
                Name = "BtnGlow", Size = UDim2.new(1, -4, 1, -4),
                Position = UDim2.new(0, 2, 0, 2),
                BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.95,
                BorderSizePixel = 0, Parent = btn
            })
            new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall - 1), Parent = btnGlow})

            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Theme.ButtonHover}):Play()
                TweenService:Create(arrowCont, TweenInfo.new(0.12), {
                    BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.75
                }):Play()
                TweenService:Create(arrow, TweenInfo.new(0.12), {
                    TextColor3 = Theme.Accent, Position = UDim2.new(0.5, -4, 0.5, -12)
                }):Play()
                TweenService:Create(btnGlow, TweenInfo.new(0.1), {BackgroundTransparency = 0.9}):Play()
                TweenService:Create(stateDot, TweenInfo.new(0.12), {
                    BackgroundTransparency = 0, Size = UDim2.new(0, 7, 0, 7)
                }):Play()
                TweenService:Create(iconCont, TweenInfo.new(0.12), {BackgroundColor3 = Theme.PanelAlt}):Play()
            end)

            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.14, Enum.EasingStyle.Quad), {BackgroundColor3 = Theme.Button}):Play()
                TweenService:Create(arrowCont, TweenInfo.new(0.14), {
                    BackgroundColor3 = Theme.Background, BackgroundTransparency = 0.6
                }):Play()
                TweenService:Create(arrow, TweenInfo.new(0.14), {
                    TextColor3 = Theme.TextDim, Position = UDim2.new(0.5, -6, 0.5, -12)
                }):Play()
                TweenService:Create(btnGlow, TweenInfo.new(0.14), {BackgroundTransparency = 0.95}):Play()
                TweenService:Create(stateDot, TweenInfo.new(0.14), {
                    BackgroundTransparency = 0.5, Size = UDim2.new(0, 5, 0, 5)
                }):Play()
                TweenService:Create(iconCont, TweenInfo.new(0.14), {BackgroundColor3 = Theme.Background}):Play()
            end)

            btn.MouseButton1Click:Connect(function()
                playClick()
                local mPos = UserInputService:GetMouseLocation()
                local absPos = btn.AbsolutePosition
                createRipple(btn, mPos.X - absPos.X, mPos.Y - absPos.Y)
                createParticles(btn, 24, 24, 6, Theme.Accent)
                TweenService:Create(btn, TweenInfo.new(0.06), {BackgroundColor3 = Theme.AccentDark}):Play()
                TweenService:Create(stateDot, TweenInfo.new(0.08), {
                    BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0,
                    Size = UDim2.new(0, 9, 0, 9)
                }):Play()
                task.delay(0.06, function()
                    TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Theme.ButtonHover}):Play()
                    task.delay(0.1, function()
                        TweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = Theme.Button}):Play()
                        TweenService:Create(stateDot, TweenInfo.new(0.2), {
                            BackgroundColor3 = Theme.Success, Size = UDim2.new(0, 5, 0, 5),
                            BackgroundTransparency = 0.5
                        }):Play()
                    end)
                end)
                pcall(function() if callback then callback() end end)
            end)

            table.insert(tabObj.Elements, btn)
            return btn
        end

        function tabObj:AddLabel(text, color)
            color = color or Theme.Text
            local label = new("TextLabel", {
                Name = "Label_" .. text, Size = UDim2.new(1, -10, 0, 24),
                Text = text, TextColor3 = color, Font = Enum.Font.Gotham,
                TextSize = 13, BackgroundTransparency = 1, Parent = page,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(tabObj.Elements, label)
            return label
        end

        function tabObj:AddSection(text)
            local section = new("Frame", {
                Name = "Section_" .. text, Size = UDim2.new(1, -10, 0, 28),
                BackgroundTransparency = 1, Parent = page
            })
            local line = new("Frame", {
                Name = "Line", Size = UDim2.new(0.25, 0, 0, 1),
                Position = UDim2.new(0, 0, 0.5, 0),
                BackgroundColor3 = Theme.StrokeLight, BackgroundTransparency = 0.82,
                BorderSizePixel = 0, Parent = section
            })
            local sectionLabel = new("TextLabel", {
                Name = "Label", Text = "  " .. text, TextColor3 = Theme.TextDim,
                Font = Enum.Font.GothamBold, TextSize = 11,
                BackgroundTransparency = 1, Position = UDim2.new(0.25, 8, 0, 0),
                Size = UDim2.new(0.75, -8, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = section
            })
            return section
        end

        function tabObj:AddToggle(opts)
            opts = opts or {}
            local toggleName = opts.Name or "Toggle"
            local defaultState = opts.Default or false
            local callback = opts.Callback or function() end

            local toggleFrame = new("Frame", {
                Name = "Toggle_" .. toggleName, Size = UDim2.new(1, -10, 0, 44),
                BackgroundColor3 = Theme.Button, BorderSizePixel = 0, Parent = page
            })
            new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = toggleFrame})
            createStroke(toggleFrame, Theme.Stroke, 1, 0.65)

            local toggleLabel = new("TextLabel", {
                Name = "Label", Text = toggleName, TextColor3 = Theme.Text,
                Font = Enum.Font.Gotham, TextSize = 14, BackgroundTransparency = 1,
                Position = UDim2.new(0, 14, 0, 0), Size = UDim2.new(0.7, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = toggleFrame
            })

            local toggleOuter = new("Frame", {
                Name = "ToggleOuter", Size = UDim2.new(0, 44, 0, 22),
                Position = UDim2.new(1, -54, 0.5, -11),
                BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Parent = toggleFrame
            })
            new("UICorner", {CornerRadius = UDim.new(0, 11), Parent = toggleOuter})
            createStroke(toggleOuter, Theme.Stroke, 1, 0.6)

            local toggleInner = new("Frame", {
                Name = "ToggleInner", Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(0, 2, 0.5, -9),
                BackgroundColor3 = Theme.TextMuted, BorderSizePixel = 0, Parent = toggleOuter
            })
            new("UICorner", {CornerRadius = UDim.new(0, 9), Parent = toggleInner})

            local toggled = defaultState
            if toggled then
                toggleOuter.BackgroundColor3 = Theme.Accent
                toggleInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleInner.Position = UDim2.new(1, -20, 0.5, -9)
            end

            local function toggle()
                toggled = not toggled
                if toggled then
                    TweenService:Create(toggleOuter, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Theme.Accent}):Play()
                    TweenService:Create(toggleInner, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -20, 0.5, -9)
                    }):Play()
                else
                    TweenService:Create(toggleOuter, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Theme.Background}):Play()
                    TweenService:Create(toggleInner, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Theme.TextMuted, Position = UDim2.new(0, 2, 0.5, -9)
                    }):Play()
                end
                pcall(callback, toggled)
            end

            toggleFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    playClick()
                    toggle()
                end
            end)

            return toggleFrame
        end

        function tabObj:AddSlider(opts)
            opts = opts or {}
            local sliderName = opts.Name or "Slider"
            local minVal = opts.Min or 0
            local maxVal = opts.Max or 100
            local defaultVal = opts.Default or math.floor((minVal + maxVal) / 2)
            local callback = opts.Callback or function() end

            local sliderFrame = new("Frame", {
                Name = "Slider_" .. sliderName, Size = UDim2.new(1, -10, 0, 54),
                BackgroundColor3 = Theme.Button, BorderSizePixel = 0, Parent = page
            })
            new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = sliderFrame})
            createStroke(sliderFrame, Theme.Stroke, 1, 0.65)

            local sliderLabel = new("TextLabel", {
                Name = "Label", Text = sliderName .. " : " .. tostring(defaultVal),
                TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 13,
                BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0, 6),
                Size = UDim2.new(0.8, 0, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = sliderFrame
            })

            local sliderBg = new("Frame", {
                Name = "SliderBg", Size = UDim2.new(1, -28, 0, 6),
                Position = UDim2.new(0, 14, 0, 36),
                BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Parent = sliderFrame
            })
            new("UICorner", {CornerRadius = UDim.new(0, 3), Parent = sliderBg})
            createStroke(sliderBg, Theme.Stroke, 1, 0.5)

            local sliderFill = new("Frame", {
                Name = "SliderFill", Size = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = sliderBg
            })
            new("UICorner", {CornerRadius = UDim.new(0, 3), Parent = sliderFill})

            local sliderKnob = new("Frame", {
                Name = "SliderKnob", Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new(0, -7, 0.5, -4),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0, Parent = sliderFill
            })
            new("UICorner", {CornerRadius = UDim.new(0, 7), Parent = sliderKnob})
            createStroke(sliderKnob, Theme.Accent, 2, 0.2)

            local dragActive = false
            local currentVal = defaultVal
            local perc = (defaultVal - minVal) / (maxVal - minVal)
            sliderFill.Size = UDim2.new(perc, 0, 1, 0)

            sliderBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragActive = true
                    local scale = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                    currentVal = math.floor(minVal + (maxVal - minVal) * scale)
                    sliderFill.Size = UDim2.new(scale, 0, 1, 0)
                    sliderLabel.Text = sliderName .. " : " .. tostring(currentVal)
                    pcall(callback, currentVal)
                end
            end)

            RunService.Heartbeat:Connect(function()
                if dragActive then
                    local scale = math.clamp((Mouse.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                    currentVal = math.floor(minVal + (maxVal - minVal) * scale)
                    sliderFill.Size = UDim2.new(scale, 0, 1, 0)
                    sliderLabel.Text = sliderName .. " : " .. tostring(currentVal)
                    pcall(callback, currentVal)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragActive = false
                end
            end)

            return sliderFrame
        end

        function tabObj:AddDropdown(opts)
            opts = opts or {}
            local dropName = opts.Name or "Dropdown"
            local items = opts.Items or {"Option 1", "Option 2", "Option 3"}
            local callback = opts.Callback or function() end

            local dropFrame = new("Frame", {
                Name = "Dropdown_" .. dropName, Size = UDim2.new(1, -10, 0, 44),
                BackgroundColor3 = Theme.Button, BorderSizePixel = 0, Parent = page
            })
            new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = dropFrame})
            createStroke(dropFrame, Theme.Stroke, 1, 0.65)

            local dropLabel = new("TextLabel", {
                Name = "Label", Text = dropName, TextColor3 = Theme.Text,
                Font = Enum.Font.Gotham, TextSize = 14, BackgroundTransparency = 1,
                Position = UDim2.new(0, 14, 0, 0), Size = UDim2.new(0.55, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = dropFrame
            })

            local selectBtn = new("TextButton", {
                Name = "SelectBtn", Text = items[1] or "Sélectionner",
                TextColor3 = Theme.TextDim, Font = Enum.Font.Gotham, TextSize = 13,
                Size = UDim2.new(0, 120, 0, 28),
                Position = UDim2.new(1, -132, 0.5, -14),
                BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Parent = dropFrame
            })
            new("UICorner", {CornerRadius = UDim.new(0, 6), Parent = selectBtn})
            createStroke(selectBtn, Theme.Stroke, 1, 0.6)

            local dropArrow = new("TextLabel", {
                Name = "DropArrow", Text = "▾", TextColor3 = Theme.TextMuted,
                Font = Enum.Font.Gotham, TextSize = 12,
                BackgroundTransparency = 1,
                Position = UDim2.new(1, -20, 0.5, -10),
                Size = UDim2.new(0, 16, 0, 20), Parent = selectBtn
            })

            selectBtn.MouseButton1Click:Connect(function()
                playClick()
            end)

            return dropFrame
        end

        table.insert(Window._tabs, tabObj)
        return tabObj
    end

    return Window
end

return Library
