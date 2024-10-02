Jobs = {};
Jobs.__index = Jobs;

function Jobs:new(job)
    local o = {};

    setmetatable(o, self);
    self.__index = self;

    o.job = job;

    if Framework.isQBCore then
        o.jobs = Framework.base.Jobs;

        o.employees = function()
            local query = [[
                SELECT *
                FROM players
                WHERE JSON_EXTRACT(job, '$.name') = @job_name
            ]]

            local result = MySQL.Sync.fetchAll(query, {
                ['@job_name'] = o.job
            })

            return result and result or nil
        end

        o.employee = function(citizenId)
            local query = [[
                SELECT *
                FROM players
                WHERE citizenid = @citizenid
            ]]

            local result = MySQL.Sync.fetchAll(query, {
                ['@citizenid'] = citizenId
            })

            return result and result[1] or nil
        end
    elseif Framework.isESX then
        o.jobs = Framework.base.Jobs;
    elseif Framework.isCustom then
        o.jobs = Framework.base.Jobs;
    end

    return o;
end

exports('getJob', function(job)
    return Jobs:new(job);
end)
