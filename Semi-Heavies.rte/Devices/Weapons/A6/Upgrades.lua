function A6SKELETAL(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Skeletal") == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 15, ToAHuman(actor).Team);
			gun:SetNumberValue("Skeletal", 2)
			gun.Mass = 1
		end	
	end
end

function A6PLUSP(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("+P") == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 10, ToAHuman(actor).Team);
			gun:SetNumberValue("+P", 2)
			gun:SetNextMagazineName("Magazine A6 +P")
			gun:Reload()
		end	
	end
end