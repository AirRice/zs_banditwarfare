AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "spawn"
	SWEP.Description = "spawn 위치를 표시한다."

	SWEP.ViewModelFOV = 70

	SWEP.Slot = 4

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
end

SWEP.ViewModel = "models/weapons/cstrike/c_c4.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ModelScale = 0.5
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.HoldType = "slam"

SWEP.hspawns = {}
SWEP.bspawns = {}
SWEP.NextPrimary = 0
SWEP.NextSecondary = 0
SWEP.NextReload = 0
function SWEP:PrimaryAttack()
	if self.NextPrimary > CurTime() then return end
	if SERVER then
		print("Person Position is: ")
		print(self:GetOwner():GetPos())
	end
	self.NextPrimary = CurTime() + 1
end

function SWEP:SecondaryAttack()
	if self.NextSecondary > CurTime() then return end
	if SERVER then
		if self:GetOwner() and self:GetOwner():IsPlayer() and self:GetOwner():Team() == TEAM_BANDIT then
			self:GetOwner():ChangeTeam(TEAM_HUMAN)
		else
			self:GetOwner():ChangeTeam(TEAM_BANDIT)
		end
		
	end
	self.NextSecondary = CurTime() + 1
end

function SWEP:Reload()
	if self.NextReload > CurTime() then return end
	self.hspawns = team.GetValidSpawnPoint(4)
	self.bspawns = team.GetValidSpawnPoint(3)
	PrintTable(self.hspawns)
	PrintTable(self.bspawns)
	print("Bandit spawns:")
	for _, ent in pairs(self.bspawns) do
		--self:DrawTarget(ent,32,0,team.GetColor(3))
		print(ent:GetPos())
	end
	print("Human spawns:")
	for _, ent in pairs(self.hspawns) do
		--self:DrawTarget(ent,32,0,team.GetColor(4))
		print(ent:GetPos())
	end
	self.NextReload = CurTime() + 1
end

if not CLIENT then return end
function SWEP:DrawHUD()

end

local texScope = Material("vgui/hud/autoaim")
function SWEP:DrawTarget(tgt, size, offset, color)
	local scrpos = tgt:GetPos():ToScreen()
	scrpos.x = math.Clamp(scrpos.x, size, ScrW() - size)
	scrpos.y = math.Clamp(scrpos.y, size, ScrH() - size)
	surface.SetDrawColor(color)
	surface.DrawRect( scrpos.x - size, scrpos.y - size, size * 2, size * 2 )
end