local Library = {}
Library.__index = Library

-- Advanced obfuscation and anti-detection
local function getObfuscatedService(serviceName)
    local chars = {}
    for i = 1, #serviceName do
        table.insert(chars, string.byte(serviceName, i))
    end
    return game:GetService(string.char(unpack(chars)))
end

-- Randomized service access to avoid pattern detection
local serviceCache = {}
local function getService(name)
    if not serviceCache[name] then
        serviceCache[name] = getObfuscatedService(name)
    end
    return serviceCache[name]
end

-- Anti-detection parent finder
local function findSecureParent()
    local parents = {
        workspace.CurrentCamera,
        getService("Players").LocalPlayer:WaitForChild("PlayerGui"),
    }
    
    -- Try CoreGui with protection
    local success, coreGui = pcall(function()
        return getService("CoreGui")
    end)
    
    if success then
        -- Test if we can actually use CoreGui without detection
        local testGui = Instance.new("ScreenGui")
        testGui.Name = "Test_" .. tostring(math.random(100000, 999999))
        
        local testSuccess = pcall(function()
            testGui.Parent = coreGui
            task.wait(0.1)
            testGui:Destroy()
        end)
        
        if testSuccess then
            table.insert(parents, 1, coreGui)
        end
    end
    
    -- Return first working parent
    for _, parent in ipairs(parents) do
        local testGui = Instance.new("ScreenGui")
        testGui.Name = "ParentTest_" .. tostring(math.random(10000, 99999))
        
        local works = pcall(function()
            testGui.Parent = parent
            testGui:Destroy()
        end)
        
        if works then
            return parent
        end
    end
    
    return getService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- Memory protection and cleanup
local protectedInstances = {}
local cleanupFunctions = {}

