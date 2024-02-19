function Update(self)
	local Effect
	
	if math.random(100) > 93 then
		Effect = CreateMOPixel("Spark Yellow 1")
		if Effect then
			Effect.Pos = self.Pos
			Effect.Vel = ((self.Vel / 2) + Vector(RangeRand(-20,20), RangeRand(-20,20))) / 30
			MovableMan:AddParticle(Effect)
		end
	end

	if math.random(100) > 98 then
		Effect = CreateMOPixel("Spark Yellow 2")
		if Effect then
			Effect.Pos = self.Pos
			Effect.Vel = ((self.Vel / 2) + Vector(RangeRand(-20,20), RangeRand(-20,20))) / 30
			MovableMan:AddParticle(Effect)
		end
	end

	for i = 1, self.dots do
		local checkPos = self.Pos + Vector(self.Vel.X,self.Vel.Y):SetMagnitude((i/self.dots)*self.raylength);
		if SceneMan.SceneWrapsX == true then
			if checkPos.X > SceneMan.SceneWidth then
				checkPos = Vector(checkPos.X - SceneMan.SceneWidth,checkPos.Y);
			elseif checkPos.X < 0 then
				checkPos = Vector(SceneMan.SceneWidth + checkPos.X,checkPos.Y);
			end
		end
		local terrCheck = SceneMan:GetTerrMatter(checkPos.X,checkPos.Y);
		if terrCheck == 178 or terrCheck == 177 and self.hardHit == false then
			if math.random(100) > 50 then
				Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
				if Effect then
					Effect.Pos = self.Pos
					Effect.Vel = ((self.Vel*-1) + Vector(RangeRand(-100,100), RangeRand(-10,10))) / 10
					MovableMan:AddParticle(Effect)
				end
			end

			if math.random(100) > 50 then
				Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
				if Effect then
					Effect.Pos = self.Pos
					Effect.Vel = ((self.Vel*-1) + Vector(RangeRand(-100,100), RangeRand(-20,20))) / 10
					MovableMan:AddParticle(Effect)
				end
			end
			self.hardHit = true
		end
	end

end


function Destroy(self)
	local Effect
	local Offset = self.Vel*(8*TimerMan.DeltaTimeSecs)


	
	for i = 1, 3 do
		Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
		if Effect then
			Effect.Pos = self.Pos + Offset
			Effect.Vel = ((self.Vel*-1) + Vector(RangeRand(-100,100), RangeRand(-10,10))) / 10
			MovableMan:AddParticle(Effect)
		end
	end

	for i = 1, 3 do
		Effect = CreateMOSParticle("Tiny Smoke Ball 1", "Base.rte")
		if Effect then
			Effect.Pos = self.Pos + Offset
			Effect.Vel = ((self.Vel*-1) + Vector(RangeRand(-20,20), RangeRand(-20,20))) / 30
			MovableMan:AddParticle(Effect)
		end
	end
	
	for i = 1, 5 do
		Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
		if Effect then
			Effect.Pos = self.Pos + Offset
			Effect.Vel = ((self.Vel*-1) + Vector(RangeRand(-100,100), RangeRand(-20,20))) / 10
			MovableMan:AddParticle(Effect)
		end
	end

	for i = 1, 5 do
		Effect = CreateMOSParticle("Side Thruster Blast Ball 1", "Base.rte")
		if Effect then
			Effect.Pos = self.Pos + Offset
			Effect.Vel = ((self.Vel*-1) + Vector(RangeRand(-20,20), RangeRand(-10,10))) / 30
			MovableMan:AddParticle(Effect)
		end
	end

	if math.random(100) > 99 then
		Effect = CreateMOSParticle("Explosion Smoke 2 Glow")
		if Effect then
			Effect.Pos = self.Pos + Offset
			Effect.Vel = ((self.Vel*-1) + Vector(RangeRand(-20,20), RangeRand(-20,20))) / 10
			MovableMan:AddParticle(Effect)
		end
	end
	if math.random(100) > 99 then
		Effect = CreateMOSParticle("Explosion Smoke 1")
		if Effect then
			Effect.Pos = self.Pos + Offset
			Effect.Vel = ((self.Vel*-1) + Vector(RangeRand(-20,20), RangeRand(-20,20))) / 10
			MovableMan:AddParticle(Effect)
		end
	end
end