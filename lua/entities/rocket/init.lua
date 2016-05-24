
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')
local FlightSound = Sound( "PhysicsCannister.ThrusterLoop" )
function ENT:Initialize()   

self.smoking = false
self.exploded = false
self.armed = true

self.flightvector = self.Entity:GetUp() * 125
self.Entity:SetModel( "models/weapons/w_missile_launch.mdl" )	
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3           
self.Entity:SetColor(255,255,0,255)
self.dietime = CurTime() + 10
util.SpriteTrail( self.Entity,  //Entity 
 											0,  //iAttachmentID 
 											Color(255,255,255,255),  //Color 
 											false, // bAdditive 
 											6, //fStartWidth 
 											0, //fEndWidth 
 											.5, //fLifetime 
											8, //fTextureRes 
 											"trails/smoke.vmt" )
self:Think()
 
end   

 function ENT:Think()
 	
		  local fx = EffectData()
			fx:SetOrigin(self.Entity:GetPos())
			fx:SetAngle( self.Entity:GetUp() + Angle(180,0,0))
			fx:SetScale(1)
			util.Effect("MuzzleEffect", fx)
	
 
	local trace = {}
		trace.start = self.Entity:GetPos()
		trace.endpos = self.Entity:GetPos() + self.flightvector * 1.05
		trace.filter = self.Entity 
	local tr = util.TraceLine( trace )
	
	if (tr.Hit) then
		util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 300, 200)
			local effectdata = EffectData()
			effectdata:SetOrigin(self.Entity:GetPos())		
			effectdata:SetStart(self.Entity:GetPos())
			util.Effect( "Explosion", effectdata )
		if (tr.Entity:IsPlayer() || tr.Entity:IsNPC() || tr.HitSky ) then
			self.exploded = true
			self.Entity:Remove()
			return true
		end
			cbt_hcgexplode( tr.HitPos, 100, 150, 6)
		
			if( !tr.Entity:IsWorld() ) then
		local attack = gcombat.hcghit( tr.Entity, 200, 7, tr.HitPos , tr.HitPos)
			end
			self.exploded = true
			self.Entity:Remove()
		
	end
	
	if CurTime() > self.dietime then
		self.Entity:Remove()
	end
	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = self.flightvector + Vector(math.Rand(-0.4,0.4), math.Rand(-0.4,0.4),math.Rand(-0.4,0.4)) + Vector(0,0,-0.1)
	self.Entity:SetAngles(self.flightvector:Angle())
	self.Entity:NextThink( CurTime() )
	return true
end
 
 function ENT:OnRemove()
	self.Entity:StopSound( FlightSound )
end
