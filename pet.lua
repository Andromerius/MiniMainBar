local PetBarButtons = {
	PetActionButton1,
	PetActionButton2,
	PetActionButton3,
	PetActionButton4,
	PetActionButton5,
	PetActionButton6,
	PetActionButton7,
	PetActionButton8,
	PetActionButton9,
	PetActionButton10
}

function MiniMainBar:InitPetBar()
	UIPARENT_MANAGED_FRAME_POSITIONS["PetActionBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['PETACTIONBAR_YPOS'] = nil

	for i = 1, #PetBarButtons do
		local button = PetBarButtons[i]
		button:SetParent(MiniMainBar_PetBar)
		button:HookScript("OnEnter",  MiniMainBar_PetBar_OnMouseOver)
		button:HookScript("OnLeave",  MiniMainBar_PetBar_OnMouseOut)
	end
	
	self:SecureHook("PetActionBarFrame_OnUpdate")
	self:SecureHook("ShowPetActionBar")

	MiniMainBar:HidePetBar(self.db.profile.PetBarHidden)
	MiniMainBar:LockPetBar(self.db.profile.PetBarLocked)
	MiniMainBar:ScalePetBar(self.db.profile.PetBarScale)
end

function MiniMainBar:UpdatePetBar()	
	local horizontal_width = 360
	local horizontal_height = 50
	
	local vertical_width = 50
	local vertical_height = 360
	
	local button_width = 34
	local button_height = 34
	
	local offset = 10
	
	if self.db.profile.PetBarOrientation == 1 then
		MiniMainBar_PetBar:SetSize(horizontal_width, horizontal_height)
	else
		MiniMainBar_PetBar:SetSize(vertical_width, vertical_height)
	end 
	
	for i = 1, #PetBarButtons do
		local button = PetBarButtons[i]
		button:ClearAllPoints()
		
		if self.db.profile.PetBarOrientation == 1 then
			button:SetPoint("BOTTOMLEFT", MiniMainBar_PetBar, "BOTTOMLEFT", button_width * (i - 1) + offset, offset)
		else
			button:SetPoint("TOP", MiniMainBar_PetBar, "TOP", 0, button_height * (i - 1) * -1 - offset)
		end
	end
	
	MiniMainBar:HidePetBar(self.db.profile.PetBarHidden)
	MiniMainBar:LockPetBar(self.db.profile.PetBarLocked)
	MiniMainBar:ScalePetBar(self.db.profile.PetBarScale)
	
	MiniMainBar_PetBar:ClearAllPoints()
	MiniMainBar_PetBar:SetPoint(
		self.db.profile.PetBarPoint.Point, 
		WorldFrame, 
		self.db.profile.PetBarPoint.RelativePoint, 
		self.db.profile.PetBarPoint.XOffset, 
		self.db.profile.PetBarPoint.YOffset
	)
end

function MiniMainBar:HidePetBar(hidden)
	if hidden then	
		MiniMainBar_PetBar:SetAlpha(0)
		MiniMainBar_PetBar:DisableDrawLayer()
		
		if MiniMainBar.db.profile.PetBarShowOnMouse then
			MiniMainBar_PetBar:EnableMouse(true)
			
			for i = 1, #PetBarButtons do
				local button = PetBarButtons[i]
				button:EnableMouse(true)
			end
		else
			MiniMainBar_PetBar:EnableMouse(false)
			
			for i = 1, #PetBarButtons do
				local button = PetBarButtons[i]
				button:EnableMouse(false)
			end
		end
	else
	    MiniMainBar_PetBar:SetAlpha(1)
		MiniMainBar_PetBar:EnableDrawLayer()
		MiniMainBar_PetBar:EnableMouse(true)
		
		for i = 1, #PetBarButtons do
			local button = PetBarButtons[i]
			button:EnableMouse(true)
		end
	end
end

function MiniMainBar:LockPetBar(locked)
	if locked then
		MiniMainBar_PetBar:SetMovable(false)
		MiniMainBar_PetBar:RegisterForDrag(nil)
		MiniMainBar_PetBar:SetBackdrop({ })
	else
		MiniMainBar_PetBar:SetMovable(true)
		MiniMainBar_PetBar:RegisterForDrag("RightButton")
		MiniMainBar_PetBar:SetBackdrop({ 
			bgFile = "Interface/DialogFrame/UI-DialogBox-Background" 
		})
	end
end

function MiniMainBar:ScalePetBar(scale)
	MiniMainBar_PetBar:SetScale(scale)
end

function MiniMainBar_PetBar_OnDragStart()
	if MiniMainBar.db.profile.PetBarLocked then return end
	
	MiniMainBar_PetBar:StartMoving();
	MiniMainBar_PetBar.isMoving = true;
end

function MiniMainBar:ShowPetActionBar()
	HidePetActionBar()
	PetActionBarFrame:Hide()
	if self.db.profile.PetBarHidden then
		MiniMainBar_PetBar:SetAlpha(0)
		MiniMainBar_PetBar:DisableDrawLayer()
	end
end

function MiniMainBar:PetActionBarFrame_OnUpdate()
	HidePetActionBar()
	PetActionBarFrame:Hide()
	if self.db.profile.PetBarHidden then
		MiniMainBar_PetBar:SetAlpha(0)
		MiniMainBar_PetBar:DisableDrawLayer()
	end
end

function MiniMainBar:PetActionButton_OnUpdate()
	HidePetActionBar()
	PetActionBarFrame:Hide()
	if self.db.profile.PetBarHidden then
		MiniMainBar_PetBar:SetAlpha(0)
		MiniMainBar_PetBar:DisableDrawLayer()
	end
end

function MiniMainBar_PetBar_OnDragStop()
	MiniMainBar_PetBar:StopMovingOrSizing()
	MiniMainBar_PetBar.isMoving = false;
	
	Point, RelativeTo, RelativePoint, XOffset, YOffset = MiniMainBar_PetBar:GetPoint()
	
	MiniMainBar.db.profile.PetBarPoint.XOffset = XOffset
	MiniMainBar.db.profile.PetBarPoint.YOffset = YOffset
	MiniMainBar.db.profile.PetBarPoint.Point = Point						
	MiniMainBar.db.profile.PetBarPoint.RelativePoint = RelativePoint
end

function MiniMainBar_PetBar_OnMouseOver(self)
	if	MiniMainBar.db.profile.PetBarHidden then
		if MiniMainBar.db.profile.PetBarShowOnMouse then
			MiniMainBar_PetBar:SetAlpha(1)
			MiniMainBar_PetBar:EnableDrawLayer()
		end
	end
end

function MiniMainBar_PetBar_OnMouseOut(self)
	if	MiniMainBar.db.profile.PetBarHidden then
		if MiniMainBar.db.profile.PetBarShowOnMouse then
			MiniMainBar_PetBar:SetAlpha(0)
			MiniMainBar_PetBar:DisableDrawLayer()
		end
	end
end
