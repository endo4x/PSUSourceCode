--[[
	id: D1JgTh9wWLzRKvx5ijda5
	name: Test
	description: Test
	time1: 2021-07-06 21:02:08.550394+00
	time2: 2021-07-06 21:02:08.550396+00
	uploader: HSvFv1RuHFK6Sdiqy2ukvEvOnOtddUME3WnUX9k-
	uploadersession: 9hqteYa9BQeUFbcsqjj_mkjK33zUaQ
	flag: f
--]]


local ColourUpdateFrame = CreateFrame("Frame")
local init
local mainColourBar = {}
local EWowFunctions = {}
local ENameFrames = {}
local EPositionFrames = {}
local ELevelFrames = {}
local EPlayerFrame = {}
local EUtils = {}
local EConstants = {}

function EWowFunctions:GetCurrentPlayerPosition()
    local map = C_Map.GetBestMapForUnit("player")
    local position = C_Map.GetPlayerMapPosition(map, "player")

    if position == nil then
        return 0, 0
    end

    return position:GetXY()
end

function EWowFunctions:getPlayerLevel()
    return UnitLevel("player")
end

function EWowFunctions:getTargetLevel()
    return UnitLevel("target")
end

function EWowFunctions:getPlayerMaxPower()
    return UnitPowerMax("player")
end

function EWowFunctions:getPlayerMaxMana()
    return UnitPowerMax("player", 0)
end

function EWowFunctions:getPlayerMaxRage()
    return UnitPowerMax("player", 1)
end

function EWowFunctions:getPlayerMaxFocus()
    return UnitPowerMax("player", 2)
end

function EWowFunctions:getPlayerMaxEnergy()
    return UnitPowerMax("player", 3)
end

function EWowFunctions:getPlayerMaxComboPoints()
    return UnitPowerMax("player", 4)
end

function EWowFunctions:getPlayerMaxRunes()
    return UnitPowerMax("player", 5)
end

function EWowFunctions:getPlayerMaxRunicPower()
    return UnitPowerMax("player", 6)
end

function EWowFunctions:getPlayerMaxSoulShards()
    return UnitPowerMax("player", 7)
end

function EWowFunctions:getPlayerMaxLunarPower()
    return UnitPowerMax("player", 8)
end

function EWowFunctions:getPlayerMaxHolyPower()
    return UnitPowerMax("player", 9)
end

function EWowFunctions:getPlayerMaxMaelStromPower()
    return UnitPowerMax("player", 11)
end

function EWowFunctions:getPlayerMaxChiPower()
    return UnitPowerMax("player", 12)
end

function EWowFunctions:getPlayerMaxInsanityPower()
    return UnitPowerMax("player", 13)
end

function EWowFunctions:getPlayerMaxArcanePower()
    return UnitPowerMax("player", 16)
end

function EWowFunctions:getPlayerMaxFuryPower()
    return UnitPowerMax("player", 17)
end

function EWowFunctions:getPlayerMaxPainPower()
    return UnitPowerMax("player", 18)
end

function EWowFunctions:getPlayerCurrentPower()
    return UnitPower("player")
end

function EWowFunctions:getPlayerCurrentMana()
    return UnitPower("player", 0)
end

function EWowFunctions:getPlayerCurrentRage()
    return UnitPower("player", 1)
end

function EWowFunctions:getPlayerCurrentFocus()
    return UnitPower("player", 2)
end

function EWowFunctions:getPlayerCurrentEnergy()
    return UnitPower("player", 3)
end

function EWowFunctions:getPlayerCurrentComboPoints()
    return UnitPower("player", 4)
end

function EWowFunctions:getPlayerCurrentRunes()
    return UnitPower("player", 5)
end

function EWowFunctions:getPlayerCurrentRunicPower()
    return UnitPower("player", 6)
end

function EWowFunctions:getPlayerCurrentSoulShards()
    return UnitPower("player", 7)
end

function EWowFunctions:getPlayerCurrentLunarPower()
    return UnitPower("player", 8)
end

function EWowFunctions:getPlayerCurrentHolyPower()
    return UnitPower("player", 9)
end

function EWowFunctions:getPlayerCurrentMaelStromPower()
    return UnitPower("player", 11)
end

function EWowFunctions:getPlayerCurrentChiPower()
    return UnitPower("player", 12)
end

function EWowFunctions:getPlayerCurrentInsanityPower()
    return UnitPower("player", 13)
end

function EWowFunctions:getPlayerCurrentArcanePower()
    return UnitPower("player", 16)
end

function EWowFunctions:getPlayerCurrentFuryPower()
    return UnitPower("player", 17)
end

function EWowFunctions:getPlayerCurrentPainPower()
    return UnitPower("player", 18)
end

function EWowFunctions:getPlayerSpellHaste()
    return UnitSpellHaste("player")
end

function EWowFunctions:IsPlayerMoving()
    return ((GetUnitSpeed("Player") / 7) * 100) > 0
end

function EWowFunctions:IsPlayerPvpFlagged()
    return UnitIsPVP("player");
end

function EWowFunctions:IsPlayerInCombat()
    return UnitAffectingCombat("player");
end

function EWowFunctions:IsPlayerAutoAttacking()
    return IsCurrentSpell(6603)
end

function EWowFunctions:GetPlayerSpecialization()
    return GetSpecialization()
end

function EWowFunctions:GetPlayerRaceId()
    local race, raceEn, id = UnitRace("player");
    if race and id then
        return id
    end

    return 0
end

function EWowFunctions:GetUnitHealth(unit)
    local health = UnitHealth(unit);
    if health then
        return health
    end

    return 0
end

function EWowFunctions:GetUnitMaxHealth(unit)
    local max = UnitHealthMax(unit);
    if max then
        return max
    end

    return 0
end

function EWowFunctions:GetUnitIsDeadOrGhost(unit)
    return UnitIsDeadOrGhost(unit)
end

function EWowFunctions:IsPlayerMounted()
    return IsMounted()
end

function EWowFunctions:HasPlayerGotPetUI()
    local hasUI, _ = HasPetUI();
    if hasUI then
        return true
    end

    return false
end

function EWowFunctions:GetPlayerPetMaxEnergy()
    return UnitPowerMax("pet", 2)
end

function EWowFunctions:GetPlayerPetCurrentEnergy()
    return UnitPower("pet", 2)
end

function EWowFunctions:getUnitMaxPower(unit, powerType)
    return UnitPowerMax(unit, powerType)
end

function EWowFunctions:getUnitCurrentPower(unit, powerType)
    return UnitPower(unit, powerType)
end

function EWowFunctions:GetUnitInCombat(unit)
    return UnitAffectingCombat(unit);
end

function EWowFunctions:GetUnitClass(unit)
    local className, classFilename, classId = UnitClass(unit)
    if className then
        return classId
    end

    return 0
end

function EWowFunctions:IsPlayerOutDoor()
    return IsOutdoors()
end

function EWowFunctions:IsPlayerInRaid()
    return IsInRaid()
end

function EWowFunctions:IsPlayerInParty()
    return not IsInRaid() and GetNumGroupMembers() > 0
end

function EWowFunctions:IsPlayerInVehicle()
    return UnitInVehicle("player")
end

function EWowFunctions:getPlayerCurrentRuneCooldown(runeIndex)
    local start, duration, runeReady = GetRuneCooldown(runeIndex)
    if start then
        local timeLeft = start + duration - GetTime()
        if not runeReady then
            if timeLeft >= 0 then
                return timeLeft
            end
        end
    end

    return 0.0
end


function EWowFunctions:GetName(partition, subStart, subEnd, unit)
    local target = GetUnitName(unit)
    if target then
        if subStart and subEnd and subStart == 13 and string.len(target) > 12 then
            target = string.sub(target, subStart, subEnd)
        elseif subStart and subEnd and subStart == 7 and string.len(target) > 6 then
            target = string.sub(target, subStart, subEnd)
        elseif subStart and subEnd and string.len(target) <= 18 then
            return 0
        end

        if target ~= nil then
            target = EUtils:StringToASCIIHex(target)
            if partition < 3 then
                return tonumber(string.sub(target, 0, 6))
            else
                if target > 999999 then
                    return tonumber(string.sub(target, 7, 12))
                end
            end
            return 0
        end
    end
    return 0
end

local rotationUpdateInterval = 0.05
ColourUpdateFrame.timeSinceLastUpdate = 0;
ColourUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
    if not init then
        init = 1
        print("Test")
        self:CreateFrames()
    else
        self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed;
        if self.timeSinceLastUpdate >= rotationUpdateInterval then
            ENameFrames:UpdateNameFrames()
            EPositionFrames:UpdatePositionFrames()
            ELevelFrames:UpdateLevelFrames()
            EPlayerFrame:UpdatePlayerMiscFrames()

            local np = C_NamePlate
            for _, v in pairs(np.GetNamePlates()) do
                if np.GetNamePlateForUnit(v.namePlateUnitToken.."target") == np.GetNamePlateForUnit("player") then
                end
            end

            self.timeSinceLastUpdate = self.timeSinceLastUpdate - rotationUpdateInterval
        end
    end
end)

local function createMainColourBar()
    local scaleForColourBar = GetScreenWidth() / GetPhysicalScreenSize()
    mainColourBar = CreateFrame("Frame", "End", UIParent)
    mainColourBar:SetSize(1900, 1)
    mainColourBar:SetPoint("TOPLEFT", 0, 0)
    mainColourBar.t = mainColourBar:CreateTexture()
    mainColourBar.t:SetColorTexture(0, 0, 0, 1)
    mainColourBar.t:SetAllPoints(mainColourBar)
    mainColourBar:SetScale(scaleForColourBar)
    mainColourBar:RegisterEvent("ADDON_LOADED")
    mainColourBar:RegisterEvent("PLAYER_ENTERING_WORLD")
    mainColourBar:RegisterEvent("UNIT_SPELLCAST_SENT")
    mainColourBar:RegisterEvent("UI_ERROR_MESSAGE")
    mainColourBar:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    mainColourBar:RegisterEvent("LOSS_OF_CONTROL_ADDED")
    mainColourBar:RegisterEvent("LOSS_OF_CONTROL_UPDATE")
    mainColourBar:RegisterEvent("PLAYER_LOGOUT")
    mainColourBar:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    mainColourBar:SetFrameStrata("TOOLTIP")
end

function ColourUpdateFrame:CreateFrames()
    createMainColourBar()
    ENameFrames:CreatePlayerNameFrames()
    ENameFrames:CreateTargetNameFrames()
    EPositionFrames:CreatePlayerPositionFrames()
    ELevelFrames:CreateLevelFrames()
    EPlayerFrame:CreatePlayerMiscFrames()
