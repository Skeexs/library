Framework = {
    __index = Framework,
    base = {},
    player = {}
};

function Framework:Get()
    local currentFramework = {};

    setmetatable(currentFramework, self);
    self.__index = self;

    if GetResourceState('qb-core') == "started" then
        self.base = exports['qb-core']:GetCoreObject();
    elseif GetResourceState('es_extended') == "started" then
        self.base = exports['es_extended']:getSharedObject();
    elseif GetResourceState(Config.ResourceBaseName) == "started" then
        self.base = Config.GetFrameworkObject();
    end

    return self;
end

function Framework:GetPlayer(playerId)
    local player = {};

    setmetatable(player, self);
    self.__index = self;

    if GetResourceState('qb-core') == "started" then
        self.player = self.base.GetPlayer(playerId);
    elseif GetResourceState('es_extended') == "started" then
        self.player = self.base.GetPlayerFromId(playerId);
    elseif GetResourceState(Config.ResourceBaseName) == "started" then
        self.player = Config.GetPlayerObject(playerId);
    end

    return self.player;
end
