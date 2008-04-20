
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

local tekcheck = LibStub("tekKonfig-Checkbox")
local tekslider = LibStub("tekKonfig-Slider")
local GAP, EDGEGAP = 8, 16


---------------------
--      Panel      --
---------------------

local frame = CreateFrame("Frame", nil, UIParent)
frame.name = "Blipstick"
frame:Hide()
frame:SetScript("OnShow", function(frame)
--~ 	local ControlFreak = ControlFreak
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

--~ 	local lockpos = tekcheck.new(frame, nil, "Lock frame", "TOPLEFT", subtitle, "BOTTOMLEFT", -2, -GAP)
--~ 	lockpos.tiptext = "Locks the frame to prevent accidental movement"
--~ 	local checksound = lockpos:GetScript("OnClick")
--~ 	lockpos:SetScript("OnClick", function(self) checksound(self); ControlFreak.db.char.frameopts.locked = not ControlFreak.db.char.frameopts.locked end)
--~ 	lockpos:SetChecked(ControlFreak.db.char.frameopts.locked)


--~ 	local showtip = tekcheck.new(frame, nil, "Show tooltip", "TOPLEFT", lockpos, "BOTTOMLEFT", 0, -GAP)
--~ 	showtip.tiptext = "Show help tooltip on hover"
--~ 	showtip:SetScript("OnClick", function(self) checksound(self); ControlFreak.db.char.showtooltip = not ControlFreak.db.char.showtooltip end)
--~ 	showtip:SetChecked(ControlFreak.db.char.showtooltip)


--~ 	local threshslider, threshslidertext, threshcontainer = tekslider.new(frame, "Break Threshold: "..ControlFreak.db.char.breakthreshold.." sec", 0, 10, "LEFT", frame, "TOP", GAP, 0)
--~ 	threshcontainer:SetPoint("TOP", lockpos, "TOP", 0, 0)
--~ 	threshslider.tiptext = "Time (in seconds) before spell breaks to unfade frame."
--~ 	threshslider:SetValue(ControlFreak.db.char.breakthreshold)
--~ 	threshslider:SetValueStep(1)
--~ 	threshslider:SetScript("OnValueChanged", function()
--~ 		ControlFreak.db.char.breakthreshold = threshslider:GetValue()
--~ 		threshslidertext:SetText("Break Threshold: "..ControlFreak.db.char.breakthreshold.." sec")
--~ 	end)


--~ 	local alpha = math.floor(ControlFreak.db.char.alpha*100 + .5)
--~ 	local alphaslider, alphaslidertext = tekslider.new(frame, "Alpha: "..alpha.."%", "0%", "100%", "TOP", threshcontainer, "BOTTOM", 0, -GAP)
--~ 	alphaslider:SetPoint("LEFT", threshslider, "LEFT")
--~ 	alphaslider.tiptext = "Alpha level to fade frame to when focus is controlled, dead, or not set."
--~ 	alphaslider:SetValue(ControlFreak.db.char.alpha)
--~ 	alphaslider:SetValueStep(0.05)
--~ 	alphaslider:SetScript("OnValueChanged", function()
--~ 		ControlFreak.db.char.alpha = alphaslider:GetValue()
--~ 		local alpha = math.floor(ControlFreak.db.char.alpha*100 + .5)
--~ 		alphaslidertext:SetText("Alpha: "..alpha.."%")
--~ 		ControlFreak:OnUpdate(true)
--~ 	end)


	frame:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(frame)


LibStub("tekKonfig-AboutPanel").new("Blipstick", "Blipstick")
