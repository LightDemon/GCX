
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()   

math.randomseed(CurTime())
self.exploded = false
self.armed = true
self.ticking = true
self.smoking = false
self.flightvector = self.Entity:GetUp() * 175
self.Entity:SetModel( "models/combatmodels/tankshell.mdl" ) 	
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3            

 
end   

 function ENT:Think()
	if (self.smoking == false) then
		self.smoking = true
	
		FireTrail = ents.Create("env_spritetrail")
		FireTrail:SetKeyValue("lifetime","2")
		FireTrail:SetKeyValue("startwidth","10")
		FireTrail:SetKeyValue("endwidth","0.1")
		FireTrail:SetKeyValue("spritename","trails/smoke.vmt")
		FireTrail:SetKeyValue("rendermode","5")
		FireTrail:SetKeyValue("rendercolor","255 255 255")
		FireTrail:SetPos(self.Entity:GetPos())
		FireTrail:SetParent(self.Entity)
		FireTrail:Spawn()
		FireTrail:Activate()
	end 

	local trace = {}
		trace.start = self.Entity:GetPos()
		trace.endpos = self.Entity:GetPos() + self.flightvector * 2.5
		trace.filter = self.Entity 
	local tr = util.TraceLine( trace )
	
	if (tr.Hit) then
		if ( self.exploded == false ) then
			if ( self.exploded == false && self.ticking == true ) then
				util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 100, 150)
				if (tr.Entity:IsPlayer() || tr.Entity:IsNPC() || tr.HitSky) then
					local effectdata = EffectData()
					effectdata:SetOrigin(self.Entity:GetPos())
					effectdata:SetStart(self.Entity:GetPos())
					util.Effect( "Explosion", effectdata )
					self.exploded = true
					self.Entity:Remove()
					return true
				end
 
				local attack = cbt_hcgexplode( self.Entity:GetPos(),500, 800, 8)
				local effectdata = EffectData()
					effectdata:SetOrigin(self.Entity:GetPos())
					effectdata:SetStart(self.Entity:GetPos())
					util.Effect( "Explosion", effectdata )
				self.exploded = true
				self.Entity:Remove()
			end
		end
	end

	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = self.flightvector + Vector(0,0,-1)
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(90,0,0))
	self.Entity:NextThink( CurTime() )
	return true
end
 
 
