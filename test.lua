local TeleportGUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TeleportButton = Instance.new("TextButton")
local PlayerList = Instance.new("ScrollingFrame")
local PlayerButtons = {}

TeleportGUI.Name = "TeleportGUI"
TeleportGUI.Parent = game.Players.LocalPlayer.PlayerGui

MainFrame.Size = UDim2.new(0, 200, 0, 200)
MainFrame.Position = UDim2.new(1, -200, 0, 0)
MainFrame.BackgroundTransparency = 1
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.Parent = TeleportGUI

TeleportButton.Size = UDim2.new(1, 0, 0, 25)
TeleportButton.Position = UDim2.new(0, 0, 0, 0)
TeleportButton.Text = "Teleport"
TeleportButton.TextColor3 = Color3.new(255, 255, 255)
TeleportButton.TextStrokeTransparency = 0
TeleportButton.TextStrokeColor3 = Color3.new(0, 0, 0)
TeleportButton.BackgroundTransparency = 1
TeleportButton.BackgroundColor3 = Color3.new(255, 255, 255)
TeleportButton.Parent = MainFrame

PlayerList.Size = UDim2.new(1, 0, 1, -25)
PlayerList.Position = UDim2.new(0, 0, 0, 25)
PlayerList.BackgroundTransparency = 1
PlayerList.BackgroundColor3 = Color3.new(255, 255, 255)
PlayerList.Parent = MainFrame

for _,player in ipairs(game.Players:GetPlayers()) do
    if player.Name ~= "Plasiksiedem" then
        local PlayerButton = Instance.new("TextButton")
        PlayerButton.Text = player.Name
        PlayerButton.Size = UDim2.new(1, 0, 0, 25)
        PlayerButton.Position = UDim2.new(0, 0, 0, #PlayerButtons * 25)
        PlayerButton.TextColor3 = Color3.new(255, 255, 255)
        PlayerButton.TextStrokeTransparency = 0
        PlayerButton.TextStrokeColor3 = Color3.new(0, 0, 0)
        PlayerButton.BackgroundTransparency = 1
        PlayerButton.BackgroundColor3 = Color3.new(255, 255, 255)
        PlayerButton.Parent = PlayerList
        table.insert(PlayerButtons, PlayerButton)

        PlayerButton.MouseButton1Click:Connect(function()
            for _,player in ipairs(game.Players:GetPlayers()) do
                if player.Name == PlayerButton.Text then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, 1)
                    TeleportGUI:Destroy()
                    wait(1)
                    while TeleportGUI.Parent do
                        wait(1)
                    end
                    TeleportGUI.Parent = game.Players.LocalPlayer.PlayerGui
                end
            end
        end)
    end
end

game:GetService("UserInputService").InputChanged:Connect(function(inputObject)
    if inputObject.KeyCode == Enum.KeyCode.Delete then
        if TeleportGUI.Parent == game.Players.LocalPlayer.PlayerGui then
            TeleportGUI.Parent = nil
        else
            TeleportGUI.Parent = game.Players.LocalPlayer.PlayerGui
        end
    end
end)
