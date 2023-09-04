-- New example script written by wally
-- You can suggest changes with a pull request or something

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()

local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)

    Title = 'Pheonix demo V0.1',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})


-- CALLBACK NOTE:
-- Passing in callback functions via the initial element parameters (i.e. Callback = function(Value)...) works
-- HOWEVER, using Toggles/Options.INDEX:OnChanged(function(Value) ... ) is the RECOMMENDED way to do this.
-- I strongly recommend decoupling UI code from logic code. i.e. Create your UI elements FIRST, and THEN setup :OnChanged functions later.

-- You do not have to set your tabs & groups up this way, just a prefrence.
local Tabs = {
    -- Creates a new tab titled Main
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
    TPS = Window:AddTab('TP')
}

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Aim')

-- LeftGroupBox:AddSlider('FOV Changer', {
--     Text = 'FOV Changer',
--     Default = 80,
--     Min = 10,
--     Max = 260,
--     Rounding = 1,
--     Compact = false,
-- 
--     Callback = function(value)
--         Aimbot_FOV_Radius = value
--     end
-- })

local settings = {
    Aimbot = true,
    Aiming = false,
    Aimbot_AimPart = "Head",
    Aimbot_TeamCheck = false,
    Aimbot_Draw_FOV = true,
    Aimbot_FOV_Color = Color3.fromRGB(255, 255, 255),
    Aimbot_FOV_Radius = 80,
    Smoothness = 3
}

local MyButton = LeftGroupBox:AddButton({
    Text = 'Aim Assist',
    Func = function()
local dwCamera = workspace.CurrentCamera
local dwRunService = game:GetService("RunService")
local dwUIS = game:GetService("UserInputService")
local dwEntities = game:GetService("Players")
local dwLocalPlayer = dwEntities.LocalPlayer
local dwMouse = dwLocalPlayer:GetMouse()



local fovcircle = Drawing.new("Circle")
fovcircle.Visible = settings.Aimbot_Draw_FOV
fovcircle.Radius = settings.Aimbot_FOV_Radius
fovcircle.Color = settings.Aimbot_FOV_Color
fovcircle.Thickness = 1
fovcircle.Filled = false
fovcircle.Transparency = 0.80

dwUIS.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton2 then
        settings.Aiming = true
    end
end)

dwUIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton2 then
        settings.Aiming = false
    end
end)

dwRunService.RenderStepped:Connect(function()
    local dist = math.huge
    local closest_char = nil

    if settings.Aiming then
        for i, v in next, dwEntities:GetChildren() do
            if v ~= dwLocalPlayer and
                v.Character and
                v.Character:FindFirstChild("HumanoidRootPart") and
                v.Character:FindFirstChild("Humanoid") and
                v.Character:FindFirstChild("Humanoid").Health > 0 then
                
                if settings.Aimbot_TeamCheck == true and
                    v.Team ~= dwLocalPlayer.Team or
                    settings.Aimbot_TeamCheck == false then

                    local char = v.Character
                    local char_part_pos, is_onscreen = dwCamera:WorldToViewportPoint(char[settings.Aimbot_AimPart].Position)

                    if is_onscreen then
                        local mag = (Vector2.new(dwMouse.X, dwMouse.Y) - Vector2.new(char_part_pos.X, char_part_pos.Y)).Magnitude

                        if mag < dist and mag < settings.Aimbot_FOV_Radius then
                            dist = mag
                            closest_char = char
                        end
                    end
                end
            end
        end

        if closest_char ~= nil and
            closest_char:FindFirstChild("HumanoidRootPart") and
            closest_char:FindFirstChild("Humanoid") and
            closest_char:FindFirstChild("Humanoid").Health > 0 then
            local targetCFrame = CFrame.new(dwCamera.CFrame.Position, closest_char[settings.Aimbot_AimPart].Position)
            dwCamera.CFrame = dwCamera.CFrame:Lerp(targetCFrame, 1 / settings.Smoothness)
        end
    end

    -- Update the FOV indicator position to follow the cursor
    fovcircle.Position = Vector2.new(dwMouse.X, dwMouse.Y + 40) -- Adjust the '10' value to control the offset
end) 
    end,
    DoubleClick = false,
    Tooltip = 'Aim Assists'
})



