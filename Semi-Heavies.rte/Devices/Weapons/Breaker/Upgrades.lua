function BREAKERLIGHT(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun.Sharpness == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 15, ToAHuman(actor).Team);
			gun.Sharpness = 2
			gun.RateOfFire = 60
		end		
	end
end

function BREAKERENGINE(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun.Sharpness ~= 3 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
			gun.Sharpness = 3
			gun.RateOfFire = 70
		end		
	end
end

function BREAKERSLUG(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then

		local gun = ToHDFirearm(gun);
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 10, ToAHuman(actor).Team);
		gun.ParticleSpreadRange = 0;
		gun:SetNextMagazineName("Magazine Breaker Slug");
		gun:SetNumberValue("Changed Magazine", 1)
		gun:SetNumberValue("AirBurst", 1)		
		
	end
end

function BREAKERBUCKSHOT(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then

		local gun = ToHDFirearm(gun);	
		gun.ParticleSpreadRange = 2;
		gun:SetNextMagazineName("Magazine Breaker");
		gun:SetNumberValue("Changed Magazine", 1)
		gun:SetNumberValue("AirBurst", 1)

	end
end

function BREAKERAIRBURST(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then

		local gun = ToHDFirearm(gun);	
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 20, ToAHuman(actor).Team);
		gun.ParticleSpreadRange = 0;
		gun:SetNextMagazineName("Magazine Breaker Airburst");
		gun:SetNumberValue("Changed Magazine", 1)
		gun:SetNumberValue("AirBurst", 2)

	end
end


