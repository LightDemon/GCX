
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('entities/base_wire_entity/init.lua'); 
include('shared.lua')

function ENT:Initialize()   

	util.PrecacheSound( "LightDemon/Zap.wav" ) 

	self.Spawned = false
	self.armed = false
	self.loading = false
	self.dietime = nil
	self.reloadtime = 0
	self.shelltype = 42
	self.infire = false
	self.distance = 1000
	--self.Entity:SetModel( "models/combatmodels/tank_gun.mdl" ) 	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
	self.Entity:SetSolid( SOLID_VPHYSICS )        -- Toolbox     
	self.Entity:SetColor(100,40,255,255)

	
          
	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
	phys:Wake() 
	phys:SetMass( 3 ) 
	end 
	
	self.Inputs = Wire_CreateInputs( self.Entity, { "Discharge" } )
	self.Outputs = Wire_CreateOutputs( self.Entity, { "Can Fire" })
	self.ID = math.random(1000);
	self.BeamTarget = SpawnTarget(self.Entity, self.distance, self.ID)
	self.BeamEnt = SpawnBeam(self.Entity, self.BeamTarget, self.ID)
	self.BeamEnt:Fire("turnoff","",0)
	
end   

function ENT:SpawnFunction( ply, tr)
	
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 60
	
	
	local ent = ents.Create( "tesla" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	
	
	return ent

end

function ENT:discharge()
	local trace = {}
		trace.start = self.Entity:GetPos() + self.Entity:GetUp() * self.Offset
		trace.endpos = self.Entity:GetPos() + self.Entity:GetUp() * self.distance + Vector( math.random( -20, 20 ), math.random( -20, 20 ), math.random( -20, 20 ) )
		trace.filter = self.Entity 
		local tr = util.TraceLine( trace ) 
		
		
		self.Entity:EmitSound("LightDemon/Zap.wav" , 500)
		if (tr.Entity:IsValid()) then
			if (tr.Entity:IsWorld() || tr.Entity:IsPlayer() || tr.Entity:IsNPC() || tr.HitSky) then
				
			else 
				cbt_nrgexplode( tr.Entity:GetPos(), 200, 100, 20)
				for _, v in pairs(ents.FindInSphere( tr.Entity:GetPos(), 300 )) do
					local effectdata = EffectData() 
					effectdata:SetStart( v:GetPos() )
					effectdata:SetOrigin( v:GetPos() )
					effectdata:SetScale( 15 )
					effectdata:SetMagnitude( 20 )
					effectdata:SetEntity(v)
					util.Effect( "TeslaHitBoxes", effectdata ) --YAY lighning
					
				end
			end
			
		end
self.reloadtime = CurTime() + .3
end

function ENT:Think()
	
	
	
		if (self.reloadtime > CurTime()) then
			self.armed = false
			Wire_TriggerOutput(self.Entity, "Can Fire", 0)
		end
	
		if (self.armed == true) then
			self:discharge()	
			self.BeamEnt:Fire("turnon","",0)
		elseif (self.reloadtime < CurTime()) then
			Wire_TriggerOutput(self.Entity, "Can Fire", 1)
			self.BeamEnt:Fire("turnoff","",0)
			if (self.infire == true) then self.armed = true end
		end
	
end

function ENT:TriggerInput(iname, value)

	if (iname == "Discharge") then
		if (value == 1 && self.infire == false) then self.infire = true end
		if (value == 0 && self.infire == true) then self.infire = false end
		self.Entity:NextThink( CurTime() )
		return true
	end
		
end

  function SpawnTarget( ent, length, id )
  local  BeamTarget = ents.Create("info_target")
    BeamTarget:SetKeyValue("targetname", "lightning_"..id)
	BeamTarget:SetPos(ent:GetPos() + ent:GetUp() * length)
	BeamTarget:SetAngles(ent:GetAngles())
	
	
    BeamTarget:Spawn()
	
	BeamTarget:SetParent(ent)
	
	return BeamTarget
end

function SpawnBeam( ent, target, id )
  local  Beam = ents.Create("env_laser")
	Beam:SetPos(ent:GetPos() + ent:GetUp() * (ent.Offset + 2))
	Beam:SetAngles(ent:GetAngles())
    Beam:SetKeyValue("renderamt", "255")
    Beam:SetKeyValue("rendercolor", "255 255 255")
	Beam:SetKeyValue("renderfx", 2)
    Beam:SetKeyValue("texture", "trails/electric.vmt")
    Beam:SetKeyValue("TextureScroll", 10)
    Beam:SetKeyValue("damage", 999)
	Beam:SetKeyValue("NoiseAmplitude", 10)
    Beam:SetKeyValue("spawnflags", 16)
    Beam:SetKeyValue("width", 6 )
    Beam:SetKeyValue("dissolvetype", 1)
    Beam:SetKeyValue("LaserTarget", "lightning_"..id)
    Beam:Spawn()
	Beam:SetParent(ent)
	
	return Beam
end

function ENT:Offset(num)
 
 self.Offset = num
 
 end