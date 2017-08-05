local PANEL = {}

PANEL.RefreshTime = 2
PANEL.NextRefresh = 0
PANEL.m_MaximumScroll = 0

local function emptypaint(self)
	return true
end

function PANEL:Init()
	self.NextRefresh = RealTime() + 0.1

	local Frame = vgui.Create( "Frame" ); //Create a frame
    Frame:SetSize( 200, 200 ); //Set the size to 200x200
    Frame:SetPos( 100, 100 ); //Move the frame to 100,100
    Frame:SetVisible( true );  //Visible
    Frame:MakePopup( ); //Make the frame
    Frame:PostMessage( "SetTitle", "text", "This is the title" ); //Set the title to "This is the title"   
 
    local Button = vgui.Create( "Button", Frame ); //Create a button that is attached to Frame
    Button:SetText( "Click me!" ); //Set the button's text to "Click me!"
    Button:SetPos( 30, 5 ); //Set the button's position relative to it's parent(Frame)
    Button:SetWide( 100 ); //Sets the width of the button you're making
    function Button:DoClick( ) //This is called when the button is clicked
        self:SetText( "Clicked" ); //Set the text to "Clicked"
    end
end

function PANEL:PerformLayout()
	self.m_AuthorLabel:MoveBelow(self.m_TitleLabel)
	self.m_ContactLabel:MoveBelow(self.m_AuthorLabel)

	self.m_ServerNameLabel:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel:GetWide(), self:GetWide() * 0.75 - self.m_ServerNameLabel:GetWide() * 0.5), 32 - self.m_ServerNameLabel:GetTall() / 2)

	self.m_HumanHeading:SetSize(self:GetWide() / 2 - 32, 28)
	self.m_HumanHeading:SetPos(self:GetWide() * 0.25 - self.m_HumanHeading:GetWide() * 0.5, 110 - self.m_HumanHeading:GetTall())

	self.m_ZombieHeading:SetSize(self:GetWide() / 2 - 32, 28)
	self.m_ZombieHeading:SetPos(self:GetWide() * 0.75 - self.m_ZombieHeading:GetWide() * 0.5, 110 - self.m_ZombieHeading:GetTall())

	self.HumanList:SetSize(self:GetWide() / 2 - 24, self:GetTall() - 150)
	self.HumanList:AlignBottom(16)
	self.HumanList:AlignLeft(8)

	self.BanditList:SetSize(self:GetWide() / 2 - 24, self:GetTall() - 150)
	self.BanditList:AlignBottom(16)
	self.BanditList:AlignRight(8)
	local screenscale = BetterScreenScale()

	self:SetSize(screenscale * 350, screenscale * 128)
	self:AlignLeft(screenscale * 24)
	self:AlignBottom(screenscale * 24)
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:Refresh()
	end
end

function PANEL:Refresh()
	self.m_ServerNameLabel:SetText(GetHostName())
	self.m_ServerNameLabel:SizeToContents()
	self.m_ServerNameLabel:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel:GetWide(), self:GetWide() * 0.75 - self.m_ServerNameLabel:GetWide() * 0.5), 32 - self.m_ServerNameLabel:GetTall() / 2)
end

vgui.Register("ZSTeamScores", PANEL, "Panel")