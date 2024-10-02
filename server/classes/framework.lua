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
        self.isQBCore = true;
    elseif GetResourceState('es_extended') == "started" then
        self.base = exports['es_extended']:getSharedObject();
        self.isESX = true;
    elseif GetResourceState(Config.ResourceBaseName) == "started" then
        self.base = Config.GetFrameworkObject();
        self.isCustom = true;
    end

    return self
end

function Framework:GetPlayer(playerId)
    local player = {};

    setmetatable(player, self);
    self.__index = self;

    if GetResourceState('qb-core') == "started" then
        self.player = self.base.Functions.GetPlayer(playerId);
    elseif GetResourceState('es_extended') == "started" then
        self.player = self.base.GetPlayerFromId(playerId);
    elseif GetResourceState(Config.ResourceBaseName) == "started" then
        self.player = Config.GetPlayerObject(playerId);
    end

    return self.player;
end

function Framework:GetCitizen(citizenId)
    local citizen = {};

    setmetatable(citizen, self);
    self.__index = self;

    if GetResourceState('qb-core') == "started" then
        self.citizen = self.base.GetPlayerByCitizenId(citizenId);
    elseif GetResourceState('es_extended') == "started" then
        self.citizen = self.base.GetPlayerFromIdentifier(citizenId);
    elseif GetResourceState(Config.ResourceBaseName) == "started" then
        self.citizen = Config.GetCitizenObject(citizenId);
    end

    return self.citizen;
end

exports('getFramework', function()
    return Framework:Get().base;
end)

-- exports('getPlayer', function(playerId)
--     return Framework:GetPlayer(playerId);
-- end)

exports('getCitizen', function(citizenId)
    return Framework:GetCitizen(citizenId);
end)
