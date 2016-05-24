
TOOL.Category		= "(GCombat eXtended)"
TOOL.Name			= "#GCX Energy"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "energyindex" ] = "0"
TOOL.ClientConVar[ "model" ] = "models/props_junk/PopCan01a.mdl"
TOOL.ClientConVar[ "offset" ] = "3"
TOOL.ent = {}


cleanup.Register( "gcxenergy" )


// Add Default Language translation (saves adding it to the txt files)
if ( CLIENT ) then

	language.Add( "Tool_gcxenergy_name", "GCX Energy" )
	language.Add( "Tool_gcxenergy_desc", "Adds Energy Weapons to things." )
	language.Add( "Tool_gcxenergy_0", "Left click to weld the selected object. Right click to spawn." )
	
	language.Add( "Tool_gcxenergy_help0", "High damage long recharge energy weapon. " )
	language.Add( "Tool_gcxenergy_help1", "Medium damage medium recharge energy weapon. " )
	language.Add( "Tool_gcxenergy_help2", "Light damage fast recharge energy weapon. " )
	language.Add( "Tool_gcxenergy_help3", "Tesla cannon. " )
	


	
	
	language.Add( "Tool_turret_type", "Type of weapon" )
	
	language.Add( "Undone_gcxenergy", "Undone weapon" )
	
	language.Add( "Cleanup_gcxenergy", "Weapon" )
	language.Add( "Cleaned_gcxenergy", "Cleaned up all Weapons" )
	language.Add( "SBoxLimit_gcombat", "You've reached the Weapon limit!" )

end

list.Set( "CannonModels", "models/combatmodels/tank_gun.mdl", { gcxenergy_offset = 50 })
list.Set( "CannonModels", "models/props_junk/PopCan01a.mdl", { gcxenergy_offset = 3 })
list.Set( "CannonModels", "models/props_lab/pipesystem01a.mdl", { gcxenergy_offset = 32 })


function TOOL:LeftClick( trace )
if (CLIENT) then return true end
local ply = self:GetOwner()
if (!ply:CheckLimit( "gcombat" )) then return end
if ( !trace.Hit ) then return end
	
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end
	
	
	local energyindex	= self:GetClientNumber( "energyindex" ) 
	local model = self:GetClientInfo("model")
	local offset = self:GetClientNumber("offset")
	
	local SpawnPos = trace.HitPos + trace.HitNormal * 6
	if (energyindex == 0) then
	self.ent = ents.Create( "lgecg" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetModel( Model( model) )
		self.ent:Offset( offset )
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyindex == 1) then
	self.ent = ents.Create( "medecg" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetModel( Model( model) )
		self.ent:Offset( offset )
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyindex == 2) then
	self.ent = ents.Create( "ecgun" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetModel( Model( model) )
		self.ent:Offset( offset )
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyindex == 3) then
	self.ent = ents.Create( "tesla" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetModel( Model( model) )
		self.ent:Offset( offset )
	self.ent:Spawn()
	self.ent:Activate()	
	
	end
	
	
	local phys = self.ent:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
		local weld = constraint.Weld(self.ent, trace.Entity, 0, trace.PhysicsBone, 0)
		local nocollide = constraint.NoCollide(self.ent, trace.Entity, 0, trace.PhysicsBone)
	end 
	ply:AddCount( "gcombat", self.ent )
	
	undo.Create("gcxenergy")
		undo.AddEntity( self.ent )
		undo.AddEntity( weld )
		undo.AddEntity( nocollide )
		undo.SetPlayer( ply )
	undo.Finish()
	return true

end

function TOOL:RightClick( trace )
if (CLIENT) then return true end
if ( !trace.Hit ) then return end
local ply = self:GetOwner()
if FIELDS == nil  and COMBATDAMAGEENGINE == nil  then
	ply:PrintMessage( HUD_PRINTCENTER, "You need Gcombat Core to use GCX" )  
	return false
end
if (!ply:CheckLimit( "gcombat" )) then return end	

	
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end
	
	
	local energyindex	= self:GetClientNumber( "energyindex" ) 
	local model = self:GetClientInfo("model")
	local offset = self:GetClientNumber("offset")
	
	local SpawnPos = trace.HitPos + trace.HitNormal * 4
	if (energyindex == 0) then
	self.ent = ents.Create( "lgecg" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetModel( Model( model) )
		self.ent:Offset( offset )
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyindex == 1) then
	self.ent = ents.Create( "medecg" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetModel( Model( model) )
		self.ent:Offset( offset )
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyindex == 2) then
	self.ent = ents.Create( "ecgun" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetModel( Model( model) )
		self.ent:Offset( offset )
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyindex == 3) then
	self.ent = ents.Create( "tesla" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetModel( Model( model) )
		self.ent:Offset( offset )
	self.ent:Spawn()
	self.ent:Activate()	
	
	end

	ply:AddCount( "gcombat", self.ent )
	undo.Create("gcxenergy")
		undo.AddEntity( self.ent )
		undo.SetPlayer( ply )
	undo.Finish()
	return true

end

function TOOL:Reload()
	local ply = self:GetOwner()
	local energyindex	= self:GetClientNumber( "energyindex" ) 
	ply:PrintMessage( HUD_PRINTTALK, "#Tool_gcxenergy_help" .. energyindex )
end



function TOOL.BuildCPanel( CPanel )

	// HEADER
	CPanel:AddControl( "Header", { Text = "#Tool_gcxenergy_name", Description	= "#Tool_gcxenergy_desc" }  )
	
	
	// the pertenent cannon
	local Ctype = {Label = "#Tool_turret_type", MenuButton = 0, Options={}}
		Ctype["Options"]["#Heavy ElectroChemical gun"]	= { gcxenergy_energyindex = "0" }
		Ctype["Options"]["#Medium ElectroChemical gun"]	= { gcxenergy_energyindex = "1" }
		Ctype["Options"]["#Light ElectroChemical gun"]	= { gcxenergy_energyindex = "2" }
		Ctype["Options"]["#Tesla cannon"]	= { gcxenergy_energyindex = "3" }
	

	CPanel:AddControl("ComboBox", Ctype )
	
	CPanel:AddControl( "PropSelect", {	Label = "Model:",
										ConVar = "gcxenergy_model",
										Models = list.Get( "CannonModels" ) } )
	
	
end