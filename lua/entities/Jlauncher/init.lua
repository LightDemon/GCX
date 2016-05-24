
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/props_phx/amraam.mdl" ) 
	self.Entity:SetName("Jlauncher")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Inputs = Wire_CreateInputs( self.Entity, { "X", "Y", "Z", "Launch", "Lock", "LockTime", "Distance"} )
	self.ammos = 1
	self.armed = false
	self.loading = false
	self.reloadtime = 0
	self.infire = false
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
	end

    	self.Entity:SetKeyValue("rendercolor", "255 255 255")
		self.PhysObj = self.Entity:GetPhysicsObject()


end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( "Jlauncher" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:TriggerInput(iname, value)
	if (iname == "X") then
		self.XCo = value

	elseif (iname == "Y") then
		self.YCo = value

	elseif (iname == "Z") then
		self.ZCo = value

	elseif (iname == "Launch") then
		if (value > 0) then
			if (self.Launched == 0) then
				self.infire = true
				self.Launched = 1
			end
		elseif (value <= 0) then
			self.infire = false
			self.Launched = 0
		end

	elseif (iname == "Lock") then
		if (value > 0) then
			self.Locked = true
		else
			self.Locked = false
		end

	elseif (iname == "LockTime") then
		if (value > 0) then
			self.LTime = value
		else
			self.LTime = 1000000
		end
		
	elseif (iname == "Distance") then
		if (value > 0) then
			self.Dist = value
		else
			self.Dist = 0
		end	
	end
end


function ENT:PhysicsUpdate()

end

function ENT:firezemeesiles()
	if (self.ammos > 0) then
		self.ammos = self.ammos - 1
	
	local NewRock = ents.Create( "Jericho" )
		if ( !NewRock:IsValid() ) then return end
		NewRock:SetPos( self.Entity:GetPos() + (self.Entity:GetForward() * 150))
		NewRock:SetModel( "models/props_phx/amraam.mdl" )
		NewRock:SetAngles( self.Entity:GetAngles() )
		NewRock.ParL = self.Entity
		NewRock:SetVar("Owner", self.Entity:GetVar("Owner"))
		NewRock:Spawn()
		NewRock:Initialize()
		NewRock:Activate()
		self.Entity:EmitSound( "weapons/stinger_fire1.wav", 500, 100 )
		
	else 
		self.armed = false
		self.ammos = 1
		self.reloadtime = CurTime() + 10
	end

end

function ENT:Think()
	if (self.reloadtime > CurTime()) then
		self.armed = false
	end
	
	if (self.armed == true) then
		self:firezemeesiles()
	elseif (self.reloadtime < CurTime()) then
		if (self.infire == true)
			then self.armed = true
	end
end	

	self.Entity:NextThink( CurTime() + 0.2)
	return true
end

function ENT:PhysicsCollide( data, physobj )
	
end

function ENT:OnTakeDamage( dmginfo )
	
end

function ENT:Use( activator, caller )

end
