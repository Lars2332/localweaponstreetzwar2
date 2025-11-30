for _,player in ipairs(game.Players:GetPlayers()) do
    if player.Character then
        player.Character:BreakJoints()
    end
end
