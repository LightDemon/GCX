
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('entities/base_wire_entity/init.lua'); 
include('shared.lua')

function ENT:Initialize()  

	util.PrecacheSound( "Lasers/SPulse/PulseLaser.wav" ) 
	
	self.ammos = 6
	self.armed = false
	self.loading = false
	self.reloadtime = 0
	self.shelltype = 42
	self.infire = false
	self.distance = 2500
	self.Entity:SetModel( "models/combatmodels/tank_gun.mdl" ) 	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
	self.Entity:SetSolid( SOLID_VPHYSICS )        -- penis olol    
	self.Entity:SetColor(0,40,255,255)
	self.wooties = 0	
	self.val1 = 0
	self.val2 = 0

          
	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
	phys:Wake() 
	phys:SetMass( 3 ) 
	end 
	
	self.Inputs = Wire_CreateInputs( self.Entity, { "Fire" , } )
	
end   

function ENT:SpawnFunction( ply, tr)
	
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 60
	
	
	local ent = ents.Create( "ISSmallPulseLaser" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	
	
	return ent

end

function ENT:pulse()

	if (self.ammos > 0) then
	
		local pos = self.Entity:GetPos()
				
		local trace = {}
		trace.start = self.Entity:GetPos() + self.Entity:GetUp() * 50
		trace.endpos = self.Entity:GetPos() + self.Entity:GetUp() * self.distance
		trace.filter = self.Entity 
		local tr = util.TraceLine( trace ) 
		
		if (tr.Hit && tr.Entity:IsValid()) then
			if ( !tr.Entity:IsWorld() || !tr.Entity:IsPlayer() || !tr.Entity:IsNPC() || !tr.Entity:IsVehicle()) then
					gcombat.nrghit( tr.Entity,20, 5, tr.HitPos, tr.HitPos )
			
			end
		end
	
		util.BlastDamage(self.Entity, self.Entity, tr.HitPos, 200, 50)
		
		
		
		self.reloadtime = CurTime() + 0.1
		
		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetStart(self.Entity:GetPos() +  self.Entity:GetUp() * 50)
		util.Effect( "ISSmallPulseBeam", effectdata )
		self.Entity:EmitSound( "Lasers/LPulse/PulseLaser.wav", 500, 100 )

	
	end

end

function ENT:TriggerInput(iname, value)

	if (iname == "Fire") then
		if (value == 1 && self.wooties != 1) then self.wooties = 1 end
		if (value == 0 && self.wooties != 0) then self.wooties = 0 end
		self.shelltype = 1
		self.Entity:NextThink( CurTime() + 0.2 )
		return true
	end
	
end

function ENT:Think()


	
		if self.wooties == 1 then
			self:pulse()
			
		end
	
end
