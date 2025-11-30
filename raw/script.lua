-- KONFIGURACJA SKRYPTU --
local GUI_TITLE = "XP Adder by [Twoja Nazwa]" -- Tytuł okna GUI
local STAT_NAME = "XP" -- Nazwa statystyki, którą chcesz zmienić. MUSI być taka sama jak w grze!

-- GŁÓWNY KOD SKRYPTU (nie edytuj poniżej, jeśli nie wiesz co robisz) --

local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")

-- === TWORZENIE GUI ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XPAdderGUI"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Główna ramka
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
mainFrame.Size = UDim2.new(0, 350, 0, 200)
mainFrame.Active = true
mainFrame.Draggable = true

-- Elementy w MainFrame
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Parent = mainFrame
titleLabel.BackgroundTransparency = 1
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.Size = UDim2.new(1, -20, 0, 30)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = GUI_TITLE
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Center

local xpLabel = Instance.new("TextLabel")
xpLabel.Name = "XPLabel"
xpLabel.Parent = mainFrame
xpLabel.BackgroundTransparency = 1
xpLabel.Position = UDim2.new(0, 10, 0, 60)
xpLabel.Size = UDim2.new(0, 50, 0, 30)
xpLabel.Font = Enum.Font.SourceSans
xpLabel.Text = STAT_NAME .. ":"
xpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
xpLabel.TextSize = 16
xpLabel.TextXAlignment = Enum.TextXAlignment.Left

local xpInput = Instance.new("TextBox")
xpInput.Name = "XPInput"
xpInput.Parent = mainFrame
xpInput.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
xpInput.BorderSizePixel = 0
xpInput.Position = UDim2.new(0, 70, 0, 60)
xpInput.Size = UDim2.new(1, -80, 0, 30)
xpInput.Font = Enum.Font.SourceSans
xpInput.PlaceholderText = "Wpisz liczbę..."
xpInput.Text = ""
xpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
xpInput.TextSize = 16

local addButton = Instance.new("TextButton")
addButton.Name = "AddButton"
addButton.Parent = mainFrame
addButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
addButton.BorderSizePixel = 0
addButton.Position = UDim2.new(0, 10, 0, 110)
addButton.Size = UDim2.new(1, -20, 0, 40)
addButton.Font = Enum.Font.SourceSansBold
addButton.Text = "Dodaj " .. STAT_NAME
addButton.TextColor3 = Color3.fromRGB(255, 255, 255)
addButton.TextSize = 18

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Parent = mainFrame
statusLabel.BackgroundTransparency = 1
statusLabel.Position = UDim2.new(0, 10, 0, 160)
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Font = Enum.Font.SourceSans
statusLabel.Text = "Status: Oczekuje..."
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 14
statusLabel.TextXAlignment = Enum.TextXAlignment.Center

-- === LOGIKA PRZYCISKÓW ===

-- Funkcja do dodawania XP
local function addXP()
    local amount = tonumber(xpInput.Text)
    
    -- Sprawdzenie, czy wpisano poprawną liczbę
    if not amount or amount <= 0 then
        statusLabel.Text = "Status: Błąd! Wpisz poprawną liczbę."
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    -- Znalezienie statystyki gracza
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        statusLabel.Text = "Status: Błąd! Nie znaleziono leaderstats."
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    local xpStat = leaderstats:FindFirstChild(STAT_NAME)
    if not xpStat then
        statusLabel.Text = "Status: Błąd! Nie znaleziono statystyki '" .. STAT_NAME .. "'."
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    -- Dodanie wartości do statystyki
    local currentXP = xpStat.Value
    xpStat.Value = currentXP + amount
    
    statusLabel.Text = "Status: Dodano " .. amount .. " " .. STAT_NAME .. "!"
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    -- Czyszczenie pola input po sukcesie
    xpInput.Text = ""
end

-- Połączenie przycisku z funkcją
addButton.MouseButton1Click:Connect(addXP)

-- Dodanie możliwości zatwierdzenia klawiszem "Enter"
xpInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        addXP()
    end
end)

-- === ZAMYKANIE GUI KLAWISZEM INSERT ===
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        -- Przełączanie widoczności GUI
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("Skrypt XP Adder załadowany! Naciśnij INSERT, aby pokazać/ukryć GUI.")
