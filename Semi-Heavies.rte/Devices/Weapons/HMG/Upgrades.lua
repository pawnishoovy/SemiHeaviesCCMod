function HMGCHARGE(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("CHARGEUPGRADE") == 0 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 20, ToAHuman(actor).Team);
			gun:SetNumberValue("CHARGEUPGRADE", 1);
			gun.RateOfFire = 1400;

		end	
	end
end

function HMGNORMAL(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("CHARGEUPGRADE") == 1 then
			gun:SetNumberValue("CHARGEUPGRADE", 0);
			gun.RateOfFire = 800;

		end	
	end
end

function HMGCLEAR(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if not gun:NumberValueExists("Chambering") and not gun:NumberValueExists("Reloading") then
			gun:SetNumberValue("Clearing Jam", 1);
		end	
	end
end

