local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local flying = false
local speed = 50

-- Funkcja latania
local function setFlying(state)
	flying = state
	humanoid.PlatformStand = state
end

UIS.InputBegan:Connect(function(input, typing)
	if typing then return end
	if input.KeyCode == Enum.KeyCode.F then
		setFlying(not flying)
	end
end)

RunService.RenderStepped:Connect(function()
	if flying then
		local direction = Vector3.zero
		local cam = workspace.CurrentCamera

		if UIS:IsKeyDown(Enum.KeyCode.W) then
			direction += cam.CFrame.LookVector
		end
		if UIS:IsKeyDown(Enum.KeyCode.S) then
			direction -= cam.CFrame.LookVector
		end
		if UIS:IsKeyDown(Enum.KeyCode.A) then
			direction -= cam.CFrame.RightVector
		end
		if UIS:IsKeyDown(Enum.KeyCode.D) then
			direction += cam.CFrame.RightVector
		end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then
			direction += Vector3.new(0,1,0)
		end
		if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
			direction -= Vector3.new(0,1,0)
		end

		root.Velocity = direction.Unit * speed
	else
		humanoid.PlatformStand = false
	end
end)
