local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet("https://pastebin.com/raw/sQMvWCcs"))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

Library:Notify("Made by LTUVR | papy#4075", 3)
wait(0.3)
Library:Notify("Game: Trident Survival V2", 3)
wait(0.3)
Library:Notify("farts.pl", 3)

local Window = Library:CreateWindow({

    Title = 'farts.pl | Trident Survival V2',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.3
})

local Tabs = {
    -- Creates a new tab titled Main
    Legit = Window:AddTab('Legit'),
    Rage = Window:AddTab('Rage'),
    Misc = Window:AddTab('Misc'),
    Visual = Window:AddTab('Visuals'),
    AA = Window:AddTab('A-A'),
    Settings = Window:AddTab('Settings'),
    ['UI Settings'] = Window:AddTab('UI Settings')
}




local LeftGroupBox = Tabs.Rage:AddLeftGroupbox('Player')



local longneck = {
    LongNeckEnabled = false,
    UpperLimitDefault = 3,
    LowerLimitDefault = 1.75,
    CurrentSliderValue = 1.75,
}
    
LeftGroupBox:AddToggle('LongNeck', {Text = 'long neck', Default = false, Tooltip}):AddKeyPicker('LongNeckKey', {Default = 'Non', SyncToggleState = true, Mode = 'Toggle', Text = 'Long Neck', NoUI = false}):OnChanged(function(value)
    longneck.LongNeckEnabled = value
    if not longneck.LongNeckEnabled then
    game:GetService("Workspace").Ignore.LocalCharacter.Bottom.PrismaticConstraint.UpperLimit = longneck.UpperLimitDefault
    game:GetService("Workspace").Ignore.LocalCharacter.Bottom.PrismaticConstraint.LowerLimit = longneck.LowerLimitDefault
    else
    game:GetService("Workspace").Ignore.LocalCharacter.Bottom.PrismaticConstraint.UpperLimit = longneck.CurrentSliderValue
    game:GetService("Workspace").Ignore.LocalCharacter.Bottom.PrismaticConstraint.LowerLimit = longneck.CurrentSliderValue
    end
end)
    
LeftGroupBox:AddSlider('HeightChangerSlider', {Text = 'height:', Suffix = "m", Default = 4, Min = 0, Max = 6.5; Rounding = 1, Compact = false}):OnChanged(function(Value)
    longneck.CurrentSliderValue = Value
    if longneck.LongNeckEnabled then
    game:GetService("Workspace").Ignore.LocalCharacter.Bottom.PrismaticConstraint.LowerLimit = Value
    game:GetService("Workspace").Ignore.LocalCharacter.Bottom.PrismaticConstraint.UpperLimit = Value
    end
end)


LeftGroupBox:AddToggle('MyddfTodggle', {
    Text = 'Fast Crouch',
    Default = false,
    Tooltip = 'Toggles on and off Fast Crouch',

    Callback = function(Value)

local QuickCrouch = Value
if QuickCrouch == true then
game:GetService("Workspace").Ignore.LocalCharacter.Top.CrouchForce.Stiffness = 10000
else
game:GetService("Workspace").Ignore.LocalCharacter.Top.CrouchForce.Stiffness = 100
end

    end
})


local function onFakeLagToggled(value)
    local networkClient = game:GetService("NetworkClient")
    networkClient:SetOutgoingKBPSLimit(value and 1 or 100)
end

LeftGroupBox:AddToggle('FakeLag', {Text = 'fake lag', Default = false}):OnChanged(onFakeLagToggled)






local LeftGroupBox = Tabs.Legit:AddLeftGroupbox('HitBoxes')






local slider11Value = 1 -- Default value for the slider

local function findModelsWithHeadAndArmor()
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local head = model:FindFirstChild("Head")
            local armorFolder = model:FindFirstChild("Armor")
            if head and armorFolder then
                -- Change head size and transparency based on the slider value
                head.Size = Vector3.new(slider11Value, slider11Value, slider11Value)
                head.Transparency = 0.5
                head.CanCollide = false
                head.CanTouch = false
            end
        end
    end
end

-- Function to update head size and transparency
local function updateHeadProperties()
    findModelsWithHeadAndArmor()
end

-- Slider
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Head Hitbox expander',
    Default = 1,
    Min = 1,
    Max = 7,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        slider11Value = Value -- Update the slider value
        updateHeadProperties() -- Update head properties when the slider value changes
    end
})

-- Function to periodically call the updateHeadProperties function every 500 ms
local RunService = game:GetService("RunService")
local interval = 0.5 -- 500 ms

local connection

connection = RunService.Heartbeat:Connect(function()
    updateHeadProperties()
end)


local LeftGroupBox = Tabs.Misc:AddLeftGroupbox('World')



local lighting = game:GetService("Lighting")