end

local playerMaxPowerFrame, playerCurrentPowerFrame = {}
local playerMaxManaFrame, playerMaxRageFrame, playerMaxFocusFrame, playerMaxEnergyFrame, playerMaxComboPointsFrame, playerMaxRunesFrame,
playerMaxRunicPowerFrame, playerMaxSoulShardsFrame, playerMaxLunarFrame, playerMaxHolyFrame, playerMaxMaelstromFrame,
playerMaxChiFrame, playerMaxInsanityFrame, playerMaxArcanePowerFrame, playerMaxFuryFrame, playerMaxPainFrame = {}

local playerCurrentManaFrame, playerCurrentRageFrame, playerCurrentFocusFrame, playerCurrentEnergyFrame, playerCurrentComboPointsFrame, playerCurrentRunesFrame,
playerCurrentRunicPowerFrame, playerCurrentSoulShardsFrame, playerCurrentLunarFrame, playerCurrentHolyFrame, playerCurrentMaelstromFrame,
playerCurrentChiFrame, playerCurrentInsanityFrame, playerCurrentArcanePowerFrame, playerCurrentFuryFrame, playerCurrentPainFrame = {}

local playerRuneCoolDown1Frame, playerRuneCoolDown2Frame, playerRuneCoolDown3Frame, playerRuneCoolDown4Frame, playerRuneCoolDown5Frame, playerRuneCoolDown6Frame = {}

local playerSpellHasteFrame, playerIsMovingFrame, playerIsInPvpFlaggedFrame, playerIsInCombatFrame, playerIsAutoAttackingFrame,
playerSpecializationFrame, playerRaceIdFrame, playerHealthFrame, playerMaxHealthFrame = {}

local playerIsDeadOrGhostFrame, playerIsMountedFrame, playerCurrentClassFrame, playerOutDoorFrame, playerInRaidFrame, playerInPartyFrame, playerInVehicleFrame = {}

local playerHasPetUIFrame, playerPetMaxEnergyFrame, playerPetCurrentEnergy, playerPetMaxManaFrame, playerPetCurrentManaFrame,
playerPetCurrentHealthFrame, playerPetMaxHealthFrame, playerPetIsInCombatFrame = {}

local PlayerFunctions = {}

