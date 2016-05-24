AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()   
self.Entity:SetModel( "models/props_c17/consolebox01a.mdl" ) 	
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3            

 local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
		phys:Wake() 
	end 
self.Inputs = Wire_CreateInputs(self, { "Active" } )
self.Done = false
self.active = false
self.EndTime = nil
end   

function ENT:SpawnFunction( ply, tr)
	
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 60
	
	
	local ent = ents.Create( "EMPMine" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	
	
	return ent

end

 function ENT:Think()
 
 
 if self.active then
	
	if not self.Done then
		self.List = ents.FindInSphere( self.Entity:GetPos(), 500 )
		self.EndTime = CurTime() + 10
		self.Done = true
	end
	
	if CurTime() < self.EndTime then
		gcx_EmpRun(self.List)
		for _, v in pairs(self.List) do
			local effectdata = EffectData() 
			effectdata:SetStart( v:GetPos() )
			effectdata:SetOrigin( v:GetPos() )
			effectdata:SetScale( 10 )
			effectdata:SetMagnitude( 10 )
			effectdata:SetEntity(v)
			util.Effect( "TeslaHitBoxes", effectdata ) --YAY lighning
		end
	else
		gcx_EmpEnd(self.List)
		self:Fire("Kill", "", 4)
	end

	
	
	self.Entity:NextThink( CurTime() + .6 )	
	end
end

function ENT:TriggerInput(iname, value)
	if ( value > 0 && iname == "Active" ) then
		self.active = true
	end
end

