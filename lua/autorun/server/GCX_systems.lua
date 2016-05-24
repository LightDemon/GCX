if(gcx == nil) then
  gcx = {}
end

AddCSLuaFile("autorun/shared/GCX_systems.lua")
include("autorun/shared/GCX_systems.lua")

function gcx.repair(entity, amount)
	if entity != nil then
		if entity:IsValid()  then
			if not entity:IsWorld() and not entity:IsPlayer() then
				if entity.cbt != nil then
					entity.cbt.health = math.Clamp(entity.cbt.health + amount , 10 , entity.cbt.maxhealth)
				end
			end	
		end
	end
end 

cbt_gcxrepair = gcx.repair

function gcx.repairarea(pos, area, amount)
	local targets = ents.FindInSphere( pos, area)

	for _,v in pairs(targets) do
		
		cbt_gcxrepair( v.Entity, amount)
	end
end 

cbt_gcxrepairarea = gcx.repairarea

function gcx.FindInCone(pos, dir, dist, ang) 
    local ent = ents.GetAll() 
    for k,v in pairs (ent) do 
        local targetVec = (v:GetPos() - pos):GetNormal()
		local angle = math.acos(dir:DotProduct(targetVec))
		local range = pos:Distance(v:GetPos())
        if math.Rad2Deg(angle) > ang or range > dist then 
            ent[k] = nil 
        end 
    end 
    return ent 
end 

FindinCone2 = gcx.FindInCone

function gcx.fragcone( position, direction, distance, angle, damage, pierce)

	local targets = FindinCone2( position, direction, distance, angle)
	--local tooclose = FindinCone2( position, direction, 5, angle)
	
	for _,i in pairs(targets) do
			local hitat = i:GetPos()
			cbt_dealhcghit( i, damage, pierce, hitat, hitat)
		
	end
	
	
end

gcx_fragcone = gcx.fragcone

 function gcx.EA( entity , on ) --emp core Thank you AlgorithmX2
if (!entity or !entity:IsValid() ) then return end 
	if (entity) and (entity.Inputs) and type(entity.Inputs) == 'table' then
		for k,v in pairs(entity.Inputs) do
			if v.Type == "NORMAL" then
				if (entity.TriggerInput) then
					if on then
						entity:TriggerInput( k , entity.Inputs[ k ].Value + math.random() * 500 )
					else
						entity:TriggerInput( k , entity.Inputs[ k ].Value )
					end
				end
			elseif v.Type == "VECTOR" then
				if (entity.TriggerInput) then
					if on then
						entity:TriggerInput( k , entity.Inputs[ k ].Value + Vector(math.random() * 500 ,math.random() * 500 ,math.random() * 500) )
					else
						entity:TriggerInput( k , entity.Inputs[ k ].Value )
					end
				end
			end
		end
end
end

function gcx.ER(List) --emp run function
	for _,v in pairs( List ) do
		gcx.EA( v , true );
			
	end
end

gcx_EmpRun = gcx.ER

function gcx.ED(List) --emp end function
	for _,v in pairs( List ) do
		gcx.EA( v , false );
	end
end

gcx_EmpEnd = gcx.ED
