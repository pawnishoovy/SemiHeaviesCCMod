function Create(self)
	self.Frame = 0;
	self.parent = nil;
	self.num = math.pi;		--
	self.pullTimer = Timer();
	self.timerReset = false
	self.parentIdentified = false

	self.negNum = 0;
end

function Update(self)
	
	
	if self.parent == nil and self.parentIdentified == false then   -- if self.parent isn't defined

		mo = MovableMan:GetMOFromID(self.RootID);
		if mo then
			if IsHDFirearm(mo) then   -- if root ID is the gun
				self.parent = ToHDFirearm(mo);
				self.parentIdentified = true
			elseif IsAHuman(mo) then   -- if root ID is the actor holding the gun
				if ToAHuman(mo).EquippedItem and IsHDFirearm(ToAHuman(mo).EquippedItem) then
					self.parent = ToHDFirearm(ToAHuman(mo).EquippedItem);
					self.parentIdentified = true
				end
			end
		end

	elseif IsHDFirearm(self.parent) then
		self.GetsHitByMOs = false
	
		self.RotAngle = self.parent.RotAngle
		if self.parent.Sharpness == 1 then
			self.Frame = 0
		elseif self.parent.Sharpness == 2 then
			self.Frame = 1
		elseif self.parent.Sharpness == 3 then
			self.Frame = 2
		elseif self.parent.Sharpness == 4 then
			self.Frame = 3
		elseif self.parent.Sharpness == 5 then
			self.Frame = 4
		elseif self.parent.Sharpness == 6 then
			self.Frame = 5
		elseif self.parent.Sharpness == 7 then
			self.Frame = 6
		elseif self.parent.Sharpness == 8 then
			self.Frame = 7
		end
		if self.parent:NumberValueExists("Chambering") then
		
			if self.timerReset == false then
				self.pullTimer:Reset();
				self.timerReset = true
			end

			if self.pullTimer:IsPastSimMS(self.parent:GetNumberValue("Pulldelay")) then
			
				self.RotAngle = self.parent:GetNumberValue("ChamberRot")

			end
		else
				self.timerReset = false
		end
	end
	if self.parentIdentified == true and IsHDFirearm(self.parent) == false then
		self.ToDelete = true;
	end
end