local RightGroupBox = Tabs.Main:AddRightGroupbox('esp')

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local tracers = {} -- Store tracers here
local isTracersEnabled = false -- Track whether tracers are enabled or not

-- Function to create a line from your mouse to a target's head
local function createTracer(targetPlayer)
    local character = player.Character
    local targetCharacter = targetPlayer.Character

    if not character or not character:FindFirstChild("Humanoid") then
        return nil
    end

    local mouse = player:GetMouse()
    local targetPosition = mouse.Hit.p -- Get the position where the mouse is pointing

    if not targetCharacter or not targetCharacter:FindFirstChild("Head") then
        return nil
    end

    local tracer = Instance.new("Part")
    tracer.Size = Vector3.new(0.009, 0.009, (targetCharacter.Head.Position - targetPosition).Magnitude)
    tracer.Anchored = true
    tracer.CanCollide = false
    tracer.Transparency = 0.1
    tracer.BrickColor = BrickColor.new("Bright red") -- Customize the color if needed
    tracer.CFrame = CFrame.new(targetPosition, targetCharacter.Head.Position) * CFrame.new(0, 0, -tracer.Size.Z/2)
    tracer.Parent = game.Workspace.CurrentCamera
    return tracer
end

-- Function to update tracers
local function updateTracers()
    if isTracersEnabled then
        for _, tracer in pairs(tracers) do
            tracer:Remove()
        end
        tracers = {}

        for _, targetPlayer in pairs(game.Players:GetPlayers()) do
            if targetPlayer ~= player then
                local tracer = createTracer(targetPlayer)
                if tracer then
                    table.insert(tracers, tracer)
                end
            end
        end
    else
        for _, tracer in pairs(tracers) do
            tracer:Remove()
        end
        tracers = {}
    end
end

-- Initial update and update at interval
updateTracers()
game:GetService("RunService").RenderStepped:Connect(function()
    updateTracers()
end)



RightGroupBox:AddToggle('tracers', {
    Text = 'Tracers',
    Default = false, -- Default value (true / false)
    Tooltip = 'Shows players tracer, from your head to other players', -- Information shown when you hover over the toggle

    Callback = function(Value)
        isTracersEnabled = Value -- Update isTracersEnabled with the toggle state
        updateTracers() -- Update tracers based on the toggle state
    end
})

-- settings
local settings = {
   defaultcolor = Color3.fromRGB(255, 0, 0),
   teamcheck = false,
   teamcolor = true
};

-- services
local runService = game:GetService("RunService");
local players = game:GetService("Players");
local userInputService = game:GetService("UserInputService");

-- variables
local localPlayer = players.LocalPlayer;
local camera = workspace.CurrentCamera;

-- functions
local newVector2, newColor3, newDrawing = Vector2.new, Color3.new, Drawing.new;
local tan, rad = math.tan, math.rad;
local round = function(...) local a = {}; for i, v in next, table.pack(...) do a[i] = math.round(v); end return unpack(a); end;
local wtvp = function(...) local a, b = camera.WorldToViewportPoint(camera, ...); return newVector2(a.X, a.Y), b, a.Z end;

local espCache = {};
local espEnabled = false;

local function createEsp(player)
   local drawings = {};

   drawings.box = newDrawing("Square");
   drawings.box.Thickness = 1;
   drawings.box.Filled = false;
   drawings.box.Color = settings.defaultcolor;
   drawings.box.Visible = false;
   drawings.box.ZIndex = 2;

   drawings.boxoutline = newDrawing("Square");
   drawings.boxoutline.Thickness = 3;
   drawings.boxoutline.Filled = false;
   drawings.boxoutline.Color = newColor3();
   drawings.boxoutline.Visible = false;
   drawings.boxoutline.ZIndex = 1;

   espCache[player] = drawings;
