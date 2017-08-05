AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'포지트론' 양전자포"
	SWEP.Description = "거의 모든 것을 분해시키는 양전 입자를 방출한다."
	SWEP.Slot = 2
	SWEP.SlotPos = 0
	SWEP.ViewModelFOV = 50
	SWEP.HUD3DBone = "Base"
	SWEP.HUD3DPos = Vector(7.791, -2.597, -7.792)
	SWEP.HUD3DScale = 0.04
	SWEP.VElements = {
	["BackPropeller"] = { type = "Model", model = "models/gibs/gunship_gibs_engine.mdl", bone = "Base", rel = "Mid", pos = Vector(-0.685, -4.422, -4.726), angle = Angle(0, -90, 0), size = Vector(0.232, 0.186, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Mid"] = { type = "Model", model = "models/props_wasteland/cargo_container01.mdl", bone = "Base", rel = "", pos = Vector(0, 1.205, 5.834), angle = Angle(0, 0, -90), size = Vector(0.048, 0.068, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Top+"] = { type = "Model", model = "models/props_combine/combine_bunker01.mdl", bone = "Base", rel = "Mid", pos = Vector(2.051, 2.29, 0.319), angle = Angle(-90, 0, 0), size = Vector(0.019, 0.061, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["HandleBar"] = { type = "Model", model = "models/props_wasteland/buoy01.mdl", bone = "Base", rel = "Mid", pos = Vector(5.456, -11.278, -2.362), angle = Angle(-99.245, 9.232, 0.028), size = Vector(0.081, 0.081, 0.136), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["BackWheelCover+"] = { type = "Model", model = "models/maxofs2d/thruster_propeller.mdl", bone = "Base", rel = "Mid", pos = Vector(0, -16, 0), angle = Angle(90, 0, 0), size = Vector(0.574, 0.574, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["BackWheelCover"] = { type = "Model", model = "models/maxofs2d/thruster_propeller.mdl", bone = "Base", rel = "Mid", pos = Vector(0, -16, 0), angle = Angle(-90, 0, 0), size = Vector(0.574, 0.574, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Top++"] = { type = "Model", model = "models/props_combine/combine_bunker01.mdl", bone = "Base", rel = "Mid", pos = Vector(-1.558, 3.878, 0.326), angle = Angle(90, 0, 0), size = Vector(0.019, 0.061, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Nozzle"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "Base", rel = "Mid", pos = Vector(0, 14.06, -1.191), angle = Angle(0, 0, 90), size = Vector(0.152, 0.152, 0.152), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Top"] = { type = "Model", model = "models/props_combine/combine_bunker01.mdl", bone = "Base", rel = "Mid", pos = Vector(0, 1.799, -0.778), angle = Angle(0, 0, 0), size = Vector(0.028, 0.054, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["BackPropeller"] = { type = "Model", model = "models/gibs/gunship_gibs_engine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mid", pos = Vector(0.37, 3.392, -2.553), angle = Angle(0, -90, 0), size = Vector(0.158, 0.134, 0.158), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Mid"] = { type = "Model", model = "models/props_wasteland/cargo_container01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.444, -0.732, -5.625), angle = Angle(-17.386, -77.86, 178.085), size = Vector(0.048, 0.045, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Top+"] = { type = "Model", model = "models/props_combine/combine_bunker01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mid", pos = Vector(0, 1.799, -0.778), angle = Angle(0, 0, 0), size = Vector(0.028, 0.054, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["HandleBar"] = { type = "Model", model = "models/props_wasteland/buoy01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mid", pos = Vector(-1.223, -8.818, -3.636), angle = Angle(149.216, 10.579, 1.753), size = Vector(0.03, 0.03, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["BackWheelCover+"] = { type = "Model", model = "models/maxofs2d/thruster_propeller.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mid", pos = Vector(0, -10, 0), angle = Angle(90, 0, 0), size = Vector(0.574, 0.574, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["HandleBar+"] = { type = "Model", model = "models/props_wasteland/buoy01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mid", pos = Vector(6.059, -3.583, -2.395), angle = Angle(-99.245, 9.232, 0.028), size = Vector(0.081, 0.081, 0.136), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["BackWheelCover"] = { type = "Model", model = "models/maxofs2d/thruster_propeller.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mid", pos = Vector(0, -10, 0), angle = Angle(-90, 0, 0), size = Vector(0.574, 0.574, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Top++"] = { type = "Model", model = "models/props_combine/combine_bunker01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mid", pos = Vector(0.742, 1.633, 0.103), angle = Angle(-90, 0, 0), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Nozzle"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mid", pos = Vector(-0.239, 8.647, -0.64), angle = Angle(0, 0, 90), size = Vector(0.114, 0.114, 0.114), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Top"] = { type = "Model", model = "models/props_combine/combine_bunker01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mid", pos = Vector(-0.641, 1.633, 0.481), angle = Angle(90, 0, 0), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "physgun"

SWEP.ViewModel = Model( "models/weapons/c_physcannon.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_physics.mdl" )
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = true

SWEP.ReloadSound = ""
SWEP.Primary.Sound = ""
SWEP.Primary.Damage = 9
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.04

SWEP.Primary.ClipSize = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0
SWEP.ConeMin = 0
SWEP.NoAmmo = false
SWEP.Recoil = 0.15

SWEP.WalkSpeed = SPEED_SLOW

SWEP.IronSightsPos = Vector(-6.6, 20, 3.1)
SWEP.NextHurt = 0
SWEP.StartPos = nil
SWEP.EndPos = nil
sound.Add( {
	name = "Loop_Lepton_Fire",
	channel = CHAN_VOICE,
	volume = 1,
	level = 75,
	pitch = 90,
	volume = 1,
	sound = "ambient/energy/force_field_loop1.wav"
} )
sound.Add( {
	name = "Loop_Lepton_Fire2",
	channel = CHAN_VOICE2,
	volume = 1,
	level = 75,
	pitch = 90,
	volume = 1,
	sound = "npc/stalker/laser_burn.wav"
} )

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 5, "FiringLaser")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end
function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:RemoveAmmo(2, self.Primary.Ammo, false)
	if (!IsValid(self.Owner)) then
		return
	end
	local recoil = self.Recoil
	if SERVER then
		--self.Owner:ViewPunch(Angle(math.Rand(-recoil * 3, 0), 0, 0))
	else
		local curAng = self.Owner:EyeAngles()
		curAng.pitch = curAng.pitch - math.Rand(recoil * 3, 0)
		curAng.yaw = curAng.yaw + math.Rand(-recoil*1.5, recoil*1.5)
		curAng.Roll = 0
		self.Owner:SetEyeAngles(curAng)
	end
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() then return false end
	if 0 >= self.Owner:GetAmmoCount(self.Primary.Ammo) then
		self:EmitSound("buttons/combine_button_locked.wav")
		self:SetNextPrimaryFire(CurTime() + 0.5)
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end


function SWEP:Think()
    if self.Owner:KeyReleased(IN_ATTACK) or self.Owner:Health() <= 0 or not self.Owner:Alive() then
		self:StopSound( "Loop_Lepton_Fire" )
		self:StopSound( "Loop_Lepton_Fire2" )
		self:EmitSound("weapons/physcannon/physcannon_claws_close.wav")
		self:SetFiringLaser( false )
    end
    if self.Owner:KeyDown(IN_ATTACK) then
		if 0 >= self.Owner:GetAmmoCount(self.Primary.Ammo) then 
			self:SetFiringLaser( false )
			self:StopSound( "Loop_Lepton_Fire" )
			self:StopSound( "Loop_Lepton_Fire2" )
		return end
        if not self:GetFiringLaser() then
            self:EmitSound( "Loop_Lepton_Fire" )
			self:EmitSound( "Loop_Lepton_Fire2" )
			self:SetFiringLaser(true)
        end
		
		local td = {}
	
		td.start = self.Owner:EyePos()
		td.mask = MASK_SHOT
		td.filter = {}
		table.Add(td.filter, team.GetPlayers( self.Owner:Team()))
		td.endpos = td.start + self.Weapon.Owner:EyeAngles():Forward()*10000
		table.Add(td.filter, {self})
		local tr = util.TraceLine(td)
		self.EndPos = tr.HitPos
        if tr.Hit then
			self.EndPos = tr.HitPos
			local ent = tr.Entity
			if CurTime() >= self.NextHurt then
				if not tr.HitSky then
					local e = EffectData()
						e:SetOrigin(tr.HitPos)
						e:SetNormal(tr.HitNormal)
						e:SetRadius(8)
						e:SetMagnitude(1)
						e:SetScale(1)
					util.Effect("cball_bounce", e)
					util.Decal( "FadingScorch", tr.HitPos+tr.HitNormal, tr.HitPos-tr.HitNormal)
				end
				if ent:IsValid() then
					local owner = self:GetOwner()
					if ent:IsPlayer() then
						if ent:Team() == owner:Team() then return end
						ent:TakeSpecialDamage(self.Primary.Damage, DMG_DISSOLVE, owner, self)
					elseif (ent.IsBarricadeObject or ent:IsNailed()) and not ent:IsSameTeam(owner)  then
						ent:TakeSpecialDamage(self.Primary.Damage*2.5, DMG_DISSOLVE, owner, self)
					else
						ent:TakeSpecialDamage(self.Primary.Damage, DMG_DISSOLVE, owner, self)
					end
					self.NextHurt = CurTime()+self.Primary.Delay
				end
			end
		end
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

function SWEP:Deploy()
    self:SetFiringLaser(false)
    return true
end

function SWEP:SecondaryAttack()
end
function SWEP:OnRemove()
	self:StopSound( "Loop_Lepton_Fire" )
	self:StopSound( "Loop_Lepton_Fire2" )
	self:SetFiringLaser( false )
end
function SWEP:Holster()
    self:StopSound( "Loop_Lepton_Fire" )
	self:StopSound( "Loop_Lepton_Fire2" )
	if self:ValidPrimaryAmmo() then
		self.PreHolsterClip1 = self:Clip1()
	end
	if self:ValidSecondaryAmmo() then
		self.PreHolsterClip2 = self:Clip2()
	end

	if CLIENT then
		self:Anim_Holster()
	end

	return true
end

function SWEP:ShootEffects()
    self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

if(CLIENT)then
local colBG = Color(16, 16, 16, 90)
local colRed = Color(220, 0, 0, 230)
local colYellow = Color(220, 220, 0, 230)
local colWhite = Color(220, 220, 220, 230)
local colAmmo = Color(255, 255, 255, 230)
function SWEP:Draw3DHUD(vm, pos, ang)
	local wid, hei = 180, 100
	local x, y = wid * -0.6, hei * -0.6
	local clip = self:Clip1()
	local spare = self.Owner:GetAmmoCount(self:GetPrimaryAmmoType())
	local maxclip = self.Primary.ClipSize

	if self.RequiredClip ~= 1 then
		clip = math.floor(clip / self.RequiredClip)
		spare = math.floor(spare / self.RequiredClip)
		maxclip = math.ceil(maxclip / self.RequiredClip)
	end

	cam.Start3D2D(pos, ang, self.HUD3DScale / 2)
		draw.RoundedBoxEx(32, x, y, wid, hei, colBG, true, false, true, false)
		draw.SimpleTextBlurry(spare, spare >= 1000 and "ZS3D2DFontSmall" or "ZS3D2DFont", x + wid * 0.5, y + hei * 0.5, spare == 0 and colRed or spare <= 200 and colYellow or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

function SWEP:Draw2DHUD()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72
	local spare = self.Owner:GetAmmoCount(self:GetPrimaryAmmoType())

	draw.RoundedBox(16, x, y, wid, hei, colBG)
	draw.SimpleTextBlurry(spare, spare >= 1000 and "ZSHUDFontBig" or "ZSHUDFont", x + wid * 0.5, y + hei * 0.5, spare == 0 and colRed or spare <= 200 and colYellow or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end
function SWEP:ViewModelDrawn()
	self:Anim_ViewModelDrawn()
	if self:GetFiringLaser() then
		self:DrawLaser()
	end
	
end

function SWEP:DrawWorldModel()
	local owner = self:GetOwner()
	if owner:IsValid() and owner.ShadowMan then return end
	self:Anim_DrawWorldModel()
	if self:GetFiringLaser() then
		self:DrawLaser()
	end
end
SWEP.DrawWorldModelTranslucent = SWEP.DrawWorldModel

function SWEP:GetMuzzlePos( weapon, attachment )
    if(!IsValid(weapon)) then return end
    local origin = weapon:GetPos()
    local angle = weapon:GetAngles()
    if weapon:IsWeapon() and weapon:IsCarriedByLocalPlayer() then
        if( IsValid( weapon:GetOwner() ) && GetViewEntity() == weapon:GetOwner() ) then
            local viewmodel = weapon:GetOwner():GetViewModel()
            if( IsValid( viewmodel ) ) then
                weapon = viewmodel
            end
        end
    end
    local attachment = weapon:GetAttachment( attachment or 1 )
    if( !attachment ) then
        return origin, angle
    end
    return attachment.Pos, attachment.Ang
end


function SWEP:DrawLaser() 
	if self.Owner ~= LocalPlayer() then
	local td = {}
		td.start = self.Weapon.Owner:EyePos()
		td.mask = MASK_SHOT
		td.filter = {}
		table.Add(td.filter, {self.Weapon.Owner})
		table.Add(td.filter, {self.Weapon.Owner:GetActiveWeapon()})
		table.Add(td.filter, team.GetPlayers(self.Weapon.Owner:Team()))
		td.endpos = td.start + self.Weapon.Owner:EyeAngles():Forward()*10000
		table.Add(td.filter, {self})
	local tr = util.TraceLine(td)
	if tr.Hit then self.EndPos = tr.HitPos end
	end
    self.StartPos = self:GetMuzzlePos( self, 1 )
    if not self.StartPos then return end
    if not self.EndPos then return end

    --self.Weapon:SetRenderBoundsWS( self.StartPos, self.EndPos )
	local Beamspeed = (self.EndPos - self.StartPos):Length()/100
	render.SetMaterial(Material("Effects/ar2_altfire1"))
	render.DrawSprite( self.EndPos, 8, 8, Color(125,125,225,255))
		--if((self.EndPos - self.StartPos):Length() >= 60) then self.EndPos = self.Weapon.Owner:EyePos() + self.Weapon.Owner:EyeAngles():Forward()*100 end
	render.SetMaterial( Material("cable/physbeam") )  
	render.DrawBeam( self.StartPos, self.EndPos, 20, CurTime()*Beamspeed, CurTime()*Beamspeed-1, Color( 255, 255, 255, 255 ) )
	render.SetMaterial( Material("cable/hydra") )  
	render.DrawBeam( self.StartPos, self.EndPos, 35, CurTime()*Beamspeed, CurTime()*Beamspeed-5, Color( 255, 255, 255, 255 ) )
end
end
