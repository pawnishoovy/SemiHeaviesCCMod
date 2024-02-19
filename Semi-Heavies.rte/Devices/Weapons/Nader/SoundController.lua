function Create(self)
	
	self:SetNumberValue("Magazine Type", 1)
	self:SetNumberValue("Round Type", 1)
	self.reloadSFX = false

end

function Update(self)

	if self.FiredFrame and self:GetNumberValue("Round Type") == 3  then

		if self:GetNumberValue("Stored Magazine") == 3 then
			self:SetNumberValue("Magazine Type", 3)
			if self:GetNumberValue("Stored Round") == 1 then
				self:SetNumberValue("Round Type", 1)
				self.BaseReloadTime = 4500
				self:SetNextMagazineName("Magazine Nader Converted")
				self:Reload()
				self.RateOfFire = 140
			elseif self:GetNumberValue("Stored Round") == 2 then
				self:SetNumberValue("Round Type", 2)
				self.BaseReloadTime = 4500
				self:SetNextMagazineName("Magazine Nader 5-Shot Hellhound")
				self:Reload()
				self.RateOfFire = 140
			end

		elseif self:GetNumberValue("Stored Magazine") == 2 then
			self:SetNumberValue("Magazine Type", 2)
			if self:GetNumberValue("Stored Round") == 1 then
				self:SetNumberValue("Round Type", 1)
				self.BaseReloadTime = 3000
				self:SetNextMagazineName("Magazine Nader Over Under")
				self:Reload()
				self.RateOfFire = 250	
			elseif self:GetNumberValue("Stored Round") == 2 then
				self:SetNumberValue("Round Type", 2)
				self.BaseReloadTime = 3000
				self:SetNextMagazineName("Magazine Nader Hellhound Over Under")
				self:Reload()
				self.RateOfFire = 250	
			end

		elseif self:GetNumberValue("Stored Magazine") == 1 then
			self:SetNumberValue("Magazine Type", 1)
			if self:GetNumberValue("Stored Round") == 1 then
				self:SetNumberValue("Round Type", 1)
				self.BaseReloadTime = 2500
				self:SetNextMagazineName("Magazine Nader Basic")
				self:Reload()
				self.RateOfFire = 550
			elseif self:GetNumberValue("Stored Round") == 2 then
				self:SetNumberValue("Round Type", 2)
				self.BaseReloadTime = 2500
				self:SetNextMagazineName("Magazine Nader One-Shot Hellhound")
				self:Reload()
				self.RateOfFire = 550
			end
		end
	end
		

	if self.Magazine then
		self.roundsWasted = self.Magazine.RoundCount;
		if self:GetNumberValue("Magazine Type") == 1 then
			self.BaseReloadTime = 2000;
		end
		if self:GetNumberValue("Magazine Type") == 2 and self.roundsWasted == 1 then
			self.BaseReloadTime = 2000;
		else
			self.BaseReloadTime = 3000;
		end
		if self:GetNumberValue("Magazine Type") == 3 then
			if self.roundsWasted == 5 then
				self.BaseReloadTime = 2500;
			elseif self.roundsWasted == 4 then
				self.BaseReloadTime = 2500;
			elseif self.roundsWasted == 3 then
				self.BaseReloadTime = 3000;
			elseif self.roundsWasted == 2 then
				self.BaseReloadTime = 3500;
			elseif self.roundsWasted == 1 then
				self.BaseReloadTime = 4000;
			elseif self.roundsWasted == 0 then
				self.BaseReloadTime = 4500;
			end
		end
	end
	
	if self:IsReloading() and self.reloadSFX == false then

		
		if self:GetNumberValue("Magazine Type") == 1 then

			reloadsfx = CreateAEmitter("Nader Reload Basic");
			reloadsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadsfx);

			self.reloadSFX = true;

		elseif self:GetNumberValue("Magazine Type") == 2 then

			if self.roundsWasted == 1 then

				reloadsfx = CreateAEmitter("Nader Reload Basic");
				reloadsfx.Pos = self.Pos;
				MovableMan:AddParticle(reloadsfx);

				self.reloadSFX = true;
			else
				reloadsfx = CreateAEmitter("Nader Reload Over Under");
				reloadsfx.Pos = self.Pos;
				MovableMan:AddParticle(reloadsfx);

				self.reloadSFX = true;
			end

		elseif self:GetNumberValue("Magazine Type") == 3 then

			if self.BaseReloadTime == 4500 then

				reloadsfx = CreateAEmitter("Nader Reload 5");
				reloadsfx.Pos = self.Pos;
				MovableMan:AddParticle(reloadsfx);

				self.reloadSFX = true;

			elseif self.BaseReloadTime == 4000 then
				
				reloadsfx = CreateAEmitter("Nader Reload 4");
				reloadsfx.Pos = self.Pos;
				MovableMan:AddParticle(reloadsfx);

				self.reloadSFX = true;


			elseif self.BaseReloadTime == 3500 then
				
				reloadsfx = CreateAEmitter("Nader Reload 3");
				reloadsfx.Pos = self.Pos;
				MovableMan:AddParticle(reloadsfx);

				self.reloadSFX = true;

			elseif self.BaseReloadTime == 3000 then
				
				reloadsfx = CreateAEmitter("Nader Reload Over Under");
				reloadsfx.Pos = self.Pos;
				MovableMan:AddParticle(reloadsfx);

				self.reloadSFX = true;

			elseif self.BaseReloadTime == 2500 then
				
				reloadsfx = CreateAEmitter("Nader Reload Basic");
				reloadsfx.Pos = self.Pos;
				MovableMan:AddParticle(reloadsfx);

				self.reloadSFX = true;
			end

		elseif self:GetNumberValue("Magazine Type") == 4 then

			reloadsfx = CreateAEmitter("Platform Reload Start DMR");
			reloadsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadsfx);

			self.reloadSFX = true;

		elseif self:GetNumberValue("Magazine Type") == 5 then

			reloadsfx = CreateAEmitter("Platform Reload Start AR");
			reloadsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadsfx);

			self.reloadSFX = true;

		end
	end
	if not self:IsReloading() then
		self.reloadSFX = false;
	end
	if self:DoneReloading() then
		self.reloadSFX = false;
	end	
end


