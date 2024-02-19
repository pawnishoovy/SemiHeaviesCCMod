 
function Create(self)

	self.parent = nil;
	self.pullTimer = Timer();

	self.newMag = false;
	self.chamber = true;
	self.num = math.pi;
	self.sfx = true;
	self.casing = false;
	self:SetNumberValue("Scope", 1)

	self.negNum = 0;

	if self.Magazine then
		self.lastAmmo = self.Magazine.RoundCount;
	end

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	end
end

function Update(self)
	

	if self.FiredFrame then
	
		for i = 1, 2 do
			Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos;
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(170*self.negNum,0):RadRotate(self.RotAngle)) / 30
				MovableMan:AddParticle(Effect)
			end
		end
		
		if PosRand() < 0.5 then
			Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos;
				Effect.Vel = (self.Vel + Vector(170*self.negNum,0):RadRotate(self.RotAngle)) / 10
				MovableMan:AddParticle(Effect)
			end
		end

		if self.sfxSetShot ~= false then

			sfxSetShot = CreateAEmitter("Shot Marauder");
			sfxSetShot.Pos = self.Pos;
			MovableMan:AddParticle(sfxSetShot);
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

				sfxSetTail = CreateAEmitter("Tail Marauder");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end
		else
	
			if self.sfxSetTail ~= false then

				sfxSetTail = CreateAEmitter("Tail Marauder Indoors");
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

	if self.HFlipped then
		self.negNum = -1;
	else
		self.negNum = 1;
	end
	
	if self.parent == nil and self.chamber == true then
		
		self.chamber = false;
		if self.pullTimer:IsPastSimMS(600) then
		
		
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

			if self.newMag == true then

				if self.lastAmmo == 0 then

					self.chamber = true;	-- pull bolt on new mag
					self.pullTimer:Reset();
					self.num = math.pi;
					self.sfx = true;
					self.smokelessCasing = true

					self.newMag = false;
				else
					self.chamber = true;	-- pull bolt on new mag
					self.pullTimer:Reset();
					self.num = math.pi;
					self.sfx = true;
					self.unspentCasing = true

					self.newMag = false;

				end

			elseif self.Magazine.RoundCount < self.lastAmmo then--and self.chamber == false then

				if self.lastAmmo ~= 1 then

					self.chamber = true;	-- pull bolt after firing
					self.pullTimer:Reset();
					self.num = math.pi;
					self.sfx = true;
					self.casing = true;
				end
			end

			self.lastAmmo = self.Magazine.RoundCount;

			if self.Magazine.RoundCount == 0 and self:IsActivated() then
				self:Reload();
			end
		else
			self.newMag = true;
		end

		if self.chamber == true then	-- pulling the bolt

			self:SetNumberValue("ChamberRot", self.RotAngle)

			self:SetNumberValue("Chambering", 1)

			--self:Deactivate();
			--self.parent:GetController():SetState(Controller.WEAPON_FIRE,false);

			if self.pullTimer:IsPastSimMS(600) then
				--self.parent:GetController():SetState(Controller.AIM_SHARP,false);
				--self.Frame = 1;

				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber Marauder LNG");
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);

					self.sfx = false;
				end

				if self.casing == true then
					casing = CreateAEmitter("Smoking Large Casing");
					casing.Pos = self.Pos+Vector(-4*self.negNum,-1):RadRotate(self.RotAngle);
					casing.Vel = self.Vel+Vector(-math.random(7,9)*self.negNum,-math.random(5,7)):RadRotate(self.RotAngle);
					MovableMan:AddParticle(casing);

					self.casing = false;
				end


				if self.smokelessCasing == true then
					casing = CreateAEmitter("Shell Smokeless");
					casing.Pos = self.Pos+Vector(-4*self.negNum,-1):RadRotate(self.RotAngle);
					casing.Vel = self.Vel+Vector(-math.random(7,9)*self.negNum,-math.random(5,7)):RadRotate(self.RotAngle);
					MovableMan:AddParticle(casing);

					self.smokelessCasing = false;
				end

				if self.unspentCasing == true then
					casing = CreateAEmitter("Shell Unspent");
					casing.Pos = self.Pos+Vector(-4*self.negNum,-1):RadRotate(self.RotAngle);
					casing.Vel = self.Vel+Vector(-math.random(7,9)*self.negNum,-math.random(5,7)):RadRotate(self.RotAngle);
					MovableMan:AddParticle(casing);

					self.unspentCasing = false;
				end

				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.num)/2;

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
end