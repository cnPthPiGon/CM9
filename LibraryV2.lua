-- By Rixer95-x2 In Youtube
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local Library = {}
Library.__index = Library

local Theme = {
    WindowWidth = 620,
    WindowHeight = 520,
    Background = Color3.fromRGB(8, 8, 12),
    Panel = Color3.fromRGB(16, 16, 22),
    PanelAlt = Color3.fromRGB(12, 12, 18),
    PanelDark = Color3.fromRGB(6, 6, 10),
    Accent = Color3.fromRGB(65, 180, 255),
    AccentDark = Color3.fromRGB(30, 100, 180),
    AccentGlow = Color3.fromRGB(40, 140, 220),
    Text = Color3.fromRGB(240, 240, 248),
    TextDim = Color3.fromRGB(140, 140, 158),
    TextMuted = Color3.fromRGB(90, 90, 108),
    Button = Color3.fromRGB(30, 30, 38),
    ButtonHover = Color3.fromRGB(48, 48, 58),
    ButtonActive = Color3.fromRGB(55, 55, 68),
    Stroke = Color3.fromRGB(35, 35, 44),
    StrokeLight = Color3.fromRGB(55, 55, 68),
    Shadow = Color3.fromRGB(0, 0, 0),
    Success = Color3.fromRGB(45, 210, 120),
    Danger = Color3.fromRGB(220, 55, 65),
    Warning = Color3.fromRGB(240, 180, 40),
    Info = Color3.fromRGB(65, 160, 255),
    Corner = 14,
    CornerSmall = 8,
    CornerMini = 4
}

local function new(class, props)
    local ins = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            pcall(function() ins[k] = v end)
        end
    end
    return ins
end

local function createShadow(parent, size, intensity)
    local s = new("ImageLabel", {
        Name = "Shadow", Image = "rbxassetid://6015897843", ImageColor3 = Theme.Shadow,
        BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 50, 50),
        Size = UDim2.new(1, size or 24, 1, size or 24),
        Position = UDim2.new(0, -(size or 24) / 2, 0, -(size or 24) / 2),
        ZIndex = -2, Parent = parent
    })
    return s
end

local function createStroke(parent, color, thickness, transparency)
    local st = new("UIStroke", {
        Color = color or Theme.Stroke, Thickness = thickness or 1,
        Transparency = transparency or 0.8, Parent = parent
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
    local maxDim = math.max(size.X, size.Y) * 2
    local ripple = new("Frame", {
        Name = "Ripple", Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0, x, 0, y),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.65, ZIndex = btn.ZIndex + 5, Parent = btn
    })
    new("UICorner", {CornerRadius = UDim.new(0, maxDim / 2), Parent = ripple})
    local tw = TweenService:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, maxDim, 0, maxDim),
        Position = UDim2.new(0, x - maxDim / 2, 0, y - maxDim / 2),
        BackgroundTransparency = 1
    })
    tw:Play()
    tw.Completed:Connect(function() ripple:Destroy() end)
end

local function createParticleBurst(parent, x, y, count, color)
    for i = 1, count or 6 do
        local p = new("Frame", {
            Size = UDim2.new(0, 3, 0, 3),
            Position = UDim2.new(0, x, 0, y),
            BackgroundColor3 = color or Theme.Accent,
            BorderSizePixel = 0, Parent = parent
        })
        new("UICorner", {CornerRadius = UDim.new(0, 2), Parent = p})
        local angle = math.random() * 6.28
        local dist = math.random(30, 60)
        local tw = TweenService:Create(p, TweenInfo.new(0.35 + math.random() * 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, x + math.cos(angle) * dist, 0, y + math.sin(angle) * dist),
            BackgroundTransparency = 1, Size = UDim2.new(0, 1, 0, 1)
        })
        tw:Play()
        tw.Completed:Connect(function() p:Destroy() end)
    end
end

local clickSound = new("Sound", {
    Parent = SoundService, SoundId = "rbxassetid://9120386432", Volume = 2.8, Pitch = 1.15
})
local hoverSound = new("Sound", {
    Parent = SoundService, SoundId = "rbxassetid://9120386432", Volume = 1, Pitch = 0.75
})

