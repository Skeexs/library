Cache = {};

function Cache:new()
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function Cache:set(value)
    self = value;
end

function Cache:add(key, value)
    self[key] = value;
end

function Cache:remove(key)
    self[key] = nil;
end

function Cache:clear()
    for k, v in pairs(self) do
        self[k] = nil;
    end
end

function Cache:has(key)
    return self[key] ~= nil;
end

function Cache:get(key)
    return self[key];
end

function Cache:keys()
    local keys = {};
    for k, v in pairs(self) do
        table.insert(keys, k);
    end
    return keys;
end
