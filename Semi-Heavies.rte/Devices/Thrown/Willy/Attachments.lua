function Create(self)
	self.Frame = 0;
	self.parentIdentified = false
	self.parent = nil
end

function Update(self)
	
	if self.parent == nil and self.parentIdentified == false then   -- if self.parent isn't defined

		self.mo = MovableMan:GetMOFromID(self.RootID);
		if self.mo then
			if IsTDExplosive(self.mo) then   -- if root ID is the gun
				self.parent = ToTDExplosive(self.mo);
				self.parentIdentified = true
			elseif IsAHuman(self.mo) then   -- if root ID is the actor holding the gun
				if ToAHuman(self.mo).EquippedItem and IsTDExplosive(ToAHuman(self.mo).EquippedItem) then
					self.parent = ToTDExplosive(ToAHuman(self.mo).EquippedItem);
					self.parentIdentified = true
				end
			end
		end
	elseif IsTDExplosive(self.parent) then
		self.GetsHitByMOs = false
		if self.parent:GetNumberValue("Frags") == 1 or self.parent.Sharpness == 1 then
			self.Frame = 0
		elseif self.parent:GetNumberValue("Frags") == 2 or self.parent.Sharpness == 2 then
			self.Frame = 1
		end
	end
	if self.parentIdentified == true and IsTDExplosive(self.parent) == false then
		self.ToDelete = true;
	end
end