function PlayerFunctions:CreatePlayerMaxPowerFrame()
    local power = EWowFunctions:getPlayerMaxPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxPowerFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxPowerFrame:SetSize(1, 1);
    playerMaxPowerFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxPower, 0)
    playerMaxPowerFrame.t = playerMaxPowerFrame:CreateTexture()
    playerMaxPowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxPowerFrame.t:SetAllPoints(playerMaxPowerFrame)
    playerMaxPowerFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxPower()
    local power = EWowFunctions:getPlayerMaxPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxPowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentPowerFrame()
    local power = EWowFunctions:getPlayerCurrentPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentPowerFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentPowerFrame:SetSize(1, 1);
    playerCurrentPowerFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentPower, 0)
    playerCurrentPowerFrame.t = playerCurrentPowerFrame:CreateTexture()
    playerCurrentPowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentPowerFrame.t:SetAllPoints(playerCurrentPowerFrame)
    playerCurrentPowerFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentPower()
    local power = EWowFunctions:getPlayerCurrentPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentPowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxManaFrame()
    local power = EWowFunctions:getPlayerMaxMana()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxManaFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxManaFrame:SetSize(1, 1);
    playerMaxManaFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxMana, 0)
    playerMaxManaFrame.t = playerMaxManaFrame:CreateTexture()
    playerMaxManaFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxManaFrame.t:SetAllPoints(playerMaxManaFrame)
    playerMaxManaFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxMana()
    local power = EWowFunctions:getPlayerMaxMana()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxManaFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxRageFrame()
    local power = EWowFunctions:getPlayerMaxRage()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxRageFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxRageFrame:SetSize(1, 1);
    playerMaxRageFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxRage, 0)
    playerMaxRageFrame.t = playerMaxRageFrame:CreateTexture()
    playerMaxRageFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxRageFrame.t:SetAllPoints(playerMaxRageFrame)
    playerMaxRageFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxRage()
    local power = EWowFunctions:getPlayerMaxRage()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxRageFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxFocusFrame()
    local power = EWowFunctions:getPlayerMaxFocus()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxFocusFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxFocusFrame:SetSize(1, 1);
    playerMaxFocusFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxFocus, 0)
    playerMaxFocusFrame.t = playerMaxFocusFrame:CreateTexture()
    playerMaxFocusFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxFocusFrame.t:SetAllPoints(playerMaxFocusFrame)
    playerMaxFocusFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxFocus()
    local power = EWowFunctions:getPlayerMaxFocus()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxFocusFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxEnergyFrame()
    local power = EWowFunctions:getPlayerMaxEnergy()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxEnergyFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxEnergyFrame:SetSize(1, 1);
    playerMaxEnergyFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxEnergy, 0)
    playerMaxEnergyFrame.t = playerMaxEnergyFrame:CreateTexture()
    playerMaxEnergyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxEnergyFrame.t:SetAllPoints(playerMaxEnergyFrame)
    playerMaxEnergyFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxEnergy()
    local power = EWowFunctions:getPlayerMaxEnergy()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxEnergyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxComboPointsFrame()
    local power = EWowFunctions:getPlayerMaxComboPoints()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxComboPointsFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxComboPointsFrame:SetSize(1, 1);
    playerMaxComboPointsFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxComboPoints, 0)
    playerMaxComboPointsFrame.t = playerMaxComboPointsFrame:CreateTexture()
    playerMaxComboPointsFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxComboPointsFrame.t:SetAllPoints(playerMaxComboPointsFrame)
    playerMaxComboPointsFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxComboPoints()
    local power = EWowFunctions:getPlayerMaxComboPoints()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxComboPointsFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxRunesFrame()
    local power = EWowFunctions:getPlayerMaxRunes()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxRunesFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxRunesFrame:SetSize(1, 1);
    playerMaxRunesFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxRunes, 0)
    playerMaxRunesFrame.t = playerMaxRunesFrame:CreateTexture()
    playerMaxRunesFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxRunesFrame.t:SetAllPoints(playerMaxRunesFrame)
    playerMaxRunesFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxRunes()
    local power = EWowFunctions:getPlayerMaxRunes()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxRunesFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxRunicFrame()
    local power = EWowFunctions:getPlayerMaxRunicPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxRunicPowerFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxRunicPowerFrame:SetSize(1, 1);
    playerMaxRunicPowerFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxRunic, 0)
    playerMaxRunicPowerFrame.t = playerMaxRunicPowerFrame:CreateTexture()
    playerMaxRunicPowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxRunicPowerFrame.t:SetAllPoints(playerMaxRunicPowerFrame)
    playerMaxRunicPowerFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxRunic()
    local power = EWowFunctions:getPlayerMaxRunicPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxRunicPowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxSoulShardsFrame()
    local power = EWowFunctions:getPlayerMaxSoulShards()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxSoulShardsFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxSoulShardsFrame:SetSize(1, 1);
    playerMaxSoulShardsFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxSoulShards, 0)
    playerMaxSoulShardsFrame.t = playerMaxSoulShardsFrame:CreateTexture()
    playerMaxSoulShardsFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxSoulShardsFrame.t:SetAllPoints(playerMaxSoulShardsFrame)
    playerMaxSoulShardsFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxSoulShards()
    local power = EWowFunctions:getPlayerMaxSoulShards()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxSoulShardsFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxLunarFrame()
    local power = EWowFunctions:getPlayerMaxLunarPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxLunarFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxLunarFrame:SetSize(1, 1);
    playerMaxLunarFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxLunar, 0)
    playerMaxLunarFrame.t = playerMaxLunarFrame:CreateTexture()
    playerMaxLunarFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxLunarFrame.t:SetAllPoints(playerMaxLunarFrame)
    playerMaxLunarFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxLunar()
    local power = EWowFunctions:getPlayerMaxLunarPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxLunarFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxHolyPowerFrame()
    local power = EWowFunctions:getPlayerMaxHolyPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxHolyFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxHolyFrame:SetSize(1, 1);
    playerMaxHolyFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxHoly, 0)
    playerMaxHolyFrame.t = playerMaxHolyFrame:CreateTexture()
    playerMaxHolyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxHolyFrame.t:SetAllPoints(playerMaxHolyFrame)
    playerMaxHolyFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxHolyPower()
    local power = EWowFunctions:getPlayerMaxHolyPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxHolyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxMaelstromFrame()
    local power = EWowFunctions:getPlayerMaxMaelStromPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxMaelstromFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxMaelstromFrame:SetSize(1, 1);
    playerMaxMaelstromFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxMaelestrom, 0)
    playerMaxMaelstromFrame.t = playerMaxMaelstromFrame:CreateTexture()
    playerMaxMaelstromFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxMaelstromFrame.t:SetAllPoints(playerMaxMaelstromFrame)
    playerMaxMaelstromFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxMaelstrom()
    local power = EWowFunctions:getPlayerMaxMaelStromPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxMaelstromFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxChiFrame()
    local power = EWowFunctions:getPlayerMaxChiPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxChiFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxChiFrame:SetSize(1, 1);
    playerMaxChiFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxChi, 0)
    playerMaxChiFrame.t = playerMaxChiFrame:CreateTexture()
    playerMaxChiFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxChiFrame.t:SetAllPoints(playerMaxChiFrame)
    playerMaxChiFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxChi()
    local power = EWowFunctions:getPlayerMaxChiPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxChiFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxInsanityFrame()
    local power = EWowFunctions:getPlayerMaxInsanityPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxInsanityFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxInsanityFrame:SetSize(1, 1);
    playerMaxInsanityFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxInsanity, 0)
    playerMaxInsanityFrame.t = playerMaxInsanityFrame:CreateTexture()
    playerMaxInsanityFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxInsanityFrame.t:SetAllPoints(playerMaxInsanityFrame)
    playerMaxInsanityFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxInsanity()
    local power = EWowFunctions:getPlayerMaxInsanityPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxInsanityFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxArcaneFrame()
    local power = EWowFunctions:getPlayerMaxArcanePower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxArcanePowerFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxArcanePowerFrame:SetSize(1, 1);
    playerMaxArcanePowerFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxArcane, 0)
    playerMaxArcanePowerFrame.t = playerMaxArcanePowerFrame:CreateTexture()
    playerMaxArcanePowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxArcanePowerFrame.t:SetAllPoints(playerMaxArcanePowerFrame)
    playerMaxArcanePowerFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxArcane()
    local power = EWowFunctions:getPlayerMaxArcanePower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxArcanePowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxFuryFrame()
    local power = EWowFunctions:getPlayerMaxFuryPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxFuryFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxFuryFrame:SetSize(1, 1);
    playerMaxFuryFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxFury, 0)
    playerMaxFuryFrame.t = playerMaxFuryFrame:CreateTexture()
    playerMaxFuryFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxFuryFrame.t:SetAllPoints(playerMaxFuryFrame)
    playerMaxFuryFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxFury()
    local power = EWowFunctions:getPlayerMaxFuryPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxFuryFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxPainFrame()
    local power = EWowFunctions:getPlayerMaxPainPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerMaxPainFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxPainFrame:SetSize(1, 1);
    playerMaxPainFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxPain, 0)
    playerMaxPainFrame.t = playerMaxPainFrame:CreateTexture()
    playerMaxPainFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerMaxPainFrame.t:SetAllPoints(playerMaxPainFrame)
    playerMaxPainFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxPain()
    local power = EWowFunctions:getPlayerMaxPainPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerMaxPainFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentManaFrame()
    local power = EWowFunctions:getPlayerCurrentMana()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentManaFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentManaFrame:SetSize(1, 1);
    playerCurrentManaFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentMana, 0)
    playerCurrentManaFrame.t = playerCurrentManaFrame:CreateTexture()
    playerCurrentManaFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentManaFrame.t:SetAllPoints(playerCurrentManaFrame)
    playerCurrentManaFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentMana()
    local power = EWowFunctions:getPlayerCurrentMana()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentManaFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentRageFrame()
    local power = EWowFunctions:getPlayerCurrentRage()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentRageFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentRageFrame:SetSize(1, 1);
    playerCurrentRageFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentRage, 0)
    playerCurrentRageFrame.t = playerCurrentRageFrame:CreateTexture()
    playerCurrentRageFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentRageFrame.t:SetAllPoints(playerCurrentRageFrame)
    playerCurrentRageFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentRage()
    local power = EWowFunctions:getPlayerCurrentRage()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentRageFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentFocusFrame()
    local power = EWowFunctions:getPlayerCurrentFocus()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentFocusFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentFocusFrame:SetSize(1, 1);
    playerCurrentFocusFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentFocus, 0)
    playerCurrentFocusFrame.t = playerCurrentFocusFrame:CreateTexture()
    playerCurrentFocusFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentFocusFrame.t:SetAllPoints(playerCurrentFocusFrame)
    playerCurrentFocusFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentFocus()
    local power = EWowFunctions:getPlayerCurrentFocus()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentFocusFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentEnergyFrame()
    local power = EWowFunctions:getPlayerCurrentEnergy()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentEnergyFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentEnergyFrame:SetSize(1, 1);
    playerCurrentEnergyFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentEnergy, 0)
    playerCurrentEnergyFrame.t = playerCurrentEnergyFrame:CreateTexture()
    playerCurrentEnergyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentEnergyFrame.t:SetAllPoints(playerCurrentEnergyFrame)
    playerCurrentEnergyFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentEnergy()
    local power = EWowFunctions:getPlayerCurrentEnergy()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentEnergyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentComboPointsFrame()
    local power = EWowFunctions:getPlayerCurrentComboPoints()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentComboPointsFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentComboPointsFrame:SetSize(1, 1);
    playerCurrentComboPointsFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentComboPoints, 0)
    playerCurrentComboPointsFrame.t = playerCurrentComboPointsFrame:CreateTexture()
    playerCurrentComboPointsFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentComboPointsFrame.t:SetAllPoints(playerCurrentComboPointsFrame)
    playerCurrentComboPointsFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentComboPoints()
    local power = EWowFunctions:getPlayerCurrentComboPoints()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentComboPointsFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentRunesFrame()
    local power = EWowFunctions:getPlayerCurrentRunes()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentRunesFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentRunesFrame:SetSize(1, 1);
    playerCurrentRunesFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentRunes, 0)
    playerCurrentRunesFrame.t = playerCurrentRunesFrame:CreateTexture()
    playerCurrentRunesFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentRunesFrame.t:SetAllPoints(playerCurrentRunesFrame)
    playerCurrentRunesFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentRunes()
    local power = EWowFunctions:getPlayerCurrentRunes()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentRunesFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentRunicFrame()
    local power = EWowFunctions:getPlayerCurrentRunicPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentRunicPowerFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentRunicPowerFrame:SetSize(1, 1);
    playerCurrentRunicPowerFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentRunic, 0)
    playerCurrentRunicPowerFrame.t = playerCurrentRunicPowerFrame:CreateTexture()
    playerCurrentRunicPowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentRunicPowerFrame.t:SetAllPoints(playerCurrentRunicPowerFrame)
    playerCurrentRunicPowerFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentRunic()
    local power = EWowFunctions:getPlayerCurrentRunicPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentRunicPowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentSoulShardsFrame()
    local power = EWowFunctions:getPlayerCurrentSoulShards()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentSoulShardsFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentSoulShardsFrame:SetSize(1, 1);
    playerCurrentSoulShardsFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentSoulShards, 0)
    playerCurrentSoulShardsFrame.t = playerCurrentSoulShardsFrame:CreateTexture()
    playerCurrentSoulShardsFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentSoulShardsFrame.t:SetAllPoints(playerCurrentSoulShardsFrame)
    playerCurrentSoulShardsFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentSoulShards()
    local power = EWowFunctions:getPlayerCurrentSoulShards()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentSoulShardsFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentLunarFrame()
    local power = EWowFunctions:getPlayerCurrentLunarPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentLunarFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentLunarFrame:SetSize(1, 1);
    playerCurrentLunarFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentLunar, 0)
    playerCurrentLunarFrame.t = playerCurrentLunarFrame:CreateTexture()
    playerCurrentLunarFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentLunarFrame.t:SetAllPoints(playerCurrentLunarFrame)
    playerCurrentLunarFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentLunar()
    local power = EWowFunctions:getPlayerCurrentLunarPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentLunarFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentHolyPowerFrame()
    local power = EWowFunctions:getPlayerCurrentHolyPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentHolyFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentHolyFrame:SetSize(1, 1);
    playerCurrentHolyFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentHoly, 0)
    playerCurrentHolyFrame.t = playerCurrentHolyFrame:CreateTexture()
    playerCurrentHolyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentHolyFrame.t:SetAllPoints(playerCurrentHolyFrame)
    playerCurrentHolyFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentHolyPower()
    local power = EWowFunctions:getPlayerCurrentHolyPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentHolyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentMaelstromFrame()
    local power = EWowFunctions:getPlayerCurrentMaelStromPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentMaelstromFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentMaelstromFrame:SetSize(1, 1);
    playerCurrentMaelstromFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentMaelestrom, 0)
    playerCurrentMaelstromFrame.t = playerCurrentMaelstromFrame:CreateTexture()
    playerCurrentMaelstromFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentMaelstromFrame.t:SetAllPoints(playerCurrentMaelstromFrame)
    playerCurrentMaelstromFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentMaelstrom()
    local power = EWowFunctions:getPlayerCurrentMaelStromPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentMaelstromFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentChiFrame()
    local power = EWowFunctions:getPlayerCurrentChiPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentChiFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentChiFrame:SetSize(1, 1);
    playerCurrentChiFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentChi, 0)
    playerCurrentChiFrame.t = playerCurrentChiFrame:CreateTexture()
    playerCurrentChiFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentChiFrame.t:SetAllPoints(playerCurrentChiFrame)
    playerCurrentChiFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentChi()
    local power = EWowFunctions:getPlayerCurrentChiPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentChiFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentInsanityFrame()
    local power = EWowFunctions:getPlayerCurrentInsanityPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentInsanityFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentInsanityFrame:SetSize(1, 1);
    playerCurrentInsanityFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentInsanity, 0)
    playerCurrentInsanityFrame.t = playerCurrentInsanityFrame:CreateTexture()
    playerCurrentInsanityFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentInsanityFrame.t:SetAllPoints(playerCurrentInsanityFrame)
    playerCurrentInsanityFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentInsanity()
    local power = EWowFunctions:getPlayerCurrentInsanityPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentInsanityFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentArcaneFrame()
    local power = EWowFunctions:getPlayerCurrentArcanePower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentArcanePowerFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentArcanePowerFrame:SetSize(1, 1);
    playerCurrentArcanePowerFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentArcane, 0)
    playerCurrentArcanePowerFrame.t = playerCurrentArcanePowerFrame:CreateTexture()
    playerCurrentArcanePowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentArcanePowerFrame.t:SetAllPoints(playerCurrentArcanePowerFrame)
    playerCurrentArcanePowerFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentArcane()
    local power = EWowFunctions:getPlayerCurrentArcanePower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentArcanePowerFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentFuryFrame()
    local power = EWowFunctions:getPlayerCurrentFuryPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentFuryFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentFuryFrame:SetSize(1, 1);
    playerCurrentFuryFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentFury, 0)
    playerCurrentFuryFrame.t = playerCurrentFuryFrame:CreateTexture()
    playerCurrentFuryFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentFuryFrame.t:SetAllPoints(playerCurrentFuryFrame)
    playerCurrentFuryFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentFury()
    local power = EWowFunctions:getPlayerCurrentFuryPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentFuryFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerCurrentPainFrame()
    local power = EWowFunctions:getPlayerCurrentPainPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentPainFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentPainFrame:SetSize(1, 1);
    playerCurrentPainFrame:SetPoint("TOPLEFT", EConstants.PlayerCurrentPain, 0)
    playerCurrentPainFrame.t = playerCurrentPainFrame:CreateTexture()
    playerCurrentPainFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentPainFrame.t:SetAllPoints(playerCurrentPainFrame)
    playerCurrentPainFrame:Show()
end

function PlayerFunctions:UpdatePlayerCurrentPain()
    local power = EWowFunctions:getPlayerCurrentPainPower()
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentPainFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerRuneCd1Frame()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(1)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)

    playerRuneCoolDown1Frame = CreateFrame("Frame", "", mainColourBar);
    playerRuneCoolDown1Frame:SetSize(1, 1);
    playerRuneCoolDown1Frame:SetPoint("TOPLEFT", EConstants.PlayerRunCooldown1, 0)
    playerRuneCoolDown1Frame.t = playerRuneCoolDown1Frame:CreateTexture()
    playerRuneCoolDown1Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerRuneCoolDown1Frame.t:SetAllPoints(playerRuneCoolDown1Frame)
    playerRuneCoolDown1Frame:Show()
