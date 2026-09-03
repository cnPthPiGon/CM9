-- Made By Chxris - @Rixer95-x2 in Youtube.
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Sounds = {}
local SoundKeys = {}
local Rows = {}
local Loops = {}
local Query = ""
local Selected = nil
local RefreshQueued = false
local Destroyed = false
local PlayingAll = false
local LoopAllActive = false
local AllConnection
local LoopAllConnection
local FPS = 0
local LastFPSUpdate = os.clock()
local FPSFrames = 0

local Gui = Instance.new("ScreenGui")
Gui.Name = "SoundExplorer"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(480, 390)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(18, 20, 25)
Main.BorderSizePixel = 0
Main.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(60, 64, 72)
Stroke.Transparency = 0.35
Stroke.Parent = Main

local Scale = Instance.new("UIScale")
Scale.Parent = Main

local function Resize()
	local Camera = workspace.CurrentCamera
	if not Camera then
		return
	end

	local View = Camera.ViewportSize

	if UIS.TouchEnabled then
		local SX = (View.X - 24) / 480
		local SY = (View.Y - 80) / 390
		Scale.Scale = math.clamp(math.min(SX, SY), 0.72, 1)
	else
		local SX = (View.X - 100) / 480
		local SY = (View.Y - 100) / 390
		Scale.Scale = math.clamp(math.min(SX, SY), 0.9, 1.15)
	end
end

Resize()

if workspace.CurrentCamera then
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(Resize)
end

local Header = Instance.new("Frame")
Header.BackgroundTransparency = 1
Header.Position = UDim2.fromOffset(10, 5)
Header.Size = UDim2.new(1, -20, 0, 43)
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(2, 0)
Title.Size = UDim2.fromOffset(125, 21)
Title.Font = Enum.Font.GothamMedium
Title.Text = "Sounds Explorer"
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(235, 237, 241)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Count = Instance.new("TextLabel")
Count.BackgroundTransparency = 1
Count.Position = UDim2.fromOffset(2, 20)
Count.Size = UDim2.fromOffset(95, 16)
Count.Font = Enum.Font.Gotham
Count.Text = "0 sounds"
Count.TextSize = 8
Count.TextColor3 = Color3.fromRGB(125, 132, 144)
Count.TextXAlignment = Enum.TextXAlignment.Left
Count.Parent = Header

local FPSLabel = Instance.new("TextLabel")
FPSLabel.BackgroundTransparency = 1
FPSLabel.Position = UDim2.fromOffset(100, 20)
FPSLabel.Size = UDim2.fromOffset(70, 16)
FPSLabel.Font = Enum.Font.Gotham
FPSLabel.Text = "FPS: 0"
FPSLabel.TextSize = 8
FPSLabel.TextColor3 = Color3.fromRGB(125, 132, 144)
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.Parent = Header

local Respect = Instance.new("TextLabel")
Respect.BackgroundTransparency = 1
Respect.Position = UDim2.fromOffset(172, 20)
Respect.Size = UDim2.fromOffset(125, 16)
Respect.Font = Enum.Font.Gotham
Respect.TextSize = 8
Respect.TextXAlignment = Enum.TextXAlignment.Left
Respect.Parent = Header

local Credit = Instance.new("TextLabel")
Credit.BackgroundTransparency = 1
Credit.Position = UDim2.new(1, -205, 0, 20)
Credit.Size = UDim2.fromOffset(205, 16)
Credit.Font = Enum.Font.Gotham
Credit.Text = "Made By Chxris - Rixer95-x2 In Youtube."
Credit.TextSize = 7
Credit.TextColor3 = Color3.fromRGB(105, 110, 120)
Credit.TextXAlignment = Enum.TextXAlignment.Right
Credit.Parent = Header

local function UpdateRespect()
	if SoundService.RespectFilteringEnabled then
		Respect.Text = "RespectFilteringEnabled: ON"
	else
		Respect.Text = "RespectFilteringEnabled: OFF"
	end

	Respect.TextColor3 = Color3.fromRGB(210, 80, 75)
end

UpdateRespect()

pcall(function()
	SoundService:GetPropertyChangedSignal("RespectFilteringEnabled"):Connect(UpdateRespect)
end)

local AllButton = Instance.new("TextButton")
AllButton.Position = UDim2.new(1, -330, 0, 1)
AllButton.Size = UDim2.fromOffset(76, 18)
AllButton.BackgroundColor3 = Color3.fromRGB(52, 91, 70)
AllButton.BorderSizePixel = 0
AllButton.Font = Enum.Font.GothamMedium
AllButton.Text = "PLAY ALL"
AllButton.TextSize = 7
AllButton.TextColor3 = Color3.fromRGB(235, 239, 244)
AllButton.Parent = Header