local function playSound(sound)
    local clone = sound:Clone()
    clone.Parent = SoundService
    clone:Play()
    clone.Ended:Connect(function() clone:Destroy() end)
end

function Library:MakeWindow(opts)
    opts = opts or {}
    local name = opts.Name or "Rixer X Library V2"

    local screenGui = new("ScreenGui", {
        Name = "RixerXHub", ResetOnSpawn = false, DisplayOrder = 100,
        IgnoreGuiInset = true, Parent = LocalPlayer:WaitForChild("PlayerGui")
    })

    local overlay = new("Frame", {
        Name = "Overlay", Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, Parent = screenGui
    })
    TweenService:Create(overlay, TweenInfo.new(0.4), {BackgroundTransparency = 0.3}):Play()

    local main = new("Frame", {
        Name = "Main", Size = UDim2.new(0, Theme.WindowWidth, 0, Theme.WindowHeight),
        Position = UDim2.new(0.5, -Theme.WindowWidth / 2, 0.5, -Theme.WindowHeight / 2),
        BackgroundColor3 = Theme.Background, BorderSizePixel = 0,
        ClipsDescendants = false, Parent = screenGui
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.Corner), Parent = main})

    createShadow(main, 30)
    createStroke(main, Theme.StrokeLight, 1.2, 0.75)

    local glowBorder = new("Frame", {
        Name = "GlowBorder", Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1, ZIndex = 5, Parent = main
    })
    local glowStroke = new("UIStroke", {
        Color = Theme.AccentGlow, Thickness = 1.5, Transparency = 0.75, Parent = glowBorder
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.Corner), Parent = glowBorder})

    local header = new("Frame", {
        Name = "Header", Size = UDim2.new(1, 0, 0, 58),
        BackgroundColor3 = Theme.Panel, BorderSizePixel = 0, Parent = main
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.Corner), Parent = header})
    createGradient(header, 90, Theme.Panel, Theme.PanelAlt)

    local headerBottomGlow = new("Frame", {
        Name = "HeaderBottomGlow", Size = UDim2.new(1, 0, 0, 3),
        Position = UDim2.new(0, 0, 1, -3),
        BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.92,
        BorderSizePixel = 0, Parent = header
    })
    new("UICorner", {CornerRadius = UDim.new(0, 2), Parent = headerBottomGlow})

    local headerLine = new("Frame", {
        Name = "HeaderLine", Size = UDim2.new(1, -24, 0, 1),
        Position = UDim2.new(0, 12, 1, 0),
        BackgroundColor3 = Theme.StrokeLight, BackgroundTransparency = 0.9,
        BorderSizePixel = 0, Parent = header
    })

    local titleGrad = new("TextLabel", {
        Name = "Title", Text = name,
        TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 20,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 0), Size = UDim2.new(0.55, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = header
    })
    createGradient(titleGrad, 45, Theme.Text, Theme.Accent)

    local subtitle = new("TextLabel", {
        Name = "Subtitle", Text = "v2.0.0 • Rixer Ecosystem",
        TextColor3 = Theme.TextMuted, Font = Enum.Font.Gotham, TextSize = 10,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 28), Size = UDim2.new(0.55, 0, 0, 16),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = header
    })

    local avatarContainer = new("Frame", {
        Name = "AvatarContainer", Size = UDim2.new(0, 38, 0, 38),
        Position = UDim2.new(0.5, -19, 0.5, -19),
        BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Parent = header
    })
    new("UICorner", {CornerRadius = UDim.new(0, 19), Parent = avatarContainer})
    createStroke(avatarContainer, Theme.Accent, 1.8, 0.4)
    local avatarGlow = new("Frame", {
        Name = "AvatarGlow", Size = UDim2.new(1, 6, 1, 6),
        Position = UDim2.new(0.5, -3, 0.5, -3),
        BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.85,
        BorderSizePixel = 0, Parent = avatarContainer, ZIndex = -1
    })
    new("UICorner", {CornerRadius = UDim.new(0, 22), Parent = avatarGlow})

    local logo = new("ImageLabel", {
        Name = "Avatar",
        Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=420&height=420&format=png",
        BackgroundTransparency = 1, Size = UDim2.new(0, 34, 0, 34),
        Position = UDim2.new(0.5, -17, 0.5, -17), Parent = avatarContainer
    })
    new("UICorner", {CornerRadius = UDim.new(0, 17), Parent = logo})

    local statsLabel = new("TextLabel", {
        Name = "Stats", Text = "⚡ " .. tostring(math.random(800, 1500)) .. " ms",
        TextColor3 = Theme.Success, Font = Enum.Font.GothamBold, TextSize = 9,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 22, 0.5, -8), Parent = header
    })

    local function createHeaderButton(txt, posX)
        local btn = new("TextButton", {
            Name = "HBtn_" .. txt, Size = UDim2.new(0, 34, 0, 34),
            Position = UDim2.new(1, posX, 0.5, -17),
            BackgroundColor3 = Theme.Button, Text = txt,
            TextColor3 = Theme.Text, Font = Enum.Font.GothamBold,
            TextSize = 18, BorderSizePixel = 0, Parent = header
        })
        new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = btn})
        createStroke(btn, Theme.Stroke, 1, 0.75)
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Theme.ButtonHover}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Theme.Button}):Play()
        end)
        return btn
    end

    local toggleBtn = createHeaderButton("—", -82)
    local closeBtn = createHeaderButton("✕", -42)

    local content = new("Frame", {
        Name = "Content", Position = UDim2.new(0, 12, 0, 68),
        Size = UDim2.new(1, -24, 1, -80),
        BackgroundTransparency = 1, Parent = main
    })

    local tabsColumn = new("Frame", {
        Name = "TabsColumn", Size = UDim2.new(0, 155, 1, 0),
        BackgroundColor3 = Theme.PanelAlt, BorderSizePixel = 0, Parent = content
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = tabsColumn})
    createStroke(tabsColumn, Theme.Stroke, 1, 0.7)
    createGradient(tabsColumn, 180, Theme.PanelAlt, Theme.PanelDark)

    local tabsScroll = new("ScrollingFrame", {
        Name = "TabsScroll", Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.AccentDark,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = tabsColumn
    })
    local tabsLayout = new("UIListLayout", {
        Parent = tabsScroll, SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center
    })
    local tabsPadding = new("UIPadding", {
        Parent = tabsScroll, PaddingTop = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6)
    })

    local pagesContainer = new("Frame", {
        Name = "PagesContainer", Position = UDim2.new(0, 167, 0, 0),
        Size = UDim2.new(1, -173, 1, 0),
        BackgroundColor3 = Theme.PanelAlt, BorderSizePixel = 0, Parent = content
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = pagesContainer})
    createStroke(pagesContainer, Theme.Stroke, 1, 0.7)

    local pagesHeader = new("Frame", {
        Name = "PagesHeader", Size = UDim2.new(1, 0, 0, 28),
        BackgroundColor3 = Theme.PanelDark, BorderSizePixel = 0, Parent = pagesContainer
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = pagesHeader})

    local pageTitle = new("TextLabel", {
        Name = "PageTitle", Text = "Accueil", TextColor3 = Theme.TextDim,
        Font = Enum.Font.GothamBold, TextSize = 12,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0), Size = UDim2.new(0.8, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = pagesHeader
    })

    local pages = new("ScrollingFrame", {
        Name = "Pages", Size = UDim2.new(1, -12, 1, -34),
        Position = UDim2.new(0, 6, 0, 34),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.AccentDark,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = pagesContainer
    })
    local pagesLayout = new("UIListLayout", {
        Parent = pages, SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center
    })
    local pagesPadding = new("UIPadding", {
        Parent = pages, PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8)
    })

    do
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
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
    Window._pages = pages
    Window._tabsScroll = tabsScroll
    Window._pagesContainer = pagesContainer
    Window._pageTitle = pageTitle

    TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, Theme.WindowWidth, 0, Theme.WindowHeight)
    }):Play()

    local minimized = false
    local savedSize = main.Size
    toggleBtn.MouseButton1Click:Connect(function()
        playSound(clickSound)
        minimized = not minimized
        if minimized then
            for _, obj in ipairs(content:GetChildren()) do
                local fade = TweenService:Create(obj, TweenInfo.new(0.2), {Transparency = 1})
                fade:Play()
                for _, child in ipairs(obj:GetDescendants()) do
                    if child:IsA("Frame") or child:IsA("ScrollingFrame") or child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("ImageLabel") then
                        pcall(function()
                            TweenService:Create(child, TweenInfo.new(0.2), {Transparency = 1}):Play()
                        end)
                    end
                end
            end
            TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, Theme.WindowWidth, 0, 58)
            }):Play()
            TweenService:Create(glowBorder, TweenInfo.new(0.2), {Transparency = 1}):Play()
            task.wait(0.25)
            content.Visible = false
        else
            content.Visible = true
            TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = savedSize
            }):Play()
            TweenService:Create(glowBorder, TweenInfo.new(0.4), {Transparency = 0.75}):Play()
            for _, obj in ipairs(content:GetChildren()) do
                local fade = TweenService:Create(obj, TweenInfo.new(0.25), {Transparency = 0})
                fade:Play()
                for _, child in ipairs(obj:GetDescendants()) do
                    if child:IsA("Frame") or child:IsA("ScrollingFrame") or child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("ImageLabel") then
                        pcall(function()
                            TweenService:Create(child, TweenInfo.new(0.25), {Transparency = 0}):Play()
                        end)
                    end
                end
            end
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        playSound(clickSound)
        TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        TweenService:Create(overlay, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        screenGui:Destroy()
    end)

    function Window:MakeTab(tabInfo)
        tabInfo = tabInfo or {}
        local tabName = tabInfo.Name or "Tab"
        local tabIcon = tabInfo.Icon or ""

        local tabBtn = new("TextButton", {
            Name = "TabBtn_" .. tabName, Size = UDim2.new(1, 0, 0, 42),
            BackgroundColor3 = Theme.Button, BorderSizePixel = 0, Text = "", Parent = tabsScroll
        })
        new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = tabBtn})
        createStroke(tabBtn, Theme.Stroke, 1, 0.65)

        local btnContent = new("Frame", {
            Name = "BtnContent", Size = UDim2.new(1, -14, 1, 0),
            Position = UDim2.new(0, 7, 0, 0), BackgroundTransparency = 1, Parent = tabBtn
        })

        if tabIcon ~= "" then
            local icon = new("ImageLabel", {
                Name = "Icon", Image = tabIcon, BackgroundTransparency = 1,
                Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0, 2, 0.5, -10), Parent = btnContent
            })
            local label = new("TextLabel", {
                Name = "Label", Text = tabName, TextColor3 = Theme.Text,
                Font = Enum.Font.GothamBold, TextSize = 13, BackgroundTransparency = 1,
                Position = UDim2.new(0, 28, 0, 0), Size = UDim2.new(0.75, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = btnContent
            })
        else
            local label = new("TextLabel", {
                Name = "Label", Text = tabName, TextColor3 = Theme.Text,
                Font = Enum.Font.GothamBold, TextSize = 13, BackgroundTransparency = 1,
                Position = UDim2.new(0, 6, 0, 0), Size = UDim2.new(0.85, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = btnContent
            })
        end

        local badge = new("Frame", {
            Name = "Badge", Size = UDim2.new(0, 6, 0, 6),
            Position = UDim2.new(1, -10, 0.5, -3),
            BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.5,
            BorderSizePixel = 0, Parent = btnContent
        })
        new("UICorner", {CornerRadius = UDim.new(0, 3), Parent = badge})

        local indicator = new("Frame", {
            Name = "Indicator", Size = UDim2.new(0, 3, 0, 0),
            Position = UDim2.new(1, -1, 0.5, 0),
            BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = tabBtn
        })
        new("UICorner", {CornerRadius = UDim.new(0, 2), Parent = indicator})

        local page = new("ScrollingFrame", {
            Name = "Page_" .. tabName, Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1, BorderSizePixel = 0, Parent = pages,
            ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.AccentDark,
            CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y
        })
        local pageLayout = new("UIListLayout", {
            Parent = page, SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center
        })
        local pagePadding = new("UIPadding", {
            Parent = page, PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8)
        })

        local tabObj = {Name = tabName, Button = tabBtn, Page = page, Elements = {}}

        local function activate()
            playSound(clickSound)
            for _, t in pairs(Window._tabs) do
                t.Page.Visible = false
                TweenService:Create(t.Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Theme.Button
                }):Play()
                for _, child in ipairs(t.Button:GetDescendants()) do
                    if child.Name == "Indicator" then
                        TweenService:Create(child, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 0)}):Play()
                    end
                    if child:IsA("TextLabel") and child.Name == "Label" then
                        TweenService:Create(child, TweenInfo.new(0.2), {TextColor3 = Theme.Text}):Play()
                    end
                    if child.Name == "Badge" then
                        TweenService:Create(child, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
                    end
                end
            end
            page.Visible = true
            Window._pageTitle.Text = "◈ " .. tabName
            TweenService:Create(tabBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Theme.ButtonActive
            }):Play()
            for _, child in ipairs(tabBtn:GetDescendants()) do
                if child.Name == "Indicator" then
                    TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, 3, 1, -10)
                    }):Play()
                end
                if child:IsA("TextLabel") and child.Name == "Label" then
                    TweenService:Create(child, TweenInfo.new(0.2), {TextColor3 = Theme.Accent}):Play()
                end
                if child.Name == "Badge" then
                    TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = 0, Size = UDim2.new(0, 8, 0, 8), Position = UDim2.new(1, -12, 0.5, -4)}):Play()
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
                TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Button}):Play()
            end
        end)

        local tabBtnGlow = new("Frame", {
            Name = "BtnGlow", Size = UDim2.new(1, -8, 1, -8),
            Position = UDim2.new(0, 4, 0, 4),
            BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.95,
            BorderSizePixel = 0, Parent = tabBtn, ZIndex = -1
        })
        new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall - 1), Parent = tabBtnGlow})

        function tabObj:AddButton(opts)
            opts = opts or {}
            local btnName = opts.Name or "Button"
            local callback = opts.Callback or function() end
            local btnColor = opts.Color or Theme.Accent

            local btn = new("TextButton", {
                Name = "Btn_" .. btnName, Size = UDim2.new(1, -10, 0, 50),
                BackgroundColor3 = Theme.Button, BorderSizePixel = 0,
                Text = "", Parent = page
            })
            new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall), Parent = btn})
            createStroke(btn, Theme.Stroke, 1, 0.65)

            local innerGlow = new("Frame", {
                Name = "InnerGlow", Size = UDim2.new(1, -4, 1, -4),
                Position = UDim2.new(0, 2, 0, 2),
                BackgroundColor3 = btnColor, BackgroundTransparency = 0.94,
                BorderSizePixel = 0, Parent = btn
            })
            new("UICorner", {CornerRadius = UDim.new(0, Theme.CornerSmall - 1), Parent = innerGlow})

            local iconContainer = new("Frame", {
                Name = "IconContainer", Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(0, 10, 0.5, -15),
                BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Parent = btn
            })
            new("UICorner", {CornerRadius = UDim.new(0, 8), Parent = iconContainer})
            createStroke(iconContainer, Theme.Stroke, 1, 0.7)

            local icon = new("ImageLabel", {
                Name = "Icon", Image = "rbxassetid://9468220156",
                BackgroundTransparency = 1, Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(0.5, -10, 0.5, -10), Parent = iconContainer
            })

            local label = new("TextLabel", {
                Name = "Label", Text = btnName, TextColor3 = Theme.Text,
                Font = Enum.Font.Gotham, TextSize = 14, BackgroundTransparency = 1,
                Position = UDim2.new(0, 48, 0, 0), Size = UDim2.new(0.65, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = btn
            })

            local hint = new("TextLabel", {
                Name = "Hint", Text = "Cliquez pour exécuter",
                TextColor3 = Theme.TextMuted, Font = Enum.Font.Gotham, TextSize = 9,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 48, 0, 24), Size = UDim2.new(0.6, 0, 0, 16),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = btn
            })

            local arrowContainer = new("Frame", {
                Name = "ArrowContainer", Size = UDim2.new(0, 24, 0, 24),
                Position = UDim2.new(1, -32, 0.5, -12),
                BackgroundColor3 = Theme.Background, BackgroundTransparency = 0.5,
                BorderSizePixel = 0, Parent = btn
            })
            new("UICorner", {CornerRadius = UDim.new(0, 6), Parent = arrowContainer})

            local arrow = new("TextLabel", {
                Name = "Arrow", Text = "›", TextColor3 = Theme.TextDim,
                Font = Enum.Font.GothamBold, TextSize = 20, BackgroundTransparency = 1,
                Position = UDim2.new(0.5, -6, 0.5, -12), Size = UDim2.new(0, 12, 0, 24),
                Parent = arrowContainer
            })

            local statusDot = new("Frame", {
                Name = "StatusDot", Size = UDim2.new(0, 6, 0, 6),
                Position = UDim2.new(1, -12, 0.5, -3),
                BackgroundColor3 = Theme.Success, BackgroundTransparency = 0.4,
                BorderSizePixel = 0, Parent = btn
            })
            new("UICorner", {CornerRadius = UDim.new(0, 3), Parent = statusDot})

            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Theme.ButtonHover
                }):Play()
                TweenService:Create(arrowContainer, TweenInfo.new(0.15), {
                    BackgroundColor3 = btnColor, BackgroundTransparency = 0.7
                }):Play()
                TweenService:Create(arrow, TweenInfo.new(0.15), {
                    TextColor3 = btnColor, Position = UDim2.new(0.5, -4, 0.5, -12)
                }):Play()
                TweenService:Create(innerGlow, TweenInfo.new(0.1), {
                    BackgroundTransparency = 0.88
                }):Play()
                TweenService:Create(statusDot, TweenInfo.new(0.15), {
                    BackgroundTransparency = 0, Size = UDim2.new(0, 8, 0, 8)
                }):Play()
                TweenService:Create(iconContainer, TweenInfo.new(0.15), {
                    BackgroundColor3 = Theme.PanelAlt
                }):Play()
            end)

            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Theme.Button
                }):Play()
                TweenService:Create(arrowContainer, TweenInfo.new(0.15), {
                    BackgroundColor3 = Theme.Background, BackgroundTransparency = 0.5
                }):Play()
                TweenService:Create(arrow, TweenInfo.new(0.15), {
                    TextColor3 = Theme.TextDim, Position = UDim2.new(0.5, -6, 0.5, -12)
                }):Play()
                TweenService:Create(innerGlow, TweenInfo.new(0.15), {
                    BackgroundTransparency = 0.94
                }):Play()
                TweenService:Create(statusDot, TweenInfo.new(0.15), {
                    BackgroundTransparency = 0.4, Size = UDim2.new(0, 6, 0, 6)
                }):Play()
                TweenService:Create(iconContainer, TweenInfo.new(0.15), {
                    BackgroundColor3 = Theme.Background
                }):Play()
            end)

            btn.MouseButton1Click:Connect(function()
                playSound(clickSound)
                local mPos = UserInputService:GetMouseLocation()
                local absPos = btn.AbsolutePosition
                createRipple(btn, mPos.X - absPos.X, mPos.Y - absPos.Y)
                createParticleBurst(btn, 24, 25, 8, btnColor)

                TweenService:Create(btn, TweenInfo.new(0.06), {
                    BackgroundColor3 = btnColor
                }):Play()
                TweenService:Create(statusDot, TweenInfo.new(0.1), {
                    BackgroundColor3 = btnColor, BackgroundTransparency = 0,
                    Size = UDim2.new(0, 10, 0, 10)
                }):Play()
                task.delay(0.06, function()
                    TweenService:Create(btn, TweenInfo.new(0.1), {
                        BackgroundColor3 = Theme.ButtonHover
                    }):Play()
                    task.delay(0.1, function()
                        TweenService:Create(btn, TweenInfo.new(0.08), {
                            BackgroundColor3 = Theme.Button
                        }):Play()
                        TweenService:Create(statusDot, TweenInfo.new(0.2), {
                            BackgroundColor3 = Theme.Success,
                            Size = UDim2.new(0, 6, 0, 6),
                            BackgroundTransparency = 0.4
                        }):Play()
                    end)
                end)

                pcall(callback)
            end)

            table.insert(tabObj.Elements, btn)
            return btn
        end

        function tabObj:AddSection(text)
            local section = new("Frame", {
                Name = "Section_" .. text, Size = UDim2.new(1, -10, 0, 28),
                BackgroundTransparency = 1, Parent = page
            })
            local line = new("Frame", {
                Name = "Line", Size = UDim2.new(0.3, 0, 0, 1),
                Position = UDim2.new(0, 0, 0.5, 0),
                BackgroundColor3 = Theme.StrokeLight, BackgroundTransparency = 0.8,
                BorderSizePixel = 0, Parent = section
            })
            local sectionLabel = new("TextLabel", {
                Name = "Label", Text = "  " .. text, TextColor3 = Theme.TextDim,
                Font = Enum.Font.GothamBold, TextSize = 11,
                BackgroundTransparency = 1, Position = UDim2.new(0.3, 8, 0, 0),
                Size = UDim2.new(0.7, -8, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, Parent = section
            })
            return section
        end

        function tabObj:AddLabel(text, color)
            color = color or Theme.Text
            local label = new("TextLabel", {
                Name = "Label_" .. text, Size = UDim2.new(1, -10, 0, 24),
                Text = text, TextColor3 = color,
                Font = Enum.Font.Gotham, TextSize = 13,
                BackgroundTransparency = 1, Parent = page,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(tabObj.Elements, label)
            return label
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
                TweenService:Create(toggleOuter, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
                TweenService:Create(toggleInner, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Position = UDim2.new(1, -20, 0.5, -9)
                }):Play()
            end

            local function toggle()
                toggled = not toggled
                if toggled then
                    TweenService:Create(toggleOuter, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Theme.Accent
                    }):Play()
                    TweenService:Create(toggleInner, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Position = UDim2.new(1, -20, 0.5, -9)
                    }):Play()
                else
                    TweenService:Create(toggleOuter, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Theme.Background
                    }):Play()
                    TweenService:Create(toggleInner, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Theme.TextMuted,
                        Position = UDim2.new(0, 2, 0.5, -9)
                    }):Play()
                end
                pcall(callback, toggled)
            end

            toggleFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    playSound(clickSound)
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
                Name = "Slider_" .. sliderName, Size = UDim2.new(1, -10, 0, 52),
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
                Position = UDim2.new(0, 14, 0, 34),
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
            TweenService:Create(sliderKnob, TweenInfo.new(0.1), {
                Position = UDim2.new(0, -7 + sliderFill.AbsoluteSize.X * 0, 0.5, -4)
            }):Play()

            sliderBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragActive = true
                    local scale = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                    currentVal = math.floor(minVal + (maxVal - minVal) * scale)
                    TweenService:Create(sliderFill, TweenInfo.new(0.12), {Size = UDim2.new(scale, 0, 1, 0)}):Play()
                    sliderLabel.Text = sliderName .. " : " .. tostring(currentVal)
                    pcall(callback, currentVal)
                end
            end)

            local connection
            connection = RunService.Heartbeat:Connect(function()
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
                Position = UDim2.new(0, 14, 0, 0), Size = UDim2.new(0.6, 0, 1, 0),
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

            local expanded = false

            selectBtn.MouseButton1Click:Connect(function()
                playSound(clickSound)
                expanded = not expanded
                TweenService:Create(dropArrow, TweenInfo.new(0.15), {
                    Text = expanded and "▴" or "▾",
                    Rotation = expanded and 180 or 0
                }):Play()
            end)

            return dropFrame
        end

        table.insert(Window._tabs, tabObj)
        return tabObj
    end

    return Window
end

return Library