end

function PlayerFunctions:UpdatePlayerRuneCd1()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(1)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)
    playerRuneCoolDown1Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerRuneCd2Frame()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(2)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)

    playerRuneCoolDown2Frame = CreateFrame("Frame", "", mainColourBar);
    playerRuneCoolDown2Frame:SetSize(1, 1);
    playerRuneCoolDown2Frame:SetPoint("TOPLEFT", EConstants.PlayerRunCooldown2, 0)
    playerRuneCoolDown2Frame.t = playerRuneCoolDown2Frame:CreateTexture()
    playerRuneCoolDown2Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerRuneCoolDown2Frame.t:SetAllPoints(playerRuneCoolDown2Frame)
    playerRuneCoolDown2Frame:Show()
end

function PlayerFunctions:UpdatePlayerRuneCd2()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(2)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)
    playerRuneCoolDown2Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerRuneCd3Frame()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(3)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)

    playerRuneCoolDown3Frame = CreateFrame("Frame", "", mainColourBar);
    playerRuneCoolDown3Frame:SetSize(1, 1);
    playerRuneCoolDown3Frame:SetPoint("TOPLEFT", EConstants.PlayerRunCooldown3, 0)
    playerRuneCoolDown3Frame.t = playerRuneCoolDown3Frame:CreateTexture()
    playerRuneCoolDown3Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerRuneCoolDown3Frame.t:SetAllPoints(playerRuneCoolDown3Frame)
    playerRuneCoolDown3Frame:Show()
end

function PlayerFunctions:UpdatePlayerRuneCd3()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(3)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)
    playerRuneCoolDown3Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerRuneCd4Frame()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(4)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)

    playerRuneCoolDown4Frame = CreateFrame("Frame", "", mainColourBar);
    playerRuneCoolDown4Frame:SetSize(1, 1);
    playerRuneCoolDown4Frame:SetPoint("TOPLEFT", EConstants.PlayerRunCooldown4, 0)
    playerRuneCoolDown4Frame.t = playerRuneCoolDown4Frame:CreateTexture()
    playerRuneCoolDown4Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerRuneCoolDown4Frame.t:SetAllPoints(playerRuneCoolDown4Frame)
    playerRuneCoolDown4Frame:Show()
end

function PlayerFunctions:UpdatePlayerRuneCd4()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(4)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)
    playerRuneCoolDown4Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerRuneCd5Frame()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(5)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)

    playerRuneCoolDown5Frame = CreateFrame("Frame", "", mainColourBar);
    playerRuneCoolDown5Frame:SetSize(1, 1);
    playerRuneCoolDown5Frame:SetPoint("TOPLEFT", EConstants.PlayerRunCooldown5, 0)
    playerRuneCoolDown5Frame.t = playerRuneCoolDown5Frame:CreateTexture()
    playerRuneCoolDown5Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerRuneCoolDown5Frame.t:SetAllPoints(playerRuneCoolDown5Frame)
    playerRuneCoolDown5Frame:Show()
end

function PlayerFunctions:UpdatePlayerRuneCd5()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(5)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)
    playerRuneCoolDown5Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerRuneCd6Frame()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(6)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)

    playerRuneCoolDown6Frame = CreateFrame("Frame", "", mainColourBar);
    playerRuneCoolDown6Frame:SetSize(1, 1);
    playerRuneCoolDown6Frame:SetPoint("TOPLEFT", EConstants.PlayerRunCooldown6, 0)
    playerRuneCoolDown6Frame.t = playerRuneCoolDown6Frame:CreateTexture()
    playerRuneCoolDown6Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerRuneCoolDown6Frame.t:SetAllPoints(playerRuneCoolDown6Frame)
    playerRuneCoolDown6Frame:Show()
end

function PlayerFunctions:UpdatePlayerRuneCd6()
    local cd = EWowFunctions:getPlayerCurrentRuneCooldown(6)
    if cd == nil then
        cd = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(cd)
    playerRuneCoolDown6Frame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerHasteFrame()
    local stat = EWowFunctions:getPlayerSpellHaste()
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:fixedDecimalToColor(stat)

    playerSpellHasteFrame = CreateFrame("Frame", "", mainColourBar);
    playerSpellHasteFrame:SetSize(1, 1);
    playerSpellHasteFrame:SetPoint("TOPLEFT", EConstants.PlayerSpellHaste, 0)
    playerSpellHasteFrame.t = playerSpellHasteFrame:CreateTexture()
    playerSpellHasteFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerSpellHasteFrame.t:SetAllPoints(playerSpellHasteFrame)
    playerSpellHasteFrame:Show()
end

function PlayerFunctions:UpdatePlayerHaste()
    local stat = EWowFunctions:getPlayerSpellHaste()
    if stat == nil then
        stat = 0
    end

    print("wooo")

    local cdCol = EUtils:fixedDecimalToColor(stat)
    playerSpellHasteFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerMovingFrame()
    local stat = EWowFunctions:IsPlayerMoving()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)

    playerIsMovingFrame = CreateFrame("Frame", "", mainColourBar);
    playerIsMovingFrame:SetSize(1, 1);
    playerIsMovingFrame:SetPoint("TOPLEFT", EConstants.PlayerIsMoving, 0)
    playerIsMovingFrame.t = playerIsMovingFrame:CreateTexture()
    playerIsMovingFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerIsMovingFrame.t:SetAllPoints(playerIsMovingFrame)
    playerIsMovingFrame:Show()
end

function PlayerFunctions:UpdatePlayerMoving()
    local stat = EWowFunctions:IsPlayerMoving()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)
    playerIsMovingFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerIsPvpFlaggedFrame()
    local stat = EWowFunctions:IsPlayerPvpFlagged()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)

    playerIsInPvpFlaggedFrame = CreateFrame("Frame", "", mainColourBar);
    playerIsInPvpFlaggedFrame:SetSize(1, 1);
    playerIsInPvpFlaggedFrame:SetPoint("TOPLEFT", EConstants.PlayerIsInPvpFlagged, 0)
    playerIsInPvpFlaggedFrame.t = playerIsInPvpFlaggedFrame:CreateTexture()
    playerIsInPvpFlaggedFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerIsInPvpFlaggedFrame.t:SetAllPoints(playerIsInPvpFlaggedFrame)
    playerIsInPvpFlaggedFrame:Show()
end

function PlayerFunctions:UpdatePlayerPvpFlagged()
    local stat = EWowFunctions:IsPlayerPvpFlagged()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)
    playerIsInPvpFlaggedFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerIsInCombatFrame()
    local stat = EWowFunctions:IsPlayerInCombat()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)

    playerIsInCombatFrame = CreateFrame("Frame", "", mainColourBar);
    playerIsInCombatFrame:SetSize(1, 1);
    playerIsInCombatFrame:SetPoint("TOPLEFT", EConstants.PlayerIsInCombat, 0)
    playerIsInCombatFrame.t = playerIsInCombatFrame:CreateTexture()
    playerIsInCombatFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerIsInCombatFrame.t:SetAllPoints(playerIsInCombatFrame)
    playerIsInCombatFrame:Show()
end

function PlayerFunctions:UpdatePlayerCombat()
    local stat = EWowFunctions:IsPlayerInCombat()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)
    playerIsInCombatFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerIsAutoAttackingFrame()
    local stat = EWowFunctions:IsPlayerAutoAttacking()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)

    playerIsAutoAttackingFrame = CreateFrame("Frame", "", mainColourBar);
    playerIsAutoAttackingFrame:SetSize(1, 1);
    playerIsAutoAttackingFrame:SetPoint("TOPLEFT", EConstants.PlayerIsAutoAttacking, 0)
    playerIsAutoAttackingFrame.t = playerIsAutoAttackingFrame:CreateTexture()
    playerIsAutoAttackingFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerIsAutoAttackingFrame.t:SetAllPoints(playerIsAutoAttackingFrame)
    playerIsAutoAttackingFrame:Show()
end

function PlayerFunctions:UpdatePlayerIsAutoAttacking()
    local stat = EWowFunctions:IsPlayerAutoAttacking()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)
    playerIsAutoAttackingFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerSpecializationFrame()
    local stat = EWowFunctions:GetPlayerSpecialization()
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)

    playerSpecializationFrame = CreateFrame("Frame", "", mainColourBar);
    playerSpecializationFrame:SetSize(1, 1);
    playerSpecializationFrame:SetPoint("TOPLEFT", EConstants.PlayerSpecialization, 0)
    playerSpecializationFrame.t = playerSpecializationFrame:CreateTexture()
    playerSpecializationFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerSpecializationFrame.t:SetAllPoints(playerSpecializationFrame)
    playerSpecializationFrame:Show()
end

function PlayerFunctions:UpdatePlayerSpecialization()
    local stat = EWowFunctions:GetPlayerSpecialization()
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)
    playerSpecializationFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerRaceFrame()
    local stat = EWowFunctions:GetPlayerRaceId()
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)

    playerRaceIdFrame = CreateFrame("Frame", "", mainColourBar);
    playerRaceIdFrame:SetSize(1, 1);
    playerRaceIdFrame:SetPoint("TOPLEFT", EConstants.PlayerRace, 0)
    playerRaceIdFrame.t = playerRaceIdFrame:CreateTexture()
    playerRaceIdFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerRaceIdFrame.t:SetAllPoints(playerRaceIdFrame)
    playerRaceIdFrame:Show()
end

function PlayerFunctions:UpdatePlayerRace()
    local stat = EWowFunctions:GetPlayerRaceId()
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)
    playerRaceIdFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerHealthFrame()
    local stat = EWowFunctions:GetUnitHealth("player")
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)

    playerHealthFrame = CreateFrame("Frame", "", mainColourBar);
    playerHealthFrame:SetSize(1, 1);
    playerHealthFrame:SetPoint("TOPLEFT", EConstants.PlayerHealth, 0)
    playerHealthFrame.t = playerHealthFrame:CreateTexture()
    playerHealthFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerHealthFrame.t:SetAllPoints(playerHealthFrame)
    playerHealthFrame:Show()
end

