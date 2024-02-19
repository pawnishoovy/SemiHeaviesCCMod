
function Create(self)

	self:SetNumberValue("Hyper", 1)

	self.parent = nil;
	self.pullTimer = Timer();
	self.chamberChecked = false
	self.chambers = false;
	self.burstTimer = Timer();
	self.burst = false;
	self.canBurst = true;

	self.newMag = false;
	self.chamber = true;
	--self.pullTimer:Reset();	--
	self.num = math.pi;	
	self.numTwo = math.pi;
	self.numThree = math.pi;
	self.numFinal = math.pi;
	self.sfx = true;		--

	self.negNum = 0;
	self.sLength = self.SharpLength;

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	end
end

function Update(self)

	if self.canBurst == true and self:IsActivated() and self.Magazine ~= nil and self.Magazine.RoundCount > 0 and self:GetNumberValue("Hyper") == 2 then 
		self.burstTimer:Reset();
		self.canBurst = false;
		self.burst = true;
	end

	if self.burst == true then
		if self.burstTimer:IsPastSimMS(201) then
			self.burstTimer:Reset();
			self:Deactivate();
			self.burst = false;
		else
			self:Activate();
		end
	else
		if self.canBurst == false then
			self:Deactivate();
			if self.burstTimer:IsPastSimMS(450) then
				self.canBurst = true;
			end
		end
	end

	local actor = MovableMan:GetMOFromID(self.RootID);
	if actor and IsAHuman(actor) then
		self.parent = ToAHuman(actor);
	else
		self.parent = nil;
	-- cock and load on pickup
		--self.chamber = true;	--
		--self.pullTimer:Reset();	--
		--self.num = math.pi;	--
		--self.sfx = true;	--
	end

	if self.HFlipped then
		self.negNum = -1;
	else
		self.negNum = 1;
	end

	if self.parent then

		if self.Magazine then

			if self.newMag == true then

				self.chamber = true;
				self.pullTimer:Reset();
				self.num = math.pi;
				self.numTwo = math.pi;
				self.numThree = math.pi;
				self.numFinal = math.pi;
				self.sfx = true;
				self.chamberChecked = false;
				self.chambers = false;

				self.newMag = false;
			end
		else
			self.newMag = true;
		end

		if self.chamber == true then

			self:Deactivate();
			--self.parent:GetController():SetState(Controller.WEAPON_FIRE,false);

			if self.pullTimer:IsPastSimMS(800) then


				if self.chamberChecked == false then

					if math.random(100) > 90 then
						self.chambers = true;

						if self.sfx ~= false then
							sfx = CreateAEmitter("Chamber Red Stare 2");
							sfx.Pos = self.Pos;
							MovableMan:AddParticle(sfx);

							self.sfx = false;
						end
					elseif math.random(100) <= 90 then
						self.chambers = false;
					end
					self.chamberChecked = true

				end

				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber Red Stare");
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);

					self.sfx = false;
				end

				self.SharpLength = self.SharpLength+(self.sLength/30)*math.sin(2*self.num);

				if self.chambers == true then

					self.RotAngle = self.RotAngle +self.negNum*math.sin(self.num)/10;

					self.num = self.num - math.pi*0.09;

				else

					self.RotAngle = self.RotAngle +self.negNum*math.sin(self.num)/7;

					self.num = self.num - math.pi*0.075;
				end

			end

			if self.num <= 0 then

				self.num = 0;
				self.chamber = false;
				self.SharpLength = self.sLength;
				if self.chambers == true then
					self.sfx = true;
					self.pullTimer:Reset();
					self.chamberTwo = true;
				end
			end
		end
		
		if self.chamberTwo == true then

			self:Deactivate();


			if self.pullTimer:IsPastSimMS(940) then


				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber Red Stare 3");
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);

					self.sfx = false;
				end

				self.SharpLength = self.SharpLength+(self.sLength/30)*math.sin(2*self.numTwo);

				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.numTwo)/10;

				self.numTwo = self.numTwo - math.pi*0.09;
			end

			if self.numTwo <= 0 then

				self.numTwo = 0;
				self.SharpLength = self.sLength;
				self.chamberTwo = false;
				self.sfx = true;
				self.pullTimer:Reset();
				self.chamberThree = true;
			end
		end
		
		
		if self.chamberThree == true then

			self:Deactivate();


			if self.pullTimer:IsPastSimMS(500) then


				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber Red Stare 4");
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);

					self.sfx = false;
				end

				self.SharpLength = self.SharpLength+(self.sLength/30)*math.sin(2*self.numThree);

				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.numThree)/15;

				self.numThree = self.numThree - math.pi*0.10;
			end

			if self.numThree <= 0 then

				self.numThree = 0;
				self.SharpLength = self.sLength;
				self.chamberThree = false;
				self.sfx = true;
				self.pullTimer:Reset();
				self.chamberFinal = true;
			end
		end
		

		if self.chamberFinal == true then

			self:Deactivate();


			if self.pullTimer:IsPastSimMS(100) then


				if self.sfx ~= false then
					sfx = CreateAEmitter("Chamber Red Stare");
					sfx.Pos = self.Pos;
					MovableMan:AddParticle(sfx);

					self.sfx = false;
				end

				self.SharpLength = self.SharpLength+(self.sLength/30)*math.sin(2*self.numFinal);

				self.RotAngle = self.RotAngle +self.negNum*math.sin(self.numFinal)/7;

				self.numFinal = self.numFinal - math.pi*0.075;
			end

			if self.numFinal <= 0 then

				self.numFinal = 0;
				self.SharpLength = self.sLength;
				self.chamberFinal = false;
			end
		end
	end
end