
local path = "Interface\\AddOns\\Blipstick\\"
local textures = {
	["Default"] = "Interface\\Minimap\\ObjectIcons",
	["SmallExclaim"] = path.."SmallExclaim",
	["LittleExclaim"] = path.."LittleExclaim",
	["Nandini black"] = path.."Nandini-black",
	["Nandini original"] = path.."Nandini",
	["AlternateBlips"] = path.."AlternateBlips",
}

Minimap:SetBlipTexture("Interface\\AddOns\\Blipstick\\SmallExclaim")





----------------------
--      Locals      --
----------------------

local GAP, EDGEGAP = 8, 16


---------------------
--      Panel      --
---------------------

local frame = CreateFrame("Frame", nil, UIParent)
frame.name = "Blipstick"
frame:Hide()
frame:SetScript("OnShow", function(frame)
	local title, subtitle = LibStub("tekKonfig-Heading").new(frame, "Blipstick", "These settings let you select a different set of minimap blips to use.")

	local anchor = subtitle
	for name,texture in pairs(textures) do
		local demo = frame:CreateTexture()
		demo:SetPoint("TOP", anchor, "BOTTOM", 0, -GAP)
		demo:SetPoint("LEFT", frame, "LEFT", EDGEGAP, 0)
		demo:SetPoint("RIGHT", frame, "CENTER", -GAP/2, 0)
		demo:SetHeight(64*demo:GetWidth()/256)
		demo:SetTexture(texture)

		local text = frame:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("LEFT", demo, "RIGHT", GAP, 0)
		text:SetPoint("RIGHT", frame, "RIGHT", -EDGEGAP, 0)
		text:SetText(name)

		anchor = demo
	end

	frame:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(frame)


LibStub("tekKonfig-AboutPanel").new("Blipstick", "Blipstick")