function PlayerFunctions:UpdatePlayerHealth()
    local stat = EWowFunctions:GetUnitHealth("player")
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)
    playerHealthFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerMaxHealthFrame()
    local stat = EWowFunctions:GetUnitMaxHealth("player")
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)

    playerMaxHealthFrame = CreateFrame("Frame", "", mainColourBar);
    playerMaxHealthFrame:SetSize(1, 1);
    playerMaxHealthFrame:SetPoint("TOPLEFT", EConstants.PlayerMaxHealth, 0)
    playerMaxHealthFrame.t = playerMaxHealthFrame:CreateTexture()
    playerMaxHealthFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerMaxHealthFrame.t:SetAllPoints(playerMaxHealthFrame)
    playerMaxHealthFrame:Show()
end

function PlayerFunctions:UpdatePlayerMaxHealth()
    local stat = EWowFunctions:GetUnitMaxHealth("player")
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)
    playerMaxHealthFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerIsDeadOrGhostFrame()
    local stat = EWowFunctions:GetUnitIsDeadOrGhost("player")
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)

    playerIsDeadOrGhostFrame = CreateFrame("Frame", "", mainColourBar);
    playerIsDeadOrGhostFrame:SetSize(1, 1);
    playerIsDeadOrGhostFrame:SetPoint("TOPLEFT", EConstants.PlayerIsDeadOrGhost, 0)
    playerIsDeadOrGhostFrame.t = playerIsDeadOrGhostFrame:CreateTexture()
    playerIsDeadOrGhostFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerIsDeadOrGhostFrame.t:SetAllPoints(playerIsDeadOrGhostFrame)
    playerIsDeadOrGhostFrame:Show()
end

function PlayerFunctions:UpdatePlayerIsDeadOrGhost()
    local stat = EWowFunctions:GetUnitIsDeadOrGhost("player")
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)
    playerIsDeadOrGhostFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerIsMountedFrame()
    local stat = EWowFunctions:IsPlayerMounted()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)

    playerIsMountedFrame = CreateFrame("Frame", "", mainColourBar);
    playerIsMountedFrame:SetSize(1, 1);
    playerIsMountedFrame:SetPoint("TOPLEFT", EConstants.PlayerIsMounted, 0)
    playerIsMountedFrame.t = playerIsMountedFrame:CreateTexture()
    playerIsMountedFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerIsMountedFrame.t:SetAllPoints(playerIsMountedFrame)
    playerIsMountedFrame:Show()
end

function PlayerFunctions:UpdatePlayerIsMounted()
    local stat = EWowFunctions:IsPlayerMounted()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)
    playerIsMountedFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerHasPetUIFrame()
    local stat = EWowFunctions:HasPlayerGotPetUI()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)

    playerHasPetUIFrame = CreateFrame("Frame", "", mainColourBar);
    playerHasPetUIFrame:SetSize(1, 1);
    playerHasPetUIFrame:SetPoint("TOPLEFT", EConstants.PlayerHasPetUI, 0)
    playerHasPetUIFrame.t = playerHasPetUIFrame:CreateTexture()
    playerHasPetUIFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerHasPetUIFrame.t:SetAllPoints(playerHasPetUIFrame)
    playerHasPetUIFrame:Show()
end

function PlayerFunctions:UpdatePlayerHasPetUI()
    local stat = EWowFunctions:GetPlayerPetMaxEnergy()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)
    playerHasPetUIFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerPetMaxEnergyFrame()
    local stat = EWowFunctions:GetPlayerPetMaxEnergy()
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)

    playerPetMaxEnergyFrame = CreateFrame("Frame", "", mainColourBar);
    playerPetMaxEnergyFrame:SetSize(1, 1);
    playerPetMaxEnergyFrame:SetPoint("TOPLEFT", EConstants.PlayerPetMaxEnergy, 0)
    playerPetMaxEnergyFrame.t = playerPetMaxEnergyFrame:CreateTexture()
    playerPetMaxEnergyFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerPetMaxEnergyFrame.t:SetAllPoints(playerPetMaxEnergyFrame)
    playerPetMaxEnergyFrame:Show()
end

function PlayerFunctions:UpdatePlayerPetMaxEnergy()
    local stat = EWowFunctions:GetPlayerPetMaxEnergy()
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)
    playerPetMaxEnergyFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerPetCurrentEnergyFrame()
    local stat = EWowFunctions:GetPlayerPetCurrentEnergy()
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)

    playerPetCurrentEnergy = CreateFrame("Frame", "", mainColourBar);
    playerPetCurrentEnergy:SetSize(1, 1);
    playerPetCurrentEnergy:SetPoint("TOPLEFT", EConstants.PlayerPetCurrentEnergy, 0)
    playerPetCurrentEnergy.t = playerPetCurrentEnergy:CreateTexture()
    playerPetCurrentEnergy.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerPetCurrentEnergy.t:SetAllPoints(playerPetCurrentEnergy)
    playerPetCurrentEnergy:Show()
end

function PlayerFunctions:UpdatePlayerPetCurrentEnergy()
    local stat = EWowFunctions:GetPlayerPetCurrentEnergy()
    if stat == nil then
        stat = 0
    end

    local cdCol = EUtils:integerToColor(stat)
    playerPetCurrentEnergy.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerPetMaxManaFrame()
    local power = EWowFunctions:getUnitMaxPower("pet", 0)
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerPetMaxManaFrame = CreateFrame("Frame", "", mainColourBar);
    playerPetMaxManaFrame:SetSize(1, 1);
    playerPetMaxManaFrame:SetPoint("TOPLEFT", EConstants.PlayerPetMaxMana, 0)
    playerPetMaxManaFrame.t = playerPetMaxManaFrame:CreateTexture()
    playerPetMaxManaFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerPetMaxManaFrame.t:SetAllPoints(playerPetMaxManaFrame)
    playerPetMaxManaFrame:Show()
end

function PlayerFunctions:UpdatePlayerPetMaxMana()
    local power = EWowFunctions:getUnitMaxPower("pet", 0)
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerPetMaxManaFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerPetCurrentManaFrame()
    local power = EWowFunctions:getUnitCurrentPower("pet", 0)
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerPetCurrentManaFrame = CreateFrame("Frame", "", mainColourBar);
    playerPetCurrentManaFrame:SetSize(1, 1);
    playerPetCurrentManaFrame:SetPoint("TOPLEFT", EConstants.PlayerPetCurrentMana, 0)
    playerPetCurrentManaFrame.t = playerPetCurrentManaFrame:CreateTexture()
    playerPetCurrentManaFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerPetCurrentManaFrame.t:SetAllPoints(playerPetCurrentManaFrame)
    playerPetCurrentManaFrame:Show()
end

function PlayerFunctions:UpdatePlayerPetCurrentMana()
    local power = EWowFunctions:getUnitCurrentPower("pet", 0)
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerPetCurrentManaFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerPetMaxHealthFrame()
    local power = EWowFunctions:GetUnitMaxHealth("pet")
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerPetMaxHealthFrame = CreateFrame("Frame", "", mainColourBar);
    playerPetMaxHealthFrame:SetSize(1, 1);
    playerPetMaxHealthFrame:SetPoint("TOPLEFT", EConstants.PlayerPetMaxHealth, 0)
    playerPetMaxHealthFrame.t = playerPetMaxHealthFrame:CreateTexture()
    playerPetMaxHealthFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerPetMaxHealthFrame.t:SetAllPoints(playerPetMaxHealthFrame)
    playerPetMaxHealthFrame:Show()
end

function PlayerFunctions:UpdatePlayerPetMaxHealth()
    local power = EWowFunctions:GetUnitMaxHealth("pet")
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerPetMaxHealthFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerPetCurrentHealthFrame()
    local power = EWowFunctions:GetUnitHealth("pet")
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerPetCurrentHealthFrame = CreateFrame("Frame", "", mainColourBar);
    playerPetCurrentHealthFrame:SetSize(1, 1);
    playerPetCurrentHealthFrame:SetPoint("TOPLEFT", EConstants.PlayerPetCurrentHealth, 0)
    playerPetCurrentHealthFrame.t = playerPetCurrentHealthFrame:CreateTexture()
    playerPetCurrentHealthFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerPetCurrentHealthFrame.t:SetAllPoints(playerPetCurrentHealthFrame)
    playerPetCurrentHealthFrame:Show()
end

function PlayerFunctions:UpdatePlayerPetCurrentHealth()
    local power = EWowFunctions:GetUnitHealth("pet")
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerPetCurrentHealthFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerPetIsInCombatFrame()
    local stat = EWowFunctions:GetUnitInCombat("pet")
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)

    playerPetIsInCombatFrame = CreateFrame("Frame", "", mainColourBar);
    playerPetIsInCombatFrame:SetSize(1, 1);
    playerPetIsInCombatFrame:SetPoint("TOPLEFT", EConstants.PlayerPetIsInCombat, 0)
    playerPetIsInCombatFrame.t = playerPetIsInCombatFrame:CreateTexture()
    playerPetIsInCombatFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
    playerPetIsInCombatFrame.t:SetAllPoints(playerPetIsInCombatFrame)
    playerPetIsInCombatFrame:Show()
end

function PlayerFunctions:UpdatePlayerPetCombat()
    local stat = EWowFunctions:GetUnitInCombat("pet")
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local cdCol = EUtils:integerToColor(stat)
    playerPetIsInCombatFrame.t:SetColorTexture(cdCol[1], cdCol[2], cdCol[3], 1)
end

function PlayerFunctions:CreatePlayerClassFrame()
    local power = EWowFunctions:GetUnitClass("player")
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)

    playerCurrentClassFrame = CreateFrame("Frame", "", mainColourBar);
    playerCurrentClassFrame:SetSize(1, 1);
    playerCurrentClassFrame:SetPoint("TOPLEFT", EConstants.PlayerClass, 0)
    playerCurrentClassFrame.t = playerCurrentClassFrame:CreateTexture()
    playerCurrentClassFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerCurrentClassFrame.t:SetAllPoints(playerCurrentClassFrame)
    playerCurrentClassFrame:Show()
end

function PlayerFunctions:UpdatePlayerClass()
    local power = EWowFunctions:GetUnitClass("player")
    if power == nil then
        power = 0
    end

    local powerCol = EUtils:integerToColor(power)
    playerCurrentClassFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerIsOutDoorFrame()
    local stat = EWowFunctions:IsPlayerOutDoor()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local powerCol = EUtils:integerToColor(stat)

    playerOutDoorFrame = CreateFrame("Frame", "", mainColourBar);
    playerOutDoorFrame:SetSize(1, 1);
    playerOutDoorFrame:SetPoint("TOPLEFT", EConstants.PlayerOutDoor, 0)
    playerOutDoorFrame.t = playerOutDoorFrame:CreateTexture()
    playerOutDoorFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerOutDoorFrame.t:SetAllPoints(playerOutDoorFrame)
    playerOutDoorFrame:Show()
