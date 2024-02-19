function Create(self)

	self.ejectedShell = false;
	self.Sharpness = 1
	self.StoredSharpness = 1

end

function Update(self)

	if self.Magazine ~= nil then
		self.RoundsWasted = self.Magazine.RoundCount
		self.ejectedShell = false;
	else
		if self.ejectedShell == false then
			self.ejectedShell = true;
			if self.HFlipped == false then
				self.negativeNum = 1;
			else
				self.negativeNum = -1;
			end
			if self.StoredSharpness == 1 then
				for i = 1, 5 do
					local shell = CreateMOSParticle("Casing");
					shell.Pos = self.Pos;
					shell.Vel = Vector(math.random()*(-3)*self.negativeNum,0):RadRotate(self.RotAngle):DegRotate((math.random()*32)-16);
					MovableMan:AddParticle(shell);
				end
			end
			if self.StoredSharpness == 2 then
				for i = 1, self.RoundsWasted do
					local shell = CreateAEmitter("Adapt Unused Flare");
					shell.Pos = self.Pos;
					shell.Vel = Vector(math.random()*(-3)*self.negativeNum,0):RadRotate(self.RotAngle):DegRotate((math.random()*32)-16);
					MovableMan:AddParticle(shell);
				end
			end
			if self.StoredSharpness == 3 then
				for i = 1, 5 do
					local shell = CreateAEmitter("Adapt Shotgun Shell");
					shell.Pos = self.Pos;
					shell.Vel = Vector(math.random()*(-3)*self.negativeNum,0):RadRotate(self.RotAngle):DegRotate((math.random()*32)-16);
					MovableMan:AddParticle(shell);
				end
			end
		end
	end
	self.StoredSharpness = self.Sharpness
end