local targetBrightness = 1 -- Default brightness value
local brightnessChangeSpeed = 100 -- Adjust this value to control the speed of brightness change

local function changeBrightness()
    local currentBrightness = lighting.Brightness
    local brightnessDelta = targetBrightness - currentBrightness
    local brightnessChange = math.clamp(brightnessDelta, -brightnessChangeSpeed, brightnessChangeSpeed)
    lighting.Brightness = currentBrightness + brightnessChange
end

game:GetService("RunService").RenderStepped:Connect(changeBrightness)

LeftGroupBox:AddSlider('Brightness', {
    Text = 'Brightness',
    Default = 1,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        targetBrightness = Value
    end
})





local lighting = game:GetService("Lighting")

local target1Brightness = 14 -- Default brightness value
local brightnessChangeSpeed = 100 -- Adjust this value to control the speed of brightness change

local function changeBrightness()
    local currentBrightness = lighting.Brightness
    local brightnessDelta = target1Brightness - currentBrightness
    local brightnessChange = math.clamp(brightnessDelta, -brightnessChangeSpeed, brightnessChangeSpeed)
    lighting.TimeOfDay = currentBrightness + brightnessChange
end

game:GetService("RunService").RenderStepped:Connect(changeBrightness)

LeftGroupBox:AddSlider('Brightness', {
    Text = 'TimeOfDay',
    Default = 14,
    Min = 1,
    Max = 24,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        target1Brightness = Value
    end
})


LeftGroupBox:AddToggle('MyTgrassoggle', {
    Text = 'Grass Toggle',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles on and off grass details', -- Information shown when you hover over the toggle

    Callback = function(Value)
        
        local showDecorations = Value -- set this to true if you want to see decorations again
        sethiddenproperty(game:GetService("Workspace").Terrain, "Decoration", showDecorations)

    end
})


local lighting = game:GetService("Lighting")



LeftGroupBox:AddToggle('GlobalysShadowys', {
    Text = 'GlobalShadow Toggle',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles on and off Global Shadows from Litghting', -- Information shown when you hover over the toggle

    Callback = function(Value)
        
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = Value

    end
})


LeftGroupBox:AddDivider()

local sounds = {
    ["Defualt"] = "rbxassetid://9114487369",
    Neverlose = "rbxassetid://8726881116",
    Gamesense = "rbxassetid://4817809188",
    Bell = "rbxassetid://6534947240",
    Rust = "rbxassetid://1255040462",
    TF2 = "rbxassetid://2868331684",
    Minecraft = "rbxassetid://4018616850",
    Osu = "rbxassetid://7149255551",
    Bat = "rbxassetid://3333907347",
    ["Call of Duty"] = "rbxassetid://5952120301",
    Bubble = "rbxassetid://6534947588",
    Pick = "rbxassetid://1347140027",
    Pop = "rbxassetid://198598793",
    Bruh = "rbxassetid://4275842574",
    Bamboo = "rbxassetid://3769434519",
    Crowbar = "rbxassetid://546410481",
    Beep = "rbxassetid://8177256015",
    ["Old Fatality"] = "rbxassetid://6607142036",
    Click = "rbxassetid://8053704437",
    Laser = "rbxassetid://7837461331"
}
  
local SoundService = game:GetService("SoundService")

SoundService.PlayerHitHeadshot.Volume = 5
SoundService.PlayerHitHeadshot.Pitch = 1
SoundService.PlayerHitHeadshot.EqualizerSoundEffect.HighGain = -2

-- GAME 

LeftGroupBox:AddDropdown('soundHit', {
Values = { 'Defualt','Neverlose','Gamesense','Bell','Rust','TF2','Minecraft','Osu','Bat','Call of Duty','Bubble','Pick','Pop','Bruh','Bamboo','Crowbar','Beep','Old Fatality','Click','Laser' },
Default = 1,
Multi = false,
Text = 'Hitsound'})
Options.soundHit:OnChanged(function()
local soundId = sounds[Options.soundHit.Value]
game:GetService("SoundService").PlayerHitHeadshot.SoundId = soundId
game:GetService("SoundService").PlayerHit.SoundId = soundId
game:GetService("SoundService").PlayerHit2.SoundId = soundId
end)

LeftGroupBox:AddDivider()


-- Assuming you have a GUI toggle named "BaseXray" and a keypicker
local toggle = LeftGroupBox:AddToggle('BaseXray', { Text = 'Base Xray', Default = false, Tooltip })
toggle:AddKeyPicker('BaseXraykey', { Default = 'Non', SyncToggleState = true, Mode = 'Toggle', Text = 'Base Xray', NoUI = false })