local AllCorner = Instance.new("UICorner")
AllCorner.CornerRadius = UDim.new(0, 4)
AllCorner.Parent = AllButton

local LoopAll = Instance.new("TextButton")
LoopAll.Position = UDim2.new(1, -249, 0, 1)
LoopAll.Size = UDim2.fromOffset(76, 18)
LoopAll.BackgroundColor3 = Color3.fromRGB(83, 73, 43)
LoopAll.BorderSizePixel = 0
LoopAll.Font = Enum.Font.GothamMedium
LoopAll.Text = "LOOPALL"
LoopAll.TextSize = 7
LoopAll.TextColor3 = Color3.fromRGB(235, 239, 244)
LoopAll.Parent = Header

local LoopAllCorner = Instance.new("UICorner")
LoopAllCorner.CornerRadius = UDim.new(0, 4)
LoopAllCorner.Parent = LoopAll

local UnloopAll = Instance.new("TextButton")
UnloopAll.Position = UDim2.new(1, -168, 0, 1)
UnloopAll.Size = UDim2.fromOffset(76, 18)
UnloopAll.BackgroundColor3 = Color3.fromRGB(83, 73, 43)
UnloopAll.BorderSizePixel = 0
UnloopAll.Font = Enum.Font.GothamMedium
UnloopAll.Text = "UNLOOPALL"
UnloopAll.TextSize = 7
UnloopAll.TextColor3 = Color3.fromRGB(235, 239, 244)
UnloopAll.Parent = Header

local UnloopCorner = Instance.new("UICorner")
UnloopCorner.CornerRadius = UDim.new(0, 4)
UnloopCorner.Parent = UnloopAll

local RejoinButton = Instance.new("TextButton")
RejoinButton.Position = UDim2.new(1, -87, 0, 1)
RejoinButton.Size = UDim2.fromOffset(76, 18)
RejoinButton.BackgroundColor3 = Color3.fromRGB(48, 67, 91)
RejoinButton.BorderSizePixel = 0
RejoinButton.Font = Enum.Font.GothamMedium
RejoinButton.Text = "REJOIN"
RejoinButton.TextSize = 7
RejoinButton.TextColor3 = Color3.fromRGB(235, 239, 244)
RejoinButton.Parent = Header

local RejoinCorner = Instance.new("UICorner")
RejoinCorner.CornerRadius = UDim.new(0, 4)
RejoinCorner.Parent = RejoinButton

local VolumeSound = Instance.new("TextButton")
VolumeSound.Position = UDim2.fromOffset(10, 75)
VolumeSound.Size = UDim2.fromOffset(100, 14)
VolumeSound.BackgroundColor3 = Color3.fromRGB(42, 75, 108)
VolumeSound.BorderSizePixel = 0
VolumeSound.Font = Enum.Font.GothamMedium
VolumeSound.Text = "VOLUME SOUND"
VolumeSound.TextSize = 6
VolumeSound.TextColor3 = Color3.fromRGB(235, 239, 244)
VolumeSound.Parent = Main

local VolumeCorner = Instance.new("UICorner")
VolumeCorner.CornerRadius = UDim.new(0, 4)
VolumeCorner.Parent = VolumeSound

local BackButton = Instance.new("TextButton")
BackButton.Position = UDim2.fromOffset(115, 75)
BackButton.Size = UDim2.fromOffset(60, 14)
BackButton.BackgroundColor3 = Color3.fromRGB(48, 67, 91)
BackButton.BorderSizePixel = 0
BackButton.Font = Enum.Font.GothamMedium
BackButton.Text = "RETOUR"
BackButton.TextSize = 6
BackButton.TextColor3 = Color3.fromRGB(235, 239, 244)
BackButton.Visible = false
BackButton.Parent = Main

local BackCorner = Instance.new("UICorner")
BackCorner.CornerRadius = UDim.new(0, 4)
BackCorner.Parent = BackButton

local Search = Instance.new("TextBox")
Search.Position = UDim2.fromOffset(10, 52)
Search.Size = UDim2.new(1, -20, 0, 20)
Search.BackgroundColor3 = Color3.fromRGB(27, 30, 37)
Search.BorderSizePixel = 0
Search.ClearTextOnFocus = false
Search.PlaceholderText = "Search sounds..."
Search.PlaceholderColor3 = Color3.fromRGB(105, 110, 120)
Search.Text = ""
Search.TextColor3 = Color3.fromRGB(232, 234, 238)
Search.TextSize = 8
Search.Font = Enum.Font.Gotham
Search.TextXAlignment = Enum.TextXAlignment.Left
Search.Parent = Main

