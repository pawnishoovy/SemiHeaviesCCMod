function Update(self)
	if math.random() > 0.95 then
		local dist, part, chosenpart
		local curdist = 25

		--Cycle through all MOs and see which is the closest.
		for i = 1, MovableMan:GetMOIDCount() - 1 do
			part = MovableMan:GetMOFromID(i)
			if part and part.ClassName ~= "MOSParticle" and part.ClassName ~= "MOPixel" and part.ClassName ~= "HDFirearm" and part.ClassName ~= "HeldDevice" then
				part = ToMovableObject(part)
				dist = SceneMan:ShortestDistance(self.Pos, part.Pos, false).Magnitude
				if dist < curdist then
					curdist = dist
					chosenpart = part
				end
			end
		end

		--If a part was found in the range, find its parent actor and heal it.
		if chosenpart then
			local MO = MovableMan:GetMOFromID(chosenpart.RootID)
			if MovableMan:IsActor(MO) then
				MO = ToActor(MO)
				if MO.Health < 100 then
					MO.Health = MO.Health + 1
				end
			end
		end
	end
end