AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/jaanus/wiretool/wiretool_range.mdl" ) 
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Outputs = Wire_CreateOutputs( self.Entity, { "Health", "Armor"} )

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( "meter" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Think()
	local trace = {}
	local vStart = self.Entity:GetPos()
	local vForward = self.Entity:GetUp()
	trace.start = vStart
	trace.endpos = vStart + (vForward * 5000)
	trace.filter = self.Entity
	local tr = util.TraceLine( trace ) 

		if (tr.Entity and tr.Entity:IsValid() and not tr.Entity:IsWorld() and not tr.Entity:IsPlayer() and not tr.Entity:IsNPC() and not tr.HitSky) then
			if (tr.Entity.cbt != nil) then
				Wire_TriggerOutput(self.Entity, "Armor", tr.Entity.cbt.armor)
			else
				Wire_TriggerOutput(self.Entity, "Armor", 0)
			end
			if (tr.Entity.cbt != nil) then
				Wire_TriggerOutput(self.Entity, "Health", tr.Entity.cbt.health)
			else
			local h = tr.Entity:GetPhysicsObject():GetMass() * 4
			local maxhealth = math.Clamp( h, 1, 4000 )
				Wire_TriggerOutput(self.Entity, "Health", maxhealth)
			end
		else
			Wire_TriggerOutput(self.Entity, "Armor", 0)
			Wire_TriggerOutput(self.Entity, "Health", 0)
			
		end
end 