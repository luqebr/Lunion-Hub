-- LUNION HUB Professional Edition Final
local TS,Plrs,UIS,RS,HS=game:GetService("TweenService"),game:GetService("Players"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("HttpService")
local TPS=game:GetService("TeleportService")
local plr,mouse=Plrs.LocalPlayer,Plrs.LocalPlayer:GetMouse()
local pg=plr:WaitForChild("PlayerGui")
if pg:FindFirstChild("LunionHub")then pg.LunionHub:Destroy()end
local sg=Instance.new("ScreenGui")sg.Name,sg.ResetOnSpawn,sg.Parent="LunionHub",false,pg

local char,hum,hrp,flying,noclipping,ctrlTP,aimbot,infiniteJump=nil,nil,nil,false,false,false,false,false
local flySpeed,aimbotFOV,walkSpeed,jumpPower=50,200,16,50
local bg,bv,noclipConn,flyConn,aimbotConn,espObjects,espConnections={},{},{},{},{},{},{}
local espSettings={Players=false,Tools=false,Distance=true,Line=true,Health=true,Inventory=true,Box=true,MaxDistance=5000}
local guiColors={Main=Color3.fromRGB(20,20,25),Accent=Color3.fromRGB(220,50,50),Secondary=Color3.fromRGB(30,30,35)}

local function updateChar()
	char,hum,hrp=plr.Character or plr.CharacterAdded:Wait(),nil,nil
	hum,hrp=char:WaitForChild("Humanoid"),char:WaitForChild("HumanoidRootPart")
	if flying then task.wait(0.5)
		if not bg[1]or not bg[1].Parent then bg[1]=Instance.new("BodyGyro",hrp)bg[1].MaxTorque,bg[1].P,bg[1].D=Vector3.new(9e9,9e9,9e9),9e4,500 end
		if not bv[1]or not bv[1].Parent then bv[1]=Instance.new("BodyVelocity",hrp)bv[1].MaxForce,bv[1].Velocity=Vector3.new(9e9,9e9,9e9),Vector3.new(0,0,0)end end
	if noclipping then task.wait(0.5)for _,part in pairs(char:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=false end end end
end
updateChar()plr.CharacterAdded:Connect(updateChar)

local function resetAll()
	flying,noclipping,ctrlTP,aimbot,infiniteJump=false,false,false,false,false
	for _,conn in pairs(flyConn)do pcall(function()conn:Disconnect()end)end flyConn={}
	for _,conn in pairs(noclipConn)do pcall(function()conn:Disconnect()end)end noclipConn={}
	for _,conn in pairs(aimbotConn)do pcall(function()conn:Disconnect()end)end aimbotConn={}
	for _,obj in pairs(bg)do pcall(function()obj:Destroy()end)end bg={}
	for _,obj in pairs(bv)do pcall(function()obj:Destroy()end)end bv={}
	if char and hum then pcall(function()hum.WalkSpeed,hum.JumpPower=16,50 end)
		for _,part in pairs(char:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=true end end end
	for _,esp in pairs(espObjects)do pcall(function()if esp.bill then esp.bill:Destroy()end if esp.line then esp.line:Destroy()end end)end espObjects={}
	for _,conn in pairs(espConnections)do pcall(function()conn:Disconnect()end)end espConnections={}
end

local function tpTo(target)if hrp then hrp.CFrame=CFrame.new(target)end end

local function respawn()
	local tools,pos={},hrp.Position
	for _,tool in pairs(plr.Backpack:GetChildren())do if tool:IsA("Tool")then table.insert(tools,tool:Clone())end end
	for _,tool in pairs(char:GetChildren())do if tool:IsA("Tool")then table.insert(tools,tool:Clone())end end
	char:BreakJoints()plr.CharacterAdded:Wait()updateChar()task.wait(0.5)hrp.CFrame=CFrame.new(pos)
	for _,tool in pairs(tools)do tool.Parent=plr.Backpack end
end

local function loadF3X()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Infininity/f3x/main/plugin.lua"))()
end

local mf=Instance.new("Frame")mf.Size,mf.Position,mf.BackgroundColor3,mf.BorderSizePixel,mf.ClipsDescendants,mf.Parent=UDim2.new(0,650,0,450),UDim2.new(0.5,-325,1.5,0),guiColors.Main,0,true,sg
Instance.new("UICorner",mf).CornerRadius=UDim.new(0,12)local border=Instance.new("UIStroke",mf)border.Color=guiColors.Accent border.Thickness=2

local cm=Instance.new("Frame")cm.Size,cm.Position,cm.BackgroundColor3,cm.Visible,cm.ZIndex,cm.Parent=UDim2.new(0,320,0,170),UDim2.new(0.5,-160,0.5,-85),guiColors.Secondary,false,10,sg
Instance.new("UICorner",cm).CornerRadius=UDim.new(0,10)Instance.new("UIStroke",cm).Color=guiColors.Accent

local ct=Instance.new("TextLabel",cm)ct.Size,ct.Position,ct.BackgroundTransparency,ct.Text,ct.Font,ct.TextSize,ct.TextColor3,ct.TextWrapped=UDim2.new(1,-40,0,80),UDim2.new(0,20,0,20),1,"Tem certeza?\n\nTodas as funções ativas serão\ndesativadas e o script será removido.",Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),true

local cy=Instance.new("TextButton",cm)cy.Size,cy.Position,cy.BackgroundColor3,cy.Text,cy.Font,cy.TextSize,cy.TextColor3,cy.BorderSizePixel=UDim2.new(0,130,0,40),UDim2.new(0,20,1,-55),Color3.fromRGB(200,40,40),"Sim, Fechar",Enum.Font.GothamBold,14,Color3.fromRGB(255,255,255),0
Instance.new("UICorner",cy).CornerRadius=UDim.new(0,8)

local cn=Instance.new("TextButton",cm)cn.Size,cn.Position,cn.BackgroundColor3,cn.Text,cn.Font,cn.TextSize,cn.TextColor3,cn.BorderSizePixel=UDim2.new(0,130,0,40),UDim2.new(1,-150,1,-55),Color3.fromRGB(80,80,90),"Cancelar",Enum.Font.GothamBold,14,Color3.fromRGB(255,255,255),0
Instance.new("UICorner",cn).CornerRadius=UDim.new(0,8)

local mb=Instance.new("TextButton")mb.Size,mb.Position,mb.BackgroundColor3,mb.Text,mb.Font,mb.TextSize,mb.TextColor3,mb.Visible,mb.Parent=UDim2.new(0,50,0,50),UDim2.new(0,20,0,20),guiColors.Accent,"L",Enum.Font.GothamBold,28,Color3.fromRGB(255,255,255),false,sg
Instance.new("UICorner",mb).CornerRadius=UDim.new(0,10)Instance.new("UIStroke",mb).Color=guiColors.Accent

local hd=Instance.new("Frame",mf)hd.Size,hd.BackgroundColor3,hd.BorderSizePixel=UDim2.new(1,0,0,50),guiColors.Accent,0
Instance.new("UICorner",hd).CornerRadius=UDim.new(0,12)

local tt=Instance.new("TextLabel",hd)tt.Size,tt.Position,tt.BackgroundTransparency,tt.Text,tt.Font,tt.TextSize,tt.TextColor3,tt.TextXAlignment=UDim2.new(1,-100,1,0),UDim2.new(0,15,0,0),1,"LUNION HUB",Enum.Font.GothamBold,24,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left

local function createBtn(pos,col,txt,cb)
	local b=Instance.new("TextButton",hd)b.Size,b.Position,b.BackgroundColor3,b.Text,b.Font,b.TextSize,b.TextColor3,b.BorderSizePixel=UDim2.new(0,40,0,40),pos,col,txt,Enum.Font.GothamBold,28,Color3.fromRGB(255,255,255),0
	Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)b.MouseButton1Click:Connect(cb)return b
end

local minimized=false
local minB=createBtn(UDim2.new(1,-90,0.5,-20),Color3.fromRGB(100,100,110),"−",function()
	minimized=not minimized
	if minimized then TS:Create(mf,TweenInfo.new(0.3),{Size=UDim2.new(0,0,0,0)}):Play()task.wait(0.3)mf.Visible,mb.Visible=false,true
	else mf.Visible=true TS:Create(mf,TweenInfo.new(0.3),{Size=UDim2.new(0,650,0,450)}):Play()mb.Visible=false end
end)

mb.MouseButton1Click:Connect(function()minimized,mb.Visible,mf.Visible=false,false,true TS:Create(mf,TweenInfo.new(0.3),{Size=UDim2.new(0,650,0,450)}):Play()end)
createBtn(UDim2.new(1,-45,0.5,-20),Color3.fromRGB(200,40,40),"×",function()cm.Visible=true end)

cy.MouseButton1Click:Connect(function()resetAll()TS:Create(mf,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,-325,1.5,0)}):Play()task.wait(0.3)sg:Destroy()print("LUNION HUB removido!")end)
cn.MouseButton1Click:Connect(function()cm.Visible=false end)

local tc=Instance.new("ScrollingFrame",mf)tc.Size,tc.Position,tc.BackgroundColor3,tc.BorderSizePixel,tc.ScrollBarThickness,tc.ScrollBarImageColor3,tc.CanvasSize=UDim2.new(0,150,1,-60),UDim2.new(0,10,0,55),guiColors.Secondary,0,4,guiColors.Accent,UDim2.new(0,0,0,0)
Instance.new("UICorner",tc).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",tc).Color=guiColors.Accent
local tl=Instance.new("UIListLayout",tc)tl.Padding=UDim.new(0,5)
local tp=Instance.new("UIPadding",tc)tp.PaddingTop,tp.PaddingLeft,tp.PaddingRight,tp.PaddingBottom=UDim.new(0,10),UDim.new(0,8),UDim.new(0,8),UDim.new(0,10)
tl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()tc.CanvasSize=UDim2.new(0,0,0,tl.AbsoluteContentSize.Y+20)end)

local cf=Instance.new("ScrollingFrame",mf)cf.Size,cf.Position,cf.BackgroundColor3,cf.BorderSizePixel,cf.ScrollBarThickness,cf.ScrollBarImageColor3,cf.CanvasSize=UDim2.new(1,-175,1,-60),UDim2.new(0,165,0,55),guiColors.Secondary,0,6,guiColors.Accent,UDim2.new(0,0,0,0)
Instance.new("UICorner",cf).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",cf).Color=guiColors.Accent

