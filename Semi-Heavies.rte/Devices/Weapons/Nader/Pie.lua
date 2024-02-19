function NADEROVERUNDER(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 30, ToAHuman(actor).Team);
		local gun = ToHDFirearm(gun);
		gun:SetNumberValue("Magazine Type", 2)
		if gun:GetNumberValue("Round Type") == 1 then
			gun.BaseReloadTime = 3000
			gun:SetNextMagazineName("Magazine Nader Over Under")
			gun:Reload()
			gun.RateOfFire = 250	
		elseif gun:GetNumberValue("Round Type") == 2 then
			gun.BaseReloadTime = 3000
			gun:SetNextMagazineName("Magazine Nader Hellhound Over Under")
			gun:Reload()
			gun.RateOfFire = 250	
		elseif gun:GetNumberValue("Round Type") == 3 then
			gun.BaseReloadTime = 2500
			gun:SetNextMagazineName("Magazine Nader One-Shot WP")
			gun:Reload()
			gun.RateOfFire = 550	
			gun:SetNumberValue("Magazine Type", 1)
		end
	end
end

function NADERONESHOT(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNumberValue("Magazine Type", 1)
		if gun:GetNumberValue("Round Type") == 1 then
			gun.BaseReloadTime = 2500
			gun:SetNextMagazineName("Magazine Nader Basic")
			gun:Reload()
			gun.RateOfFire = 550
		elseif gun:GetNumberValue("Round Type") == 2 then
			gun.BaseReloadTime = 2500
			gun:SetNextMagazineName("Magazine Nader One-Shot Hellhound")
			gun:Reload()
			gun.RateOfFire = 550
		elseif gun:GetNumberValue("Round Type") == 3 then
			gun.BaseReloadTime = 2500
			gun:SetNextMagazineName("Magazine Nader One-Shot WP")
			gun:Reload()
			gun.RateOfFire = 550
			gun:SetNumberValue("Magazine Type", 1)
		end
	end
end

function NADERBASIC(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNumberValue("Round Type", 1)
		if gun:GetNumberValue("Magazine Type") == 3 then
			gun.BaseReloadTime = 4500
			gun:SetNextMagazineName("Magazine Nader Converted")	
			gun:Reload()
			gun.RateOfFire = 140
		elseif gun:GetNumberValue("Magazine Type") == 2 then
			gun.BaseReloadTime = 3000
			gun:SetNextMagazineName("Magazine Nader Over Under")
			gun:Reload()
			gun.RateOfFire = 250
		elseif gun:GetNumberValue("Magazine Type") == 1 then
			gun.BaseReloadTime = 2500
			gun:SetNextMagazineName("Magazine Nader Basic")
			gun:Reload()
			gun.RateOfFire = 550
		end
	end
end

function NADERWP(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 130, ToAHuman(actor).Team);

		if gun:GetNumberValue("Round Type") ~= 3 then
			gun:SetNumberValue("Stored Magazine", gun:GetNumberValue("Magazine Type"))
			gun:SetNumberValue("Stored Round", gun:GetNumberValue("Round Type"))
		end
		gun:SetNumberValue("Round Type", 3)
		gun:SetNumberValue("Magazine Type", 1)
		gun.BaseReloadTime = 2500
		gun:SetNextMagazineName("Magazine Nader One-Shot WP")
		gun:Reload()
		gun.RateOfFire = 550
	end
end


function NADERCONVERSION(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 60, ToAHuman(actor).Team);
		gun:SetNumberValue("Magazine Type", 3)
		if gun:GetNumberValue("Round Type") == 1 then
			gun.BaseReloadTime = 4500
			gun:SetNextMagazineName("Magazine Nader Converted")
			gun:Reload()
			gun.RateOfFire = 140
		elseif gun:GetNumberValue("Round Type") == 2 then
			gun.BaseReloadTime = 4500
			gun:SetNextMagazineName("Magazine Nader 5-Shot Hellhound")
			gun:Reload()
			gun.RateOfFire = 140
		elseif gun:GetNumberValue("Round Type") == 3 then
			gun.BaseReloadTime = 2500
			gun:SetNextMagazineName("Magazine Nader One-Shot WP")
			gun:Reload()
			gun.RateOfFire = 550
			gun:SetNumberValue("Magazine Type", 1)
		end
	end
end

function NADERHH(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		local Funds = ActivityMan:GetActivity():GetTeamFunds(ToAHuman(actor).Team);
		ActivityMan:GetActivity():SetTeamFunds(Funds - 100, ToAHuman(actor).Team);
		gun:SetNumberValue("Round Type", 2)
		if gun:GetNumberValue("Magazine Type") == 3 then
			gun.BaseReloadTime = 4500
			gun:SetNextMagazineName("Magazine Nader 5-Shot Hellhound")	
			gun:Reload()
			gun.RateOfFire = 140
		elseif gun:GetNumberValue("Magazine Type") == 2 then
			gun.BaseReloadTime = 3000
			gun:SetNextMagazineName("Magazine Nader Hellhound Over Under")
			gun:Reload()
			gun.RateOfFire = 250
		elseif gun:GetNumberValue("Magazine Type") == 1 then
			gun.BaseReloadTime = 2500
			gun:SetNextMagazineName("Magazine Nader One-Shot Hellhound")
			gun:Reload()
			gun.RateOfFire = 550
		end
	end
end

