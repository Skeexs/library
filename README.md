# Skeexs Library [![Build Status](https://travis-ci.org/skeexs/library.svg?branch=master)](https://travis-ci.org/skeexs/library)

## Importing Framework

```lua
-- Importing framework, this works just as importing esx or QB for example.
Base = Framework:Get();
```

## Usage (Server)

### I do not condone this type of events when removing money, its just an example.

```lua
-- Importing framework, this works just as importing esx or QB for example.
Base = Framework:Get();

-- Creating events
RegisterNetEvent("tryRemoveMoney", function(amount)
    local source = source; -- Saving source to a variable, this is just for performance.

    -- Creating a new player
    -- This is just a wrapper for ESX.GetPlayerFromId(source) or QBCore.Functions.GetPlayer(source)
    local player = Player:new(source);

    -- Checking if player exists
    if not player then
        return
    end

    -- Checking if player has enough money
    if not player:hasMoney(amount) then
        return
    end

    -- Removing money from player
    player:removeMoney(amount);
end)
```
