local PANEL = {}

function PANEL:Init()
	self:SetContentAlignment( 4 )

	self:SetPaintBackground( true )

	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( true )

	self:SetCursor( "hand" )
	self:SetFont( "ZSHUDFontSmallest" )

    self:SizeToContentsY(8)
end

function PANEL:Paint(w, h) 
	local outlinecol
	if self:GetDisabled() then
		outlinecol = Color(5, 5, 5, 90)
	elseif self.Depressed or self:IsMenuOpen() then
		outlinecol = COLOR_LIMEGREEN
	elseif self.Hovered then
		outlinecol = COLOR_DARKGREEN
	else
		outlinecol = COLOR_DARKGRAY
	end

	local edgesize = math.min(math.ceil(w * 0.2), 24)
	draw.RoundedBox(edgesize/2, 0, 0, w , h, outlinecol)
	draw.RoundedBox(edgesize/4, 3, 3, w-6 , h-6, color_black)
end

vgui.Register( "DComboBoxEx", PANEL, "DComboBox" )