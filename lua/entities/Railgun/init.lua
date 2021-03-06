
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('entities/base_wire_entity/init.lua'); 
include('shared.lua')

util.PrecacheSound("arty/artyfire.wav")

function ENT:Initialize()   

	self.ammomodel = "models/props_c17/canister01a.mdl"
	self.ammos = 1
	self.clipsize = 1
	self.armed = false
	self.loading = false
	self.reloadtime = 0
	self.infire = false
	self.Entity:SetModel( "models/roltzy/railgun.mdl" ) 	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
	self.Entity:SetSolid( SOLID_VPHYSICS )        -- Toolbox     
	
          
	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
		phys:Wake() 
	end 
 
	self.Inputs = Wire_CreateInputs( self.Entity, { "Fire"} )
	self.Outputs = Wire_CreateOutputs( self.Entity, { "Can Fire"})
end   

function ENT:SpawnFunction( ply, tr)
	
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 60
	
	
	local ent = ents.Create( "Railgun" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	
	
	return ent

end

function ENT:firerac5()
        local offset = self.Entity:GetRight()
		local ent = ents.Create( "Rail" )
		ent:SetPos( self.Entity:GetPos() + offset * -100)
		ent:SetAngles( self.Entity:GetAngles() + Angle(0,0,-90))
		ent:Spawn()
		ent:Activate()
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() + offset * -100)
		effectdata:SetStart( self.Entity:GetPos() + offset * -100)
		util.Effect( "atapsplode", effectdata )
		
		self.Entity:EmitSound( "LightDemon/Railgun.wav", 500, 100 )
		self.ammos = self.ammos-1
	

end

function ENT:Think()
if FIELDS == nil and COMBATDAMAGEENGINE == nil then return end

	if self.ammos <= 0 then
	self.reloadtime = CurTime()+15
	self.ammos = self.clipsize
	end
	
	if (self.reloadtime < CurTime()) then
		Wire_TriggerOutput(self.Entity, "Can Fire", 1)
	else
		Wire_TriggerOutput(self.Entity, "Can Fire", 0)
	end
	
	if (self.inFire == true) then
		if (self.reloadtime < CurTime()) then
		
			self:firerac5()
			
		end
	end

	self.Entity:NextThink( CurTime() + .3)
	return true
end

function ENT:TriggerInput(k, v)
if(k=="Fire") then
		if((v or 0) >= 1) then
			self.inFire = true
		else
			self.inFire = false
		end
	end
end
 
 
