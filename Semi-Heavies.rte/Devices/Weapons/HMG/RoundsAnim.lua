function Create(self)
	self.Frame = 1;
	self.parent = nil;
	self.reloadTimer = Timer();
	self.timerReset = true;
	self.num = math.pi;		--
	self.pullTimer = Timer();
	self.pullTimerReset = false

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
					self.sfx = true;
				elseif self.reloadTimer:IsPastSimMS(2980) and not self.reloadTimer:IsPastSimMS(3060) and self.Reloaded == true then
					self.Frame = 2;

					if self.sfx ~= false then
						sfx = CreateAEmitter("Rounds In A612 Overwhelmer");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);
						self.sfx = false
					end

				elseif self.reloadTimer:IsPastSimMS(3060) and not self.reloadTimer:IsPastSimMS(3140) and self.Reloaded == true then
					self.Frame = 3;
				elseif self.reloadTimer:IsPastSimMS(3140) and self.Reloaded == true then
					self.Frame = 1;
				end
				if self.reloadTimer:IsPastSimMS(5500) and self.Reloaded == true then
					self.Reloaded = false;
				end

				
				if self.parent.Magazine.RoundCount == 3 then
					self.Frame = 4;
				elseif self.parent.Magazine.RoundCount == 2 then
					self.Frame = 5;
				elseif self.parent.Magazine.RoundCount == 1 then
					self.Frame = 0;
				elseif self.Reloaded == false and not self.parent.Magazine.RoundCount == 0 then
					self.Frame = 1;
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
		end
	end
	if self.parentIdentified == true and IsHDFirearm(self.parent) == false then
		self.ToDelete = true;
	end
end