-- Function to update Hitbox transparency based on the toggle value
local function updateHitboxTransparency(value)
    local workspace = game:GetService("Workspace")

    if value then
        -- When the toggle is enabled, search for models with a single "Hitbox" part
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("Hitbox") then
                local hitbox = model:FindFirstChild("Hitbox")
                if hitbox:IsA("BasePart") then
                    hitbox.Transparency = 0.7
                end
            end
        end
    else
        -- When the toggle is disabled, reset transparency for all "Hitbox" parts
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("Hitbox") then
                local hitbox = model:FindFirstChild("Hitbox")
                if hitbox:IsA("BasePart") then
                    hitbox.Transparency = 0
                end
            end
        end
    end
end

toggle:OnChanged(function(value)
    updateHitboxTransparency(value)
end)





local RightGroupBox = Tabs.Misc:AddRightGroupbox('Crosshair')

local CrossHairX = Drawing.new("Circle")

local toggle = RightGroupBox:AddToggle('Circlecrosshair', { Text = 'Circle crosshair', Default = false, Tooltip })
toggle:OnChanged(function(value)
    CrossHairX.Visible = value -- Update the visibility of the crosshair based on the toggle value
end)

local toggle = RightGroupBox:AddToggle('Circlecrosshairfill', { Text = 'Circle Fill', Default = false, Tooltip })
toggle:OnChanged(function(value)
    CrossHairX.Filled = value -- Update the visibility of the crosshair based on the toggle value
end)

RightGroupBox:AddLabel('Circle Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Circle Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
		CrossHairX.Color = Color3.fromRGB(Value.R * 255, Value.G * 255, Value.B * 255)
    end
})

RightGroupBox:AddSlider('Radiuscroshar', {
    Text = 'Circle Radius',
    Default = 5,
    Min = 1,
    Max = 100,
    Rounding = 2,
    Compact = false,

    Callback = function(Value)
        CrossHairX.Radius = Value
    end
})


local Camera = game:GetService("Workspace").CurrentCamera

CrossHairX.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
CrossHairX.ZIndex = 3




local RightGroupBox = Tabs.Visual:AddLeftGroupbox('Ores')


local labelCache = {}
local isToggleOn = false
local updateTime = 0.1 -- 100 milliseconds
local lastUpdateTime = 0
local heartbeatConnection

local function findModelsWithColor()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local parts = model:GetChildren()
            if #parts == 1 then -- Check if there's only one child (one part)
                local part = parts[1]
                if part:IsA("BasePart") and part.Color == Color3.new(105/255, 102/255, 92/255) and not labelCache[model] then
                    table.insert(models, model)
                    labelCache[model] = nil -- Remove any existing BillboardGui
                end
            end
        end
    end
    return models
end

local function createLabelForModel(model)
    local label = Instance.new("BillboardGui")
    label.Parent = model
    label.Size = UDim2.new(0, 100, 0, 50)
    label.StudsOffset = Vector3.new(0, 2, 0)
    
    -- Set AlwaysOnTop to true to make labels visible through walls
    label.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = label
    nameLabel.Text = "Stone"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.SourceSansSemibold
    nameLabel.TextSize = 10

    labelCache[model] = label
end

local function updateLabels()
    if not isToggleOn then return end

    local models = findModelsWithColor()
    for _, model in pairs(models) do
        local label = labelCache[model]
        if label then
            label.Enabled = true
        else
            createLabelForModel(model)
        end
    end
end

local function toggleLabels()
    if isToggleOn then
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - lastUpdateTime >= updateTime then
                updateLabels()
                lastUpdateTime = currentTime
            end
        end)
        updateLabels()
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        for model, label in pairs(labelCache) do
            label:Destroy()
            labelCache[model] = nil
        end
    end
end

RightGroupBox:AddToggle('MyToggle', {
    Text = 'Stone',
    Default = false,
    Tooltip = 'Shows Stone Name',

    Callback = function(Value)
        isToggleOn = Value
        toggleLabels()
    end
})



local labelCache = {}
local isToggleOn = false
local updateTime = 0.1 -- 100 milliseconds
local lastUpdateTime = 0
local heartbeatConnection

local function findModelsWithColorAndNoHead()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local hasMatchingPart = false
            for _, part in pairs(model:GetChildren()) do
                if part:IsA("BasePart") and part.Color == Color3.new(199/255, 172/255, 120/255) then
                    hasMatchingPart = true
                    break -- No need to check further once we find a matching part
                end
            end
            if hasMatchingPart and not model:FindFirstChild("Head") and not labelCache[model] then
                table.insert(models, model)
                labelCache[model] = nil -- Remove any existing BillboardGui
            end
        end
    end
    return models
end

