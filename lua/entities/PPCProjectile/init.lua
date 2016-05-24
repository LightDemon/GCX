
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()   

math.randomseed(CurTime())
self.exploded = false
self.armed = true
self.ticking = true
self.smoking = false
self.flightvector = self.Entity:GetUp() * 100
self.Entity:SetModel( "models/combatmodels/tankshell.mdl" ) 	
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS ) 		-- vagina ololol
self.Entity:SetColor(0,0,0,0)       		            

 
end   

 function ENT:Think()
	if (self.smoking == false) then
		self.smoking = true
	
		Trail = ents.Create("env_spritetrail")
		Trail:SetKeyValue("lifetime","0.2")
		Trail:SetKeyValue("startwidth","15")
		Trail:SetKeyValue("endwidth","0")
		Trail:SetKeyValue("spritename","trails/physbeam.vmt")
		Trail:SetKeyValue("rendermode","5")
		Trail:SetKeyValue("rendercolor","0 200 255")
		Trail:SetPos(self.Entity:GetPos())
		Trail:SetParent(self.Entity)
		Trail:Spawn()
		Trail:Activate()
		
	end 


	local trace = {}
		trace.start = self.Entity:GetPos()
		trace.endpos = self.Entity:GetPos() + self.flightvector *3
		trace.filter = self.Entity 
	local tr = util.TraceLine( trace )
	
	if (tr.Hit) then
		if ( self.exploded == false ) then
			if ( self.exploded == false && self.ticking == true ) then
				util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 100, 50)
				if (tr.Entity:IsWorld() || tr.Entity:IsPlayer() || tr.Entity:IsNPC() || tr.HitSky) then
					local effectdata = EffectData()
					effectdata:SetOrigin(self.Entity:GetPos())
					effectdata:SetStart(self.Entity:GetPos())
					util.Effect( "Explosion", effectdata )
					self.exploded = true
					self.Entity:Remove()
					return true
				end
 
    
				local attack = gcombat.nrghit( tr.Entity, 350, 9, tr.HitPos , tr.HitPos)
				if (attack == 0) then
					attack = 1
				end

 

				self.exploded = true
				self.Entity:Remove()
			end
		end
	end

	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector * 3)
	self.flightvector = self.flightvector + Vector(0,0,0)
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(90,0,0))
	self.Entity:NextThink( CurTime() )
	return true
end
 
 
