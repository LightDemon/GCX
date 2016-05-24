
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('entities/base_wire_entity/init.lua');
include( 'shared.lua' )



function ENT:Initialize()

	self.Entity:SetModel( "models/props_phx/amraam.mdl" )
	self.Entity:SetName("jericho")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
	end

    	self.Entity:SetKeyValue("rendercolor", "255 255 255")
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.STime = CurTime()
	self.LTime = self.STime + self.ParL.LTime
	self.Dist = self.ParL.Dist
end

function ENT:PhysicsUpdate()

	if(self.Exploded) then
		self.Entity:Remove()
		return
	end
		if (self.Locked == true) then
			self.Target = Vector(self.XCo, self.YCo, self.ZCo)
			AimVec = ( self.Target - self.LastPosition ):Angle()
			self.Entity:SetAngles( AimVec )
		end
	
		self.PhysObj:SetVelocity(self.Entity:GetForward()*6200)
		self.LastPosition = self.Entity:GetPos()
end


function ENT:Think()
	self.Location = self.Entity:GetPos()
	local fuse = self.Location:Distance(self.Target)
	
	if (fuse <= self.Dist && self.Locked == true) then
		self:splitterb()
		self:splitter()
		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos() +  self.Entity:GetForward() * 50)
		effectdata:SetStart(self.Entity:GetPos() +  self.Entity:GetForward() * 50)
		util.Effect( "artyfire", effectdata )
		self.Exploded = true		
	end
	
	if (self.PreLaunch == false) then
		self.PreLaunch = true
		local phys = self.Entity:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			phys:EnableGravity(false)
			phys:EnableDrag(false)
			phys:EnableCollisions(true)
			phys:EnableMotion(true)
		end

		local RockTrail = ents.Create("env_rockettrail")
 			  RockTrail:SetAngles( self.Entity:GetForward():GetNormalized() * 1  )
			  RockTrail:SetPos( self.Entity:GetPos() )
			  RockTrail:SetParent(self.Entity)
		      RockTrail:Spawn()
			  RockTrail:Activate()   

 
   
		self.PreLaunch = true
	end

	self.XCo = self.ParL.XCo
	self.YCo = self.ParL.YCo
	self.ZCo = self.ParL.ZCo
	
	if (self.ParL.Locked == true) then
		self.Locked = true
	end
	if (CurTime() > self.LTime) then
		self.Locked = true
	end
end

function ENT:splitter()
	
	if(!self.Exploded) then
		
		
		for i=1,20 do
			local ent = ents.Create("miniboom")
			local vec = (self.Entity:GetForward() + Vector(math.random(-60, 60), math.random(-30, 30), math.random(-30, 30)))
			Foozle = Vector(self.XCo, self.YCo, self.ZCo)
			PinPoint = ( Foozle - self.Entity:GetPos() ):Angle()
			ent:SetPos(self.Entity:GetPos() + vec * 15)
			ent:SetAngles(PinPoint)
			ent:Spawn()
			ent:SetOwner(self.Entity:GetOwner()) // They won't collide with us
			--ent:SetVelocity(vec * 700)
		end
	end
end

function ENT:splitterb()
	
	if(!self.Exploded) then
		for i=1,4 do
			local entb = ents.Create("bigboom")
			local vecb = (self.Entity:GetForward() + Vector(math.random(-30, 30), math.random(-15, 15), math.random(-15, 15)))
			Foozleb = Vector(self.XCo, self.YCo, self.ZCo)
			PinPointb = ( Foozleb - self.Entity:GetPos() ):Angle()
			entb:SetPos(self.Entity:GetPos() + vecb * 15)
			entb:SetAngles(PinPointb)
			entb:Spawn()
			entb:SetOwner(self.Entity:GetOwner()) // They won't collide with us
			--ent:SetVelocity(vec * 700)
		end
	end
end

function ENT:PhysicsCollide( data, physobj )

	if(!self.Exploded) then
		local expl=ents.Create("env_explosion")
		expl:SetPos(self.Entity:GetPos())
		expl:SetName("Missile")
		expl:SetParent(self.Entity)
		expl:SetOwner(self.Entity:GetOwner())
		expl:SetKeyValue("iMagnitude","300");
		expl:SetKeyValue("iRadiusOverride", 250)
		expl:Spawn()
		expl:Activate()
		expl:Fire("explode", "", 0)
		expl:Fire("kill","",0)
		gcombat.hcgexplode( self.Entity:GetPos(), 100, 50, 5 )
		self.Exploded = true
	end
end

function ENT:OnTakeDamage( dmginfo )

	if(!self.Exploded) then
		local expl=ents.Create("env_explosion")
		expl:SetPos(self.Entity:GetPos())
		expl:SetName("Missile")
		expl:SetParent(self.Entity)
		expl:SetOwner(self.Entity:GetOwner())
		expl:SetKeyValue("iMagnitude","300");
		expl:SetKeyValue("iRadiusOverride", 250)
		expl:Spawn()
		expl:Activate()
		expl:Fire("explode", "", 0)
		expl:Fire("kill","",0)
		self.Exploded = true
	end	
end

function ENT:Use( activator, caller )

end
