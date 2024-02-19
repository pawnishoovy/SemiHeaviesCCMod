function Create(self)
	self.Frame = 0;
	self.parent = nil;
	self.reloadTimer = Timer();
	self.cockTimer = Timer()
	self.cockTimerReset = false
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

		
		if self.Mass then
	
			if self.parent.FiredFrame or self.parent:DoneReloading() then
				self.Frame = 0;
				self.cockTimerReset = false;
			end
			
			if self.parent:NumberValueExists("Chambering") then
		
				if self.pullTimerReset == false then
					self.pullTimer:Reset();
					self.pullTimerReset = true
				end
	
				if self.pullTimer:IsPastSimMS(600) then

					if self.cockTimerReset == false then
						self.cockTimer:Reset()
						self.cockTimerReset = true
					end

					if self.cockTimer:IsPastSimMS(20) and not self.cockTimer:IsPastSimMS(30) then
						self.Frame = 1
					elseif self.cockTimer:IsPastSimMS(30) and not self.cockTimer:IsPastSimMS(145) then
						self.Frame = 2
					elseif self.cockTimer:IsPastSimMS(145) and not self.cockTimer:IsPastSimMS(160) then
						self.Frame = 3
					elseif self.cockTimer:IsPastSimMS(160) and not self.cockTimer:IsPastSimMS(175) then
						self.Frame = 4
					elseif self.cockTimer:IsPastSimMS(175) and not self.cockTimer:IsPastSimMS(220) then
						self.Frame = 5
					elseif self.cockTimer:IsPastSimMS(220) and not self.cockTimer:IsPastSimMS(350) then
						self.Frame = 6
					elseif self.cockTimer:IsPastSimMS(350) and not self.cockTimer:IsPastSimMS(370) then
						self.Frame = 7
					elseif self.cockTimer:IsPastSimMS(370) and not self.cockTimer:IsPastSimMS(390) then
						self.Frame = 8
					elseif self.cockTimer:IsPastSimMS(390) and not self.cockTimer:IsPastSimMS(410) then
						self.Frame = 9
					elseif self.cockTimer:IsPastSimMS(410) and not self.cockTimer:IsPastSimMS(500) then
						self.Frame = 10
					elseif self.cockTimer:IsPastSimMS(500) and not self.cockTimer:IsPastSimMS(600) then
						self.Frame = 2
					elseif self.cockTimer:IsPastSimMS(600) and not self.cockTimer:IsPastSimMS(700) then
						self.Frame = 1
					end
			
					self.RotAngle = self.parent:GetNumberValue("ChamberRot")

				end
			else
				self.pullTimerReset = false;
				self.cockTimerReset = false;
				self.Frame = 0
			end
		end
	end
	if self.parentIdentified == true and IsHDFirearm(self.parent) == false then
		self.ToDelete = true;
	end
end



