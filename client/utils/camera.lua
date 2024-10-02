Camera = {};
Camera.__index = Camera;

function Camera:new(cam)
    cam = cam or {};

    setmetatable(cam, self);

    self.handle = CreateCam('DEFAULT_SCRIPTED_CAMERA', false);
    self.coords = cam.coords or vector4(0.0, 0.0, 0.0, 0.0);

    self.rotation = cam.rotation or vector3(0.0, 0.0, 0.0);
    self.fov = cam.fov or 60.0;

    return cam;
end

function Camera:setup()
    SetCamCoord(self.handle, self.coords.x, self.coords.y, self.coords.z);
    SetCamRot(self.handle, self.rotation.x, self.rotation.y, self.rotation.z);
    SetCamFov(self.handle, self.fov);

    SetCamActive(self.handle, true);
    RenderScriptCams(true, 1, 500, true, true);
end

function Camera:pointAtEntity(entity)
    PointCamAtEntity(self.handle, entity, 0.0, 0.0, 0.0, true);
end

function Camera:pointAtCoord(coords)
    PointCamAtCoord(self.handle, coords.x, coords.y, coords.z);
end

function Camera:setFov(fov)
    SetCamFov(self.handle, fov);
end

function Camera:destroy()
    DestroyCam(self.handle, false);
end

function Camera:getCoords()
    return self.coords;
end

function Camera:setCoords(coords)
    SetCamCoord(self.handle, coords.x, coords.y, coords.z);
end

function Camera:getRotation()
    return self.rotation;
end

function Camera:setRotation(rotation)
    SetCamRot(self.handle, rotation.x, rotation.y, rotation.z);
end

function Camera:getFov()
    return self.fov;
end

function Camera:setActive()
    SetCamActive(self.handle, true);
end
