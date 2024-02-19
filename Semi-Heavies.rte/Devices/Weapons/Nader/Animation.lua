function Create(self)
	self.Frame = 0;
	self.parentIdentified = false;
	self.reloadTimerReset = false;
	self.reloadTimer = Timer();

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
	
		if self.parent:IsReloading() then
			if self.reloadTimerReset == false then
				self.reloadTimer:Reset();
				self.reloadTimerReset = true;
			end
			if self.reloadTimer:IsPastSimMS(700) then
				self.Frame = 1;
			end
		else
			self.Frame = 0;
			self.reloadTimerReset = false;
		end
	end
	if self.parentIdentified == true and IsHDFirearm(self.parent) == false then
		self.ToDelete = true;
	end
end



