-- Destroyers X Hub Library v2 (minimize corrige)
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SoundService = game:GetService("SoundService")

local Library = {}
Library.__index = Library

local Theme = {
    WindowWidth = 520,
    WindowHeight = 420,
    Background = Color3.fromRGB(18,18,18),
    Panel = Color3.fromRGB(28,28,28),
    Accent = Color3.fromRGB(65,160,255),
    Text = Color3.fromRGB(235,235,235),
    Button = Color3.fromRGB(50,50,50),
    ButtonHover = Color3.fromRGB(70,70,70),
    Stroke = Color3.fromRGB(30,30,30),
    Corner = 12,
    HeaderHeight = 50,
    MinimizedWidth = 220, -- largeur quand minimisé (modifiable)
    MinimizedHeight = 50  -- hauteur quand minimisé (doit correspondre au header)
}

local function new(class, props)
    local ins = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            pcall(function() ins[k] = v end)
        end
    end
    return ins
end

local function createScreenGui(name)
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local sg = new("ScreenGui", {Name = name or "DestroyersXHub", ResetOnSpawn = false, Parent = playerGui})
    return sg
end

-- Son de clic universel (garde le son en SoundService)
local clickSound = new("Sound", {Parent = SoundService, SoundId = "rbxassetid://2101148", Volume = 1})