end

local function removeEsp(player)
   if rawget(espCache, player) then
       for _, drawing in next, espCache[player] do
           drawing:Remove();
       end
       espCache[player] = nil;
   end
end

local function updateEsp(player, esp)
   local character = player and player.Character;
   if character then
       local cframe = character:GetModelCFrame();
       local position, visible, depth = wtvp(cframe.Position);
       esp.box.Visible = visible;
       esp.boxoutline.Visible = visible;

       if cframe and visible then
           local scaleFactor = 1 / (depth * tan(rad(camera.FieldOfView / 2)) * 2) * 1000;
           local width, height = round(4 * scaleFactor, 5 * scaleFactor);
           local x, y = round(position.X, position.Y);

           esp.box.Size = newVector2(width, height);
           esp.box.Position = newVector2(round(x - width / 2, y - height / 2));
           esp.box.Color = settings.teamcolor and player.TeamColor.Color or settings.defaultcolor;

           esp.boxoutline.Size = esp.box.Size;
           esp.boxoutline.Position = esp.box.Position;
       end
   else
       esp.box.Visible = false;
       esp.boxoutline.Visible = false;
   end
end

local function toggleEsp()
   espEnabled = not espEnabled;
   if espEnabled then
       for _, player in next, players:GetPlayers() do
           if player ~= localPlayer then
               createEsp(player);
           end
       end
   else
       for _, player in next, players:GetPlayers() do
           removeEsp(player);
       end
   end
end

RightGroupBox:AddToggle('Box', {
    Text = 'Box',
    Default = false, -- Default value (true / false)
    Tooltip = 'Enables box ESP', -- Information shown when you hover over the toggle

    Callback = function(Value)
        toggleEsp()
    end
})

-- Connect player added and removed events
players.PlayerAdded:Connect(function(player)
   if espEnabled then
       createEsp(player);
   end
end);

players.PlayerRemoving:Connect(function(player)
   if espEnabled then
       removeEsp(player);
   end
end)

-- ESP rendering loop
runService:BindToRenderStep("esp", Enum.RenderPriority.Camera.Value, function()
   if not espEnabled then
       return
   end

   for player, drawings in next, espCache do
       if settings.teamcheck and player.Team == localPlayer.Team then
           continue;
       end

       if drawings and player ~= localPlayer then
           updateEsp(player, drawings);
       end
   end
end)

-- Reference the camera in Workspace
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

-- Create a variable to track the name ESP state
local isNameEspEnabled = false

-- Create a table to store name labels for each player
local nameLabels = {}

-- Function to toggle name ESP
function ToggleNameEsp(enable)
    isNameEspEnabled = enable
    for _, label in pairs(nameLabels) do
        label.Visible = enable
    end
end

function createNameLabel(player)
    local NameLabel = Drawing.new("Text")
    NameLabel.Visible = false
    NameLabel.Color = Color3.new(1, 1, 1)
    NameLabel.Size = 20
    NameLabel.Center = true
    NameLabel.Outline = true
    NameLabel.OutlineColor = Color3.new(0, 0, 0)
    nameLabels[player] = NameLabel
end

for _, player in pairs(game.Players:GetPlayers()) do
    createNameLabel(player)
end

-- Function to update name labels
function updateNameLabels()
    for player, label in pairs(nameLabels) do
        if isNameEspEnabled and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") and player ~= game.Players.LocalPlayer and player.Character.Humanoid.Health > 0 then
            local Vector, onScreen = camera:worldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                label.Text = player.Name
                label.Position = Vector2.new(Vector.x, Vector.y - 30) -- Adjust the Y offset to position the name label properly
                label.Visible = true
            else
                label.Visible = false
            end
        else
            label.Visible = false
        end
    end
end

