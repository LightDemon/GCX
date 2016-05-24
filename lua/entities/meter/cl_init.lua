
include('shared.lua')
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Draw()

		local trace = {}
		local vStart = self.Entity:GetPos()
		local vForward = self.Entity:GetUp()
		trace.start = vStart
		trace.endpos = vStart + (vForward * 5000)
		trace.filter = self.Entity
		local tr = util.TraceLine( trace ) 
		self.Entity:SetRenderBoundsWS(self.Entity:GetPos()-self.Entity:GetUp()*self.Entity:BoundingRadius(), tr.HitPos)
		render.SetMaterial(Material("sprites/bluelaser1"))      
		render.DrawBeam(tr.StartPos,tr.HitPos,5,0,0,Color(255,255,255,255)) 
		self:DrawEntityOutline( 0 )
	self.Entity:DrawModel()

end


