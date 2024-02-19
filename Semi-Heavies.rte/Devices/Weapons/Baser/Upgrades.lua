function BASERFLASH(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Flash Upgrade") == 0 then
			local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
			ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
			gun:SetNumberValue("Flash Upgrade", 1)
		end
	end
end
