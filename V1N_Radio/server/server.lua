--[[
────────────────────────────────────────────────────────────────────────────────
─██████──██████─████████───██████──────────██████─████████████───██████████████─
─██░░██──██░░██─██░░░░██───██░░██████████──██░░██─██░░░░░░░░████─██░░░░░░░░░░██─
─██░░██──██░░██─████░░██───██░░░░░░░░░░██──██░░██─██░░████░░░░██─██░░██████████─
─██░░██──██░░██───██░░██───██░░██████░░██──██░░██─██░░██──██░░██─██░░██─────────
─██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██░░██████████─
─██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██░░░░░░░░░░██─
─██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██████████░░██─
─██░░░░██░░░░██───██░░██───██░░██──██░░██████░░██─██░░██──██░░██─────────██░░██─
─████░░░░░░████─████░░████─██░░██──██░░░░░░░░░░██─██░░████░░░░██─██████████░░██─
───████░░████───██░░░░░░██─██░░██──██████████░░██─██░░░░░░░░████─██░░░░░░░░░░██─
─────██████─────██████████─██████──────────██████─████████████───██████████████─
────────────────────────────────────────────────────────────────────────────────
Discord: V1NDs#0977
Youtube: https://www.youtube.com/channel/UCaBZGvYryg09IS-uaSHyfPw
Github: https://github.com/V1NDs
]]--

--==vRP connection==--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")
--===================================--

--==Configs==--
local cfg = module(GetCurrentResourceName(), "cfg/config")
--===================================--

--==Variables==--
local access = nil
--===================================--

--==Events==--
RegisterServerEvent("V1N_Radio:checkRank", function(channel)
    local source = source
    local user_id = vRP.getUserId({source})
    local jobs = vRP.getUserDataTable({user_id})

    if cfg.permissions[channel] ~= nil then
        for k,v in pairs(cfg.permissions[channel]) do
            if jobs["groups"][v] ~= nil then
                TriggerClientEvent("V1N_Radio:addToChannel", source, user_id, channel)
                access = true
                return
            end
        end

        access = false
    else
        TriggerClientEvent("V1N_Radio:addToChannel", source, user_id, channel)
    end

    if not access then
        if cfg.notification ~= "" then
            if cfg.notification == "pNotify" then
                TriggerClientEvent("pNotify:SendNotification", source, { text = "Du har ikke adgang til radio kanal "..channel, type = "error", queue = "global", timeout = 4000, layout = "centerRight", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"} })
            else
                TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "error", text = "Du har ikke adgang til radio kanal "..channel, duration = 4000})
            end
        end
    end
end)
--===================================--
