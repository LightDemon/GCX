
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('entities/base_wire_entity/init.lua');
include('shared.lua')

function ENT:SpawnFunction( ply, tr)
	
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 60
	
	local ent = ents.Create( "Gc4" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	return ent

end

function ENT:Initialize()
	self.Entity:SetModel( "models/weapons/w_c4_planted.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
	self.Entity:SetSolid( SOLID_VPHYSICS )        -- Toolbox   
	self.infire = false
	self.Entity:SetOwner(self.owner)
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then 
		phys:Wake()
	end

      self.Inputs = Wire_CreateInputs ( self.Entity, { "Detonate" } )
end


function ENT:Think()

        if self.infire then
		local effectdata = EffectData()
			effectdata:SetOrigin( self.Entity:GetPos() )
			effectdata:SetStart(self.Entity:GetUp())
		util.Effect( "dirtyxplo", effectdata )
		self.Entity:EmitSound( "PaperJack/big_explosion.wav", 500, 100)
		cbt_hcgexplode( self.Entity:GetPos(), 600, 1000, 7)
		util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 500, 300)
		self.Entity:Remove()
	end
end
		

function ENT:TriggerInput(iname, value)

	if (iname == "Detonate") then
		if (value == 1 && self.infire == false) then self.infire = true end
		if (value == 0 && self.infire == true) then self.infire = false end
	end

end