end

function PlayerFunctions:UpdatePlayerOutDoor()
    local stat = EWowFunctions:IsPlayerOutDoor()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local powerCol = EUtils:integerToColor(stat)
    playerOutDoorFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerIsInRaidFrame()
    local stat = EWowFunctions:IsPlayerInRaid()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local powerCol = EUtils:integerToColor(stat)

    playerInRaidFrame = CreateFrame("Frame", "", mainColourBar);
    playerInRaidFrame:SetSize(1, 1);
    playerInRaidFrame:SetPoint("TOPLEFT", EConstants.PlayerInRaid, 0)
    playerInRaidFrame.t = playerInRaidFrame:CreateTexture()
    playerInRaidFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerInRaidFrame.t:SetAllPoints(playerInRaidFrame)
    playerInRaidFrame:Show()
end

function PlayerFunctions:UpdatePlayerIsInRaid()
    local stat = EWowFunctions:IsPlayerInRaid()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local powerCol = EUtils:integerToColor(stat)
    playerInRaidFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerIsInPartyFrame()
    local stat = EWowFunctions:IsPlayerInParty()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local powerCol = EUtils:integerToColor(stat)

    playerInPartyFrame = CreateFrame("Frame", "", mainColourBar);
    playerInPartyFrame:SetSize(1, 1);
    playerInPartyFrame:SetPoint("TOPLEFT", EConstants.PlayerInParty, 0)
    playerInPartyFrame.t = playerInPartyFrame:CreateTexture()
    playerInPartyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerInPartyFrame.t:SetAllPoints(playerInPartyFrame)
    playerInPartyFrame:Show()
end

function PlayerFunctions:UpdatePlayerIsInParty()
    local stat = EWowFunctions:IsPlayerInParty()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local powerCol = EUtils:integerToColor(stat)
    playerInPartyFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePlayerIsInVehicleFrame()
    local stat = EWowFunctions:IsPlayerInVehicle()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local powerCol = EUtils:integerToColor(stat)

    playerInVehicleFrame = CreateFrame("Frame", "", mainColourBar);
    playerInVehicleFrame:SetSize(1, 1);
    playerInVehicleFrame:SetPoint("TOPLEFT", EConstants.PlayerInVehicle, 0)
    playerInVehicleFrame.t = playerInVehicleFrame:CreateTexture()
    playerInVehicleFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
    playerInVehicleFrame.t:SetAllPoints(playerInVehicleFrame)
    playerInVehicleFrame:Show()
end

function PlayerFunctions:UpdatePlayerIsInVehicle()
    local stat = EWowFunctions:IsPlayerInVehicle()
    if stat == false then
        stat = 0
    else
        stat = 1
    end

    local powerCol = EUtils:integerToColor(stat)
    playerInVehicleFrame.t:SetColorTexture(powerCol[1], powerCol[2], powerCol[3], 1)
end

function PlayerFunctions:CreatePetFrames()
    self:CreatePlayerHasPetUIFrame()
    self:CreatePlayerPetMaxEnergyFrame()
    self:CreatePlayerPetCurrentEnergyFrame()
    self:CreatePlayerPetMaxManaFrame()
    self:CreatePlayerPetCurrentManaFrame()
    self:CreatePlayerPetMaxHealthFrame()
    self:CreatePlayerPetCurrentHealthFrame()
    self:CreatePlayerPetIsInCombatFrame()
end

function PlayerFunctions:UpdatePetFrames()
    self:UpdatePlayerHasPetUI()
    self:UpdatePlayerPetMaxEnergy()
    self:UpdatePlayerPetCurrentEnergy()
    self:UpdatePlayerPetMaxMana()
    self:UpdatePlayerPetCurrentMana()
    self:UpdatePlayerPetMaxHealth()
    self:UpdatePlayerPetCurrentHealth()
    self:UpdatePlayerPetCombat()
end

function EPlayerFrame:CreatePlayerMiscFrames()
    PlayerFunctions:CreatePlayerMaxPowerFrame()
    PlayerFunctions:CreatePlayerCurrentPowerFrame()
    PlayerFunctions:CreatePlayerMaxManaFrame()
    PlayerFunctions:CreatePlayerMaxRageFrame()
    PlayerFunctions:CreatePlayerMaxFocusFrame()
    PlayerFunctions:CreatePlayerMaxEnergyFrame()
    PlayerFunctions:CreatePlayerMaxComboPointsFrame()
    PlayerFunctions:CreatePlayerMaxRunesFrame()
    PlayerFunctions:CreatePlayerMaxRunicFrame()
    PlayerFunctions:CreatePlayerMaxSoulShardsFrame()
    PlayerFunctions:CreatePlayerMaxLunarFrame()
    PlayerFunctions:CreatePlayerMaxHolyPowerFrame()
    PlayerFunctions:CreatePlayerMaxMaelstromFrame()
    PlayerFunctions:CreatePlayerMaxChiFrame()
    PlayerFunctions:CreatePlayerMaxInsanityFrame()
    PlayerFunctions:CreatePlayerMaxArcaneFrame()
    PlayerFunctions:CreatePlayerMaxFuryFrame()
    PlayerFunctions:CreatePlayerMaxPainFrame()

    PlayerFunctions:CreatePlayerCurrentManaFrame()
    PlayerFunctions:CreatePlayerCurrentRageFrame()
    PlayerFunctions:CreatePlayerCurrentFocusFrame()
    PlayerFunctions:CreatePlayerCurrentEnergyFrame()
    PlayerFunctions:CreatePlayerCurrentComboPointsFrame()
    PlayerFunctions:CreatePlayerCurrentRunesFrame()
    PlayerFunctions:CreatePlayerCurrentRunicFrame()
    PlayerFunctions:CreatePlayerCurrentSoulShardsFrame()
    PlayerFunctions:CreatePlayerCurrentLunarFrame()
    PlayerFunctions:CreatePlayerCurrentHolyPowerFrame()
    PlayerFunctions:CreatePlayerCurrentMaelstromFrame()
    PlayerFunctions:CreatePlayerCurrentChiFrame()
    PlayerFunctions:CreatePlayerCurrentInsanityFrame()
    PlayerFunctions:CreatePlayerCurrentArcaneFrame()
    PlayerFunctions:CreatePlayerCurrentFuryFrame()
    PlayerFunctions:CreatePlayerCurrentPainFrame()

    PlayerFunctions:CreatePlayerRuneCd1Frame()
    PlayerFunctions:CreatePlayerRuneCd2Frame()
    PlayerFunctions:CreatePlayerRuneCd3Frame()
    PlayerFunctions:CreatePlayerRuneCd4Frame()
    PlayerFunctions:CreatePlayerRuneCd5Frame()
    PlayerFunctions:CreatePlayerRuneCd6Frame()

    PlayerFunctions:CreatePlayerHasteFrame()
    PlayerFunctions:CreatePlayerMovingFrame()
    PlayerFunctions:CreatePlayerIsPvpFlaggedFrame()
    PlayerFunctions:CreatePlayerIsInCombatFrame()
    PlayerFunctions:CreatePlayerIsAutoAttackingFrame()
    PlayerFunctions:CreatePlayerSpecializationFrame()
    PlayerFunctions:CreatePlayerRaceFrame()

    PlayerFunctions:CreatePlayerHealthFrame()
    PlayerFunctions:CreatePlayerMaxHealthFrame()

    PlayerFunctions:CreatePlayerIsDeadOrGhostFrame()
    PlayerFunctions:CreatePlayerIsMountedFrame()
    PlayerFunctions:CreatePlayerClassFrame()
    PlayerFunctions:CreatePlayerIsOutDoorFrame()

    PlayerFunctions:CreatePetFrames()

    PlayerFunctions:CreatePlayerIsInRaidFrame()
    PlayerFunctions:CreatePlayerIsInPartyFrame()
    PlayerFunctions:CreatePlayerIsInVehicleFrame()
end

function EPlayerFrame:UpdatePlayerMiscFrames()
    PlayerFunctions:UpdatePlayerMaxPower()
    PlayerFunctions:UpdatePlayerCurrentPower()
    PlayerFunctions:UpdatePlayerMaxMana()
    PlayerFunctions:UpdatePlayerMaxRage()
    PlayerFunctions:UpdatePlayerMaxFocus()
    PlayerFunctions:UpdatePlayerMaxEnergy()
    PlayerFunctions:UpdatePlayerMaxComboPoints()
    PlayerFunctions:UpdatePlayerMaxRunes()
    PlayerFunctions:UpdatePlayerMaxRunic()
    PlayerFunctions:UpdatePlayerMaxSoulShards()
    PlayerFunctions:UpdatePlayerMaxLunar()
    PlayerFunctions:UpdatePlayerMaxHolyPower()
    PlayerFunctions:UpdatePlayerMaxMaelstrom()
    PlayerFunctions:UpdatePlayerMaxChi()
    PlayerFunctions:UpdatePlayerMaxInsanity()
    PlayerFunctions:UpdatePlayerMaxArcane()
    PlayerFunctions:UpdatePlayerMaxFury()
    PlayerFunctions:UpdatePlayerMaxPain()

    PlayerFunctions:UpdatePlayerCurrentMana()
    PlayerFunctions:UpdatePlayerCurrentRage()
    PlayerFunctions:UpdatePlayerCurrentFocus()
    PlayerFunctions:UpdatePlayerCurrentEnergy()
    PlayerFunctions:UpdatePlayerCurrentComboPoints()
    PlayerFunctions:UpdatePlayerCurrentRunes()
    PlayerFunctions:UpdatePlayerCurrentRunic()
    PlayerFunctions:UpdatePlayerCurrentSoulShards()
    PlayerFunctions:UpdatePlayerCurrentLunar()
    PlayerFunctions:UpdatePlayerCurrentHolyPower()
    PlayerFunctions:UpdatePlayerCurrentMaelstrom()
    PlayerFunctions:UpdatePlayerCurrentChi()
    PlayerFunctions:UpdatePlayerCurrentInsanity()
    PlayerFunctions:UpdatePlayerCurrentArcane()
    PlayerFunctions:UpdatePlayerCurrentFury()
    PlayerFunctions:UpdatePlayerCurrentPain()

    PlayerFunctions:UpdatePlayerRuneCd1()
    PlayerFunctions:UpdatePlayerRuneCd2()
    PlayerFunctions:UpdatePlayerRuneCd3()
    PlayerFunctions:UpdatePlayerRuneCd4()
    PlayerFunctions:UpdatePlayerRuneCd5()
    PlayerFunctions:UpdatePlayerRuneCd6()

    PlayerFunctions:UpdatePlayerHaste()
    PlayerFunctions:UpdatePlayerMoving()
    PlayerFunctions:UpdatePlayerPvpFlagged()
    PlayerFunctions:UpdatePlayerCombat()
    PlayerFunctions:UpdatePlayerIsAutoAttacking()
    PlayerFunctions:UpdatePlayerSpecialization()
    PlayerFunctions:UpdatePlayerRace()
    PlayerFunctions:UpdatePlayerHealth()
    PlayerFunctions:UpdatePlayerMaxHealth()

    PlayerFunctions:UpdatePlayerIsDeadOrGhost()
    PlayerFunctions:UpdatePlayerIsMounted()
    PlayerFunctions:UpdatePlayerClass()
    PlayerFunctions:UpdatePlayerOutDoor()

    PlayerFunctions:UpdatePetFrames()

    PlayerFunctions:UpdatePlayerIsInRaid()
    PlayerFunctions:UpdatePlayerIsInParty()
    PlayerFunctions:UpdatePlayerIsInVehicle()
