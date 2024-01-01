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
    elseif (GetResourceState('es_extended') == "started") then
        o.cash = self.dummy.getMoney();
        o.bank = self.dummy.getAccount('bank').money;
    elseif (GetResourceState(Config.ResourceBaseName) == "started") then
        o.cash = self.dummy.cash;
        o.bank = self.dummy.bank;
    end

    return o;
end

function Player:Notify(message, type)
    print(message);
end

function Player:addCash(amount)
    if (GetResourceState('qb-core') == "started") then
        self.dummy.Functions.AddMoney('cash', amount);
    elseif (GetResourceState('es_extended') == "started") then
        self.dummy.addMoney(amount);
    end

    self.cash = self.cash + amount;

    return self.cash;
end
