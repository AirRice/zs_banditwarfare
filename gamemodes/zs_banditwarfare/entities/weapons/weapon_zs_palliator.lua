AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_palliator_name"
	SWEP.TranslateDesc = "weapon_palliator_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 57

	SWEP.HUD3DBone = "Base"
	SWEP.HUD3DPos = Vector(6, -2, -7)
	SWEP.HUD3DAng = Angle(180, 0, 0)
	SWEP.HUD3DScale = 0.045

	SWEP.VElements = {
		["Center"] = { type = "Model", model = "models/props_wasteland/buoy01.mdl", bone = "Base", rel = "", pos = Vector(0, 2.627, 1.282), angle = Angle(0, 0, 0), size = Vector(0.142, 0.142, 0.196), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["Vials++"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Center", pos = Vector(-3.329, 0.365, -7.882), angle = Angle(-87.508, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Vials"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Center", pos = Vector(-1.859, -2.454, -6.895), angle = Angle(-87.508, 130.707, 0), size = Vector(0.635, 0.635, 0.635), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Center", pos = Vector(8.949, 1.574, -6.435), angle = Angle(-96.032, -11.589, 0), size = Vector(0.904, 0.904, 0.477), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["Center+++"] = { type = "Model", model = "models/props_c17/consolebox01a.mdl", bone = "Base", rel = "Center", pos = Vector(0, -1.63, -9.438), angle = Angle(-90, 90, 0), size = Vector(0.151, 0.151, 0.151), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Weapon+"] = { type = "Model", model = "models/props_combine/combine_interface001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Center", pos = Vector(0, -0.064, -4.317), angle = Angle(180, -90, 0), size = Vector(0.202, 0.142, 0.202), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Weapon"] = { type = "Model", model = "models/weapons/w_rif_m4a1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Center", pos = Vector(0, 4.967, -4.23), angle = Angle(90, -90, 0), size = Vector(0.731, 1.37, 0.643), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Center++"] = { type = "Model", model = "models/healthvial.mdl", bone = "Base", rel = "Center", pos = Vector(0, 0, -6.086), angle = Angle(0, 90, 0), size = Vector(1.593, 1.593, 2.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Center+++++"] = { type = "Model", model = "models/props_combine/combine_mortar01a.mdl", bone = "Base", rel = "Center", pos = Vector(-0.555, -0.128, -8.848), angle = Angle(0, 180, 0), size = Vector(0.17, 0.17, 0.17), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Vials+"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Center", pos = Vector(-3.093, -1.247, -7.641), angle = Angle(-87.508, 158.44, 0), size = Vector(0.535, 0.535, 0.535), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Center+"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "Base", rel = "Center", pos = Vector(0, 0, -6.086), angle = Angle(0, 0, 0), size = Vector(0.082, 0.082, 0.172), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["Center++++"] = { type = "Model", model = "models/props_pipes/pipecluster16d_002a.mdl", bone = "Base", rel = "Center", pos = Vector(4.032, 0.187, 2.553), angle = Angle(0, 0, -90), size = Vector(0.071, 0.071, 0.071), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Center++++++"] = { type = "Model", model = "models/props_c17/substation_transformer01a.mdl", bone = "Base", rel = "Center", pos = Vector(1.57, 3.996, 6.092), angle = Angle(0, 0, 90), size = Vector(0.054, 0.054, 0.024), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}


	SWEP.WElements = {
		["Center"] = { type = "Model", model = "models/props_wasteland/buoy01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.503, -1.672, -5.594), angle = Angle(-8.82, -78.866, -90), size = Vector(0.142, 0.142, 0.196), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["Vials++"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(-3.329, 0.365, -7.882), angle = Angle(-87.508, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Vials"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(-1.859, -2.454, -6.895), angle = Angle(-87.508, 130.707, 0), size = Vector(0.635, 0.635, 0.635), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(8.949, 1.574, -3.674), angle = Angle(-96.032, -11.589, 0), size = Vector(0.904, 0.904, 0.477), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["Center+++"] = { type = "Model", model = "models/props_c17/consolebox01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(0, -1.63, -9.438), angle = Angle(-90, 90, 0), size = Vector(0.151, 0.151, 0.151), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Center++++++"] = { type = "Model", model = "models/props_c17/substation_transformer01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(1.57, 3.996, 6.092), angle = Angle(0, 0, 90), size = Vector(0.054, 0.054, 0.024), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Center+++++"] = { type = "Model", model = "models/props_combine/combine_mortar01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(-0.555, -0.128, -8.848), angle = Angle(0, 180, 0), size = Vector(0.17, 0.17, 0.17), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Center++"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(0, 0, -6.086), angle = Angle(0, 90, 0), size = Vector(1.593, 1.593, 2.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Center+"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(0, 0, -6.086), angle = Angle(0, 0, 0), size = Vector(0.082, 0.082, 0.172), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["Weapon+"] = { type = "Model", model = "models/props_combine/combine_interface001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(0, -0.064, -4.317), angle = Angle(180, -90, 0), size = Vector(0.202, 0.142, 0.202), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Vials+"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(-3.093, -1.247, -7.641), angle = Angle(-87.508, 158.44, 0), size = Vector(0.535, 0.535, 0.535), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Center++++"] = { type = "Model", model = "models/props_pipes/pipecluster16d_002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(4.032, 0.187, 2.553), angle = Angle(0, 0, -90), size = Vector(0.071, 0.071, 0.071), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Weapon"] = { type = "Model", model = "models/weapons/w_rif_m4a1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Center", pos = Vector(0, 4.967, -4.23), angle = Angle(90, -90, 0), size = Vector(0.731, 1.37, 0.643), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "physgun"

SWEP.ViewModel = "models/weapons/c_physcannon.mdl"
SWEP.WorldModel = "models/weapons/w_physics.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.UseHands = true

SWEP.Primary.Delay = 0.1

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 250
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Battery"

SWEP.ConeMax = 0
SWEP.ConeMin = 0
SWEP.NoAmmo = false
SWEP.Recoil = 0.1

SWEP.ReloadSound = ""
SWEP.Primary.Sound = ""
SWEP.Primary.Damage = 1
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.05


SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.IronSightsPos = Vector(-6.6, 20, 3.1)
SWEP.NextHurt = 0
SWEP.StartPos = nil
SWEP.EndPos = nil

SWEP.HasNoClip = true
SWEP.LowAmmoThreshold = 150
SWEP.HealRangeSqr = 147456
SWEP.HealRangeSqrMin = 2048
SWEP.LastUpdate = 0
SWEP.PossibleTargets = {}
sound.Add( {
	name = "Loop_Palliator_Heal",
	channel = CHAN_AUTO+20,
	volume = 1,
	level = 75,
	pitch = 120,
	volume = 0.5,
	sound = "items/medcharge4.wav"
} )
sound.Add( {
	name = "Loop_Palliator_Heal2",
	channel = CHAN_AUTO+21,
	volume = 1,
	level = 75,
	pitch = 90,
	volume = 1,
	sound = "items/suitcharge1.wav"
} )
function SWEP:SetupDataTables()
	self:NetworkVar("Float", 4, "LastHealTime")
	self:NetworkVar("Entity", 3, "CurrentLookTarget")
	self:NetworkVar("Entity", 4, "CurrentTarget")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self:GetNextPrimaryFire() > CurTime() or self:GetCurrentTarget():IsValid() or not (self:GetCurrentLookTarget() and self:GetCurrentLookTarget():IsValid()) then return end
	if self:Ammo1() <= 0 then
		self:EmitSound("items/suitchargeno1.wav", 75, 110)
		self:SetNextPrimaryFire(CurTime() + 0.5)
		return
	end
	local owner = self:GetOwner()
	self:SetCurrentTarget(self:GetCurrentLookTarget())
	self:SetNextPrimaryFire(CurTime() + 0.5)
	self:EmitSound("items/medshot4.wav", 75, 80)
end

function SWEP:SecondaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then return end
	if self:GetNextPrimaryFire() <= CurTime() then
		self:SetCurrentTarget(nil)
		self:SetNextPrimaryFire(CurTime() + 0.5)
		self:EmitSound("items/medshotno1.wav", 75, 80)
	end
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
		if (centre - mypos):GetNormalized():Dot(owner:GetAimVector()) < 0.9 and not (sqrdst < self.HealRangeSqrMin) then continue end
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
	if sqrdst > (self.HealRangeSqr*1.5) or (not (sqrdst < self.HealRangeSqrMin) and ((centre - mypos):GetNormalized():Dot(owner:GetAimVector()) < 0.75 or not WorldVisible(mypos,centre))) then return false end

	return true
end

SWEP.NextEmit = 0
function SWEP:Think()
	local curtgt = self:GetCurrentTarget()
	local owner = self:GetOwner()
	if not (curtgt and curtgt:IsValid()) then
		self:StopSound("Loop_Palliator_Heal")
		self:StopSound("Loop_Palliator_Heal2")
		if CurTime() > self.LastUpdate + 0.05 then
			self:SetCurrentLookTarget(self:GetClosestTarget())
			self.LastUpdate = CurTime()
		end
	elseif curtgt:IsPlayer() then
		if not self:CheckValidTarget(curtgt) or self:Ammo1() <= 0 then 
			self:SecondaryAttack() 
		else
			self:EmitSound("Loop_Palliator_Heal")
			self:EmitSound("Loop_Palliator_Heal2")
			local sameteam = curtgt:Team() == owner:Team()
			if self.NextEmit <= CurTime() then
				local effectdata = EffectData()
					effectdata:SetOrigin(curtgt:WorldSpaceCenter())
					effectdata:SetFlags(sameteam and 1 or 0)
					effectdata:SetEntity(self)
					effectdata:SetAttachment(1)
				util.Effect("tracer_healray", effectdata)
				self.NextEmit = CurTime() + 0.1
			end
			if self:GetLastHealTime() + self.Primary.Delay <= CurTime() then
				if SERVER then
					local magnitude = math.min(self.Primary.Damage,self:Ammo1())
					if sameteam then
						local boost = curtgt:GetStatus("healdartboost")
						if !(boost and boost:IsValid()) then
							boost = curtgt:GiveStatus("healdartboost")
							boost.DieTime = CurTime() + 1
						end
						if curtgt:Health() >= curtgt:GetMaxHealth() then
							magnitude = 0
						end
						curtgt:HealHealth(magnitude,owner,self)
					else
						local invuln = curtgt:GetStatus("spawnbuff")
						if not (invuln and invuln:IsValid()) then
							curtgt:TakeSpecialDamage(magnitude, DMG_NERVEGAS, owner, self)
							curtgt:AddLegDamage(magnitude*2)
						else
							magnitude = 0
						end
					end
					owner:RemoveAmmo(magnitude, self:GetPrimaryAmmoType(), false)
				end	
				self:SetLastHealTime(CurTime())
			end
		end
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

function SWEP:Deploy()
	if self.BaseClass.Deploy then
		self.BaseClass.Deploy(self)
	end
	self:SetCurrentTarget(nil)
	self:SetLastHealTime(0)
    return true
end

function SWEP:OnRemove()
	self:StopSound( "Loop_Palliator_Heal" )
	self:StopSound( "Loop_Palliator_Heal2" )
end

function SWEP:Holster()
	self:SetCurrentTarget(nil)
    self:StopSound( "Loop_Palliator_Heal" )
	self:StopSound( "Loop_Palliator_Heal2" )
	return self.BaseClass.Holster(self)
end


if CLIENT then
	function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
		pos, ang = self.BaseClass.CalcViewModelView(self, vm, oldpos, oldang, pos, ang)
		return pos + ((self:GetCurrentTarget() and self:GetCurrentTarget():IsValid() and self:GetCurrentTarget():IsPlayer()) and VectorRand(-0.15,0.25) or Vector(0,0,0)),ang
	end
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
		if not (self:GetCurrentTarget() and self:GetCurrentTarget():IsValid()) then
			local ent = self:GetCurrentLookTarget()
			if ent:IsPlayer() and ent:IsValid() and ent:Alive()then
				local sameteam = (ent:Team() == MySelf:Team())
				local x1,y1,x2,y2 = self:GetEntScreenCoords(ent)
				surface.SetDrawColor(sameteam and COLOR_DARKGREEN or COLOR_DARKRED)
				surface.DrawOutlinedRect(x1, y1, x2-x1, y2-y1, 6)
			end
		else
			if self:GetCurrentTarget():IsPlayer() and self:GetCurrentTarget():Alive() then
				local sameteam = (self:GetCurrentTarget():Team() == MySelf:Team())
				local screenscale = BetterScreenScale()
				surface.SetFont("ZSHUDFontSmall")
				local translatestring = sameteam and "weapon_palliator_healing_x" or "weapon_palliator_attacking_x"
				local text = translate.Format(translatestring,self:GetCurrentTarget():Name())
				local _, nTEXH = surface.GetTextSize(text)
				draw.SimpleText(text, "ZSHUDFontSmall", ScrW() - 218 * screenscale, ScrH() - nTEXH * 6, sameteam and COLOR_DARKGREEN or COLOR_DARKRED, TEXT_ALIGN_CENTER)
			end
		end
		if self.BaseClass.DrawHUD then
			self.BaseClass.DrawHUD(self)
		end
	end    
end