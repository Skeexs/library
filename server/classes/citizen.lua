-- ! Work in progress !

local base = Framework:Get();

Citizens = {};

function Citizens:new(socialSecurityNumber)
    local o = {}

    setmetatable(o, self)
    self.__index = self

    o.socialSecurityNumber = socialSecurityNumber

    if Framework.isQBCore then
        local QBCore = Framework.base;
        local Player = QBCore.Functions.GetPlayerByCitizenId(socialSecurityNumber)

        o.data = {
            job = {
                name  = Player.PlayerData.job.name,
                grade = Player.PlayerData.job.grade.level,
                label = Player.PlayerData.job.label,

                set   = function(job, grade)
                    return Player.Functions.SetJob(job, grade)
                end,
                get   = function()
                    return Player.PlayerData.job
                end
            }
        }
    elseif Framework.isESX then
        local player = base.GetPlayerFromIdentifier(socialSecurityNumber)

        o.data = {
            job = {
                name  = player.job.name,
                grade = player.job.grade,
                label = player.job.label,

                set   = function(job, grade)
                    return player.setJob(job, grade)
                end,
                get   = function()
                    return player.getJob()
                end
            }
        }
    elseif Framework.isCustom then
        o.data = Config.GetCitizenObject(socialSecurityNumber)
    end

    return o
end

function Citizens:GetOffline(identifier)
    setmetatable({}, self)
    self.__index = self

    if Framework.isQBCore then
        local QBCore = Framework.base;
        local Player = QBCore.Player.GetOfflinePlayer(identifier);

        if not Player then
            return {
                error = "Player not found.",
            }
        end

        self.job = {
            name       = Player.PlayerData.job.name,
            grade      = Player.PlayerData.job.grade.level,
            gradeLabel = QBCore.Shared.Jobs[Player.PlayerData.job.name].grades
                [tostring(Player.PlayerData.job.grade.level)].label or "Unknown"
        }

        self.identifier = Player.PlayerData.license
    elseif Framework.isESX then
        local getOfflinePlayer = function()
            local query = [[
                SELECT
                    *
                FROM
                    users
                WHERE
                    identifier = @identifier
            ]]

            local player = MySQL.Sync.fetchAll(query, {
                ['@identifier'] = identifier
            })

            if not player then
                return {
                    error = "Player not found.",
                }
            end

            return player and player[1] or nil
        end

        local player = getOfflinePlayer();

        if not player then
            return {
                error = "Player not found.",
            }
        end

        local ESX = Framework.base;

        -- return {
        --     job = {
        --         name       = player.job,
        --         grade      = player.job_grade,
        --         gradeLabel = ESX.Jobs[player.job].grades[tostring(player.job_grade)].label or "Unknown"
        --     }
        -- }

        self.job = {
            name       = player.job,
            grade      = player.job_grade,
            gradeLabel = ESX.Jobs[player.job].grades[tostring(player.job_grade)].label or "Unknown"
        }

        self.identifier = player.identifier
    end

    return self
end

exports('getCitizen', function(socialSecurityNumber)
    return Citizens:new(socialSecurityNumber);
end)

exports('getOfflineCitizen', function(identifier)
    return Citizens:GetOffline(identifier);
end)

exports('GetJob', function(jobName, grade)
    local job = {}

    if Framework.isQBCore then
        local QBCore = Framework.base;
        -- return QBCore.Shared.Jobs[jobName].grades[tostring(grade)].label or "Unknown"

        if not QBCore then
            return {
                error = "QBCore not found.",
            }
        end

        local _grade = QBCore.Shared.Jobs[jobName].grades[tostring(grade)];

        if not _grade then
            print("Grade not found.")
            return {
                error = "Grade not found.",
            }
        end

        print("Job found", jobName, grade, _grade.label)

        job = {
            name       = jobName,
            grade      = grade,
            gradeLabel = _grade.label or "Unknown",
            label      = QBCore.Shared.Jobs[jobName].label or "Unknown"
        }
    elseif Framework.isESX then
        local ESX = Framework.base;

        if not ESX then
            return {
                error = "ESX not found.",
            }
        end

        local _grade = ESX.Jobs[jobName].grades[tostring(grade)];

        if not _grade then
            print("Grade not found.")
            return {
                error = "Grade not found.",
            }
        end

        print("Job found", jobName, grade, _grade.label)

        job = {
            name       = jobName,
            grade      = grade,
            gradeLabel = _grade.label or "Unknown",
            label      = ESX.Jobs[jobName].label or "Unknown"
        }
    end

    return job
end)
