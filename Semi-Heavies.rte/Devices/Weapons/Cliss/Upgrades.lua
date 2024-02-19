--really ugly code, again

-- 1 sharpness: no mods
-- 2 sharpness: reddot
-- 3 sharpness: ergonomic grip
-- 4 sharpness: both



function CLISSMAG(actor)
	local gun = ToAHuman(actor).EquippedItem;

--custom values decided not to work (NumberValueExists is a nil method, sure game)
--had to do hacky stuff with gun mass
-- if you know why pm me

	if gun ~= nil and gun.Mass == 6 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 10, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Cliss Long");
		gun:Reload();
		gun.Mass = 3.01
	end
end

function CLISSREDDOT(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness ~= 2 and gun.Sharpness ~= 4 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 25, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.SharpShakeRange = 3
		if gun.Sharpness == 3 then
			gun.Sharpness = 4
		elseif gun.Sharpness == 1 then
			gun.Sharpness = 2
		end	
	end
end

function CLISSGRIP(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness ~= 3 and gun.Sharpness ~= 4 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.ShakeRange = 3.5
		if gun.Sharpness == 2 then
			gun.Sharpness = 4
		elseif gun.Sharpness == 1 then
			gun.Sharpness = 3
		end	
	end
end