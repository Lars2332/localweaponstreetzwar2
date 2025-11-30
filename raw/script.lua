-- Wczytuje oryginalny skrypt z podanego adresu URL
loadstring(game:HttpGet("https://raw.githubusercontent.com/Lars2332/localweaponstreetzwar2/main/raw/script.lua"))()

-- --- POCZĄTEK KODU PRZEŁĄCZNIKA LOTU ---

local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local isFlying = false
local flySpeed = 100 -- Prędkość latania, możesz zmienić
local flyConnection

local function startFlying()
    if isFlying then return end
    isFlying = true
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character.HumanoidRootPart
    
    -- Wyłączenie grawitacji i kolizji
    humanoid.PlatformStand = true
    rootPart.Anchored = false
    
    -- Główna pętla lotu
    flyConnection = runService.Heartbeat:Connect(function()
        if not isFlying or not character or not rootPart then
            flyConnection:Disconnect()
            return
        end
        
        local moveDirection = humanoid.MoveDirection
        local camera = workspace.CurrentCamera
        local lookVector = camera.CFrame.LookVector
        
        -- Obliczanie wektora ruchu
        local velocity = Vector3.new()
        
        -- Ruch do przodu/tyłu i w boki
        if moveDirection.Magnitude > 0 then
            velocity = (lookVector * moveDirection.Z + camera.CFrame.RightVector * moveDirection.X) * flySpeed
        end
        
        -- Ruch w górę i w dół (klawisze Shift i Ctrl)
        if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) or userInputService:IsKeyDown(Enum.KeyCode.RightShift) then
            velocity = velocity + Vector3.new(0, flySpeed, 0)
        elseif userInputService:IsKeyDown(Enum.KeyCode.LeftControl) or userInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            velocity = velocity + Vector3.new(0, -flySpeed, 0)
        end
        
        -- Zastosowanie prędkości
        rootPart.Velocity = velocity
        rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + lookVector) -- Utrzymanie orientacji
    end)
end

local function stopFlying()
    if not isFlying then return end
    isFlying = false
    
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") then
        character.Humanoid.PlatformStand = false
        character.HumanoidRootPart.Velocity = Vector3.new() -- Zatrzymanie po wylądowaniu
    end
    
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
end

-- Połączenie zdarzenia naciśnięcia klawisza F
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        if isFlying then
            stopFlying()
        else
            startFlying()
        end
    end
end)

print("Przełącznik lotu (F) załadowany. Użyj Shift, aby lecieć w górę, i Ctrl, aby lecieć w dół.")
