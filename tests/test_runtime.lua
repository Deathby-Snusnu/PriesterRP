-- SPDX-License-Identifier: MPL-2.0
-- Source-only PriesterRP regression harness (Lua 5.1 or 5.4).
-- Run from addons/PriesterRP: lua tests/test_runtime.lua
local root = (arg and arg[0] or "tests/test_runtime.lua"):gsub("\\", "/")
root = root:match("^(.*)tests/test_runtime%.lua$") or "./"
local state = { class="PRIEST", race="Dwarf", target="Trainingspuppe",
    hostile=true, now=100, sent={}, messages={}, timers={} }
local env = {assert=assert, error=error, ipairs=ipairs, pairs=pairs, select=select,
    tostring=tostring, tonumber=tonumber, type=type, next=next, string=string,
    table=table, math={}, print=function(m) state.messages[#state.messages+1]=m end}
for k,v in pairs(math) do env.math[k] = v end
env.math.random = function(limit) return 1 end
env._G = env
env.SlashCmdList = {}
env.UnitClass = function() return "Priest", state.class end
env.UnitRace = function() return "Dwarf", state.race end
env.UnitExists = function(unit) return unit=="target" and state.target~=nil end
env.UnitCanAttack = function() return state.hostile end
env.UnitCanAssist = function() return not state.hostile end
env.UnitIsUnit = function(a,b) return a=="target" and b=="player" and state.target=="Bromli" end
env.UnitName = function(unit) return unit=="player" and "Bromli" or state.target end
env.GetTime = function() return state.now end
env.IsInGroup = function() return false end
env.UnitAffectingCombat = function() return false end
env.C_Timer = {After=function(seconds, callback)
    state.timers[#state.timers + 1] = {seconds=seconds, callback=callback}
end}
env.IsInRaid = function() return false end
env.C_ChatInfo = {SendChatMessage=function(line, channel, languageID)
    state.sent[#state.sent+1] = {line=line, channel=channel, languageID=languageID}
end}
env.CreateFrame = function()
    local obj={events={}, scripts={}}
    function obj:RegisterEvent(name) self.events[name]=true end
    function obj:SetScript(name, callback) self.scripts[name]=callback end
    state.frame=obj
    return obj
end

local function loadInEnv(filename)
    local chunk, why
    if setfenv then
        chunk, why=loadfile(root..filename)
        assert(chunk, why)
        setfenv(chunk, env)
    else
        chunk, why=loadfile(root..filename, "t", env)
        assert(chunk, why)
    end
    return chunk
end
local addon={}
local toc=assert(io.open(root.."PriesterRP.toc","r"))
for line in toc:lines() do
    line=line:match("^%s*(.-)%s*$")
    if line~="" and line:sub(1,1)~="#" then
        loadInEnv(line:gsub("\\","/"))("PriesterRP",addon)
    end
end
toc:close()
assert(type(env.SlashCmdList.PRIESTERRP)=="function", "slash handler missing")
state.frame.scripts.OnEvent(state.frame, "PLAYER_LOGIN")
assert(addon.ready and addon.db and addon.db.outputLanguage=="deDE")
assert(addon.db.textChance==30)
assert(addon.db.cooldown==20)
assert(addon.db.ambientChance==70)
assert(addon.db.ambientMinInterval==180 and addon.db.ambientMaxInterval==420)
assert(addon.db.ambientEnabled==true)
assert(type(addon.ResetAmbientTimer)=="function")
addon.db.racialTextChance=0

local function noTarget(key)
    local line = assert(addon.BuildText(key), "missing " .. key)
    assert(not line:find(state.target,1,true), key .. " leaked target")
end
for _,key in ipairs({"HOLY_NOVA","PRAYER_OF_HEALING","INNER_FIRE",
    "FADE","PSYCHIC_SCREAM","SHADOWFORM","LEVITATE"}) do
    noTarget(key)
end
-- Force the second pool entry, which is allowed to mention a legal target.
local defaultRandom = env.math.random
env.math.random = function(n) if n == 100 then return 1 else return math.min(2,n) end end
assert(addon.BuildText("SMITE"):find("Trainingspuppe",1,true),
    "harmful directed spell should name a hostile target")
state.hostile=false
noTarget("SMITE")
state.target="Verbuendeter"
assert(addon.BuildText("RENEW"):find("Verbuendeter",1,true),
    "friendly spell should name a friendly target")
state.hostile=true
noTarget("RENEW")
state.target="Trainingspuppe"
env.math.random = defaultRandom
local required={"POWER_WORD_SHIELD","RENEW","PENANCE","HOLY_NOVA",
    "SHADOW_WORD_PAIN","SHADOW_WORD_DEATH","SHADOWFORM","LIGHTWELL_RENEW"}
for _,lang in ipairs({"deDE","enUS","frFR"}) do
    addon.db.outputLanguage=lang
    for _,key in ipairs(required) do
        assert(addon.localeData[lang].texts[key], lang .. " lacks " .. key)
        assert(addon.BuildText(key), lang .. " cannot build " .. key)
    end
end

addon.db.outputLanguage="deDE"
env.RPChatMod={GetChatLanguageID=function() return 6 end}
assert(addon.SendText("Vorwärts!"))
assert(state.sent[#state.sent].languageID==6, "shared language policy ignored")
assert(addon.SendText("*hebt den Schild.*"))
assert(state.sent[#state.sent].channel=="EMOTE")
assert(state.sent[#state.sent].line=="hebt den Schild.")
assert(state.sent[#state.sent].languageID==nil)
addon.db.textChance=0
assert(not addon.TryText("SMITE"), "chance 0 should suppress text")
addon.db.textChance=100
state.class="MAGE"
assert(not addon.TryText("SMITE"), "other classes should not speak priest texts")
state.class="PRIEST"
assert(addon.TryText("SMITE"), "priest text should be sent")
assert(#state.sent==3)
-- Timer callbacks must never send chat. They only set a pending flag.
addon.db.ambientChance=100
addon.db.cooldown=0
state.now=200 -- last actual send started the previous default 20s cooldown
addon.ResetAmbientTimer()
assert(#state.timers > 0)
local lastTimer=state.timers[#state.timers].callback
local before=#state.sent
lastTimer()
assert(#state.sent==before, "timer sent chat without a player action")
assert(addon.HasPendingAmbient(), "timer did not queue ambient")
assert(addon.TryText("POWER_WORD_SHIELD"), "queued ambient should flush on action")
assert(#state.sent==before+1 and not addon.HasPendingAmbient())
addon.ResetAmbientTimer()
state.timers[#state.timers].callback()
assert(addon.HasPendingAmbient())
addon.db.textChance=30
local originalRandom=env.math.random
local randomCalls=0
env.math.random=function()
    randomCalls=randomCalls+1
    return randomCalls==1 and 31 or 1
end
local pendingSent=#state.sent
assert(not addon.TryText("POWER_WORD_SHIELD"), "failed ambient chance must not reroll ability text")
assert(#state.sent==pendingSent and addon.HasPendingAmbient())
assert(randomCalls==1, "RP action should roll global text chance only once")
env.math.random=originalRandom
addon.db.textChance=0
local muted=#state.sent
assert(not addon.TryText("POWER_WORD_SHIELD"), "chance 0 must mute queued ambient and ability text")
assert(#state.sent==muted and not addon.HasPendingAmbient())
addon.db.textChance=100
-- Turning ambient off must invalidate stale timers and discard queued lines.
addon.ResetAmbientTimer()
local stale=state.timers[#state.timers].callback
addon.db.ambientEnabled=false
addon.ResetAmbientTimer()
local stopped=#state.sent
stale()
assert(#state.sent==stopped and not addon.HasPendingAmbient())
assert(addon.TryAmbient(nil,true), "manual ambient should work when automatic is off")
-- Rich list and diagnosis commands must be available.
env.SlashCmdList.PRIESTERRP("list racial")
env.SlashCmdList.PRIESTERRP("list all")
env.SlashCmdList.PRIESTERRP("status")
env.SlashCmdList.PRIESTERRP("debug")
env.SlashCmdList.PRIESTERRP("ambient interval 180 420")
assert(addon.db.ambientMinInterval==180 and addon.db.ambientMaxInterval==420)
env.SlashCmdList.PRIESTERRP("ambient on")
assert(addon.db.ambientEnabled)
env.SlashCmdList.PRIESTERRP("ambient off")
assert(not addon.db.ambientEnabled)
print("PriesterRP runtime smoke checks passed.")
