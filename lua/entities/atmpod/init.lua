
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('entities/base_wire_entity/init.lua'); 
include('shared.lua')

function ENT:Initialize()   

	self.ammomodel = "models/props_c17/canister01a.mdl"
	self.ammos = 1
	self.armed = false
	self.loading = false
	self.reloadtime = 0
	self.infire = false
	self.Entity:SetModel( "models/props_c17/canister01a.mdl" ) 	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
	self.Entity:SetSolid( SOLID_VPHYSICS )        -- Toolbox     
	self.Entity:SetColor(75,75,75,255)
	
	self.val1 = 0
	self.val2 = 0
	
	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
		phys:Wake() 
	end 
 
	self.Inputs = Wire_CreateInputs( self.Entity, { "Fire"} )
	self.Outputs = Wire_CreateOutputs( self.Entity, { "Ready"})
end   

function ENT:SpawnFunction( ply, tr)
	
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 60
	
	
	local ent = ents.Create( "atmpod" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	
	
	return ent

end

function ENT:fireatm()

	if (self.ammos > 0) then
		self.ammos = self.ammos - 1
	
		local ent = ents.Create( "atmissile" )
		ent:SetPos( self.Entity:GetPos() + (self.Entity:GetUp() * 80))
		ent:SetAngles(self.Entity:GetAngles())
		ent:Spawn()
		ent:Activate()
	else 
		self.armed = false
		self.ammos = 1
		self.reloadtime = CurTime() + 25
	end

end

function ENT:Think()
if FIELDS == nil and COMBATDAMAGEENGINE == nil then return end
	
	
	if (self.reloadtime > CurTime()) then
		self.armed = false
		Wire_TriggerOutput(self.Entity, "Ready", 0)
	end
	
	if (self.armed == true) then
		
			self:fireatm()
			self.Entity:Remove()
			
		
	elseif (self.reloadtime < CurTime()) then
		self.Entity:SetColor(75,75,75,255)
		Wire_TriggerOutput(self.Entity, "Ready", 1)
		if (self.infire == true) then self.armed = true end
	end

	self.Entity:NextThink( CurTime() + 1)
	return true
end

function ENT:TriggerInput(iname, value)

	if (iname == "Fire") then
		if (value == 1 && self.infire == false) then self.infire = true end
		if (value == 0 && self.infire == true) then self.infire = false end
		self.Entity:NextThink( CurTime() )
		return true
	end

end
 
 
