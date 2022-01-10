AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_positron_name"
	SWEP.TranslateDesc = "weapon_positron_desc"
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
SWEP.ShowWorldModel = false

SWEP.ReloadSound = ""
SWEP.Primary.Sound = ""
SWEP.Primary.Damage = 20
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.045

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 250
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"

SWEP.ConeMax = 0
SWEP.ConeMin = 0
SWEP.NoAmmo = false
SWEP.Recoil = 0.075

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.IronSightsPos = Vector(-6.6, 20, 3.1)
SWEP.NextHurt = 0
SWEP.NextEffect = 0
SWEP.StartPos = nil
SWEP.EndPos = nil

SWEP.HasNoClip = true
SWEP.LowAmmoThreshold = 150

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
	self:NetworkVar("Entity", 4, "LastHurtTarget")
	self:NetworkVar("Int", 4, "LastHurtDmg")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end
function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:RemoveAmmo((self:GetLastHurtDmg() >= 15 and 3 or 1), self.Primary.Ammo, false)
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
    if self.Owner:KeyReleased(IN_ATTACK) or not self.Owner:Alive() or self.Owner:Health() <= 0 then
		self:StopSound( "Loop_Lepton_Fire" )
		self:StopSound( "Loop_Lepton_Fire2" )
		self:EmitSound("weapons/physcannon/physcannon_claws_close.wav")
		self:SetFiringLaser( false )
		self:SetLastHurtTarget(nil)
		self:SetLastHurtDmg(0)
    end
    if self.Owner:KeyDown(IN_ATTACK) then
		if 0 >= self.Owner:GetAmmoCount(self.Primary.Ammo) or self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() then 
			self:SetFiringLaser( false )
			self:StopSound( "Loop_Lepton_Fire" )
			self:StopSound( "Loop_Lepton_Fire2" )
			self:SetLastHurtTarget(nil)
			self:SetLastHurtDmg(0)
		return end
        if not self:GetFiringLaser() then
			self:SetFiringLaser(true)
        end
		self:EmitSound( "Loop_Lepton_Fire" )
		self:EmitSound( "Loop_Lepton_Fire2" )
		local td = {}
	
		td.start = self.Owner:EyePos()
		td.mask = MASK_SHOT
		td.filter = {}
		table.Add(td.filter, team.GetPlayers( self.Owner:Team()))
		td.endpos = td.start + self.Weapon.Owner:EyeAngles():Forward()*10000
		table.Add(td.filter, {self})
		self.Owner:LagCompensation(true)
		local tr = util.TraceLine(td)
		self.Owner:LagCompensation(false)
		self.EndPos = tr.HitPos
        if tr.Hit then
			self.EndPos = tr.HitPos
			local ent = tr.Entity
			if CurTime() >= self.NextHurt then
				if not tr.HitSky then
					if CurTime() >= self.NextEffect then
						local e = EffectData()
							e:SetOrigin(tr.HitPos)
							e:SetNormal(tr.HitNormal)
							e:SetRadius(8)
							e:SetMagnitude(1)
							e:SetScale(1)
						util.Effect("cball_bounce", e)
						self.NextEffect = CurTime()+self.Primary.Delay*1.5
					end
					util.Decal( "FadingScorch", tr.HitPos+tr.HitNormal, tr.HitPos-tr.HitNormal)
				end
				if ent:IsValid() then
					local dmg = 3
					if self:GetLastHurtTarget() == ent then
						dmg = math.min(self:GetLastHurtDmg()+3,self.Primary.Damage*3)
					else
						self:SetLastHurtTarget(ent)
						dmg = math.max(self:GetLastHurtDmg()-15,3)
					end
					self:SetLastHurtDmg(dmg)
					local owner = self:GetOwner()
					if ent:IsPlayer() then
						if ent:Team() == owner:Team() then return end
						ent:TakeSpecialDamage(math.floor(dmg/3), DMG_DISSOLVE, owner, self, tr.HitPos)
					elseif (ent.IsBarricadeObject or ent:IsNailed()) and not ent:IsSameTeam(owner)  then
						ent:TakeSpecialDamage(dmg, DMG_DISSOLVE, owner, self, tr.HitPos)
					else
						ent:TakeSpecialDamage(math.floor(dmg/3), DMG_DISSOLVE, owner, self, tr.HitPos)
					end
				else
					local dmg = math.max(self:GetLastHurtDmg()-15,3)
					self:SetLastHurtTarget(nil)
					self:SetLastHurtDmg(dmg)
				end
				self.NextHurt = CurTime()+self.Primary.Delay
			end
		end
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

function SWEP:Deploy()
    self:SetFiringLaser(false)
	self:SetLastHurtTarget(nil)
	self:SetLastHurtDmg(0)
    return self.BaseClass.Deploy(self)
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
	return self.BaseClass.Holster(self)
end

function SWEP:ShootEffects()
    self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

if(CLIENT)then
function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
	pos, ang = self.BaseClass.CalcViewModelView(self, vm, oldpos, oldang, pos, ang)
	return pos + (self:GetFiringLaser() and VectorRand(-0.25,0.25) or Vector(0,0,0)),ang
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
	local beamwide = 0.2 + 0.8*math.Clamp(self:GetLastHurtDmg()/self.Primary.Damage,0,1)
    --self.Weapon:SetRenderBoundsWS( self.StartPos, self.EndPos )
	local Beamspeed = (self.EndPos - self.StartPos):Length()/100
	render.SetMaterial(Material("Effects/ar2_altfire1"))
	render.DrawSprite( self.EndPos, 8, 8, Color(125,125,225,255))
		--if((self.EndPos - self.StartPos):Length() >= 60) then self.EndPos = self.Weapon.Owner:EyePos() + self.Weapon.Owner:EyeAngles():Forward()*100 end
	render.SetMaterial( Material("cable/physbeam") )  
	render.DrawBeam( self.StartPos, self.EndPos, 20*beamwide, CurTime()*Beamspeed, CurTime()*Beamspeed-1, Color( 255, 255, 255, 255 ) )
	render.SetMaterial( Material("cable/hydra") )  
	render.DrawBeam( self.StartPos, self.EndPos, 35*beamwide, CurTime()*Beamspeed, CurTime()*Beamspeed-5, Color( 255, 255, 255, 255 ) )
end
end
