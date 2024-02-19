function Create(self)
	self:SetNumberValue("Frags", 1)
	self.Sharpness = 1
end

function Update(self)
	if self.Fuze then

		if self.Fuze:IsPastSimMS(4000) then
			if self:GetNumberValue("Frags") == 2 then
				local Payload = CreateMOSRotating("WP Grenade Frags", "Semi-Heavies.rte");
				if Payload then
					Payload.Pos = self.Pos;
					MovableMan:AddParticle(Payload);
					Payload:GibThis();
					self:GibThis();
				end
			else
				self:GibThis();
			end
		end
	elseif self:IsActivated() then
		self.Fuze = Timer();
	end
end