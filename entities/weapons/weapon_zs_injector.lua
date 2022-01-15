AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_injector_name"
	SWEP.TranslateDesc = "weapon_injector_desc"
	SWEP.VElements = {
		["Handle+"] = { type = "Model", model = "models/props_wasteland/cafeteria_table001a.mdl", bone = "v_weapon.USP_Parent", rel = "Handle", pos = Vector(0, 0, -0.718), angle = Angle(0, 0, 180), size = Vector(0.027, 0.041, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Syringe+"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Syringe", pos = Vector(0, 0, 7.388), angle = Angle(-90, 0, 0), size = Vector(0.143, 0.305, 0.305), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },
		["Handle"] = { type = "Model", model = "models/props_wasteland/cafeteria_table001a.mdl", bone = "v_weapon.USP_Parent", rel = "", pos = Vector(0, -0.475, 2.513), angle = Angle(0, 0, -14.912), size = Vector(0.027, 0.041, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Syringe"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "MainPipe", pos = Vector(0, 0, 7.307), angle = Angle(0, 0, 0), size = Vector(0.46, 0.46, 0.569), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Disk"] = { type = "Model", model = "models/props_c17/lamp_standard_off01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "MainPipe", pos = Vector(0, 0, 8.001), angle = Angle(180, 0, 0), size = Vector(0.12, 0.12, 0.097), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Trigger"] = { type = "Model", model = "models/weapons/w_crowbar.mdl", bone = "v_weapon.USP_Trigger", rel = "", pos = Vector(0, 2.736, -0.08), angle = Angle(-15.372, -90, 0), size = Vector(0.197, 0.197, 0.263), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["MainPipe"] = { type = "Model", model = "models/props_pipes/valve002.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Handle", pos = Vector(0, -2.313, 1.648), angle = Angle(0, 180, 164.804), size = Vector(0.093, 0.093, 0.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} }
	}


	SWEP.WElements = {
		["Handle+"] = { type = "Model", model = "models/props_wasteland/cafeteria_table001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(0, 0, -0.718), angle = Angle(0, 0, 180), size = Vector(0.027, 0.041, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["MainPipe"] = { type = "Model", model = "models/props_pipes/valve002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(0, -2.313, 1.648), angle = Angle(0, 180, 164.804), size = Vector(0.093, 0.093, 0.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Handle"] = { type = "Model", model = "models/props_wasteland/cafeteria_table001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.681, 1.804, -0.709), angle = Angle(0, 90, -100.764), size = Vector(0.027, 0.041, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Trigger"] = { type = "Model", model = "models/weapons/w_crowbar.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "MainPipe", pos = Vector(0.324, 2.384, 4.62), angle = Angle(143.777, 93.218, -33.599), size = Vector(0.197, 0.197, 0.263), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Disk"] = { type = "Model", model = "models/props_c17/lamp_standard_off01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "MainPipe", pos = Vector(0, 0, 7.971), angle = Angle(180, 0, 0), size = Vector(0.12, 0.12, 0.097), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Syringe"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "MainPipe", pos = Vector(0, 0, 7.307), angle = Angle(0, 0, 0), size = Vector(0.46, 0.46, 0.569), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Syringe+"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Syringe", pos = Vector(0, 0, 7.388), angle = Angle(-90, 0, 0), size = Vector(0.143, 0.305, 0.305), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} }
	}


	SWEP.ViewModelFOV = 65
	SWEP.ViewModelFlip = false

	SWEP.Slot = 1
	SWEP.SlotPos = 0

	SWEP.HUD3DPos = Vector(-1, 0.4, 1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
	SWEP.HUD3DBone = "v_weapon.USP_Slide"
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"
SWEP.ShowWorldModel = false
SWEP.ShowViewModel = false
SWEP.ViewModel = "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel = "models/weapons/w_pist_usp.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_Glock.Single")
SWEP.Primary.Damage = 30
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.3
SWEP.Recoil = 0.96
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 60
SWEP.Primary.Ammo = "Battery"
SWEP.RequiredClip = 30

SWEP.ConeMax = 0.04
SWEP.ConeMin = 0.012
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.IronSightsPos = Vector(-5.75, 10, 2.7)

SWEP.ReloadSpeed = 0.45
SWEP.HealRangeSqr = 9216
SWEP.HealRangeSqrMin = 2048
SWEP.LastUpdate = 0

SWEP.ToxicDamage = 2
SWEP.ToxicTick = 0.2
SWEP.ToxDuration = 3

function SWEP:SetupDataTables()
	self:NetworkVar("Entity", 3, "CurrentLookTarget")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:SendReloadAnimation()
	self:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:EmitReloadFinishSound()
	if IsFirstTimePredicted() then
		self:EmitSound("weapons/sg550/sg550_boltpull.wav", 90, 150)
	end
end

function SWEP:EmitReloadSound()
	if IsFirstTimePredicted() then
		self:EmitSound("weapons/ump45/ump45_clipout.wav", 90, 135, 0.9, CHAN_AUTO)
	end
end

function SWEP:EmitFireSound()
	self:EmitSound("weapons/m4a1/m4a1-1.wav", 75, 80, 1, CHAN_WEAPON)
	self:EmitSound("items/smallmedkit1.wav", 70, math.random(165, 170), 0.5, CHAN_WEAPON + 21)
	self:EmitSound("weapons/stunstick/alyx_stunner"..math.random(2)..".wav", 70, math.random(115, 120), 0.5, CHAN_WEAPON + 22)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	local curtgt = self:GetCurrentLookTarget()
	if not (curtgt and curtgt:IsValid()) or not self:CheckValidTarget(curtgt) then 
		self:EmitSound("items/suitchargeno1.wav", 75, 110)
		self:SetNextPrimaryFire(CurTime() + 0.5)
		return
	end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextReload(CurTime() + self.Primary.Delay)
	self:EmitFireSound()	
	self:TakeAmmo()
	local dmg = self.Primary.Damage
	self:SetConeAndFire()
	self:DoRecoil()
	local owner = self.Owner
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	local sameteam = curtgt:Team() == owner:Team()
	local tgtpos = curtgt:LocalToWorld(curtgt:OBBCenter())
	local effectdata = EffectData()
		effectdata:SetOrigin(tgtpos)
		effectdata:SetNormal((tgtpos - owner:GetShootPos()):GetNormalized())
		effectdata:SetMagnitude(8)
		effectdata:SetEntity(curtgt)
		util.Effect("hit_healdart", effectdata)
		effectdata:SetFlags(sameteam and 1 or 0)
		effectdata:SetEntity(self)
		effectdata:SetAttachment(1)
		util.Effect("tracer_healray", effectdata)
	if SERVER then
		if sameteam then
			curtgt:GiveStatus("healdartboost").DieTime = CurTime() + 5
			curtgt:HealHealth(self.Primary.Damage,owner,self)
		else
			local invuln = curtgt:GetStatus("spawnbuff")
			if not (invuln and invuln:IsValid()) then
				local tox = curtgt:GetStatus("tox")
				if (tox and tox:IsValid()) then
					tox:AddTime(self.ToxDuration)
					tox.Owner = curtgt
					tox.Damage = self.ToxicDamage
					tox.Damager = owner
					tox.TimeInterval = self.ToxicTick
				else
					stat = curtgt:GiveStatus("tox")
					stat:SetTime(self.ToxDuration)
					stat.Owner = curtgt
					stat.Damage = self.ToxicDamage
					stat.Damager = owner
					stat.TimeInterval = self.ToxicTick
				end
				curtgt:AddLegDamage(dmg*2)
				curtgt:GiveStatus("knockdown", 2)
			end
		end
	end	
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end


function SWEP:GetClosestTarget()
	local owner = self:GetOwner()
	local minimum = nil
	local selectedTarget = nil
	local mypos = owner:EyePos()
    for _,ent in ipairs(player.GetAll()) do
		if ent == owner then continue end
		local centre = ent:WorldSpaceCenter()
		local sqrdst = mypos:DistToSqr(centre)
		if sqrdst > self.HealRangeSqr then continue end
		if (centre - mypos):GetNormalized():Dot(owner:GetAimVector()) < 0.85 and not (sqrdst < self.HealRangeSqrMin) then continue end
		if (minimum == nil or sqrdst < minimum) then
			minimum = sqrdst
			selectedTarget = ent
		end
	end
	if (selectedTarget and selectedTarget:IsValid() and WorldVisible(mypos,selectedTarget:WorldSpaceCenter())) then
		return selectedTarget
	else
		return nil
	end
end

function SWEP:CheckValidTarget(tgt)
	local owner = self:GetOwner()
	local mypos = owner:EyePos()
	if not (tgt and tgt:IsValid() and tgt:IsPlayer() and tgt:Alive()) then return false end

	local centre = tgt:WorldSpaceCenter()
	local sqrdst = mypos:DistToSqr(centre)
	if sqrdst > self.HealRangeSqr or (not (sqrdst < self.HealRangeSqrMin) and ((centre - mypos):GetNormalized():Dot(owner:GetAimVector()) < 0.75 or not WorldVisible(mypos,centre))) then return false end

	return true
end

function SWEP:Think()
	if CurTime() > self.LastUpdate + 0.05 then		
		self:SetCurrentLookTarget(self:GetClosestTarget())
		self.LastUpdate = CurTime()
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

if CLIENT then
	function SWEP:GetEntScreenCoords(ent)
		local min,max = ent:OBBMins(),ent:OBBMaxs()
		local corners = {
			Vector(min.x,min.y,min.z),
			Vector(min.x,min.y,max.z),
			Vector(min.x,max.y,min.z),
			Vector(min.x,max.y,max.z),
			Vector(max.x,min.y,min.z),
			Vector(max.x,min.y,max.z),
			Vector(max.x,max.y,min.z),
			Vector(max.x,max.y,max.z)
		}

		local minx,miny,maxx,maxy = ScrW(),ScrH(),0,0
		for _,corner in pairs(corners) do
			local screen = ent:LocalToWorld(corner):ToScreen()
			minx,miny = math.min(minx,screen.x),math.min(miny,screen.y)
			maxx,maxy = math.max(maxx,screen.x),math.max(maxy,screen.y)
		end
		return minx,miny,maxx,maxy
	end

	function SWEP:DrawHUD()
		local ent = self:GetCurrentLookTarget()
		if ent:IsPlayer() and ent:IsValid() and ent:Alive() and self:CheckValidTarget(ent) then
			local sameteam = (ent:Team() == MySelf:Team())
			local x1,y1,x2,y2 = self:GetEntScreenCoords(ent)
			surface.SetDrawColor(sameteam and COLOR_DARKGREEN or COLOR_DARKRED)
			surface.DrawOutlinedRect(x1, y1, x2-x1, y2-y1, 6)
		end
		if self.BaseClass.DrawHUD then
			self.BaseClass.DrawHUD(self)
		end
	end    
	function SWEP:PostDrawViewModel(vm, pl, wep)
		local veles = self.VElements

		local time = CurTime()
		local reloadfinish = self:GetReloadFinish()
		local reloadstart = self:GetReloadStart()

		local col1, col2 = Color(0, 0, 0, 0), Color(255, 255, 255, 255)
		if (reloadfinish == 0 and self:Clip1() < 1) or (reloadfinish - time * 5) > (time - reloadstart) then
			veles["Syringe+"].color = col1
			veles["Syringe"].color = col1
		else
			veles["Syringe+"].color = col2
			veles["Syringe"].color = col2
		end
		if self.BaseClass.PostDrawViewModel then 
			self.BaseClass.PostDrawViewModel(self,vm, pl, wep)
		end
	end
end
