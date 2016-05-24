
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/aamissile.mdl" )
	self.Entity:SetName("srm")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetColor(75,75,75,255)

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
	end

    	self.Entity:SetKeyValue("rendercolor", "255 255 255")
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.STime = CurTime()
	self.LTime = self.STime + 0.5
	self.Timer = self.STime + self.LTime + 5

end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( "orackrkt" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:PhysicsUpdate()

	if(self.Exploded) then
		self.Entity:Remove()
		return
	end

	if (self.Fired == true) then
			
		self.PhysObj:SetVelocity(self.Entity:GetUp()*3100)

		if(self.Timer <= self.STime) then
			local phys = self.Entity:GetPhysicsObject()
			phys:EnableGravity(true)
			phys:EnableDrag(true)
			self.Locked = false
		end

		self.LastPosition = self.Entity:GetPos()
	end
	end

function ENT:flak()
	
	if(!self.Exploded) then
		for i=1,5 do
			local sopme	= (self.Entity:GetPos() + Vector(math.random(-600, 600), math.random(-600, 600), math.random(-100, 100)))
			local effectdatab = EffectData()
						effectdatab:SetOrigin(sopme)		
						effectdatab:SetStart(self.Entity:GetPos())
						util.Effect( "aamsplode", effectdatab )
						gcombat.hcgexplode( sopme, 300, 500, 7 )
			
		end
	end
end

function ENT:Think()
if(self.Fired == false) then
	local phys = self.Entity:GetPhysicsObject()
			if (phys:IsValid()) then
				phys:Wake()
				phys:EnableGravity(false)
				phys:EnableDrag(false)
				phys:EnableCollisions(true)
				phys:EnableMotion(true)
			end
	end
	if (self.Fired == true) then
		if (self.PreLaunch == false) then
			self.PreLaunch = true
			local phys = self.Entity:GetPhysicsObject()
			if (phys:IsValid()) then
				phys:Wake()
				phys:EnableGravity(false)
				phys:EnableDrag(false)
				phys:EnableCollisions(true)
				phys:EnableMotion(true)
			end
	self.PhysObj:SetVelocity(self.Entity:GetUp()*3100)
			RockTrail = ents.Create("env_rockettrail")
				RockTrail:SetAngles( self.Entity:GetAngles() + Angle(90,0,0)  )
				RockTrail:SetPos( self.Entity:GetPos() )
				RockTrail:SetParent(self.Entity)
				RockTrail:Spawn()
				RockTrail:Activate()       
			self.PreLaunch = true
		end
	end
	if (CurTime() > self.LTime) then
		self.Locked = true
	end

end

function ENT:PhysicsCollide( data, physobj )

	if(!self.Exploded && self.Fired == true) then
		local expl=ents.Create("env_explosion")
		expl:SetPos(self.Entity:GetPos())
		expl:SetName("Missile")
		expl:SetParent(self.Entity)
		expl:SetOwner(self.Entity:GetOwner())
		expl:SetKeyValue("iMagnitude","300");
		expl:SetKeyValue("iRadiusOverride", 250)
		expl:Spawn()
		expl:Activate()
		expl:Fire("explode", "", 0)
		expl:Fire("kill","",0)
		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())		
		effectdata:SetStart(self.Entity:GetPos())
		util.Effect( "aamsplode", effectdata )
		gcombat.hcgexplode( self.Entity:GetPos(), 300, 500, 7 )
		self:flak()
		self.Exploded = true
	end
end

function ENT:OnTakeDamage( dmginfo )

	if(!self.Exploded) then
		local expl=ents.Create("env_explosion")
		expl:SetPos(self.Entity:GetPos())
		expl:SetName("Missile")
		expl:SetParent(self.Entity)
		expl:SetOwner(self.Entity:GetOwner())
		expl:SetKeyValue("iMagnitude","300");
		expl:SetKeyValue("iRadiusOverride", 250)
		expl:Spawn()
		expl:Activate()
		expl:Fire("explode", "", 0)
		expl:Fire("kill","",0)
		self.Exploded = true
	end	
end

function ENT:Use( activator, caller )

end
