TOOL.Category = '(GCombat eXtended)'
TOOL.Name = '#Razer Weapon'
TOOL.Command = nil
TOOL.ConfigName = ''

TOOL.ClientConVar['keydown'] = ''

cleanup.Register('razers')


if ( CLIENT ) then
	language.Add( 'Tool_weapon_razer_name', 'Razer Weapon Spawner (Shanjaq)' )
	language.Add( 'Tool_weapon_razer_desc', 'Create Razer Weapons attached to any surface.' )
	language.Add( 'Tool_weapon_razer_0', 'Click somewhere to attach a Razer Weapon.' )

	language.Add( 'Undone_weapon_razer', 'Razer Undone' )
	language.Add( 'Cleanup_razers', 'Razer' )
	language.Add( 'Cleaned_razer', 'Cleaned up all Razers' )
	language.Add( 'SBoxLimit_razers', 'Maximum Razer Weapons Reached' )
end



function TOOL:LeftClick( trace )
	if trace.Entity && (trace.Entity:IsPlayer() ) then return false end
	
	if(CLIENT) then
		return true
	end

	if(!SERVER) then return false end

	if ( !self:GetSWEP():CheckLimit( "razers" ) ) then return false end

	local ply = self:GetOwner()
	local Pos = trace.HitPos
	local Ang = trace.HitNormal:Angle()
	Ang.pitch = Ang.pitch + 90
	
	local keydown 			= self:GetClientNumber( 'keydown' ) 
	ent = MakeRazer( ply, Ang, Pos, keydown )
	ent:SetPos( trace.HitPos - trace.HitNormal * ent:OBBMins().z)
	
	if ( trace.Entity:IsValid() ) then
		local const = constraint.Weld(ent, trace.Entity,0, trace.PhysicsBone, 0, systemmanager )
		nocollide = constraint.NoCollide( ent, trace.Entity, 0, trace.PhysicsBone )
		trace.Entity:DeleteOnRemove( ent )
	end

	undo.Create('Razer')
		undo.AddEntity( ent)
		undo.AddEntity( const )
		undo.AddEntity( nocollide )
		undo.SetPlayer( ply )
	undo.Finish()


	ply:AddCleanup( 'razers', thruster )
	ply:AddCleanup( 'razers', const )
	ply:AddCleanup( 'razers', nocollide )
	
	return true
end

if SERVER then 
    CreateConVar('sbox_maxrazers',4)
	
	function MakeRazer( ply, Ang, Pos, keydown )
		if ( !ply:CheckLimit( "razers" ) ) then return nil end
		local ent = ents.Create( 'razer_base' )
			if !ent:IsValid() then return false end
			ent:SetModel( "models/props_combine/combine_light002a.mdl" )
			ent:SetAngles(Ang)
			ent:SetPos(Pos)
		ent:Spawn()

		ent:SetVar('Owner',ply)
		
		numpad.OnDown(ply, keydown, 'Razer_On', ent, 1)
		numpad.OnUp(ply, keydown, 'Razer_Off', ent, 1)

		local rtable = {
			keydown = keydown,
			Active = 0
			}
			
			
		table.Merge(ent:GetTable(), rtable )
		
		ply:AddCount('razers', ent)
		
		return ent
	end
	
	duplicator.RegisterEntityClass( 'razer', MakeRazer,  'Ang', 'Pos', 'keydown')
	
	local function ResetCamera( ent, player )
		player:SetViewEntity(player)
	end
	
	local function Razer_On( pl, ent, mul )
		if (!ent:IsValid()) then return false end
		
		ent:GetTable().Active = 1
		return true
	end

	local function Razer_Off( pl, ent, mul )
		if (!ent:IsValid()) then return false end

		ent:GetTable().Active = 0
		return true
	end

	numpad.Register( "Razer_On", Razer_On )
	numpad.Register( "Razer_Off", Razer_Off )	
end

function TOOL.BuildCPanel( cp )
	cp:AddControl( 'Header', { Text = '#Tool_weapon_razer_name', Description	= '#Tool_weapon_razer_desc' }  )


	cp:AddControl('Numpad', { Label = 'Fire:', ButtonSize = '22', Command = 'weapon_razer_keydown' } )
	
end

function TOOL:UpdateGhostRazer( ent, player )

	if ( !ent ) then return end
	if ( !ent:IsValid() ) then return end

	local tr 	= utilx.GetPlayerTrace( player, player:GetCursorAimVector() )
	local trace 	= util.TraceLine( tr )
	if (!trace.Hit) then return end
	
	if (trace.Entity && trace.Entity:GetClass() == "razer_base" || trace.Entity:IsPlayer() ) then
	
		ent:SetNoDraw( true )
		return
		
	end
	
	local Ang = trace.HitNormal:Angle()
	Ang.pitch = Ang.pitch + 90
	ent:SetAngles( Ang )
	
	local min = ent:OBBMins()
	ent:SetPos( trace.HitPos - trace.HitNormal * min.z )
	
	ent:SetNoDraw( false )
	
end


function TOOL:Think()
	local model	= "models/props_combine/combine_light002a.mdl"
	
	if (!self.GhostEntity || !self.GhostEntity:IsValid() || self.GhostEntity:GetModel() != model) then
		self:MakeGhostEntity( model, Vector(0,0,0), Angle(0,0,0) )
	end
	
	self:UpdateGhostRazer( self.GhostEntity, self:GetOwner() )
end


