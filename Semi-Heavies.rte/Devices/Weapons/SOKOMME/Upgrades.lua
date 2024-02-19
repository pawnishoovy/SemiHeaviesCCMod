--introducing all new custom value system



function SOKOMMEREDDOT(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("RedDot") == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 10, ToAHuman(actor).Team);
			gun:SetNumberValue("RedDot", 2);
			if gun:GetNumberValue("Suppressor") == 2 then
				gun.SharpShakeRange = 1
			else
				gun.SharpShakeRange = 0.45
			end
		end
	end
end

function SOKOMMEMAG(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Mag") == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 10, ToAHuman(actor).Team);
			gun:SetNumberValue("Mag", 2);
			gun:SetNextMagazineName("Magazine SOKOMME Long")
			gun:Reload()
		end
	end
end


function SOKOMMESUPPRESSOR(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Suppressor") == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 3, ToAHuman(actor).Team);
			gun:SetNumberValue("Suppressor", 2);
			if gun:GetNumberValue("RedDot") == 2 then
				gun.SharpShakeRange = 1
			else
				gun.SharpShakeRange = 1.7
			end
		end
	end
end