
----------------------
--      Locals      --
----------------------

local DEFAULTPATH = "Interface\\Minimap\\ObjectIcons"

local path = "Interface\\AddOns\\Blipstick\\"
local textures = {"Default", "SmallExclaim", "LittleExclaim", "Nandini", "Nandini-black", "AlternateBlips", "HunterZSmall", "Charmed"}


------------------------------
--      Initialization      --
------------------------------

if AddonLoader and AddonLoader.RemoveInterfaceOptions then AddonLoader:RemoveInterfaceOptions("Blipstick") end

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
	local GAP, EDGEGAP, TEXTHEIGHT, TEXTOFFSET = 8, 16, 13, 5
	local ROWHEIGHT = (408-73-EDGEGAP) / (#textures/3) - GAP
	local COLWIDTH = (623-EDGEGAP*2-GAP*2) / 3

	local title, subtitle = LibStub("tekKonfig-Heading").new(frame, "Blipstick", "These settings let you select a different set of minimap blips to use.")

	local anchor, rows, lastcol = subtitle, {}
	local function OnClick(self)
		frame.db.texture = self.texture
		Minimap:SetBlipTexture(self.texture)
		for _,row in pairs(rows) do row:SetChecked(row == self) end
	end
	for i,name in ipairs(textures) do
		local newrow = ((i % 3) == 1)
		local texture = name == "Default" and DEFAULTPATH or path..name

		local row = CreateFrame("CheckButton", nil, frame)
		row:SetHeight(ROWHEIGHT)
		row:SetWidth(COLWIDTH)
		if newrow then
			row:SetPoint("TOP", anchor, "BOTTOM", 0, -GAP)
			row:SetPoint("LEFT", frame, "LEFT", EDGEGAP, 0)
		else
			row:SetPoint("TOPLEFT", lastcol, "TOPRIGHT", GAP, 0)
		end

		row:SetChecked(texture == frame.db.texture)
		row.texture = texture
		row:SetScript("OnClick", OnClick)

		local highlight = row:CreateTexture()
		highlight:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
		highlight:SetVertexColor(.196, .388, .8, 0.75)
		row:SetHighlightTexture(highlight)
		row:SetCheckedTexture(highlight)

		local preview = row:CreateTexture()
		preview:SetWidth((ROWHEIGHT - TEXTHEIGHT - TEXTOFFSET)*8/7) -- Maintain proper aspect
		preview:SetPoint("TOP", row)
		preview:SetPoint("BOTTOM", row, 0, TEXTHEIGHT + TEXTOFFSET)
		preview:SetTexture(texture)

		local text = row:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("TOP", preview, "BOTTOM")
		text:SetText(name)

		highlight:SetPoint("TOPLEFT", preview, 0, TEXTOFFSET)
		highlight:SetPoint("RIGHT", preview, 0, 0)
		highlight:SetPoint("BOTTOM", text, 0, -TEXTOFFSET)

		table.insert(rows, row)
		anchor = not newrow and row or anchor
		lastcol = row
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
