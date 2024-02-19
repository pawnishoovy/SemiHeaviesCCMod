function Update(self)

	if self.IsSetToDelete == true then
		self:GibThis();
	end
end

function Destroy(self)

	self:GibThis();

end