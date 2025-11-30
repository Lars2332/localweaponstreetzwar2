local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- Poczekaj, aż leaderstats się załadują
local leaderstats = player:WaitForChild("leaderstats", 5)

if leaderstats then
    local xp = leaderstats:FindFirstChild("XP")
    if xp then
        xp.Value = xp.Value + 1000
        print("Dodano 1000 XP lokalnie! Nowa wartość: " .. xp.Value)
    else
        warn("Nie znaleziono zmiennej XP w leaderstats")
    end
else
    warn("Nie znaleziono leaderstats")
end
