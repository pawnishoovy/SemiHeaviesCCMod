--its only slightly ugly this time cuz theres only 1 mod

-- 1 sharpness: no mods
-- 2 sharpness: sniper scope



function ROAMERDUAPIT(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Roamer DUAP-I-T");
		gun:Reload();
	end
end

function ROAMERNORMAL(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Roamer");
		gun:Reload();
	end
end


function ROAMERSCOPE(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness == 1 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 25, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.Sharpness = 2
		gun.SharpLength = 450
		gun.SharpShakeRange = 0.3
	end
end