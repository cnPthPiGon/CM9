-- Rixer X Library V2
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
    Corner = 12
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

local clickSound = new("Sound", {Parent = SoundService, SoundId = "rbxassetid://16208317412", Volume = 5})

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

    local header = new("Frame", {
        Name = "Header",
        Size = UDim2.new(1,0,0,50),
        BackgroundTransparency = 1,
        Parent = main
    })

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

    -- Logo avatar dynamique en haut
    local logo = new("ImageLabel", {
        Name = "LogoAvatar",
        Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..LocalPlayer.UserId.."&width=420&height=420&format=png",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 36, 0, 36),
        Position = UDim2.new(0.5, -18, 0.5, -18),
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
        Position = UDim2.new(0,12,0,60),
        Size = UDim2.new(1,-24,1,-72),
        BackgroundTransparency = 1,
        Parent = main
    })

    local tabsColumn = new("ScrollingFrame", {
        Name = "TabsColumn",
        Size = UDim2.new(0,140,1,0),
        BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        Parent = content,
        CanvasSize = UDim2.new(0,0,0,0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })
    new("UICorner", {CornerRadius=UDim.new(0,8), Parent=tabsColumn})
    local tabsLayout = new("UIListLayout",{Parent=tabsColumn, SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0,8)})

    local pages = new("Frame", {
        Name = "Pages",
        Position = UDim2.new(0,156,0,0),
        Size = UDim2.new(1,-160,1,0),
        BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0,
        Parent = content
    })
    new("UICorner", {CornerRadius=UDim.new(0,8), Parent=pages})
    local pagesLayout = new("UIListLayout",{Parent=pages, SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0,8)})

    -- Drag window
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

    -- Minimisation
    local minimized = false
    local savedSize = main.Size
    toggleBtn.MouseButton1Click:Connect(function()
        clickSound:Play()
        minimized = not minimized
        if minimized then
            for _,obj in ipairs(content:GetChildren()) do
                if obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
                    TweenService:Create(obj, TweenInfo.new(0.2), {Transparency = 1}):Play()
                end
            end
            TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, Theme.WindowWidth, 0, 60)}):Play()
            task.wait(0.3)
            content.Visible = false
        else
            content.Visible = true
            TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = savedSize}):Play()
            for _,obj in ipairs(content:GetChildren()) do
                if obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
                    TweenService:Create(obj, TweenInfo.new(0.25), {Transparency = 0}):Play()
                end
            end
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        clickSound:Play()
        screenGui:Destroy()
    end)

    -- MakeTab
    function Window:MakeTab(tabInfo)
        tabInfo = tabInfo or {}
        local tabName = tabInfo.Name or "Tab"
        local tabIcon = tabInfo.Icon or ""
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

        -- Icon à la fin du bouton
        if tabIcon ~= "" then
            local icon = new("ImageLabel",{
                Name="Icon",
                Image=tabIcon,
                BackgroundTransparency=1,
                Size=UDim2.new(0,24,0,24),
                Position=UDim2.new(1,-28,0.5,-12),
                Parent=tabBtn
            })
        end

        local page = new("ScrollingFrame",{
            Name = "Page_"..tabName,
            Size=UDim2.new(1,-16,1,0),
            Position=UDim2.new(0,8,0,0),
            BackgroundTransparency=1,
            Parent=pages,
            ScrollBarThickness=6,
            CanvasSize=UDim2.new(0,0,0,0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        })
        new("UIListLayout",{Parent=page, SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0,8)})

        local tabObj = {Name=tabName,Button=tabBtn,Page=page,Elements={}}

        local function activate()
            clickSound:Play()
            for _,t in pairs(Window._tabs) do
                t.Page.Visible=false
                t.Button.BackgroundColor3=Theme.Button
            end
            page.Visible=true
            tabBtn.BackgroundColor3=Theme.Accent
            Window._active=tabObj
        end

        if #Window._tabs==0 then activate() else page.Visible=false end
        tabBtn.MouseButton1Click:Connect(activate)

        function tabObj:AddButton(opts)
            opts = opts or {}
            local btn = new("TextButton",{
                Name="Btn_"..(opts.Name or "Button"),
                Size=UDim2.new(1,-16,0,42),
                BackgroundColor3=Theme.Button,
                BorderSizePixel=0,
                Text="",
                Parent=page
            })
            new("UICorner",{CornerRadius=UDim.new(0,8),Parent=btn})

            -- Logo fixe sur tous les boutons
            local icon = new("ImageLabel",{
                Name="Icon",
                Image="rbxassetid://9468220156",
                BackgroundTransparency=1,
                Size=UDim2.new(0,24,0,24),
                Position=UDim2.new(0,10,0.5,-12),
                Parent=btn
            })

            local label = new("TextLabel",{
                Name="Label",
                Text=opts.Name or "Button",
                TextColor3=Theme.Text,
                Font=Enum.Font.Gotham,
                TextSize=14,
                BackgroundTransparency=1,
                Position=UDim2.new(0,40,0,0),
                Size=UDim2.new(1,-40,1,0),
                TextXAlignment=Enum.TextXAlignment.Left,
                Parent=btn
            })

            btn.MouseEnter:Connect(function()
                TweenService:Create(btn,TweenInfo.new(0.12,Enum.EasingStyle.Quad),{BackgroundColor3=Theme.ButtonHover}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn,TweenInfo.new(0.12,Enum.EasingStyle.Quad),{BackgroundColor3=Theme.Button}):Play()
            end)
            btn.MouseButton1Click:Connect(function()
                clickSound:Play()
                pcall(function()
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
