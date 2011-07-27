
local defaults = {
	profile = {
		MainMenuBarScale = 1,
		MainMenuBarGryphonsHidden = false,
		MainMenuBarXPBarHidden = false,
		
		MicroMenuHidden = false,
		MicroMenuLocked = false,
		MicroMenuScale = 1,
		MicroMenuShowOnMouse = false,
		MicroMenuOrientation = 1,
		MicroMenuPoint = {
			XOffset = 0,
			YOffset = 0,
			Point = "CENTER",
			RelatedPoint = "CENTER",
			RelatedTo = "WorldFrame"
		},

		StanceBarHidden = false,
		StanceBarLocked = false,
		StanceBarScale = 1,
		StanceBarShowOnMouse = false,
		StanceBarPoint = {
			XOffset = 0,
			YOffset = 0,
			Point = "CENTER",
			RelatedPoint = "CENTER",
			RelatedTo = "WorldFrame"
		},
		
		BagsBarHidden = false,
		BagsBarLocked = false,
		BagsBarScale = 1,
		BagsBarShowOnMouse = false,
		BagsBarOrientation = 1,
		BagsBarPoint = {
			XOffset = 0,
			YOffset = 0,
			Point = "CENTER",
			RelatedPoint = "CENTER",
			RelatedTo = "WorldFrame"
		},

		PetBarHidden = false,
		PetBarLocked = false,
		PetBarScale = 1,
		PetBarShowOnMouse = false,
		PetBarOrientation = 1,
		PetBarPoint = {
			XOffset = 0,
			YOffset = 0,
			Point = "CENTER",
			RelatedPoint = "CENTER",
			RelatedTo = "WorldFrame"
		}
	}
}

