-- -----------------------------------------------------------------------------
-- Init.lua
-- -----------------------------------------------------------------------------

--- @class (partial) CruxCounter
local CC    = CruxCounter
local M     = {}
local EM    = GetEventManager()

--- @type integer Crux ability ID
M.abilityId = 184220

--- Build namespace for events
--- @param event string Name of the event
--- @return string namespace Addon-specific event namespace
local function getEventNamespace(event)
    return CC.Addon.name .. event
end

--- Respond to effect changes.
--- @see EVENT_EFFECT_CHANGED
--- @param eventId integer
--- @param changeType EffectResult
--- @param effectSlot integer
--- @param effectName string
--- @param unitTag string
--- @param beginTime number
--- @param endTime number
--- @param stackCount integer
--- @param iconName string
--- @param deprecatedBuffType string
--- @param effectType BuffEffectType
--- @param abilityType AbilityType
--- @param statusEffectType StatusEffectType
--- @param unitName string
--- @param unitId integer
--- @param abilityId integer
--- @param sourceType CombatUnitType
local function onEffectChanged(eventId, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount,
                               iconName, deprecatedBuffType, effectType, abilityType, statusEffectType, unitName, unitId,
                               abilityId, sourceType)
    if changeType == EFFECT_RESULT_FADED then
        CC.State:ClearStacks()
        return
    end

    CC.State:SetStacks(stackCount)
end

--- Update combat state
--- @param eventId integer
--- @param inCombat boolean Whether or not the player is in combat
--- @return nil
local function onCombatChanged(eventId, inCombat)
    CC.State:SetInCombat(inCombat)

    if CC.Settings:Get("hideOutOfCombat") and not inCombat then
        CruxCounter_Display:RemoveSceneFragments()
    else
        CruxCounter_Display:AddSceneFragments()
    end
end

--- Respond to player life/death/zone/load changes.
--- Note: Sound playback skipped for these stack transitions
--- @return nil
local function onPlayerChanged()
    if CC.arcanistActive() == false then -- NEW u46
        CruxCounter_Display:RemoveSceneFragments()
        return
    end

    M:UpdateCombatState()

    for i = 1, GetNumBuffs("player") do
        --- buffIndex wants luaindex so passing integer emits a warning
        --- @diagnostic disable-next-line: param-type-mismatch
        local _, _, _, _, stackCount, _, _, _, _, _, abilityId = GetUnitBuffInfo("player", i)
        if abilityId == M.abilityId then
            -- stackCount is seen as type `stackCount`, but should be `integer`
            -- fix in annotation
            CC.State:SetStacks(stackCount --[[@as integer]], false)

            return
        end
    end

    -- No Crux in player buffs
    CC.State:SetStacks(0, false)
end

--- Update combat state with current value
--- @return nil
function M:UpdateCombatState()
    onCombatChanged(nil, IsUnitInCombat("player") --[[@as boolean]])
end

--- Wrap EVENT_MANAGER:RegisterForEvent function
--- @param namespace string Unique event namespace
--- @param event any Event to filter
--- @param callbackFunc function Execute function on event trigger
--- @return nil
function M:Listen(namespace, event, callbackFunc)
    EM:RegisterForEvent(getEventNamespace(namespace), event, callbackFunc)
end

--- Wrap EVENT_MANAGER:UnregisterForEvent function
--- @param namespace string Unique event namespace
--- @param event any Event to filter
--- @return nil
function M:Unlisten(namespace, event)
    EM:UnregisterForEvent(getEventNamespace(namespace), event)
end

--- Wrap EVENT_MANAGER:AddFilterForEvent function
--- @param namespace string Unique event namespace
--- @param event any Event to filter
--- @param filterType integer Type of filter
--- @param filterValue any Value to filter
--- @param ... any Additional filters
--- @return nil
function M:AddFilter(namespace, event, filterType, filterValue, ...)
    EM:AddFilterForEvent(getEventNamespace(namespace), event, filterType, filterValue, ...)
end

--- Register to receive combat state transitions
--- @return nil
function M:RegisterForCombat()
    self:UpdateCombatState()
    self:Listen("CombatState", EVENT_PLAYER_COMBAT_STATE, onCombatChanged)
end

--- Unregister listening for combat state transitions
--- @return nil
function M:UnregisterForCombat()
    self:Unlisten("CombatState", EVENT_PLAYER_COMBAT_STATE)
    self:UpdateCombatState()
end

--- Registers event manager events.
--- @return nil
function M:RegisterEvents()
    CC.Debug:Trace(2, "Registering events...")

    -- Ability updates
    self:Listen("EffectChanged", EVENT_EFFECT_CHANGED, onEffectChanged)
    self:AddFilter(
        "EffectChanged",
        EVENT_EFFECT_CHANGED,
        REGISTER_FILTER_ABILITY_ID, self.abilityId,
        REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER
    )
    self:Listen("SkillsFullUpdate", EVENT_SKILLS_FULL_UPDATE, function()
        CC.Debug:Trace(1, "SkillsFullUpdate event fired")
        if CC.arcanistActive() == false then -- NEW u46
            CC.Debug:Trace(1, "Arcanist not active, removing scene fragments")
            CruxCounter_Display:RemoveSceneFragments()
            return
        end
    end)

    self:Listen("ArmoryRestoreResponse", EVENT_ARMORY_BUILD_RESTORE_RESPONSE, function(eventId, result, buildIndex)
        CC.Debug:Trace(1, "ArmoryRestoreResponse event fired, result: " .. tostring(result))
        if CC.arcanistActive() == false then -- NEW u46
            CC.Debug:Trace(1, "Arcanist not active, removing scene fragments")
            CruxCounter_Display:RemoveSceneFragments()
        else
            CC.Debug:Trace(1, "Arcanist active, adding scene fragments")
            CruxCounter_Display:AddSceneFragments()
            return
        end
    end)

    -- Life or death
    self:Listen("PlayerDead", EVENT_PLAYER_DEAD, onPlayerChanged)
    self:Listen("PlayerAlive", EVENT_PLAYER_ALIVE, onPlayerChanged)

    -- Zone change or load
    self:Listen("PlayerActivated", EVENT_PLAYER_ACTIVATED, onPlayerChanged)
    self:Listen("ZoneUpdated", EVENT_ZONE_UPDATE, onPlayerChanged)

    -- Combat state
    if CC.Settings:Get("hideOutOfCombat") then
        self:RegisterForCombat()
    end
end

CC.Events = M
