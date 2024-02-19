function Create(self)
	self.Frame = 0;
	self.parent = nil;
	self.reloadTimer = Timer();
	self.timerReset = true
	self.num = math.pi;		--
	self.pullTimer = Timer();
	self.pullTimerReset = false
	self.clearTimerReset = false;
	self.clearTimer = Timer();

	self.negNum = 0;
end

function Update(self)

	if self.parent == nil then   -- if self.parent isn't defined
		mo = MovableMan:GetMOFromID(self.RootID);
			if mo then
				if IsHDFirearm(mo) then   -- if root ID is the gun
					self.parent = ToHDFirearm(mo);
			elseif IsAHuman(mo) then   -- if root ID is the actor holding the gun
				if ToAHuman(mo).EquippedItem and IsHDFirearm(ToAHuman(mo).EquippedItem) then
					self.parent = ToHDFirearm(ToAHuman(mo).EquippedItem);
					self.parentIdentified = true
				end
			end
		end

	elseif IsHDFirearm(self.parent) then
		self.GetsHitByMOs = false

		local actor = MovableMan:GetMOFromID(self.parent.RootID);
		if actor and IsAHuman(actor) then
			self.gunParent = ToAHuman(actor);
		else
			self.gunParent = nil;

		end

		if self.gunParent == nil and self.Reloaded == true then

			self.Reloaded = false;
			self.timerReset = false;
			self.Frame = 0

		end

		if self.gunParent then
	
			if self.parent:IsReloading() then
				self.Frame = 0;
				self.timerReset = false;
			elseif self.parent.Magazine then
			
			
				if self.timerReset == false then
					self.reloadTimer:Reset();
					self.timerReset = true;
					self.Reloaded = true;
					self.sfxOpen = true;
					self.sfxClose = true;
				elseif self.reloadTimer:IsPastSimMS(900) and not self.reloadTimer:IsPastSimMS(3700) and self.Reloaded == true then
					self.Frame = 1;

					if self.sfxOpen ~= false then
						sfx = CreateAEmitter("Cover Open A612 Overwhelmer");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
						self.sfxOpen = false
					end

				elseif self.reloadTimer:IsPastSimMS(3700) and self.Reloaded == true then
					self.Frame = 0;

					if self.sfxClose ~= false then
						sfx = CreateAEmitter("Cover Close A612 Overwhelmer");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
						self.sfxClose = false
					end
				end
				if self.reloadTimer:IsPastSimMS(5500) and self.Reloaded == true then
					self.Reloaded = false;
				end

				if self.Reloaded == false then
					self.Frame = 0;
				end	
			end
			if self.parent:NumberValueExists("Chambering") then
		
				if self.pullTimerReset == false then
					self.pullTimer:Reset();
					self.pullTimerReset = true
				end
	
				if self.pullTimer:IsPastSimMS(5500) then
			
					self.RotAngle = self.parent:GetNumberValue("ChamberRot")

				end
			else
				self.pullTimerReset = false
			end
			if self.parent:NumberValueExists("Clearing Jam") then
				if self.clearTimerReset == false then
					self.clearTimer:Reset();
					self.clearTimerReset = true;
					self.sfxOpen = true;
					self.sfxFiddle = true;
					self.sfxClose = true;
				elseif self.reloadTimer:IsPastSimMS(100) and not self.clearTimer:IsPastSimMS(900) then
					self.Frame = 1;

					if self.sfxOpen ~= false then
						sfx = CreateAEmitter("Cover Open A612 Overwhelmer");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
						self.sfxOpen = false
					end
					
				elseif self.reloadTimer:IsPastSimMS(900) and not self.clearTimer:IsPastSimMS(1800) then
					self.Frame = 1;

					if self.sfxFiddle ~= false then
						sfx = CreateAEmitter("Clear Jam A612");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
						self.sfxFiddle = false
					end

				elseif self.clearTimer:IsPastSimMS(1800) then
					self.Frame = 0;

					if self.sfxClose ~= false then
						sfx = CreateAEmitter("Cover Close A612 Overwhelmer");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
						self.sfxClose = false
					end
				end
			else
				self.clearTimerReset = false;
			end
		end
	end
	if self.parentIdentified == true and IsHDFirearm(self.parent) == false then
		self.ToDelete = true;
	end
end



