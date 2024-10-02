Framework = {};
Framework.__index = Framework;

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
