local framework = Framework:Get()

RegisterNetEvent("QBCore:Server:OnJobUpdate", function(source, job)
    TriggerClientEvent("Library:SetDuty", source, job)
    TriggerEvent("Library:SetDuty", source, job)
end)

RegisterNetEvent("esx:setJob", function(job)
    local src = source

    TriggerClientEvent("Library:SetDuty", src, job)
    TriggerEvent("Library:SetDuty", src, job)
end)
