RegisterCommand("player", function(source)
    local player = Player:new(source);

    print(player.cash);
end)

RegisterCommand("givecash", function(source, args)
    local player = Player:new(source);

    if not args[1] then
        print("You need to specify an amount.");
        return;
    end

    local amount = tonumber(args[1]);

    if not amount then
        print("You need to specify a valid amount.");
        return;
    end

    local newAmount = player:addCash(amount);

    player:Notify("You have received $" .. amount .. " and now have $" .. newAmount .. ".", "success");
end)