-- Advanced name generation with multiple patterns
local function generateStealthName(prefix)
    local patterns = {
        function() -- Roblox-like names
            local robloxNames = {"Frame", "TextLabel", "ScrollingFrame", "UIListLayout", "UIPadding"}
            return robloxNames[math.random(1, #robloxNames)] .. "_" .. tostring(math.random(1000, 9999))
        end,
        function() -- Random characters
            local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            local name = prefix or ""
            for i = 1, math.random(6, 12) do
                name = name .. chars:sub(math.random(1, #chars), math.random(1, #chars))
            end
            return name
        end,
        function() -- System-like names
            local systemNames = {"System", "Core", "Main", "Root", "Base", "Primary"}
            return systemNames[math.random(1, #systemNames)] .. tostring(math.random(100, 999))
        end
    }
    
    return patterns[math.random(1, #patterns)]()
end

-- Color scheme (more subtle to avoid detection)
local Colors = {
    Background = Color3.fromRGB(18, 18, 18),
    Secondary = Color3.fromRGB(22, 22, 22),
    Accent = Color3.fromRGB(28, 28, 28),
    Border = Color3.fromRGB(45, 45, 45),
    Text = Color3.fromRGB(240, 240, 240),
    TextSecondary = Color3.fromRGB(170, 170, 170),
    Primary = Color3.fromRGB(88, 135, 230),
    Success = Color3.fromRGB(90, 180, 90),
    Warning = Color3.fromRGB(230, 180, 90),
    Error = Color3.fromRGB(230, 90, 90),
    Hover = Color3.fromRGB(35, 35, 35)
}

-- Protected tween creation
local function createProtectedTween(object, info, properties)
    local success, tween = pcall(function()
        return getService("TweenService"):Create(object, info, properties)
    end)
    return success and tween or nil
end

-- Stealth UI creation functions
local function createStealthElement(className, properties)
    local element = Instance.new(className)
    element.Name = generateStealthName()
    
    if properties then
        for prop, value in pairs(properties) do
            pcall(function()
                element[prop] = value
            end)
        end
    end
    
    table.insert(protectedInstances, element)
    return element
end

function Library:CreateWindow(options)
    options = options or {}
    local windowName = options.Name or "Window"
    local windowSize = options.Size or UDim2.new(0, 650, 0, 450)
    
    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    Window.Visible = true
    
    -- Create ScreenGui with maximum stealth
    local ScreenGui = createStealthElement("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        IgnoreGuiInset = true
    })
    
    -- Advanced parent detection and placement
    local secureParent = findSecureParent()
    ScreenGui.Parent = secureParent
    
    -- Hide from basic detection methods
    task.spawn(function()
        task.wait(0.1)
        ScreenGui.Enabled = true
    end)
    
    -- Main Frame with anti-detection properties
    local MainFrame = createStealthElement("Frame", {
        Size = windowSize,
        Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        Active = true,
        Visible = true
    })
    MainFrame.Parent = ScreenGui
    
    -- Add fake properties to confuse detection
    MainFrame:SetAttribute("_roblox_internal", true)
    MainFrame:SetAttribute("_system_ui", true)
    MainFrame:SetAttribute("_protected", math.random(1000, 9999))
    
    -- Create corner and stroke with protection
    pcall(function()
        local corner = createStealthElement("UICorner", {CornerRadius = UDim.new(0, 6)})
        corner.Parent = MainFrame
        
        local stroke = createStealthElement("UIStroke", {
            Color = Colors.Border,
            Thickness = 1
        })
        stroke.Parent = MainFrame
    end)
    
    -- Title Bar
    local TitleBar = createStealthElement("Frame", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Colors.Secondary,
        BorderSizePixel = 0
    })
    TitleBar.Parent = MainFrame
    
    local TitleLabel = createStealthElement("TextLabel", {
        Size = UDim2.new(1, -15, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = windowName,
        TextColor3 = Colors.Text,
        TextSize = 14,
        Font = Enum.Font.SourceSans,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    TitleLabel.Parent = TitleBar
    
    -- Tab Container
    local TabContainer = createStealthElement("Frame", {
        Size = UDim2.new(0, 160, 1, -40),
        Position = UDim2.new(0, 8, 0, 40),
        BackgroundColor3 = Colors.Secondary,
        BorderSizePixel = 0
    })
    TabContainer.Parent = MainFrame
    
    local TabList = createStealthElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 3)
    })
    TabList.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = createStealthElement("Frame", {
        Size = UDim2.new(1, -180, 1, -40),
        Position = UDim2.new(0, 175, 0, 40),
        BackgroundColor3 = Colors.Secondary,
        BorderSizePixel = 0
    })
    ContentContainer.Parent = MainFrame
    
    -- Protected dragging with randomized intervals
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    -- Anti-detection: Randomize connection timing
    task.spawn(function()
        task.wait(math.random(50, 200) / 1000)
        
        getService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(
                    startPos.X.Scale, 
                    startPos.X.Offset + delta.X, 
                    startPos.Y.Scale, 
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
        
        getService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end)
    
    function Window:CreateTab(options)
        options = options or {}
        local tabName = options.Name or "Tab"
        
        local Tab = {}
        Tab.Elements = {}
        
        -- Tab Button
        local TabButton = createStealthElement("TextButton", {
            Size = UDim2.new(1, -6, 0, 32),
            Position = UDim2.new(0, 3, 0, 0),
            BackgroundColor3 = Colors.Accent,
            BorderSizePixel = 0,
            Text = tabName,
            TextColor3 = Colors.TextSecondary,
            TextSize = 13,
            Font = Enum.Font.SourceSans
        })
        TabButton.Parent = TabContainer
        
        -- Tab Content
        local TabContent = createStealthElement("ScrollingFrame", {
            Size = UDim2.new(1, -10, 1, -10),
            Position = UDim2.new(0, 5, 0, 5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Colors.Primary,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false
        })
        TabContent.Parent = ContentContainer
        
        local ContentList = createStealthElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6)
        })
        ContentList.Parent = TabContent
        
        -- Protected tab switching
        TabButton.MouseButton1Click:Connect(function()
            task.spawn(function()
                for _, tab in pairs(Window.Tabs) do
                    tab.Content.Visible = false
                    tab.Button.BackgroundColor3 = Colors.Accent
                    tab.Button.TextColor3 = Colors.TextSecondary
                end
                
                TabContent.Visible = true
                TabButton.BackgroundColor3 = Colors.Primary
                TabButton.TextColor3 = Colors.Text
                Window.CurrentTab = Tab
            end)
        end)
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.ContentList = ContentList
        
        if #Window.Tabs == 0 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Colors.Primary
            TabButton.TextColor3 = Colors.Text
            Window.CurrentTab = Tab
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- Protected element creation functions
        function Tab:CreateButton(options)
            options = options or {}
            local buttonText = options.Text or "Button"
            local callback = options.Callback or function() end
            
            local ButtonFrame = createStealthElement("Frame", {
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundTransparency = 1
            })
            ButtonFrame.Parent = TabContent
            
            local Button = createStealthElement("TextButton", {
                Size = UDim2.new(1, -8, 1, 0),
                Position = UDim2.new(0, 4, 0, 0),
                BackgroundColor3 = Colors.Accent,
                BorderSizePixel = 0,
                Text = buttonText,
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.SourceSans
            })
            Button.Parent = ButtonFrame
            
            Button.MouseButton1Click:Connect(function()
                task.spawn(function()
                    local tween = createProtectedTween(Button, TweenInfo.new(0.1), {BackgroundColor3 = Colors.Primary})
                    if tween then tween:Play() end
                    
                    task.wait(0.1)
                    
                    local tween2 = createProtectedTween(Button, TweenInfo.new(0.1), {BackgroundColor3 = Colors.Accent})
                    if tween2 then tween2:Play() end
                    
                    pcall(callback)
                end)
            end)
            
            return Button
        end
        
        function Tab:CreateToggle(options)
            options = options or {}
            local toggleText = options.Text or "Toggle"
            local defaultValue = options.Default or false
            local callback = options.Callback or function() end
            
            local ToggleFrame = createStealthElement("Frame", {
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = Colors.Accent,
                BorderSizePixel = 0
            })
            ToggleFrame.Parent = TabContent
            
            local ToggleButton = createStealthElement("TextButton", {
                Size = UDim2.new(1, -40, 1, 0),
                BackgroundTransparency = 1,
                Text = toggleText,
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.SourceSans,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            ToggleButton.Parent = ToggleFrame
            
            local ToggleIndicator = createStealthElement("Frame", {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(1, -22, 0.5, -9),
                BackgroundColor3 = defaultValue and Colors.Success or Colors.Error,
                BorderSizePixel = 0
            })
            ToggleIndicator.Parent = ToggleFrame
            
            local toggled = defaultValue
            
            ToggleButton.MouseButton1Click:Connect(function()
                task.spawn(function()
                    toggled = not toggled
                    local newColor = toggled and Colors.Success or Colors.Error
                    
                    local tween = createProtectedTween(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = newColor})
                    if tween then tween:Play() end
                    
                    pcall(callback, toggled)
                end)
            end)
            
            return ToggleButton
        end
        
        return Tab
    end
    
    -- Protected cleanup
    function Window:Destroy()
        task.spawn(function()
            for _, instance in pairs(protectedInstances) do
                pcall(function()
                    instance:Destroy()
                end)
            end
            
            for _, cleanup in pairs(cleanupFunctions) do
                pcall(cleanup)
            end
            
            if ScreenGui then
                ScreenGui:Destroy()
            end
        end)
    end
    
    return Window
end

-- Anti-detection cleanup routine
task.spawn(function()
    while task.wait(math.random(45, 90)) do
        pcall(function()
            collectgarbage("collect")
        end)
    end
end)

return Library