function Library:MakeWindow(opts)
    opts = opts or {}
    local name = opts.Name or "Destroyers X Hub"

    local screenGui = createScreenGui("DestroyersXHub")
    local main = new("Frame", {
        Name = "Main",
        Size = UDim2.new(0, Theme.WindowWidth, 0, Theme.WindowHeight),
        Position = UDim2.new(0.5, -Theme.WindowWidth/2, 0.5, -Theme.WindowHeight/2),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Parent = screenGui
    })
    new("UICorner", {CornerRadius = UDim.new(0, Theme.Corner), Parent = main})

    local gradient = new("UIGradient", {Parent = main})
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Theme.Background:Lerp(Theme.Panel,0.08)),
        ColorSequenceKeypoint.new(1, Theme.Background)
    }
    gradient.Rotation = 90

    local header = new("Frame", {
        Name = "Header",
        Size = UDim2.new(1,0,0,Theme.HeaderHeight),
        BackgroundTransparency = 1,
        Parent = main
    })

    -- Logo du joueur local (centré dans le header)
    local playerLogoFrame = new("Frame", {
        Name = "PlayerLogoFrame",
        Size = UDim2.new(0,36,0,36),
        Position = UDim2.new(0.5,-18,0.5,-18),
        BackgroundColor3 = Theme.Panel,
        Parent = header
    })
    new("UICorner",{CornerRadius=UDim.new(0,18),Parent=playerLogoFrame})

    local playerLogo = new("ImageLabel", {
        Name = "PlayerLogo",
        Size = UDim2.new(1, -4,1,-4),
        Position = UDim2.new(0,2,0,2),
        BackgroundTransparency = 1,
        Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=420&h=420",
        Parent = playerLogoFrame
    })
    new("UICorner",{CornerRadius=UDim.new(0,16),Parent=playerLogo})

    local title = new("TextLabel", {
        Name = "Title",
        Text = name,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        BackgroundTransparency = 1,
        Position = UDim2.new(0,12,0,0),
        Size = UDim2.new(0.8,0,1,0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header
    })

    local toggleBtn = new("TextButton", {
        Name = "Toggle",
        Size = UDim2.new(0,36,0,36),
        Position = UDim2.new(1,-88,0.5,-18),
        BackgroundColor3 = Theme.Panel,
        Text = "—",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 22,
        Parent = header
    })
    new("UICorner", {CornerRadius=UDim.new(0,8), Parent=toggleBtn})

    local closeBtn = new("TextButton", {
        Name = "Close",
        Size = UDim2.new(0,36,0,36),
        Position = UDim2.new(1,-44,0.5,-18),
        BackgroundColor3 = Theme.Panel,
        Text = "❌",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        Parent = header
    })
    new("UICorner", {CornerRadius=UDim.new(0,8), Parent=closeBtn})

    local content = new("Frame", {
        Name = "Content",
        Position = UDim2.new(0,12,0,Theme.HeaderHeight + 10),
        Size = UDim2.new(1,-24,1, - (Theme.HeaderHeight + 18)),
        BackgroundTransparency = 1,
        Parent = main
    })

    local tabsColumn = new("ScrollingFrame", {
        Name = "TabsColumn",
        Size = UDim2.new(0,140,1,0),
        BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        Parent = content
    })
    new("UICorner", {CornerRadius=UDim.new(0,8), Parent=tabsColumn})
    local tabsLayout = new("UIListLayout", {Parent=tabsColumn, SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0,8)})

    local pages = new("Frame", {
        Name = "Pages",
        Position = UDim2.new(0,156,0,0),
        Size = UDim2.new(1,-160,1,0),
        BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0,
        Parent = content
    })
    new("UICorner", {CornerRadius=UDim.new(0,8), Parent=pages})
    local pagesLayout = new("UIListLayout", {Parent=pages, SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0,8)})

    -- sauvegarder taille/position initiales pour restore
    local originalSize = main.Size
    local originalPosition = main.Position

    -- drag mobile/pc (inchangé)
    do
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
        end
        header.InputBegan:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                dragging=true
                dragStart=input.Position
                startPos=main.Position
                input.Changed:Connect(function()
                    if input.UserInputState==Enum.UserInputState.End then dragging=false end
                end)
            end
        end)
        header.InputChanged:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
                dragInput=input
            end
        end)
        RunService.Heartbeat:Connect(function()
            if dragging and dragInput then
                pcall(function() update(dragInput) end)
            end
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

    local minimized = false

    -- Fonction pour basculer minimize / restore avec animation propre
    local function setMinimized(state)
        if state == minimized then return end
        minimized = state
        clickSound:Play()
        if minimized then
            -- Animator: réduire la fenêtre et masquer le contenu (animation fluide)
            local targetSize = UDim2.new(0, Theme.MinimizedWidth, 0, Theme.MinimizedHeight)
            local targetPos = UDim2.new(0.5, -Theme.MinimizedWidth/2, 0.5, -Theme.MinimizedHeight/2)
            -- Masquer progressivement le contenu (fade + visible=false après)
            local fadeTween = TweenService:Create(content, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1,-24,0,0)})
            fadeTween:Play()
            fadeTween.Completed:Wait()
            content.Visible = false
            tabsColumn.Visible = false
            pages.Visible = false
            playerLogoFrame.Visible = false
            title.Visible = false
            -- réduire le main
            TweenService:Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize, Position = targetPos}):Play()
        else
            -- Restore: agrandir la fenêtre et réafficher le contenu
            content.Visible = true
            tabsColumn.Visible = true
            pages.Visible = true
            playerLogoFrame.Visible = true
            title.Visible = true
            -- Animer la taille et la position vers l'original
            TweenService:Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = originalSize, Position = originalPosition}):Play()
            -- revenir la taille du content progressivement
            delay(0.18, function()
                TweenService:Create(content, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1,-24,1, - (Theme.HeaderHeight + 18))}):Play()
            end)
        end
    end

    toggleBtn.MouseButton1Click:Connect(function()
        setMinimized(not minimized)
    end)

    closeBtn.MouseButton1Click:Connect(function()
        clickSound:Play()
        screenGui:Destroy()
    end)

    function Window:MakeTab(tabInfo)
        tabInfo = tabInfo or {}
        local tabName = tabInfo.Name or "Tab"
        local tabBtn = new("TextButton", {
            Name = "TabBtn_"..tabName,
            Size = UDim2.new(1,-16,0,44),
            BackgroundColor3 = Theme.Button,
            BorderSizePixel = 0,
            Text = tabName,
            TextColor3 = Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            Parent = tabsColumn
        })
        new("UICorner",{CornerRadius=UDim.new(0,8),Parent=tabBtn})

        local page = new("ScrollingFrame",{
            Name = "Page_"..tabName,
            Size=UDim2.new(1,-16,1,0),
            Position=UDim2.new(0,8,0,0),
            BackgroundTransparency=1,
            Parent=pages,
            ScrollBarThickness=6
        })
        page.AutomaticCanvasSize=Enum.AutomaticSize.Y
        local pageLayout = new("UIListLayout",{Parent=page,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8)})

        local tabObj = {Name=tabName,Button=tabBtn,Page=page,Elements={}}

        local function activate()
            clickSound:Play()
            for _,t in pairs(Window._tabs) do
                t.Page.Visible = false
                t.Button.BackgroundColor3 = Theme.Button
            end
            page.Visible = true
            tabBtn.BackgroundColor3 = Theme.Accent
            Window._active = tabObj
        end

        if #Window._tabs == 0 then activate() else page.Visible = false end
        tabBtn.MouseButton1Click:Connect(activate)

        -- Fonction pour ajouter des boutons dans la tab
        function tabObj:AddButton(opts)
            opts = opts or {}
            local btn = new("TextButton",{
                Name="Btn_"..(opts.Name or "Button"),
                Size=UDim2.new(1,-16,0,42),
                BackgroundColor3=Theme.Button,
                BorderSizePixel=0,
                Text=opts.Name or "Button",
                TextColor3=Theme.Text,
                Font=Enum.Font.Gotham,
                TextSize=14,
                Parent=page
            })
            new("UICorner",{CornerRadius=UDim.new(0,8),Parent=btn})
            local g=new("UIGradient",{Parent=btn})
            g.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Theme.Button:Lerp(Theme.ButtonHover,0.06)),ColorSequenceKeypoint.new(1,Theme.Button)})
            g.Rotation=90

            btn.MouseEnter:Connect(function()
                TweenService:Create(btn,TweenInfo.new(0.12,Enum.EasingStyle.Quad),{BackgroundColor3=Theme.ButtonHover}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn,TweenInfo.new(0.12,Enum.EasingStyle.Quad),{BackgroundColor3=Theme.Button}):Play()
            end)
            btn.MouseButton1Click:Connect(function()
                clickSound:Play()
                pcall(function()
                    local orig = btn.BackgroundColor3
                    TweenService:Create(btn,TweenInfo.new(0.06),{BackgroundColor3=Theme.Accent}):Play()
                    delay(0.08,function()
                        if btn and btn.Parent then btn.BackgroundColor3 = orig end
                    end)
                    if opts.Callback then opts.Callback() end
                end)
            end)

            table.insert(tabObj.Elements,btn)
            return btn
        end

        table.insert(Window._tabs,tabObj)
        return tabObj
    end

    return Window
end

return Library