local function createLabelForModel(model)
    local label = Instance.new("BillboardGui")
    label.Parent = model
    label.Size = UDim2.new(0, 100, 0, 50)
    label.StudsOffset = Vector3.new(0, 2, 0)
    
    -- Set AlwaysOnTop to true to make labels visible through walls
    label.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = label
    nameLabel.Text = "Metal"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.SourceSansSemibold
    nameLabel.TextSize = 10

    labelCache[model] = label
end

local function updateLabels()
    if not isToggleOn then return end

    local models = findModelsWithColorAndNoHead()
    for _, model in pairs(models) do
        local label = labelCache[model]
        if label then
            label.Enabled = true
        else
            createLabelForModel(model)
        end
    end
end

local function toggleLabels()
    if isToggleOn then
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - lastUpdateTime >= updateTime then
                updateLabels()
                lastUpdateTime = currentTime
            end
        end)
        updateLabels()
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        for model, label in pairs(labelCache) do
            label:Destroy()
            labelCache[model] = nil
        end
    end
end

RightGroupBox:AddToggle('MyddfToggle', {
    Text = 'Metal',
    Default = false,
    Tooltip = 'Metal Ore Esp',

    Callback = function(Value)
        isToggleOn = Value
        toggleLabels()
    end
})







local labelCache = {}
local isToggleOn = false
local updateTime = 0.1 -- 100 milliseconds
local lastUpdateTime = 0
local heartbeatConnection

local function findModelsWithColorAndNoHead()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local hasMatchingPart = false
            for _, part in pairs(model:GetChildren()) do
                if part:IsA("BasePart") and part.Color == Color3.new(248/255, 248/255, 248/255) then
                    hasMatchingPart = true
                    break -- No need to check further once we find a matching part
                end
            end
            if hasMatchingPart and not model:FindFirstChild("Hitbox") and not labelCache[model] then
            if hasMatchingPart and not model:FindFirstChild("RightWall") and not labelCache[model] then
            if hasMatchingPart and not model:FindFirstChild("LeftWall") and not labelCache[model] then
            if hasMatchingPart and not model:FindFirstChild("Enclosure") and not labelCache[model] then
            if hasMatchingPart and not model:FindFirstChild("Meshes/triangle") and not labelCache[model] then
                table.insert(models, model)
                labelCache[model] = nil -- Remove any existing BillboardGui
            end
            end
            end
            end
            end
        end
    end
    return models
end

local function createLabelForModel(model)
    local label = Instance.new("BillboardGui")
    label.Parent = model
    label.Size = UDim2.new(0, 100, 0, 50)
    label.StudsOffset = Vector3.new(0, 2, 0)
    
    -- Set AlwaysOnTop to true to make labels visible through walls
    label.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = label
    nameLabel.Text = "Nitrate"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.SourceSansSemibold
    nameLabel.TextSize = 10

    labelCache[model] = label
end

local function updateLabels()
    if not isToggleOn then return end

    local models = findModelsWithColorAndNoHead()
    for _, model in pairs(models) do
        local label = labelCache[model]
        if label then
            label.Enabled = true
        else
            createLabelForModel(model)
        end
    end
end

local function toggleLabels()
    if isToggleOn then
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - lastUpdateTime >= updateTime then
                updateLabels()
                lastUpdateTime = currentTime
            end
        end)
        updateLabels()
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        for model, label in pairs(labelCache) do
            label:Destroy()
            labelCache[model] = nil
        end
    end
end

RightGroupBox:AddToggle('MyddfTodggle', {
    Text = 'Nitrate',
    Default = false,
    Tooltip = 'Nitrate Ore Esp',

    Callback = function(Value)
        isToggleOn = Value
        toggleLabels()
    end
})



local RightGroupBox = Tabs.Visual:AddRightGroupbox('Crates')


local labelCache = {}
local isToggleOn = false
local updateTime = 0.1 -- 100 milliseconds
local lastUpdateTime = 0
local heartbeatConnection

local function findModelsWithColorAndNoHead()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local hasMatchingPart = false
            for _, part in pairs(model:GetChildren()) do
                if part:IsA("BasePart") and part.Color == Color3.new(211/255, 190/255, 150/255) then
                    hasMatchingPart = true
                    break -- No need to check further once we find a matching part
                end
            end
            if hasMatchingPart and not model:FindFirstChild("hammer") and not labelCache[model] then
            if hasMatchingPart and not model:FindFirstChild("tarp") and not labelCache[model] then
            if hasMatchingPart and not model:FindFirstChild("Placement") and not labelCache[model] then
            if hasMatchingPart and not model:FindFirstChild("Wedge") and not labelCache[model] then
                table.insert(models, model)
                labelCache[model] = nil -- Remove any existing BillboardGui
            end
        end
            end
            end
        end
    end
    return models
end

