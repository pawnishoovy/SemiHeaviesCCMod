
function Create(self)

	self.parent = nil;
	self.pullTimer = Timer();
	self.recoilTimer = Timer();
	self.shotsFired = 0;
	self.weightApplied = false
	self.upgradeApplied = false
	self.barrelApplied = false

	self.newMag = false;
	self.chamber = true;		--
	--self.pullTimer:Reset();	--
	self.num = math.pi;		--
	self.sfx = true;		--
	self.sRangeModifier = 1;
	self.baseModifier = 1
	self:SetNumberValue("ROFUPGRADE", 1)
	self:SetNumberValue("ACCUPGRADES", 1)
	self:SetNumberValue("BARRELUPGRADE", 1)

	self.negNum = 0;
	self.sLength = self.SharpLength;

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
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(150*self.negNum,0):RadRotate(self.RotAngle)) / 30
				MovableMan:AddParticle(Effect)
			end
		end
		
		if PosRand() < 0.5 then
			Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos;
				Effect.Vel = (self.Vel + Vector(150*self.negNum,0):RadRotate(self.RotAngle)) / 10
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

				sfxSetTail = CreateAEmitter("Tailed Shot AR-338");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end	

		else
	
			if self.sfxSetTail ~= false then

				sfxSetTail = CreateAEmitter("Tail AR-338 Indoors");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end
	
			if self.sfxSetShot ~= false then

				sfxSetShot = CreateAEmitter("Shot AR-338");
				sfxSetShot.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetShot);

			end	
	
		end

	end

	if self:DoneReloading() == true and self.lastMagazineAmmo > 0 then
		self.Magazine.RoundCount = self.Magazine.RoundCount + 1;
		self.newMag = false;
	end

	if self:IsActivated() then
		if self.FiredFrame then
			self.shotsFired = self.shotsFired + 1;
			self.recoilTimer:Reset();
		end
	else
		if self.recoilTimer:IsPastSimMS(600) then
			self.shotsFired = 0
		end
	end
	
-- when all i have is a hammer everythings a nail
-- that is to say this is ugly code
	
	if self:GetNumberValue("ROFUPGRADE") == 2 then
		if self.shotsFired == 0 then
			self.ShakeRange = 3
			self.SharpShakeRange = 1 * self.sRangeModifier
		elseif self.shotsFired == 1 then
			self.ShakeRange = 4
			self.SharpShakeRange = 3 * self.sRangeModifier
		elseif self.shotsFired == 2 then
			self.ShakeRange = 5
			self.SharpShakeRange = 3.5 * self.sRangeModifier
		elseif self.shotsFired == 3 then
			self.ShakeRange = 7
			self.SharpShakeRange = 4.7 * self.sRangeModifier
		elseif self.shotsFired == 4 then
			self.ShakeRange = 7.5
			self.SharpShakeRange = 5.9 * self.sRangeModifier
		elseif self.shotsFired > 4 then
			self.ShakeRange = 9
			self.SharpShakeRange = 6.5 * self.sRangeModifier
		end
	elseif self:GetNumberValue("ROFUPGRADE") == 1 then
		if self.shotsFired == 0 then
			self.ShakeRange = 3
			self.SharpShakeRange = 1 * self.sRangeModifier
		elseif self.shotsFired == 1 then
			self.ShakeRange = 3
			self.SharpShakeRange = 2.7 * self.sRangeModifier
		elseif self.shotsFired == 2 then
			self.ShakeRange = 4
			self.SharpShakeRange = 3.2 * self.sRangeModifier
		elseif self.shotsFired == 3 then
			self.ShakeRange = 5
			self.SharpShakeRange = 3.5 * self.sRangeModifier
		elseif self.shotsFired == 4 then
			self.ShakeRange = 6
			self.SharpShakeRange = 4 * self.sRangeModifier
		elseif self.shotsFired > 4 then
			self.ShakeRange = 7
			self.SharpShakeRange = 4.5 * self.sRangeModifier
		end
	elseif self:GetNumberValue("ROFUPGRADE") == 3 then
		if self.shotsFired == 0 then
			self.ShakeRange = 3
			self.SharpShakeRange = 1 * self.sRangeModifier
		elseif self.shotsFired == 1 then
			self.ShakeRange = 4
			self.SharpShakeRange = 4 * self.sRangeModifier
		elseif self.shotsFired == 2 then
			self.ShakeRange = 5
			self.SharpShakeRange = 4.5 * self.sRangeModifier
		elseif self.shotsFired == 3 then
			self.ShakeRange = 7
			self.SharpShakeRange = 5.7 * self.sRangeModifier
		elseif self.shotsFired == 4 then
			self.ShakeRange = 7.5
			self.SharpShakeRange = 6.9 * self.sRangeModifier
		elseif self.shotsFired > 4 then
			self.ShakeRange = 9
			self.SharpShakeRange = 7.5 * self.sRangeModifier
		end
	end
	
	if self:GetNumberValue("ACCUPGRADES") == 2 and self.upgradeApplied == false then
		self.sRangeModifier = self.sRangeModifier - 0.1;
		self.upgradeApplied = true;
		if self:GetNumberValue("BARRELUPGRADE") == 1 then
			self.baseModifier = 0.9
		else
			self.baseModifier = 0.85
		end
	end
	if self:GetNumberValue("BARRELUPGRADE") == 2 and self.barrelApplied == false then
		self.sRangeModifier = self.sRangeModifier - 0.05;
		self.barrelApplied = true;
		if self:GetNumberValue("ACCUPGRADES") == 1 then
			self.baseModifier = 0.95
		else
			self.baseModifier = 0.85
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
		if self.pullTimer:IsPastSimMS(1300) then
		
		
		else
			self.stoppedPremature = true;
		end
		self:RemoveNumberValue("ChamberRot")
		self:RemoveNumberValue("Chambering")

	end

	if self.parent then

		
		if self.parent.Mass > 150 and self.parent.Mass <= 175 and self.weightApplied == false then
			self.sRangeModifier = self.sRangeModifier - 0.05
			self.weightApplied = true
		end
		if self.parent.Mass > 175 and self.parent.Mass <= 185 and self.weightApplied == false then
			self.sRangeModifier = self.sRangeModifier - 0.15
			self.weightApplied = true
		end
		if self.parent.Mass > 185 and self.parent.Mass <= 200 and self.weightApplied == false then
			self.sRangeModifier = self.sRangeModifier - 0.20
			self.weightApplied = true
		end
		if self.parent.Mass > 200 and self.weightApplied == false then
			self.sRangeModifier = self.sRangeModifier - 0.40
			self.weightApplied = true
		end


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

			if self.pullTimer:IsPastSimMS(1300) then
				--self.parent:GetController():SetState(Controller.AIM_SHARP,false);
				--self.Frame = 1;
				

				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber " .. self.PresetName);
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);
					self.sfx = false
				end
				
				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.num)/2;

				self:SetNumberValue("ChamberRot", self.RotAngle)

				self.num = self.num - math.pi*0.08;
			end

			if self.num <= 0 then
			
				self.num = 0;
				self.chamber = false;
				self:RemoveNumberValue("Chambering")
				self:RemoveNumberValue("ChamberRot")
			end
		end
	else
		self.weightApplied = false
		self.sRangeModifier = self.baseModifier
	end
end