end


function EUtils:OnInitialize()

end

function EUtils:Modulo(val, by)
    return val - math.floor(val / by) * by
end

function EUtils:integerToColor(i)
    if i then
        if i ~= math.floor(i) then
            error("The number passed to 'integerToColor' must be an integer")
        end

        if i > (256 * 256 * 256 - 1) then
            error("Integer too big to encode as color")
        end

        local b = self:Modulo(i, 256)
        i = math.floor(i / 256)
        local g = self:Modulo(i, 256)
        i = math.floor(i / 256)
        local r = self:Modulo(i, 256)

        return { r / 255, g / 255, b / 255 }
    end
    return nil
end

function EUtils:fixedDecimalToColor(f)
    local smallerDec = tonumber(string.format("%.3f", f))
    local smallerDecStr = #tostring(smallerDec)
    if (smallerDecStr <= 6) then
        local i = math.floor(smallerDec * 100000)
        return self:integerToColor(i)
    else
        return self:integerToColor(0)
    end
end

function EUtils:StringToASCIIHex(str)
    str = string.sub(string.upper(str), 0, 6)
    local ASCII = ''
    for i = 1, string.len(str) do
        local c = string.sub(str, i, i)
        ASCII = ASCII .. string.byte(c)
    end
    return tonumber(ASCII)
end

local playerNameFrame1, playerNameFrame2, playerNameFrame3, playerNameFrame4, playerNameFrame5, playerNameFrame6  = {}
local targetNameFrame1, targetNameFrame2, targetNameFrame3, targetNameFrame4, targetNameFrame5, targetNameFrame6 = {}

function ENameFrames:CreatePlayerNameFrames()
    local playerName1 = EUtils:integerToColor(EWowFunctions:GetName( 0, nil, nil, "player"))
    local playerName2 = EUtils:integerToColor(EWowFunctions:GetName( 3, nil, nil, "player"))
    local playerName3 = EUtils:integerToColor(EWowFunctions:GetName( 0, 7, 12, "player"))
    local playerName4 = EUtils:integerToColor(EWowFunctions:GetName( 3, 7, 12, "player"))
    local playerName5 = EUtils:integerToColor(EWowFunctions:GetName( 0, 13, 18, "player"))
    local playerName6 = EUtils:integerToColor(EWowFunctions:GetName( 3, 13, 18, "player"))

    playerNameFrame1 = CreateFrame("Frame", "", mainColourBar);
    playerNameFrame1:SetSize(1, 1);
    playerNameFrame1:SetPoint("TOPLEFT", EConstants.PlayerName1, 0)
    playerNameFrame1.t = playerNameFrame1:CreateTexture()
    playerNameFrame1.t:SetColorTexture(playerName1[1], playerName1[2], playerName1[3], 1)
    playerNameFrame1.t:SetAllPoints(playerNameFrame1)
    playerNameFrame1:Show()
    playerNameFrame2 = CreateFrame("Frame", "", mainColourBar);
    playerNameFrame2:SetSize(1, 1);
    playerNameFrame2:SetPoint("TOPLEFT", EConstants.PlayerName2, 0)
    playerNameFrame2.t = playerNameFrame2:CreateTexture()
    playerNameFrame2.t:SetColorTexture(playerName2[1], playerName2[2], playerName2[3], 1)
    playerNameFrame2.t:SetAllPoints(playerNameFrame2)
    playerNameFrame2:Show()
    playerNameFrame3 = CreateFrame("Frame", "", mainColourBar);
    playerNameFrame3:SetSize(1, 1);
    playerNameFrame3:SetPoint("TOPLEFT", EConstants.PlayerName3, 0)
    playerNameFrame3.t = playerNameFrame3:CreateTexture()
    playerNameFrame3.t:SetColorTexture(playerName3[1], playerName3[2], playerName3[3], 1)
    playerNameFrame3.t:SetAllPoints(playerNameFrame3)
    playerNameFrame3:Show()
    playerNameFrame4 = CreateFrame("Frame", "", mainColourBar);
    playerNameFrame4:SetSize(1, 1);
    playerNameFrame4:SetPoint("TOPLEFT", EConstants.PlayerName4, 0)
    playerNameFrame4.t = playerNameFrame4:CreateTexture()
    playerNameFrame4.t:SetColorTexture(playerName4[1], playerName4[2], playerName4[3], 1)
    playerNameFrame4.t:SetAllPoints(playerNameFrame4)
    playerNameFrame4:Show()
    playerNameFrame5 = CreateFrame("Frame", "", mainColourBar);
    playerNameFrame5:SetSize(1, 1);
    playerNameFrame5:SetPoint("TOPLEFT", EConstants.PlayerName5, 0)
    playerNameFrame5.t = playerNameFrame5:CreateTexture()
    playerNameFrame5.t:SetColorTexture(playerName5[1], playerName5[2], playerName5[3], 1)
    playerNameFrame5.t:SetAllPoints(playerNameFrame5)
    playerNameFrame5:Show()
    playerNameFrame6 = CreateFrame("Frame", "", mainColourBar);
    playerNameFrame6:SetSize(1, 1);
    playerNameFrame6:SetPoint("TOPLEFT", EConstants.PlayerName6, 0)
    playerNameFrame6.t = playerNameFrame6:CreateTexture()
    playerNameFrame6.t:SetColorTexture(playerName6[1], playerName6[2], playerName6[3], 1)
    playerNameFrame6.t:SetAllPoints(playerNameFrame6)
    playerNameFrame6:Show()
end

function ENameFrames:CreateTargetNameFrames()
    local targetName1 = EUtils:integerToColor(EWowFunctions:GetName(0, nil, nil, "target"))
    local targetName2 = EUtils:integerToColor(EWowFunctions:GetName(3, nil, nil, "target"))
    local targetName3 = EUtils:integerToColor(EWowFunctions:GetName( 0, 7, 12, "target"))
    local targetName4 = EUtils:integerToColor(EWowFunctions:GetName( 3, 7, 12, "target"))
    local targetName5 = EUtils:integerToColor(EWowFunctions:GetName( 0, 13, 18, "target"))
    local targetName6 = EUtils:integerToColor(EWowFunctions:GetName( 3, 13, 18, "target"))

    targetNameFrame1 = CreateFrame("Frame", "", mainColourBar);
    targetNameFrame1:SetSize(1, 1);
    targetNameFrame1:SetPoint("TOPLEFT", EConstants.TargetName1, 0)
    targetNameFrame1.t = targetNameFrame1:CreateTexture()
    targetNameFrame1.t:SetColorTexture(targetName1[1], targetName1[2], targetName1[3], 1)
    targetNameFrame1.t:SetAllPoints(targetNameFrame1)
    targetNameFrame1:Show()
    targetNameFrame2 = CreateFrame("Frame", "", mainColourBar);
    targetNameFrame2:SetSize(1, 1);
    targetNameFrame2:SetPoint("TOPLEFT", EConstants.TargetName2, 0)
    targetNameFrame2.t = targetNameFrame2:CreateTexture()
    targetNameFrame2.t:SetColorTexture(targetName2[1], targetName2[2], targetName2[3], 1)
    targetNameFrame2.t:SetAllPoints(targetNameFrame2)
    targetNameFrame2:Show()
    targetNameFrame3 = CreateFrame("Frame", "", mainColourBar);
    targetNameFrame3:SetSize(1, 1);
    targetNameFrame3:SetPoint("TOPLEFT", EConstants.TargetName3, 0)
    targetNameFrame3.t = targetNameFrame3:CreateTexture()
    targetNameFrame3.t:SetColorTexture(targetName3[1], targetName3[2], targetName3[3], 1)
    targetNameFrame3.t:SetAllPoints(targetNameFrame3)
    targetNameFrame3:Show()
    targetNameFrame4 = CreateFrame("Frame", "", mainColourBar);
    targetNameFrame4:SetSize(1, 1);
    targetNameFrame4:SetPoint("TOPLEFT", EConstants.TargetName4, 0)
    targetNameFrame4.t = targetNameFrame4:CreateTexture()
    targetNameFrame4.t:SetColorTexture(targetName4[1], targetName4[2], targetName4[3], 1)
    targetNameFrame4.t:SetAllPoints(targetNameFrame4)
    targetNameFrame4:Show()
    targetNameFrame5 = CreateFrame("Frame", "", mainColourBar);
    targetNameFrame5:SetSize(1, 1);
    targetNameFrame5:SetPoint("TOPLEFT", EConstants.TargetName5, 0)
    targetNameFrame5.t = targetNameFrame5:CreateTexture()
    targetNameFrame5.t:SetColorTexture(targetName5[1], targetName5[2], targetName5[3], 1)
    targetNameFrame5.t:SetAllPoints(targetNameFrame5)
    targetNameFrame5:Show()
    targetNameFrame6 = CreateFrame("Frame", "", mainColourBar);
    targetNameFrame6:SetSize(1, 1);
    targetNameFrame6:SetPoint("TOPLEFT", EConstants.TargetName6, 0)
    targetNameFrame6.t = targetNameFrame6:CreateTexture()
    targetNameFrame6.t:SetColorTexture(targetName6[1], targetName6[2], targetName6[3], 1)
    targetNameFrame6.t:SetAllPoints(targetNameFrame6)
    targetNameFrame6:Show()
end

