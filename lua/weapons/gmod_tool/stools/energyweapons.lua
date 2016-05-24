
TOOL.Category		= "MechWarrior"
TOOL.Name			= "#Energy Weapons"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "energyweaponsindex" ] = "0"
TOOL.ent = {}


cleanup.Register( "energyweapons")


// Add Default Language translation (saves adding it to the txt files)
if ( CLIENT ) then

	language.Add( "Tool_energyweapons_name", "MW4 tech" )
	language.Add( "Tool_energyweapons_desc", "Adds MW4 Energy Weapons to things." )
	language.Add( "Tool_energyweapons_0", "Left click to weld the selected object. Right click to spawn." )
	
	language.Add( "Tool_turret_type", "Type of weapon" )
	
	language.Add( "Undone_energyweapons", "Undone weapon" )
	
	language.Add( "Cleanup_energyweapons", "MW4 Tech" )
	language.Add( "Cleaned_energyweapons", "Cleaned up all Weapons" )
	language.Add( "SBoxLimit_energyweapons", "You've reached the MW4 limit!" )

end

function TOOL:LeftClick( trace )
if (CLIENT) then return true end
local ply = self:GetOwner()
if ( !trace.Hit ) then return end
	
	if (!ply:CheckLimit( "gcombat" )) then return end
	
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end
	
	
	local energyweaponsindex	= self:GetClientNumber( "energyweaponsindex" ) 
	
	local SpawnPos = trace.HitPos + trace.HitNormal * 4
	if (energyweaponsindex == 0) then
	self.ent = ents.Create( "ClanLargeLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 1) then
	self.ent = ents.Create( "ClanMediumLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 2) then
	self.ent = ents.Create( "ClanSmallLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 3) then
	self.ent = ents.Create( "ERLargeLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 5) then
	self.ent = ents.Create( "ERMediumLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 6) then
	self.ent = ents.Create( "ERSmallLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 7) then
	self.ent = ents.Create( "ISLargeLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 8) then
	self.ent = ents.Create( "ISMediumLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 9) then
	self.ent = ents.Create( "ISSmallLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 10) then
	self.ent = ents.Create( "ClanLargePulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 11) then
	self.ent = ents.Create( "ClanMediumPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 12) then
	self.ent = ents.Create( "ClanSmallPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 13) then
	self.ent = ents.Create( "ERLargePulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 14) then
	self.ent = ents.Create( "ERMediumPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 15) then
	self.ent = ents.Create( "ERSmallPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 16) then
	self.ent = ents.Create( "ISLargePulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 17) then
	self.ent = ents.Create( "ISMediumPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 18) then
	self.ent = ents.Create( "ISSmallPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 19) then
	self.ent = ents.Create( "PPCWeapon" )
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
	
	undo.Create("energyweapons")
		undo.AddEntity( self.ent )
		undo.AddEntity( weld )
		undo.AddEntity( nocollide )
		undo.SetPlayer( ply )
	undo.Finish()
	return true

end

function TOOL:RightClick( trace )
	local ply = self:GetOwner()
if ( !trace.Hit ) then return end
	if (!ply:CheckLimit( "gcombat" )) then return end
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end
	if (CLIENT) then return true end
	
	local energyweaponsindex	= self:GetClientNumber( "energyweaponsindex" ) 
	
	local SpawnPos = trace.HitPos + trace.HitNormal * 4
	if (energyweaponsindex == 0) then
	self.ent = ents.Create( "ClanLargeLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 1) then
	self.ent = ents.Create( "ClanMediumLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 2) then
	self.ent = ents.Create( "ClanSmallLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 3) then
	self.ent = ents.Create( "ERLargeLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 5) then
	self.ent = ents.Create( "ERMediumLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 6) then
	self.ent = ents.Create( "ERSmallLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 7) then
	self.ent = ents.Create( "ISLargeLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 8) then
	self.ent = ents.Create( "ISMediumLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 9) then
	self.ent = ents.Create( "ISSmallLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 10) then
	self.ent = ents.Create( "ClanLargePulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 11) then
	self.ent = ents.Create( "ClanMediumPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 12) then
	self.ent = ents.Create( "ClanSmallPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 13) then
	self.ent = ents.Create( "ERLargePulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()
	elseif (energyweaponsindex == 14) then
	self.ent = ents.Create( "ERMediumPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 15) then
	self.ent = ents.Create( "ERSmallPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 16) then
	self.ent = ents.Create( "ISLargePulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 17) then
	self.ent = ents.Create( "ISMediumPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 18) then
	self.ent = ents.Create( "ISSmallPulseLaser" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	elseif (energyweaponsindex == 19) then
	self.ent = ents.Create( "PPCWeapon" )
		self.ent:SetPos( SpawnPos )
		self.ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0))
	self.ent:Spawn()
	self.ent:Activate()	
	end
	
	ply:AddCount( "gcombat", self.ent )
	
	undo.Create("energyweapons")
		undo.AddEntity( self.ent )
		undo.SetPlayer( ply )
	undo.Finish()
	return true

end

function TOOL.BuildCPanel( CPanel )

	// HEADER
	CPanel:AddControl( "Header", { Text = "#Tool_energyweapons_name", Description	= "#Tool_energyweapons_desc" }  )
	
	
	// the pertenent cannon
	local Ctype = {Label = "#Tool_turret_type", MenuButton = 0, Options={}}
		Ctype["Options"]["#Clan Large Laser"]	= { energyweapons_energyweaponsindex = "0" }
		Ctype["Options"]["#Clan Medium Laser"]	= { energyweapons_energyweaponsindex = "1" }
		Ctype["Options"]["#Clan Small Laser"]	= { energyweapons_energyweaponsindex = "2" }
		Ctype["Options"]["#ER Large Laser"]	= { energyweapons_energyweaponsindex = "3" }
		Ctype["Options"]["#ER Medium Laser"]	= { energyweapons_energyweaponsindex = "5" }
		Ctype["Options"]["#ER Small Laser"]	= { energyweapons_energyweaponsindex = "6" }
		Ctype["Options"]["#IS Large Laser"]	= { energyweapons_energyweaponsindex = "7" }
		Ctype["Options"]["#IS Medium Laser"]	= { energyweapons_energyweaponsindex = "8" }
		Ctype["Options"]["#IS Small Laser"]	= { energyweapons_energyweaponsindex = "9" }
		Ctype["Options"]["#Clan Large Pluse Laser"]	= { energyweapons_energyweaponsindex = "10" }
		Ctype["Options"]["#Clan Medium Pluse Laser"]	= { energyweapons_energyweaponsindex = "11" }
		Ctype["Options"]["#Clan Small Pluse Laser"]	= { energyweapons_energyweaponsindex = "12" }
		Ctype["Options"]["#ER Large Pluse Laser"]	= { energyweapons_energyweaponsindex = "13" }
		Ctype["Options"]["#ER Medium Pluse Laser"]	= { energyweapons_energyweaponsindex = "14" }
		Ctype["Options"]["#ER Small Pluse Laser"]	= { energyweapons_energyweaponsindex = "15" }
		Ctype["Options"]["#IS Large Pluse Laser"]	= { energyweapons_energyweaponsindex = "16" }
		Ctype["Options"]["#IS Medium Pluse Laser"]	= { energyweapons_energyweaponsindex = "17" }
		Ctype["Options"]["#IS Smal Pluse Laser"]	= { energyweapons_energyweaponsindex = "18" }
		Ctype["Options"]["#PPC"]	= { energyweapons_energyweaponsindex = "19" }
					
	CPanel:AddControl("ComboBox", Ctype )
	

end