local currentTab

local function createToggle(parent,text,yPos,callback,defaultState)
	local tf=Instance.new("Frame",parent)tf.Size,tf.Position,tf.BackgroundColor3,tf.BorderSizePixel=UDim2.new(1,-40,0,40),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
	Instance.new("UICorner",tf).CornerRadius=UDim.new(0,8)
	local lbl=Instance.new("TextLabel",tf)lbl.Size,lbl.Position,lbl.BackgroundTransparency,lbl.Text,lbl.Font,lbl.TextSize,lbl.TextColor3,lbl.TextXAlignment=UDim2.new(1,-60,1,0),UDim2.new(0,15,0,0),1,text,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left
	local btn=Instance.new("TextButton",tf)btn.Size,btn.Position,btn.BackgroundColor3,btn.Text,btn.BorderSizePixel=UDim2.new(0,50,0,25),UDim2.new(1,-60,0.5,-12.5),defaultState and guiColors.Accent or Color3.fromRGB(60,60,65),"",0
	Instance.new("UICorner",btn).CornerRadius=UDim.new(1,0)
	local ind=Instance.new("Frame",btn)ind.Size,ind.Position,ind.BackgroundColor3,ind.BorderSizePixel=UDim2.new(0,21,0,21),defaultState and UDim2.new(1,-23,0.5,-10.5)or UDim2.new(0,2,0.5,-10.5),defaultState and Color3.fromRGB(255,255,255)or Color3.fromRGB(150,150,150),0
	Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
	local toggled=defaultState or false
	btn.MouseButton1Click:Connect(function()toggled=not toggled TS:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=toggled and guiColors.Accent or Color3.fromRGB(60,60,65)}):Play()TS:Create(ind,TweenInfo.new(0.2),{Position=toggled and UDim2.new(1,-23,0.5,-10.5)or UDim2.new(0,2,0.5,-10.5),BackgroundColor3=toggled and Color3.fromRGB(255,255,255)or Color3.fromRGB(150,150,150)}):Play()callback(toggled)end)
end

local function createSlider(parent,text,yPos,min,max,default,callback)
	local sf=Instance.new("Frame",parent)sf.Size,sf.Position,sf.BackgroundColor3,sf.BorderSizePixel=UDim2.new(1,-40,0,60),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
	Instance.new("UICorner",sf).CornerRadius=UDim.new(0,8)
	local lbl=Instance.new("TextLabel",sf)lbl.Size,lbl.Position,lbl.BackgroundTransparency,lbl.Text,lbl.Font,lbl.TextSize,lbl.TextColor3,lbl.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,10,0,5),1,text..": "..default,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left
	local track=Instance.new("Frame",sf)track.Size,track.Position,track.BackgroundColor3,track.BorderSizePixel=UDim2.new(1,-20,0,6),UDim2.new(0,10,1,-20),Color3.fromRGB(60,60,65),0
	Instance.new("UICorner",track).CornerRadius=UDim.new(1,0)
	local fill=Instance.new("Frame",track)fill.Size,fill.BackgroundColor3,fill.BorderSizePixel=UDim2.new((default-min)/(max-min),0,1,0),guiColors.Accent,0
	Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
	local value,dragging=default,false
	local function update(input)local pos,tPos,tSize=input.Position.X,track.AbsolutePosition.X,track.AbsoluteSize.X local percent=math.clamp((pos-tPos)/tSize,0,1)value=math.floor(min+(max-min)*percent)fill.Size=UDim2.new(percent,0,1,0)lbl.Text=text..": "..value callback(value)end
	track.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true update(input)end end)
	UIS.InputChanged:Connect(function(input)if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then update(input)end end)
	UIS.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
end

local function createListBtn(parent,text,yPos,callback)
	local bf=Instance.new("Frame",parent)bf.Size,bf.Position,bf.BackgroundColor3,bf.BorderSizePixel=UDim2.new(1,-40,0,40),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
	Instance.new("UICorner",bf).CornerRadius=UDim.new(0,8)
	local btn=Instance.new("TextButton",bf)btn.Size,btn.BackgroundTransparency,btn.Text,btn.Font,btn.TextSize,btn.TextColor3,btn.BorderSizePixel=UDim2.new(1,0,1,0),1,text,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),0
	btn.MouseEnter:Connect(function()TS:Create(bf,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,65)}):Play()end)
	btn.MouseLeave:Connect(function()TS:Create(bf,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(40,40,45)}):Play()end)
	btn.MouseButton1Click:Connect(callback)
end

local function createInput(parent,text,yPos,placeholder,callback)
	local inf=Instance.new("Frame",parent)inf.Size,inf.Position,inf.BackgroundColor3,inf.BorderSizePixel=UDim2.new(1,-40,0,70),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
	Instance.new("UICorner",inf).CornerRadius=UDim.new(0,8)
	local lbl=Instance.new("TextLabel",inf)lbl.Size,lbl.Position,lbl.BackgroundTransparency,lbl.Text,lbl.Font,lbl.TextSize,lbl.TextColor3,lbl.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,10,0,5),1,text,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left
	local input=Instance.new("TextBox",inf)input.Size,input.Position,input.BackgroundColor3,input.Text,input.PlaceholderText,input.Font,input.TextSize,input.TextColor3,input.BorderSizePixel=UDim2.new(1,-100,0,30),UDim2.new(0,10,0,30),guiColors.Secondary,"",placeholder,Enum.Font.Gotham,12,Color3.fromRGB(255,255,255),0
	Instance.new("UICorner",input).CornerRadius=UDim.new(0,6)
	local btn=Instance.new("TextButton",inf)btn.Size,btn.Position,btn.BackgroundColor3,btn.Text,btn.Font,btn.TextSize,btn.TextColor3,btn.BorderSizePixel=UDim2.new(0,80,0,30),UDim2.new(1,-90,0,30),guiColors.Accent,"OK",Enum.Font.GothamBold,14,Color3.fromRGB(255,255,255),0
	Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)btn.MouseButton1Click:Connect(function()callback(input.Text)end)
	return input
end