local function createLabelForModel(model)
    local label = Instance.new("BillboardGui")
    label.Parent = model
    label.Size = UDim2.new(0, 100, 0, 50)
    label.StudsOffset = Vector3.new(0, 2, 0)
    
    -- Set AlwaysOnTop to true to make labels visible through walls
    label.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = label
    nameLabel.Text = "CardBoard Crate"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.SourceSansSemibold
    nameLabel.TextSize = 10

    labelCache[model] = label
end

local function updateLabels()
    if not isToggleOn then return end

    local models = findModelsWithColorAndNoHead()
    for _, model in pairs(models) do
        local label = labelCache[model]
        if label then
            label.Enabled = true
        else
            createLabelForModel(model)
        end
    end
end

local function toggleLabels()
    if isToggleOn then
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - lastUpdateTime >= updateTime then
                updateLabels()
                lastUpdateTime = currentTime
            end
        end)
        updateLabels()
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        for model, label in pairs(labelCache) do
            label:Destroy()
            labelCache[model] = nil
        end
    end
end

RightGroupBox:AddToggle('MyddfTodggle', {
    Text = 'CardBoard',
    Default = false,
    Tooltip = 'CardBoard crate Esp',

    Callback = function(Value)
        isToggleOn = Value
        toggleLabels()
    end
})







local labelCache = {}
local isToggleOn = false
local updateTime = 0.1 -- 100 milliseconds
local lastUpdateTime = 0
local heartbeatConnection

local function findModelsWithColorAndNoHead()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local hasMatchingPart = false
            for _, part in pairs(model:GetChildren()) do
                if part:IsA("BasePart") and part.Color == Color3.new(134/255, 133/255, 136/255) then
                    hasMatchingPart = true
                    break -- No need to check further once we find a matching part
                end
            end
            if hasMatchingPart and not model:FindFirstChild("hammer") and not labelCache[model] then
            if hasMatchingPart and not model:FindFirstChild("tarp") and not labelCache[model] then
                table.insert(models, model)
                labelCache[model] = nil -- Remove any existing BillboardGui
            end
            end
        end
    end
    return models
end

local function createLabelForModel(model)
    local label = Instance.new("BillboardGui")
    label.Parent = model
    label.Size = UDim2.new(0, 100, 0, 50)
    label.StudsOffset = Vector3.new(0, 2, 0)
    
    -- Set AlwaysOnTop to true to make labels visible through walls
    label.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = label
    nameLabel.Text = "Transport Crate"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.SourceSansSemibold
    nameLabel.TextSize = 10

    labelCache[model] = label
end

local function updateLabels()
    if not isToggleOn then return end

    local models = findModelsWithColorAndNoHead()
    for _, model in pairs(models) do
        local label = labelCache[model]
        if label then
            label.Enabled = true
        else
            createLabelForModel(model)
        end
    end
end

local function toggleLabels()
    if isToggleOn then
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - lastUpdateTime >= updateTime then
                updateLabels()
                lastUpdateTime = currentTime
            end
        end)
        updateLabels()
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        for model, label in pairs(labelCache) do
            label:Destroy()
            labelCache[model] = nil
        end
    end
end

RightGroupBox:AddToggle('MyddfTodggle', {
    Text = 'Transport',
    Default = false,
    Tooltip = 'Transport Crate Esp',

    Callback = function(Value)
        isToggleOn = Value
        toggleLabels()
    end
})









local labelCache = {}
local isToggleOn = false
local updateTime = 0.1 -- 100 milliseconds
local lastUpdateTime = 0
local heartbeatConnection

local function findModelsWithColorAndNoHead()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local hasMatchingPart = false
            for _, part in pairs(model:GetChildren()) do
                if part:IsA("BasePart") and part.Color == Color3.new(148/255, 142/255, 147/255) then
                    hasMatchingPart = true
                    break -- No need to check further once we find a matching part
                end
            end
            if hasMatchingPart and not model:FindFirstChild("Hitbox") and not labelCache[model] then
                table.insert(models, model)
                labelCache[model] = nil -- Remove any existing BillboardGui
            end
        end
    end
    return models
end

local function createLabelForModel(model)
    local label = Instance.new("BillboardGui")
    label.Parent = model
    label.Size = UDim2.new(0, 100, 0, 50)
    label.StudsOffset = Vector3.new(0, 2, 0)
    
    -- Set AlwaysOnTop to true to make labels visible through walls
    label.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = label
    nameLabel.Text = "Vault Crate"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.SourceSansSemibold
    nameLabel.TextSize = 10

    labelCache[model] = label
end

local function updateLabels()
    if not isToggleOn then return end

    local models = findModelsWithColorAndNoHead()
    for _, model in pairs(models) do
        local label = labelCache[model]
        if label then
            label.Enabled = true
        else
            createLabelForModel(model)
        end
    end
end

