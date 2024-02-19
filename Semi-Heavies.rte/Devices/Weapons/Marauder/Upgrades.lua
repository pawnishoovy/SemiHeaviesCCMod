function MARAUDERSCOPELARGE(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Scope") ~= 1 then
			gun:SetNumberValue("Scope", 1)
			gun.Mass = 20
			gun.SharpLength = 560
		end	
	end
end

function MARAUDERSCOPESMALL(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Scope") ~= 2 then
			gun:SetNumberValue("Scope", 2)
			gun.Mass = 18
			gun.SharpLength = 360
		end	
	end
end

function MARAUDERIRONSIGHTS(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		if gun:GetNumberValue("Scope") ~= 3 then
			gun:SetNumberValue("Scope", 3)
			gun.Mass = 16
			gun.SharpLength = 230
		end	
	end
end