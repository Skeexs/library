RegisterCommand("player", function(source)
    local player = Player:new(source);

    print(player.cash);
    print(player.steamName)
end)

RegisterCommand("givecash", function(source, args)
    local player = Player:new(source) or {};

    if not player then
        return;
    end

    player.addCash(5000);
end)