local function createESP(obj,name,color,isPlayer,targetPlayer)
	if espObjects[obj]then return end
	local bill=Instance.new("BillboardGui")bill.Name,bill.AlwaysOnTop,bill.Size,bill.StudsOffset,bill.Adornee,bill.Parent,bill.MaxDistance="ESP",true,UDim2.new(0,300,0,150),Vector3.new(0,4,0),obj,obj,espSettings.MaxDistance
	local frame=Instance.new("Frame",bill)frame.Size,frame.BackgroundTransparency,frame.BorderSizePixel=UDim2.new(1,0,1,0),1,0
	if espSettings.Box then
		for i=0,1 do for j=0,1 do
				local corner=Instance.new("Frame",frame)corner.Size,corner.Position,corner.BackgroundColor3,corner.BorderSizePixel=UDim2.new(0.15,0,0,2),UDim2.new(i,i==1 and-2 or 0,j,j==1 and-2 or 0),color,0
				local corner2=Instance.new("Frame",frame)corner2.Size,corner2.Position,corner2.BackgroundColor3,corner2.BorderSizePixel=UDim2.new(0,2,0.15,0),UDim2.new(i,i==1 and-2 or 0,j,j==1 and-2 or 0),color,0
			end end
	end
	local nameLabel=Instance.new("TextLabel",frame)nameLabel.Size,nameLabel.Position,nameLabel.BackgroundColor3,nameLabel.BackgroundTransparency,nameLabel.Text,nameLabel.TextColor3,nameLabel.TextStrokeTransparency,nameLabel.Font,nameLabel.TextSize,nameLabel.BorderSizePixel=UDim2.new(1,0,0,30),UDim2.new(0,0,0,-35),Color3.fromRGB(0,0,0),0.2,name,color,0,Enum.Font.GothamBold,16,0
	Instance.new("UICorner",nameLabel).CornerRadius=UDim.new(0,8)
	local distLabel=Instance.new("TextLabel",frame)distLabel.Size,distLabel.Position,distLabel.BackgroundTransparency,distLabel.Text,distLabel.TextColor3,distLabel.TextStrokeTransparency,distLabel.Font,distLabel.TextSize=UDim2.new(1,0,0,22),UDim2.new(0,0,1,5),1,"0m",Color3.fromRGB(255,255,255),0,Enum.Font.GothamBold,14
	local line if espSettings.Line then line=Instance.new("Beam",obj)local a0,a1=Instance.new("Attachment",workspace.CurrentCamera),Instance.new("Attachment",obj)line.Attachment0,line.Attachment1,line.Color,line.Width0,line.Width1,line.FaceCamera,line.Transparency=a0,a1,ColorSequence.new(color),0.2,0.2,true,NumberSequence.new(0.3)end
	if isPlayer and targetPlayer then
		local hBG=Instance.new("Frame",frame)hBG.Size,hBG.Position,hBG.BackgroundColor3,hBG.BorderSizePixel=UDim2.new(0.8,0,0,6),UDim2.new(0.1,0,1,27),Color3.fromRGB(40,40,40),0 Instance.new("UICorner",hBG).CornerRadius=UDim.new(1,0)
		local hBar=Instance.new("Frame",hBG)hBar.Size,hBar.BackgroundColor3,hBar.BorderSizePixel=UDim2.new(1,0,1,0),Color3.fromRGB(0,255,0),0 Instance.new("UICorner",hBar).CornerRadius=UDim.new(1,0)
		local hText=Instance.new("TextLabel",frame)hText.Size,hText.Position,hText.BackgroundTransparency,hText.Text,hText.TextColor3,hText.TextStrokeTransparency,hText.Font,hText.TextSize=UDim2.new(1,0,0,20),UDim2.new(0,0,1,35),1,"100%",Color3.fromRGB(255,255,255),0,Enum.Font.GothamBold,12
		local invLabel=Instance.new("TextLabel",frame)invLabel.Size,invLabel.Position,invLabel.BackgroundTransparency,invLabel.Text,invLabel.TextColor3,invLabel.TextStrokeTransparency,invLabel.Font,invLabel.TextSize,invLabel.TextWrapped=UDim2.new(1,0,0,35),UDim2.new(0,0,1,55),1,"",Color3.fromRGB(200,220,255),0,Enum.Font.Gotham,11,true
		local conn=RS.Heartbeat:Connect(function()
			if obj and obj.Parent and hrp and targetPlayer and targetPlayer.Character then local dist=(hrp.Position-obj.Position).Magnitude if dist>espSettings.MaxDistance then bill.Enabled=false return else bill.Enabled=true end distLabel.Text=espSettings.Distance and math.floor(dist).."m"or""distLabel.Visible=espSettings.Distance if espSettings.Health then local h=targetPlayer.Character:FindFirstChild("Humanoid")if h then local hp=h.Health/h.MaxHealth hBar.Size=UDim2.new(hp,0,1,0)hBar.BackgroundColor3=hp>0.75 and Color3.fromRGB(0,255,0)or hp>0.5 and Color3.fromRGB(255,255,0)or hp>0.25 and Color3.fromRGB(255,165,0)or Color3.fromRGB(255,0,0)hText.Text=math.floor(hp*100).."%"hBG.Visible,hText.Visible=true,true else hBG.Visible,hText.Visible=false,false end else hBG.Visible,hText.Visible=false,false end if espSettings.Inventory then local tools={}for _,tool in pairs(targetPlayer.Backpack:GetChildren())do if tool:IsA("Tool")then table.insert(tools,tool.Name)end end for _,tool in pairs(targetPlayer.Character:GetChildren())do if tool:IsA("Tool")then table.insert(tools,"[E] "..tool.Name)end end invLabel.Text=#tools>0 and table.concat(tools,", ")or""invLabel.Visible=#tools>0 else invLabel.Visible=false end else if conn then conn:Disconnect()end end end)table.insert(espConnections,conn)
	else local conn=RS.Heartbeat:Connect(function()if obj and obj.Parent and hrp then local dist=(hrp.Position-obj.Position).Magnitude if dist>espSettings.MaxDistance then bill.Enabled=false return else bill.Enabled=true end distLabel.Text=espSettings.Distance and math.floor(dist).."m"or""distLabel.Visible=espSettings.Distance else if conn then conn:Disconnect()end end end)table.insert(espConnections,conn)end
	espObjects[obj]={bill=bill,line=line}
end

local function getClosestPlayer()local closest,dist=nil,aimbotFOV for _,p in pairs(Plrs:GetPlayers())do if p~=plr and p.Character and p.Character:FindFirstChild("Head")then local head=p.Character.Head local pos,onScreen=workspace.CurrentCamera:WorldToViewportPoint(head.Position)if onScreen then local mag=(Vector2.new(pos.X,pos.Y)-Vector2.new(mouse.X,mouse.Y)).Magnitude if mag<dist then closest,dist=head,mag end end end end return closest end

local function createPlayerContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"Player",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	createToggle(cf,"Fly",50,function(e)flying=e for _,c in pairs(flyConn)do pcall(function()c:Disconnect()end)end flyConn={}for _,o in pairs(bg)do pcall(function()o:Destroy()end)end bg={}for _,o in pairs(bv)do pcall(function()o:Destroy()end)end bv={}if e and hrp then bg[1]=Instance.new("BodyGyro",hrp)bg[1].MaxTorque,bg[1].P,bg[1].D=Vector3.new(9e9,9e9,9e9),9e4,500 bv[1]=Instance.new("BodyVelocity",hrp)bv[1].MaxForce,bv[1].Velocity=Vector3.new(9e9,9e9,9e9),Vector3.new(0,0,0)flyConn[1]=RS.Heartbeat:Connect(function()if not flying or not hrp or not hrp.Parent then for _,o in pairs(bg)do pcall(function()o:Destroy()end)end bg={}for _,o in pairs(bv)do pcall(function()o:Destroy()end)end bv={}for _,c in pairs(flyConn)do pcall(function()c:Disconnect()end)end flyConn={}return end local cam,dir=workspace.CurrentCamera,Vector3.new()if UIS:IsKeyDown(Enum.KeyCode.W)then dir=dir+(cam.CFrame.LookVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.S)then dir=dir-(cam.CFrame.LookVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.A)then dir=dir-(cam.CFrame.RightVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.D)then dir=dir+(cam.CFrame.RightVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.Space)then dir=dir+(Vector3.new(0,1,0)*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.LeftShift)then dir=dir-(Vector3.new(0,1,0)*flySpeed)end if bv[1]and bv[1].Parent then bv[1].Velocity=dir end if bg[1]and bg[1].Parent then bg[1].CFrame=cam.CFrame end end)end end)
	createSlider(cf,"Velocidade Voo",100,10,500,50,function(v)flySpeed=v end)
	createSlider(cf,"Velocidade",170,16,500,16,function(v)walkSpeed=v if hum then pcall(function()hum.WalkSpeed=v end)end end)
	createSlider(cf,"Pulo",240,50,500,50,function(v)jumpPower=v if hum then pcall(function()hum.JumpPower=v hum.JumpHeight=v/7 end)end end)
	createToggle(cf,"Noclip",310,function(e)noclipping=e for _,c in pairs(noclipConn)do pcall(function()c:Disconnect()end)end noclipConn={}if e then noclipConn[1]=RS.Stepped:Connect(function()if not noclipping then for _,c in pairs(noclipConn)do pcall(function()c:Disconnect()end)end noclipConn={}return end if char then for _,p in pairs(char:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end)else if char then for _,p in pairs(char:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=true end end end end end)
	createToggle(cf,"Infinite Jump",380,function(e)infiniteJump=e if e then local c=UIS.JumpRequest:Connect(function()if infiniteJump and hum then pcall(function()hum:ChangeState(Enum.HumanoidStateType.Jumping)end)end end)table.insert(noclipConn,c)end end)
	createToggle(cf,"Aimbot",450,function(e)aimbot=e for _,c in pairs(aimbotConn)do pcall(function()c:Disconnect()end)end aimbotConn={}if e then aimbotConn[1]=RS.RenderStepped:Connect(function()if not aimbot then for _,c in pairs(aimbotConn)do pcall(function()c:Disconnect()end)end aimbotConn={}return end local t=getClosestPlayer()if t then workspace.CurrentCamera.CFrame=CFrame.new(workspace.CurrentCamera.CFrame.Position,t.Position)end end)end end)
	createSlider(cf,"FOV Aimbot",520,50,500,200,function(v)aimbotFOV=v end)
	createListBtn(cf,"Respawn Sem Perder",590,function()respawn()end)
	createListBtn(cf,"F3X Building Tools",640,function()loadF3X()end)
end

local function createTPContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"Teleport",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	local y=50
	createInput(cf,"Coordenadas",y,"X, Y, Z",function(t)local c=string.split(t,",")if#c==3 then local x,yy,z=tonumber(c[1]),tonumber(c[2]),tonumber(c[3])if x and yy and z then tpTo(Vector3.new(x,yy,z))end end end)y=y+80
	createToggle(cf,"Ctrl+Click TP",y,function(e)ctrlTP=e end)y=y+50
	createListBtn(cf,"Criar TP Tool",y,function()local t=Instance.new("Tool")t.Name,t.RequiresHandle,t.Parent="TP Tool",false,plr.Backpack t.Activated:Connect(function()if mouse.Target then tpTo(mouse.Hit.Position+Vector3.new(0,3,0))end end)end)y=y+50
	local pl=Instance.new("TextLabel",cf)pl.Size,pl.Position,pl.BackgroundTransparency,pl.Text,pl.Font,pl.TextSize,pl.TextColor3,pl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,y),1,"Players:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left y=y+30
	for _,p in pairs(Plrs:GetPlayers())do if p~=plr then createListBtn(cf,p.Name,y,function()if p.Character and p.Character:FindFirstChild("HumanoidRootPart")then tpTo(p.Character.HumanoidRootPart.Position)end end)y=y+45 end end y=y+10
	local sl=Instance.new("TextLabel",cf)sl.Size,sl.Position,sl.BackgroundTransparency,sl.Text,sl.Font,sl.TextSize,sl.TextColor3,sl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,y),1,"Spawns:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left y=y+30
	local sp={}for _,o in pairs(workspace:GetDescendants())do if o:IsA("SpawnLocation")then table.insert(sp,o)end end
	if#sp>0 then for i,s in ipairs(sp)do createListBtn(cf,"Spawn "..i,y,function()tpTo(s.Position+Vector3.new(0,3,0))end)y=y+45 end else local n=Instance.new("TextLabel",cf)n.Size,n.Position,n.BackgroundTransparency,n.Text,n.Font,n.TextSize,n.TextColor3,n.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,y),1,"Nenhum spawn",Enum.Font.Gotham,12,Color3.fromRGB(150,150,150),Enum.TextXAlignment.Left y=y+35 end y=y+10
	local tl=Instance.new("TextLabel",cf)tl.Size,tl.Position,tl.BackgroundTransparency,tl.Text,tl.Font,tl.TextSize,tl.TextColor3,tl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,y),1,"Tools:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left y=y+30
	local ts={}for _,o in pairs(workspace:GetDescendants())do if o:IsA("Tool")and o.Parent~=plr.Character and o.Parent~=plr.Backpack then table.insert(ts,o)end end
	if#ts>0 then for _,t in ipairs(ts)do createListBtn(cf,t.Name,y,function()if t and t:FindFirstChild("Handle")then tpTo(t.Handle.Position)end end)y=y+45 end end
end

local function createESPContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"ESP Professional",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	createToggle(cf,"Player ESP",50,function(e)espEnabled.Players=e if e then for _,p in pairs(Plrs:GetPlayers())do if p~=plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then createESP(p.Character.HumanoidRootPart,p.Name,Color3.fromRGB(255,100,100),true,p)end end else for o,es in pairs(espObjects)do if o:IsDescendantOf(workspace)and o.Parent and o.Parent:FindFirstChild("Humanoid")then pcall(function()if es.bill then es.bill:Destroy()end if es.line then es.line:Destroy()end end)espObjects[o]=nil end end end end)
	createToggle(cf,"Tool ESP",100,function(e)espEnabled.Tools=e if e then for _,o in pairs(workspace:GetDescendants())do if o:IsA("Tool")and o:FindFirstChild("Handle")then createESP(o.Handle,o.Name,Color3.fromRGB(100,255,100),false)end end else for o,es in pairs(espObjects)do if o:IsDescendantOf(workspace)and o.Parent and o.Parent:IsA("Tool")then pcall(function()if es.bill then es.bill:Destroy()end if es.line then es.line:Destroy()end end)espObjects[o]=nil end end end end)
	local cl=Instance.new("TextLabel",cf)cl.Size,cl.Position,cl.BackgroundTransparency,cl.Text,cl.Font,cl.TextSize,cl.TextColor3,cl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,160),1,"Configuracoes:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left
	createToggle(cf,"Distancia",190,function(e)espSettings.Distance=e end,true)
	createToggle(cf,"Linha",240,function(e)espSettings.Line=e end,true)
	createToggle(cf,"Vida",290,function(e)espSettings.Health=e end,true)
	createToggle(cf,"Inventario",340,function(e)espSettings.Inventory=e end,true)
	createToggle(cf,"Caixa",390,function(e)espSettings.Box=e end,true)
	createSlider(cf,"Distancia Max",440,500,10000,5000,function(v)espSettings.MaxDistance=v for o,es in pairs(espObjects)do if es.bill then es.bill.MaxDistance=v end end end)
