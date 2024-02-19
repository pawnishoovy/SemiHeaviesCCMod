function ADAPTBULLET(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Adapt");
		gun:Reload();
		gun.Sharpness = 1
	end
end

function ADAPTFLARE(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Adapt Flare");
		gun:Reload();
		gun.Sharpness = 2
	end
end

function ADAPTSHOT(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Adapt Shotgun");
		gun:Reload();
		gun.Sharpness = 3
	end
end