Ped = {};
Ped.__index = Ped;

function Ped:new(pObj)
    local obj = {};
    setmetatable(obj, self);

    self.model = pObj.model or 0;
    self.coords = pObj.coords or vector3(0.0, 0.0, 0.0);
    self.isNetwork = pObj.isNetwork or false;
    self.isMission = pObj.isMission or false;
    self.flag = pObj.flag or 0;
    self.outfit = pObj.outfit or nil;

    while not HasModelLoaded(self.model) do
        RequestModel(self.model);
        Citizen.Wait(0);
    end

    self.entity = CreatePed(4, self.model, self.coords.xyz, self.coords.w, self.isNetwork, self.isMission, self.flag);

    print("Ped created: " .. self.entity)

    SetModelAsNoLongerNeeded(self.model)

    if obj.outfit ~= nil then
        obj:setOutfit(obj.outfit);
    end

    return self;
end

function Ped:setOutfit(outfit)
    if outfit == nil then
        return;
    end

    if outfit.mom and outfit.dad then
        SetPedHeadBlendData(self.entity, outfit.mom, outfit.dad, 0, outfit.mom, outfit.dad, 0,
            (outfit.face_md_weight / 100) + 0.0,
            (outfit.skin_md_weight / 100) + 0.0, 0.0, false)
    end

    if outfit.beard_1 and outfit.beard_1 then
        print("Setting beard: " .. outfit.beard_1 .. " " .. outfit.beard_2)

        SetPedHeadOverlay(self.entity, 1, outfit.beard_1, (outfit.beard_2 / 10) + 0.0)

        if outfit.beard_3 and outfit.beard_4 ~= 0 then
            SetPedHeadOverlayColor(self.entity, 1, 1, outfit.beard_3, outfit.beard_4)
        end
    end

    if outfit.hair_1 then
        if outfit.hair_1 then
            SetPedComponentVariation(self.entity, 2, outfit.hair_1, outfit.hair_2, 2)
        end

        if outfit.hair_color_1 then
            print("Setting hair color: " .. outfit.hair_color_1 .. " " .. outfit.hair_color_2)
            SetPedHairColor(self.entity, outfit.hair_color_1, outfit.hair_color_2)
        end
    end



    if outfit.glasses_1 and outfit.glasses_2 then
        SetPedPropIndex(self.entity, 1, outfit.glasses_1, outfit.glasses_2, 2)
    end

    -- if outfit.head ~= nil then
    --     SetPedComponentVariation(self.entity, 0, outfit.head, 0, 0)
    -- end

    if outfit.pants_1 ~= nil then
        SetPedComponentVariation(self.entity, 4, outfit.pants_1, outfit.pants_2, 0)
    end

    if outfit.arms ~= nil then
        SetPedComponentVariation(self.entity, 3, outfit.arms, outfit.arms_2, 0)
    end

    if outfit.bags_1 ~= nil then
        SetPedComponentVariation(self.entity, 5, outfit.bags_1, outfit.bags_2, 0)
    end

    if outfit.shoes_1 ~= nil then
        SetPedComponentVariation(self.entity, 6, outfit.shoes_1, outfit.shoes_2, 0)
    end

    -- if outfit.accessories ~= nil then
    --     SetPedComponentVariation(self.entity, 7, outfit.accessories, 0, 0)
    -- end

    if outfit.tshirt_1 ~= nil then
        SetPedComponentVariation(self.entity, 8, outfit.tshirt_1, outfit.tshirt_2, 0)
    end

    if outfit.bodyArmor ~= nil then
        SetPedComponentVariation(self.entity, 9, outfit.bodyArmor, 0, 0)
    end

    if outfit.decals_1 ~= nil then
        SetPedComponentVariation(self.entity, 10, outfit.decals_1, 0, 0)
    end

    if outfit.torso_1 ~= nil then
        SetPedComponentVariation(self.entity, 11, outfit.torso_1, outfit.torso_2, 0)
    end

    if outfit.mask_1 ~= nil then
        SetPedComponentVariation(self.entity, 1, outfit.mask_1, outfit.mask_2, 0)
    end

    if outfit.helmet_1 then
        SetPedPropIndex(self.entity, 0, outfit.helmet_1, outfit.helmet_2, 2)
    elseif outfit.helmet_1 == -1 then
        ClearPedProp(self.entity, 0)
    end

    if outfit.eyebrows_1 then
        SetPedHeadOverlay(playerPed, 2, outfit.eyebrows_1, (outfit.eyebrows_2 / 10) + 0.0)

        if outfit.eyebrows_3 and outfit.eyebrows_4 ~= 0 then
            SetPedHeadOverlayColor(self.entity, 2, 1, outfit.eyebrows.color, outfit.eyebrows.color2)
        end
    end
end

function Ped:getEntity()
    return self.entity;
end

function Ped:delete()
    DeleteEntity(self.entity);
    SetEntityAsMissionEntity(self.entity, true, true)
end

function Ped:playAnimation(dict, animation, options)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(self.entity, dict, animation, options.blendAnim, -options.blendAnim, -1, 1, 0, false, false, false)
end

function Ped:playScenario(scenario)
    TaskStartScenarioInPlace(self.entity, scenario, 0, true)
end

exports('createPed', function(pObj)
    return Ped:new(pObj);
end)