function ENameFrames:UpdateNameFrames()
    local playerName1 = EUtils:integerToColor(EWowFunctions:GetName( 0, nil, nil, "player"))
    local playerName2 = EUtils:integerToColor(EWowFunctions:GetName( 3, nil, nil, "player"))
    local playerName3 = EUtils:integerToColor(EWowFunctions:GetName( 0, 7, 12, "player"))
    local playerName4 = EUtils:integerToColor(EWowFunctions:GetName( 3, 7, 12, "player"))
    local playerName5 = EUtils:integerToColor(EWowFunctions:GetName( 0, 13, 18, "player"))
    local playerName6 = EUtils:integerToColor(EWowFunctions:GetName( 3, 13, 18, "player"))

    playerNameFrame1.t:SetColorTexture(playerName1[1], playerName1[2], playerName1[3], 1)
    playerNameFrame2.t:SetColorTexture(playerName2[1], playerName2[2], playerName2[3], 1)
    playerNameFrame3.t:SetColorTexture(playerName3[1], playerName3[2], playerName3[3], 1)
    playerNameFrame4.t:SetColorTexture(playerName4[1], playerName4[2], playerName4[3], 1)
    playerNameFrame5.t:SetColorTexture(playerName5[1], playerName5[2], playerName5[3], 1)
    playerNameFrame6.t:SetColorTexture(playerName6[1], playerName6[2], playerName6[3], 1)

    local targetName1 = EUtils:integerToColor(EWowFunctions:GetName(0, nil, nil, "target"))
    local targetName2 = EUtils:integerToColor(EWowFunctions:GetName(3, nil, nil, "target"))
    local targetName3 = EUtils:integerToColor(EWowFunctions:GetName( 0, 7, 12, "target"))
    local targetName4 = EUtils:integerToColor(EWowFunctions:GetName( 3, 7, 12, "target"))
    local targetName5 = EUtils:integerToColor(EWowFunctions:GetName( 0, 13, 18, "target"))
    local targetName6 = EUtils:integerToColor(EWowFunctions:GetName( 3, 13, 18, "target"))

    targetNameFrame1.t:SetColorTexture(targetName1[1], targetName1[2], targetName1[3], 1)
    targetNameFrame2.t:SetColorTexture(targetName2[1], targetName2[2], targetName2[3], 1)
    targetNameFrame3.t:SetColorTexture(targetName3[1], targetName3[2], targetName3[3], 1)
    targetNameFrame4.t:SetColorTexture(targetName4[1], targetName4[2], targetName4[3], 1)
    targetNameFrame5.t:SetColorTexture(targetName5[1], targetName5[2], targetName5[3], 1)
    targetNameFrame6.t:SetColorTexture(targetName6[1], targetName6[2], targetName6[3], 1)
end

local playerPositionFrameX, playerPositionFrameY  = {}

local function CreateXPositionFrame(xCoordi)
    local xPos = EUtils:fixedDecimalToColor(xCoordi)

    playerPositionFrameX = CreateFrame("Frame", "", mainColourBar);
    playerPositionFrameX:SetSize(1, 1);
    playerPositionFrameX:SetPoint("TOPLEFT", EConstants.XPosition, 0)
    playerPositionFrameX.t = playerPositionFrameX:CreateTexture()
    playerPositionFrameX.t:SetColorTexture(xPos[1], xPos[2], xPos[3], 1)
    playerPositionFrameX.t:SetAllPoints(playerPositionFrameX)
    playerPositionFrameX:Show()
end

local function CreateYPositionFrame(yCoordi)
    local yPos = EUtils:fixedDecimalToColor(yCoordi)

    playerPositionFrameY = CreateFrame("Frame", "", mainColourBar);
    playerPositionFrameY:SetSize(1, 1);
    playerPositionFrameY:SetPoint("TOPLEFT", EConstants.YPosition, 0)
    playerPositionFrameY.t = playerPositionFrameY:CreateTexture()
    playerPositionFrameY.t:SetColorTexture(yPos[1], yPos[2], yPos[3], 1)
    playerPositionFrameY.t:SetAllPoints(playerPositionFrameY)
    playerPositionFrameY:Show()
end

function EPositionFrames:CreatePlayerPositionFrames()
    local xCoordi, yCoordi = EWowFunctions:GetCurrentPlayerPosition()
    if xCoordi == nil or yCoordi == nil then
        xCoordi = 0
        yCoordi = 0
    end

    CreateXPositionFrame(xCoordi)
    CreateYPositionFrame(yCoordi)
end

function EPositionFrames:UpdatePositionFrames()
    local xCoordi, yCoordi = EWowFunctions:GetCurrentPlayerPosition()
    if xCoordi == nil or yCoordi == nil then
        xCoordi = 0
        yCoordi = 0
    end

    local xPos = EUtils:fixedDecimalToColor(xCoordi)
    playerPositionFrameX.t:SetColorTexture(xPos[1], xPos[2], xPos[3], 1)

    local yPos = EUtils:fixedDecimalToColor(yCoordi)
    playerPositionFrameY.t:SetColorTexture(yPos[1], yPos[2], yPos[3], 1)
end

local playerLevelFrame, targetLevelFrame = {}

function ELevelFrames:CreateLevelFrames()
    local playerLevel = EUtils:integerToColor(EWowFunctions:getPlayerLevel())

    playerLevelFrame = CreateFrame("Frame", "", mainColourBar);
    playerLevelFrame:SetSize(1, 1);
    playerLevelFrame:SetPoint("TOPLEFT", EConstants.PlayerLevel, 0)
    playerLevelFrame.t = playerLevelFrame:CreateTexture()
    playerLevelFrame.t:SetColorTexture(playerLevel[1], playerLevel[2], playerLevel[3], 1)
    playerLevelFrame.t:SetAllPoints(playerLevelFrame)
    playerLevelFrame:Show()

    local targetLevel = EUtils:integerToColor(EWowFunctions:getTargetLevel())

    targetLevelFrame = CreateFrame("Frame", "", mainColourBar);
    targetLevelFrame:SetSize(1, 1);
    targetLevelFrame:SetPoint("TOPLEFT", EConstants.TargetLevel, 0)
    targetLevelFrame.t = targetLevelFrame:CreateTexture()
    targetLevelFrame.t:SetColorTexture(targetLevel[1], targetLevel[2], targetLevel[3], 1)
    targetLevelFrame.t:SetAllPoints(targetLevelFrame)
    targetLevelFrame:Show()
end

function ELevelFrames:UpdateLevelFrames()
    local playerLevel = EUtils:integerToColor(EWowFunctions:getPlayerLevel())
    playerLevelFrame.t:SetColorTexture(playerLevel[1], playerLevel[2], playerLevel[3], 1)

    local targetLevel = EUtils:integerToColor(EWowFunctions:getTargetLevel())
    targetLevelFrame.t:SetColorTexture(targetLevel[1], targetLevel[2], targetLevel[3], 1)
end

EConstants.Empty = {PlayerName1= 0, 0 }

EConstants.PlayerName1 = 1
EConstants.PlayerName2 = 2
EConstants.PlayerName3 = 3
EConstants.PlayerName4 = 4
EConstants.PlayerName5 = 5
EConstants.PlayerName6 = 6

EConstants.TargetName1 = 7
EConstants.TargetName2 = 8
EConstants.TargetName3 = 9
EConstants.TargetName4 = 10
EConstants.TargetName5 = 11
EConstants.TargetName6 = 12

EConstants.XPosition = 13
EConstants.YPosition = 14

EConstants.PlayerLevel = 15
EConstants.TargetLevel = 16

EConstants.PlayerMaxPower = 17
EConstants.PlayerCurrentPower = 18

EConstants.PlayerMaxMana = 19
EConstants.PlayerMaxRage = 20
EConstants.PlayerMaxFocus = 21
EConstants.PlayerMaxEnergy = 22
EConstants.PlayerMaxComboPoints = 23
EConstants.PlayerMaxRunes = 24
EConstants.PlayerMaxRunic = 25
EConstants.PlayerMaxSoulShards = 26
EConstants.PlayerMaxLunar = 27
EConstants.PlayerMaxHoly = 28
EConstants.PlayerMaxMaelestrom = 29
EConstants.PlayerMaxChi = 30
EConstants.PlayerMaxInsanity = 31
EConstants.PlayerMaxArcane = 32
EConstants.PlayerMaxFury = 33
EConstants.PlayerMaxPain = 34

EConstants.PlayerCurrentMana = 35
EConstants.PlayerCurrentRage = 36
EConstants.PlayerCurrentFocus = 37
EConstants.PlayerCurrentEnergy = 38
EConstants.PlayerCurrentComboPoints = 39
EConstants.PlayerCurrentRunes = 40
EConstants.PlayerCurrentRunic = 41
EConstants.PlayerCurrentSoulShards = 42
EConstants.PlayerCurrentLunar = 43
EConstants.PlayerCurrentHoly = 44
EConstants.PlayerCurrentMaelestrom = 45
EConstants.PlayerCurrentChi = 46
EConstants.PlayerCurrentInsanity = 47
EConstants.PlayerCurrentArcane = 48
EConstants.PlayerCurrentFury = 49
EConstants.PlayerCurrentPain = 50

EConstants.PlayerRunCooldown1 = 51
EConstants.PlayerRunCooldown2 = 52
EConstants.PlayerRunCooldown3 = 53
EConstants.PlayerRunCooldown4 = 54
EConstants.PlayerRunCooldown5 = 55
EConstants.PlayerRunCooldown6 = 56

EConstants.PlayerSpellHaste = 57
EConstants.PlayerIsMoving = 58
EConstants.PlayerIsInPvpFlagged = 59
EConstants.PlayerIsInCombat = 60
EConstants.PlayerIsAutoAttacking = 61
EConstants.PlayerSpecialization = 62
EConstants.PlayerRace = 63
EConstants.PlayerHealth = 64
EConstants.PlayerMaxHealth = 65
EConstants.PlayerIsDeadOrGhost = 66
EConstants.PlayerIsMounted = 67
EConstants.PlayerHasPetUI = 68
EConstants.PlayerPetMaxEnergy = 69
EConstants.PlayerPetCurrentEnergy = 70
EConstants.PlayerPetMaxMana = 71
EConstants.PlayerPetCurrentMana = 72
EConstants.PlayerPetMaxHealth = 73
EConstants.PlayerPetCurrentHealth = 74
EConstants.PlayerPetIsInCombat = 75
EConstants.PlayerClass = 76
EConstants.PlayerOutDoor = 77
EConstants.PlayerInRaid = 78
EConstants.PlayerInParty = 79
EConstants.PlayerInVehicle= 80