local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local NP = E:GetModule('NamePlates')

function NP:Construct_PvPIndicator(nameplate)
	local PvPIndicator = nameplate:CreateTexture(nil, 'OVERLAY')
	PvPIndicator:SetSize(36, 36)
	PvPIndicator:SetPoint('CENTER', nameplate)
	PvPIndicator.Badge_ = nameplate:CreateTexture(nil, 'ARTWORK')
	PvPIndicator.Badge_:SetSize(50, 52)
	PvPIndicator.Badge_:SetPoint('CENTER', PvPIndicator, 'CENTER')

	function PvPIndicator:PostUpdate(unit, status)
		if not status then return end

		if (not self.Badge) or (self.Badge and not self.Badge:IsShown()) then
			if status ~= 'FFA' then
				self:SetAtlas('bfa-landingbutton-'..strlower(status)..'-up', true)
				self:SetTexCoord(0, 1, 0, 1)
			end
		end
	end

	return PvPIndicator
end

function NP:Update_PvPIndicator(nameplate)
	local db = NP.db.units[nameplate.frameType]

	if db.pvpindicator and db.pvpindicator.enable then
		if not nameplate:IsElementEnabled('PvPIndicator') then
			nameplate:EnableElement('PvPIndicator')
		end

		nameplate.PvPIndicator:SetSize(db.pvpindicator.size, db.pvpindicator.size)
		nameplate.PvPIndicator.Badge_:SetSize(db.pvpindicator.size + 14, db.pvpindicator.size + 16)

		nameplate.PvPIndicator.Badge = nil

		if db.pvpindicator.showBadge then
			nameplate.PvPIndicator.Badge = nameplate.PvPIndicator.Badge_
		end

		nameplate.PvPIndicator:ClearAllPoints()

		if db.pvpindicator.position == 'RIGHT' then
			nameplate.PvPIndicator:SetPoint('LEFT', nameplate, 'RIGHT', db.pvpindicator.xOffset, db.pvpindicator.yOffset)
		elseif db.pvpindicator.position == 'LEFT' then
			nameplate.PvPIndicator:SetPoint('RIGHT', nameplate, 'LEFT', db.pvpindicator.xOffset, db.pvpindicator.yOffset)
		else
			nameplate.PvPIndicator:SetPoint('CENTER', nameplate, 'CENTER', db.pvpindicator.xOffset, db.pvpindicator.yOffset)
		end
	else
		if nameplate:IsElementEnabled('PvPIndicator') then
			nameplate:DisableElement('PvPIndicator')
		end
	end
end