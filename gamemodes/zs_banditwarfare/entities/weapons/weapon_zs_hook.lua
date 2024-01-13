AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_meathook_name"
	SWEP.TranslateDesc = "weapon_meathook_desc"
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.363, -5), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.181, 4, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_SLASH

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/props_junk/meathook001a.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 10
SWEP.MeleeRange = 65
SWEP.MeleeSize = 1.15

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture
SWEP.Primary.Delay = 1.3
SWEP.SwingRotation = Angle(30, -30, -30)
SWEP.SwingTime = 0.45
SWEP.SwingHoldType = "grenade"

SWEP.IsConsumable = true

SWEP.RegenTime = 5

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 31, "IsHit")
	self:NetworkVar("Float", 31, "LastHit")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(95, 105))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.random(120, 130))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_sheet_impact_bullet"..math.random(2)..".wav")
end

function SWEP:PlayerHitUtil(owner, damage, hitent, dmginfo)
	hitent:MeleeViewPunch(damage*0.5)
	if hitent:Health() > self.MeleeDamage then
		local status = hitent:GetStatus("spawnbuff")
		if status and status:IsValid() then
			return false
		end
		hitent:AddLegDamage(50)
		if not self:GetIsHit() then
			self:SetIsHit(true)
			self:SetLastHit(CurTime())
		end
		if SERVER then
			local ang = self:GetOwner():EyeAngles()
			ang:RotateAroundAxis(ang:Forward(), 180)

			local startPos = owner:GetShootPos()

			local endPos = startPos + ang:Forward() * self.MeleeRange

			local tr = util.TraceHull({start = startPos, endpos = endPos, filter = owner, mins = Vector(-self.MeleeSize, -self.MeleeSize, -self.MeleeSize), maxs = Vector(self.MeleeSize, self.MeleeSize, self.MeleeSize)})

			local ent = ents.Create("prop_meathook")
			if ent:IsValid() then
				ent:SetPos(tr.HitPos)
				ent:Spawn()
				ent:SetOwner(owner)

				local followed = false
				if hitent:GetBoneCount() > 1 then
					local boneindex = hitent:NearestBone(tr.HitPos)
					if boneindex and boneindex > 0 then
						ent:FollowBone(hitent, boneindex)
						ent:SetPos((hitent:GetBonePositionMatrixed(boneindex) * 2 + tr.HitPos) / 3)
						followed = true
					end
				end
				if not followed then
					ent:SetParent(hitent)
				end

				ent:SetAngles(ang)
			end
			--timer.Simple(0, function() owner:StripWeapon(self:GetClass()) end)
		end
		self:SetIsHit(true)
	end
end

function SWEP:CanPrimaryAttack()
	if self:GetIsHit() then return false end

	return self.BaseClass.CanPrimaryAttack(self)
end

function SWEP:Think()
	if self:GetLastHit() and self:GetLastHit() != 0 and self:GetLastHit() + self.RegenTime <= CurTime() then
		self:GiveNewHook()
		self:SetLastHit(0)
	end
	self.BaseClass.Think(self)
end

function SWEP:GiveNewHook()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self.IdleAnimation = CurTime() + self:SequenceDuration()
	self:SetNextPrimaryFire(self.IdleAnimation)
	self:SetIsHit(false)
end

if CLIENT then
	function SWEP:PostDrawViewModel(vm, pl, wep)
		local veles = self.VElements
		local dontdraw = self:GetIsHit()
		local col1, col2 = Color(0, 0, 0, 0), Color(255, 255, 255, 255)

		veles["base"].color = dontdraw and col1 or col2

		if self.BaseClass.PostDrawViewModel then 
			self.BaseClass.PostDrawViewModel(self,vm, pl, wep)
		end
	end

	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()
		if owner:IsValid() and owner.ShadowMan then return end
		local weles = self.WElements
		local dontdraw = self:GetIsHit()
		local col1, col2 = Color(0, 0, 0, 0), Color(255, 255, 255, 255)

		weles["base"].color = dontdraw and col1 or col2

		self:Anim_DrawWorldModel()
	end

	local texGradDown = surface.GetTextureID("VGUI/gradient_down")
	function SWEP:DrawHUD()
		local scrW = ScrW()
		local scrH = ScrH()
		local width = 200
		local height = 30
		local x, y = ScrW() - width - 32, ScrH() - height - 72
		local ratio = math.Clamp((CurTime()-self:GetLastHit())/self.RegenTime,0,1) 
		if ratio > 0 and self:GetIsHit() then
			surface.SetDrawColor(5, 5, 5, 180)
			surface.DrawRect(x, y, width, height)
			surface.SetDrawColor(255, 0, 0, 180)
			surface.SetTexture(texGradDown)
			surface.DrawTexturedRect(x, y, width*ratio, height)
			surface.SetDrawColor(255, 0, 0, 180)
			surface.DrawOutlinedRect(x - 1, y - 1, width + 2, height + 2)
		end
		if self.BaseClass.DrawHUD then
			self.BaseClass.DrawHUD(self)
		end
	end
end