MiniMainBar = LibStub("AceAddon-3.0"):NewAddon("MiniMainBar", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0")

function MiniMainBar:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("MiniMainBarDB", defaults, "Default")

	-- TODO: Actually implement profiles.
	self.db.RegisterCallback(self, "OnProfileChanged", "UpdateFromProfile")
	self.db.RegisterCallback(self, "OnProfileCopied", "UpdateFromProfile")
	self.db.RegisterCallback(self, "OnProfileReset", "UpdateFromProfile")

	-- Main UI update hooks
	self:SecureHook("UIParent_ManageFramePositions", MiniMainBar.UpdateGUI)
	self:SecureHook("MainMenuBar_ToPlayerArt", MiniMainBar.UpdateGUI)
	self:SecureHook("ShapeshiftBar_OnEvent", MiniMainBar.UpdateGUI)
	self:SecureHook("PossessBar_OnEvent", MiniMainBar.UpdateGUI)
	self:SecureHook("PetActionBar_OnEvent", MiniMainBar.UpdateGUI)
	
	MiniMainBar:InitOptions()
	MiniMainBar:InitGUI()
	MiniMainBar:InitVehicleGUI()
end

function MiniMainBar:UpdateFromProfile()

end

function MiniMainBar:InitGUI()
	MiniMainBar:InitMainMenuBar()
	MiniMainBar:InitMicroMenu()
	MiniMainBar:InitPetBar()
	MiniMainBar:InitBagsBar()
	MiniMainBar:InitStanceBar()
end

function MiniMainBar:InitVehicleGUI()

end

function MiniMainBar:UpdateGUI()
	if UnitHasVehicleUI("player") then return end

	-- If changing forms in combat Blizzard code will show these bars so they're hidden before the noncombat code.
	ShapeshiftBarFrame:Hide()
	PossessBarFrame:Hide()
	PetActionBarFrame:Hide()
	
	if InCombatLockdown() then
		MiniMainBar:CloneBlizzardExpBarSetup(512)
		return 
	end
	
	MiniMainBar:UpdateMainMenuBar()
	MiniMainBar:UpdateMicroMenu()
	MiniMainBar:UpdateBagsBar()
	MiniMainBar:UpdatePetBar()
	MiniMainBar:UpdateStanceBar()
end

function MiniMainBar:UpdateVehicleGUI()

end

function MiniMainBar:CloneBlizzardExpBarSetup(width)
	MainMenuXPBarTextureMid:SetWidth(width - 28)
	
	local divWidth = width / 20
	local xpos = divWidth - 4.5

	for i = 1,19 do
		local texture = _G["MainMenuXPBarDiv"..i]

		if not texture then
			texture = MainMenuExpBar:CreateTexture("MainMenuXPBarDiv"..i, "OVERLAY");
			texture:SetTexture("Interface\\MainMenuBar\\UI-XP-Bar");
			texture:SetSize(9,9);
			texture:SetTexCoord( 0.01562500, 0.15625000, 0.01562500, 0.17187500);
		end

		local xalign = floor(xpos);
		
		texture:SetPoint("LEFT", xalign, 1);
		xpos = xpos + divWidth;
	end

	MainMenuExpBar:SetWidth(width)
	
	local playerCurrXP = UnitXP("player")
	local playerMaxXP = UnitXPMax("player")
	local exhaustionThreshold = GetXPExhaustion()
	
	
	 if (not exhaustionThreshold) then
		ExhaustionTick:Hide()
		ExhaustionLevelFillBar:Hide()
	else
		local exhaustionTickSet = max(((playerCurrXP + exhaustionThreshold) / playerMaxXP) * MainMenuExpBar:GetWidth(), 0)
		ExhaustionTick:ClearAllPoints()
		
		 if (exhaustionTickSet > MainMenuExpBar:GetWidth() or MainMenuBarMaxLevelBar:IsShown()) then
			ExhaustionTick:Hide()
			ExhaustionLevelFillBar:Hide()
		 else
			ExhaustionTick:Show()
			ExhaustionTick:SetPoint("CENTER", "MainMenuExpBar", "LEFT", exhaustionTickSet, 0)
			ExhaustionLevelFillBar:Show()
			ExhaustionLevelFillBar:SetPoint("TOPRIGHT", "MainMenuExpBar", "TOPLEFT", exhaustionTickSet, 0)
		end
	end
end

function MiniMainBar:InitMainMenuBar()
	-- Main Menu bar elements to be hidden
	MainMenuBarPageNumber:Hide()
	ActionBarUpButton:Hide()
	ActionBarDownButton:Hide()
	MainMenuBarTexture2:Hide()
	MainMenuBarTexture3:Hide()
	MainMenuMaxLevelBar2:Hide()
	MainMenuMaxLevelBar3:Hide()
	
	-- Reanchor elements due to resizing of MainMenuBar 
	MainMenuMaxLevelBar0:SetPoint("BOTTOM", "MainMenuBarMaxLevelBar", "TOP", -128, 0)
	MainMenuBarTexture0:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", -128, 0)
	MainMenuBarTexture1:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", 128, 0)
	ReputationWatchBar:SetPoint("TOP", "MainMenuBar", "TOP", 0, 0);
	MainMenuBarLeftEndCap:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", -290, 0)
	MainMenuBarRightEndCap:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", 290, 0)
	
	-- Clear extra XP/Rep bar textures
	ReputationWatchBarTexture2:SetTexture(nil)
	ReputationWatchBarTexture3:SetTexture(nil)
	ReputationXPBarTexture2:SetTexture(nil)
	ReputationXPBarTexture3:SetTexture(nil)
	MainMenuMaxLevelBar2:SetTexture(nil)
	MainMenuMaxLevelBar3:SetTexture(nil)
	
	-- Resize MainMenuBar 
	MainMenuBar:SetWidth(512)
	ReputationWatchBar:SetWidth(512)
	ReputationWatchStatusBarBackground:SetWidth(512)
	MainMenuBarMaxLevelBar:SetWidth(512)
	ReputationWatchStatusBar:SetWidth(512)
end

function MiniMainBar:UpdateMainMenuBar()
	local level = UnitLevel("player")

	if level < MAX_PLAYER_LEVEL and not IsXPUserDisabled() then
		MiniMainBar:CloneBlizzardExpBarSetup(512)
	end

	if MultiBarBottomRight:IsShown() then
		local YOffset = 0
		
		if MultiBarBottomLeft:IsShown() then
			YOffset = 42
		end
		
		MultiBarBottomRight:ClearAllPoints()
		MultiBarBottomRight:SetPoint("BOTTOMLEFT", MultiBarBottomLeft, "BOTTOMLEFT", 0, YOffset)
	end	
	
	MiniMainBar:HideGryphons(self.db.profile.MainMenuBarGryphonsHidden)
	MiniMainBar:ScaleMainMenuBar(self.db.profile.MainMenuBarScale)
end

function MiniMainBar:ScaleMainMenuBar(scale)
	MainMenuBar:SetScale(scale)
	VehicleMenuBar:SetScale(scale)
end

function MiniMainBar:HideGryphons(hidden)
	if (hidden) then
		MainMenuBarLeftEndCap:Hide()
		MainMenuBarRightEndCap:Hide()
    else
		MainMenuBarLeftEndCap:Show()
		MainMenuBarRightEndCap:Show()	
	end
end