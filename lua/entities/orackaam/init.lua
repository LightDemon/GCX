
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/aamissile.mdl" )
	self.Entity:SetName("srm")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

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
	
	local ent = ents.Create( "orackaam" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:SetAngles( Ang )
	self.Entity:SetAngles(Ang)
end

function ENT:PhysicsUpdate( physobj )
	
	if self.Exploded then
		self.Entity:Remove()
	end
	
	if(self.Fired == true) then
		local PreVel = self.PhysObj:GetVelocity()
		self.PhysObj:AddVelocity( PreVel + (self.Entity:GetUp() * 400000) )
	end
end

function ENT:flak()
	
	if(!self.Exploded) then
		for i=1,5 do
			local sopme	= (self.Entity:GetPos() + Vector(math.random(-600, 600), math.random(-600, 600), math.random(-600, 600)))
			local effectdatab = EffectData()
						effectdatab:SetOrigin(sopme)		
						effectdatab:SetStart(self.Entity:GetPos())
						util.Effect( "aamsplode", effectdatab )
						gcombat.hcgexplode( sopme, 300, 500, 7 )
			
		end
	end
end

function ENT:Explode()
	if ( self.Exploded ) then return end
	
	
	
	local attack = gcombat.hcgexplode( self.Entity:GetPos(), 300, 500, 7)
				if (attack == 0) then
					brokedshell = ents.Create("prop_physics")
					brokedshell:SetPos(self.Entity:GetPos())
					brokedshell:SetAngles(self.Entity:GetAngles())
					brokedshell:SetKeyValue( "model", "models/aamissile.mdl" )
					brokedshell:PhysicsInit( SOLID_VPHYSICS )
					brokedshell:SetMoveType( MOVETYPE_VPHYSICS )
					brokedshell:SetSolid( SOLID_VPHYSICS )
					brokedshell:Activate()
					brokedshell:Spawn()
					brokedshell:Fire("Kill", "", 20)
				elseif (attack != 0) then
					self:flak()
					util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), blastRadius, 200)
					local effectdata = EffectData()
					effectdata:SetOrigin(self.Entity:GetPos())		
					effectdata:SetStart(self.Entity:GetPos())
					util.Effect( "aamsplode", effectdata )
				end
	
 	--util.BlastDamage( self.Entity, self.Entity, self.Entity:GetPos(), blastRadius, 50 )

	local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() )
	util.Effect( "Explosion", effectdata, true, true )
self.Exploded = true
end

function AngToVec( ang )
	return Vector(ang.pitch%360,ang.yaw%360,ang.roll%360)
end

local seekable = {
gmod_thruster = true,
prop_vehicle_airboat = true,
prop_vehicle_jeep = true,
gmod_hoverball = true,
malawar_repulsor = true,
prop_physics = true
}

function ENT:CheckSeeking()
	local seekStart = self.Entity:GetPos() + (self.Entity:GetUp())
	local seekVec = self.Entity:GetUp()
	local seekDist = 8000
	local seaKAng = 30
	local targets = FindinCone2( seekStart, seekVec, seekDist, seaKAng )
	for i, e in pairs(targets) do
		cls = e:GetClass()
		if seekable[cls] then
		--if cls == 'gmod_thruster' or cls == 'prop_vehicle_airboat' or cls == 'prop_vehicle_jeep' then
			local Ang = e:GetPos() - self.Entity:GetPos()
			local dist = Ang:Length()
			if dist < (50) then
				self:Explode()
				return
			end
			
			local phys = self.Entity:GetPhysicsObject()
			local oldVel = phys:GetVelocity()
			Ang = Ang:Angle()
			Ang.pitch = Ang.pitch + 90
			self.Entity:GetPhysicsObject():SetAngle(Ang)
			phys:SetVelocity((oldVel) * 1)
			return
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
				phys:EnableDrag(true)
				phys:EnableCollisions(true)
				phys:EnableMotion(true)
			end
			
		self.PhysObj:SetVelocity(self.Entity:GetUp()*0)
			RockTrail = ents.Create("env_rockettrail")
				RockTrail:SetAngles( self.Entity:GetAngles() + Angle(90,0,0)  )
				RockTrail:SetPos( self.Entity:GetPos() )
				RockTrail:SetParent(self.Entity)
				RockTrail:Spawn()
				RockTrail:Activate()       
			self.PreLaunch = true
			
		end
		self:CheckSeeking()
	end
	if (CurTime() > self.LTime) then
		self.Locked = true
		--self:CheckSeeking()
	end
	if self.Exploded then
		self.Entity:Remove()
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
