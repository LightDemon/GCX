AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
local FlightSound = Sound( "PhysicsCannister.ThrusterLoop" )
local blastRadius = 400
function ENT:Initialize()
	self.Entity:SetModel('models/props_junk/garbage_plasticbottle003a.mdl')

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_NONE )
	self.Entity:SetColor(255,156,0,255)	

	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:EnableGravity( false )
		phys:Wake()
	end
	
	self.Entity:EmitSound( FlightSound )
	self.Entity:SetGravity( 0 )
	self.SpawnTime = CurTime()
	self.DeathTime = CurTime() + 5
	
	local ent = self.Entity
 local trail = ents.Create("env_fire_trail")
trail:SetPos(ent:GetPos())
trail:Spawn()
trail:SetParent(ent)
	
	
end

function ENT:PhysicsCollide( data, physobj )
	self:Explode()
end

function ENT:SetAngles( Ang )
	self.Entity:SetAngles(Ang)
end

function ENT:PhysicsUpdate( physobj )
	local Ang = self.Entity:GetUp()
	local force = Ang * 80

	physobj:ApplyForceCenter(force)
end

function ENT:Explode()
	if ( self.Exploded ) then return end
	
	
	
	local attack = gcombat.hcgexplode( self.Entity:GetPos(), 300, 150, 5)
				if (attack == 0) then
					brokedshell = ents.Create("prop_physics")
					brokedshell:SetPos(self.Entity:GetPos())
					brokedshell:SetAngles(self.Entity:GetAngles())
					brokedshell:SetKeyValue( "model", "models/props_junk/garbage_plasticbottle003a.mdl" )
					brokedshell:PhysicsInit( SOLID_VPHYSICS )
					brokedshell:SetMoveType( MOVETYPE_VPHYSICS )
					brokedshell:SetSolid( SOLID_VPHYSICS )
					brokedshell:Activate()
					brokedshell:Spawn()
					brokedshell:Fire("Kill", "", 20)
				elseif (attack != 0) then
					util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), blastRadius, 200)
					local effectdata = EffectData()
					effectdata:SetOrigin(self.Entity:GetPos())		
					effectdata:SetStart(self.Entity:GetPos())
					util.Effect( "athesplode", effectdata )
				end
	
 	--util.BlastDamage( self.Entity, self.Entity, self.Entity:GetPos(), blastRadius, 50 )

	local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() )
	util.Effect( "Explosion", effectdata, true, true )
self.Exploded = true
end

local seekRadius = 1500

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
	local seekDist = 2000
	local seaKAng = 15
	local targets = FindinCone2( seekStart, seekVec, seekDist, seaKAng )
	for i, e in pairs(targets) do
		cls = e:GetClass()
		if seekable[cls] then
		--if cls == 'gmod_thruster' or cls == 'prop_vehicle_airboat' or cls == 'prop_vehicle_jeep' then
			local Ang = e:GetPos() - self.Entity:GetPos()
			local dist = Ang:Length()
			if dist < (20) then
				self:Explode()
				return
			end
			
			local phys = self.Entity:GetPhysicsObject()
			local oldVel = phys:GetVelocity()
			Ang = Ang:Angle()
			Ang.pitch = Ang.pitch + 90
			self.Entity:GetPhysicsObject():SetAngle(Ang)
			phys:SetVelocity((oldVel) * 0.5)
			return
		end
	end
end

function ENT:Think()
	if self.Solid == nil and CurTime() > (self.SpawnTime + 0.4) then
		self.Entity:SetSolid( SOLID_VPHYSICS )
		self.Solid = true
	end
	
	if CurTime() > self.SpawnTime + 1 then
		self:CheckSeeking()
	end
	
	
	if CurTime() > self.DeathTime then
		self.Entity:Remove()
	end
	if self.Exploded then
		self.Entity:Remove()
	end
end

function ENT:OnRemove()
	self.Entity:StopSound( FlightSound )
end
