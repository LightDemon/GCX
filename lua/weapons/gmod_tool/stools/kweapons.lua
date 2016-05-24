
TOOL.Category		= "Karbine's GCX"
TOOL.Name			= "#Karbine's weapons"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "kweaponsindex" ] = "0"
TOOL.ent = {}


cleanup.Register( "kweapons" )


// Add Default Language translation (saves adding it to the txt files)
if ( CLIENT ) then

	language.Add( "Tool_kweapons_name", "Karbine's weapons" )
	language.Add( "Tool_kweapons_desc", "Adds cannons to things." )
	language.Add( "Tool_kweapons_0", "Left click to weld the selected object. Right click to spawn." )
	

	language.Add( "Tool_kweapons_help0", "40mm Anti-infantry/light target" )
	language.Add( "Tool_kweapons_help1", "40mm grenade launcher" )
	language.Add( "Tool_kweapons_help2", "30mm autocannon " )
	language.Add( "Tool_kweapons_help3", "Karbine's 120mm " )
	language.Add( "Tool_kweapons_help4", "broke" )
	language.Add( "Tool_kweapons_help5", "Karbine's 150mm " )
	language.Add( "Tool_kweapons_help6", "7,5cm cannon " )
	language.Add( "Tool_kweapons_help7", "20mm Anti-air weapon " )
	language.Add( "Tool_kweapons_help8", "50 cal ent test" )
	language.Add( "Tool_kweapons_help9", "GAU-8 Ent version " )
	language.Add( "Tool_kweapons_help10", "105mm railgun " )
	language.Add( "Tool_kweapons_help11", "Smoke dispenser " )
	language.Add( "Tool_kweapons_help12", "37mm kannone " )
	language.Add( "Tool_kweapons_help13", "Energy Discharger " )
	language.Add( "Tool_kweapons_help14", "230mm cannon. " )
	language.Add( "Tool_kweapons_help15", "old cannon." )
	language.Add( "Tool_kweapons_help16", "MG42" )
	language.Add( "Tool_kweapons_help17", "Heavy laser" )
	language.Add( "Tool_kweapons_help18", "Rebel laser" )
	language.Add( "Tool_kweapons_help19", "Imperial laser" )
	language.Add( "Tool_kweapons_help20", "Light laser" )
	language.Add( "Tool_kweapons_help21", "M197" )
	language.Add( "Tool_kweapons_help22", "Unguided spam" )
	language.Add( "Tool_kweapons_help23", "Anti-anything" )
	language.Add( "Tool_kweapons_help24", "German 30mm" )
	language.Add( "Tool_kweapons_help25", "German 20mm" )
	language.Add( "Tool_kweapons_help26", "German 8mm" )
	language.Add( "Tool_kweapons_help27", "Anti Infantry Arty" )
	language.Add( "Tool_kweapons_help28", ".50BMG rifle" )


	
	
	language.Add( "Tool_turret_type", "Type of weapon" )
	
	language.Add( "Undone_kweapons", "Undone weapon" )
	
	language.Add( "Cleanup_kweapons", "Weapon" )
	language.Add( "Cleaned_kweapons", "Cleaned up all Weapons" )
	language.Add( "SBoxLimit_gcombats", "You've reached the Weapon limit!" )

end

function TOOL:LeftClick( trace )
local ply = self:GetOwner()
if FIELDS == nil and COMBATDAMAGEENGINE == nil then
	ply:PrintMessage( HUD_PRINTCENTER, "You need Gcombat Core to use GCX" )  
	return 
