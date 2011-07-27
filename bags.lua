local BagsBarItems = {
	MainMenuBarBackpackButton, 
	CharacterBag0Slot, 
	CharacterBag1Slot,
	CharacterBag2Slot, 
	CharacterBag3Slot
}

function MiniMainBar:InitBagsBar()
	for i = 1, #BagsBarItems do
		local button = BagsBarItems[i]
		button:SetParent(MiniMainBar_BagsBar)

		button:HookScript("OnEnter",  MiniMainBar_BagsBar_OnMouseOver)
		button:HookScript("OnLeave",  MiniMainBar_BagsBar_OnMouseOut)
	end
	
	MiniMainBar:HideBagsBar(self.db.profile.BagsBarHidden)
	MiniMainBar:LockBagsBar(self.db.profile.BagsBarLocked)
	MiniMainBar:ScaleBagsBar(self.db.profile.BagsBarScale)
end

function MiniMainBar:UpdateBagsBar()
	local horizontal_width = 180
	local horizontal_height = 45
	
	local vertical_width = 45
	local vertical_height = 180
	
	local button_width = 33
	local button_height = 33
	
	local offset = 8
	
	if self.db.profile.BagsBarOrientation == 1 then
		MiniMainBar_BagsBar:SetSize(horizontal_width, horizontal_height)
	else
		MiniMainBar_BagsBar:SetSize(vertical_width, vertical_height)
	end 
	
	for i = 1, #BagsBarItems do
		local button = BagsBarItems[i]
		button:ClearAllPoints()
		
		if self.db.profile.BagsBarOrientation == 1 then
			button:SetPoint("BOTTOMLEFT", MiniMainBar_BagsBar, "BOTTOMLEFT", button_width * (i - 1) + offset, offset)
		else
			button:SetPoint("TOP", MiniMainBar_BagsBar, "TOP", 0, button_height * (i - 1) * -1 - offset)
		end
	end
	
	MiniMainBar:HideBagsBar(self.db.profile.BagsBarHidden)
	MiniMainBar:LockBagsBar(self.db.profile.BagsBarLocked)
	MiniMainBar:ScaleBagsBar(self.db.profile.BagsBarScale)
		
	MiniMainBar_BagsBar:ClearAllPoints()
	MiniMainBar_BagsBar:SetPoint(
		self.db.profile.BagsBarPoint.Point, 
		WorldFrame, 
		self.db.profile.BagsBarPoint.RelativePoint,
		self.db.profile.BagsBarPoint.XOffset,  
		self.db.profile.BagsBarPoint.YOffset
	)
end

function MiniMainBar:HideBagsBar(hidden)
	if hidden then	
		MiniMainBar_BagsBar:SetAlpha(0)
		MiniMainBar_BagsBar:DisableDrawLayer()

		if MiniMainBar.db.profile.BagsBarShowOnMouse then
			MiniMainBar_BagsBar:EnableMouse(true)
			
			for i = 1, #BagsBarItems do
				local button = BagsBarItems[i]
				button:EnableMouse(true)
			end
		else
			MiniMainBar_MicroMenu:EnableMouse(false)
			
			for i = 1, #BagsBarItems do
				local button = BagsBarItems[i]
				button:EnableMouse(false)
			end
		end
	else
	    MiniMainBar_BagsBar:SetAlpha(1)
		MiniMainBar_BagsBar:EnableDrawLayer()
		MiniMainBar_BagsBar:EnableMouse(true)
		
		for i = 1, #BagsBarItems do
			local button = BagsBarItems[i]
			button:EnableMouse(true)
		end
	end
end

function MiniMainBar:LockBagsBar(locked)
	if locked then
		MiniMainBar_BagsBar:SetMovable(false)
		MiniMainBar_BagsBar:RegisterForDrag(nil)
		MiniMainBar_BagsBar:SetBackdrop({ })
	else
		MiniMainBar_BagsBar:SetMovable(true)
		MiniMainBar_BagsBar:RegisterForDrag("RightButton")
		MiniMainBar_BagsBar:SetBackdrop({ 
			bgFile = "Interface/DialogFrame/UI-DialogBox-Background" 
		})
	end
end

function MiniMainBar:ScaleBagsBar(scale)
	MiniMainBar_BagsBar:SetScale(scale)
end

function MiniMainBar_BagsBar_OnDragStart()
	if MiniMainBar.db.char.BagsBarLocked then return end
	
	MiniMainBar_BagsBar:StartMoving()
	MiniMainBar_BagsBar.isMoving = true
end

function MiniMainBar_BagsBar_OnDragStop()
	MiniMainBar_BagsBar:StopMovingOrSizing()
	MiniMainBar_BagsBar.isMoving = false
	
	Point, RelativeTo, RelativePoint, XOffset, YOffset = MiniMainBar_BagsBar:GetPoint()
	
	MiniMainBar.db.profile.BagsBarPoint.XOffset = XOffset
	MiniMainBar.db.profile.BagsBarPoint.YOffset = YOffset
	MiniMainBar.db.profile.BagsBarPoint.Point = Point						
	MiniMainBar.db.profile.BagsBarPoint.RelativePoint = RelativePoint
end

function MiniMainBar_BagsBar_OnMouseOver(self)
	if	MiniMainBar.db.profile.BagsBarHidden then
		if MiniMainBar.db.profile.BagsBarShowOnMouse then
			MiniMainBar_BagsBar:SetAlpha(1)
			MiniMainBar_BagsBar:EnableDrawLayer()
		end
	end
end

function MiniMainBar_BagsBar_OnMouseOut(self)
	if	MiniMainBar.db.profile.BagsBarHidden then
		if MiniMainBar.db.profile.BagsBarShowOnMouse then
			MiniMainBar_BagsBar:SetAlpha(0)
			MiniMainBar_BagsBar:DisableDrawLayer()
		end
	end
end
