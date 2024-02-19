function Create(self)

	self.parent = nil;
	self.pullTimer = Timer();
	self.pullTimerTwo = Timer();
	self.reloadEndTimer = Timer();
	self.smokeTimer = Timer();
	self.initialTimer = Timer(); -- workaround for it smoking at creation, relic from old code

	-- custom for pump timing to change with upgrades
	self.pullDelay = 600;
	self.cockTotalTime = 320;

	self.newMag = false;
	self.chamber = true;
	self.num = math.pi;
	self.sfxOne = true;
	self.sfxTwo = true;
	self.sfxSetShot = true;
	self.sfxSetMech = true;
	self.sfxSetTail = true;
	self.casing = false;
	self.Intrerrupted = false;
	self.manualReload = true;
	self.sfxReloadStart = true;
	self.sfxReloadEnd = false;
	self.reloadEnd = false;

	self.negNum = 0;
	self:SetNumberValue("AirBurst", 1)

	if self.Magazine then
		self.lastAmmo = self.Magazine.RoundCount;
	end

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	end
	self.reloadTimer = Timer();
	self.loadedShell = false;
	self.reloadCycle = false;

	self.reloadDelay = 200;

	if self.Magazine then
		self.ammoCounter = self.Magazine.RoundCount;
	else
		self.ammoCounter = 0;
	end
end

