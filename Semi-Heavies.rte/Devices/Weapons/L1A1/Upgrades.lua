function L1A1FULL(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun.FullAuto = true
	end
end

function L1A1SEMI(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun.FullAuto = false
	end
end

function L1A1MODERN(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Modern") == 0 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 25, ToAHuman(actor).Team);
			gun:SetNumberValue("Modern", 1)
			gun.RateOfFire = 530
			gun.SharpShakeRange = 1.30
			gun.Mass = 6
		end
	end
end

function L1A1MAG(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 10, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine L1A1 Modern");
		gun:Reload();
	end
end