game.Players.PlayerAdded:Connect(function(player)
    createNameLabel(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    nameLabels[player] = nil
end)

RightGroupBox:AddToggle('Names', {
    Text = 'Names Toggle',
    Default = false, -- Default value (true / false)
    Tooltip = 'Shows everyones players name', -- Information shown when you hover over the toggle

    Callback = function(Value)
        ToggleNameEsp(Value)
    end
})

-- Update name labels continuously
game:GetService("RunService").RenderStepped:Connect(function()
    updateNameLabels()
end)


local RightGroupBox = Tabs.Main:AddRightGroupbox('Player')

RightGroupBox:AddSlider('FOV', {
    Text = 'FOV Slider',
    Default = 90,
    Min = 80,
    Max = 120,
    Rounding = 1,
    Compact = false,

    Callback = function(newFOV)
-- Reference the camera in Workspace
local camera = game.Workspace.CurrentCamera

-- Function to set the FOV
function SetFOV(newFOV)
    if camera then
        camera.FieldOfView = newFOV
        print('Setting FOV to', newFOV)
    else
        warn('Camera not found in Workspace!')
    end
    wait(0.001) -- Wait for 0.001 seconds before changing FOV again
end

SetFOV(newFOV)
    end
})



-- Define global variables
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")

-- Function to toggle CameraOffset
local function ToggleCameraOffset()
    local isThirdPersonEnabled = player:GetAttribute("ThirdPersonEnabled") or false
    isThirdPersonEnabled = not isThirdPersonEnabled
    
    if isThirdPersonEnabled then
        humanoid.CameraOffset = Vector3.new(0, 6, 10)
    else
        humanoid.CameraOffset = Vector3.new(0, 0, 0)
    end
    
    -- Store the camera offset state in player attributes
    player:SetAttribute("ThirdPersonEnabled", isThirdPersonEnabled)
end


RightGroupBox:AddToggle('third', {
    Text = 'Third Person!',
    Default = false, -- Default value (true / false)
    Tooltip = 'Enables/Disables third person camera!', -- Information shown when you hover over the toggle

    Callback = function(Value)
        ToggleCameraOffset()
    end
})

local function KeybindCallback(Value)
    ToggleCameraOffset()
end

-- Listen for character added and reset camera state
player.CharacterAdded:Connect(function(newCharacter)
    humanoid = newCharacter:WaitForChild("Humanoid")
    StopListeningForKeyPress()
    humanoid.CameraOffset = Vector3.new(0, 0, 0)  -- Reset camera offset
    ListenForKeyPress()
end)

-- When the player respawns, apply the camera offset if it was enabled
player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    
    if isCameraOffsetEnabled then
        humanoid.CameraOffset = Vector3.new(0, 5, 10)
    end
end)

-- When the player resets, re-enable the keybind
player.CharacterRemoving:Connect(function()
    isKeybindEnabled = true
end)







local LeftGroupBox = Tabs.TPS:AddLeftGroupbox('TP')


local MyButton = LeftGroupBox:AddButton({
    Text = 'TP random',
    Func = function()
        -- Get a list of all players in the game
        local players = game.Players:GetPlayers()
        
        -- Check if there are any players in the game
        if #players > 0 then
            -- Select a random player from the list
            local randomPlayer = players[math.random(1, #players)]
            
            -- Check if the selected player has a character and a torso
            if randomPlayer.Character and randomPlayer.Character:FindFirstChild('HumanoidRootPart') then
                local pos = randomPlayer.Character.HumanoidRootPart.Position
                local delay = 1 -- Adjust the teleport tween speed (in seconds)
                
                -- Perform the teleportation
                local tween_s = game:GetService('TweenService')
                local tweeninfo = TweenInfo.new(delay, Enum.EasingStyle.Linear)
                local lp = game.Players.LocalPlayer
                
                if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                    local cf = CFrame.new(pos)
                    local a = tween_s:Create(lp.Character.HumanoidRootPart, tweeninfo, {CFrame = cf})
                    a:Play()
                end
            else
                warn('Selected player does not have a torso.')
            end
        else
            warn('No players in the game.')
        end
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to a random player!',
})


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

    Library:SetWatermark(('Pheonix demo | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()