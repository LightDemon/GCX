AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()   
self.Entity:SetModel( "models/Roller.mdl" ) 	
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3            
end   

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal 

	local ent = ents.Create( "prop_thumper" )
	ent:SetPos( SpawnPos )   
	ent:SetModel( "models/props_combine/combinethumper001a.mdl" )
	ent:PhysicsInit( SOLID_VPHYSICS )     
	ent:SetMoveType( MOVETYPE_VPHYSICS )   	
	ent:SetSolid( SOLID_VPHYSICS )                
	ent:Spawn()
	 local phys = ent:GetPhysicsObject()
		if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass( 200 ) 
		end 
	ent:Activate()
	ent.active = true
		
		
		
	local ent2 = ents.Create( "repair" )
	ent2.Thump = ent
	ent2:SetPos( SpawnPos +Vector(0,0,10000) )
	ent2:Spawn()
	ent2:Activate()
	return ent2
end

function ENT:Think()
	if (self.Thump.active == nil) then
		self.Entity:Remove()
		return 
	end
	pos = self.Thump.Entity:GetPos()
	for _,v in pairs(ents.FindByClass("prop_thumper")) do
		local dist = (pos - v:GetPos()):Length();
			if(dist <= 2050 && v != self.Thump.Entity) then
		cbt_nrgexplode( self.Thump.Entity:GetPos(), 1000, 20, 6)
		local Rep = ents.Create("point_tesla")
			Rep:SetKeyValue("targetname", "teslab")
			Rep:SetKeyValue("m_SoundName", "DoSpark")
			Rep:SetKeyValue("texture", "sprites/physbeam.spr")
			Rep:SetKeyValue("m_Color", "200 200 255")
			Rep:SetKeyValue("m_flRadius", 1000)
			Rep:SetKeyValue("beamcount_min", 2)
			Rep:SetKeyValue("beamcount_max", 5)
			Rep:SetKeyValue("thick_min", 2)
			Rep:SetKeyValue("thick_max", 8)
			Rep:SetKeyValue("lifetime_min", "0.1")
			Rep:SetKeyValue("lifetime_max", "0.2")
			Rep:SetKeyValue("interval_min", "0.05")
			Rep:SetKeyValue("interval_max", "0.08")
			Rep:SetPos(self.Thump.Entity:GetPos()+self.Thump.Entity:GetUp()*550)
			Rep:Spawn()
			Rep:Fire("DoSpark","",0)
			Rep:Fire("kill","", 1)
		return end
	end
	self:Repair()
	self.NextThink = CurTime() +  20
	end


function ENT:Repair()
	cbt_gcxrepairarea(self.Thump.Entity:GetPos(), 1000, 60)
end

function ENT:OnRemove()
	if (self.Thump.active != nil) then
		self.Thump.Entity:Remove()
	end
end
