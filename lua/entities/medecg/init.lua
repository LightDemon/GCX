
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('entities/base_wire_entity/init.lua'); 
include('shared.lua')

function ENT:Initialize()   
	
	self.armed = false
	self.loading = false
	self.reloadtime = 0
	self.shelltype = 42
	self.crud = false
	self.distance = 100000
	--self.Entity:SetModel( "models/combatmodels/tank_gun.mdl" ) 	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
	self.Entity:SetSolid( SOLID_VPHYSICS )        -- Toolbox     
	self.Entity:SetColor(0, 128, 133, 255)
	dofire = 0
	
	self.val1 = 0
	self.val2 = 0
	
          
	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
	phys:Wake() 
	phys:SetMass( 3 ) 
	end 
	
	self.Inputs = Wire_CreateInputs( self.Entity, { "Fire MECG" } )
	self.Outputs = Wire_CreateOutputs( self.Entity, { "Can Fire"  })
end   

function ENT:SpawnFunction( ply, tr)
	
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 60
	
	
	local ent = ents.Create( "medecg" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	
	
	return ent

end

function ENT:firemedecg()

		local pos = self.Entity:GetPos()
				
		local foopah = {}
		foopah.start = self.Entity:GetPos() + self.Entity:GetUp() * self.Offset
		foopah.endpos = self.Entity:GetPos() + (self.Entity:GetUp() * self.distance + Vector( math.random( -200, 200 ), math.random( -200, 200 ), math.random( -200, 200 )))
		foopah.filter = self.Entity 
		local tr = util.TraceLine( foopah )
		
		if (tr.Hit && tr.Entity:IsValid()) then
			if ( !tr.Entity:IsWorld() || !tr.Entity:IsPlayer() || !tr.Entity:IsNPC() || !tr.Entity:IsVehicle()) then
				local attack = cbt_dealhcghit( tr.Entity, 12, tr.HitNormal:Dot(self.Entity:GetUp() * -1) * 12, tr.HitPos, 		tr.HitPos)
				if (attack == 0) then
					brokedshell = ents.Create("prop_physics")
					brokedshell:SetPos(tr.HitPos + tr.HitNormal*16)
					brokedshell:SetAngles(self.Entity:GetAngles())
					brokedshell:SetKeyValue( "model", "models/combatmodels/tankshell.mdl" )
					brokedshell:PhysicsInit( SOLID_VPHYSICS )
					brokedshell:SetMoveType( MOVETYPE_VPHYSICS )
					brokedshell:SetSolid( SOLID_VPHYSICS )
					brokedshell:Activate()
					brokedshell:Spawn()
					brokedshell:Fire("Kill", "", 20)
					brokedshell:SetColor(0,0,0,255)
					local phys = brokedshell:GetPhysicsObject()  	
					if (phys:IsValid()) then  
						phys:SetVelocity( self.Entity:GetUp() * 10000)
					end
				end
			end
		end
	
		util.BlastDamage(self.Entity, self.Entity, tr.HitPos, 200, 50)
		
		gcombat.hcgexplode( tr.HitPos, 50, 6, 5)
		gcombat.nrgexplode( tr.HitPos, 75, 12, 5)
		
		self.reloadtime = CurTime() + 0.1
		
		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetStart(self.Entity:GetPos() +  self.Entity:GetUp() * self.Offset)
		util.Effect( "medecgbeam", effectdata )
	
	

end

function ENT:Think()
if FIELDS == nil and COMBATDAMAGEENGINE == nil then return end
	
	
	if (self.reloadtime > CurTime()) then
		self.armed = false
		Wire_TriggerOutput(self.Entity, "Can Fire", 0)
	end
	
	if (self.armed == true) then
		
			self:firemedecg()
			
			self.armed = false
		
	elseif (self.reloadtime < CurTime()) then
		Wire_TriggerOutput(self.Entity, "Can Fire", 1)
		if (self.crud == true) then self.armed = true end
	end
end



function ENT:TriggerInput(iname, value)

	if (iname == "Fire MECG") then
		if (value == 1 && self.crud == false) then self.crud = true end		
		if (value == 0 && self.crud == true) then self.crud = false end		
		self.shelltype = 1
		self.Entity:NextThink( CurTime() + 0.15 )
		return true
	end
	
end
 
  function ENT:Offset(num)
 
 self.Offset = num
 
 end

