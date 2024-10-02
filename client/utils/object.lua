Object = {};

function Object:new(obj)
    obj = obj or {};

    setmetatable(obj, self);
    self.__index = self;

    obj.model = obj.model or 0;
    obj.coords = obj.coords or vector3(0.0, 0.0, 0.0);
    obj.isNetwork = obj.isNetwork or false;
    obj.isMission = obj.isMission or false;
    obj.flag = obj.flag or 0;

    while not HasModelLoaded(obj.model) do
        RequestModel(obj.model);
        Citizen.Wait(0);
    end

    self.entity = CreateObject(obj.model, obj.coords.xyz, obj.isNetwork, obj.isMission, obj.flag);

    return obj;
end

function Object:delete()
    DeleteEntity(self.entity);
end

function Object:placeOnGround()
    local ground, z = GetGroundZFor_3dCoord(self.coords.x, self.coords.y, self.coords.z, 0);
    SetEntityCoords(self.entity, self.coords.x, self.coords.y, z);
end
