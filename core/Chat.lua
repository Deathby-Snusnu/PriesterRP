-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
local supported = {SAY=true, YELL=true, PARTY=true, RAID=true, INSTANCE_CHAT=true, AUTO=true}
local function channel()
    local value = addon.db.chatChannel or "SAY"
    if not supported[value] then return nil end
    if value ~= "AUTO" then
        if value == "PARTY" and (not IsInGroup or not IsInGroup()) then return nil end
        if value == "RAID" and (not IsInRaid or not IsInRaid()) then return nil end
        if value == "INSTANCE_CHAT" and
            (not IsInGroup or not LE_PARTY_CATEGORY_INSTANCE or not IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then return nil end
        return value
    end
    if IsInGroup and LE_PARTY_CATEGORY_INSTANCE and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        return "INSTANCE_CHAT"
    end
    if IsInRaid and IsInRaid() then return "RAID" end
    if IsInGroup and IsInGroup() then return "PARTY" end
    return "SAY"
end
function addon.SendText(text)
    if type(text) ~= "string" or text == "" then return false end
    local a, b = text:sub(1, 1) == "*", text:sub(-1) == "*"
    if a ~= b then return false end
    local emote = a and b
    if emote then text = text:sub(2, -2) end
    text = text:match("^%s*(.-)%s*$")
    if text == "" or #text > 255 or text:find("[\r\n]") or text:find("|", 1, true) then
        return false
    end
    local destination = emote and "EMOTE" or channel()
    if not destination then return false end
    local languageID
    if destination == "SAY" or destination == "YELL" then
        local rpChat = _G.RPChatMod
        if type(rpChat) == "table" and type(rpChat.GetChatLanguageID) == "function" then
            languageID = rpChat.GetChatLanguageID(destination)
        end
    end
    if C_ChatInfo and type(C_ChatInfo.SendChatMessage) == "function" then
        C_ChatInfo.SendChatMessage(text, destination, languageID)
    elseif type(SendChatMessage) == "function" then
        SendChatMessage(text, destination, languageID)
    else
        return false
    end
    return true
end