local SearchPadding = Instance.new("UIPadding")
SearchPadding.PaddingLeft = UDim.new(0, 8)
SearchPadding.PaddingRight = UDim.new(0, 8)
SearchPadding.Parent = Search

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 5)
SearchCorner.Parent = Search

local List = Instance.new("ScrollingFrame")
List.Position = UDim2.fromOffset(10, 92)
List.Size = UDim2.new(1, -20, 1, -102)
List.BackgroundColor3 = Color3.fromRGB(13, 15, 19)
List.BorderSizePixel = 0
List.ScrollBarThickness = 3
List.ScrollBarImageColor3 = Color3.fromRGB(70, 74, 83)
List.AutomaticCanvasSize = Enum.AutomaticSize.Y
List.CanvasSize = UDim2.new()
List.Parent = Main

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 6)
ListCorner.Parent = List

local ListPadding = Instance.new("UIPadding")
ListPadding.PaddingTop = UDim.new(0, 5)
ListPadding.PaddingBottom = UDim.new(0, 5)
ListPadding.PaddingLeft = UDim.new(0, 5)
ListPadding.PaddingRight = UDim.new(0, 5)
ListPadding.Parent = List

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 3)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = List

local Properties = Instance.new("Frame")
Properties.Visible = false
Properties.Position = UDim2.fromOffset(10, 92)
Properties.Size = UDim2.new(1, -20, 1, -102)
Properties.BackgroundColor3 = Color3.fromRGB(16, 18, 23)
Properties.BorderSizePixel = 0
Properties.Parent = Main

local PropertiesCorner = Instance.new("UICorner")
PropertiesCorner.CornerRadius = UDim.new(0, 6)
PropertiesCorner.Parent = Properties

local PropertiesTitle = Instance.new("TextLabel")
PropertiesTitle.BackgroundTransparency = 1
PropertiesTitle.Position = UDim2.fromOffset(10, 8)
PropertiesTitle.Size = UDim2.new(1, -65, 0, 19)
PropertiesTitle.Font = Enum.Font.GothamMedium
PropertiesTitle.Text = "Sound properties"
PropertiesTitle.TextSize = 11
PropertiesTitle.TextColor3 = Color3.fromRGB(225, 228, 234)
PropertiesTitle.TextXAlignment = Enum.TextXAlignment.Left
PropertiesTitle.Parent = Properties

local Close = Instance.new("TextButton")
Close.Position = UDim2.new(1, -43, 0, 7)
Close.Size = UDim2.fromOffset(33, 25)
Close.BackgroundColor3 = Color3.fromRGB(31, 34, 41)
Close.BorderSizePixel = 0
Close.Font = Enum.Font.Gotham
Close.Text = "×"
Close.TextSize = 15
Close.TextColor3 = Color3.fromRGB(200, 204, 212)
Close.Parent = Properties

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = Close

local SelectedName = Instance.new("TextLabel")
SelectedName.BackgroundTransparency = 1
SelectedName.Position = UDim2.fromOffset(10, 31)
SelectedName.Size = UDim2.new(1, -20, 0, 20)
SelectedName.Font = Enum.Font.GothamMedium
SelectedName.Text = ""
SelectedName.TextSize = 11
SelectedName.TextColor3 = Color3.fromRGB(150, 183, 220)
SelectedName.TextXAlignment = Enum.TextXAlignment.Left
SelectedName.TextTruncate = Enum.TextTruncate.AtEnd
SelectedName.Parent = Properties

local PathBox = Instance.new("TextBox")
PathBox.Position = UDim2.fromOffset(10, 55)
PathBox.Size = UDim2.new(1, -20, 0, 34)
PathBox.BackgroundColor3 = Color3.fromRGB(11, 13, 17)
PathBox.BorderSizePixel = 0
PathBox.ClearTextOnFocus = false
PathBox.TextEditable = false
PathBox.Text = ""
PathBox.TextColor3 = Color3.fromRGB(145, 151, 162)
PathBox.TextSize = 8
PathBox.Font = Enum.Font.Code
PathBox.TextXAlignment = Enum.TextXAlignment.Left
PathBox.TextYAlignment = Enum.TextYAlignment.Center
PathBox.TextTruncate = Enum.TextTruncate.AtEnd
PathBox.Parent = Properties

