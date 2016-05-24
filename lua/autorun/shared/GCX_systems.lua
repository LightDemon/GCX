if(gcx == nil) then
  gcx = {}
end


function gcx.ShieldTrace(pos, dir, filter) --thanks dr.fattyjr
local tr = StarGate.Trace:New(pos, dir, filter)
	local aim = (dir-pos):GetNormal()
	tr.HitShield = false
	
	if(ValidEntity(tr.Entity)) then 		-- special execption for when hitting avon's shield
		local class = tr.Entity:GetClass()
		if(class == "shield") then 	--This is a  ridiculously complex way of actually finding where the spherical shield is and not the cubic bounding box if anybody knows of a better way PLEASE tell me
			local pos2 = tr.Entity:GetPos()
			local rad = tr.Entity:GetNWInt("size", false)
			local relpos = tr.HitPos-pos2
			local a = aim.x^2+aim.y^2+aim.z^2
			local b = 2*(relpos.x*aim.x+relpos.y*aim.y+relpos.z*aim.z)
			local c = relpos.x^2+relpos.y^2+relpos.z^2-rad^2
			local dist = (-1*b-(b^2-4*a*c)^0.5)/(2*a)	-- Thank god for Brahmagupta
			
			if tostring(dist) == "-1.#IND" then 	-- Sometimes the trace will hit the bounding box but end up not actually hitting the round shield and this should mean that dist is a non-real number
				tr = gcx.ShieldTrace(tr.HitPos, dir, tr.Entity)
			elseif dist < 0 then -- If the trace starts in the sphere the dist will be negative.
				dist = (-1*b+(b^2-4*a*c)^0.5)/(2*a)
				tr.HitPos = tr.HitPos+aim*dist
				tr.HitNormal = (tr.HitPos-pos2):GetNormal()
				tr.HitShield = true
			else
				tr.HitPos = tr.HitPos+aim*dist
				tr.HitNormal = (tr.HitPos-pos2):GetNormal()
				tr.HitShield = true
			end
		end
	end

	return tr
end

MsgN("GCX Client Systems Loaded")