local function toggleLabels()
    if isToggleOn then
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - lastUpdateTime >= updateTime then
                updateLabels()
                lastUpdateTime = currentTime
            end
        end)
        updateLabels()
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        for model, label in pairs(labelCache) do
            label:Destroy()
            labelCache[model] = nil
        end
    end
end

RightGroupBox:AddToggle('MyddfTodggle', {
    Text = 'Vault Crate',
    Default = false,
    Tooltip = 'Vault Crate Esp',

    Callback = function(Value)
        isToggleOn = Value
        toggleLabels()
    end
})




local labelCache = {}
local isToggleOn = false
local updateTime = 0.1 -- 100 milliseconds
local lastUpdateTime = 0
local heartbeatConnection

local function findModelsWithColorAndNoHead()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local hasMatchingPart = false
            for _, part in pairs(model:GetChildren()) do
                if part:IsA("BasePart") and part.Color == Color3.new(124/255, 156/255, 107/255) then
                    hasMatchingPart = true
                    break -- No need to check further once we find a matching part
                end
            end
            if hasMatchingPart and not model:FindFirstChild("Hitbox") and not labelCache[model] then
                table.insert(models, model)
                labelCache[model] = nil -- Remove any existing BillboardGui
            end
        end
    end
    return models
end

local function createLabelForModel(model)
    local label = Instance.new("BillboardGui")
    label.Parent = model
    label.Size = UDim2.new(0, 100, 0, 50)
    label.StudsOffset = Vector3.new(0, 2, 0)
    
    -- Set AlwaysOnTop to true to make labels visible through walls
    label.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = label
    nameLabel.Text = "Military Crate"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.SourceSansSemibold
    nameLabel.TextSize = 10

    labelCache[model] = label
end

local function updateLabels()
    if not isToggleOn then return end

    local models = findModelsWithColorAndNoHead()
    for _, model in pairs(models) do
        local label = labelCache[model]
        if label then
            label.Enabled = true
        else
            createLabelForModel(model)
        end
    end
end

local function toggleLabels()
    if isToggleOn then
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - lastUpdateTime >= updateTime then
                updateLabels()
                lastUpdateTime = currentTime
            end
        end)
        updateLabels()
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        for model, label in pairs(labelCache) do
            label:Destroy()
            labelCache[model] = nil
        end
    end
end

RightGroupBox:AddToggle('MyddfTodggle', {
    Text = 'Military Crate',
    Default = false,
    Tooltip = 'Military Crate Esp',

    Callback = function(Value)
        isToggleOn = Value
        toggleLabels()
    end
})



local LeftGroupBox = Tabs.Visual:AddLeftGroupbox('Players')




local labelCache = {} -- Store the labels
local isToggleOn = false
local updateTime = 0.1 -- 100 milliseconds
local lastUpdateTime = 0
local heartbeatConnection

local function findModelsWithHeadAndArmor()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local head = model:FindFirstChild("Head")
            local armorFolder = model:FindFirstChild("Armor")
            local eye = model:FindFirstChild("Eye")
            if head and armorFolder and not eye and not labelCache[model] then
                table.insert(models, model)
                labelCache[model] = nil -- Remove any existing label from the cache
            end
        end
    end
    return models
end

-- Function to draw labels for a specific model
local function drawLabelsForModel(model)
    local head = model:FindFirstChild("Head")
    if not head then return end

    local nameLabel = labelCache[model]
    if not nameLabel then
        nameLabel = Drawing.new("Text")
        nameLabel.Text = "Enemy"
        nameLabel.Size = 13
        nameLabel.Color = Color3.new(1, 1, 1)
        nameLabel.Center = true
        nameLabel.Outline = true
        nameLabel.OutlineColor = Color3.new(0, 0, 0)

        labelCache[model] = nameLabel
    end

    local function updateLabelPosition()
        if head and nameLabel then
            local headPosition = head.Position
            local screenPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(headPosition)
            if onScreen then
                nameLabel.Position = Vector2.new(screenPosition.x, screenPosition.y)
                nameLabel.Visible = true
            else
                nameLabel.Visible = false
            end
        end
    end

    updateLabelPosition()

    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        if not model.Parent then
            nameLabel:Remove()
            connection:Disconnect()
            labelCache[model] = nil
        else
            updateLabelPosition()
        end
    end)
end

-- Function to remove labels for a specific model
local function removeLabelsForModel(model)
    local nameLabel = labelCache[model]
    if nameLabel then
        nameLabel:Remove()
        labelCache[model] = nil
    end
end

-- Function to update label positions for visible models
local function updateLabelPositions()
    for model, _ in pairs(labelCache) do
        if model.Parent then
            updateLabelPosition(model)
        else
            removeLabelsForModel(model)
        end
    end
end

