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


		local actor = MovableMan:GetMOFromID(self.parent.RootID);
		if actor and IsAHuman(actor) then
			self.gunParent = ToAHuman(actor);
		else
			self.gunParent = nil;

		end

		
		if self.gunParent then
	
			if self.parent:IsReloading() then
				self.Frame = 0;
				self.cockTimerReset = false;
			end
			
			if self.parent:NumberValueExists("Chambering") then
		
				if self.pullTimerReset == false then
					self.pullTimer:Reset();
					self.pullTimerReset = true
				end
	
				if self.pullTimer:IsPastSimMS(5500) then

					if self.cockTimerReset == false then
						self.cockTimer:Reset()
						self.cockTimerReset = true
					end

					if self.cockTimer:IsPastSimMS(70) and not self.cockTimer:IsPastSimMS(85) then
						self.Frame = 2
					elseif self.cockTimer:IsPastSimMS(85) and not self.cockTimer:IsPastSimMS(100) then
						self.Frame = 3
					elseif self.cockTimer:IsPastSimMS(100) and not self.cockTimer:IsPastSimMS(115) then
						self.Frame = 4
					elseif self.cockTimer:IsPastSimMS(115) and not self.cockTimer:IsPastSimMS(130) then
						self.Frame = 1
					end
			
					self.RotAngle = self.parent:GetNumberValue("ChamberRot")

				end
			else
				self.pullTimerReset = false
				self.Frame = 0
			end
		end
	end
	if self.parentIdentified == true and IsHDFirearm(self.parent) == false then
		self.ToDelete = true;
	end
end



