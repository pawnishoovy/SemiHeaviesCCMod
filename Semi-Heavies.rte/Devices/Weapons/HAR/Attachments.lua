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

		self.mo = MovableMan:GetMOFromID(self.RootID);
		if self.mo then
			if IsHDFirearm(self.mo) then   -- if root ID is the gun
				self.parent = ToHDFirearm(self.mo);
				self.parentIdentified = true
			elseif IsAHuman(self.mo) then   -- if root ID is the actor holding the gun
				if ToAHuman(self.mo).EquippedItem and IsHDFirearm(ToAHuman(self.mo).EquippedItem) then
					self.parent = ToHDFirearm(ToAHuman(self.mo).EquippedItem);
					self.parentIdentified = true
				end
			end
		end
	elseif IsHDFirearm(self.parent) then
		self.GetsHitByMOs = false
		self.RotAngle = self.parent.RotAngle
		if self.parent:GetNumberValue("ACCUPGRADES") == 1 then
			self.Frame = 0
		else
			self.Frame = 1
		end
		if self.parent:NumberValueExists("Chambering") then
		
			if self.timerReset == false then
				self.pullTimer:Reset();
				self.timerReset = true
			end

			if self.pullTimer:IsPastSimMS(1300) then
			
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