local PathPadding = Instance.new("UIPadding")
PathPadding.PaddingLeft = UDim.new(0, 8)
PathPadding.PaddingRight = UDim.new(0, 8)
PathPadding.Parent = PathBox

local PathCorner = Instance.new("UICorner")
PathCorner.CornerRadius = UDim.new(0, 5)
PathCorner.Parent = PathBox

local CopyAll = Instance.new("TextButton")
CopyAll.Position = UDim2.fromOffset(10, 94)
CopyAll.Size = UDim2.new(1, -20, 0, 27)
CopyAll.BackgroundColor3 = Color3.fromRGB(48, 88, 132)
CopyAll.BorderSizePixel = 0
CopyAll.Font = Enum.Font.GothamMedium
CopyAll.Text = "Copy path"
CopyAll.TextSize = 9
CopyAll.TextColor3 = Color3.fromRGB(240, 243, 247)
CopyAll.Parent = Properties

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 5)
CopyCorner.Parent = CopyAll

local PropertyList = Instance.new("ScrollingFrame")
PropertyList.Position = UDim2.fromOffset(10, 128)
PropertyList.Size = UDim2.new(1, -20, 1, -138)
PropertyList.BackgroundTransparency = 1
PropertyList.BorderSizePixel = 0
PropertyList.ScrollBarThickness = 3
PropertyList.ScrollBarImageColor3 = Color3.fromRGB(70, 74, 83)
PropertyList.AutomaticCanvasSize = Enum.AutomaticSize.Y
PropertyList.CanvasSize = UDim2.new()
PropertyList.Parent = Properties

local PropertyLayout = Instance.new("UIListLayout")
PropertyLayout.Padding = UDim.new(0, 2)
PropertyLayout.SortOrder = Enum.SortOrder.LayoutOrder
PropertyLayout.Parent = PropertyList

local function GetPath(Object)
	local Parts = {}
	local Current = Object

	while Current and Current ~= game do
		table.insert(Parts, 1, Current.Name)
		Current = Current.Parent
	end

	local Result = "game"

	for _, Name in ipairs(Parts) do
		if Name:match("^[%a_][%w_]*$") then
			Result = Result .. "." .. Name
		else
			Result = Result .. "[\"" .. Name:gsub("\\", "\\\\"):gsub("\"", "\\\"") .. "\"]"
		end
	end

	return Result
end

local function GetSoundKey(Sound)
	return Sound.SoundId .. "|" .. Sound.Name
end

local function Copy(Text)
	if typeof(setclipboard) == "function" then
		pcall(setclipboard, Text)
	elseif typeof(to_clipboard) == "function" then
		pcall(to_clipboard, Text)
	end
end

local function ValueToString(Value)
	local Type = typeof(Value)

	if Type == "Instance" then
		if Value then
			return GetPath(Value)
		end
		return "nil"
	elseif Type == "EnumItem" then
		return tostring(Value)
	elseif Type == "Vector3" then
		return string.format("%.3f, %.3f, %.3f", Value.X, Value.Y, Value.Z)
	elseif Type == "Vector2" then
		return string.format("%.3f, %.3f", Value.X, Value.Y)
	elseif Type == "Color3" then
		return string.format("%.3f, %.3f, %.3f", Value.R, Value.G, Value.B)
	else
		return tostring(Value)
	end
end

local SoundProperties = {
	"Name",
	"SoundId",
	"Volume",
	"PlaybackSpeed",
	"Playing",
	"Looped",
	"TimePosition",
	"TimeLength",
	"PlaybackRegionsEnabled",
	"PlaybackRegion",
	"RollOffMode",
	"RollOffMinDistance",
	"RollOffMaxDistance",
	"EmitterSize",
	"SoundGroup",
	"Archivable",
	"Parent"
}

local function ClearProperties()
	for _, Object in ipairs(PropertyList:GetChildren()) do
		if Object:IsA("GuiObject") then
			Object:Destroy()
		end
	end
end

