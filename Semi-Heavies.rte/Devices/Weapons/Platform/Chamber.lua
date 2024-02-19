
function Create(self)

	self.parent = nil;
	self.pullTimer = Timer();

	self.newMag = false;
	self.chamber = true;		--
	--self.pullTimer:Reset();	--
	self.num = math.pi;		--
	self.sfx = true;		--
	self.reloadSFX = false
	self.reloadEndSFX = false

	self.negNum = 0;
	self.sLength = self.SharpLength;
	self.ShakeRange = 6
	self.sRange = self.ShakeRange
	self.lifeTimer = Timer();
	self.lifeTimerReset = false

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	end
end

function Update(self)		
		
		
	if self.Sharpness == 1 then
		self.pullDelay = 300
		self:SetNumberValue("Pulldelay", self.pullDelay)
		self:SetNumberValue("Conversion", 1)
	elseif self.Sharpness == 2 then
		self.pullDelay = 4900
		self:SetNumberValue("Pulldelay", self.pullDelay)
		self:SetNumberValue("Conversion", 2)
	elseif self.Sharpness == 3 then
		self.pullDelay = 400
		self:SetNumberValue("Pulldelay", self.pullDelay)
			self:SetNumberValue("Conversion", 3)
	elseif self.Sharpness == 4 then
		self.pullDelay = 350
		self:SetNumberValue("Pulldelay", self.pullDelay)
		self:SetNumberValue("Conversion", 4)
	elseif self.Sharpness == 5 then
		self.pullDelay = 300
		self:SetNumberValue("Pulldelay", self.pullDelay)
		self:SetNumberValue("Conversion", 5)
	end
	if self.ShakeRange == 8 or self.ShakeRange == 5 or self.ShakeRange == 4 or self.ShakeRange == 10 then
		self.sRange = self.ShakeRange
	end

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	else
		self.parent = nil;
	-- cock and load on pickup
		--self.chamber = true;	--
		--self.pullTimer:Reset();	--
		--self.num = math.pi;	--
		--self.sfx = true;	--
	end

	if self.HFlipped then
		self.negNum = -1;
	else
		self.negNum = 1;
	end

	if self.parent then

		if self.Magazine then

			if self.newMag == true then

				self.chamber = true;
				self.pullTimer:Reset();
				self.num = math.pi;
				self.sfx = true;

				self.newMag = false;
			end
		else
			self.newMag = true;
		end

		if self.chamber == true then

			self:SetNumberValue("Chambering", 1)
			self:Deactivate();
			--self.parent:GetController():SetState(Controller.WEAPON_FIRE,false);

			if self.pullTimer:IsPastSimMS(self.pullDelay) then
				--self.parent:GetController():SetState(Controller.AIM_SHARP,false);
				--self.Frame = 1;
				

				if self.sfx ~= false then
					if self.Sharpness == 1 then
						sfx = CreateAEmitter("Chamber LG612 Gun Platform Empty");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
	
						self.sfx = false;
					elseif self.Sharpness == 2 then
						sfx = CreateAEmitter("Chamber LG612 Gun Platform HMG");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
	
						self.sfx = false;
					elseif self.Sharpness == 3 then
						sfx = CreateAEmitter("Chamber LG612 Gun Platform LMG");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
	
						self.sfx = false;
					elseif self.Sharpness == 4 then
						sfx = CreateAEmitter("Chamber LG612 Gun Platform DMR");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
	
						self.sfx = false;
					elseif self.Sharpness == 5 then
						sfx = CreateAEmitter("Chamber LG612 Gun Platform AR");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
	
						self.sfx = false;
					end
				end
				

				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.num)/2;

				self:SetNumberValue("ChamberRot", self.RotAngle)

				self.num = self.num - math.pi*0.08;
			end

			if self.num <= 0 then
			
				self.num = 0;
				self.chamber = false;
				self.ShakeRange = self.sRange
				self:RemoveNumberValue("Chambering")
				self:RemoveNumberValue("ChamberRot")
			end
		end
	end
	if self:IsReloading() and self.reloadSFX == false then

		self.reloadEndSFX = false
		
		if self.Sharpness == 1 then

			reloadsfx = CreateAEmitter("Platform Reload Start Empty");
			reloadsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadsfx);

			self.reloadSFX = true;

		elseif self.Sharpness == 2 then

			reloadsfx = CreateAEmitter("Platform Reload Start HMG");
			reloadsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadsfx);

			self.reloadSFX = true;

		elseif self.Sharpness == 3 then

			reloadsfx = CreateAEmitter("Platform Reload Start LMG");
			reloadsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadsfx);

			self.reloadSFX = true;

		elseif self.Sharpness == 4 then

			reloadsfx = CreateAEmitter("Platform Reload Start DMR");
			reloadsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadsfx);

			self.reloadSFX = true;

		elseif self.Sharpness == 5 then

			reloadsfx = CreateAEmitter("Platform Reload Start AR");
			reloadsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadsfx);

			self.reloadSFX = true;

		end
	end

	if self:DoneReloading() and self.reloadEndSFX == false then

		self.reloadSFX = false

		if self.Sharpness == 1 then

			reloadendsfx = CreateAEmitter("Platform Reload End Empty");
			reloadendsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadendsfx);

			self.reloadEndSFX = true;

		elseif self.Sharpness == 2 then

			reloadendsfx = CreateAEmitter("Platform Reload End HMG");
			reloadendsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadendsfx);

			self.reloadEndSFX = true;

		elseif self.Sharpness == 3 then

			reloadendsfx = CreateAEmitter("Platform Reload End LMG");
			reloadendsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadendsfx);

			self.reloadEndSFX = true;

		elseif self.Sharpness == 4 then

			reloadendsfx = CreateAEmitter("Platform Reload End DMR");
			reloadendsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadendsfx);

			self.reloadEndSFX = true;

		elseif self.Sharpness == 5 then

			reloadendsfx = CreateAEmitter("Platform Reload End AR");
			reloadendsfx.Pos = self.Pos;
			MovableMan:AddParticle(reloadendsfx);

			self.reloadEndSFX = true;

		end
	end			
end