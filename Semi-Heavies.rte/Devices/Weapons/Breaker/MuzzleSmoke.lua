function Create(self)
	local Effect

	self.time = math.random(20,60);
	self.timer = Timer();
end

function Update(self)

	if self.timer:IsPastSimMS(self.time) then
		self.timer:Reset();

		self.Mass = self.Mass*0.95;
		self.Sharpness = self.Sharpness*0.95;
	end
end