-- Function to check and update labels for visible models
local function checkAndUpdateLabels()
    if not isToggleOn then return end

    local models = findModelsWithHeadAndArmor()
    for _, model in pairs(models) do
        if not labelCache[model] then
            drawLabelsForModel(model)
        else
            updateLabelPosition(model)
        end
    end
end

-- Function to add or remove labels based on the toggle state
local function toggleLabels()
    if isToggleOn then
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - lastUpdateTime >= updateTime then
                checkAndUpdateLabels()
                lastUpdateTime = currentTime
            end
        end)
        checkAndUpdateLabels()
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        -- Remove all labels when Value is false
        for model, _ in pairs(labelCache) do
            removeLabelsForModel(model)
        end
    end
end

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Name Esp',
    Default = false,
    Tooltip = 'Enable or disable name ESP',

    Callback = function(Value)
        isToggleOn = Value
        toggleLabels()
    end
})










local guiCache = {}
local Highlight = Instance.new("Highlight")
local isEspEnabled = false

local function findModelsWithHeadAndArmor()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local head = model:FindFirstChild("Head")
            local armorFolder = model:FindFirstChild("Armor")
            local eye = model:FindFirstChild("Eye")
            if head and armorFolder and not eye and not guiCache[model] then
                table.insert(models, model)
                guiCache[model] = {}
                local highlight = Highlight:Clone()
                highlight.Parent = model
            end
        end
    end
    return models
end

local function removeHighlightsForModel(model)
    for _, highlight in pairs(model:GetChildren()) do
        if highlight:IsA("Highlight") then
            highlight:Destroy()
        end
    end
    guiCache[model] = nil
end

local function removeHighlights()
    for model, _ in pairs(guiCache) do
        removeHighlightsForModel(model)
    end
end

local function enableEsp()
    if isEspEnabled then
        findModelsWithHeadAndArmor()
    end
end

local function disableEsp()
    if not isEspEnabled then
        removeHighlights()
    end
end

-- Toggle button
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Cham Esp',
    Default = false,
    Tooltip = 'Enable or disable cham ESP',

    Callback = function(Value)
        isEspEnabled = Value
        if isEspEnabled then
            enableEsp()
        else
            disableEsp()
        end
    end
})

-- Function to check and enable ESP
local function checkAndEnableEsp()
    if isEspEnabled then
        enableEsp()
    end
end

-- Run the checkAndEnableEsp function every 0.1 seconds (100ms)
local RunService = game:GetService("RunService")
local interval = 0.1 -- 0.1 seconds (100ms)
local connection

connection = RunService.Heartbeat:Connect(function()
    checkAndEnableEsp()
end)






-- variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local cache = {}
local labelCache = {}

-- constants
local BOX_OUTLINE_COLOR = Color3.new(0, 0, 0)
local BOX_COLOR = Color3.new(1, 1, 1)
local CHAR_SIZE = Vector2.new(4, 7)

-- utils
local function create(class, properties)
    local drawing = Drawing.new(class)
    for property, value in pairs(properties) do
        drawing[property] = value
    end
    return drawing
end

local function floor2(v)
    return Vector2.new(math.floor(v.X), math.floor(v.Y))
end

-- functions
local function findModelsWithCorners()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local RightLowerLeg = model:FindFirstChild("RightLowerLeg")
            local LeftLowerLeg = model:FindFirstChild("LeftLowerLeg")
            local LeftUpperArm = model:FindFirstChild("LeftUpperArm")
            local RightUpperArm = model:FindFirstChild("RightUpperArm")
            local eye = model:FindFirstChild("Eye")
            if RightLowerLeg and LeftLowerLeg and LeftUpperArm and RightUpperArm and not eye and not labelCache[model] then
                table.insert(models, model)
                labelCache[model] = nil -- Remove any existing label from the cache
            end
        end
    end
    return models
end

local function createEsp(model)
    local esp = {}

    esp.boxOutline = create("Square", {
        Color = BOX_OUTLINE_COLOR,
        Thickness = 3,
        Filled = false
    })

    esp.box = create("Square", {
        Color = BOX_COLOR,
        Thickness = 1,
        Filled = false
    })

    cache[model] = esp
end

local function removeEsp(model)
    local esp = cache[model]
    if not esp then return end

    for _, drawing in pairs(esp) do
        drawing:Remove()
    end

    cache[model] = nil
end

-- Create a variable to store the ESP toggle state
local isBoxEspEnabled = false

-- Toggle button
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'BoxEsp',
    Default = false,
    Tooltip = 'Enable or disable Box ESP',

    Callback = function(Value)
        isBoxEspEnabled = Value
    end
})

