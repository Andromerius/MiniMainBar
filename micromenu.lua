local MicroMenuButtons = {
	CharacterMicroButton, 
	SpellbookMicroButton, 
	TalentMicroButton, 
	AchievementMicroButton, 
	QuestLogMicroButton,
	GuildMicroButton, 
	PVPMicroButton, 
	LFDMicroButton,
	EJMicroButton,
	RaidMicroButton,
	MainMenuMicroButton, 
	HelpMicroButton
}

function MiniMainBar:InitMicroMenu()
	for i = 1, #MicroMenuButtons do
		local button = MicroMenuButtons[i]
		button:SetParent(MiniMainBar_MicroMenu)
		
		button:HookScript("OnEnter",  MiniMainBar_MicroMenu_OnMouseOver)
		button:HookScript("OnLeave",  MiniMainBar_MicroMenu_OnMouseOut)
	end
	
	self:SecureHook("UpdateMicroButtons", MiniMainBar.UpdateMicroButtons)
	
	MiniMainBar:HideMicroMenu(self.db.profile.MicroMenuHidden)
	MiniMainBar:LockMicroMenu(self.db.profile.MicroMenuLocked)
	MiniMainBar:ScaleMicroMenu(self.db.profile.MicroMenuScale)
end

function MiniMainBar:UpdateMicroMenu()
	local horizontal_width = 330
	local horizontal_height = 45
	
	local vertical_width = 45
	local vertical_height = 450
	
	local microbutton_width = 25
	local microbutton_height = 33
	
	local xoffset = 10
	
	if self.db.profile.MicroMenuOrientation == 1 then
		MiniMainBar_MicroMenu:SetSize(horizontal_width, horizontal_height)
	else
		MiniMainBar_MicroMenu:SetSize(vertical_width, vertical_height)
	end 
	
	for i = 1, #MicroMenuButtons do
		local button = MicroMenuButtons[i]
		button:ClearAllPoints()
		
		if self.db.profile.MicroMenuOrientation == 1 then
			button:SetPoint("BOTTOMLEFT", MiniMainBar_MicroMenu, "BOTTOMLEFT", microbutton_width * (i - 1) + xoffset, 4)
		else
			button:SetPoint("TOP", MiniMainBar_MicroMenu, "TOP", 0, microbutton_height * (i - 1) * -1)
		end
	end
	
	MiniMainBar:HideMicroMenu(self.db.profile.MicroMenuHidden)
	MiniMainBar:LockMicroMenu(self.db.profile.MicroMenuLocked)
	MiniMainBar:ScaleMicroMenu(self.db.profile.MicroMenuScale)
	
	MiniMainBar_MicroMenu:ClearAllPoints()
	MiniMainBar_MicroMenu:SetPoint(
		MiniMainBar.db.profile.MicroMenuPoint.Point, 
		WorldFrame, 
		self.db.profile.MicroMenuPoint.RelativePoint, 
		self.db.profile.MicroMenuPoint.XOffset, 
		self.db.profile.MicroMenuPoint.YOffset
	)
end

function MiniMainBar:UpdateMicroButtons()
	-- Blizzard code resets the UIParent of the micromenu buttons, so we override that here.
	for i = 1, #MicroMenuButtons do
		local button = MicroMenuButtons[i]
		button:SetParent(MiniMainBar_MicroMenu)
	end
end

function MiniMainBar:HideMicroMenu(hidden)
	if hidden then	
		MiniMainBar_MicroMenu:SetAlpha(0)
		MiniMainBar_MicroMenu:DisableDrawLayer()
		
		if MiniMainBar.db.profile.MicroMenuShowOnMouse then
			MiniMainBar_MicroMenu:EnableMouse(true)
			
			for i = 1, #MicroMenuButtons do
				local button = MicroMenuButtons[i]
				button:EnableMouse(true)
			end
		else
			MiniMainBar_MicroMenu:EnableMouse(false)
			
			for i = 1, #MicroMenuButtons do
				local button = MicroMenuButtons[i]
				button:EnableMouse(false)
			end
		end
	else
	    MiniMainBar_MicroMenu:SetAlpha(1)
		MiniMainBar_MicroMenu:EnableDrawLayer()
		MiniMainBar_MicroMenu:EnableMouse(true)
		
		for i = 1, #MicroMenuButtons do
			local button = MicroMenuButtons[i]
			button:EnableMouse(true)
		end
	end
end

function MiniMainBar:LockMicroMenu(locked)
	if locked then
		MiniMainBar_MicroMenu:SetMovable(false)
		MiniMainBar_MicroMenu:RegisterForDrag(nil)
		MiniMainBar_MicroMenu:SetBackdrop({ })
	else
		MiniMainBar_MicroMenu:SetMovable(true)
		MiniMainBar_MicroMenu:RegisterForDrag("RightButton")
		MiniMainBar_MicroMenu:SetBackdrop({ 
			bgFile = "Interface/DialogFrame/UI-DialogBox-Background" 
		})
	end
end

function MiniMainBar:ScaleMicroMenu(scale)
	MiniMainBar_MicroMenu:SetScale(scale)
end

function MiniMainBar_MicroMenu_OnDragStart()
	if MiniMainBar.db.profile.MicroMenuLocked then return end
	
	MiniMainBar_MicroMenu:StartMoving();
	MiniMainBar_MicroMenu.isMoving = true;
end

function MiniMainBar_MicroMenu_OnDragStop()
	MiniMainBar_MicroMenu:StopMovingOrSizing();
	MiniMainBar_MicroMenu.isMoving = false;
	
	Point, RelativeTo, RelativePoint, XOffset, YOffset = MiniMainBar_MicroMenu:GetPoint()
	
	MiniMainBar.db.profile.MicroMenuPoint.XOffset = XOffset
	MiniMainBar.db.profile.MicroMenuPoint.YOffset = YOffset
	MiniMainBar.db.profile.MicroMenuPoint.Point = Point						
	MiniMainBar.db.profile.MicroMenuPoint.RelativePoint = RelativePoint
end

function MiniMainBar_MicroMenu_OnMouseOver(self)
	if MiniMainBar.db.profile.MicroMenuHidden then
		if MiniMainBar.db.profile.MicroMenuShowOnMouse then
			MiniMainBar_MicroMenu:SetAlpha(1)
			MiniMainBar_MicroMenu:EnableDrawLayer()
		end
	end
end

function MiniMainBar_MicroMenu_OnMouseOut(self)
	if	MiniMainBar.db.profile.MicroMenuHidden then
		if MiniMainBar.db.profile.MicroMenuShowOnMouse then
			MiniMainBar_MicroMenu:SetAlpha(0)
			MiniMainBar_MicroMenu:DisableDrawLayer()
		end
	end
end

