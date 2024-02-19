function GunEcho(self)

	local Vector2 = Vector(0,-700);

	local Vector2Left = Vector(0,-700):RadRotate(45);

	local Vector2Right = Vector(0,-700):RadRotate(-45);

	local Vector3 = Vector(0,0);

	local Vector4 = Vector(0,0);

	self.ray = SceneMan:CastObstacleRay(self.Pos, Vector2, Vector3, Vector4, self.RootID, self.Team, 128, 7);

	self.rayRight = SceneMan:CastObstacleRay(self.Pos, Vector2Right, Vector3, Vector4, self.RootID, self.Team, 128, 7);

	self.rayLeft = SceneMan:CastObstacleRay(self.Pos, Vector2Left, Vector3, Vector4, self.RootID, self.Team, 128, 7);

	if self.ray < 0 or self.rayRight < 0 or self.rayLeft < 0 then
		return false
	else
		return true
	end
end

	