include("shared.lua")

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

local colFlash = Color(30, 255, 30)
function ENT:Draw()
	self:DrawModel()

	if not MySelf:IsValid() then return end

	local owner = self:GetObjectOwner()

	local w, h = 600, 420

	cam.Start3D2D(self:LocalToWorld(Vector(1, 0, self:OBBMaxs().z)), self:GetAngles(), 0.05)

		draw.RoundedBox(64, w * -0.5, h * -0.5, w, h, color_black_alpha120)

		draw.SimpleText(translate.Get("arsenal_crate"), "ZS3D2DFont2", 0, 0, COLOR_GRAY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if (owner:IsPlayer() and MySelf:Team() == owner:Team() or not owner:IsPlayer()) and GAMEMODE:PlayerCanPurchase(MySelf) then
			colFlash.a = math.abs(math.sin(CurTime() * 5)) * 255
			draw.SimpleText(translate.Get("purchase_now"), "ZS3D2DFont2Small", 0, -64, colFlash, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end

		if owner:IsValid() and owner:IsPlayer() then
			draw.SimpleText("("..owner:ClippedName()..")", "ZS3D2DFont2Small", 0, 64, owner == MySelf and COLOR_BLUE or COLOR_GRAY, TEXT_ALIGN_CENTER)
		end

	cam.End3D2D()
end
