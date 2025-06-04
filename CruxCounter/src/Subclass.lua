-- -----------------------------------------------------------------------------
-- Subclass.lua - by notnear tweaked by dack_janiels
-- -----------------------------------------------------------------------------

--- @class (partial) CruxCounter
local CC = CruxCounter

--- Is the player's current class an Arcanist?
--- @return boolean
local function isArcanist()
    local arcanistClassId = 117
    return GetUnitClassId("player") == arcanistClassId
end

local arcanistSkillLines = {
    [218] = true, -- "Herald of the Tome"
    [219] = true, -- "Soldier of Apocrypha"
    [220] = true, -- "Curative Runeforms"
}

function CC.arcanistActive()
    if isArcanist() then return true end

    for skillLineId in pairs(arcanistSkillLines) do
        local skillLineData = SKILLS_DATA_MANAGER:GetSkillLineDataById(skillLineId)
        if skillLineData and skillLineData:IsActive() then
            return true
        end
    end
    return false
end
