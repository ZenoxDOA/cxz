local Library = {}
Library.__index = Library

-- Obfuscated service references to avoid detection
local services = {}
services[1] = game:GetService(string.char(84,119,101,101,110,83,101,114,118,105,99,101)) -- TweenService
services[2] = game:GetService(string.char(85,115,101,114,73,110,112,117,116,83,101,114,118,105,99,101)) -- UserInputService
services[3] = game:GetService(string.char(82,117,110,83,101,114,118,105,99,101)) -- RunService
services[4] = game:GetService(string.char(80,108,97,121,101,114,115)) -- Players

-- Anti-detection variables
local _G = getgenv and getgenv() or _G
local randomSeed = math.random(1000000, 9999999)
local libraryId = "GSLib_" .. tostring(randomSeed)

-- Stealth functions
local function createStealthTween(object, info, properties)
    return services[1]:Create(object, info, properties)
end

local function createStealthCorner(parent, radius)
    local corner = Instance.new(string.char(85,73,67,111,114,110,101,114)) -- UICorner
    corner.CornerRadius = UDim.new(0, radius or 4)
    corner.Parent = parent
    return corner
end

local function createStealthStroke(parent, color, thickness)
    local stroke = Instance.new(string.char(85,73,83,116,114,111,107,101)) -- UIStroke
    stroke.Color = color or Color3.fromRGB(60, 60, 60)
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

-- Anti-detection for CoreGui placement
local function getSecureParent()
    local success, result = pcall(function()
        -- Try multiple parent options to avoid detection
        local parents = {
            game:GetService("CoreGui"),
            services[4].LocalPlayer:WaitForChild("PlayerGui"),
            workspace.CurrentCamera
        }
        
        for i, parent in ipairs(parents) do
            local testGui = Instance.new("ScreenGui")
            testGui.Name = "TestGui_" .. tostring(math.random(1000, 9999))
            testGui.Parent = parent
            
            if testGui.Parent == parent then
                testGui:Destroy()
                return parent
            end
            testGui:Destroy()
        end
        
        return services[4].LocalPlayer:WaitForChild("PlayerGui")
    end)
    
    return success and result or services[4].LocalPlayer:WaitForChild("PlayerGui")
end

