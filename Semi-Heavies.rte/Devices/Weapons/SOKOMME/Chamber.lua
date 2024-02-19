
function Create(self)

	self.parent = nil;
	self.pullTimer = Timer();
	self:SetNumberValue("RedDot", 1)
	self:SetNumberValue("Suppressor", 1)
	self:SetNumberValue("Mag", 1)
	self:SetNumberValue("Recoiling", 0)

	self.stanceManipulator = 0;
	self.rotAngleManipulator = 0;
	self.posManipulator = 0;
	self.newMag = false;
	self.chamber = true;		--
	--self.pullTimer:Reset();	--
	self.num = math.pi;		--
	self.sfx = true;		--

	self.negNum = 0;
	self.lifeTimer = Timer();
	self.lifeTimerReset = false;
	self.recoilTimer = Timer();

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	end
end

function Update(self)

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
	
	if self.parent == nil then
		self:RemoveNumberValue("Move To Cover");
	end

	if self.HFlipped then
		self.negNum = -1;
	else
		self.negNum = 1;
	end

	if self:DoneReloading() == true and self.lastMagazineAmmo > 0 then
		self.Magazine.RoundCount = self.Magazine.RoundCount + 1;
		self.newMag = false;
	end
	
	if self.parent then
	
		if self:GetNumberValue("Move To Cover") == 1 then
			self.StanceOffset:SetMagnitude(20 - self.stanceManipulator);
			self.RotAngle = self.RotAngle + (((math.pi / 2) * self.negNum) * self.rotAngleManipulator)
			self.Pos = self.Pos - Vector(3 * self.negNum, 2):SetMagnitude(6 * self.posManipulator)
			self.parent:GetController():SetState(Controller.AIM_SHARP,false);
			
			if self.stanceManipulator < 7.5 then
				self.stanceManipulator = self.stanceManipulator + 0.5;
			end
			
			if self.rotAngleManipulator < 0.75 then
				self.rotAngleManipulator = self.rotAngleManipulator + 0.05;
			end
			
			if self.posManipulator < 0.75 then
				self.posManipulator = self.posManipulator + 0.05;
			end
			
			self:SetNumberValue("PosChangeX", 3 * self.posManipulator);
			self:SetNumberValue("PosChangeY", 2 * self.posManipulator);

			if self.parent:IsPlayerControlled() then
				if UInputMan:KeyPressed(6) then
					self:SetNumberValue("Move To Cover", 0)
				end
			end
			
		elseif self:GetNumberValue("Move To Cover") == 0 then
			self.StanceOffset:SetMagnitude(20 - self.stanceManipulator);
			self.RotAngle = self.RotAngle + (((math.pi / 2) * self.negNum) * self.rotAngleManipulator)	
			self.Pos = self.Pos - Vector(3 * self.negNum, 2):SetMagnitude(6 * self.posManipulator)
			
			if self.stanceManipulator > 0 then
				self.stanceManipulator = self.stanceManipulator - 0.5;
			end
			
			if self.rotAngleManipulator > 0 then
				self.rotAngleManipulator = self.rotAngleManipulator - 0.05;
			end
			
			if self.posManipulator > 0 then
				self.posManipulator = self.posManipulator - 0.05;
			end
			
			-- janky fixes for attachments following Pos properly
			
			self:SetNumberValue("PosChangeX", 3 * self.posManipulator);
			self:SetNumberValue("PosChangeY", 2 * self.posManipulator);
			
		end
	end
	if self:GetNumberValue("Recoiling") == 1 then

	
		if self.recoilTimer:IsPastSimMS(45) then
			self:SetNumberValue("Recoiling", 0);
		elseif self.recoilTimer:IsPastSimMS(35) then
			self.SharpStanceOffset = Vector(14, 0);
			self.RotAngle = self.RotAngle + (0.05 * self.negNum);
		elseif self.recoilTimer:IsPastSimMS(25) then
			self.SharpStanceOffset = Vector(12, 0);	
			self.RotAngle = self.RotAngle + (0.10 * self.negNum);
		elseif self.recoilTimer:IsPastSimMS(15) then
			self.SharpStanceOffset = Vector(10, 0);	
			self.RotAngle = self.RotAngle + (0.15 * self.negNum);
		elseif self.recoilTimer:IsPastSimMS(5) then
			self.SharpStanceOffset = Vector(9, 0);
			self.RotAngle = self.RotAngle + (0.2 * self.negNum);
		end
	end
	
	if self.FiredFrame then
	
		self:SetNumberValue("Recoiling", 1);
		self.recoilTimer:Reset();
		self.SharpStanceOffset = Vector(10, 0);
		self.RotAngle = self.RotAngle + (0.17 * self.negNum);

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

		if self.sfxSetShot ~= false then

			sfxSetShot = CreateAEmitter("Shot SOKOMME");
			sfxSetShot.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetShot);

		end
		if self.sfxSetMech ~= false then

			sfxSetMech = CreateAEmitter("Mech SOKOMME");
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


		if self:GetNumberValue("Suppressor") == 1 then

			if self.sfxSetShot ~= false then

				sfxSetShot = CreateAEmitter("Unsuppressed Addon SOKOMME");
				sfxSetShot.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetShot);

			end	


			if self.ray < 0 or self.rayRight < 0 or self.rayLeft < 0 then
	
				if self.sfxSetTail ~= false then

					sfxSetTail = CreateAEmitter("Tail SOKOMME");
					sfxSetTail.Pos = self.Pos;
					MovableMan:AddParticle(sfxSetTail);

				end

				if self.sfxSetTail ~= false then

					sfxSetTail = CreateAEmitter("Tail SOKOMME Unsuppressed");
					sfxSetTail.Pos = self.Pos;
					MovableMan:AddParticle(sfxSetTail);

				end	

			else
	
				if self.sfxSetTail ~= false then

					sfxSetTail = CreateAEmitter("Tail SOKOMME Indoors Unsuppressed");
					sfxSetTail.Pos = self.Pos;
					MovableMan:AddParticle(sfxSetTail);

				end	
			end
		else

			if self.ray < 0 or self.rayRight < 0 or self.rayLeft < 0 then
	
				if self.sfxSetTail ~= false then

					sfxSetTail = CreateAEmitter("Tail SOKOMME");
					sfxSetTail.Pos = self.Pos;
					MovableMan:AddParticle(sfxSetTail);

				end

			else
	
				if self.sfxSetTail ~= false then

					sfxSetTail = CreateAEmitter("Tail SOKOMME Indoors");
					sfxSetTail.Pos = self.Pos;
					MovableMan:AddParticle(sfxSetTail);

				end	
			end
		end
	elseif self:GetNumberValue("Recoiling") == 0 then
		self.SharpStanceOffset = Vector(15, 0);	
	end


	if self.parent == nil and self.chamber == true then
		
		self.chamber = false;
		if self.pullTimer:IsPastSimMS(480) then
		
		
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
			self.lastMagazineAmmo = self.lastAmmo;
			self.newMag = true;
		end

		if self.chamber == true then

			self:SetNumberValue("Chambering", 1)
			self:Deactivate();
			--self.parent:GetController():SetState(Controller.WEAPON_FIRE,false);

			if self.pullTimer:IsPastSimMS(480) then
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

				self.num = self.num - math.pi*0.08;
			end

			if self.num <= 0 then
			
				self.num = 0;
				self.chamber = false;
				self:RemoveNumberValue("Chambering")
			end
		end
	end	
	-- cheap fix for attachment rotations with the new recoil code
	self:SetNumberValue("ChamberRot", self.RotAngle)	
	
end