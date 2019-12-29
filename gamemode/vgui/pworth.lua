hook.Add("SetWave", "CloseWorthOnWave1", function(wave)
	if wave > 0 then
		if pWorth and pWorth:Valid() then
			pWorth:Close()
		end

		hook.Remove("SetWave", "CloseWorthOnWave1")
	end
end)

local cvarDefaultCart = CreateClientConVar("zsb_defaultcart", "", true, false)

local function DefaultDoClick(btn)
	if cvarDefaultCart:GetString() == btn.Name then
		RunConsoleCommand("zsb_defaultcart", "")
		surface.PlaySound("buttons/button11.wav")
	else
		RunConsoleCommand("zsb_defaultcart", btn.Name)
		surface.PlaySound("buttons/button14.wav")
	end

	timer.Simple(0.1, MakepWorth)
end

local WorthRemaining = 0
local WorthButtons = {}
local function CartDoClick(self, silent, force)
	local id = self.ID
	local tab = FindStartingItem(id)
	if not tab then return end

	if self.On then
		self.On = nil
		self:SetImage("icon16/cart_add.png")
		if not silent then
			surface.PlaySound("buttons/button18.wav")
		end
		self:SetTooltip("목록에 추가")
		WorthRemaining = WorthRemaining + tab.Worth
	else
		if WorthRemaining < tab.Worth and not force then
			surface.PlaySound("buttons/button8.wav")
			return
		end
		self.On = true
		self:SetImage("icon16/cart_delete.png")
		if not silent then
			surface.PlaySound("buttons/button17.wav")
		end
		self:SetTooltip("목록에서 제거")
		WorthRemaining = WorthRemaining - tab.Worth
	end

	pWorth.WorthLab:SetText("시작 자금: ".. WorthRemaining)
	if WorthRemaining <= 0 then
		pWorth.WorthLab:SetTextColor(COLOR_RED)
	elseif WorthRemaining <= GAMEMODE.StartingWorth * 0.25 then
		pWorth.WorthLab:SetTextColor(COLOR_YELLOW)
	else
		pWorth.WorthLab:SetTextColor(COLOR_LIMEGREEN)
	end
	pWorth.WorthLab:SizeToContents()
end

local function Checkout(tobuy)
	if tobuy and #tobuy > 0 then
		gamemode.Call("SuppressArsenalUpgrades", 1)

		RunConsoleCommand("worthcheckout", unpack(tobuy))

		if pWorth and pWorth:Valid() then
			pWorth:Close()
		end
	else
		surface.PlaySound("buttons/combine_button_locked.wav")
	end
end

local function CheckoutDoClick(self)
	local tobuy = {}
	for _, btn in pairs(WorthButtons) do
		if btn and btn.On and btn.ID then
			table.insert(tobuy, btn.ID)
		end
	end

	Checkout(tobuy)
end

local function RandDoClick(self)
	gamemode.Call("SuppressArsenalUpgrades", 1)

	RunConsoleCommand("worthrandom")

	if pWorth and pWorth:Valid() then
		pWorth:Close()
	end
end

GM.SavedCarts = {}
hook.Add("Initialize", "LoadCarts", function()
	if file.Exists(GAMEMODE.CartFile, "DATA") then
		GAMEMODE.SavedCarts = Deserialize(file.Read(GAMEMODE.CartFile)) or {}
	end
end)

local function helpDoClick()
	MakepHelp()
end

local function ClearCartDoClick()
	for _, btn in ipairs(WorthButtons) do
		if btn.On then
			btn:DoClick(true, true)
		end
	end

	surface.PlaySound("buttons/button11.wav")
end

local function LoadCart(cartid, silent)
	if GAMEMODE.SavedCarts[cartid] then
		MakepWorth()
		for _, id in pairs(GAMEMODE.SavedCarts[cartid][2]) do
			for __, btn in pairs(WorthButtons) do
				if btn and (btn.ID == id or GAMEMODE.Items[id] and GAMEMODE.Items[id].Signature == btn.ID) then
					btn:DoClick(true, true)
				end
			end
		end
		if not silent then
			surface.PlaySound("buttons/combine_button1.wav")
		end
	end
end

local function LoadDoClick(self)
	LoadCart(self.ID)
end

