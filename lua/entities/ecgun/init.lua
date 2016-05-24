
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('entities/base_wire_entity/init.lua'); 
include('shared.lua')

function ENT:Initialize()   
	
	self.armed = false
	self.loading = false
	self.reloadtime = 0
	self.shelltype = 42
	self.beano = false
	self.distance = 100000
	--self.Entity:SetModel( "models/combatmodels/tank_gun.mdl" ) 	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
	self.Entity:SetSolid( SOLID_VPHYSICS )        -- Toolbox     
	self.Entity:SetColor(0, 246, 255,255)
	dofire = 0
	
	self.val1 = 0
	self.val2 = 0
	
          
	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
	phys:Wake() 
	phys:SetMass( 3 ) 
	end 
	
	self.Inputs = Wire_CreateInputs( self.Entity, { "Fire LECG" } )
	self.Outputs = Wire_CreateOutputs( self.Entity, { "Can Fire" })
end   

function ENT:SpawnFunction( ply, tr)
	
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 60
	
	
	local ent = ents.Create( "ecgun" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	
	
	return ent

end

function ENT:fireECG()

		local pos = self.Entity:GetPos()
				
		local trace = {}
		trace.start = self.Entity:GetPos() + self.Entity:GetUp() * self.Offset
		trace.endpos = self.Entity:GetPos() + (self.Entity:GetUp() * self.distance + Vector( math.random( -200, 200 ), math.random( -200, 200 ), math.random( -200, 200 )))
		trace.filter = self.Entity 
		local tr = util.TraceLine( trace )
		
		if (tr.Hit && tr.Entity:IsValid()) then
			if ( !tr.Entity:IsWorld() || !tr.Entity:IsPlayer() || !tr.Entity:IsNPC() || !tr.Entity:IsVehicle()) then
				local attack = cbt_dealhcghit( tr.Entity, 12, tr.HitNormal:Dot(self.Entity:GetUp() * -1) * 12, tr.HitPos, tr.HitPos)
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
		
		gcombat.hcgexplode( tr.HitPos, 25, 6, 5)
		gcombat.nrgexplode( tr.HitPos, 50, 12, 5)
		
		self.reloadtime = CurTime() + 0.05
		
		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetStart(self.Entity:GetPos() +  self.Entity:GetUp() * self.Offset )
		util.Effect( "ecgbeam", effectdata )
	
	

end

function ENT:Think()
if FIELDS == nil and COMBATDAMAGEENGINE == nil then return end
	
	
	if (self.reloadtime > CurTime()) then
		self.armed = false
		Wire_TriggerOutput(self.Entity, "Can Fire", 0)
	end
	
	if (self.armed == true) then
		
			self:fireECG()
			
			self.armed = false
		
	elseif (self.reloadtime < CurTime()) then
		Wire_TriggerOutput(self.Entity, "Can Fire", 1)
		if (self.beano == true) then self.armed = true end
	end
end


function ENT:TriggerInput(iname, value)
	if (iname == "Fire LECG") then
		if (value == 1 && self.beano == false) then self.beano = true end		
		if (value == 0 && self.beano == true) then self.beano = false end		
		self.shelltype = 1
		self.Entity:NextThink( CurTime() + 0.01 )
		return true
	end
	
end
 
 function ENT:Offset(num)
 
 self.Offset = num
 
 end
