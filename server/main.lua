RegisterCommand("player", function(source)
    local player = Player:new(source);

    print(player.cash);
    print(player.steamName)
end)

RegisterCommand("givecash", function(source, args)

end)
