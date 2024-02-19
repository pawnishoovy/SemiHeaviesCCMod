
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
	self.sfxSetMech = true;

	self.negNum = 0;
	self.sLength = self.SharpLength;
	self.ShakeRange = 6
	self.sRange = self.ShakeRange
	self.lifeTimer = Timer();
	self.lifeTimerReset = false
	self.flashCooldown = Timer();
	self.flashedTimer = Timer();
	
	self:SetNumberValue("Flash Upgrade", 0);

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	end
end

function Update(self)


	if not self:IsActivated() then

		if self.justShot == true then

			self.justShot = false;

			if self.ray < 0 or self.rayRight < 0 or self.rayLeft < 0 then

				if self.sfxSetTail ~= false then

					sfxSetTail = CreateAEmitter("Tail Baser");
					sfxSetTail.Pos = self.Pos;
					MovableMan:AddParticle(sfxSetTail);

				end
			end
		end	
	end

	if self.FiredFrame then	
	
		for i = 1, 2 do
			Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.MuzzlePos;
				Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20)) + Vector(135*self.negNum,0):RadRotate(self.RotAngle)) / 30
				MovableMan:AddParticle(Effect)
			end
		end

		self.justShot = true;


		if self.sfxSetShot ~= false then

			sfxSetShot = CreateAEmitter("Shot Baser");
			sfxSetShot.Pos = self.Pos;
			MovableMan:AddParticle(sfxSetShot);

		end

		if self.sfxSetMech ~= false then

			sfxSetShot = CreateAEmitter("Mech Baser");
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
		
			-- if self.sfxSetTail ~= false then

				-- sfxSetTail = CreateAEmitter("Outdoors Tail Baser");
				-- sfxSetTail.Pos = self.Pos;
				-- MovableMan:AddParticle(sfxSetTail);

			-- end	

		else

	
			if self.sfxSetTail ~= false then

				sfxSetTail = CreateAEmitter("Tail Baser Indoors");
				sfxSetTail.Pos = self.Pos;
				MovableMan:AddParticle(sfxSetTail);

			end	
	
		end

	end

	if self:DoneReloading() == true and self.lastMagazineAmmo > 0 then
		self.Magazine.RoundCount = self.Magazine.RoundCount + 1;
		self.newMag = false;
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
		if self.pullTimer:IsPastSimMS(450) then
		
		
		else
			self.stoppedPremature = true;
		end
		self:RemoveNumberValue("ChamberRot")
		self:RemoveNumberValue("Chambering")

	end
	
	if self:GetNumberValue("FlashingWhite") == 1 then
	
		if self.object1 then
		
			
			if IsActor(self.object1) then
				self.actor1 = ToActor(self.object1)
			elseif IsAttachable(self.object1) then
			
					
				local thing = MovableMan:GetMOFromID(self.object1.RootID);
				self.object1 = ToAttachable(self.object1);
				
				
				if IsActor(thing) then
					self.actor1 = ToActor(thing);
				end
			end

			if self.actor1 then
				
					self.actor1:FlashWhite(25);
						
			end
		end
		if self.object2 then
			
			if IsActor(self.object2) then
				self.actor2 = ToActor(self.object2)
			elseif IsAttachable(self.object2) then
					
				local thing = MovableMan:GetMOFromID(self.object2.RootID);
				self.object2 = ToAttachable(self.object2);
				
				if IsActor(thing) then
					self.actor2 = ToActor(thing);
				end
			end

			if self.actor2 then
				
					self.actor2:FlashWhite(25);
						
			end
		end
		if self.object3 then
			
			if IsActor(self.object1) then
				self.actor3 = ToActor(self.object3)
			elseif IsAttachable(self.object3) then
					
				local thing = MovableMan:GetMOFromID(self.object3.RootID);
				self.object3 = ToAttachable(self.object3);
				
				if IsActor(thing) then
					self.actor3 = ToActor(thing);
				end
			end

			if self.actor3 then
				
					self.actor3:FlashWhite(25);
						
			end
		end
		
		self:RemoveNumberValue("FlashingWhite");
		self:SetNumberValue("Stunning", 1)
		self.flashedTimer:Reset();
		
	end
	
	if self:GetNumberValue("Stunning") == 1 then
	
		if self.flashedTimer:IsPastSimMS(1000) then
		
			self:RemoveNumberValue("Stunning");
		
		else	
			if self.actor1 then
				self.actor1:GetController():SetState(Controller.WEAPON_FIRE,false);
			end	
			
			if self.actor2 then
				self.actor2:GetController():SetState(Controller.WEAPON_FIRE,false);
			end	
			
			if self.actor3 then
				self.actor3:GetController():SetState(Controller.WEAPON_FIRE,false);
			end	
		end
	end

	if self.parent then	
	
		if self:GetNumberValue("Flash Upgrade") == 1 then
	
			if self.parent:IsPlayerControlled() then

				if UInputMan:KeyPressed(Key.F) and self.flashCooldown:IsPastSimMS(5000) then-- 6 = F key
					self.actor1 = nil;
					self.actor2 = nil;
					self.actor3 = nil;
					sfxSetFlash = CreateAEmitter("Flash Baser");
					sfxSetFlash.Pos = self.MuzzlePos;
					MovableMan:AddParticle(sfxSetFlash);
					fxSetFlash = CreateMOPixel("Baser Flash Explosion");
					fxSetFlash.Pos = self.MuzzlePos;
					MovableMan:AddParticle(fxSetFlash);
					self.object1 = nil;
					self.object2 = nil;
					self.object3 = nil;
					local Vector1 = (Vector(140,0):GetXFlipped(self.HFlipped)):RadRotate(self.RotAngle);
					local Vector2 = (Vector(140,0):GetXFlipped(self.HFlipped)):RadRotate(self.RotAngle-20);
					local Vector3 = (Vector(140,0):GetXFlipped(self.HFlipped)):RadRotate(self.RotAngle+20);
					self.ray1 = SceneMan:CastMORay(self.MuzzlePos, Vector1, self.RootID, self.Team, 128, false, 1);
					self.ray2 = SceneMan:CastMORay(self.MuzzlePos, Vector2, self.RootID, self.Team, 128, false, 1);
					self.ray3 = SceneMan:CastMORay(self.MuzzlePos, Vector3, self.RootID, self.Team, 128, false, 1);
					if self.ray1 ~= nil then
						self.object1 = MovableMan:GetMOFromID(self.ray1); 
					end 	
					if self.ray2 ~= nil then
						self.object2 = MovableMan:GetMOFromID(self.ray2); 
					end 	
					if self.ray3 ~= nil then
						self.object3 = MovableMan:GetMOFromID(self.ray3); 
					end 			
					self:SetNumberValue("FlashingWhite", 1);
					self.flashCooldown:Reset();
				end
			end
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
			self.lastMag = self.Magazine;
			self.velApplied = false;
		else
		
			if self.velApplied == false then
				if MovableMan:IsParticle(self.lastMag) then
					self.lastMag.Vel = self.lastMag.Vel + Vector(0*self.negNum,-3):RadRotate(self.RotAngle);
				end
				self.velApplied = true;
			end
			
			self.newMag = true;
			self.lastMagazineAmmo = self.lastAmmo;
	
			if self.justShot == true then
				if self.ray < 0 or self.rayRight < 0 or self.rayLeft < 0 then
	
					if self.sfxSetTail ~= false then

						sfxSetTail = CreateAEmitter("Tail Baser");
						sfxSetTail.Pos = self.Pos;
						MovableMan:AddParticle(sfxSetTail);

					end
				end
				self.justShot = false;
			end
		end

		if self.chamber == true then
			self:SetNumberValue("ChamberRot", self.RotAngle)
			self:SetNumberValue("Chambering", 1)
			self:Deactivate();
			--self.parent:GetController():SetState(Controller.WEAPON_FIRE,false);

			if self.pullTimer:IsPastSimMS(450) then
				--self.parent:GetController():SetState(Controller.AIM_SHARP,false);
				--self.Frame = 1;

				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber " .. self.PresetName);
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);

					self.sfx = false;
				end

				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.num)/6;

				self:SetNumberValue("ChamberRot", self.RotAngle)

				self.num = self.num - math.pi*0.065;
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