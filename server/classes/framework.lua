Framework = {};

function Framework:Get()
    local currentFramework = {};

    setmetatable(currentFramework, self);
    self.__index = self;

    if GetResourceState('qb-core') == "started" then
        self = exports['qb-core']:GetFrameworkObject();
    elseif GetResourceState('es_extended') == "started" then
        self = exports['es_extended']:getSharedObject();
    elseif GetResourceState(Config.ResourceBaseName) == "started" then
        self = Config.GetFrameworkObject();
    end

    return self;
end

function Framework:GetPlayerObject(playerId)
    if GetResourceState('qb-core') == "started" then
        return self.Functions.GetPlayer(playerId);
    elseif GetResourceState('es_extended') == "started" then
        return self.GetPlayerFromId(playerId);
    elseif GetResourceState(Config.ResourceBaseName) == "started" then
        return self.GetPlayerObject(playerId);
    end

    return nil;
end