function Update(self)

	if self:GetNumberValue("Changed Magazine") == 1 then
	
		for i = 1, self.lastAmmo do
			casing = CreateAEmitter("Breaker Shell Unspent");
			casing.Pos = self.Pos+Vector(2*self.negNum,-2):RadRotate(self.RotAngle);
			casing.Vel = self.Vel+Vector(-math.random(4,8)*self.negNum,-math.random(2,6)):RadRotate(self.RotAngle);
			MovableMan:AddParticle(casing);
		end
			
		self.lastAmmo = 0;
		self.ammoCounter = 0;
		self:Reload();
		self:RemoveNumberValue("Changed Magazine");
	end
	
	if self.Sharpness == 2 then
		self.pullDelay = 500;
		self.cockTotalTime = 260;
	elseif self.Sharpness == 3 then
		self.pullDelay = 400;
		self.cockTotalTime = 200
	end

	if self.HFlipped then
		self.negNum = -1;
	else
		self.negNum = 1;
	end

	if self.initialTimer:IsPastSimMS(2500) then
		if self.smokeTimer:IsPastSimMS(2500) ~= true then 

			if math.random(100) > 97 then

				gfx = CreateMOSParticle("Tiny Smoke Ball 1");
				gfx.Pos = self.MuzzlePos;
				gfx.Vel = self.Vel + Vector(0,-1)

				MovableMan:AddParticle(gfx);
			end

		end
	end
	if self.initialTimer:IsPastSimMS(2500) then
		if self.smokeTimer:IsPastSimMS(100) ~= true then 

			if math.random(100) > 95 then

				gfx = CreateMOSParticle("Breaker Smoke");
				gfx.Pos = self.MuzzlePos;
				gfx.Vel = self.Vel;

				MovableMan:AddParticle(gfx);
			end

		end
	end
	
	if self.FiredFrame then

		self:RemoveNumberValue("ReloadEnded")

		self.Intrerrupted = false;
		self.manualReload = true;
		self.sfxReloadStart = true;
		self.smokeTimer:Reset();

		if self:GetNumberValue("AirBurst") == 1 then

			for i = 1, 2 do
				gfx = CreateMOSParticle("Side Thruster Blast Ball 1");
				gfx.Pos = self.MuzzlePos;
				gfx.Vel = self:RotateOffset(Vector(RangeRand(-2,2), RangeRand(7,11)))

				MovableMan:AddParticle(gfx);
			end
			for i = 1, 5 do
				gfx = CreateMOSParticle("Tiny Smoke Ball 1");
				gfx.Pos = self.MuzzlePos;
				gfx.Vel = self:RotateOffset(Vector(RangeRand(-2,2), RangeRand(7,11)))

				MovableMan:AddParticle(gfx);
			end
			for i = 1, 2 do
				gfx = CreateMOSParticle("Breaker Smoke");
				gfx.Pos = self.MuzzlePos;
				gfx.Vel = self:RotateOffset(Vector(RangeRand(-2,2), RangeRand(7,11)))

				MovableMan:AddParticle(gfx);
			end
			for i = 1, 2 do
				gfx = CreateMOSParticle("Side Thruster Blast Ball 1");
				gfx.Pos = self.MuzzlePos;
				gfx.Vel = self:RotateOffset(Vector(RangeRand(-2,2), -RangeRand(7,11)))

				MovableMan:AddParticle(gfx);
			end
			for i = 1, 5 do
				gfx = CreateMOSParticle("Tiny Smoke Ball 1");
				gfx.Pos = self.MuzzlePos;
				gfx.Vel = self:RotateOffset(Vector(RangeRand(-2,2), -RangeRand(7,11)))

				MovableMan:AddParticle(gfx);
			end
			for i = 1, 2 do
				gfx = CreateMOSParticle("Breaker Smoke");
				gfx.Pos = self.MuzzlePos;
				gfx.Vel = self:RotateOffset(Vector(RangeRand(-2,2), -RangeRand(7,11)))

				MovableMan:AddParticle(gfx);
			end
		end

		for i = 1, 5 do
			gfx = CreateMOSParticle("Side Thruster Blast Ball 1");
			gfx.Pos = self.MuzzlePos;
			gfx.Vel = (self.Vel + Vector(RangeRand(-30,30), RangeRand(-30,30))) / 5 + Vector(15*self.negNum,0):RadRotate(self.RotAngle)

			MovableMan:AddParticle(gfx);
		end
		
		for i = 1, 10 do
			gfx = CreateMOSParticle("Tiny Smoke Ball 1");
			gfx.Pos = self.MuzzlePos;
			gfx.Vel = (self.Vel + Vector(RangeRand(-30,30), RangeRand(-30,30))) / 5 + Vector(15*self.negNum,0):RadRotate(self.RotAngle)

			MovableMan:AddParticle(gfx);
		end
		for i = 1, 5 do
			gfx = CreateMOSParticle("Breaker Smoke");
			gfx.Pos = self.MuzzlePos;
			gfx.Vel = (self.Vel + Vector(RangeRand(-30,30), RangeRand(-30,30))) / 5 + Vector(15*self.negNum,0):RadRotate(self.RotAngle)

			MovableMan:AddParticle(gfx);
		end

		if self.sfxSetShot ~= false then
		
			if self:GetNumberValue("AirBurst") == 1 then

				sfxSetShot = CreateAEmitter("Shot Breaker");
				sfxSetShot.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetShot);
				
			else
			
				sfxSetShot = CreateAEmitter("Shot Breaker Airburst");
				sfxSetShot.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetShot);
				
			end
		end

		if self.sfxSetMech ~= false then
		
			if self:GetNumberValue("AirBurst") == 1 then

				sfxSetMech = CreateAEmitter("Mech Breaker");
				sfxSetMech.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetMech);
				
			else
			
				sfxSetMech = CreateAEmitter("Mech Breaker Airburst");
				sfxSetMech.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetMech);
				
			end
		end

		local Vector2 = Vector(0,-700);

		local Vector2Left = Vector(0,-700):RadRotate(45);

		local Vector2Right = Vector(0,-700):RadRotate(-45);

		local Vector3 = Vector(0,0);

		local Vector4 = Vector(0,0);

		self.ray = SceneMan:CastObstacleRay(self.Pos, Vector2, Vector3, Vector4, self.RootID, self.Team, 128, 7);

		self.rayRight = SceneMan:CastObstacleRay(self.Pos, Vector2Right, Vector3, Vector4, self.RootID, self.Team, 128, 7);

		self.rayLeft = SceneMan:CastObstacleRay(self.Pos, Vector2Left, Vector3, Vector4, self.RootID, self.Team, 128, 7);

		if self.ray < 0 or self.rayRight < 0 or self.rayLeft < 0 then
	
			if self.sfxSetTail ~= false then

				sfxSetTail = CreateAEmitter("Tail Breaker");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end	

		else
	
			if self.sfxSetTail ~= false then

				sfxSetTail = CreateAEmitter("Tail Breaker Indoors");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end	
	
		end

	end

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	else
		self.parent = nil;
	end
	
	if self.parent == nil and self.chamber == true then
		
		self.chamber = false;
		if self.pullTimer:IsPastSimMS(self.pullDelay) then
		
		
		else
			self.stoppedPremature = true;
		end
		self:RemoveNumberValue("ChamberRot")
		self:RemoveNumberValue("Chambering")

	end

	if self.parent then

		if self.Magazine then
		
			if self.stoppedPremature == true then
				
				self.chamber = true;
				self.pullTimer:Reset();
				self.pullTimerTwo:Reset();
				self.num = math.pi;
				self.sfxOne = true;
				self.sfxTwo = true;

				self.stoppedPremature = false;
			end

			if self.Magazine.RoundCount < self.lastAmmo and self.reloadCycle == false and self.reloadEnd == false then

				if self.lastAmmo ~= 8 then

					self.chamber = true;	-- pull bolt after firing
					self.pullTimer:Reset();
					self.pullTimerTwo:Reset();
					self.num = math.pi;
					self.sfxOne = true;
					self.sfxTwo = true;

					self.casing = true;
				end
			end

			self.lastAmmo = self.Magazine.RoundCount;

		else
			self.newMag = true;
		end

		if self.chamber == true then	-- pulling the bolt


			self:SetNumberValue("Chambering", 1)

			--self:Deactivate();
			--self.parent:GetController():SetState(Controller.WEAPON_FIRE,false);

			if self.pullTimer:IsPastSimMS(self.pullDelay) then
				--self.parent:GetController():SetState(Controller.AIM_SHARP,false);
				--self.Frame = 1;

				if self.sfxOne ~= false then
					sfx = CreateAEmitter("Cock Start Breaker");
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);

					self.sfxOne = false;
				end


				if self.sfxTwo ~= false then
					if self.pullTimerTwo:IsPastSimMS(self.pullDelay + self.cockTotalTime) then
						sfx = CreateAEmitter("Cock Stop Breaker");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);

						self.sfxTwo = false;
					end
				end

				if self.casing == true then
					casing = CreateAEmitter("Breaker Smoking Large Casing");
					casing.Pos = self.Pos+Vector(-4*self.negNum,-1):RadRotate(self.RotAngle);
					casing.Vel = self.Vel+Vector(-math.random(7,9)*self.negNum,-math.random(5,7)):RadRotate(self.RotAngle);
					MovableMan:AddParticle(casing);

					self.casing = false;
				end

				self.RotAngle = self.RotAngle -self.negNum*math.sin(self.num)/4;

				self:SetNumberValue("ChamberRot", self.RotAngle)

				self.num = self.num - math.pi*0.04;
			end

			if self.num <= 0 then

				self.num = 0;
				self.chamber = false;
				self:RemoveNumberValue("Chambering")
				self:RemoveNumberValue("ChamberRot")
			end
		end
	end

	if self.Magazine ~= nil then
		if self.loadedShell == false then
			self.ammoCounter = self.Magazine.RoundCount;
		else
			self.loadedShell = false;
			self.Magazine.RoundCount = self.ammoCounter + 1;
			if self.Magazine.RoundCount == 6 then
				self.reloadCycle = false;
			end
			if self.sfxLoad ~= false then
				sfx = CreateAEmitter("Shell Reload Breaker");
				sfx.Pos = self.Pos;
				MovableMan:AddParticle(sfx);

				self.sfxLoad = false;
			end
		end
	else
		if self.manualReload == true then
			self.BaseReloadTime = 700;
			if self.sfxReloadStart ~= false then
				sfx = CreateAEmitter("Reload Start Breaker");
				sfx.Pos = self.Pos;
				MovableMan:AddParticle(sfx);
				self:RemoveNumberValue("ReloadEnded")
				self:SetNumberValue("ReloadStarted", 1)
				self.sfxReloadStart = false;
			end
		end
			
		self.reloadTimer:Reset();
		self.reloadCycle = true;
		self.loadedShell = true;
		self.Intrerrupted = false;
		self.sfxLoad = true;
		self.resetsDone = false;
		if self.chamber == true then
			self.chamber = false;
			self.num = 0;
			self:RemoveNumberValue("Chambering")
			self:RemoveNumberValue("ChamberRot")
			if self.casing == true then
				casing = CreateAEmitter("Smoking Large Casing");
				casing.Pos = self.Pos+Vector(-4*self.negNum,-1):RadRotate(self.RotAngle);
				casing.Vel = self.Vel+Vector(-math.random(7,9)*self.negNum,-math.random(5,7)):RadRotate(self.RotAngle);
				MovableMan:AddParticle(casing);

				self.casing = false;
			end
		end
	end

	if self:IsActivated() then
		if self.reloadCycle == true then
			self.Intrerrupted = true;
		end
		self.reloadCycle = false;
	end
	
	if self.reloadEnd == true then
		self:Deactivate();
		if self:GetNumberValue("Changed Magazine") == 1 then
			self.reloadEnd = false;
		end
	end

	if self.reloadEndTimer:IsPastSimMS(300) and self.reloadEnd == true then
		if self.sfxReloadEnd ~= false then
			sfx = CreateAEmitter("Reload End Breaker");
			sfx.Pos = self.Pos;
			MovableMan:AddParticle(sfx);
			self:RemoveNumberValue("ReloadStarted")
			self:SetNumberValue("ReloadEnded", 1)
			self.reloadEnd = false;
		end
	end
		

	if self.reloadCycle == true and self.reloadTimer:IsPastSimMS(self.reloadDelay) and self:IsFull() == false then
		local actor = MovableMan:GetMOFromID(self.RootID);
		if MovableMan:IsActor(actor) then
			ToActor(actor):GetController():SetState(Controller.WEAPON_RELOAD,true);
		end
		self.BaseReloadTime = 340
		self.manualReload = false;
	end

	if self.reloadCycle == false and self.Magazine and self.resetsDone == false then
		self.manualReload = true;
		self.sfxReloadStart = true;
		self.sfxReloadEnd = true;
		self.Intrerrupted = false;
		self.resetsDone = true;
		self.reloadEnd = true;
		self.sfxReloadEnd = true;
		self.reloadEndTimer:Reset();
	end

	self:SetNumberValue("Total Cock Time", self.cockTotalTime);
	self:SetNumberValue("Pull Delay", self.pullDelay)
end