end

local function createMiscContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"Personalizacao",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	local y=50
	local hexIn=createInput(cf,"Cor HEX",y,"#DC3232",function(t)local h=t:gsub("#","")if#h==6 then local r,g,b=tonumber(h:sub(1,2),16),tonumber(h:sub(3,4),16),tonumber(h:sub(5,6),16)if r and g and b then guiColors.Accent=Color3.fromRGB(r,g,b)hd.BackgroundColor3,mb.BackgroundColor3=guiColors.Accent,guiColors.Accent border.Color=guiColors.Accent tc.ScrollBarImageColor3,cf.ScrollBarImageColor3=guiColors.Accent,guiColors.Accent for _,o in pairs(sg:GetDescendants())do if o:IsA("UIStroke")then o.Color=guiColors.Accent end end end end end)y=y+80
	local cs={{Color3.fromRGB(220,50,50),"Vermelho"},{Color3.fromRGB(50,150,255),"Azul"},{Color3.fromRGB(50,220,50),"Verde"},{Color3.fromRGB(200,50,200),"Roxo"},{Color3.fromRGB(255,165,0),"Laranja"},{Color3.fromRGB(255,220,50),"Amarelo"},{Color3.fromRGB(0,255,255),"Ciano"},{Color3.fromRGB(255,100,255),"Rosa"}}
	for _,d in pairs(cs)do local c,n=d[1],d[2]createListBtn(cf,n,y,function()guiColors.Accent=c hd.BackgroundColor3,mb.BackgroundColor3=c,c border.Color=c tc.ScrollBarImageColor3,cf.ScrollBarImageColor3=c,c for _,o in pairs(sg:GetDescendants())do if o:IsA("UIStroke")then o.Color=c end end end)y=y+45 end
end

local function createServerContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"Server Hop",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	local y=50
	createInput(cf,"Nome do Player",y,"Username",function(t)for _,p in pairs(Plrs:GetPlayers())do if p.Name:lower():find(t:lower())then pcall(function()TPS:TeleportToPlaceInstance(game.PlaceId,game.JobId,plr)end)break end end end)y=y+80
	createListBtn(cf,"Server Aleatorio",y,function()pcall(function()local s=game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))if s.data[1]then TPS:TeleportToPlaceInstance(game.PlaceId,s.data[math.random(1,#s.data)].id,plr)end end)end)y=y+50
	createListBtn(cf,"Servidor Menos Player",y,function()pcall(function()local s=game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))table.sort(s.data,function(a,b)return a.playing<b.playing end)if s.data[1]then TPS:TeleportToPlaceInstance(game.PlaceId,s.data[1].id,plr)end end)end)y=y+50
	local fl=Instance.new("TextLabel",cf)fl.Size,fl.Position,fl.BackgroundTransparency,fl.Text,fl.Font,fl.TextSize,fl.TextColor3,fl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,y),1,"Amigos Online:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left y=y+30
	for _,p in pairs(Plrs:GetPlayers())do if p~=plr and plr:IsFriendsWith(p.UserId)then createListBtn(cf,p.Name.." (Amigo)",y,function()pcall(function()TPS:TeleportToPlaceInstance(game.PlaceId,game.JobId,plr)end)end)y=y+45 end end
end

local function createTab(n,i,o,f)
	local t=Instance.new("TextButton",tc)t.Size,t.BackgroundColor3,t.Text,t.Font,t.TextSize,t.TextColor3,t.TextXAlignment,t.BorderSizePixel,t.LayoutOrder=UDim2.new(1,0,0,40),Color3.fromRGB(40,40,45),i.." "..n,Enum.Font.Gotham,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left,0,o
	Instance.new("UICorner",t).CornerRadius=UDim.new(0,6)Instance.new("UIPadding",t).PaddingLeft=UDim.new(0,12)
	t.MouseEnter:Connect(function()if currentTab~=t then TS:Create(t,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,65)}):Play()end end)
	t.MouseLeave:Connect(function()if currentTab~=t then TS:Create(t,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(40,40,45)}):Play()end end)
	t.MouseButton1Click:Connect(function()if currentTab then TS:Create(currentTab,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(40,40,45),TextColor3=Color3.fromRGB(200,200,200)}):Play()end currentTab=t TS:Create(t,TweenInfo.new(0.2),{BackgroundColor3=guiColors.Accent,TextColor3=Color3.fromRGB(255,255,255)}):Play()for _,c in ipairs(cf:GetChildren())do if c:IsA("GuiObject")then c:Destroy()end end cf.CanvasSize=UDim2.new(0,0,0,0)if f then f()task.wait(0.1)local h=0 for _,c in ipairs(cf:GetChildren())do if c:IsA("GuiObject")then local b=c.Position.Y.Offset+c.Size.Y.Offset if b>h then h=b end end end cf.CanvasSize=UDim2.new(0,0,0,h+20)end end)
end

createTab("Player","P",1,createPlayerContent)
createTab("Teleport","T",2,createTPContent)
createTab("ESP","E",3,createESPContent)
createTab("Server","S",4,createServerContent)
createTab("Misc","M",5,createMiscContent)

mouse.Button1Down:Connect(function()if ctrlTP and UIS:IsKeyDown(Enum.KeyCode.LeftControl)and mouse.Target then tpTo(mouse.Hit.Position+Vector3.new(0,3,0))end end)

local dr,di,ds,sp
hd.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true ds,sp=i.Position,mf.Position i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then dr=false end end)end end)
hd.InputChanged:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseMovement then di=i end end)
UIS.InputChanged:Connect(function(i)if i==di and dr then local d=i.Position-ds mf.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)end end)

