
function PLATHMG(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness == 1 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 120, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.RateOfFire = 450
		gun.Sharpness = 2
		gun.SharpShakeRange = 3
		gun.ShakeRange = 10
		gun.Mass = 12
		gun.BaseReloadTime = 3000
		gun.NoSupportFactor = 3
		gun.SharpLength = 200
		gun:SetNextMagazineName("Magazine Platform HMG")	
		gun:Reload()
	end
end

function PLATLMG(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness == 1 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 100, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.RateOfFire = 550
		gun.Sharpness = 3
		gun.SharpShakeRange = 2.5
		gun.ShakeRange = 8
		gun.Mass = 7
		gun.BaseReloadTime = 2500
		gun.NoSupportFactor = 2.5
		gun.SharpLength = 210
		gun:SetNextMagazineName("Magazine Platform LMG")
		gun:Reload()
	end
end

function PLATDMR(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness == 1 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 100, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.RateOfFire = 250
		gun.Sharpness = 4
		gun.SharpShakeRange = 1
		gun.ShakeRange = 5
		gun.Mass = 7
		gun.FullAuto = false
		gun.BaseReloadTime = 2300
		gun.NoSupportFactor = 2
		gun.SharpLength = 390
		gun:SetNextMagazineName("Magazine Platform DMR")
		gun:Reload()
	end
end

function PLATAR(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil and gun.Sharpness == 1 then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 60, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun.RateOfFire = 650
		gun.Sharpness = 5
		gun.SharpShakeRange = 2
		gun.ShakeRange = 4
		gun.Mass = 6
		gun.BaseReloadTime = 2100
		gun.NoSupportFactor = 1.4
		gun.SharpLength = 200
		gun:SetNextMagazineName("Magazine Platform AR")
		gun:Reload()
	end
end