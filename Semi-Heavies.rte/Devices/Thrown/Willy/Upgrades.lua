function WPFRAGS(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToTDExplosive(gun);
		if gun:GetNumberValue("Frags") == 1 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 10, ToAHuman(actor).Team);
			gun:SetNumberValue("Frags", 2)
			gun.Sharpness = 2
		end
	end
end