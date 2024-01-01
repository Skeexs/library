local Core = Framework:Get();
Player = {};

function Player:new(source)
    local o = {};

    setmetatable(o, self);
    self.__index = self;

    o.source = source;

    self.dummy = Core:GetPlayer(source);

    if not self.dummy then
        return;
    end

    if (GetResourceState('qb-core') == "started") then
        o.cash = self.dummy.PlayerData.money.cash;
        o.bank = self.dummy.PlayerData.money.bank;
        o.identifier = self.dummy.PlayerData.license
        o.steamName = self.dummy.PlayerData.name;
        o.socialSecurityNumber = self.dummy.PlayerData.cid;
    elseif (GetResourceState('es_extended') == "started") then
        o.cash = self.dummy.getMoney();
        o.bank = self.dummy.getAccount('bank').money;
        o.identifier = self.dummy.getIdentifier();
        o.steamName = GetPlayerName(source)
        o.socialSecurityNumber = self.dummy.getIdentifier();
    elseif (GetResourceState(Config.ResourceBaseName) == "started") then
        o.cash = self.dummy.cash;
        o.bank = self.dummy.bank;
    end

    return o;
end

function Player:Notify(message, type)
    if (GetResourceState('qb-core') == "started") then
        TriggerClientEvent('QBCore:Notify', self.source, message, type);
    elseif (GetResourceState('es_extended') == "started") then
        TriggerClientEvent('esx:showNotification', self.source, message);
    elseif (GetResourceState(Config.ResourceBaseName) == "started") then
        -- self.dummy:Notify(message, type);
    end

    return true;
end

function Player:addCash(amount)
    if (GetResourceState('qb-core') == "started") then
        self.dummy.Functions.AddMoney('cash', amount);
    elseif (GetResourceState('es_extended') == "started") then
        self.dummy.addMoney(amount);
    end

    self.cash = self.cash + amount;

    self:Notify("You have added $" .. amount .. " to your wallet.", "success");

    return self.cash;
end

function Player:removeCash(amount)
    if (GetResourceState('qb-core') == "started") then
        self.dummy.Functions.RemoveMoney('cash', amount);
    elseif (GetResourceState('es_extended') == "started") then
        self.dummy.removeMoney(amount);
    end

    self.cash = self.cash - amount;

    self:Notify("You have removed $" .. amount .. " from your wallet.", "error");

    return self.cash;
end
