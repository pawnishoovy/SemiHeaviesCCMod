
function REDHEAVY(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Red Heavy");
		gun:Reload();
	end
end

function REDMINI(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Red Mini");
		gun:Reload();
	end
end

function REDNORMAL(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Red");
		gun:Reload();
	end
end

function REDHYPER(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Hyper") == 1 then
			gun:SetNumberValue("Hyper", 2)
			gun.RateOfFire = 600
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 60, ToAHuman(actor).Team);
			gun.FullAuto = true;
		end
	end
end

function REDREMOVE(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Hyper") == 2 then
			gun:SetNumberValue("Hyper", 1)
			gun.RateOfFire = 120
			gun.FullAuto = false;
		end
	end
end