local function SaveCurrentCart(name)
	local tobuy = {}
	for _, btn in pairs(WorthButtons) do
		if btn and btn.On and btn.ID then
			table.insert(tobuy, btn.ID)
		end
	end
	for i, cart in ipairs(GAMEMODE.SavedCarts) do
		if string.lower(cart[1]) == string.lower(name) then
			cart[1] = name
			cart[2] = tobuy

			file.Write(GAMEMODE.CartFile, Serialize(GAMEMODE.SavedCarts))
			print("Saved cart "..tostring(name))

			LoadCart(i, true)
			return
		end
	end

	GAMEMODE.SavedCarts[#GAMEMODE.SavedCarts + 1] = {name, tobuy}

	file.Write(GAMEMODE.CartFile, Serialize(GAMEMODE.SavedCarts))
	print("Saved cart "..tostring(name))

	LoadCart(#GAMEMODE.SavedCarts, true)
end

local function SaveDoClick(self)
	Derma_StringRequest("목록 저장", "현재 구매 목록을 저장하려면 저장할 목록의 이름을 적어주세요.", "이름", 
	function(strTextOut) SaveCurrentCart(strTextOut) end,
	function(strTextOut) end,
	"승낙", "취소")
end

local function DeleteDoClick(self)
	if GAMEMODE.SavedCarts[self.ID] then
		table.remove(GAMEMODE.SavedCarts, self.ID)
		file.Write(GAMEMODE.CartFile, Serialize(GAMEMODE.SavedCarts))
		surface.PlaySound("buttons/button19.wav")
		MakepWorth()
	end
end

local function QuickCheckDoClick(self)
	if GAMEMODE.SavedCarts[self.ID] then
		Checkout(GAMEMODE.SavedCarts[self.ID][2])
	end
end

function MakepWorth()
	if pWorth and pWorth:Valid() then
		pWorth:Remove()
		pWorth = nil
	end

	local maxworth = GAMEMODE.StartingWorth
	WorthRemaining = maxworth

	local wid, hei = math.min(ScrW(), 720), ScrH() * 0.7

	local frame = vgui.Create("DFrame")
	pWorth = frame
	frame:SetSize(wid, hei)
	frame:SetDeleteOnClose(true)
	frame:SetKeyboardInputEnabled(false)
	frame:SetTitle(" ")

	local propertysheet = vgui.Create("DPropertySheet", frame)
	propertysheet:StretchToParent(4, 24, 4, 50)
	propertysheet.Paint = function() end
	
	local help = vgui.Create("DButton", frame)
	help:SetFont("ZSHUDFontSmall")
	help:SetText("<도움말>")
	help:SizeToContents()
	help:SetSize(140, 30)
	help:AlignTop(8)
	help:AlignRight(100)
	help:SetTextColor(COLOR_LIMEGREEN)
	help.DoClick = helpDoClick
	
	local list = vgui.Create("DPanelList", propertysheet)
	propertysheet:AddSheet("구매 목록", list, "icon16/heart.png", false, false)
	list:EnableVerticalScrollbar(true)
	list:SetWide(propertysheet:GetWide() - 16)
	list:SetSpacing(2)
	list:SetPadding(2)

	local panfont = "ZSHUDFontSmall"
	local panhei = 40

	local defaultcart = cvarDefaultCart:GetString()

	for i, savetab in ipairs(GAMEMODE.SavedCarts) do
		local cartpan = vgui.Create("DEXRoundedPanel")
		cartpan:SetCursor("pointer")
		cartpan:SetSize(list:GetWide(), panhei)

		local cartname = savetab[1]

		local x = 8

		if defaultcart == cartname then
			local defimage = vgui.Create("DImage", cartpan)
			defimage:SetImage("icon16/heart.png")
			defimage:SizeToContents()
			defimage:SetMouseInputEnabled(true)
			defimage:SetTooltip("이것이 즐겨찾기 목록이다.\n자금 상점에서 구매를 하지 못하면 자동으로 이 목록의 물품이 사지게 된다.")
			defimage:SetPos(x, cartpan:GetTall() * 0.5 - defimage:GetTall() * 0.5)
			x = x + defimage:GetWide() + 4
		end

		local cartnamelabel = EasyLabel(cartpan, cartname, panfont)
		cartnamelabel:SetPos(x, cartpan:GetTall() * 0.5 - cartnamelabel:GetTall() * 0.5)

		x = cartpan:GetWide() - 20

		local checkbutton = vgui.Create("DImageButton", cartpan)
		checkbutton:SetImage("icon16/accept.png")
		checkbutton:SizeToContents()
		checkbutton:SetTooltip("저장된 목록 바로 구매.")
		x = x - checkbutton:GetWide() - 8
		checkbutton:SetPos(x, cartpan:GetTall() * 0.5 - checkbutton:GetTall() * 0.5)
		checkbutton.ID = i
		checkbutton.DoClick = QuickCheckDoClick

		local loadbutton = vgui.Create("DImageButton", cartpan)
		loadbutton:SetImage("icon16/folder_go.png")
		loadbutton:SizeToContents()
		loadbutton:SetTooltip("저장된 목록 불러오기.")
		x = x - loadbutton:GetWide() - 8
		loadbutton:SetPos(x, cartpan:GetTall() * 0.5 - loadbutton:GetTall() * 0.5)
		loadbutton.ID = i
		loadbutton.DoClick = LoadDoClick

		local defaultbutton = vgui.Create("DImageButton", cartpan)
		defaultbutton:SetImage("icon16/heart.png")
		defaultbutton:SizeToContents()
		if cartname == defaultcart then
			defaultbutton:SetTooltip("즐겨찾기 목록 지정 취소.")
		else
			defaultbutton:SetTooltip("이 목록을 즐겨찾기 목록으로 지정한다.")
		end
		x = x - defaultbutton:GetWide() - 8
		defaultbutton:SetPos(x, cartpan:GetTall() * 0.5 - defaultbutton:GetTall() * 0.5)
		defaultbutton.Name = cartname
		defaultbutton.DoClick = DefaultDoClick

		local deletebutton = vgui.Create("DImageButton", cartpan)
		deletebutton:SetImage("icon16/bin.png")
		deletebutton:SizeToContents()
		deletebutton:SetTooltip("이 목록을 삭제한다.")
		x = x - deletebutton:GetWide() - 8
		deletebutton:SetPos(x, cartpan:GetTall() * 0.5 - loadbutton:GetTall() * 0.5)
		deletebutton.ID = i
		deletebutton.DoClick = DeleteDoClick

		list:AddItem(cartpan)
	end

	for catid, catname in ipairs(GAMEMODE.ItemCategories) do
		local list = vgui.Create("DPanelList", propertysheet)
		list:SetPaintBackground(false)
		propertysheet:AddSheet(catname, list, GAMEMODE.ItemCategoryIcons[catid], false, false)
		list:EnableVerticalScrollbar(true)
		list:SetWide(propertysheet:GetWide() - 16)
		list:SetSpacing(2)
		list:SetPadding(2)

		for i, tab in ipairs(GAMEMODE.Items) do
			if tab.Category == catid and tab.WorthShop then
				local button = vgui.Create("ZSWorthButton")
				button:SetWorthID(i)
				list:AddItem(button)
				WorthButtons[i] = button
			end
		end
	end

	local worthlab = EasyLabel(frame, "시작 자금: "..tostring(WorthRemaining), "ZSHUDFontSmall", COLOR_LIMEGREEN)
	worthlab:SetPos(8, frame:GetTall() - worthlab:GetTall() - 8)
	frame.WorthLab = worthlab
	
	local checkout = vgui.Create("DButton", frame)
	checkout:SetFont("ZSHUDFontSmall")
	checkout:SetText("구매!")
	checkout:SizeToContents()
	checkout:SetSize(140, 30)
	checkout:AlignBottom(8)
	checkout:CenterHorizontal()
	checkout.DoClick = CheckoutDoClick
	
	local savebutton = vgui.Create("DButton", frame)
	savebutton:SetFont("ZSHUDFontSmall")
	savebutton:SetText("현재 목록 저장")
	savebutton:SizeToContents()
	savebutton:SetSize(200, 30)
	savebutton:AlignBottom(8)
	savebutton:MoveRightOf(checkout, 8)
	savebutton.DoClick = SaveDoClick
	
	local randombutton = vgui.Create("DButton", frame)
	randombutton:SetText("랜덤 사기")
	randombutton:SetSize(64, 16)
	randombutton:AlignBottom(8)
	randombutton:AlignRight(8)
	randombutton.DoClick = RandDoClick

	local clearbutton = vgui.Create("DButton", frame)
	clearbutton:SetText("전체 지우기")
	clearbutton:SetSize(64, 16)
	clearbutton:AlignRight(8)
	clearbutton:MoveAbove(randombutton, 8)
	clearbutton.DoClick = ClearCartDoClick

	if #GAMEMODE.SavedCarts == 0 then
		propertysheet:SetActiveTab(propertysheet.Items[math.min(2, #propertysheet.Items)].Tab)
	end

	frame:Center()
	frame:SetAlpha(0)
	frame:AlphaTo(255, 0.5, 0)
	frame:MakePopup()

	return frame
end



PANEL = {}

function PANEL:Init()
	self:SetText("")

	self:DockPadding(4, 4, 4, 4)
	self:SetTall(48)

	local mdlframe = vgui.Create("DEXRoundedPanel", self)
	mdlframe:SetWide(self:GetTall() - 8)
	mdlframe:Dock(LEFT)
	mdlframe:DockMargin(0, 0, 20, 0)

	self.ModelPanel = vgui.Create("DModelPanel", mdlframe)
	self.ModelPanel:Dock(FILL)
	self.ModelPanel:DockPadding(0, 0, 0, 0)
	self.ModelPanel:DockMargin(0, 0, 0, 0)

	self.NameLabel = EasyLabel(self, "", "ZSHUDFontSmall")
	self.NameLabel:SetContentAlignment(4)
	self.NameLabel:Dock(FILL)

	self.PriceLabel = EasyLabel(self, "", "ZSHUDFontTiny")
	self.PriceLabel:SetWide(80)
	self.PriceLabel:SetContentAlignment(6)
	self.PriceLabel:Dock(RIGHT)
	self.PriceLabel:DockMargin(8, 0, 4, 0)

	self.ItemCounter = vgui.Create("ItemAmountCounter", self)

	self:SetWorthID(nil)
end

function PANEL:SetWorthID(id)
	self.ID = id

	local tab = FindStartingItem(id)

	if not tab then
		self.ModelPanel:SetVisible(false)
		self.ItemCounter:SetVisible(false)
		self.NameLabel:SetText("")
		return
	end

	local mdl = tab.Model or (weapons.GetStored(tab.SWEP) or tab).WorldModel
	if mdl then
		self.ModelPanel:SetModel(mdl)
		local mins, maxs = self.ModelPanel.Entity:GetRenderBounds()
		self.ModelPanel:SetCamPos(mins:Distance(maxs) * Vector(0.75, 0.75, 0.5))
		self.ModelPanel:SetLookAt((mins + maxs) / 2)
		self.ModelPanel:SetVisible(true)
	else
		self.ModelPanel:SetVisible(false)
	end

	if tab.SWEP or tab.Countables then
		self.ItemCounter:SetItemID(id)
		self.ItemCounter:SetVisible(true)
	else
		self.ItemCounter:SetVisible(false)
	end

	if tab.Worth then
		self.PriceLabel:SetText(tostring(tab.Worth).." Worth")
	else
		self.PriceLabel:SetText("")
	end

	self:SetTooltip(tab.Description)

	self:SetAlpha(255)

	self.NameLabel:SetText(tab.Name or "")
end

function PANEL:Paint(w, h)
	local outline
	if self.Hovered then
		outline = self.On and COLOR_GREEN or COLOR_GRAY
	else
		outline = self.On and COLOR_DARKGREEN or COLOR_DARKGRAY
	end

	draw.RoundedBox(8, 0, 0, w, h, outline)
	draw.RoundedBox(4, 4, 4, w - 8, h - 8, color_black)
end

function PANEL:DoClick(silent, force)
	local id = self.ID
	local tab = FindStartingItem(id)
	if not tab then return end

	if self.On then
		self.On = nil
		if not silent then
			surface.PlaySound("buttons/button18.wav")
		end
		WorthRemaining = WorthRemaining + tab.Worth
	else
		if WorthRemaining < tab.Worth and not force then
			surface.PlaySound("buttons/button8.wav")
			return
		end
		self.On = true
		if not silent then
			surface.PlaySound("buttons/button17.wav")
		end
		WorthRemaining = WorthRemaining - tab.Worth
	end

	pWorth.WorthLab:SetText("시작 자금: ".. WorthRemaining)
	if WorthRemaining <= 0 then
		pWorth.WorthLab:SetTextColor(COLOR_RED)
	elseif WorthRemaining <= GAMEMODE.StartingWorth * 0.25 then
		pWorth.WorthLab:SetTextColor(COLOR_YELLOW)
	else
		pWorth.WorthLab:SetTextColor(COLOR_LIMEGREEN)
	end
	pWorth.WorthLab:SizeToContents()
end

vgui.Register("ZSWorthButton", PANEL, "DButton")
