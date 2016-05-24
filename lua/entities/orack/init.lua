
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/\props_phx/mechanics/mech1.mdl" ) 
	self.Entity:SetName("Breach Loader")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Inputs = Wire_CreateInputs( self.Entity, { "Fire" } )
	self.Outputs = Wire_CreateOutputs(self.Entity, { "ShellsLeft" }) 

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
	end
	self.Entity:SetKeyValue("rendercolor", "255 255 255")
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.PhysObj:SetMass( 100 )
	
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	SpawnPos.z = SpawnPos.z + 50
	
	local ent = ents.Create( "orack" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent.SPL = ply
	
	return ent
	
end

function ENT:TriggerInput(iname, value)
	if (iname == "Fire") then
		if (value > 0) then
			if (CurTime() >= self.CDown) then
				local CShell = nil
				local DShell = value
				if (DShell == 1) then
					CShell = self.S1
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S1 = nil
				end
				if (DShell == 2) then
					CShell = self.S2
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S2 = nil
				end
				if (DShell == 3) then
					CShell = self.S3
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S3 = nil
				end
				if (DShell == 4) then
					CShell = self.S4
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S4 = nil
				end
				if (DShell == 5) then
					CShell = self.S5
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S5 = nil
				end
				if (DShell == 6) then
					CShell = self.S6
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S6 = nil
				end
				if (DShell == 7) then
					CShell = self.S7
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S7 = nil
				end
				if (DShell == 8) then
					CShell = self.S8
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S8 = nil
				end
				if (DShell == 9) then
					CShell = self.S9
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S9 = nil
				end
				if (DShell == 10) then
					CShell = self.S10
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S10 = nil
				end
				if (DShell == 11) then
					CShell = self.S11
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S11 = nil
				end
				if (DShell == 12) then
					CShell = self.S12
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S12 = nil
				end
				if (DShell == 13) then
					CShell = self.S13
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S13 = nil
				end
				if (DShell == 14) then
					CShell = self.S14
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S14 = nil
				end
				if (DShell == 15) then
					CShell = self.S15
					if (CShell == nil) then
						DShell = DShell + 1
					end
					self.S15 = nil
				end
				
				if ( CShell == nil ) then return end
				if ( !CShell:IsValid() ) then return end
				if ( CShell.BWeld:IsValid() ) then CShell.BWeld:Remove() end
				CShell.Fired = true
				CShell.SPL = self.SPL
				CShell:Fire("kill", "", 40)
				CShell.ParL = self.Entity
				self.CDown = CurTime() + 0.1
				
			end
		end
		
	end
end

function ENT:PhysicsUpdate()

end

function ENT:Think()
	
	local SCount = 0
	self.OWidth = 0
	if (self.S1 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S1.RWidth
--	elseif (self.S2 != nil) then
--		self.S1 = self.S2
--		self.S2 = nil
	end
	if (self.S2 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S2.RWidth
--	elseif (self.S3 != nil) then
--		self.S2 = self.S3
--		self.S3 = nil
	end
	if (self.S3 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S3.RWidth
--	elseif (self.S4 != nil) then
--		self.S3 = self.S4
--		self.S4 = nil
	end
	if (self.S4 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S4.RWidth
--	elseif (self.S5 != nil) then
--		self.S4 = self.S5
--		self.S5 = nil
	end
	if (self.S5 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S5.RWidth
--	elseif (self.S6 != nil) then
--		self.S5 = self.S6
--		self.S6 = nil
	end
	if (self.S6 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S6.RWidth
--	elseif (self.S7 != nil) then
--		self.S6 = self.S7
--		self.S7 = nil
	end
	if (self.S7 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S7.RWidth
--	elseif (self.S8 != nil) then
--		self.S7 = self.S8
--		self.S8 = nil
	end
	if (self.S8 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S8.RWidth
--	elseif (self.S9 != nil) then
--		self.S8 = self.S9
--		self.S9 = nil
	end
	if (self.S9 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S9.RWidth
--	elseif (self.S10 != nil) then
--		self.S9 = self.S10
--		self.S10 = nil
	end
	if (self.S10 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S10.RWidth
	end
	if (self.S11 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S11.RWidth
	end
	if (self.S12 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S12.RWidth
	end
	if (self.S13 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S13.RWidth
	end
	if (self.S14 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S14.RWidth
	end
	if (self.S15 != nil) then
		SCount = SCount + 1
		self.OWidth = self.OWidth + self.S15.RWidth
	end
	self.AWidth = self.MWidth - self.OWidth 
	


	Wire_TriggerOutput(self.Entity, "ShellsLeft", SCount)
end

function ENT:PhysicsCollide( data, physobj )

end

function ENT:Touch( activator )
		
	if (activator.ORackable == true && activator.BWeld == nil && activator.Fired == false && activator.RWidth <= self.AWidth) then
		local NShell = activator
		local NSAng = self.Entity:GetAngles()
		if (NShell.Horiz != true) then			
			NSAng.p = NSAng.p + 90
		end
		NShell:SetAngles( NSAng )
		if (self.S1 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			self.S1 = NShell
		elseif (self.S2 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			self.S2 = NShell
		elseif (self.S3 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			self.S3 = NShell
		elseif (self.S4 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			self.S4 = NShell
		elseif (self.S5 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			self.S5 = NShell
		elseif (self.S6 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			self.S6 = NShell
		elseif (self.S7 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S6, NShell.Entity, 0, 0)
			self.S7 = NShell
		elseif (self.S8 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S6, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S7, NShell.Entity, 0, 0)
			self.S8 = NShell
		elseif (self.S9 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S6, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S7, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S8, NShell.Entity, 0, 0)
			self.S9 = NShell
		elseif (self.S10 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S6, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S7, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S8, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S9, NShell.Entity, 0, 0)
			self.S10 = NShell
		elseif (self.S11 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S6, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S7, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S8, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S9, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S10, NShell.Entity, 0, 0)
			self.S11 = NShell
		elseif (self.S12 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S6, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S7, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S8, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S9, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S10, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S11, NShell.Entity, 0, 0)
			self.S12 = NShell
		elseif (self.S13 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S6, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S7, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S8, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S9, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S10, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S11, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S12, NShell.Entity, 0, 0)
			self.S13 = NShell
		elseif (self.S14 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S6, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S7, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S8, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S9, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S10, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S11, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S12, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S13, NShell.Entity, 0, 0)
			self.S14 = NShell
		elseif (self.S15 == nil) then
			NShell:SetPos( self.Entity:GetPos() + (self.Entity:GetRight() * -30) + (self.Entity:GetRight() * self.OWidth) + (self.Entity:GetRight() * (NShell.RWidth / 2) ) + (self.Entity:GetUp() * ( NShell.DWidth * -1 ) ) )
			NShell.BWeld = constraint.Weld(self.Entity, NShell.Entity, 0, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.Entity, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S1, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S2, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S3, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S4, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S5, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S6, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S7, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S8, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S9, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S10, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S11, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S12, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S13, NShell.Entity, 0, 0)
			NShell.BNoc = constraint.NoCollide(self.S14, NShell.Entity, 0, 0)
			self.S15 = NShell
		else
			return
		end
		
	end
	
end

function ENT:OnTakeDamage( dmginfo )
	
end

function ENT:Use( activator, caller )

end