local function AddProperty(Name, Value, Order)
	local Row = Instance.new("Frame")
	Row.Size = UDim2.new(1, -2, 0, 29)
	Row.BackgroundColor3 = Color3.fromRGB(25, 28, 34)
	Row.BorderSizePixel = 0
	Row.LayoutOrder = Order
	Row.Parent = PropertyList

	local RC = Instance.new("UICorner")
	RC.CornerRadius = UDim.new(0, 4)
	RC.Parent = Row

	local N = Instance.new("TextLabel")
	N.BackgroundTransparency = 1
	N.Position = UDim2.fromOffset(8, 0)
	N.Size = UDim2.new(0.43, -8, 1, 0)
	N.Font = Enum.Font.Gotham
	N.Text = Name
	N.TextSize = 8
	N.TextColor3 = Color3.fromRGB(139, 145, 156)
	N.TextXAlignment = Enum.TextXAlignment.Left
	N.TextTruncate = Enum.TextTruncate.AtEnd
	N.Parent = Row

	local V = Instance.new("TextLabel")
	V.BackgroundTransparency = 1
	V.Position = UDim2.new(0.43, 0, 0, 0)
	V.Size = UDim2.new(0.57, -8, 1, 0)
	V.Font = Enum.Font.Code
	V.Text = ValueToString(Value)
	V.TextSize = 7
	V.TextColor3 = Color3.fromRGB(222, 225, 231)
	V.TextXAlignment = Enum.TextXAlignment.Right
	V.TextTruncate = Enum.TextTruncate.AtEnd
	V.Parent = Row
end

local function ShowProperties(Sound)
	if not Sound or not Sound.Parent then
		return
	end

	Selected = Sound
	ClearProperties()

	SelectedName.Text = Sound.Name
	PathBox.Text = GetPath(Sound)

	local Order = 0

	for _, Property in ipairs(SoundProperties) do
		local Success, Value = pcall(function()
			return Sound[Property]
		end)

		if Success then
			Order += 1
			AddProperty(Property, Value, Order)
		end
	end

	for Name, Value in pairs(Sound:GetAttributes()) do
		Order += 1
		AddProperty("Attribute: " .. Name, Value, Order)
	end

	List.Visible = false
	Search.Visible = false
	Count.Visible = false
	Properties.Visible = true
	VolumeSound.Visible = false
	BackButton.Visible = false
end

local function HideProperties()
	Selected = nil
	Properties.Visible = false
	List.Visible = true
	Search.Visible = true
	Count.Visible = true
	VolumeSound.Visible = true
	BackButton.Visible = false
end

Close.MouseButton1Click:Connect(HideProperties)

CopyAll.MouseButton1Click:Connect(function()
	if Selected and Selected.Parent then
		Copy(GetPath(Selected))
	end
end)

local function UpdateCount()
	local Amount = 0

	for Sound in pairs(Sounds) do
		if Sound.Parent then
			Amount += 1
		end
	end

	Count.Text = tostring(Amount) .. " sounds"
end

local function UpdateLoopButton(Sound)
	local Row = Rows[Sound]

	if not Row then
		return
	end

	local LoopButton = Row:FindFirstChild("LoopButton")

	if not LoopButton then
		return
	end

	if Loops[Sound] then
		LoopButton.Text = "Looping"
		LoopButton.BackgroundColor3 = Color3.fromRGB(65, 105, 78)
	else
		LoopButton.Text = "Loop"
		LoopButton.BackgroundColor3 = Color3.fromRGB(83, 73, 43)
	end
end

local function StopLoop(Sound)
	local Data = Loops[Sound]

	if Data then
		Data.Active = false
		Loops[Sound] = nil
	end

	if Sound and Sound.Parent then
		pcall(function()
			Sound:Stop()
		end)
	end

	UpdateLoopButton(Sound)
end

local function StartLoop(Sound)
	if not Sound or not Sound.Parent then
		return
	end

	if Loops[Sound] then
		return
	end

	local Data = {
		Active = true
	}

	Loops[Sound] = Data
	UpdateLoopButton(Sound)

	task.spawn(function()
		while Data.Active and not Destroyed and Sound.Parent do
			pcall(function()
				Sound:Play()
			end)

			local StartTime = os.clock()

			while Data.Active and not Destroyed and Sound.Parent and os.clock() - StartTime < 0.5 do
				task.wait()
			end

			if Data.Active and not Destroyed and Sound.Parent then
				pcall(function()
					Sound:Stop()
				end)
			end

			task.wait()
		end

		if Loops[Sound] == Data then
			Loops[Sound] = nil
			UpdateLoopButton(Sound)
		end
	end)
end

