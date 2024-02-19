function Create(self)
	self.healdecrease = 1
	self.healtimer = Timer()
	self.healInterval = 1000;
end

function Update(self)

	for actor in MovableMan.Actors do
	    if (actor.Pos.X >= self.Pos.X - 20) and (actor.Pos.X <= self.Pos.X + 20) and (actor.Pos.Y >= self.Pos.Y - 21) and (actor.Pos.Y <= self.Pos.Y + 21) then
			self.target = actor;
			self.Pos = self.target.Pos;
			if self.healtimer:IsPastSimMS(self.healInterval) then
				actor.Health = actor.Health - self.healdecrease;
				self.healtimer:Reset();
			end
		end
	end
end
