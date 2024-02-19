function Create(self)

	self.engineStartTimer = Timer();
	self.engineTimerReset = false;
	print("hello world")

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
		print(self.parent)
		self.GetsHitByMOs = false

		if self.parent:GetNumberValue("CHARGEUPGRADE") == 1 then

			self:TriggerBurst();

			if self.engineTimerReset == false then

				self.engineStartTimer:Reset();
				self.engineTimerReset = true;

			end

			if self.engineStartTimer:IsPastSimMS(2533) then

				self:EnableEmission(true);

			end
		end
	end
end