end
if (!ply:CheckLimit( "gcombat" )) then return end
if ( !trace.Hit ) then return end
	
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end
	if (CLIENT) then return true end
	
	local kweaponsindex	= self:GetClientNumber( "kweaponsindex" ) 
	
	local SpawnPos = trace.HitPos + trace.HitNormal * 6

	if (kweaponsindex == 0) then
	self.ent = ents.Create( "40mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (kweaponsindex == 1) then
	self.ent = ents.Create( "mk19" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
		elseif (kweaponsindex == 2) then
	self.ent = ents.Create( "30mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
		elseif (kweaponsindex == 3) then
	self.ent = ents.Create( "120mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
		elseif (kweaponsindex == 4) then
	self.ent = ents.Create( "m250cal" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
		elseif (kweaponsindex == 5) then
	self.ent = ents.Create( "k150mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
			elseif (kweaponsindex == 6) then
	self.ent = ents.Create( "75mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
				elseif (kweaponsindex == 7) then
	self.ent = ents.Create( "20mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 8) then
	self.ent = ents.Create( "50calent" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 9) then
	self.ent = ents.Create( "gau8" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 10) then
	self.ent = ents.Create( "105mmrailgun" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetOwner(ply)
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 11) then
	self.ent = ents.Create( "smoke" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 12) then
	self.ent = ents.Create( "37mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 13) then
	self.ent = ents.Create( "energydischarger" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 14) then
	self.ent = ents.Create( "230mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 15) then
	self.ent = ents.Create( "oldcannon" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 16) then
	self.ent = ents.Create( "mg42" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 17) then
	self.ent = ents.Create( "heavylaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 18) then
	self.ent = ents.Create( "redlaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 19) then
	self.ent = ents.Create( "greenlaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 20) then
	self.ent = ents.Create( "lightlaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 21) then
	self.ent = ents.Create( "m197" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 22) then
	self.ent = ents.Create( "rocketpod" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 23) then
	self.ent = ents.Create( "rpgbase" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 24) then
	self.ent = ents.Create( "mk108" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 25) then
	self.ent = ents.Create( "mg151" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 26) then
	self.ent = ents.Create( "mg17" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 27) then
	self.ent = ents.Create( "105mmhowitzer" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 28) then
	self.ent = ents.Create( "50bmg" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	

	
	end
	
	
	local phys = self.ent:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
		local weld = constraint.Weld(self.ent, trace.Entity, 0, trace.PhysicsBone, 0)
		local nocollide = constraint.NoCollide(self.ent, trace.Entity, 0, trace.PhysicsBone)
	end 
	ply:AddCount( "gcombat", self.ent )
	
	undo.Create("kweapons")
		undo.AddEntity( self.ent )
		undo.AddEntity( weld )
		undo.AddEntity( nocollide )
		undo.SetPlayer( ply )
	undo.Finish()
	return true

end

function TOOL:RightClick( trace )
local ply = self:GetOwner()
if FIELDS == nil and COMBATDAMAGEENGINE == nil then
	ply:PrintMessage( HUD_PRINTCENTER, "You need Gcombat Core to use GCX" )  
	return 
end
if (!ply:CheckLimit( "gcombat" )) then return end	
if ( !trace.Hit ) then return end
	
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end
	if (CLIENT) then return true end
	
	local kweaponsindex	= self:GetClientNumber( "kweaponsindex" ) 
	
	local SpawnPos = trace.HitPos + trace.HitNormal * 4
	if (kweaponsindex == 0) then
	self.ent = ents.Create( "40mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (kweaponsindex == 1) then
	self.ent = ents.Create( "mk19" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
		elseif (kweaponsindex == 2) then
	self.ent = ents.Create( "30mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
		elseif (kweaponsindex == 3) then
	self.ent = ents.Create( "120mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
		elseif (kweaponsindex == 4) then
	self.ent = ents.Create( "m250cal" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
		elseif (kweaponsindex == 5) then
	self.ent = ents.Create( "k150mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
			elseif (kweaponsindex == 6) then
	self.ent = ents.Create( "75mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
				elseif (kweaponsindex == 7) then
	self.ent = ents.Create( "20mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 8) then
	self.ent = ents.Create( "50calent" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 9) then
	self.ent = ents.Create( "gau8" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 10) then
	self.ent = ents.Create( "105mmrailgun" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
		self.ent:SetOwner(ply)
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 11) then
	self.ent = ents.Create( "smoke" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
				    elseif (kweaponsindex == 12) then
	self.ent = ents.Create( "37mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()		
					elseif (kweaponsindex == 13) then
	self.ent = ents.Create( "energydischarger" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 14) then
	self.ent = ents.Create( "230mm" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 15) then
	self.ent = ents.Create( "oldcannon" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 16) then
	self.ent = ents.Create( "mg42" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 17) then
	self.ent = ents.Create( "heavylaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 18) then
	self.ent = ents.Create( "redlaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 19) then
	self.ent = ents.Create( "greenlaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 20) then
	self.ent = ents.Create( "lightlaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 21) then
	self.ent = ents.Create( "m197" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 22) then
	self.ent = ents.Create( "rocketpod" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 23) then
	self.ent = ents.Create( "rpgbase" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 24) then
	self.ent = ents.Create( "mk108" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 25) then
	self.ent = ents.Create( "mg151" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 26) then
	self.ent = ents.Create( "mg17" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 27) then
	self.ent = ents.Create( "105mmhowitzer" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
					elseif (kweaponsindex == 28) then
	self.ent = ents.Create( "50bmg" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()

	end

	ply:AddCount( "gcombat", self.ent )
	undo.Create("kweapons")
		undo.AddEntity( self.ent )
		undo.AddEntity( weld )
		undo.AddEntity( nocollide )
		undo.SetPlayer( ply )
	undo.Finish()
	return true

end

function TOOL:Reload()
	local ply = self:GetOwner()
	local kweaponsindex	= self:GetClientNumber( "kweaponsindex" ) 
	ply:PrintMessage( HUD_PRINTTALK, "#Tool_kweapons_help" .. kweaponsindex )
end



function TOOL.BuildCPanel( CPanel )

	// HEADER
	CPanel:AddControl( "Header", { Text = "#Tool_kweapons_name", Description	= "#Tool_kweapons_desc" }  )
	
	
	// the pertenent cannon
	local Ctype = {Label = "#Tool_turret_type", MenuButton = 0, Options={}}

		Ctype["Options"]["#Bofors 40mm"]	= { kweapons_kweaponsindex = "0" }
		Ctype["Options"]["#MK19"]	= { kweapons_kweaponsindex = "1" }
		Ctype["Options"]["#30MM"]	= { kweapons_kweaponsindex = "2" }
		Ctype["Options"]["#120mm"]	= { kweapons_kweaponsindex = "3" }
		Ctype["Options"]["#M2 50cal"]	= { kweapons_kweaponsindex = "4" }
		Ctype["Options"]["#150mm"]	= { kweapons_kweaponsindex = "5" }
		Ctype["Options"]["#7.5cm cannon"]	= { kweapons_kweaponsindex = "6" }
		Ctype["Options"]["#20mm Anti-Air weapon"]	= { kweapons_kweaponsindex = "7" }
		Ctype["Options"]["#50 cal "]	= { kweapons_kweaponsindex = "8" }
		Ctype["Options"]["#GAU-8"]	= { kweapons_kweaponsindex = "9" }
		Ctype["Options"]["#105mm railgun"]	= { kweapons_kweaponsindex = "10" }
		Ctype["Options"]["#Smoke dispenser"]	= { kweapons_kweaponsindex = "11" }
		Ctype["Options"]["#37mm Kannone"]	= { kweapons_kweaponsindex = "12" }
		Ctype["Options"]["#Energy Discharger"]	= { kweapons_kweaponsindex = "13" }
		Ctype["Options"]["#230mm cannon"]	= { kweapons_kweaponsindex = "14" }
		Ctype["Options"]["#old ye cannon"]	= { kweapons_kweaponsindex = "15" }
		Ctype["Options"]["#MG42"]	= { kweapons_kweaponsindex = "16" }
		Ctype["Options"]["#Heavy Laser"]	= { kweapons_kweaponsindex = "17" }
		Ctype["Options"]["#Rebel Laser"]	= { kweapons_kweaponsindex = "18" }
		Ctype["Options"]["#Imperial Laser"]	= { kweapons_kweaponsindex = "19" }
		Ctype["Options"]["#Light Laser"]	= { kweapons_kweaponsindex = "20" }
		Ctype["Options"]["#M197"]	= { kweapons_kweaponsindex = "21" }
		Ctype["Options"]["#Rocket Pod"]	= { kweapons_kweaponsindex = "22" }
		Ctype["Options"]["#ignore"]	= { kweapons_kweaponsindex = "23" }
		Ctype["Options"]["#mk108"]	= { kweapons_kweaponsindex = "24" }
		Ctype["Options"]["#MG151/20"]	= { kweapons_kweaponsindex = "25" }
		Ctype["Options"]["#mg17"]	= { kweapons_kweaponsindex = "26" }
		Ctype["Options"]["#105mm Howitzer"]	= { kweapons_kweaponsindex = "27" }
		Ctype["Options"]["#.50BMG Semiauto"]	= { kweapons_kweaponsindex = "28" }
		
	CPanel:AddControl("ComboBox", Ctype )
	

end
