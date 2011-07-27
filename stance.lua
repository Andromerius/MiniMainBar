UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil
UIPARENT_MANAGED_FRAME_POSITIONS["PossessBarFrame"] = nil
UIPARENT_MANAGED_FRAME_POSITIONS["MultiCastActionBarFrame"] = nil
	
function MiniMainBar:InitStanceBar()
	for i = 1, 10 do
		local button = _G["ShapeshiftButton" .. tostring(i)]
		button:SetParent(MiniMainBar_StanceBar)
		
		button:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
		button:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)
	end
	
	local button = _G["ShapeshiftButton" .. tostring(1)]
	button:ClearAllPoints()
	button:SetPoint("BOTTOMLEFT", MiniMainBar_StanceBar, "BOTTOMLEFT", 6, 8)
	
	for i = 1, 2 do
		local button = _G["PossessButton" .. tostring(i)]
		button:SetParent(MiniMainBar_StanceBar)
		
		button:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
		button:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)
	end	
	
	for i = 1, 4 do
		local button = _G["MultiCastSlotButton"..i]	
		button:SetParent(MiniMainBar_StanceBar)
		button:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
		button:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)				
	end
	
	for i = 1, 12 do
		local button = _G["MultiCastActionButton"..i]
		button:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
		button:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)
	end

			
	--MultiCastActionPage1:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
	--MultiCastActionPage1:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)
	--MultiCastActionPage2:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
	--MultiCastActionPage2:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)
	--MultiCastActionPage3:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
	--MultiCastActionPage3:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)
	MultiCastRecallSpellButton:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
	MultiCastFlyoutFrameOpenButton:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
	--MultiCastFlyoutFrameOpenButton:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)
	
	MultiCastSummonSpellButton:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
	--MultiCastSummonSpellButton:HookScript("OnClick",  MiniMainBar_StanceBar_OnMouseOut)
	MultiCastFlyoutFrameCloseButton:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
	MultiCastFlyoutFrameCloseButton:HookScript("OnClick",  MiniMainBar_StanceBar_OnMouseOut)
	MultiCastFlyoutFrame:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
	--MultiCastFlyoutFrame:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)
	
	MultiCastActionBarFrame:SetParent(MiniMainBar_StanceBar)
	MultiCastActionBarFrame:ClearAllPoints()	
	MultiCastActionBarFrame:SetScript("OnShow", nil)
	MultiCastActionBarFrame:SetScript("OnHide", nil)
	MultiCastActionBarFrame:SetScript("OnUpdate", nil)
	MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", MiniMainBar_StanceBar, "BOTTOMLEFT", 6, 4)
	MultiCastActionBarFrame:HookScript("OnEnter",  MiniMainBar_StanceBar_OnMouseOver)
	MultiCastActionBarFrame:HookScript("OnLeave",  MiniMainBar_StanceBar_OnMouseOut)
	
	MiniMainBar:HideStanceBar(self.db.profile.StanceBarHidden)
	MiniMainBar:LockStanceBar(self.db.profile.StanceBarLocked)
	MiniMainBar:ScaleStanceBar(self.db.profile.StanceBarScale)
end

function MiniMainBar:UpdateStanceBar()
	ShapeshiftBarLeft:Hide()
    ShapeshiftBarMiddle:Hide()
    ShapeshiftBarRight:Hide()
    PossessBackground1:Hide()
    PossessBackground2:Hide()
	
	local button = _G["ShapeshiftButton" .. tostring(1)]
	button:ClearAllPoints()
	button:SetPoint("BOTTOMLEFT", MiniMainBar_StanceBar, "BOTTOMLEFT", 6, 8)	
	
	local button = _G["PossessButton" .. tostring(1)]
	button:ClearAllPoints()
	button:SetPoint("BOTTOMLEFT", MiniMainBar_StanceBar, "BOTTOMLEFT", 6, 8)
	
	MiniMainBar:HideStanceBar(self.db.profile.StanceBarHidden)
	MiniMainBar:LockStanceBar(self.db.profile.StanceBarLocked)
	MiniMainBar:ScaleStanceBar(self.db.profile.StanceBarScale)
	
	MiniMainBar_StanceBar:ClearAllPoints()
	MiniMainBar_StanceBar:SetPoint(
		self.db.profile.StanceBarPoint.Point, 
		WorldFrame, 
		self.db.profile.StanceBarPoint.RelativePoint, 
		self.db.profile.StanceBarPoint.XOffset, 
		self.db.profile.StanceBarPoint.YOffset
	)