local function CreateRow(Sound, Order)
	if not Sound or not Sound.Parent then
		return
	end

	if Rows[Sound] then
		Rows[Sound].LayoutOrder = Order
		UpdateLoopButton(Sound)
		return
	end

	local Row = Instance.new("Frame")
	Row.Name = "Sound"
	Row.Size = UDim2.new(1, 0, 0, 42)
	Row.BackgroundColor3 = Color3.fromRGB(21, 24, 30)
	Row.BorderSizePixel = 0
	Row.LayoutOrder = Order
	Row.Parent = List

	local RC = Instance.new("UICorner")
	RC.CornerRadius = UDim.new(0, 5)
	RC.Parent = Row

	local Select = Instance.new("TextButton")
	Select.BackgroundTransparency = 1
	Select.Position = UDim2.fromOffset(0, 0)
	Select.Size = UDim2.new(1, -239, 1, 0)
	Select.Text = ""
	Select.Parent = Row

	local Name = Instance.new("TextLabel")
	Name.BackgroundTransparency = 1
	Name.Position = UDim2.fromOffset(8, 3)
	Name.Size = UDim2.new(1, -15, 0, 15)
	Name.Font = Enum.Font.Gotham
	Name.Text = Sound.Name
	Name.TextSize = 10
	Name.TextColor3 = Color3.fromRGB(232, 235, 240)
	Name.TextXAlignment = Enum.TextXAlignment.Left
	Name.TextTruncate = Enum.TextTruncate.AtEnd
	Name.Parent = Select

	local SoundPath = Instance.new("TextLabel")
	SoundPath.BackgroundTransparency = 1
	SoundPath.Position = UDim2.fromOffset(8, 20)
	SoundPath.Size = UDim2.new(1, -15, 0, 12)
	SoundPath.Font = Enum.Font.Code
	SoundPath.Text = GetPath(Sound)
	SoundPath.TextSize = 7
	SoundPath.TextColor3 = Color3.fromRGB(105, 111, 123)
	SoundPath.TextXAlignment = Enum.TextXAlignment.Left
	SoundPath.TextTruncate = Enum.TextTruncate.AtEnd
	SoundPath.Parent = Select

	local PlayButton = Instance.new("TextButton")
	PlayButton.Position = UDim2.new(1, -231, 0.5, -12)
	PlayButton.Size = UDim2.fromOffset(51, 24)
	PlayButton.BackgroundColor3 = Color3.fromRGB(52, 105, 75)
	PlayButton.BorderSizePixel = 0
	PlayButton.Font = Enum.Font.GothamMedium
	PlayButton.Text = "Play"
	PlayButton.TextSize = 8
	PlayButton.TextColor3 = Color3.fromRGB(235, 239, 245)
	PlayButton.Parent = Row

	local PlayCorner = Instance.new("UICorner")
	PlayCorner.CornerRadius = UDim.new(0, 5)
	PlayCorner.Parent = PlayButton

	local LoopButton = Instance.new("TextButton")
	LoopButton.Name = "LoopButton"
	LoopButton.Position = UDim2.new(1, -176, 0.5, -12)
	LoopButton.Size = UDim2.fromOffset(51, 24)
	LoopButton.BackgroundColor3 = Color3.fromRGB(83, 73, 43)
	LoopButton.BorderSizePixel = 0
	LoopButton.Font = Enum.Font.GothamMedium
	LoopButton.Text = "Loop"
	LoopButton.TextSize = 8
	LoopButton.TextColor3 = Color3.fromRGB(235, 239, 245)
	LoopButton.Parent = Row

	local LoopCorner = Instance.new("UICorner")
	LoopCorner.CornerRadius = UDim.new(0, 5)
	LoopCorner.Parent = LoopButton

	local StopButton = Instance.new("TextButton")
	StopButton.Position = UDim2.new(1, -121, 0.5, -12)
	StopButton.Size = UDim2.fromOffset(51, 24)
	StopButton.BackgroundColor3 = Color3.fromRGB(112, 61, 61)
	StopButton.BorderSizePixel = 0
	StopButton.Font = Enum.Font.GothamMedium
	StopButton.Text = "Stop"
	StopButton.TextSize = 8
	StopButton.TextColor3 = Color3.fromRGB(235, 239, 245)
	StopButton.Parent = Row

	local StopCorner = Instance.new("UICorner")
	StopCorner.CornerRadius = UDim.new(0, 5)
	StopCorner.Parent = StopButton

	local CopyButton = Instance.new("TextButton")
	CopyButton.Position = UDim2.new(1, -66, 0.5, -12)
	CopyButton.Size = UDim2.fromOffset(61, 24)
	CopyButton.BackgroundColor3 = Color3.fromRGB(42, 75, 108)
	CopyButton.BorderSizePixel = 0
	CopyButton.Font = Enum.Font.GothamMedium
	CopyButton.Text = "Copy"
	CopyButton.TextSize = 8
	CopyButton.TextColor3 = Color3.fromRGB(235, 239, 245)
	CopyButton.Parent = Row

	local CopyCorner = Instance.new("UICorner")
	CopyCorner.CornerRadius = UDim.new(0, 5)
	CopyCorner.Parent = CopyButton

	Select.MouseButton1Click:Connect(function()
		ShowProperties(Sound)
	end)

	PlayButton.MouseButton1Click:Connect(function()
		if Sound and Sound.Parent then
			pcall(function()
				Sound:Play()
			end)
		end
	end)

	LoopButton.MouseButton1Click:Connect(function()
		if Loops[Sound] then
			StopLoop(Sound)
		else
			StartLoop(Sound)
		end
	end)

	StopButton.MouseButton1Click:Connect(function()
		StopLoop(Sound)

		if Sound and Sound.Parent then
			pcall(function()
				Sound:Stop()
			end)
		end
	end)

	CopyButton.MouseButton1Click:Connect(function()
		if Sound and Sound.Parent then
			Copy(GetPath(Sound))
		end
	end)

	Rows[Sound] = Row
	UpdateLoopButton(Sound)
