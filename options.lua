local options = nil

function MiniMainBar:InitOptions()
	self.OptionsFrames = {}

	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("MiniMainBar", self:ConstructOptions())
	self.OptionsFrames = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MiniMainBar", "MiniMainBar")

	LibStub("AceConsole-3.0"):RegisterChatCommand("minimainbar", OpenOptions)
	LibStub("AceConsole-3.0"):RegisterChatCommand("mmb", OpenOptions)
end

function MiniMainBar:ConstructOptions()
	if not options then
		options = {
			name = "MiniMainBar",
			type = "group",
			childGroups = "tab",
			args = {	
				general = {
					order = 1,
					name = "General Options",
					type = "group",	
					args = {
						mainbar_artwork = {
									order = 1,
									name = "Hide artwork",
									desc = "Hides or unhides the main bar artwork.",
									type = "toggle",
									get = function () return self.db.profile.MainMenuBarGryphonsHidden end,
									set = function (info, value)  
									          self.db.profile.MainMenuBarGryphonsHidden = value
											  self:UpdateGUI()
										  end
								},
						mainbar_break1 = {
							order = 2,
							name = "",
							type = "description"
						},
						mainbar_scale = {
									order = 3,
									name = "Scale main bar",
									desc = "Scales the main bar. Note that this will also scale every other bar as well.",
									type = "range",
									min = 0.1,
									max = 2.0,
									step = 0.05,
									get = function () return self.db.profile.MainMenuBarScale end,
									set = function (info, value)
										      self.db.profile.MainMenuBarScale = value
											  self:UpdateGUI()
										  end
						},
						mainbar_break2 = {
							order = 3,
							name = "",
							type = "description"
						},
						mainbar_break3 = {
							order = 4,
							name = "",
							type = "description"
						},
						mainbar_break6 = {
							order = 5,
							name = "",
							type = "description"
						},
						mainbar_default = {
							order = 6,
							name = "Default Settings",
							desc = "Reset MiniMainBar to its default settings.  All bars will be moved to the center of the screen.",
							type = "execute",
							func = function () 
								       self.db.profile = self.db.defaults.profile 
									   self:UpdateGUI()
								   end
						}
					}
				},
				bags = {
					order = 2,
					name = "Bag Bar Options",
					type = "group",
					args = {
						bags_hide = {
							order = 1,
							name = "Hide bags bar",
							desc = "Hides or unhides the bags bar.",
							type = "toggle",
							get = function () return self.db.profile.BagsBarHidden end,
							set = function (info, value)  
									  self.db.profile.BagsBarHidden = value
									  self:UpdateGUI()
								  end
						},
						bags_break1 = {
							order = 2,
							name = "",
							type = "description"
						},
						bags_lock = {
							order = 1,
							name = "Lock bars bar",
							desc = "Locks or unlocks the bags bar.",
							type = "toggle",
							get = function () return self.db.profile.BagsBarLocked end,
							set = function (info, value)  
									  self.db.profile.BagsBarLocked = value
									  self:UpdateGUI()
								  end
						},
						bags_break2 = {
							order = 4,
							name = "",
							type = "description"
						},
						bags_mouseover = {
							order = 1,
							name = "Show bags bar on mouse over",
							desc = "Only valid if the bags bar is hidden.  Will show the bags bar on mouseover if enabled.",
							type = "toggle",
							get = function () return self.db.profile.BagsBarShowOnMouse end,
							set = function (info, value)  
									  self.db.profile.BagsBarShowOnMouse = value
									  self:UpdateGUI()
								  end
						},
						bags_break3 = {
							order = 6,
							name = "",
							type = "description"
						},
						bags_orientation = {
							order = 7,
							name = "Orientation",
							desc = "Determines if the bags bar should be horizontal or vertical",
							type = "select",
							style = "dropdown",
							values = { "Horizontal", "Vertical" },
							get = function () return self.db.profile.BagsBarOrientation end,
							set = function (info, value)
								      self.db.profile.BagsBarOrientation = value
									  self:UpdateGUI()
								  end
						},
						bags_break4 = {
							order = 8,
							name = "",
							type = "description"
						},
						bags_scale = {
							order = 9,
							name = "Scale bags bar",
							desc = "Scales the bags bar.",
							type = "range",
							min = 0.1,
							max = 2.0,
							step = 0.05,
							get = function () return self.db.profile.BagsBarScale end,
							set = function (info, value)
									  self.db.profile.BagsBarScale = value
									  self:UpdateGUI()
								  end
						}
					}
				},
				micromenu = {
					order = 3,
					name = "Micromenu Bar Options",
					type = "group",
					args = {
						micromenu_hide = {
							order = 1,
							name = "Hide micromenu bar",
							desc = "Hides or unhides the micromenu bar.",
							type = "toggle",
							get = function () return self.db.profile.MicroMenuHidden end,
							set = function (info, value)  
									  self.db.profile.MicroMenuHidden = value
									  self:UpdateGUI()
								  end
						},
						micromenu_break1 = {
							order = 3,
							name = "",
							type = "description"
						},
						micromenu_lock = {
							order = 1,
							name = "Lock micromenu bar",
							desc = "Locks or unlocks the micromenu bar.",
							type = "toggle",
							get = function () return self.db.profile.MicroMenuLocked end,
							set = function (info, value)  
									  self.db.profile.MicroMenuLocked = value
									  self:UpdateGUI()
								  end
						},
						micromenu_break2 = {
							order = 5,
							name = "",
							type = "description"
						},
						micromenu_mouseover = {
							order = 1,
							name = "Show micromenu on mouse over",
							desc = "Only valid if the micromenu is hidden.  Will show the micromenu on mouseover if enabled.",
							type = "toggle",
							get = function () return self.db.profile.MicroMenuShowOnMouse end,
							set = function (info, value)  
									  self.db.profile.MicroMenuShowOnMouse = value
									  self:UpdateGUI()
								  end
						},
						micromenu_break3 = {
							order = 7,
							name = "Layout Options",
							type = "header"
						},
						micromenu_orientation = {
							order = 8,
							name = "Orientation",
							desc = "Determines if the micromenu bar should be horizontal or vertical",
							type = "select",
							style = "dropdown",
							values = { "Horizontal", "Vertical" },
							get = function () return self.db.profile.MicroMenuOrientation end,
							set = function (info, value)
								      self.db.profile.MicroMenuOrientation = value
									  self:UpdateGUI()
								  end
						},
						micromenu_break4 = {
							order = 8,
							name = "",
							type = "description"
						},
						micromenu_scale = {
							order = 9,
							name = "Scale",
							desc = "Scales the micromenu bar.",
							type = "range",
							min = 0.1,
							max = 2.0,
							step = 0.05,
							get = function () return self.db.profile.MicroMenuScale end,
							set = function (info, value)
									  self.db.profile.MicroMenuScale = value
									  self:UpdateGUI()
								  end
						}
					}
				},
				pet = {
					order = 4,
					name = "Pet Bar Options",
					type = "group",
					args = {
						pet_hide = {
							order = 1,
							name = "Hide pet bar",
							desc = "Hides or unhides the pet bar.",
							type = "toggle",
							get = function () return self.db.profile.PetBarHidden end,
							set = function (info, value)  
									  self.db.profile.PetBarHidden = value
									  self:UpdateGUI()
								  end
						},
						pet_break1 = {
							order = 2,
							name = "",
							type = "description"
						},
						pet_lock = {
							order = 3,
							name = "Lock pet bar",
							desc = "Locks or unlocks the pet bar.",
							type = "toggle",
							get = function () return self.db.profile.PetBarLocked end,
							set = function (info, value)  
									  self.db.profile.PetBarLocked = value
									  self:UpdateGUI()
								  end
						},
						pet_break2 = {
							order = 4,
							name = "",
							type = "description"
						},
						pet_mouseover = {
							order = 5,
							name = "Show pet bar on mouse over",
							desc = "Only valid if the pet bar is hidden.  Will show the pet bar on mouseover if enabled.",
							type = "toggle",
							get = function () return self.db.profile.PetBarShowOnMouse end,
							set = function (info, value)  
									  self.db.profile.PetBarShowOnMouse = value
									  self:UpdateGUI()
								  end
						},
						pet_break3 = {
							order = 6,
							name = "",
							type = "description"
						},
						pet_orientation = {
							order = 7,
							name = "Orientation",
							desc = "Determines if the pet bar should be horizontal or vertical",
							type = "select",
							style = "dropdown",
							values = { "Horizontal", "Vertical" },
							get = function () return self.db.profile.PetBarOrientation end,
							set = function (info, value)
								      self.db.profile.PetBarOrientation = value
									  self:UpdateGUI()
								  end
						},
						pet_break4 = {
							order = 8,
							name = "",
							type = "description"
						},
						pet_scale = {
							order = 9,
							name = "Scale pet bar",
							desc = "Scales the pet bar.",
							type = "range",
							min = 0.1,
							max = 2.0,
							step = 0.05,
							get = function () return self.db.profile.PetBarScale end,
							set = function (info, value)
									  self.db.profile.PetBarScale = value
									  self:UpdateGUI()
								  end
						}
					}
				},
				stance = {
					order = 5,
					name = "Stance Bar Options",
					type = "group",
					args = {
						stance_hide = {
							order = 1,
							name = "Hide stance bar",
							desc = "Hides or unhides the stance bar.",
							type = "toggle",
							get = function () return self.db.profile.StanceBarHidden end,
							set = function (info, value)  
									  self.db.profile.StanceBarHidden = value
									  self:UpdateGUI()
								  end
						},
						stance_break1 = {
							order = 2,
							name = "",
							type = "description"
						},
						stance_lock = {
							order = 3,
							name = "Lock stance bar",
							desc = "Locks or unlocks the stance bar.",
							type = "toggle",
							get = function () return self.db.profile.StanceBarLocked end,
							set = function (info, value)  
									  self.db.profile.StanceBarLocked = value
									  self:UpdateGUI()
								  end
						},
						stance_break2 = {
							order = 4,
							name = "",
							type = "description"
						},
						stance_mouseover = {
							order = 5,
							name = "Show stance bar on mouse over",
							desc = "Only valid if the stance bar is hidden.  Will show the stance bar on mouseover if enabled.",
							type = "toggle",
							get = function () return self.db.profile.StanceBarShowOnMouse end,
							set = function (info, value)  
									  self.db.profile.StanceBarShowOnMouse = value
									  self:UpdateGUI()
								  end
						},
						stance_break3 = {
							order = 6,
							name = "",
							type = "description"
						},
						stance_scale = {
							order = 7,
							name = "Scale stance bar",
							desc = "Scales the stance bar.",
							type = "range",
							min = 0.1,
							max = 2.0,
							step = 0.05,
							get = function () return self.db.profile.StanceBarScale end,
							set = function (info, value)
									  self.db.profile.StanceBarScale = value
									  self:UpdateGUI()
								  end
						}
					}
				}
			}
		}
	end
	
	return options
end

function OpenOptions(input) 
	InterfaceOptionsFrame_OpenToCategory(MiniMainBar.OptionsFrames)
	InterfaceOptionsFrame:Raise()
end