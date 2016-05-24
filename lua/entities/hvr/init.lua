
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()   

self.smoking = false
self.exploded = false
self.armed = true

self.flightvector = self.Entity:GetUp() * 400
self.Entity:SetModel( "models/props_junk/garbage_plasticbottle003a.mdl" )
self.Entity:SetGravity( 0.5 ) 	
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3           
self.Entity:SetColor(255,255,0,255)
 self.dietime = CurTime() + 10
end   

 function ENT:Think()
	
 	if (self.smoking == false) then
		self.smoking = true
	
		local RockTrail = ents.Create("env_rockettrail")
 			  RockTrail:SetAngles( self.Entity:GetUp() * 1  )
			  RockTrail:SetPos( self.Entity:GetPos() )
			  RockTrail:SetParent(self.Entity)
		      RockTrail:Spawn()
			  RockTrail:Activate()
			  RockTrail:Fire("Kill", "", "4")
	end 
 
	local trace = {}
		trace.start = self.Entity:GetPos()
		trace.endpos = self.Entity:GetPos() + self.flightvector * 1.05
		trace.filter = self.Entity 
	local tr = util.TraceLine( trace )
	
	if (tr.Hit) then
		
		if (tr.Entity:IsPlayer() || tr.Entity:IsNPC() || tr.HitSky ) then
			util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 150, 200)
			local effectdata = EffectData()
			effectdata:SetOrigin(self.Entity:GetPos())		
			effectdata:SetStart(self.Entity:GetPos())
			util.Effect( "athesplode", effectdata )
			self.exploded = true
			self.Entity:Remove()
			return true
		end
		
		local attack = gcombat.hcgexplode( self.Entity:GetPos(), 250, 150, 7)
				
				if (attack != 0) then
					util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 350, 200)
					local effectdata = EffectData()
					effectdata:SetOrigin(self.Entity:GetPos())		
					effectdata:SetStart(self.Entity:GetPos())
					util.Effect( "atapsplode", effectdata )
				end
			self.exploded = true
			self.Entity:Remove()
		
	end
	if CurTime() > self.dietime then
		self.Entity:Remove()
	end
	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = self.flightvector + Vector(0,0,0)
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(90,0,0))
	self.Entity:NextThink( CurTime() )
	return true
end
 
 
