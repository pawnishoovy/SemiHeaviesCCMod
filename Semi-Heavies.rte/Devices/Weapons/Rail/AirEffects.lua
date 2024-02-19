function Create(self)
	local Effect
	local Offset = self.Vel*(20*TimerMan.DeltaTimeSecs)	-- the effect will be created the next frame so move it one frame backwards towards the barrel

	for i = 1, 6 do
		Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
		if Effect then
			Effect.Pos = self.Pos - Offset
			Effect.Vel = (self.Vel + Vector(RangeRand(-20,20), RangeRand(-20,20))) / 30
			MovableMan:AddParticle(Effect)
		end
	end
	
	if PosRand() < 0.9 then
		Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
		if Effect then
			Effect.Pos = self.Pos - Offset
			Effect.Vel = (self.Vel + Vector(RangeRand(-30,30), RangeRand(-30,30))) / 30
			MovableMan:AddParticle(Effect)
		end
	end
end

function Update(self)
	local Effect
	local Offset = self.Vel*(20*TimerMan.DeltaTimeSecs)	-- the effect will be created the next frame so move it one frame backwards towards the barrel
	
	-- smoke trail
	for i = 1, math.floor(self.Vel.Magnitude*0.045) do
		if PosRand() < 0.2 then
			Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
			if Effect then
				Effect.Pos = self.Pos - Offset * i/8 + Vector(RangeRand(-2,2),RangeRand(-2,2))
				Effect.Vel = (self.Vel + Vector(RangeRand(-10,30),RangeRand(-10,10))) / 20
				MovableMan:AddParticle(Effect)
			end
		end
	end
end