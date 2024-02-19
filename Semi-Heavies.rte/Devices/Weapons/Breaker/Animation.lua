function Create(self)
	self.Frame = 0;
	self.parent = nil;
	self.reloadTimer = Timer();
	self.cockTimer = Timer();
	self.cockTimerReset = false;
	self.num = math.pi;		--
	self.pullTimer = Timer();
	self.pullTimerReset = false;
	self.moveTimer = Timer();
	self.moveTimerReset = false;
	self.reloadEndAnimDone = false;

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

		
		if self.Mass then
	
			if self.parent.FiredFrame then
				self.Frame = 0;
				self.cockTimerReset = false;
			end

			
			if self.parent:NumberValueExists("Chambering") then
				self.moveTimerReset = false;
		
				if self.pullTimerReset == false then
					self.pullTimer:Reset();
					self.pullTimerReset = true
				end
	
				if self.pullTimer:IsPastSimMS(self.parent:GetNumberValue("Pull Delay")) then

					self.cockTimeDivided = self.parent:GetNumberValue("Total Cock Time") / 4

					if self.cockTimerReset == false then
						self.cockTimer:Reset()
						self.cockTimerReset = true
					end

					if self.cockTimer:IsPastSimMS(0) and not self.cockTimer:IsPastSimMS(self.cockTimeDivided) then
						self.Frame = 1
					elseif self.cockTimer:IsPastSimMS(self.cockTimeDivided) and not self.cockTimer:IsPastSimMS(self.cockTimeDivided * 3 + 20) then
						self.Frame = 2
					elseif self.cockTimer:IsPastSimMS(self.cockTimeDivided * 3 + 20) and not self.cockTimer:IsPastSimMS(self.cockTimeDivided * 4) then
						self.Frame = 1
					elseif self.cockTimer:IsPastSimMS(self.cockTimeDivided * 4)then
						self.Frame = 0
					end
			
					self.RotAngle = self.parent:GetNumberValue("ChamberRot")

				end
			else
				self.pullTimerReset = false
				if self.reloadEndAnimDone == true then
					self.Frame = 0
				end
			end
			if self.parent:NumberValueExists("ReloadStarted") then

				self.reloadEndAnimDone = false;

				if self.moveTimerReset == false then
					self.moveTimer:Reset();
					self.moveTimerReset = true;
				end

				if self.moveTimer:IsPastSimMS(70) and not self.moveTimer:IsPastSimMS(150) then
					self.Frame = 0
				elseif self.moveTimer:IsPastSimMS(150) and not self.moveTimer:IsPastSimMS(220) then
					self.Frame = 1
				elseif self.moveTimer:IsPastSimMS(220) then
					self.Frame = 2
				end
			end
			

			if self.parent:NumberValueExists("ReloadEnded") then

				if self.reloadEndAnimDone == false then

					if self.moveTimerReset == true then
						self.moveTimer:Reset();
						self.moveTimerReset = false;
					end

					if self.moveTimer:IsPastSimMS(20) and not self.moveTimer:IsPastSimMS(90) then
						self.Frame = 2
					elseif self.moveTimer:IsPastSimMS(90) and not self.moveTimer:IsPastSimMS(170) then
						self.Frame = 1
					elseif self.moveTimer:IsPastSimMS(170) then
						self.Frame = 0
						self.reloadEndAnimDone = true;
					end
				end
			end
		end
	end
	if self.parentIdentified == true and IsHDFirearm(self.parent) == false then
		self.ToDelete = true;
	end
end



