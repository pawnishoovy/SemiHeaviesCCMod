--really ugly code

-- 1 sharpness: no mods
-- 2 sharpness: feeding mechanism
-- 3 sharpness: barrel
-- 4 sharpness: hip
-- 5 sharpness: feed+barrel
-- 6 sharpness: feed+hip
-- 7 sharpness: barrel+hip
-- 8 sharpness: all 3


function MARFEEDING(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness ~= 2 and gun.Sharpness ~= 5 and gun.Sharpness ~= 6 and gun.Sharpness ~= 8 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.RateOfFire = 600
		if gun.Sharpness == 4 then
			gun.Sharpness = 6
		elseif gun.Sharpness == 7 then
			gun.Sharpness = 8
		elseif gun.Sharpness == 3 then
			gun.Sharpness = 5	
		elseif gun.Sharpness == 1 then
			gun.Sharpness = 2
		end	
	end
end

function MARBARREL(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness ~= 3 and gun.Sharpness ~= 5 and gun.Sharpness ~= 7 and gun.Sharpness ~= 8 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.SharpShakeRange = 1.5
		gun.SharpLength = 300
		if gun.Sharpness == 4 then
			gun.Sharpness = 7
		elseif gun.Sharpness == 6 then
			gun.Sharpness = 8
		elseif gun.Sharpness == 2 then
			gun.Sharpness = 5	
		elseif gun.Sharpness == 1 then
			gun.Sharpness = 3
		end
	end
end

function MARHIP(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness ~= 4 and gun.Sharpness ~= 6 and gun.Sharpness ~=  7 and gun.Sharpness ~= 8 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 40, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.ShakeRange = 2
		if gun.Sharpness == 3 then
			gun.Sharpness = 7
		elseif gun.Sharpness == 5 then
			gun.Sharpness = 8
		elseif gun.Sharpness == 2 then
			gun.Sharpness = 6	
		elseif gun.Sharpness == 1 then
			gun.Sharpness = 4
		end
	end
end