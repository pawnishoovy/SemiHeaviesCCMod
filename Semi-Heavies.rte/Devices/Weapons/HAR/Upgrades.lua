function HARACCUPGRADES(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("ACCUPGRADES") == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
			gun:SetNumberValue("ACCUPGRADES", 2)

		end	
	end
end

function HARBARRELUPGRADE(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("BARRELUPGRADE") == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 25, ToAHuman(actor).Team);
			gun:SetNumberValue("BARRELUPGRADE", 2)

		end	
	end
end

function HARROFUPGRADE(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("ROFUPGRADE") == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 35, ToAHuman(actor).Team);
			gun:SetNumberValue("ROFUPGRADE", 2)
			gun.RateOfFire = 370
		end	
	end
end

function HARROFOVERDRIVE(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("ROFUPGRADE") == 1 or gun:GetNumberValue("ROFUPGRADE") == 2 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 60, ToAHuman(actor).Team);
			gun:SetNumberValue("ROFUPGRADE", 3)
			gun.RateOfFire = 550
		end	
	end
end
