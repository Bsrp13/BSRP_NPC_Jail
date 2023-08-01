local areaCoords = {
    vector3(362.84, -1590.43, 23.0), -- change these coords to whatever location you want
    vector3(838.34, -1278.07, 27.55),
    vector3(-1084.71, -815.54, 14.84),
    vector3(1857.8, 3694.63, 33.27),
    vector3(-440.52, 6010.79, 26.70),
    vector3(472.50, -1007.45, 25.27)
}

local function DeleteNPC()
    local coords = GetEntityCoords(PlayerPedId())
    ClearAreaOfPeds(coords.x, coords.y, coords.z, 2.0, 1)
end

local function DisplayNotification(msg, thisFrame)
    AddTextEntry('showNotification1', msg)

    if thisFrame then
        DisplayHelpTextThisFrame('showNotification1', false)
    else
        BeginTextCommandDisplayHelp('showNotification1')
        EndTextCommandDisplayHelp(0, false, 0, -1)
    end
end



CreateThread(function()
    while true do
        local inRange = false
        Wait(5)
        for k, v in pairs(areaCoords) do
            if #(GetEntityCoords(PlayerPedId()) - v) < 10.0 then
                inRange = true
                DrawMarker(1, v.x, v.y, v.z - 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.5, 120, 10, 20, 155, false, false, false, 2, false, false, false)
                if #(GetEntityCoords(PlayerPedId()) - v) < 2.0 then
                    DisplayNotification('~w~Press ~r~E~w~ to place the suspect into Police Custody', true) -- change the text here to whatever you want
                    if IsControlJustPressed(0, 38) then
                        DeleteNPC()
                TriggerEvent('chatMessage', "^1[Custody Sergeant]^7 Suspect is now in Police Custody! You can now return to patrol.")
                       
                    end
                end
            end
        end
        if not inRange then
            Wait(1000)
        end
    end
end)