local md,mi,ms,mp-- LUNION HUB Professional Edition - Fixed & Enhanced
local TS,Plrs,UIS,RS,HS=game:GetService("TweenService"),game:GetService("Players"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("HttpService")
local TPS=game:GetService("TeleportService")
local plr,mouse=Plrs.LocalPlayer,Plrs.LocalPlayer:GetMouse()
local pg=plr:WaitForChild("PlayerGui")
if pg:FindFirstChild("LunionHub")then pg.LunionHub:Destroy()end
local sg=Instance.new("ScreenGui")sg.Name,sg.ResetOnSpawn,sg.Parent="LunionHub",false,pg

local char,hum,hrp,flying,noclipping,ctrlTP,aimbot,infiniteJump=nil,nil,nil,false,false,false,false,false
local flySpeed,aimbotFOV,walkSpeed,jumpPower=50,200,16,50
local bg,bv,noclipConn,flyConn,aimbotConn,espObjects,espConnections={},{},{},{},{},{},{}
local espSettings={Players=false,Tools=false,Distance=true,Line=true,Health=true,Inventory=true,Box=true,MaxDistance=5000}
local espEnabled={Players=false,Tools=false} -- FIX: Variável que estava faltando
local guiColors={Main=Color3.fromRGB(20,20,25),Accent=Color3.fromRGB(220,50,50),Secondary=Color3.fromRGB(30,30,35)}

local function updateChar()
	char,hum,hrp=plr.Character or plr.CharacterAdded:Wait(),nil,nil
	hum,hrp=char:WaitForChild("Humanoid"),char:WaitForChild("HumanoidRootPart")
	if flying then task.wait(0.5)
		if not bg[1]or not bg[1].Parent then bg[1]=Instance.new("BodyGyro",hrp)bg[1].MaxTorque,bg[1].P,bg[1].D=Vector3.new(9e9,9e9,9e9),9e4,500 end
		if not bv[1]or not bv[1].Parent then bv[1]=Instance.new("BodyVelocity",hrp)bv[1].MaxForce,bv[1].Velocity=Vector3.new(9e9,9e9,9e9),Vector3.new(0,0,0)end end
	if noclipping then task.wait(0.5)for _,part in pairs(char:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=false end end end
end
updateChar()plr.CharacterAdded:Connect(updateChar)

local function resetAll()
	flying,noclipping,ctrlTP,aimbot,infiniteJump=false,false,false,false,false
	espEnabled={Players=false,Tools=false}
	for _,conn in pairs(flyConn)do pcall(function()conn:Disconnect()end)end flyConn={}
	for _,conn in pairs(noclipConn)do pcall(function()conn:Disconnect()end)end noclipConn={}
	for _,conn in pairs(aimbotConn)do pcall(function()conn:Disconnect()end)end aimbotConn={}
	for _,obj in pairs(bg)do pcall(function()obj:Destroy()end)end bg={}
	for _,obj in pairs(bv)do pcall(function()obj:Destroy()end)end bv={}
	if char and hum then pcall(function()hum.WalkSpeed,hum.JumpPower=16,50 end)
		for _,part in pairs(char:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=true end end end
	for _,esp in pairs(espObjects)do pcall(function()if esp.bill then esp.bill:Destroy()end if esp.line then esp.line:Destroy()end end)end espObjects={}
	for _,conn in pairs(espConnections)do pcall(function()conn:Disconnect()end)end espConnections={}
end

local function tpTo(target)if hrp then hrp.CFrame=CFrame.new(target)end end

local function respawn()
	local tools,pos={},hrp.Position
	for _,tool in pairs(plr.Backpack:GetChildren())do if tool:IsA("Tool")then table.insert(tools,tool:Clone())end end
	for _,tool in pairs(char:GetChildren())do if tool:IsA("Tool")then table.insert(tools,tool:Clone())end end
	char:BreakJoints()plr.CharacterAdded:Wait()updateChar()task.wait(0.5)hrp.CFrame=CFrame.new(pos)
	for _,tool in pairs(tools)do tool.Parent=plr.Backpack end
end

local function loadF3X()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Infininity/f3x/main/plugin.lua"))()
end

local mf=Instance.new("Frame")mf.Size,mf.Position,mf.BackgroundColor3,mf.BorderSizePixel,mf.ClipsDescendants,mf.Parent=UDim2.new(0,650,0,450),UDim2.new(0.5,-325,1.5,0),guiColors.Main,0,true,sg
Instance.new("UICorner",mf).CornerRadius=UDim.new(0,12)local border=Instance.new("UIStroke",mf)border.Color=guiColors.Accent border.Thickness=2

local cm=Instance.new("Frame")cm.Size,cm.Position,cm.BackgroundColor3,cm.Visible,cm.ZIndex,cm.Parent=UDim2.new(0,320,0,170),UDim2.new(0.5,-160,0.5,-85),guiColors.Secondary,false,10,sg
Instance.new("UICorner",cm).CornerRadius=UDim.new(0,10)Instance.new("UIStroke",cm).Color=guiColors.Accent

local ct=Instance.new("TextLabel",cm)ct.Size,ct.Position,ct.BackgroundTransparency,ct.Text,ct.Font,ct.TextSize,ct.TextColor3,ct.TextWrapped=UDim2.new(1,-40,0,80),UDim2.new(0,20,0,20),1,"Tem certeza? ⚠️\n\nTodas as funções ativas serão\ndesativadas e o script será removido.",Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),true

local cy=Instance.new("TextButton",cm)cy.Size,cy.Position,cy.BackgroundColor3,cy.Text,cy.Font,cy.TextSize,cy.TextColor3,cy.BorderSizePixel=UDim2.new(0,130,0,40),UDim2.new(0,20,1,-55),Color3.fromRGB(200,40,40),"✓ Sim, Fechar",Enum.Font.GothamBold,14,Color3.fromRGB(255,255,255),0
Instance.new("UICorner",cy).CornerRadius=UDim.new(0,8)

local cn=Instance.new("TextButton",cm)cn.Size,cn.Position,cn.BackgroundColor3,cn.Text,cn.Font,cn.TextSize,cn.TextColor3,cn.BorderSizePixel=UDim2.new(0,130,0,40),UDim2.new(1,-150,1,-55),Color3.fromRGB(80,80,90),"✕ Cancelar",Enum.Font.GothamBold,14,Color3.fromRGB(255,255,255),0
Instance.new("UICorner",cn).CornerRadius=UDim.new(0,8)

local mb=Instance.new("TextButton")mb.Size,mb.Position,mb.BackgroundColor3,mb.Text,mb.Font,mb.TextSize,mb.TextColor3,mb.Visible,mb.Parent=UDim2.new(0,50,0,50),UDim2.new(0,20,0,20),guiColors.Accent,"🌙",Enum.Font.GothamBold,28,Color3.fromRGB(255,255,255),false,sg
Instance.new("UICorner",mb).CornerRadius=UDim.new(0,10)Instance.new("UIStroke",mb).Color=guiColors.Accent

local hd=Instance.new("Frame",mf)hd.Size,hd.BackgroundColor3,hd.BorderSizePixel=UDim2.new(1,0,0,50),guiColors.Accent,0
Instance.new("UICorner",hd).CornerRadius=UDim.new(0,12)

local tt=Instance.new("TextLabel",hd)tt.Size,tt.Position,tt.BackgroundTransparency,tt.Text,tt.Font,tt.TextSize,tt.TextColor3,tt.TextXAlignment=UDim2.new(1,-100,1,0),UDim2.new(0,15,0,0),1,"🌙 LUNION HUB",Enum.Font.GothamBold,24,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left

local function createBtn(pos,col,txt,cb)
	local b=Instance.new("TextButton",hd)b.Size,b.Position,b.BackgroundColor3,b.Text,b.Font,b.TextSize,b.TextColor3,b.BorderSizePixel=UDim2.new(0,40,0,40),pos,col,txt,Enum.Font.GothamBold,28,Color3.fromRGB(255,255,255),0
	Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)b.MouseButton1Click:Connect(cb)return b
end

local minimized=false
local minB=createBtn(UDim2.new(1,-90,0.5,-20),Color3.fromRGB(100,100,110),"−",function()
	minimized=not minimized
	if minimized then TS:Create(mf,TweenInfo.new(0.3),{Size=UDim2.new(0,0,0,0)}):Play()task.wait(0.3)mf.Visible,mb.Visible=false,true
	else mf.Visible=true TS:Create(mf,TweenInfo.new(0.3),{Size=UDim2.new(0,650,0,450)}):Play()mb.Visible=false end
end)

mb.MouseButton1Click:Connect(function()minimized,mb.Visible,mf.Visible=false,false,true TS:Create(mf,TweenInfo.new(0.3),{Size=UDim2.new(0,650,0,450)}):Play()end)
createBtn(UDim2.new(1,-45,0.5,-20),Color3.fromRGB(200,40,40),"×",function()cm.Visible=true end)

cy.MouseButton1Click:Connect(function()resetAll()TS:Create(mf,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,-325,1.5,0)}):Play()task.wait(0.3)sg:Destroy()print("LUNION HUB removido!")end)
cn.MouseButton1Click:Connect(function()cm.Visible=false end)

local tc=Instance.new("ScrollingFrame",mf)tc.Size,tc.Position,tc.BackgroundColor3,tc.BorderSizePixel,tc.ScrollBarThickness,tc.ScrollBarImageColor3,tc.CanvasSize=UDim2.new(0,150,1,-60),UDim2.new(0,10,0,55),guiColors.Secondary,0,4,guiColors.Accent,UDim2.new(0,0,0,0)
Instance.new("UICorner",tc).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",tc).Color=guiColors.Accent
local tl=Instance.new("UIListLayout",tc)tl.Padding=UDim.new(0,5)
local tp=Instance.new("UIPadding",tc)tp.PaddingTop,tp.PaddingLeft,tp.PaddingRight,tp.PaddingBottom=UDim.new(0,10),UDim.new(0,8),UDim.new(0,8),UDim.new(0,10)
tl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()tc.CanvasSize=UDim2.new(0,0,0,tl.AbsoluteContentSize.Y+20)end)

local cf=Instance.new("ScrollingFrame",mf)cf.Size,cf.Position,cf.BackgroundColor3,cf.BorderSizePixel,cf.ScrollBarThickness,cf.ScrollBarImageColor3,cf.CanvasSize=UDim2.new(1,-175,1,-60),UDim2.new(0,165,0,55),guiColors.Secondary,0,6,guiColors.Accent,UDim2.new(0,0,0,0)
Instance.new("UICorner",cf).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",cf).Color=guiColors.Accent

local currentTab

local function createToggle(parent,text,yPos,callback,defaultState)
	local tf=Instance.new("Frame",parent)tf.Size,tf.Position,tf.BackgroundColor3,tf.BorderSizePixel=UDim2.new(1,-40,0,40),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
	Instance.new("UICorner",tf).CornerRadius=UDim.new(0,8)
	local lbl=Instance.new("TextLabel",tf)lbl.Size,lbl.Position,lbl.BackgroundTransparency,lbl.Text,lbl.Font,lbl.TextSize,lbl.TextColor3,lbl.TextXAlignment=UDim2.new(1,-60,1,0),UDim2.new(0,15,0,0),1,text,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left
	local btn=Instance.new("TextButton",tf)btn.Size,btn.Position,btn.BackgroundColor3,btn.Text,btn.BorderSizePixel=UDim2.new(0,50,0,25),UDim2.new(1,-60,0.5,-12.5),defaultState and guiColors.Accent or Color3.fromRGB(60,60,65),"",0
	Instance.new("UICorner",btn).CornerRadius=UDim.new(1,0)
	local ind=Instance.new("Frame",btn)ind.Size,ind.Position,ind.BackgroundColor3,ind.BorderSizePixel=UDim2.new(0,21,0,21),defaultState and UDim2.new(1,-23,0.5,-10.5)or UDim2.new(0,2,0.5,-10.5),defaultState and Color3.fromRGB(255,255,255)or Color3.fromRGB(150,150,150),0
	Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
	local toggled=defaultState or false
	btn.MouseButton1Click:Connect(function()toggled=not toggled TS:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=toggled and guiColors.Accent or Color3.fromRGB(60,60,65)}):Play()TS:Create(ind,TweenInfo.new(0.2),{Position=toggled and UDim2.new(1,-23,0.5,-10.5)or UDim2.new(0,2,0.5,-10.5),BackgroundColor3=toggled and Color3.fromRGB(255,255,255)or Color3.fromRGB(150,150,150)}):Play()callback(toggled)end)
end

local function createSlider(parent,text,yPos,min,max,default,callback)
	local sf=Instance.new("Frame",parent)sf.Size,sf.Position,sf.BackgroundColor3,sf.BorderSizePixel=UDim2.new(1,-40,0,60),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
	Instance.new("UICorner",sf).CornerRadius=UDim.new(0,8)
	local lbl=Instance.new("TextLabel",sf)lbl.Size,lbl.Position,lbl.BackgroundTransparency,lbl.Text,lbl.Font,lbl.TextSize,lbl.TextColor3,lbl.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,10,0,5),1,text..": "..default,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left
	local track=Instance.new("Frame",sf)track.Size,track.Position,track.BackgroundColor3,track.BorderSizePixel=UDim2.new(1,-20,0,6),UDim2.new(0,10,1,-20),Color3.fromRGB(60,60,65),0
	Instance.new("UICorner",track).CornerRadius=UDim.new(1,0)
	local fill=Instance.new("Frame",track)fill.Size,fill.BackgroundColor3,fill.BorderSizePixel=UDim2.new((default-min)/(max-min),0,1,0),guiColors.Accent,0
	Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
	local value,dragging=default,false
	local function update(input)local pos,tPos,tSize=input.Position.X,track.AbsolutePosition.X,track.AbsoluteSize.X local percent=math.clamp((pos-tPos)/tSize,0,1)value=math.floor(min+(max-min)*percent)fill.Size=UDim2.new(percent,0,1,0)lbl.Text=text..": "..value callback(value)end
	track.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true update(input)end end)
	UIS.InputChanged:Connect(function(input)if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then update(input)end end)
	UIS.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
end

