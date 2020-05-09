local config = exports.revival_announcer:RA_GetConfig()

local wait = GetConvarInt("ra_wait_time", config.defaultWaitTime)
local prefix = GetConvar("ra_prefix", config.messagePrefix)

local color_r = GetConvarInt("ra_color_r", config.messageColor[1])
local color_g = GetConvarInt("ra_color_g", config.messageColor[2])
local color_b = GetConvarInt("ra_color_b", config.messageColor[3])

local color = {color_r, color_g, color_b}

local ignorelist = {}

-- listen I get it I should clean it up, move on with your day.

function send(args, src, color, multiline)
    if src == nil then
        src = -1
    end

    if color == nil then
        color = {255, 0, 0}
    end

    if multiline == nil then
        multiline = true
    end

    if args == nil then
        print("Message is nil.")
        return
    elseif type(args) == "string" then
        args = {prefix, args}
    end

    TriggerClientEvent('chat:addMessage', src, {
        color = color,
        multiline = multiline,
        args = args
    }) 
end

RegisterCommand("announce", function(source, args)
    if #config.messages < 1 then
        send("There are no messages set up in the configuration file.", source)
        return
    end

    if #args == 1 then
        if tonumber(args[1]) ~= nil then
            if not config.messages[tonumber(args[1])] then
                send("You did not specify a valid announcement id!", source)
                return
            end
            
            if config.ignoreList then
                for i, v in ipairs(GetPlayers()) do
                    if not ignorelist[v] == true then
                        send(config.messages[tonumber(args[1])], v)
                    end
                end
            else
                send(config.messages[tonumber(args[1])])
            end
        end
    else
        send("You must specify ^31^0 argument!", source)
    end
end, true)

RegisterCommand("ignore", function(source, args)
    if ignorelist[GetPlayerName(source)] ~= true then
        send("Added you to the ignore list of announcements.", source)
        ignorelist[GetPlayerName(source)] = true
    else
        send("Removed you from the ignore list.", source)
        ignorelist[GetPlayerName(source)] = nil
    end
end, true)

Citizen.CreateThread(function()
    if #config.messages == 0 then
        print("No messages were provided in the messages config, so I'll be shutting down now.")
        return
    end

    print("rAnnouncer started.")

    local index = 0

    while true do
        if index == #config.messages then
            index = 0 
        end
        
        index = index + 1

        if config.ignoreList == true then
            for i, v in ipairs(GetPlayers()) do
                if ignorelist[GetPlayerName(v)] == nil then
                    send(config.messages[index], v)
                end
            end
        else
            send(config.messages[index])
        end

        print(prefix .. ": " .. config.messages[index])
        
        Citizen.Wait(wait * 1000)
    end  
end)

AddEventHandler('playerDropped', function (reason)
    if ignorelist[GetPlayerName(source)] then
        ignorelist[GetPlayerName(source)] = nil
        print("Player " .. GetPlayerName(source) .. " dropped, handling disconnect. (Reason: " .. reason .. ")")
    end
end)