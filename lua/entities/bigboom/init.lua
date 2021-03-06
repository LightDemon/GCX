AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.PrecacheSound( "ambient/explosions/explode_1.wav" )
util.PrecacheSound( "ambient/explosions/explode_2.wav" )
util.PrecacheSound( "ambient/explosions/explode_3.wav" )
util.PrecacheSound( "ambient/explosions/explode_4.wav" )

function ENT:Initialize() 

self.expl = {}
self.expl[0] = "ambient/explosions/explode_1.wav"
self.expl[1] = "ambient/explosions/explode_2.wav"
self.expl[2] = "ambient/explosions/explode_3.wav"
self.expl[3] = "ambient/explosions/explode_4.wav"

self.exploded = false
self.armed = true
self.smoking = false
self.flightvector = self.Entity:GetUp() * 30
self.Entity:SetModel( "models/aamissile.mdl" ) 	
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3            
 
 self.nexttarGet = CurTime()
 self.target = self.Entity    

 self:Think()
end   


 function ENT:Think()

 if (self.smoking == false) then
		self.smoking = true
	
		FireTrail = ents.Create("env_spritetrail")
		FireTrail:SetKeyValue("lifetime","1")
		FireTrail:SetKeyValue("startwidth","5")
		FireTrail:SetKeyValue("endwidth","10")
		FireTrail:SetKeyValue("spritename","trails/smoke.vmt")
		FireTrail:SetKeyValue("rendermode","5")
		FireTrail:SetKeyValue("rendercolor","255 255 8")
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
		if ( self.exploded == false ) then
			
			if (tr.Entity:IsPlayer() || tr.Entity:IsNPC()) then
				local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetStart(tr.HitPos)
				gcombat.hcgexplode( self.Entity:GetPos(), 500, 250, 5)
				util.Effect( "Explosion", effectdata )
				self.Entity:EmitSound( self.expl[ math.random(0,3) ], 300, 100 )
				self.exploded = true
				self.Entity:Remove()
				return true
			end

   
			local attack = gcombat.hcgexplode( self.Entity:GetPos(), 500, 250, 5)
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetStart(tr.HitPos)
				gcombat.hcgexplode( self.Entity:GetPos(), 500, 250, 5)
				util.Effect( "Explosion", effectdata )

			if (attack == 0) then
				brokedshell = ents.Create("prop_physics")
				brokedshell:SetPos(self.Entity:GetPos())
				brokedshell:SetAngles(self.Entity:GetAngles())
				brokedshell:SetKeyValue( "model", "models/\props_phx/ww2bomb.mdl" )
				brokedshell:PhysicsInit( SOLID_VPHYSICS )
				brokedshell:SetMoveType( MOVETYPE_VPHYSICS )
				brokedshell:SetSolid( SOLID_VPHYSICS )
				brokedshell:Activate()
				brokedshell:Spawn()
				brokedshell:Fire("Kill", "", 20)
				local phys = brokedshell:GetPhysicsObject()  	
				if (phys:IsValid()) then  
					phys:SetVelocity(self.flightvector *1000)
				end
			end
 
			self.exploded = true
			self.Entity:Remove()
		end
	end
	
	local seekStart = self:GetPos() + self:GetUp() 
	local seekVec = self:GetUp()
	local seekDist = 2000
	local seaKAng = 22.5
	local EIS = FindinCone2( seekStart, seekVec, seekDist, seaKAng )
	local distance = seekDist
		
	if !self.target:IsValid() then self.target = self.Entity end
	
	if self.nexttarGet < CurTime() then 
		for _,t in pairs(EIS) do
			if (t:GetClass() == "prop_physics" || t:IsPlayer() || t:IsNPC()) then
				if (t:GetPos():Distance(self:GetPos()) < distance && self:GetUp():DotProduct((t:GetPos() - self:GetPos()):GetNormalized()) > 0.5) then
					self.target = t
					distance = t:GetPos():Distance(self:GetPos())
				end
			end
		end
		
		self.nexttarGet = CurTime() + 1
	end
	
	if self.target != self.Entity then
		self.flightvector = self.flightvector + (self.target:GetPos() - self:GetPos()):GetNormalized() * 6
	end
	
	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = (self.flightvector + Vector(math.Rand(-5,5), math.Rand(-5,5), math.Rand(-5,5)))
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(0,0,0))
	self.Entity:NextThink( CurTime() )
	return true
end
 
 
