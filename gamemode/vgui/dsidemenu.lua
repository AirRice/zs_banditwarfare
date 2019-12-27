local PANEL = {}

PANEL.Spacing = 8

function PANEL:Init()
	self:RefreshSize()
	self:SetPos(ScrW() - 1, 0)

	self.Items = {}
end


function PANEL:RefreshSize()
	self:SetSize(BetterScreenScale() * 256, ScrH())
end

function PANEL:OpenMenu()

	self:RefreshSize()
	self:SetPos(ScrW() - self:GetWide(), 0, 0, 0, 0)
	self:SetVisible(true)
	self:MakePopup()
	self.StartChecking = RealTime() + 0.1

	timer.Simple(0, function() gui.SetMousePos(ScrW() - self:GetWide() * 0.5, ScrH() * 0.5) end)
end

function PANEL:CloseMenu()
	self:SetVisible(false)
end

local texRightEdge = surface.GetTextureID("gui/gradient")
function PANEL:Paint()
	surface.SetDrawColor(5, 5, 5, 180)
	surface.DrawRect(self:GetWide() * 0.4, 0, self:GetWide() * 0.6, self:GetTall())
	surface.SetTexture(texRightEdge)
	surface.DrawTexturedRectRotated(self:GetWide() * 0.2, self:GetTall() * 0.5, self:GetWide() * 0.4, self:GetTall(), 180)
end

function PANEL:AddItem(item)
	item:SetParent(self)
	item:SetWide(self:GetWide() - 16)

	table.insert(self.Items, item)

	self:InvalidateLayout()
end

function PANEL:RemoveItem(item)
	for k, v in ipairs(self.Items) do
		if v == item then
			item:Remove()
			table.remove(self.Items, k)
			self:InvalidateLayout()
			break
		end
	end
end

function PANEL:PerformLayout()
	local y = ScrH() * 0.5
	for k, item in pairs(self.Items) do
		if item and item:Valid() then
			y = y - (item:GetTall() + self.Spacing) * 0.5
		end
	end

	for k, item in ipairs(self.Items) do
		if item and item:Valid() then
			item:SetPos(0, y)
			item:CenterHorizontal()
			y = y + item:GetTall() + self.Spacing
		end
	end
end

vgui.Register("DSideMenu", PANEL, "DPanel")
