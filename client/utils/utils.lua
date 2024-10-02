Utils = {};

function Utils:Find(tbl, cb)
    for k, v in ipairs(tbl) do
        if cb(v) then
            return v;
        end
    end
end

function Utils:findIndex(tbl, cb)
    for i, v in ipairs(tbl) do
        if cb(v) then
            return i;
        end
    end
end
