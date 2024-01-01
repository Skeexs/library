-- ! Work in progress !

local base = Framework:Get();

Citizens = {};

function Citizens:new(socialSecurityNumber)
    local o = {};

    setmetatable(o, self);
    self.__index = self;

    o.socialSecurityNumber = socialSecurityNumber;

    if (GetResourceState('qb-core') == "started") then
        o.playerData = base:GetPlayerByCitizenId(socialSecurityNumber);
    elseif (GetResourceState('es_extended') == "started") then
        o.playerData = base:GetPlayerFromIdentifier(socialSecurityNumber);
    elseif (GetResourceState(Config.ResourceBaseName) == "started") then
        o.playerData = Config.GetCitizenObject(socialSecurityNumber);
    end

    return o;
end