end

local function QueueRefresh()
	if RefreshQueued then
		return
	end

	RefreshQueued = true

	task.defer(function()
		RefreshQueued = false

		if Destroyed then
			return
		end

		local SearchText = Query:lower()
		local Order = 0
		local Alive = {}

		for Key, Sound in pairs(SoundKeys) do
			if not Sound.Parent then
				if Loops[Sound] then
					StopLoop(Sound)
				end

				SoundKeys[Key] = nil
				Sounds[Sound] = nil
			end
		end

		for Key, Sound in pairs(SoundKeys) do
			if Sound.Parent then
				local Match = SearchText == ""

				if not Match then
					local Name = Sound.Name:lower()
					local Id = Sound.SoundId:lower()
					local Path = GetPath(Sound):lower()

					Match = Name:find(SearchText, 1, true)
						or Id:find(SearchText, 1, true)
						or Path:find(SearchText, 1, true)
				end

				if Match then
					Order += 1
					Alive[Sound] = true
					CreateRow(Sound, Order)
				end
			end
		end

		for Sound, Row in pairs(Rows) do
			if not Alive[Sound] then
				Row:Destroy()
				Rows[Sound] = nil
			end
		end

		UpdateCount()
	end)
end

local function Register(Object)
	if not Object:IsA("Sound") then
		return
	end

	if Sounds[Object] then
		return
	end

	local Key = GetSoundKey(Object)

	if SoundKeys[Key] then
		Sounds[Object] = true
		return
	end

	Sounds[Object] = true
	SoundKeys[Key] = Object
end

for _, Object in ipairs(game:GetDescendants()) do
	Register(Object)
end

game.DescendantAdded:Connect(function(Object)
	if Object:IsA("Sound") then
		Register(Object)

		if LoopAllActive then
			task.defer(function()
				if Object.Parent and not Loops[Object] then
					StartLoop(Object)
				end
			end)
		end

		QueueRefresh()
	end
end)

game.DescendantRemoving:Connect(function(Object)
	if Sounds[Object] then
		Sounds[Object] = nil

		local Key = GetSoundKey(Object)

		if SoundKeys[Key] == Object then
			SoundKeys[Key] = nil
		end

		StopLoop(Object)

		if Rows[Object] then
			Rows[Object]:Destroy()
			Rows[Object] = nil
		end

		if Selected == Object then
			HideProperties()
		end

		UpdateCount()
	end
end)

Search:GetPropertyChangedSignal("Text"):Connect(function()
	Query = Search.Text
	QueueRefresh()
end)

VolumeSound.MouseButton1Click:Connect(function()
	local Order = 0
	local Alive = {}

	for Sound in pairs(SoundKeys) do
		if Sound and Sound.Parent then
			local Volume = Sound.Volume

			if Volume > 0 and Volume == math.floor(Volume) then
				Order += 1
				Alive[Sound] = true
				CreateRow(Sound, Order)
			end
		end
	end

	for Sound, Row in pairs(Rows) do
		if not Alive[Sound] then
			Row:Destroy()
			Rows[Sound] = nil
		end
	end

	Search.Text = ""
	Query = ""

	VolumeSound.Visible = false
	BackButton.Visible = true
end)

BackButton.MouseButton1Click:Connect(function()
	BackButton.Visible = false
	VolumeSound.Visible = true
	Search.Text = ""
	Query = ""
	QueueRefresh()
end)

