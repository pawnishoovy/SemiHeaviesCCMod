
function Create(self)

	self.parent = nil;
	self.pullTimer = Timer();

	self.recoilTimer = Timer();
	self.shotsFired = 0;
	self.weightApplied = false;
	self.sRangeModifier = 1;
	self.baseModifier = 1;
	self.shotsFired = 0;
	self:SetNumberValue("CHARGEUPGRADE", 0)

	self.chargeDelay = 1300;
	self.charging = false;
	self.chargeTimer = Timer();
	self.burstTimer = Timer();
	self.burst = false;
	self.canBurst = true;
	
	self.clearTimer = Timer();
	self.clearTimerReset = false;
	self.jammedShots = 0;
	self.jamRisk = 0;

	self.newMag = false;
	self.chamber = false;		--
	--self.pullTimer:Reset();	--
	self.num = math.pi;		--
	self.sfx = true;		--
	self.sfxSetShot = true;
	self.sfxSetMech = true;
	self.sfxSetTail = true;
	self.sfxSetSweetener = true;

	self.negNum = 0;
	self.sLength = self.SharpLength;

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	end
end

function Update(self)

	if self:IsReloading() then
		self:SetNumberValue("Reloading", 1)
		self:RemoveNumberValue("Jammed")
	else
		self:RemoveNumberValue("Reloading")
	end

	if self.parent then
		if self.parent:IsPlayerControlled() == false and self:NumberValueExists("Jammed") and self.chamber == false and not self:IsReloading() then
			self:SetNumberValue("Clearing Jam", 1);
		end
	end
	
	if self:NumberValueExists("Jammed") and self:IsActivated() then
	
		self:Deactivate()
		
		if self.sfxJammed ~= false then
		
			sfxJammed = CreateAEmitter("Jammed A612");
			sfxJammed.Pos = self.Pos;
			MovableMan:AddParticle(sfxJammed);
			
			self.sfxJammed = false;
			
		end
		
	else
	
		self.sfxJammed = true;
		
	end
	
	if self:NumberValueExists("Clearing Jam") then
	
		self:Deactivate()
		
		if self.clearTimerReset == false then
			self.clearTimer:Reset()
			self.clearTimerReset = true
		end
		
		if self.clearTimer:IsPastSimMS(3500) then
			self:RemoveNumberValue("Jammed")
			self:RemoveNumberValue("Clearing Jam")
		end
	else
		self.clearTimerReset = false;
	end

	if self.Magazine then
		
		if self.newMag == true then
		
			self.chamber = true;
			self.pullTimer:Reset();
			self.num = math.pi;
			self.sfx = true;
			
		end
	end
	

	-- thx 4zk for old chargeup code

	if self:GetNumberValue("CHARGEUPGRADE") == 1 then

		if self.charging == true then

			if self.chargeTimer:IsPastSimMS(self.chargeDelay) then
				self.burst = true;
				self.burstTimer:Reset();
				self.charging = false;
				sfx = CreateAEmitter("Chargeloop A612");
				sfx.Pos = self.Pos;
				MovableMan:AddParticle(sfx);
			else
				self:Deactivate();
			end

		elseif self.Magazine and self:IsActivated() and self.burst == false and self.chamber == false then

			if self.triggerPulled == false then

				self:Deactivate();
				self.charging = true;
				self.triggerPulled = true;
				self.chargeTimer:Reset();

				sfx = CreateAEmitter("Chargeup A612");
				sfx.Pos = self.Pos;
				MovableMan:AddParticle(sfx);

			end
		else
			self.triggerPulled = false;
		end

		if self.burst == true then

			if self.burstTimer:IsPastSimMS(1000) then
				self.burstTimer:Reset();
				self:Deactivate();
				self.burst = false;
				
				sfx = CreateAEmitter("Chargedown A612");
				sfx.Pos = self.Pos;
				MovableMan:AddParticle(sfx);
			else
				self:Activate();
			end
		end
	end



	if self:IsActivated() then
		if self.FiredFrame then
			self.shotsFired = self.shotsFired + 1;
			self.recoilTimer:Reset();
		end
	else
		if self.recoilTimer:IsPastSimMS(500) then
			self.shotsFired = 0
		end
		if self.recoilTimer:IsPastSimMS(1000) then
			self.shotsFired = 0
			self.jamRisk = 0;
			self.jammedShots = 0;
			self:RemoveNumberValue("Jamming")
		end
		if self.justShot == true then

			self.justShot = false;

			if self.ray < 0 or self.rayRight < 0 or self.rayLeft < 0 then

				if self.sfxSetTail ~= false then

					sfxSetTail = CreateAEmitter("Tail A612");
					sfxSetTail.Pos = self.Pos;
					MovableMan:AddParticle(sfxSetTail);

				end
			end
		end		
	end

	if self.shotsFired == 0 then
		self.ShakeRange = 3
		self.SharpShakeRange = 1 * self.sRangeModifier
	elseif self.shotsFired == 1 then
		self.ShakeRange = 3.5
		self.SharpShakeRange = 1.5 * self.sRangeModifier
	elseif self.shotsFired == 2 then
		self.ShakeRange = 4
		self.SharpShakeRange = 2 * self.sRangeModifier
	elseif self.shotsFired == 3 then
		self.ShakeRange = 5
		self.SharpShakeRange = 2.5 * self.sRangeModifier
	elseif self.shotsFired == 4 then
		self.ShakeRange = 6
		self.SharpShakeRange = 3 * self.sRangeModifier
	elseif self.shotsFired > 4 then
		self.ShakeRange = 7
		self.SharpShakeRange = 3.5 * self.sRangeModifier
	end
	
	if self.shotsFired > 20 then
		self.jamRisk = self.shotsFired / 1.5 - 18
	end

	if self.FiredFrame then
	
		if math.random(100) < self.jamRisk then
		
			self:SetNumberValue("Jamming", 1)
			
		end
		
		if self:NumberValueExists("Jamming") then
		
			self.jammedShots = self.jammedShots + 1
			
			sfxJamming = CreateAEmitter("Jamming A612");
			sfxJamming.Pos = self.Pos;
			MovableMan:AddParticle(sfxJamming);
			
			for i = 1, 1 do
				gfx = CreateMOSParticle("Tiny Smoke Ball 1");
				gfx.Pos = self.Pos;
				gfx.Vel = self:RotateOffset(Vector(RangeRand(-2,2), -RangeRand(4,8)))

				MovableMan:AddParticle(gfx);
			end

		end
		
		if self.jammedShots == 10 then
		
			self:SetNumberValue("Jammed", 1)
			
			sfxJam = CreateAEmitter("Jam A612");
			sfxJam.Pos = self.Pos;
			MovableMan:AddParticle(sfxJam);
			
			for i = 1, 2 do
				gfx = CreateMOSParticle("Side Thruster Blast Ball 1");
				gfx.Pos = self.Pos;
				gfx.Vel = self:RotateOffset(Vector(RangeRand(-2,2), -RangeRand(10,20)))

				MovableMan:AddParticle(gfx);
			end
		
		end	
	
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

		self.justShot = true;

		if self.sfxSetShot ~= false then

			sfxSetShot = CreateAEmitter("Shot A612");
			sfxSetShot.Pos = self.Pos;
			MovableMan:AddParticle(sfxSetShot);
		end

		if self.sfxSetMech ~= false then

			sfxSetMech = CreateAEmitter("Mech A612");
			sfxSetMech.Pos = self.Pos;
			MovableMan:AddParticle(sfxSetMech);

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

				sfxSetTail = CreateAEmitter("Tail A612 Indoors");
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
		self.stoppedPremature = true;

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

			if self.newMag == true then

				self.chamber = true;
				self.pullTimer:Reset();
				self.num = math.pi;
				self.sfx = true;

				self.newMag = false;
			end
		else
			self.newMag = true;
			if self.justShot == true then
				if self.ray < 0 or self.rayRight < 0 or self.rayLeft < 0 then
	
					if self.sfxSetTail ~= false then

						sfxSetTail = CreateAEmitter("Tail A612");
						sfxSetTail.Pos = self.Pos;
						MovableMan:AddParticle(sfxSetTail);

					end
				end
				self.justShot = false;
			end
		end

		if self.chamber == true then

			self:SetNumberValue("ChamberRot", self.RotAngle)
			self:RemoveNumberValue("Jammed")
			self:SetNumberValue("Chambering", 1)
			self:Deactivate();
			--self.parent:GetController():SetState(Controller.WEAPON_FIRE,false);

			if self.pullTimer:IsPastSimMS(5500) then
				--self.parent:GetController():SetState(Controller.AIM_SHARP,false);
				--self.Frame = 1;
				

				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber " .. self.PresetName);
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);
					self.sfx = false
				end
				
				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.num)/5;

				self:SetNumberValue("ChamberRot", self.RotAngle)

				self.num = self.num - math.pi*0.03;
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