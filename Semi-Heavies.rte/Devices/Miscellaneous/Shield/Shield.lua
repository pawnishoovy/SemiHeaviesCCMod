function Create(self)

	self.requiredFrame = 1;
	self.animTime = 250;
	self.animTimer = Timer();
	self.moveSoundTimer = Timer()
	self:SetNumberValue("Extended", 0);	-- not extended on startup
	self:SetNumberValue("Extending", 0);
	self:SetNumberValue("Retracting", 0);
	self:SetNumberValue("Protection", 0);
	self:SetNumberValue("Hi", 123); -- identifier for attachment parent-detecting script so it doesn't latch onto disarmers etc
	
	-- WARNING: the frames are weird because 000 needs to be full for the game to make a proper collision mesh. 000 is technically
	-- unused.


end

function Update(self)

	local parent;
	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		parent = ToAHuman(actor);
		if parent.EquippedItem then
			if IsHDFirearm(parent.EquippedItem) then
				self.parentGun = ToHDFirearm(parent.EquippedItem);
				if self.ToDelete then
					self.parentGun:SetNumberValue("Move To Cover", 0);
				end
			else
				self.parentGun = nil;
			end
		else
			self.parentGun = nil;
		end
	end


	-- handle animations for attachment
	
	if self:GetNumberValue("Extending") == 1 then
	
		if self.parentGun then
			self.parentGun:SetNumberValue("Move To Cover", 1);
		end
	
		local delay = self.animTime / 5; -- divide by frames on the attachment for smoothness
	
		if self.animTimer:IsPastSimMS(delay) then
		
			self.requiredFrame = self.requiredFrame + 1;
			self:SetNumberValue("Required Frame", self.requiredFrame);
			
			self.animTimer:Reset();
			
		end
			
		if self.requiredFrame > 5 then -- animation is done, stop extended and start being extended
		
			self:SetNumberValue("Extending", 0);
			self:SetNumberValue("Extended", 1);
			self:SetNumberValue("Protection", 1);
			self.JointStiffness = 0.1;
		end
	end
	
	if self:GetNumberValue("Retracting") == 1 then
	
		if self.parentGun then
			self.parentGun:SetNumberValue("Move To Cover", 0);
		end
	
		local delay = self.animTime / 5; 
	
		if self.animTimer:IsPastSimMS(delay) then
		
			self.requiredFrame = self.requiredFrame - 1;
			self:SetNumberValue("Required Frame", self.requiredFrame);
			
			self.animTimer:Reset();
			
		end
			
		if self.requiredFrame < 2 then 
		
			self:SetNumberValue("Retracting", 0);
			self:SetNumberValue("Extended", 0);
			self:SetNumberValue("Protection", 0);
			self.JointStiffness = 0.7;
		end
	end
			
	self:SetNumberValue("Required Frame", self.requiredFrame); -- set number to give to attachment after all is calculated		
			
	-- get parent
	local parent;
	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		
		parent = ToAHuman(actor);
		self.parent = ToAHuman(actor);

		if self:GetNumberValue("Extended") == 1 then		
			parent:GetController():SetState(Controller.WEAPON_FIRE,false);
			self:SetNumberValue("Protection", 1); -- tell attachment to start getting hit by mos
			self.JointStiffness = 0.1;
		else
			self:SetNumberValue("Protection", 0);
			self.JointStiffness = 0.7;
			self.changedOffsetAndRotAngle = false;
		end
		
		if parent:IsPlayerControlled() then
		
			if UInputMan:KeyPressed(Key.F) then -- if F is pressed
			
		
				if self:GetNumberValue("Extending") == 0 and self:GetNumberValue("Retracting") == 0 then -- if not in an animation
				
					if self:GetNumberValue("Extended") == 0 then
						self:SetNumberValue("Extending", 1);
						local sfx = CreateAEmitter("Shield Extend");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);						
					else			
						self:SetNumberValue("Retracting", 1);
						local sfx = CreateAEmitter("Shield Retract");
						sfx.Pos = self.Pos;
						MovableMan:AddParticle(sfx);						
					end
					self.animTimer:Reset();
				end
			end
		end
			
		if parent:GetController():IsState(Controller.MOVE_LEFT) or parent:GetController():IsState(Controller.MOVE_RIGHT) then
		
			--script for making sounds on move, up: check for left or right presses down: use a timer to make sounds every 800ms

			if self.moveSoundTimer:IsPastSimMS(800) then
				local sfx = CreateAEmitter("Shield Move");
				sfx.Pos = self.Pos;
				MovableMan:AddParticle(sfx);	
				self.moveSoundTimer:Reset();
			end
		end		
	end
end