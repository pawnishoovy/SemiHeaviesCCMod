function Create(self)

end

function Update(self)

	if self.parent == nil then   -- if self.parent isn't defined

		local mo mo = MovableMan:GetMOFromID(self.RootID);
		if mo then
			if IsHeldDevice(mo) then   -- if root ID is the gun
				self.parent = ToHeldDevice(mo);
				self.parentIdentified = true
			elseif IsAHuman(mo) then   -- if root ID is the actor holding the gun
				for i = 1 , MovableMan:GetMOIDCount() - 1 do
					local part = MovableMan:GetMOFromID(i);
					if part.ClassName == "HeldDevice" then
						local thing = ToHeldDevice(part)
						if part.RootID == self.RootID and thing:GetNumberValue("Hi") == 123 then
							self.parent = ToHeldDevice(part);
							self.parentIdentified = true
						end
					end
				end
			end
		end
	elseif IsHeldDevice(self.parent) then
		self:ClearForces();
		self:ClearImpulseForces();
	
		self.Frame = self.parent:GetNumberValue("Required Frame");
		
		if self.parent:GetNumberValue("Protection") == 1 then
			self.GetsHitByMOs = true;
		else
			self.GetsHitByMOs = false;
		end
		if self.Frame == 1 then
			self:RemoveWounds(self.WoundCount);
		end
	end
	if self.parentIdentified == true and IsHeldDevice(self.parent) == false then
		self.ToDelete = true;
	end
end