local function createListBtn(parent,text,yPos,callback)
	local bf=Instance.new("Frame",parent)bf.Size,bf.Position,bf.BackgroundColor3,bf.BorderSizePixel=UDim2.new(1,-40,0,40),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
	Instance.new("UICorner",bf).CornerRadius=UDim.new(0,8)
	local btn=Instance.new("TextButton",bf)btn.Size,btn.BackgroundTransparency,btn.Text,btn.Font,btn.TextSize,btn.TextColor3,btn.BorderSizePixel=UDim2.new(1,0,1,0),1,text,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),0
	btn.MouseEnter:Connect(function()TS:Create(bf,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,65)}):Play()end)
	btn.MouseLeave:Connect(function()TS:Create(bf,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(40,40,45)}):Play()end)
	btn.MouseButton1Click:Connect(callback)
end

local function createInput(parent,text,yPos,placeholder,callback)
	local inf=Instance.new("Frame",parent)inf.Size,inf.Position,inf.BackgroundColor3,inf.BorderSizePixel=UDim2.new(1,-40,0,70),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
	Instance.new("UICorner",inf).CornerRadius=UDim.new(0,8)
	local lbl=Instance.new("TextLabel",inf)lbl.Size,lbl.Position,lbl.BackgroundTransparency,lbl.Text,lbl.Font,lbl.TextSize,lbl.TextColor3,lbl.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,10,0,5),1,text,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left
	local input=Instance.new("TextBox",inf)input.Size,input.Position,input.BackgroundColor3,input.Text,input.PlaceholderText,input.Font,input.TextSize,input.TextColor3,input.BorderSizePixel=UDim2.new(1,-100,0,30),UDim2.new(0,10,0,30),guiColors.Secondary,"",placeholder,Enum.Font.Gotham,12,Color3.fromRGB(255,255,255),0
	Instance.new("UICorner",input).CornerRadius=UDim.new(0,6)
	local btn=Instance.new("TextButton",inf)btn.Size,btn.Position,btn.BackgroundColor3,btn.Text,btn.Font,btn.TextSize,btn.TextColor3,btn.BorderSizePixel=UDim2.new(0,80,0,30),UDim2.new(1,-90,0,30),guiColors.Accent,"OK",Enum.Font.GothamBold,14,Color3.fromRGB(255,255,255),0
	Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)btn.MouseButton1Click:Connect(function()callback(input.Text)end)
	return input
end

local function createColorPicker(parent,text,yPos,defaultColor,callback)
	local cpf=Instance.new("Frame",parent)cpf.Size,cpf.Position,cpf.BackgroundColor3,cpf.BorderSizePixel=UDim2.new(1,-40,0,200),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
	Instance.new("UICorner",cpf).CornerRadius=UDim.new(0,8)
	local lbl=Instance.new("TextLabel",cpf)lbl.Size,lbl.Position,lbl.BackgroundTransparency,lbl.Text,lbl.Font,lbl.TextSize,lbl.TextColor3,lbl.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,10,0,5),1,text,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left

	local preview=Instance.new("Frame",cpf)preview.Size,preview.Position,preview.BackgroundColor3,preview.BorderSizePixel=UDim2.new(0,40,0,40),UDim2.new(1,-50,0,30),defaultColor,0
	Instance.new("UICorner",preview).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",preview).Color=Color3.fromRGB(255,255,255)

	local gradient=Instance.new("ImageLabel",cpf)gradient.Size,gradient.Position,gradient.BackgroundColor3,gradient.BorderSizePixel,gradient.Image=UDim2.new(1,-20,0,80),UDim2.new(0,10,0,75),Color3.new(1,1,1),0,"rbxassetid://3887014957"
	Instance.new("UICorner",gradient).CornerRadius=UDim.new(0,6)

	local h,s,v=defaultColor:ToHSV()
	local currentColor=defaultColor
	local draggingGrad=false

	local function updateColor(hue,sat,val)
		currentColor=Color3.fromHSV(hue,sat,val)
		preview.BackgroundColor3=currentColor
		callback(currentColor)
	end

	gradient.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then draggingGrad=true end end)
	UIS.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then draggingGrad=false end end)
	UIS.InputChanged:Connect(function(input)
		if draggingGrad and input.UserInputType==Enum.UserInputType.MouseMovement then
			local pos=input.Position
			local gPos,gSize=gradient.AbsolutePosition,gradient.AbsoluteSize
			local x,y=math.clamp((pos.X-gPos.X)/gSize.X,0,1),math.clamp((pos.Y-gPos.Y)/gSize.Y,0,1)
			h,s,v=x,1-y,1
			updateColor(h,s,v)
		end
	end)

	local rSlider=Instance.new("Frame",cpf)rSlider.Size,rSlider.Position,rSlider.BackgroundColor3,rSlider.BorderSizePixel=UDim2.new(0.3,0,0,8),UDim2.new(0,10,1,-65),Color3.fromRGB(255,0,0),0
	Instance.new("UICorner",rSlider).CornerRadius=UDim.new(1,0)
	local gSlider=Instance.new("Frame",cpf)gSlider.Size,gSlider.Position,gSlider.BackgroundColor3,gSlider.BorderSizePixel=UDim2.new(0.3,0,0,8),UDim2.new(0.35,0,1,-65),Color3.fromRGB(0,255,0),0
	Instance.new("UICorner",gSlider).CornerRadius=UDim.new(1,0)
	local bSlider=Instance.new("Frame",cpf)bSlider.Size,bSlider.Position,bSlider.BackgroundColor3,bSlider.BorderSizePixel=UDim2.new(0.3,0,0,8),UDim2.new(0.7,0,1,-65),Color3.fromRGB(0,0,255),0
	Instance.new("UICorner",bSlider).CornerRadius=UDim.new(1,0)

	local rLbl=Instance.new("TextLabel",cpf)rLbl.Size,rLbl.Position,rLbl.BackgroundTransparency,rLbl.Text,rLbl.Font,rLbl.TextSize,rLbl.TextColor3=UDim2.new(0.3,0,0,15),UDim2.new(0,10,1,-50),1,"R: "..math.floor(defaultColor.R*255),Enum.Font.Gotham,11,Color3.fromRGB(255,100,100)
	local gLbl=Instance.new("TextLabel",cpf)gLbl.Size,gLbl.Position,gLbl.BackgroundTransparency,gLbl.Text,gLbl.Font,gLbl.TextSize,gLbl.TextColor3=UDim2.new(0.3,0,0,15),UDim2.new(0.35,0,1,-50),1,"G: "..math.floor(defaultColor.G*255),Enum.Font.Gotham,11,Color3.fromRGB(100,255,100)
	local bLbl=Instance.new("TextLabel",cpf)bLbl.Size,bLbl.Position,bLbl.BackgroundTransparency,bLbl.Text,bLbl.Font,bLbl.TextSize,bLbl.TextColor3=UDim2.new(0.3,0,0,15),UDim2.new(0.7,0,1,-50),1,"B: "..math.floor(defaultColor.B*255),Enum.Font.Gotham,11,Color3.fromRGB(100,100,255)

	local hexLbl=Instance.new("TextLabel",cpf)hexLbl.Size,hexLbl.Position,hexLbl.BackgroundTransparency,hexLbl.Text,hexLbl.Font,hexLbl.TextSize,hexLbl.TextColor3=UDim2.new(1,-20,0,20),UDim2.new(0,10,1,-28),1,"HEX: #"..string.format("%02X%02X%02X",defaultColor.R*255,defaultColor.G*255,defaultColor.B*255),Enum.Font.GothamBold,12,Color3.fromRGB(255,255,255)

	local function updateLabels(col)
		rLbl.Text="R: "..math.floor(col.R*255)
		gLbl.Text="G: "..math.floor(col.G*255)
		bLbl.Text="B: "..math.floor(col.B*255)
		hexLbl.Text="HEX: #"..string.format("%02X%02X%02X",col.R*255,col.G*255,col.B*255)
	end

	callback=function(col)
		updateLabels(col)
		guiColors.Accent=col
		hd.BackgroundColor3,mb.BackgroundColor3=col,col
		border.Color=col
		tc.ScrollBarImageColor3,cf.ScrollBarImageColor3=col,col
		for _,o in pairs(sg:GetDescendants())do if o:IsA("UIStroke")then o.Color=col end end
	end

	return cpf
end