-- Modify the updateEsp function to use the toggle state
local function updateEsp()
    if not isBoxEspEnabled then
        -- If the toggle is off, remove all existing ESP
        for model, _ in pairs(cache) do
            removeEsp(model)
        end
        return
    end

    local models = findModelsWithCorners()

    for model, esp in pairs(cache) do
        local rightLowerLeg = model:FindFirstChild("RightLowerLeg")
        local leftLowerLeg = model:FindFirstChild("LeftLowerLeg")
        local leftUpperArm = model:FindFirstChild("LeftUpperArm")
        local rightUpperArm = model:FindFirstChild("RightUpperArm")

        if not rightLowerLeg or not leftLowerLeg or not leftUpperArm or not rightUpperArm then
            -- Parts are missing, remove ESP
            removeEsp(model)
        end

        local position = model:GetModelCFrame().Position
        local screen, onScreen = camera:WorldToViewportPoint(position)

        if onScreen then
            local frustumHeight = math.tan(math.rad(camera.FieldOfView * 0.5)) * 2 * screen.Z
            local size = camera.ViewportSize.Y / frustumHeight * CHAR_SIZE

            esp.boxOutline.Size = floor2(size)
            esp.boxOutline.Position = floor2(Vector2.new(screen.X, screen.Y) - size * 0.5)

            esp.box.Size = esp.boxOutline.Size
            esp.box.Position = esp.boxOutline.Position

            for _, drawing in pairs(esp) do
                drawing.Visible = true
            end
        else
            removeEsp(model)
        end
    end

    -- Check for new models to add ESP
    for _, model in pairs(models) do
        if not cache[model] then
            createEsp(model)
        end
    end
end

-- connections
Players.PlayerAdded:Connect(function(player)
    createEsp(player)
end)

Players.PlayerRemoving:Connect(function(player)
    removeEsp(player)
end)

RunService.RenderStepped:Connect(updateEsp)

-- Initialize cache for existing models with an "Armor" folder
for _, model in pairs(workspace:GetChildren()) do
    if model:IsA("Model") and model:FindFirstChild("Armor", true) then
        createEsp(model)
    end
end





local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local tracerLines = {}
local isTracersEnabled = false

local function Vector2Find(P)
    local camera = workspace.CurrentCamera
    local worldPoint = P:GetPrimaryPartCFrame().p
    local vector, inViewport = camera:WorldToViewportPoint(worldPoint)
    if inViewport then
        return Vector2.new(vector.X, vector.Y)
    end
    return nil
end

local function findModelsWithHeadAndArmor()
    local models = {}
    for _, model in pairs(workspace:GetChildren()) do
        if model.Name == "Model" then
            local head = model:FindFirstChild("Head")
            local armorFolder = model:FindFirstChild("Armor")
            local eye = model:FindFirstChild("Eye")
            if head and armorFolder and not eye then
                table.insert(models, model)
            end
        end
    end
    return models
end

local function createOrUpdateTracer(model)
    if not tracerLines[model] then
        tracerLines[model] = Drawing.new("Line")
        tracerLines[model].Visible = false
        tracerLines[model].Color = Color3.fromRGB(255, 255, 255)
        tracerLines[model].Thickness = 1
        tracerLines[model].Transparency = 0.8
    end

    local line = tracerLines[model]
    local linePosition = Vector2Find(model)
    local screenSize = game:GetService("Workspace").CurrentCamera.ViewportSize
    local middleX = screenSize.X / 2
    if linePosition then
        line.To = linePosition
        line.From = Vector2.new(middleX, 0)
        line.Visible = true
    else
        line.Visible = false
    end
end

local function updateTracers()
    if isTracersEnabled then
        local models = findModelsWithHeadAndArmor()
        for model, line in pairs(tracerLines) do
            if not table.find(models, model) then
                line:Remove()
                tracerLines[model] = nil
            end
        end

        for _, model in pairs(models) do
            createOrUpdateTracer(model)
        end
    else
        for _, line in pairs(tracerLines) do
            line:Remove()
        end
        tracerLines = {}
    end
end

local tracerToggle = LeftGroupBox:AddToggle('MydfghdtyuToggle', {
    Text = 'Tracers',
    Default = false,
    Tooltip = 'Enable or disable Tracers',

    Callback = function(Value)
        isTracersEnabled = Value
    end
})

-- Continuously update tracers' positions during heartbeat
RunService.Heartbeat:Connect(updateTracers)

-- Initialize tracers when the script starts
updateTracers()





















-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Example of dynamically-updating watermark with common traits (fps and ping)
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    local playerCount = #game.Players:GetPlayers()
    
    Library:SetWatermark(('farts.pl | %s fps | %s ms | %d players'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()),
        playerCount
    ));
end);

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()







wait(4)

Library:Notify("Discord: discord.com/xrYpU6nQ7X", 10)
wait(0.3)
Library:Notify("farts.pl😮‍💨", 5)
wait(0.3)
Library:Notify("Enjoy🤗", 5)
