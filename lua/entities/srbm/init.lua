
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()   

self.smoking = false
self.exploded = false
self.armed = true

self.flightvector = self.Entity:GetUp() * 50
self.Entity:SetModel( "models/\props_phx/rocket1.mdl" )
self.Entity:SetGravity( 0.5 ) 	
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3           
self.Entity:SetColor(75,75,75,255)

 
end   

 function ENT:Think()
	
 	if (self.smoking == false) then
		self.smoking = true
	
		local RockTrail = ents.Create("env_rockettrail")
 			  RockTrail:SetAngles( self.Entity:GetUp() * 180  )
			  RockTrail:SetPos( self.Entity:GetPos() )
			  RockTrail:SetParent(self.Entity)
		      RockTrail:Spawn()
			  RockTrail:Activate()
	end 
 

 
	local trace = {}
		trace.start = self.Entity:GetPos()
		trace.endpos = self.Entity:GetPos() + self.flightvector * 2.5 
		trace.filter = self.Entity 
	local tr = util.TraceLine( trace )
	
	if (tr.Hit) then
		
			util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 1000, 500)
			
			local effectdata = EffectData()
			effectdata:SetOrigin(self.Entity:GetPos())
			effectdata:SetStart(self.Entity:GetPos())
			util.Effect( "athesplode", effectdata )
			
		gcombat.hcgexplode( self.Entity:GetPos(), 1500, 700, 10)
	end
	
	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = self.flightvector + Vector(0,0,-0.1)
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(90,0,0))
	self.Entity:NextThink( CurTime() )
	return true
end
 
 
