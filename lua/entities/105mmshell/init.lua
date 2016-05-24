AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()   

self.exploded = false
self.armed = true
self.smoking = false
self.flightvector = self.Entity:GetUp() * 700 --1500
self.Entity:SetModel( "models/combatmodels/tankshell.mdl" ) 	
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3            
 
end   


 function ENT:Think()
	if (self.smoking == false) then
		self.smoking = true
	
		FireTrail = ents.Create("env_spritetrail")
		FireTrail:SetKeyValue("lifetime","5")
		FireTrail:SetKeyValue("startwidth","15")
		FireTrail:SetKeyValue("endwidth","0.1")
		FireTrail:SetKeyValue("spritename","trails/plasma.vmt")
		FireTrail:SetKeyValue("rendermode","5")
		FireTrail:SetKeyValue("rendercolor","255 50 0")
		FireTrail:SetPos(self.Entity:GetPos())
		FireTrail:SetParent(self.Entity)
		FireTrail:Spawn()
		FireTrail:Activate()
	end 


	local trace = {}
		trace.start = self.Entity:GetPos()
		trace.endpos = self.Entity:GetPos() + self.flightvector * 1.5
		trace.filter = self.Entity 
	local tr = util.TraceLine( trace )
	
	if (tr.Hit) then
		if (tr.Entity:IsWorld() || tr.Entity:IsPlayer() || tr.Entity:IsNPC() || tr.HitSky) then
		self.Entity:Remove()
		else
				
			local attack = cbt_dealhcghit( tr.Entity, 5000, 9, tr.HitPos, tr.HitPos)
				
				if (attack != 0) then
					local pewpew = ents.Create("105mmshell")
					pewpew:SetPos(tr.HitPos + (self.Entity:GetUp() * 8))
					pewpew:SetAngles(self.Entity:GetAngles())
					pewpew:Activate()
					pewpew:Spawn()
				self.Entity:Remove()
				end
		end
		self.Entity:Remove()
	end
	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = self.flightvector + Vector(0,0,0)
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(90,0,0))
	self.Entity:NextThink( CurTime() )
	return true
end
 
 