end

function MiniMainBar:HideStanceBar(hidden)
	if hidden then	
		MiniMainBar_StanceBar:SetAlpha(0)
		MiniMainBar_StanceBar:DisableDrawLayer()
		
		if MiniMainBar.db.profile.StanceBarShowOnMouse then
			MiniMainBar_StanceBar:EnableMouse(true)
			
			for i = 1, 10 do
				local button = _G["ShapeshiftButton" .. tostring(i)]
				button:EnableMouse(true)
			end
			
			for i = 1, 2 do
				local button = _G["PossessButton" .. tostring(i)]
				button:EnableMouse(true)
			end
		else
			MiniMainBar_StanceBar:EnableMouse(false)
			
			for i = 1, 10 do
				local button = _G["ShapeshiftButton" .. tostring(i)]
				button:EnableMouse(false)
			end
			
			for i = 1, 2 do
				local button = _G["PossessButton" .. tostring(i)]
				button:EnableMouse(false)
			end
		end
	else
	    MiniMainBar_StanceBar:SetAlpha(1)
		MiniMainBar_StanceBar:EnableDrawLayer()
		MiniMainBar_StanceBar:EnableMouse(true)

		for i = 1, 10 do
			local button = _G["ShapeshiftButton" .. tostring(i)]
			button:EnableMouse(true)
		end
		
		for i = 1, 2 do
			local button = _G["PossessButton" .. tostring(i)]
			button:EnableMouse(true)
		end
	end
end

function MiniMainBar:LockStanceBar(locked)
	if locked then
		MiniMainBar_StanceBar:SetMovable(false)
		MiniMainBar_StanceBar:RegisterForDrag(nil)
		MiniMainBar_StanceBar:SetBackdrop({ })
	else
		MiniMainBar_StanceBar:SetMovable(true)
		MiniMainBar_StanceBar:RegisterForDrag("RightButton")
		MiniMainBar_StanceBar:SetBackdrop({ 
			bgFile = "Interface/DialogFrame/UI-DialogBox-Background" 
		})
	end
end

function MiniMainBar:ScaleStanceBar(scale)
	MiniMainBar_StanceBar:SetScale(scale)
end

function MiniMainBar_StanceBar_OnDragStart()
	if MiniMainBar.db.profile.StanceBarLocked then return end
	
	MiniMainBar_StanceBar:StartMoving()
	MiniMainBar_StanceBar.isMoving = true
end

function MiniMainBar_StanceBar_OnDragStop()
	MiniMainBar_StanceBar:StopMovingOrSizing()
	MiniMainBar_StanceBar.isMoving = false
	
	Point, RelativeTo, RelativePoint, XOffset, YOffset = MiniMainBar_StanceBar:GetPoint()
	
	MiniMainBar.db.profile.StanceBarPoint.XOffset = XOffset
	MiniMainBar.db.profile.StanceBarPoint.YOffset = YOffset
	MiniMainBar.db.profile.StanceBarPoint.Point = Point						
	MiniMainBar.db.profile.StanceBarPoint.RelativePoint = RelativePoint
end

function MiniMainBar_StanceBar_OnMouseOver(self)
	if	MiniMainBar.db.profile.StanceBarHidden then
		if MiniMainBar.db.profile.StanceBarShowOnMouse then
			MiniMainBar_StanceBar:SetAlpha(1)
			MiniMainBar_StanceBar:EnableDrawLayer()
		end
	end
end

function MiniMainBar_StanceBar_OnMouseOut(self)
	if	MiniMainBar.db.profile.StanceBarHidden then
		if MiniMainBar.db.profile.StanceBarShowOnMouse then
			MiniMainBar_StanceBar:SetAlpha(0)
			MiniMainBar_StanceBar:DisableDrawLayer()
		end
	end
end
