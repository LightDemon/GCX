AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

util.PrecacheSound( "Streetwar.d3_c17_11_fire" )
util.PrecacheSound( "beams/beamstart5.wav" )
util.PrecacheSound( "Airboat_impact_hard" )
util.PrecacheSound( "Town.d1_town_04_spinup" )
util.PrecacheSound( "Canals.d1_canals_01_chargeloop" )
util.PrecacheSound( "d3_citadel.weapon_zapper_charge_node" )


include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local BeamLength = 16384
local BeamSpreadFraction = 16
local MaxHeat = 100
local Heat_Increment = 60
local Refire_Rate = 1.5



local function Discharge(ent)
	local Pos = ent:GetPos()
	local Ang = ent:GetAngles()
	local b_len = BeamLength
	local endpos = nil
	Ang:RotateAroundAxis(Ang:Up(), 180)  --the thing spawns backwards  o_O
	
	Pos = Pos+Ang:Up()*16
	if (ent.beam_mode == 1) then
		ent:EmitSound( "Streetwar.d3_c17_11_fire" )
	end
	ent:EmitSound( "beams/beamstart5.wav", 500, 100 )
	
	local traces = 1
	if (ent.beam_mode == 1) then
		traces = 3  --3 on each side, 6 really...
		b_len = b_len / 4
	end
	
	local endlist = { }
	table.insert( endlist, Pos+(Ang:Forward()*b_len) )
	
	
	local i = traces
	while ((i > 0) and (ent.beam_mode == 1)) do
		table.insert( endlist, Pos+(Ang:Forward()*b_len)+(Ang:Up()*((b_len/BeamSpreadFraction)/traces)*i) )
		table.insert( endlist, Pos+(Ang:Forward()*b_len)-(Ang:Up()*((b_len/BeamSpreadFraction)/traces)*i) )
		i = i - 1
	end
	
	for _, trace_end in pairs( endlist ) do
		local trace = {}
		
		trace.start = Pos
--		trace.endpos = Pos+(Ang:Forward()*BeamLength)
		trace.endpos = trace_end
		trace.filter = { ent }
		local done = 0
		local tr = util.TraceLine( trace )
		while not ((tr.HitWorld) or (tr.Fraction >= 1)) do
			if (tr.Hit) then
				if ((tr.Fraction > 0) and (endpos == nil)) then	--entrance wound
					
					zap = ents.Create("point_tesla")
					zap:SetKeyValue("targetname", "teslab")
					zap:SetKeyValue("m_SoundName" ,"DoSpark")
					zap:SetKeyValue("texture" ,"sprites/plasmabeam.spr")
					if (ent.beam_mode == 1) then
						zap:SetKeyValue("m_Color" ,"255 0 0")
					else
						zap:SetKeyValue("m_Color" ,"0 255 255")
					end
					zap:SetKeyValue("m_flRadius" ,tostring(240))
					zap:SetKeyValue("beamcount_min" ,tostring(12))
					zap:SetKeyValue("beamcount_max", tostring(36))
					zap:SetKeyValue("thick_min", tostring(3))
					zap:SetKeyValue("thick_max", tostring(24))
					zap:SetKeyValue("lifetime_min" ,"0.1")
					zap:SetKeyValue("lifetime_max", "0.2")
					zap:SetKeyValue("interval_min", "0.05")
					zap:SetKeyValue("interval_max" ,"0.08")
					zap:SetPos(tr.HitPos)
					zap:Spawn()
					zap:Fire("DoSpark","",0)
					zap:Fire("DoSpark","",0.08)
					zap:Fire("kill","", 1)
					if (endpos == nil) then zap:EmitSound( "Airboat_impact_hard" ) end
				end
				local Effect = EffectData()
			    Effect:SetOrigin(tr.HitPos)
				Effect:SetAngle( Ang )
				Effect:SetScale( ent.beam_mode )  --the sneakiness!
			    util.Effect("razer_impact", Effect)
				cbt_dealnrghit( tr.Entity, 300, 200, tr.HitPos, tr.Entity)
				cbt_nrgexplode( tr.HitPos, 200, 100, 5)
				util.BlastDamage(ent,ent,tr.HitPos,1,40)
				if not (endpos == nil) then done = 1 end
			end
			if (done == 1) then
				trace.start = tr.HitPos+(Ang:Forward()*math.random(96,256))
			else
				trace.start = tr.HitPos+(Ang:Forward()*64)
			end
	--		trace.endpos = Pos+(Ang:Forward()*(BeamLength*(1 - tr.Fraction)))
			tr = util.TraceLine( trace )
		end
		local Effect = EffectData()
	    Effect:SetOrigin(tr.HitPos)
		Effect:SetAngle( Ang )
		Effect:SetScale( ent.beam_mode )  --the sneakiness!
	    util.Effect("razer_impact", Effect)
		if (endpos == nil) then endpos = tr.HitPos end
	end
	
	
	local effectdata = EffectData()
	effectdata:SetEntity( ent )
	effectdata:SetOrigin( Pos )
	effectdata:SetStart( endpos )
	effectdata:SetAngle( Ang )
	effectdata:SetScale( ent.beam_mode )
	util.Effect( "razer_beam", effectdata, true, true )
