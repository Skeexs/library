local Core = Framework:Get();
Player = {};

function Player:new(source)
    local o = {};

    setmetatable(o, self);
    self.__index = self;

    o.source = source;

    self.dummy = Core:GetPlayer(source);

    if not self.dummy then
        return {
            error = "Player not found.",
        }
    end

    if Core.isQBCore then
        o.cash = self.dummy.PlayerData.money.cash;
        o.bank = self.dummy.PlayerData.money.bank;
        o.identifier = self.dummy.PlayerData.license
        o.steamName = self.dummy.PlayerData.name;
        o.socialSecurityNumber = self.dummy.PlayerData.cid;

        o.addCash = function(amount)
            self.dummy.Functions.AddMoney('cash', amount);
        end

        o.removeCash = function(amount)
            self.dummy.Functions.RemoveMoney('cash', amount);
        end

        o.job = self.dummy.PlayerData.job.name;
        o.job_grade = self.dummy.PlayerData.job.grade

        print()



        -- self.job_title = Core.base.Jobs[self.dummy.PlayerData.job.name].grades
        --     [tostring(self.dummy.PlayerData.job.grade)].label;

        self.firstName = self.dummy.PlayerData.charinfo.firstname;
        self.lastName = self.dummy.PlayerData.charinfo.lastname;
    elseif Core.isESX then
        o.cash = self.dummy.getMoney();
        o.bank = self.dummy.getAccount('bank').money;

        local jobs = Core.base.Jobs;

        log:info("Mitt jobb", self.dummy.job.name, self.dummy.job.grade)
        log:info("Mitt jobb i JSON", json.encode(jobs[self.dummy.job.name], {
            indent = true
        }))

        o.job = self.dummy.job.name;
        o.job_grade = self.dummy.job.grade
        o.job_title = (jobs and jobs[o.job]) and jobs[o.job].grades[tostring(o.job_grade)].label or "Unknown";

        o.identifier = self.dummy.getIdentifier();
        o.steamName = GetPlayerName(source)
        o.socialSecurityNumber = self.dummy.getIdentifier();

        o.firstName = self.dummy.variables.firstName;
        o.lastName = self.dummy.variables.lastName;
    elseif Core.isCustom then
        o.cash = self.dummy.cash;
        o.bank = self.dummy.bank;
    end

    return o;
end

function Player:retrieveSSN()
    return self.socialSecurityNumber;
end

function Player:GetSteamName()
    return self.steamName;
end

function Player:GetIdentifier()
    return self.identifier;
end

function Player:Notify(message, type)
    if Core.isQBCore then
        TriggerClientEvent('QBCore:Notify', self.source, message, type);
    elseif Core.isESX then
        TriggerClientEvent('esx:showNotification', self.source, message);
    elseif Core.isCustom then
        -- self.dummy:Notify(message, type);
    end

    return true;
end

function Player:removeCash(amount)
    if Core.isQBCore then
        self.dummy.Functions.RemoveMoney('cash', amount);
    elseif Core.isESX then
        self.dummy.removeMoney(amount);
    end

    self.cash = self.cash - amount;

    self:Notify("You have removed $" .. amount .. " from your wallet.", "error");

    return self.cash;
end

function Player:hasMoney(amount)
    if Core.isQBCore then
        return self.dummy.Functions.GetMoney('cash').money >= amount;
    elseif Core.isESX then
        return self.dummy.getMoney() >= amount;
    end

    return false;
end

exports('getPlayer', function(source)
    return Player:new(source);
end)
