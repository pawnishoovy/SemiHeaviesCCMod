function PUMPERSTOCK(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness == 1 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 20, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.RateOfFire = 200
		gun.Sharpness = 2
			
	end
end

function PUMPERDB(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 5, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Pumper DB")
		gun:SetNumberValue("DB", 2)
		gun:Reload()
		gun:SetNumberValue("Changed Magazine", 1)			
	end
end

function PUMPERNORMAL(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Pumper")
		gun:SetNumberValue("DB", 1)
		gun:Reload()	
		gun:SetNumberValue("Changed Magazine", 1)	
	end
end