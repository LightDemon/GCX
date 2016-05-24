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
	
	
   self.Entity:SetModel( "models/props_junk/popcan01a.mdl" )
   self.Entity:PhysicsInit( SOLID_VPHYSICS )
   self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
   self.Entity:SetSolid( SOLID_VPHYSICS )
   self.Entity:SetName("105mm")
  	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
		phys:Wake() 
		phys:SetMass( 2500 ) 
		Msg(phys:GetMass( ))

	end 
 
   
 
	self.Inputs = Wire_CreateInputs( self.Entity, { "Fire"} )
	self.Outputs = Wire_CreateOutputs( self.Entity, { "Can Fire"})
end   



function ENT:SpawnFunction( ply, tr)
	
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 60
	
	
	local ent = ents.Create( "Test" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	
	
	return ent

end

 function ENT:firerac5()
	local ply = self:GetOwner()
	if  self.Entity:GetPhysicsObject():GetMass() < 2500   then
		ply:PrintMessage( HUD_PRINTCENTER, "Your weapon is too light! Weapon must be equal or greater than 2500 weight to fire!" )  
	
	else
		local ent = ents.Create( "105mmshell" )
		ent:SetPos( self.Entity:GetPos() +  self.Entity:GetUp() * 60)
		ent:SetAngles( self.Entity:GetAngles() )
		ent:Spawn()
		ent:Activate()

		local phys = self.Entity:GetPhysicsObject()  
		if (phys:IsValid()) then  
			phys:ApplyForceCenter( self:GetForward() * -500000)
		end

		self.Entity:EmitSound( "arty/railgun.wav", 500, 100 )
		self.ammos = self.ammos-1

		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos() +  self.Entity:GetUp() * 5)
		effectdata:SetNormal( self:GetUp() )
		util.Effect( "railgun", effectdata )
	end
end



function ENT:Think()
if FIELDS == nil and COMBATDAMAGEENGINE == nil then return end
	if self.ammos <= 0 then
	self.reloadtime = CurTime()+6
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

	self.Entity:NextThink( CurTime() + .03)
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