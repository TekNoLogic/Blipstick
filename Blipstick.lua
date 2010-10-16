
----------------------
--      Locals      --
----------------------

local DEFAULTPATH = "Interface\\Minimap\\ObjectIcons"

local path = "Interface\\AddOns\\Blipstick\\"
local textures = {"Default", "SmallExclaim", "LittleExclaim", "Nandini", "Nandini-black", "AlternateBlips", "HunterZSmall", "Charmed"}


------------------------------
--      Initialization      --
------------------------------

local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function (self, event, addon)
	if addon ~= "Blipstick" then return end

	BlipStickDB = BlipStickDB or {texture = path.."SmallExclaim"}
	self.db = BlipStickDB
	Minimap:SetBlipTexture(self.db.texture)

	self:UnregisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", nil)
end)


----------------------------
--      Config Panel      --
----------------------------

frame.name = "Blipstick"
frame:Hide()
frame:SetScript("OnShow", function(frame)
	local GAP, EDGEGAP, TEXTHEIGHT, TEXTOFFSET, HIGHLIGHTOFFSET = 8, 16, 13, 5, 8
	local ROWHEIGHT = (408-73-EDGEGAP) / (#textures/2) - GAP

	local title, subtitle = LibStub("tekKonfig-Heading").new(frame, "Blipstick", "These settings let you select a different set of minimap blips to use.")

	local anchor, rows = subtitle, {}
	local function OnClick(self)
		frame.db.texture = self.texture
		Minimap:SetBlipTexture(self.texture)
		for _,row in pairs(rows) do row:SetChecked(row == self) end
	end
	for i,name in ipairs(textures) do
		local leftside = ((i % 2) == 1)
		local texture = name == "Default" and DEFAULTPATH or path..name

		local row = CreateFrame("CheckButton", nil, frame)
		row:SetHeight(ROWHEIGHT)
		row:SetPoint("TOP", anchor, "BOTTOM", 0, -GAP)
		if leftside then
			row:SetPoint("LEFT", frame, "LEFT", EDGEGAP, 0)
			row:SetPoint("RIGHT", frame, "CENTER")
		else
			row:SetPoint("LEFT", frame, "CENTER")
			row:SetPoint("RIGHT", frame, "RIGHT", -EDGEGAP, 0)
		end

		row:SetChecked(texture == frame.db.texture)
		row.texture = texture
		row:SetScript("OnClick", OnClick)

		local highlight = row:CreateTexture()
		highlight:SetTexture("Interface\\HelpFrame\\HelpFrameButton-Highlight")
		highlight:SetTexCoord(0, 1, 0, 0.578125)
		row:SetHighlightTexture(highlight)
		row:SetCheckedTexture(highlight)

		local preview = row:CreateTexture()
		preview:SetWidth((ROWHEIGHT - TEXTHEIGHT - TEXTOFFSET)*2) -- Maintain proper aspect
		preview:SetPoint("TOP", row)
		preview:SetPoint("BOTTOM", row, 0, TEXTHEIGHT + TEXTOFFSET)
		preview:SetTexture(texture)

		local text = row:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("TOP", preview, "BOTTOM")
		text:SetText(name)

		highlight:SetPoint("TOPLEFT", preview, -HIGHLIGHTOFFSET, HIGHLIGHTOFFSET)
		highlight:SetPoint("RIGHT", preview, HIGHLIGHTOFFSET, 0)
		highlight:SetPoint("BOTTOM", text, 0, -TEXTOFFSET - HIGHLIGHTOFFSET)

		table.insert(rows, row)
		anchor = not leftside and row or anchor
	end

	frame:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(frame)


LibStub("tekKonfig-AboutPanel").new("Blipstick", "Blipstick")


----------------------------------------
--      Quicklaunch registration      --
----------------------------------------

LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Blipstick", {
	type = "launcher",
	icon = "Interface\\AddOns\\Blipstick\\icon",
	OnClick = function() InterfaceOptionsFrame_OpenToCategory(frame) end,
})
