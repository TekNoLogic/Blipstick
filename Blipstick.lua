
----------------------
--      Locals      --
----------------------

local GAP, EDGEGAP, ROWHEIGHT = 8, 16, 43
local DEFAULTPATH = "Interface\\Minimap\\ObjectIcons"

local path = "Interface\\AddOns\\Blipstick\\"
local textures = {"Default", "SmallExclaim", "LittleExclaim", "Nandini", "Nandini-black", "AlternateBlips"}


------------------------------
--      Initialization      --
------------------------------

local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function (self, event, addon)
	if addon ~= "Blipstick" then return end

	BlipStickDB = BlipStickDB or {texture = "SmallExclaim"}
	self.db = BlipStickDB
	Minimap:SetBlipTexture(self.db.texture == "Default" and DEFAULTPATH or path..self.db.texture)

	self:UnregisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", nil)
end)


----------------------------
--      Config Panel      --
----------------------------

frame.name = "Blipstick"
frame:Hide()
frame:SetScript("OnShow", function(frame)
	local title, subtitle = LibStub("tekKonfig-Heading").new(frame, "Blipstick", "These settings let you select a different set of minimap blips to use.")

	local anchor, rows = subtitle, {}
	local function OnClick(self)
		frame.db.texture = self.texture
		Minimap:SetBlipTexture(self.texture)
		for _,row in pairs(rows) do row:SetChecked(row == self) end
	end
	for _,name in ipairs(textures) do
		local texture = name == "Default" and DEFAULTPATH or path..name

		local row = CreateFrame("CheckButton", nil, frame)
		row:SetHeight(ROWHEIGHT)
		row:SetPoint("TOP", anchor, "BOTTOM", 0, -GAP)
		row:SetPoint("LEFT", frame, "LEFT", EDGEGAP, 0)
		row:SetPoint("RIGHT", frame, "RIGHT", -EDGEGAP, 0)

		row:SetChecked(name == frame.db.texture)
		row.texture = texture
		row:SetScript("OnClick", OnClick)

		local highlight = row:CreateTexture()
		highlight:SetTexture("Interface\\HelpFrame\\HelpFrameButton-Highlight")
		highlight:SetTexCoord(0, 1, 0, 0.578125)
		highlight:SetAllPoints()
		row:SetHighlightTexture(highlight)
		row:SetCheckedTexture(highlight)

		local preview = row:CreateTexture()
		preview:SetPoint("TOPLEFT", row)
		preview:SetPoint("RIGHT", row, "CENTER", -GAP/2, 0)
		preview:SetPoint("BOTTOM", row)
		preview:SetTexture(texture)

		local text = row:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("LEFT", preview, "RIGHT", GAP, 0)
		text:SetPoint("RIGHT", row)
		text:SetText(name)

		table.insert(rows, row)
		anchor = row
	end

	frame:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(frame)


LibStub("tekKonfig-AboutPanel").new("Blipstick", "Blipstick")
