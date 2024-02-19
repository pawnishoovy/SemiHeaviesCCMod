function Create(self)

	self.lifeTimer = Timer();
	self.goodGib = false;
	
	for i = 1, 3 do
		Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
		if Effect then
			Effect.Pos = self.Pos
			Effect.Vel = (self.Vel + Vector(RangeRand(-50,50), RangeRand(-50,50))) / 30
			Effect.Team = self.Team
			MovableMan:AddParticle(Effect)
		end
	end
	
	if PosRand() < 0.1 then
		Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
		if Effect then
			Effect.Pos = self.Pos
			Effect.Vel = (self.Vel + Vector(RangeRand(-30,30), RangeRand(-30,30))) / 20
			Effect.Team = self.Team
			MovableMan:AddParticle(Effect)
		end
	end
	for i = 1, 7 do
		Effect = CreateMOSParticle("Breaker Smoke", "Semi-Heavies.rte")
		if Effect then
			Effect.Pos = self.Pos
			Effect.Vel = (self.Vel + Vector(RangeRand(-40,40), RangeRand(-40,40))) / 30
			Effect.Team = self.Team
			MovableMan:AddParticle(Effect)
		end
	end	
end

function Update(self)

	if self.lifeTimer:IsPastSimMS(180) then
		local explosion = CreateAEmitter("Airburst Explosion Breaker");
		explosion.Pos = self.Pos;
		explosion.Vel = self.Vel;
		explosion.RotAngle = self.RotAngle;
		MovableMan:AddParticle(explosion);
		self.goodGib = true;
		sfx = CreateAEmitter("Airburst Explode Breaker");
		sfx.Pos = self.Pos;
		MovableMan:AddParticle(sfx);
		self.ToDelete = true;
	end

end

function Destroy(self)

	ActivityMan:GetActivity():ReportDeath(self.Team,-1);
	if self.goodGib == false then
		sfx = CreateAEmitter("Airburst Fizzle Breaker");
		sfx.Pos = self.Pos;
		MovableMan:AddParticle(sfx);
	end		

end