local function createESP(obj,name,color,isPlayer,targetPlayer)
	if espObjects[obj]then return end
	local bill=Instance.new("BillboardGui")bill.Name,bill.AlwaysOnTop,bill.Size,bill.StudsOffset,bill.Adornee,bill.Parent,bill.MaxDistance="ESP",true,UDim2.new(0,300,0,150),Vector3.new(0,4,0),obj,obj,espSettings.MaxDistance
	local frame=Instance.new("Frame",bill)frame.Size,frame.BackgroundTransparency,frame.BorderSizePixel=UDim2.new(1,0,1,0),1,0
	if espSettings.Box then
		for i=0,1 do for j=0,1 do
				local corner=Instance.new("Frame",frame)corner.Size,corner.Position,corner.BackgroundColor3,corner.BorderSizePixel=UDim2.new(0.15,0,0,2),UDim2.new(i,i==1 and-2 or 0,j,j==1 and-2 or 0),color,0
				local corner2=Instance.new("Frame",frame)corner2.Size,corner2.Position,corner2.BackgroundColor3,corner2.BorderSizePixel=UDim2.new(0,2,0.15,0),UDim2.new(i,i==1 and-2 or 0,j,j==1 and-2 or 0),color,0
			end end
	end
	local nameLabel=Instance.new("TextLabel",frame)nameLabel.Size,nameLabel.Position,nameLabel.BackgroundColor3,nameLabel.BackgroundTransparency,nameLabel.Text,nameLabel.TextColor3,nameLabel.TextStrokeTransparency,nameLabel.Font,nameLabel.TextSize,nameLabel.BorderSizePixel=UDim2.new(1,0,0,30),UDim2.new(0,0,0,-35),Color3.fromRGB(0,0,0),0.2,name,color,0,Enum.Font.GothamBold,16,0
	Instance.new("UICorner",nameLabel).CornerRadius=UDim.new(0,8)
	local distLabel=Instance.new("TextLabel",frame)distLabel.Size,distLabel.Position,distLabel.BackgroundTransparency,distLabel.Text,distLabel.TextColor3,distLabel.TextStrokeTransparency,distLabel.Font,distLabel.TextSize=UDim2.new(1,0,0,22),UDim2.new(0,0,1,5),1,"0m",Color3.fromRGB(255,255,255),0,Enum.Font.GothamBold,14
	local line if espSettings.Line then line=Instance.new("Beam",obj)local a0,a1=Instance.new("Attachment",workspace.CurrentCamera),Instance.new("Attachment",obj)line.Attachment0,line.Attachment1,line.Color,line.Width0,line.Width1,line.FaceCamera,line.Transparency=a0,a1,ColorSequence.new(color),0.2,0.2,true,NumberSequence.new(0.3)end
	if isPlayer and targetPlayer then
		local hBG=Instance.new("Frame",frame)hBG.Size,hBG.Position,hBG.BackgroundColor3,hBG.BorderSizePixel=UDim2.new(0.8,0,0,6),UDim2.new(0.1,0,1,27),Color3.fromRGB(40,40,40),0 Instance.new("UICorner",hBG).CornerRadius=UDim.new(1,0)
		local hBar=Instance.new("Frame",hBG)hBar.Size,hBar.BackgroundColor3,hBar.BorderSizePixel=UDim2.new(1,0,1,0),Color3.fromRGB(0,255,0),0 Instance.new("UICorner",hBar).CornerRadius=UDim.new(1,0)
		local hText=Instance.new("TextLabel",frame)hText.Size,hText.Position,hText.BackgroundTransparency,hText.Text,hText.TextColor3,hText.TextStrokeTransparency,hText.Font,hText.TextSize=UDim2.new(1,0,0,20),UDim2.new(0,0,1,35),1,"100%",Color3.fromRGB(255,255,255),0,Enum.Font.GothamBold,12
		local invLabel=Instance.new("TextLabel",frame)invLabel.Size,invLabel.Position,invLabel.BackgroundTransparency,invLabel.Text,invLabel.TextColor3,invLabel.TextStrokeTransparency,invLabel.Font,invLabel.TextSize,invLabel.TextWrapped=UDim2.new(1,0,0,35),UDim2.new(0,0,1,55),1,"",Color3.fromRGB(200,220,255),0,Enum.Font.Gotham,11,true
		local conn=RS.Heartbeat:Connect(function()
			if obj and obj.Parent and hrp and targetPlayer and targetPlayer.Character then local dist=(hrp.Position-obj.Position).Magnitude if dist>espSettings.MaxDistance then bill.Enabled=false return else bill.Enabled=true end distLabel.Text=espSettings.Distance and math.floor(dist).."m"or""distLabel.Visible=espSettings.Distance if espSettings.Health then local h=targetPlayer.Character:FindFirstChild("Humanoid")if h then local hp=h.Health/h.MaxHealth hBar.Size=UDim2.new(hp,0,1,0)hBar.BackgroundColor3=hp>0.75 and Color3.fromRGB(0,255,0)or hp>0.5 and Color3.fromRGB(255,255,0)or hp>0.25 and Color3.fromRGB(255,165,0)or Color3.fromRGB(255,0,0)hText.Text=math.floor(hp*100).."%"hBG.Visible,hText.Visible=true,true else hBG.Visible,hText.Visible=false,false end else hBG.Visible,hText.Visible=false,false end if espSettings.Inventory then local tools={}for _,tool in pairs(targetPlayer.Backpack:GetChildren())do if tool:IsA("Tool")then table.insert(tools,tool.Name)end end for _,tool in pairs(targetPlayer.Character:GetChildren())do if tool:IsA("Tool")then table.insert(tools,"[E] "..tool.Name)end end invLabel.Text=#tools>0 and table.concat(tools,", ")or""invLabel.Visible=#tools>0 else invLabel.Visible=false end else if conn then conn:Disconnect()end end end)table.insert(espConnections,conn)
	else local conn=RS.Heartbeat:Connect(function()if obj and obj.Parent and hrp then local dist=(hrp.Position-obj.Position).Magnitude if dist>espSettings.MaxDistance then bill.Enabled=false return else bill.Enabled=true end distLabel.Text=espSettings.Distance and math.floor(dist).."m"or""distLabel.Visible=espSettings.Distance else if conn then conn:Disconnect()end end end)table.insert(espConnections,conn)end
	espObjects[obj]={bill=bill,line=line}
end

local function getClosestPlayer()local closest,dist=nil,aimbotFOV for _,p in pairs(Plrs:GetPlayers())do if p~=plr and p.Character and p.Character:FindFirstChild("Head")then local head=p.Character.Head local pos,onScreen=workspace.CurrentCamera:WorldToViewportPoint(head.Position)if onScreen then local mag=(Vector2.new(pos.X,pos.Y)-Vector2.new(mouse.X,mouse.Y)).Magnitude if mag<dist then closest,dist=head,mag end end end end return closest end

local function createPlayerContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"👤 Player",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	createToggle(cf,"✈️ Fly",50,function(e)flying=e for _,c in pairs(flyConn)do pcall(function()c:Disconnect()end)end flyConn={}for _,o in pairs(bg)do pcall(function()o:Destroy()end)end bg={}for _,o in pairs(bv)do pcall(function()o:Destroy()end)end bv={}if e and hrp then bg[1]=Instance.new("BodyGyro",hrp)bg[1].MaxTorque,bg[1].P,bg[1].D=Vector3.new(9e9,9e9,9e9),9e4,500 bv[1]=Instance.new("BodyVelocity",hrp)bv[1].MaxForce,bv[1].Velocity=Vector3.new(9e9,9e9,9e9),Vector3.new(0,0,0)flyConn[1]=RS.Heartbeat:Connect(function()if not flying or not hrp or not hrp.Parent then for _,o in pairs(bg)do pcall(function()o:Destroy()end)end bg={}for _,o in pairs(bv)do pcall(function()o:Destroy()end)end bv={}for _,c in pairs(flyConn)do pcall(function()c:Disconnect()end)end flyConn={}return end local cam,dir=workspace.CurrentCamera,Vector3.new()if UIS:IsKeyDown(Enum.KeyCode.W)then dir=dir+(cam.CFrame.LookVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.S)then dir=dir-(cam.CFrame.LookVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.A)then dir=dir-(cam.CFrame.RightVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.D)then dir=dir+(cam.CFrame.RightVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.Space)then dir=dir+(Vector3.new(0,1,0)*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.LeftShift)then dir=dir-(Vector3.new(0,1,0)*flySpeed)end if bv[1]and bv[1].Parent then bv[1].Velocity=dir end if bg[1]and bg[1].Parent then bg[1].CFrame=cam.CFrame end end)end end)
	createSlider(cf,"🚀 Velocidade Voo",100,10,500,50,function(v)flySpeed=v end)
	createSlider(cf,"🏃 Velocidade",170,16,500,16,function(v)walkSpeed=v if hum then pcall(function()hum.WalkSpeed=v end)end end)
	createSlider(cf,"⬆️ Pulo",240,50,500,50,function(v)jumpPower=v if hum then pcall(function()hum.JumpPower=v hum.JumpHeight=v/7 end)end end)
	createToggle(cf,"👻 Noclip",310,function(e)noclipping=e for _,c in pairs(noclipConn)do pcall(function()c:Disconnect()end)end noclipConn={}if e then noclipConn[1]=RS.Stepped:Connect(function()if not noclipping then for _,c in pairs(noclipConn)do pcall(function()c:Disconnect()end)end noclipConn={}return end if char then for _,p in pairs(char:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end)else if char then for _,p in pairs(char:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=true end end end end end)
	createToggle(cf,"♾️ Infinite Jump",380,function(e)infiniteJump=e if e then local c=UIS.JumpRequest:Connect(function()if infiniteJump and hum then pcall(function()hum:ChangeState(Enum.HumanoidStateType.Jumping)end)end end)table.insert(noclipConn,c)end end)
	createToggle(cf,"🎯 Aimbot",450,function(e)aimbot=e for _,c in pairs(aimbotConn)do pcall(function()c:Disconnect()end)end aimbotConn={}if e then aimbotConn[1]=RS.RenderStepped:Connect(function()if not aimbot then for _,c in pairs(aimbotConn)do pcall(function()c:Disconnect()end)end aimbotConn={}return end local t=getClosestPlayer()if t then workspace.CurrentCamera.CFrame=CFrame.new(workspace.CurrentCamera.CFrame.Position,t.Position)end end)end end)
	createSlider(cf,"🔭 FOV Aimbot",520,50,500,200,function(v)aimbotFOV=v end)
	createListBtn(cf,"🔄 Respawn Sem Perder",590,function()respawn()end)
	createListBtn(cf,"🔨 F3X Building Tools",640,function()loadF3X()end)
end

local function createTPContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"📍 Teleport",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	local y=50
	createInput(cf,"📌 Coordenadas",y,"X, Y, Z",function(t)local c=string.split(t,",")if#c==3 then local x,yy,z=tonumber(c[1]),tonumber(c[2]),tonumber(c[3])if x and yy and z then tpTo(Vector3.new(x,yy,z))end end end)y=y+80
	createToggle(cf,"🖱️ Ctrl+Click TP",y,function(e)ctrlTP=e end)y=y+50
	createListBtn(cf,"🛠️ Criar TP Tool",y,function()local t=Instance.new("Tool")t.Name,t.RequiresHandle,t.Parent="TP Tool",false,plr.Backpack t.Activated:Connect(function()if mouse.Target then tpTo(mouse.Hit.Position+Vector3.new(0,3,0))end end)end)y=y+50
	local pl=Instance.new("TextLabel",cf)pl.Size,pl.Position,pl.BackgroundTransparency,pl.Text,pl.Font,pl.TextSize,pl.TextColor3,pl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,y),1,"👥 Players:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left y=y+30
	for _,p in pairs(Plrs:GetPlayers())do if p~=plr then createListBtn(cf,p.Name,y,function()if p.Character and p.Character:FindFirstChild("HumanoidRootPart")then tpTo(p.Character.HumanoidRootPart.Position)end end)y=y+45 end end y=y+10
	local sl=Instance.new("TextLabel",cf)sl.Size,sl.Position,sl.BackgroundTransparency,sl.Text,sl.Font,sl.TextSize,sl.TextColor3,sl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,y),1,"🎯 Spawns:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left y=y+30
	local sp={}for _,o in pairs(workspace:GetDescendants())do if o:IsA("SpawnLocation")then table.insert(sp,o)end end
	if#sp>0 then for i,s in ipairs(sp)do createListBtn(cf,"Spawn "..i,y,function()tpTo(s.Position+Vector3.new(0,3,0))end)y=y+45 end else local n=Instance.new("TextLabel",cf)n.Size,n.Position,n.BackgroundTransparency,n.Text,n.Font,n.TextSize,n.TextColor3,n.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,y),1,"Nenhum spawn",Enum.Font.Gotham,12,Color3.fromRGB(150,150,150),Enum.TextXAlignment.Left y=y+35 end y=y+10
	local tl=Instance.new("TextLabel",cf)tl.Size,tl.Position,tl.BackgroundTransparency,tl.Text,tl.Font,tl.TextSize,tl.TextColor3,tl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,y),1,"🔧 Tools:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left y=y+30
	local ts={}for _,o in pairs(workspace:GetDescendants())do if o:IsA("Tool")and o.Parent~=plr.Character and o.Parent~=plr.Backpack then table.insert(ts,o)end end
	if#ts>0 then for _,t in ipairs(ts)do createListBtn(cf,t.Name,y,function()if t and t:FindFirstChild("Handle")then tpTo(t.Handle.Position)end end)y=y+45 end end
end

local function createESPContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"👁️ ESP Professional",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	createToggle(cf,"👥 Player ESP",50,function(e)espEnabled.Players=e if e then for _,p in pairs(Plrs:GetPlayers())do if p~=plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then createESP(p.Character.HumanoidRootPart,p.Name,Color3.fromRGB(255,100,100),true,p)end end else for o,es in pairs(espObjects)do if o:IsDescendantOf(workspace)and o.Parent and o.Parent:FindFirstChild("Humanoid")then pcall(function()if es.bill then es.bill:Destroy()end if es.line then es.line:Destroy()end end)espObjects[o]=nil end end end end)
	createToggle(cf,"🔧 Tool ESP",100,function(e)espEnabled.Tools=e if e then for _,o in pairs(workspace:GetDescendants())do if o:IsA("Tool")and o:FindFirstChild("Handle")then createESP(o.Handle,o.Name,Color3.fromRGB(100,255,100),false)end end else for o,es in pairs(espObjects)do if o:IsDescendantOf(workspace)and o.Parent and o.Parent:IsA("Tool")then pcall(function()if es.bill then es.bill:Destroy()end if es.line then es.line:Destroy()end end)espObjects[o]=nil end end end end)
	local cl=Instance.new("TextLabel",cf)cl.Size,cl.Position,cl.BackgroundTransparency,cl.Text,cl.Font,cl.TextSize,cl.TextColor3,cl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,160),1,"⚙️ Configurações:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left
	createToggle(cf,"📏 Distancia",190,function(e)espSettings.Distance=e end,true)
	createToggle(cf,"📐 Linha",240,function(e)espSettings.Line=e end,true)
	createToggle(cf,"❤️ Vida",290,function(e)espSettings.Health=e end,true)
	createToggle(cf,"🎒 Inventario",340,function(e)espSettings.Inventory=e end,true)
	createToggle(cf,"📦 Caixa",390,function(e)espSettings.Box=e end,true)
	createSlider(cf,"🔍 Distancia Max",440,500,10000,5000,function(v)espSettings.MaxDistance=v for o,es in pairs(espObjects)do if es.bill then es.bill.MaxDistance=v end end end)