end

function ENT:Attack()
	if ( self.heat <= MaxHeat ) then
		Discharge(self.Entity)
		self.heat = self.heat + (Heat_Increment + (Heat_Increment*self.beam_mode*2))
	else
		self.Entity:EmitSound( "Town.d1_town_04_spinup" )
	end
end


function ENT:Initialize()
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	
	self.Entity:NextThink(CurTime() +  1) 
	self.NextFire = CurTime() + 1
	self.beam_mode = 0
	self.Active = 0
	self.heat = 0
	if not (WireAddon == nil) then self.Inputs = Wire_CreateInputs(self.Entity, { "Fire", "Overload" }) end
	if not (WireAddon == nil) then self.Outputs = Wire_CreateOutputs(self.Entity, { "Heat" }) end
	
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(80)
	end
end

function ENT:OnRemove()
	self.Entity:StopSound( "Canals.d1_canals_01_chargeloop" )
end


function ENT:Setup()
	self:TriggerInput("Fire", 0)
end

function ENT:TriggerInput(iname, value)
	if (iname == "Fire") then
		if (value ~= 0) then
			self.Active = 1
		else
			self.Active = 0
		end
	elseif (iname == "Overload") then
		if (value ~= 0) then
			self.beam_mode = 1
			self.Entity:EmitSound( "d3_citadel.weapon_zapper_charge_node", 500, 100 )
			self.Entity:EmitSound( "Canals.d1_canals_01_chargeloop" )
		else
			self.beam_mode = 0
			self.Entity:StopSound( "Canals.d1_canals_01_chargeloop" )
		end
	end
end



function ENT:Think()
	if ( self.beam_mode == 0 ) then
		self:SetOverlayText( "Razer Weapon\n(Heat: " .. self.heat .. ")" )
	else
		self:SetOverlayText( "Razer Weapon\n(OVERLOAD)\n(Heat: " .. self.heat .. ")" )
	end

	if (( self.Active == 1 ) and ( self.NextFire < CurTime() )) then
		self.NextFire = CurTime() +  Refire_Rate
		self:Attack()
	end
	
	
--	if ( self.Entity:NextThink() > CurTime() ) then return end
	self.Entity:NextThink(CurTime() +  1)

	if ( self.heat >= MaxHeat ) then
		local Smoke = ents.Create("env_smoketrail")
		Smoke:SetKeyValue("opacity", 1)
		Smoke:SetKeyValue("spawnrate", 10)
		Smoke:SetKeyValue("lifetime", 2)
		Smoke:SetKeyValue("startcolor", "180 180 180")
		Smoke:SetKeyValue("endcolor", "255 255 255")
		Smoke:SetKeyValue("minspeed", 15)
		Smoke:SetKeyValue("maxspeed", 30)
		Smoke:SetKeyValue("startsize", (self.Entity:BoundingRadius() / 2))
		Smoke:SetKeyValue("endsize", self.Entity:BoundingRadius())
		Smoke:SetKeyValue("spawnradius", 10)
		Smoke:SetKeyValue("emittime", 300)
		Smoke:SetKeyValue("firesprite", "sprites/firetrail.spr")
		Smoke:SetKeyValue("smokesprite", "sprites/whitepuff.spr")
		Smoke:SetPos(self.Entity:GetPos())
		Smoke:SetParent(self.Entity)
		Smoke:Spawn()
		Smoke:Activate()
		Smoke:Fire("kill","", 1)
		
	end
	if ( self.heat > 0 ) then self.heat = self.heat - 1 end
	if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "Heat", self.heat) end
	
	
end

function ENT:AcceptInput(name,activator,caller)
	if name == "Use" and caller:IsPlayer() and caller:KeyDownLast(IN_USE) == false then
		if ( self.beam_mode == 0 ) then
			self.beam_mode = 1
			self.Entity:EmitSound( "d3_citadel.weapon_zapper_charge_node", 500, 100 )
			self.Entity:EmitSound( "Canals.d1_canals_01_chargeloop" )
		else
			self.beam_mode = 0
			self.Entity:StopSound( "Canals.d1_canals_01_chargeloop" )
		end
	end
end



function ENT:PreEntityCopy()
	if (WireAddon == 1) then
		local DupeInfo = Wire_BuildDupeInfo(self.Entity)
		if DupeInfo then
			duplicator.StoreEntityModifier( self.Entity, "WireDupeInfo", DupeInfo )
		end
	end
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	if (WireAddon == 1) then
		if (Ent.EntityMods) and (Ent.EntityMods.WireDupeInfo) then
			Wire_ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
		end
	end
end
