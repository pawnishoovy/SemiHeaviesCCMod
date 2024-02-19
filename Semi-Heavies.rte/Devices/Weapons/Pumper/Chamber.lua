
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

	if self:DoneReloading() == true and self.lastMagazineAmmo > 0 and not self:NumberValueExists("Changed Magazine") then
		self.Magazine.RoundCount = self.Magazine.RoundCount + 1;
		self.newMag = false;
	elseif self:DoneReloading() == true and self:NumberValueExists("Changed Magazine") and self.lastMagazineAmmo > 0 then
		self:RemoveNumberValue("Changed Magazine")
		self.unspentCasing = true;
	elseif self:DoneReloading() == true and self:NumberValueExists("Changed Magazine") then
		self:RemoveNumberValue("Changed Magazine")
	end
		
	if self.FiredFrame and self:GetNumberValue("DB") == 2 then
		sfx = CreateAEmitter("DB Sound");
		sfx.Pos = self.Pos;
		MovableMan:AddParticle(sfx);
		
		for i = 1, 25 do
			Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(120*self.negNum,0):RadRotate(self.RotAngle)) / 30
				MovableMan:AddParticle(Effect)
			end
		end

		for i = 1, 25 do
			Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(120*self.negNum,0):RadRotate(self.RotAngle)) / 1
				MovableMan:AddParticle(Effect)
			end
		end

		for i = 1, 5 do
			Effect = CreateMOSParticle("Pumper DB Flame Smoke 1")
			if Effect then
				Effect.Pos = self.MuzzlePos
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(120*self.negNum,0):RadRotate(self.RotAngle)) / 1
				MovableMan:AddParticle(Effect)
			end
		end

		for i = 1, 5 do
			Effect = CreateMOPixel("Spark Yellow 1")
			if Effect then
				Effect.Pos = self.MuzzlePos
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(120*self.negNum,0):RadRotate(self.RotAngle)) / 5
				Effect.Team = self.Team
				Effect.IgnoresTeamHits = true
				Effect.HitsMOs = false
				MovableMan:AddParticle(Effect)
			end
		end

		for i = 1, 5 do
			Effect = CreateMOSParticle("Explosion Smoke 1")
			if Effect then
				Effect.Pos = self.MuzzlePos
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(120*self.negNum,0):RadRotate(self.RotAngle)) / 0.5
				Effect.Team = self.Team
				Effect.IgnoresTeamHits = true
				Effect.HitsMOs = false
				MovableMan:AddParticle(Effect)
			end
		end

		for i = 1, 5 do
			Effect = CreateMOPixel("Spark Yellow 2")
			if Effect then
				Effect.Pos = self.MuzzlePos
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(120*self.negNum,0):RadRotate(self.RotAngle)) / 5
				Effect.Team = self.Team
				Effect.IgnoresTeamHits = true
				Effect.HitsMOs = false
				MovableMan:AddParticle(Effect)
			end
		end

		for i = 1, math.random(5) do
			Effect = CreateMOPixel("Grenade Fragment Yellow")
			if Effect then
				Effect.Pos = self.MuzzlePos
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(120*self.negNum,0):RadRotate(self.RotAngle)) / 5
				Effect.Team = self.Team
				Effect.IgnoresTeamHits = true
				MovableMan:AddParticle(Effect)
			end
		end

		for i = 1, 10 do
			Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos
				Effect.Vel = (self.Vel + Vector(120*self.negNum,0):RadRotate(self.RotAngle)) / 25
				MovableMan:AddParticle(Effect)
			end
		end
	end

	if self.FiredFrame then
	
		for i = 1, 10 do
			Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos;
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(110*self.negNum,0):RadRotate(self.RotAngle)) / 30
				MovableMan:AddParticle(Effect)
			end
		end
		
		for i = 1, math.random(5) do
			Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos;
				Effect.Vel = (self.Vel + Vector(110*self.negNum,0):RadRotate(self.RotAngle)) / 10
				MovableMan:AddParticle(Effect)
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

				sfxSetTail = CreateAEmitter("Tailed Shot SG-10");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end	

		else
	
			if self.sfxSetTail ~= false then

				sfxSetTail = CreateAEmitter("Tail SG-10 Indoors");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end
	
			if self.sfxSetShot ~= false then

				sfxSetShot = CreateAEmitter("Shot SG-10");
				sfxSetShot.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetShot);

			end	
	
		end

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
	
	if self.parent == nil and self.chamber == true then
		
		self.chamber = false;
		if self.pullTimer:IsPastSimMS(700) then
		
		
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
				self.num = math.pi;
				self.sfx = true;

				self.stoppedPremature = false;
			end

			self.lastAmmo = self.Magazine.RoundCount;

			if self.newMag == true then

				self.chamber = true;
				self.pullTimer:Reset();
				self.num = math.pi;
				self.sfx = true;

				self.newMag = false;
			end
		else
			self.newMag = true;
			self.lastMagazineAmmo = self.lastAmmo;
		end

		if self.chamber == true then

			self:SetNumberValue("Chambering", 1)
			self:Deactivate();
			--self.parent:GetController():SetState(Controller.WEAPON_FIRE,false);

			if self.pullTimer:IsPastSimMS(700) then
				--self.parent:GetController():SetState(Controller.AIM_SHARP,false);
				--self.Frame = 1;
				

				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber " .. self.PresetName);
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);
					self.sfx = false
				end

				if self.unspentCasing == true then
					casing = CreateMOSParticle("Shell");
					casing.Pos = self.Pos+Vector(-4*self.negNum,-1):RadRotate(self.RotAngle);
					casing.Vel = self.Vel+Vector(-math.random(7,9)*self.negNum,-math.random(5,7)):RadRotate(self.RotAngle);
					MovableMan:AddParticle(casing);

					self.unspentCasing = false;
				end
				
				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.num)/2;

				self:SetNumberValue("ChamberRot", self.RotAngle)

				self.num = self.num - math.pi*0.07;
			end

			if self.num <= 0 then
			
				self.num = 0;
				self.chamber = false;
				self:RemoveNumberValue("Chambering")
				self:RemoveNumberValue("ChamberRot")
			end
		end
	end				
end