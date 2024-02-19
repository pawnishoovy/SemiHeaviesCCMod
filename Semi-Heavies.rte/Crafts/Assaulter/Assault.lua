function Create(self)
	self.explosiveTimer = Timer();
	
	if math.random() > 0.5 then
		self.AngularVel = -math.random(6, 10);
		self.Vel = Vector(math.random(2, 5), 20);
	else
		self.AngularVel = math.random(6, 10);
		self.Vel = Vector(-math.random(2, 5), 20);
	end
end

function Update(self)
	if self.explosiveTimer:IsPastSimMS(1000) then
		self.explosives = true;
	elseif self.Vel.Largest > 5 then
		self.explosiveTimer:Reset();
	end
end

function Destroy(self)
	ActivityMan:GetActivity():ReportDeath(self.Team, -1);
end
