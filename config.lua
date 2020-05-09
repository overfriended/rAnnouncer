-- These are defaults, you can either set them here or through convars. 

local Config = {}

Config.ignoreList = true -- STRONGLY RECOMMEND DISABLING WITH INFINITY
Config.defaultWaitTime = 300 -- 300 seconds (5 minutes)
Config.messagePrefix = "System"
Config.messageColor = {255, 0, 0}

Config.messages = {
    "Please do not step on too many snails!", -- id 1
    "Snail lives matter!", -- id 2
    "Subscribe to me on Snailtube!" -- id 3
}

exports("RA_GetConfig", function()
    return Config
end)
