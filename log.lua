log = {};

_print = print;

function print(...)
    if Config.Debug then
        _print(...);
    end
end

function log:info(...)
    print("[INFO] ", ...);
end

function log:error(...)
    print("[ERROR] ", ...);
end