AllButton.MouseButton1Click:Connect(function()
	if PlayingAll then
		PlayingAll = false

		if AllConnection then
			AllConnection:Disconnect()
			AllConnection = nil
		end

		for Sound in pairs(Sounds) do
			if Sound.Parent then
				pcall(function()
					Sound:Stop()
				end)
			end
		end

		AllButton.Text = "PLAY ALL"
		AllButton.BackgroundColor3 = Color3.fromRGB(52, 91, 70)
		return
	end

	if SoundService.RespectFilteringEnabled then
		return
	end

	PlayingAll = true
	AllButton.Text = "STOP ALL"
	AllButton.BackgroundColor3 = Color3.fromRGB(112, 61, 61)

	AllConnection = game.DescendantAdded:Connect(function(Object)
		if PlayingAll and Object:IsA("Sound") then
			pcall(function()
				Object:Play()
			end)
		end
	end)

	task.spawn(function()
		while PlayingAll and not Destroyed do
			for Key, Object in pairs(SoundKeys) do
				if not PlayingAll then
					break
				end

				if Object and Object.Parent then
					pcall(function()
						Object:Play()
					end)
				end

				task.wait()
			end

			task.wait()
		end
	end)
end)

LoopAll.MouseButton1Click:Connect(function()
	if LoopAllActive then
		LoopAllActive = false

		for Sound in pairs(Loops) do
			StopLoop(Sound)
		end

		if LoopAllConnection then
			LoopAllConnection:Disconnect()
			LoopAllConnection = nil
		end

		LoopAll.Text = "LOOPALL"
		LoopAll.BackgroundColor3 = Color3.fromRGB(83, 73, 43)

		return
	end

	LoopAllActive = true
	LoopAll.Text = "LOOPING ALL"
	LoopAll.BackgroundColor3 = Color3.fromRGB(65, 105, 78)

	for _, Sound in pairs(SoundKeys) do
		if Sound and Sound.Parent and not Loops[Sound] then
			StartLoop(Sound)
		end
	end

	LoopAllConnection = game.DescendantAdded:Connect(function(Object)
		if LoopAllActive and Object:IsA("Sound") then
			task.defer(function()
				if Object.Parent and not Loops[Object] then
					StartLoop(Object)
				end
			end)
		end
	end)

	task.spawn(function()
		while LoopAllActive and not Destroyed do
			for _, Sound in pairs(SoundKeys) do
				if not LoopAllActive then
					break
				end

				if Sound and Sound.Parent and not Loops[Sound] then
					StartLoop(Sound)
				end
			end

			task.wait(0.5)
		end
	end)
end)

UnloopAll.MouseButton1Click:Connect(function()
	LoopAllActive = false

	if LoopAllConnection then
		LoopAllConnection:Disconnect()
		LoopAllConnection = nil
	end

	for Sound in pairs(Loops) do
		StopLoop(Sound)
	end

	for Sound in pairs(Sounds) do
		if Sound.Parent then
			pcall(function()
				Sound.Looped = false
				Sound:Stop()
			end)
		end
	end

	LoopAll.Text = "LOOPALL"
	LoopAll.BackgroundColor3 = Color3.fromRGB(83, 73, 43)
end)

RejoinButton.MouseButton1Click:Connect(function()
	pcall(function()
		TeleportService:TeleportToPlaceInstance(
			game.PlaceId,
			game.JobId,
			Player
		)
	end)
end)

RunService.RenderStepped:Connect(function()
	FPSFrames += 1

	local Now = os.clock()

	if Now - LastFPSUpdate >= 1 then
		FPS = FPSFrames
		FPSFrames = 0
		LastFPSUpdate = Now
		FPSLabel.Text = "FPS: " .. tostring(FPS)
	end
end)

local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = true
		DragStart = Input.Position
		StartPosition = Main.Position
	end
end)

UIS.InputChanged:Connect(function(Input)
	if not Dragging then
		return
	end

	if Input.UserInputType == Enum.UserInputType.MouseMovement
		or Input.UserInputType == Enum.UserInputType.Touch then

		local Delta = Input.Position - DragStart

		Main.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = false
	end
end)

Gui.AncestryChanged:Connect(function(_, Parent)
	if not Parent then
		Destroyed = true
		PlayingAll = false
		LoopAllActive = false

		for Sound in pairs(Loops) do
			StopLoop(Sound)
		end

		if AllConnection then
			AllConnection:Disconnect()
			AllConnection = nil
		end

		if LoopAllConnection then
			LoopAllConnection:Disconnect()
			LoopAllConnection = nil
		end
	end
end)

QueueRefresh()
