
function Create(self)

	self.parent = nil;
	self.pullTimer = Timer();

	self.newMag = false;
	self.chamber = true;		--
	--self.pullTimer:Reset();	--
	self.num = math.pi;		--
	self.sfx = true;		--
	self.sfxSetShot = true;
	self.sfxSetTail = true;

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

	if self.FiredFrame then	
	
		for i = 1, 2 do
			Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos;
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(135*self.negNum,0):RadRotate(self.RotAngle)) / 30
				MovableMan:AddParticle(Effect)
			end
		end
		
		if PosRand() < 0.5 then
			Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos;
				Effect.Vel = (self.Vel + Vector(135*self.negNum,0):RadRotate(self.RotAngle)) / 10
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

				sfxSetTail = CreateAEmitter("Tailed Shot Modular");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end	

		else
	
			if self.sfxSetTail ~= false then

				sfxSetTail = CreateAEmitter("Tail Modular Indoors");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end	

			if self.sfxSetShot ~= false then

				sfxSetShot = CreateAEmitter("Shot Modular");
				sfxSetShot.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetShot);

			end
	
		end

	end

	if self:DoneReloading() == true and self.lastMagazineAmmo > 0 then
		self.Magazine.RoundCount = self.Magazine.RoundCount + 1;
		self.newMag = false;
	end

	if self.ShakeRange == 6 or self.ShakeRange == 2 then
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
	
	if self.parent == nil and self.chamber == true then
		
		self.chamber = false;
		if self.pullTimer:IsPastSimMS(280) then
		
		
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
	
			if self.justShot == true then
				if self.ray < 0 or self.rayRight < 0 or self.rayLeft < 0 then
	
					if self.sfxSetTail ~= false then

						sfxSetTail = CreateAEmitter("Tail Modular");
						sfxSetTail.Pos = self.Pos;
						MovableMan:AddParticle(sfxSetTail);

					end
				end
				self.justShot = false;
			end
		end

		if self.chamber == true then

			self:SetNumberValue("Chambering", 1)
			self:Deactivate();
			--self.parent:GetController():SetState(Controller.WEAPON_FIRE,false);

			if self.pullTimer:IsPastSimMS(280) then
				--self.parent:GetController():SetState(Controller.AIM_SHARP,false);
				--self.Frame = 1;

				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber " .. self.PresetName);
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);

					self.sfx = false;
				end

				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.num)/2;

				self.ShakeRange = self.RotAngle

				self.num = self.num - math.pi*0.08;
			end

			if self.num <= 0 then

				self.num = 0;
				self.chamber = false;
				self.ShakeRange = self.sRange
				self:RemoveNumberValue("Chambering")
			end
		end
	end
end