end

local function createMiscContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"🎨 Personalização",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	local y=50

	createColorPicker(cf,"🎨 Seletor de Cor",y,guiColors.Accent,function(c)end)
	y=y+210

	local hexIn=createInput(cf,"# Cor HEX",y,"#DC3232",function(t)local h=t:gsub("#","")if#h==6 then local r,g,b=tonumber(h:sub(1,2),16),tonumber(h:sub(3,4),16),tonumber(h:sub(5,6),16)if r and g and b then guiColors.Accent=Color3.fromRGB(r,g,b)hd.BackgroundColor3,mb.BackgroundColor3=guiColors.Accent,guiColors.Accent border.Color=guiColors.Accent tc.ScrollBarImageColor3,cf.ScrollBarImageColor3=guiColors.Accent,guiColors.Accent for _,o in pairs(sg:GetDescendants())do if o:IsA("UIStroke")then o.Color=guiColors.Accent end end end end end)y=y+80

	local cl=Instance.new("TextLabel",cf)cl.Size,cl.Position,cl.BackgroundTransparency,cl.Text,cl.Font,cl.TextSize,cl.TextColor3,cl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,y),1,"🎨 Cores Predefinidas:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left y=y+30

	local cs={{Color3.fromRGB(220,50,50),"❤️ Vermelho"},{Color3.fromRGB(50,150,255),"💙 Azul"},{Color3.fromRGB(50,220,50),"💚 Verde"},{Color3.fromRGB(200,50,200),"💜 Roxo"},{Color3.fromRGB(255,165,0),"🧡 Laranja"},{Color3.fromRGB(255,220,50),"💛 Amarelo"},{Color3.fromRGB(0,255,255),"💠 Ciano"},{Color3.fromRGB(255,100,255),"💗 Rosa"}}
	for _,d in pairs(cs)do local c,n=d[1],d[2]createListBtn(cf,n,y,function()guiColors.Accent=c hd.BackgroundColor3,mb.BackgroundColor3=c,c border.Color=c tc.ScrollBarImageColor3,cf.ScrollBarImageColor3=c,c for _,o in pairs(sg:GetDescendants())do if o:IsA("UIStroke")then o.Color=c end end end)y=y+45 end
end

local function createServerContent()
	local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"🌐 Server Hop",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
	local y=50
	createInput(cf,"🔍 Nome do Player",y,"Username",function(t)for _,p in pairs(Plrs:GetPlayers())do if p.Name:lower():find(t:lower())then pcall(function()TPS:TeleportToPlaceInstance(game.PlaceId,game.JobId,plr)end)break end end end)y=y+80
	createListBtn(cf,"🎲 Server Aleatório",y,function()pcall(function()local s=game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))if s.data[1]then TPS:TeleportToPlaceInstance(game.PlaceId,s.data[math.random(1,#s.data)].id,plr)end end)end)y=y+50
	createListBtn(cf,"📉 Servidor Menos Player",y,function()pcall(function()local s=game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))table.sort(s.data,function(a,b)return a.playing<b.playing end)if s.data[1]then TPS:TeleportToPlaceInstance(game.PlaceId,s.data[1].id,plr)end end)end)y=y+50
	local fl=Instance.new("TextLabel",cf)fl.Size,fl.Position,fl.BackgroundTransparency,fl.Text,fl.Font,fl.TextSize,fl.TextColor3,fl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,y),1,"👥 Amigos Online:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left y=y+30
	for _,p in pairs(Plrs:GetPlayers())do if p~=plr and plr:IsFriendsWith(p.UserId)then createListBtn(cf,p.Name.." (Amigo)",y,function()pcall(function()TPS:TeleportToPlaceInstance(game.PlaceId,game.JobId,plr)end)end)y=y+45 end end
end

local function createTab(n,i,o,f)
	local t=Instance.new("TextButton",tc)t.Size,t.BackgroundColor3,t.Text,t.Font,t.TextSize,t.TextColor3,t.TextXAlignment,t.BorderSizePixel,t.LayoutOrder=UDim2.new(1,0,0,40),Color3.fromRGB(40,40,45),i.." "..n,Enum.Font.Gotham,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left,0,o
	Instance.new("UICorner",t).CornerRadius=UDim.new(0,6)Instance.new("UIPadding",t).PaddingLeft=UDim.new(0,12)
	t.MouseEnter:Connect(function()if currentTab~=t then TS:Create(t,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,65)}):Play()end end)
	t.MouseLeave:Connect(function()if currentTab~=t then TS:Create(t,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(40,40,45)}):Play()end end)
	t.MouseButton1Click:Connect(function()if currentTab then TS:Create(currentTab,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(40,40,45),TextColor3=Color3.fromRGB(200,200,200)}):Play()end currentTab=t TS:Create(t,TweenInfo.new(0.2),{BackgroundColor3=guiColors.Accent,TextColor3=Color3.fromRGB(255,255,255)}):Play()for _,c in ipairs(cf:GetChildren())do if c:IsA("GuiObject")then c:Destroy()end end cf.CanvasSize=UDim2.new(0,0,0,0)if f then f()task.wait(0.1)local h=0 for _,c in ipairs(cf:GetChildren())do if c:IsA("GuiObject")then local b=c.Position.Y.Offset+c.Size.Y.Offset if b>h then h=b end end end cf.CanvasSize=UDim2.new(0,0,0,h+20)end end)
end

createTab("Player","👤",1,createPlayerContent)
createTab("Teleport","📍",2,createTPContent)
createTab("ESP","👁️",3,createESPContent)
createTab("Server","🌐",4,createServerContent)
createTab("Misc","🎨",5,createMiscContent)

mouse.Button1Down:Connect(function()if ctrlTP and UIS:IsKeyDown(Enum.KeyCode.LeftControl)and mouse.Target then tpTo(mouse.Hit.Position+Vector3.new(0,3,0))end end)

local dr,di,ds,sp
hd.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true ds,sp=i.Position,mf.Position i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then dr=false end end)end end)
hd.InputChanged:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseMovement then di=i end end)
UIS.InputChanged:Connect(function(i)if i==di and dr then local d=i.Position-ds mf.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)end end)

local md,mi,ms,mp
mb.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then md=true ms,mp=i.Position,mb.Position i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then md=false end end)end end)
mb.InputChanged:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseMovement then mi=i end end)
UIS.InputChanged:Connect(function(i)if i==mi and md then local d=i.Position-ms mb.Position=UDim2.new(mp.X.Scale,mp.X.Offset+d.X,mp.Y.Scale,mp.Y.Offset+d.Y)end end)

TS:Create(mf,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-325,0.5,-225)}):Play()
print("LUNION HUB - Carregado com sucesso!")
mb.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then md=true ms,mp=i.Position,mb.Position i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then md=false end end)end end)
mb.InputChanged:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseMovement then mi=i end end)
UIS.InputChanged:Connect(function(i)if i==mi and md then local d=i.Position-ms mb.Position=UDim2.new(mp.X.Scale,mp.X.Offset+d.X,mp.Y.Scale,mp.Y.Offset+d.Y)end end)

TS:Create(mf,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-325,0.5,-225)}):Play()
print("LUNION HUB - Carregado com sucesso!")
