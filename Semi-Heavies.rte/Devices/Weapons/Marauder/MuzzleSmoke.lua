function Update(self)

	local rayhitpos = Vector(0,0)

	if SceneMan:CastStrengthRay(self.Pos,Vector(self.Vel.X,self.Vel.Y):SetMagnitude(0.5),0,Vector(0,0),0,128,SceneMan.SceneWrapsX) == true then
		self.Sharpness = 3
	end
end
		