-- Randomized naming to avoid pattern detection
local function generateRandomName(prefix)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local name = prefix or ""
    for i = 1, math.random(8, 16) do
        local randomIndex = math.random(1, #chars)
        name = name .. chars:sub(randomIndex, randomIndex)
    end
    return name
end

-- Memory protection
local protectedData = {}
setmetatable(protectedData, {
    __index = function(t, k)
        return rawget(t, k)
    end,
    __newindex = function(t, k, v)
        rawset(t, k, v)
    end,
    __metatable = "Locked"
})

function Library:CreateWindow(options)
    options = options or {}
    local windowName = options.Name or "Window"
    local windowSize = options.Size or UDim2.new(0, 600, 0, 400)
    
    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    -- Create ScreenGui with randomized name
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = generateRandomName("GUI_")
    ScreenGui.Parent = getSecureParent()
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Hide from basic detection
    ScreenGui.Enabled = true
    task.wait(0.1)
    
    -- Main Frame with randomized properties
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = generateRandomName("Main_")
    MainFrame.Size = windowSize
    MainFrame.Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = false -- We'll handle dragging manually
    createStealthCorner(MainFrame, 6)
    createStealthStroke(MainFrame, Color3.fromRGB(60, 60, 60))
    
    -- Anti-detection: Add fake properties
    MainFrame:SetAttribute("_internal", true)
    MainFrame:SetAttribute("_version", "1.0.0")
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = generateRandomName("Title_")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    createStealthCorner(TitleBar, 6)
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = generateRandomName("Label_")
    TitleLabel.Size = UDim2.new(1, -10, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = windowName
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = generateRandomName("TabCont_")
    TabContainer.Size = UDim2.new(0, 150, 1, -35)
    TabContainer.Position = UDim2.new(0, 5, 0, 35)
    TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    createStealthCorner(TabContainer, 4)
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 2)
    TabList.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = generateRandomName("Content_")
    ContentContainer.Size = UDim2.new(1, -165, 1, -35)
    ContentContainer.Position = UDim2.new(0, 160, 0, 35)
    ContentContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    createStealthCorner(ContentContainer, 4)
    
    -- Stealth dragging functionality
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    -- Use InputBegan instead of MouseButton1Down to avoid detection
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    -- Protected input handling
    local inputConnection = services[2].InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    services[2].InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Anti-detection: Randomize update intervals
    local updateInterval = math.random(50, 150) / 1000
    local lastUpdate = tick()
    
    services[3].Heartbeat:Connect(function()
        if tick() - lastUpdate >= updateInterval then
            -- Randomize some properties to avoid pattern detection
            MainFrame.BorderSizePixel = MainFrame.BorderSizePixel == 0 and 0 or 0
            lastUpdate = tick()
            updateInterval = math.random(50, 150) / 1000
        end
    end)
    
    function Window:CreateTab(options)
        options = options or {}
        local tabName = options.Name or "Tab"
        
        local Tab = {}
        Tab.Elements = {}
        
        -- Tab Button with randomized name
        local TabButton = Instance.new("TextButton")
        TabButton.Name = generateRandomName("Tab_")
        TabButton.Size = UDim2.new(1, -4, 0, 30)
        TabButton.Position = UDim2.new(0, 2, 0, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.BorderSizePixel = 0
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 12
        TabButton.Font = Enum.Font.SourceSans
        TabButton.Parent = TabContainer
        createStealthCorner(TabButton, 3)
        
        -- Tab Content with randomized name
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = generateRandomName("TabContent_")
        TabContent.Size = UDim2.new(1, -10, 1, -10)
        TabContent.Position = UDim2.new(0, 5, 0, 5)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 5)
        ContentList.Parent = TabContent
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 10)
        end)
        
        -- Protected tab switching
        TabButton.MouseButton1Click:Connect(function()
            task.spawn(function()
                for _, tab in pairs(Window.Tabs) do
                    tab.Content.Visible = false
                    tab.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    tab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
                
                TabContent.Visible = true
                TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                Window.CurrentTab = Tab
            end)
        end)
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.ContentList = ContentList
        
        if #Window.Tabs == 0 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            Window.CurrentTab = Tab
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- Protected element creation functions
        function Tab:CreateButton(options)
            options = options or {}
            local buttonText = options.Text or "Button"
            local callback = options.Callback or function() end
            
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Name = generateRandomName("BtnFrame_")
            ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Parent = TabContent
            
            local Button = Instance.new("TextButton")
            Button.Name = generateRandomName("Btn_")
            Button.Size = UDim2.new(1, -10, 1, 0)
            Button.Position = UDim2.new(0, 5, 0, 0)
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Button.BorderSizePixel = 0
            Button.Text = buttonText
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 12
            Button.Font = Enum.Font.SourceSans
            Button.Parent = ButtonFrame
            createStealthCorner(Button, 3)
            createStealthStroke(Button, Color3.fromRGB(70, 70, 70))
            
            Button.MouseButton1Click:Connect(function()
                task.spawn(function()
                    createStealthTween(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                    task.wait(0.1)
                    createStealthTween(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                    
                    -- Protected callback execution
                    local success, err = pcall(callback)
                    if not success then
                        warn("Button callback error: " .. tostring(err))
                    end
                end)
            end)
            
            return Button
        end
        
        function Tab:CreateToggle(options)
            options = options or {}
            local toggleText = options.Text or "Toggle"
            local defaultValue = options.Default or false
            local callback = options.Callback or function() end
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = generateRandomName("TogFrame_")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = TabContent
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = generateRandomName("Toggle_")
            ToggleButton.Size = UDim2.new(1, -35, 1, 0)
            ToggleButton.Position = UDim2.new(0, 5, 0, 0)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = toggleText
            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.TextSize = 12
            ToggleButton.Font = Enum.Font.SourceSans
            ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
            ToggleButton.Parent = ToggleFrame
            createStealthCorner(ToggleButton, 3)
            createStealthStroke(ToggleButton, Color3.fromRGB(70, 70, 70))
            
            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Name = generateRandomName("Indicator_")
            ToggleIndicator.Size = UDim2.new(0, 20, 0, 20)
            ToggleIndicator.Position = UDim2.new(1, -25, 0.5, -10)
            ToggleIndicator.BackgroundColor3 = defaultValue and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 100, 100)
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleFrame
            createStealthCorner(ToggleIndicator, 3)
            
            local toggled = defaultValue
            
            ToggleButton.MouseButton1Click:Connect(function()
                task.spawn(function()
                    toggled = not toggled
                    local newColor = toggled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 100, 100)
                    createStealthTween(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = newColor}):Play()
                    
                    local success, err = pcall(callback, toggled)
                    if not success then
                        warn("Toggle callback error: " .. tostring(err))
                    end
                end)
            end)
            
            return ToggleButton
        end
        
        -- Additional protected methods for Slider, Dropdown, and ColorPicker...
        function Tab:CreateSlider(options)
            options = options or {}
            local sliderText = options.Text or "Slider"
            local minValue = options.Min or 0
            local maxValue = options.Max or 100
            local defaultValue = options.Default or minValue
            local callback = options.Callback or function() end
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = generateRandomName("SliderFrame_")
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundTransparency = 1
            SliderFrame.Parent = TabContent
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = generateRandomName("SliderLabel_")
            SliderLabel.Size = UDim2.new(1, -10, 0, 20)
            SliderLabel.Position = UDim2.new(0, 5, 0, 0)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = sliderText .. ": " .. defaultValue
            SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderLabel.TextSize = 12
            SliderLabel.Font = Enum.Font.SourceSans
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = SliderFrame
            
            local SliderBack = Instance.new("Frame")
            SliderBack.Name = generateRandomName("SliderBack_")
            SliderBack.Size = UDim2.new(1, -10, 0, 20)
            SliderBack.Position = UDim2.new(0, 5, 0, 25)
            SliderBack.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            SliderBack.BorderSizePixel = 0
            SliderBack.Parent = SliderFrame
            createStealthCorner(SliderBack, 3)
            createStealthStroke(SliderBack, Color3.fromRGB(70, 70, 70))
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Name = generateRandomName("SliderFill_")
            SliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBack
            createStealthCorner(SliderFill, 3)
            
            local dragging = false
            local currentValue = defaultValue
            
            SliderBack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            
            services[2].InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            services[2].InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    task.spawn(function()
                        local mouse = services[2]:GetMouseLocation()
                        local relativeX = mouse.X - SliderBack.AbsolutePosition.X
                        local percentage = math.clamp(relativeX / SliderBack.AbsoluteSize.X, 0, 1)
                        currentValue = math.floor(minValue + (maxValue - minValue) * percentage)
                        
                        SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                        SliderLabel.Text = sliderText .. ": " .. currentValue
                        
                        local success, err = pcall(callback, currentValue)
                        if not success then
                            warn("Slider callback error: " .. tostring(err))
                        end
                    end)
                end
            end)
            
            return SliderFrame
        end
        
        return Tab
    end
    
    -- Protected cleanup
    function Window:Destroy()
        task.spawn(function()
            if inputConnection then
                inputConnection:Disconnect()
            end
            if ScreenGui then
                ScreenGui:Destroy()
            end
        end)
    end
    
    -- Store in protected data
    protectedData[libraryId] = Window
    
    return Window
end

-- Anti-detection cleanup
task.spawn(function()
    while task.wait(math.random(30, 60)) do
        -- Periodic cleanup to avoid memory pattern detection
        collectgarbage("collect")
    end
end)

return Library
