-- LUNION HUB Universal v5 - Script Completo
local TS,Plrs,UIS,RS=game:GetService("TweenService"),game:GetService("Players"),game:GetService("UserInputService"),game:GetService("RunService")
local plr,mouse=Plrs.LocalPlayer,Plrs.LocalPlayer:GetMouse()
local pg=plr:WaitForChild("PlayerGui")
if pg:FindFirstChild("LunionHub")then pg.LunionHub:Destroy()end
local sg=Instance.new("ScreenGui")sg.Name,sg.ResetOnSpawn,sg.Parent="LunionHub",false,pg
local char,hum,hrp,flying,noclipping,ctrlTP,aimbot=nil,nil,nil,false,false,false,false
local flySpeed,aimbotFOV,originalWS,originalJP=50,200,16,50
local bg,bv,noclipConn,flyConn,aimbotConn,espObjects=nil,nil,nil,nil,nil,{}
local espSettings={Players=false,Tools=false,Distance=true,Line=false,Health=true,Inventory=true}
local guiColors={Main=Color3.fromRGB(20,20,25),Accent=Color3.fromRGB(220,50,50),Secondary=Color3.fromRGB(30,30,35)}
local function updateChar()
char,hum,hrp=plr.Character or plr.CharacterAdded:Wait(),nil,nil
hum,hrp=char:WaitForChild("Humanoid"),char:WaitForChild("HumanoidRootPart")
originalWS,originalJP=hum.WalkSpeed,hum.JumpPower
if flying then task.wait(0.5)if not bg or not bg.Parent then bg=Instance.new("BodyGyro",hrp)bg.MaxTorque,bg.P,bg.D=Vector3.new(9e4,9e4,9e4),9e4,500 end if not bv or not bv.Parent then bv=Instance.new("BodyVelocity",hrp)bv.MaxForce,bv.Velocity=Vector3.new(9e4,9e4,9e4),Vector3.new(0,0,0)end end
if noclipping then task.wait(0.5)for _,part in pairs(char:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=false end end end
end
updateChar()plr.CharacterAdded:Connect(updateChar)
local function resetAll()
flying,noclipping,ctrlTP,aimbot=false,false,false,false
if flyConn then flyConn:Disconnect()flyConn=nil end if noclipConn then noclipConn:Disconnect()noclipConn=nil end if aimbotConn then aimbotConn:Disconnect()aimbotConn=nil end
if bg then bg:Destroy()bg=nil end if bv then bv:Destroy()bv=nil end
hum.WalkSpeed,hum.JumpPower=originalWS,originalJP
for _,part in pairs(char:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=true end end
for _,esp in pairs(espObjects)do pcall(function()if esp.bill then esp.bill:Destroy()end if esp.line then esp.line:Destroy()end end)end espObjects={}
end
local function tpTo(target)hrp.CFrame=CFrame.new(target)end
local function respawn()
local tools,pos={},hrp.Position
for _,tool in pairs(plr.Backpack:GetChildren())do if tool:IsA("Tool")then table.insert(tools,tool:Clone())end end
for _,tool in pairs(char:GetChildren())do if tool:IsA("Tool")then table.insert(tools,tool:Clone())end end
char:BreakJoints()plr.CharacterAdded:Wait()updateChar()task.wait(0.5)hrp.CFrame=CFrame.new(pos)
for _,tool in pairs(tools)do tool.Parent=plr.Backpack end
end
local mf=Instance.new("Frame")
mf.Size,mf.Position,mf.BackgroundColor3,mf.BorderSizePixel,mf.ClipsDescendants,mf.Parent=UDim2.new(0,650,0,450),UDim2.new(0.5,-325,1.5,0),guiColors.Main,0,true,sg
Instance.new("UICorner",mf).CornerRadius=UDim.new(0,12)Instance.new("UIStroke",mf).Color=guiColors.Accent
local cm=Instance.new("Frame")
cm.Size,cm.Position,cm.BackgroundColor3,cm.Visible,cm.ZIndex,cm.Parent=UDim2.new(0,320,0,170),UDim2.new(0.5,-160,0.5,-85),guiColors.Secondary,false,10,sg
Instance.new("UICorner",cm).CornerRadius=UDim.new(0,10)Instance.new("UIStroke",cm).Color=guiColors.Accent
local ct=Instance.new("TextLabel",cm)
ct.Size,ct.Position,ct.BackgroundTransparency,ct.Text,ct.Font,ct.TextSize,ct.TextColor3,ct.TextWrapped=UDim2.new(1,-40,0,80),UDim2.new(0,20,0,20),1,"⚠️ Tem certeza?\n\nTodas as funções ativas serão\ndesativadas e o script será removido.",Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),true
local cy=Instance.new("TextButton",cm)
cy.Size,cy.Position,cy.BackgroundColor3,cy.Text,cy.Font,cy.TextSize,cy.TextColor3,cy.BorderSizePixel=UDim2.new(0,130,0,40),UDim2.new(0,20,1,-55),Color3.fromRGB(200,40,40),"✓ Sim, Fechar",Enum.Font.GothamBold,14,Color3.fromRGB(255,255,255),0
Instance.new("UICorner",cy).CornerRadius=UDim.new(0,8)
local cn=Instance.new("TextButton",cm)
cn.Size,cn.Position,cn.BackgroundColor3,cn.Text,cn.Font,cn.TextSize,cn.TextColor3,cn.BorderSizePixel=UDim2.new(0,130,0,40),UDim2.new(1,-150,1,-55),Color3.fromRGB(80,80,90),"✗ Cancelar",Enum.Font.GothamBold,14,Color3.fromRGB(255,255,255),0
Instance.new("UICorner",cn).CornerRadius=UDim.new(0,8)
local mb=Instance.new("TextButton")
mb.Size,mb.Position,mb.BackgroundColor3,mb.Text,mb.Font,mb.TextSize,mb.TextColor3,mb.Visible,mb.Parent=UDim2.new(0,50,0,50),UDim2.new(0,20,0,20),Color3.fromRGB(180,30,30),"L",Enum.Font.GothamBold,28,Color3.fromRGB(255,255,255),false,sg
Instance.new("UICorner",mb).CornerRadius=UDim.new(0,10)Instance.new("UIStroke",mb).Color=guiColors.Accent
local hd=Instance.new("Frame",mf)
hd.Size,hd.BackgroundColor3,hd.BorderSizePixel=UDim2.new(1,0,0,50),guiColors.Accent,0
Instance.new("UICorner",hd).CornerRadius=UDim.new(0,12)
local tt=Instance.new("TextLabel",hd)
tt.Size,tt.Position,tt.BackgroundTransparency,tt.Text,tt.Font,tt.TextSize,tt.TextColor3,tt.TextXAlignment=UDim2.new(1,-100,1,0),UDim2.new(0,15,0,0),1,"LUNION HUB",Enum.Font.GothamBold,24,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left
local function createBtn(pos,col,txt,cb)
local b=Instance.new("TextButton",hd)
b.Size,b.Position,b.BackgroundColor3,b.Text,b.Font,b.TextSize,b.TextColor3,b.BorderSizePixel=UDim2.new(0,40,0,40),pos,col,txt,Enum.Font.GothamBold,28,Color3.fromRGB(255,255,255),0
Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)b.MouseButton1Click:Connect(cb)return b
end
local minimized=false
local minB=createBtn(UDim2.new(1,-90,0.5,-20),Color3.fromRGB(100,100,110),"−",function()
minimized=not minimized
if minimized then TS:Create(mf,TweenInfo.new(0.3),{Size=UDim2.new(0,0,0,0)}):Play()task.wait(0.3)mf.Visible,mb.Visible=false,true else mf.Visible=true TS:Create(mf,TweenInfo.new(0.3),{Size=UDim2.new(0,650,0,450)}):Play()mb.Visible=false end
end)
mb.MouseButton1Click:Connect(function()minimized,mb.Visible,mf.Visible=false,false,true TS:Create(mf,TweenInfo.new(0.3),{Size=UDim2.new(0,650,0,450)}):Play()end)
createBtn(UDim2.new(1,-45,0.5,-20),Color3.fromRGB(200,40,40),"×",function()cm.Visible=true end)
cy.MouseButton1Click:Connect(function()resetAll()TS:Create(mf,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,-325,1.5,0)}):Play()task.wait(0.3)sg:Destroy()print("LUNION HUB removido!")end)
cn.MouseButton1Click:Connect(function()cm.Visible=false end)
local tc=Instance.new("ScrollingFrame",mf)
tc.Size,tc.Position,tc.BackgroundColor3,tc.BorderSizePixel,tc.ScrollBarThickness,tc.ScrollBarImageColor3,tc.CanvasSize=UDim2.new(0,150,1,-60),UDim2.new(0,10,0,55),guiColors.Secondary,0,4,guiColors.Accent,UDim2.new(0,0,0,0)
Instance.new("UICorner",tc).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",tc).Color=guiColors.Accent
local tl=Instance.new("UIListLayout",tc)tl.Padding=UDim.new(0,5)
local tp=Instance.new("UIPadding",tc)tp.PaddingTop,tp.PaddingLeft,tp.PaddingRight,tp.PaddingBottom=UDim.new(0,10),UDim.new(0,8),UDim.new(0,8),UDim.new(0,10)
tl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()tc.CanvasSize=UDim2.new(0,0,0,tl.AbsoluteContentSize.Y+20)end)
local cf=Instance.new("ScrollingFrame",mf)
cf.Size,cf.Position,cf.BackgroundColor3,cf.BorderSizePixel,cf.ScrollBarThickness,cf.ScrollBarImageColor3,cf.CanvasSize=UDim2.new(1,-175,1,-60),UDim2.new(0,165,0,55),guiColors.Secondary,0,6,guiColors.Accent,UDim2.new(0,0,0,0)
Instance.new("UICorner",cf).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",cf).Color=guiColors.Accent
local currentTab
local function createToggle(parent,text,yPos,callback)
local tf=Instance.new("Frame",parent)tf.Size,tf.Position,tf.BackgroundColor3,tf.BorderSizePixel=UDim2.new(1,-40,0,40),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
Instance.new("UICorner",tf).CornerRadius=UDim.new(0,8)
local lbl=Instance.new("TextLabel",tf)lbl.Size,lbl.Position,lbl.BackgroundTransparency,lbl.Text,lbl.Font,lbl.TextSize,lbl.TextColor3,lbl.TextXAlignment=UDim2.new(1,-60,1,0),UDim2.new(0,15,0,0),1,text,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left
local btn=Instance.new("TextButton",tf)btn.Size,btn.Position,btn.BackgroundColor3,btn.Text,btn.BorderSizePixel=UDim2.new(0,50,0,25),UDim2.new(1,-60,0.5,-12.5),Color3.fromRGB(60,60,65),"",0
Instance.new("UICorner",btn).CornerRadius=UDim.new(1,0)
local ind=Instance.new("Frame",btn)ind.Size,ind.Position,ind.BackgroundColor3,ind.BorderSizePixel=UDim2.new(0,21,0,21),UDim2.new(0,2,0.5,-10.5),Color3.fromRGB(150,150,150),0
Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
local toggled=false
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
local function createInput(parent,text,yPos,callback)
local inf=Instance.new("Frame",parent)inf.Size,inf.Position,inf.BackgroundColor3,inf.BorderSizePixel=UDim2.new(1,-40,0,70),UDim2.new(0,20,0,yPos),Color3.fromRGB(40,40,45),0
Instance.new("UICorner",inf).CornerRadius=UDim.new(0,8)
local lbl=Instance.new("TextLabel",inf)lbl.Size,lbl.Position,lbl.BackgroundTransparency,lbl.Text,lbl.Font,lbl.TextSize,lbl.TextColor3,lbl.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,10,0,5),1,text,Enum.Font.Gotham,14,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left
local input=Instance.new("TextBox",inf)input.Size,input.Position,input.BackgroundColor3,input.Text,input.PlaceholderText,input.Font,input.TextSize,input.TextColor3,input.BorderSizePixel=UDim2.new(1,-100,0,30),UDim2.new(0,10,0,30),guiColors.Secondary,"","X, Y, Z",Enum.Font.Gotham,12,Color3.fromRGB(255,255,255),0
Instance.new("UICorner",input).CornerRadius=UDim.new(0,6)
local btn=Instance.new("TextButton",inf)btn.Size,btn.Position,btn.BackgroundColor3,btn.Text,btn.Font,btn.TextSize,btn.TextColor3,btn.BorderSizePixel=UDim2.new(0,80,0,30),UDim2.new(1,-90,0,30),guiColors.Accent,"TP",Enum.Font.GothamBold,14,Color3.fromRGB(255,255,255),0
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)btn.MouseButton1Click:Connect(function()callback(input.Text)end)
end
local function createESP(obj,name,color,isPlayer,targetPlayer)
if espObjects[obj]then return end
local bill=Instance.new("BillboardGui")bill.Name,bill.AlwaysOnTop,bill.Size,bill.StudsOffset,bill.Adornee,bill.Parent="ESP",true,UDim2.new(0,200,0,100),Vector3.new(0,3,0),obj,obj
local frame=Instance.new("Frame",bill)frame.Size,frame.BackgroundTransparency,frame.BorderSizePixel=UDim2.new(1,0,1,0),1,0
for _,data in pairs({{UDim2.new(1,0,0,2),UDim2.new(0,0,0,0)},{UDim2.new(1,0,0,2),UDim2.new(0,0,1,-2)},{UDim2.new(0,2,1,0),UDim2.new(0,0,0,0)},{UDim2.new(0,2,1,0),UDim2.new(1,-2,0,0)}})do local line=Instance.new("Frame",frame)line.Size,line.Position,line.BackgroundColor3,line.BorderSizePixel=data[1],data[2],color,0 end
local label=Instance.new("TextLabel",frame)label.Size,label.Position,label.BackgroundColor3,label.BackgroundTransparency,label.Text,label.TextColor3,label.TextStrokeTransparency,label.TextStrokeColor3,label.Font,label.TextSize,label.BorderSizePixel=UDim2.new(1,0,0,25),UDim2.new(0,0,0,-30),Color3.fromRGB(0,0,0),0.3,name,color,0,Color3.fromRGB(0,0,0),Enum.Font.GothamBold,14,0
Instance.new("UICorner",label).CornerRadius=UDim.new(0,6)
local distLabel=Instance.new("TextLabel",frame)distLabel.Size,distLabel.Position,distLabel.BackgroundTransparency,distLabel.Text,distLabel.TextColor3,distLabel.TextStrokeTransparency,distLabel.TextStrokeColor3,distLabel.Font,distLabel.TextSize=UDim2.new(1,0,0,20),UDim2.new(0,0,1,5),1,"0m",Color3.fromRGB(255,255,255),0,Color3.fromRGB(0,0,0),Enum.Font.Gotham,12
local lineAttach0,lineAttach1,lineBeam
if espSettings.Line then lineAttach0,lineAttach1=Instance.new("Attachment",hrp),Instance.new("Attachment",obj)lineBeam=Instance.new("Beam",obj)lineBeam.Attachment0,lineBeam.Attachment1,lineBeam.Color,lineBeam.Width0,lineBeam.Width1=lineAttach0,lineAttach1,ColorSequence.new(color),0.1,0.1 end
if isPlayer and targetPlayer then
local healthLabel=Instance.new("TextLabel",frame)healthLabel.Size,healthLabel.Position,healthLabel.BackgroundTransparency,healthLabel.Text,healthLabel.TextColor3,healthLabel.TextStrokeTransparency,healthLabel.TextStrokeColor3,healthLabel.Font,healthLabel.TextSize=UDim2.new(1,0,0,18),UDim2.new(0,0,1,25),1,"❤️ 100",Color3.fromRGB(0,255,0),0,Color3.fromRGB(0,0,0),Enum.Font.Gotham,11
local invLabel=Instance.new("TextLabel",frame)invLabel.Size,invLabel.Position,invLabel.BackgroundTransparency,invLabel.Text,invLabel.TextColor3,invLabel.TextStrokeTransparency,invLabel.TextStrokeColor3,invLabel.Font,invLabel.TextSize=UDim2.new(1,0,0,18),UDim2.new(0,0,1,43),1,"🎒",Color3.fromRGB(200,200,255),0,Color3.fromRGB(0,0,0),Enum.Font.Gotham,10
RS.Heartbeat:Connect(function()
if obj and obj.Parent and hrp and targetPlayer and targetPlayer.Character then
local dist=(hrp.Position-obj.Position).Magnitude
if espSettings.Distance then distLabel.Text=math.floor(dist).."m"else distLabel.Text=""end
if espSettings.Health then local h=targetPlayer.Character:FindFirstChild("Humanoid")if h then local hp=math.floor((h.Health/h.MaxHealth)*100)healthLabel.Text="❤️ "..hp.."%"healthLabel.TextColor3=hp>75 and Color3.fromRGB(0,255,0)or hp>50 and Color3.fromRGB(255,255,0)or hp>25 and Color3.fromRGB(255,165,0)or Color3.fromRGB(255,0,0)healthLabel.Visible=true else healthLabel.Visible=false end else healthLabel.Visible=false end
if espSettings.Inventory then local tools={}for _,tool in pairs(targetPlayer.Backpack:GetChildren())do if tool:IsA("Tool")then table.insert(tools,tool.Name)end end for _,tool in pairs(targetPlayer.Character:GetChildren())do if tool:IsA("Tool")then table.insert(tools,"["..tool.Name.."]")end end invLabel.Text=#tools>0 and"🎒 "..table.concat(tools,", ")or""invLabel.Visible=#tools>0 else invLabel.Visible=false end
end
end)
else RS.Heartbeat:Connect(function()if obj and obj.Parent and hrp then local dist=(hrp.Position-obj.Position).Magnitude distLabel.Text=espSettings.Distance and math.floor(dist).."m"or""end end)end
espObjects[obj]={bill=bill,line=lineBeam,attach0=lineAttach0,attach1=lineAttach1}
end
local function getClosestPlayer()
local closest,dist=nil,aimbotFOV
for _,p in pairs(Plrs:GetPlayers())do if p~=plr and p.Character and p.Character:FindFirstChild("Head")then local head=p.Character.Head local pos,onScreen=workspace.CurrentCamera:WorldToViewportPoint(head.Position)if onScreen then local mag=(Vector2.new(pos.X,pos.Y)-Vector2.new(mouse.X,mouse.Y)).Magnitude if mag<dist then closest,dist=head,mag end end end end return closest
end
local function createPlayerContent()
local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"👤 Player",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
createToggle(cf,"Fly",50,function(enabled)flying=enabled if flyConn then flyConn:Disconnect()flyConn=nil end if bg then bg:Destroy()bg=nil end if bv then bv:Destroy()bv=nil end if enabled then bg=Instance.new("BodyGyro",hrp)bg.MaxTorque,bg.P,bg.D=Vector3.new(9e4,9e4,9e4),9e4,500 bv=Instance.new("BodyVelocity",hrp)bv.MaxForce,bv.Velocity=Vector3.new(9e4,9e4,9e4),Vector3.new(0,0,0)flyConn=RS.Heartbeat:Connect(function()if not flying or not hrp or not hrp.Parent then if bg then bg:Destroy()bg=nil end if bv then bv:Destroy()bv=nil end if flyConn then flyConn:Disconnect()flyConn=nil end return end local cam,dir=workspace.CurrentCamera,Vector3.new()if UIS:IsKeyDown(Enum.KeyCode.W)then dir=dir+(cam.CFrame.LookVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.S)then dir=dir-(cam.CFrame.LookVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.A)then dir=dir-(cam.CFrame.RightVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.D)then dir=dir+(cam.CFrame.RightVector*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.Space)then dir=dir+(Vector3.new(0,1,0)*flySpeed)end if UIS:IsKeyDown(Enum.KeyCode.LeftShift)then dir=dir-(Vector3.new(0,1,0)*flySpeed)end bv.Velocity,bg.CFrame=dir,cam.CFrame end)end end)
createSlider(cf,"Velocidade de Voo",100,10,200,50,function(val)flySpeed=val end)
createSlider(cf,"Velocidade",170,16,200,16,function(val)hum.WalkSpeed=val end)
createSlider(cf,"Pulo",240,50,300,50,function(val)hum.JumpPower=val end)
createToggle(cf,"Noclip",310,function(enabled)noclipping=enabled if noclipConn then noclipConn:Disconnect()noclipConn=nil end if enabled then noclipConn=RS.Stepped:Connect(function()if not noclipping then if noclipConn then noclipConn:Disconnect()noclipConn=nil end return end for _,part in pairs(char:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=false end end end)else for _,part in pairs(char:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=true end end end end)
createToggle(cf,"Aimbot",380,function(enabled)aimbot=enabled if aimbotConn then aimbotConn:Disconnect()aimbotConn=nil end if enabled then aimbotConn=RS.RenderStepped:Connect(function()if not aimbot then if aimbotConn then aimbotConn:Disconnect()aimbotConn=nil end return end local target=getClosestPlayer()if target then workspace.CurrentCamera.CFrame=CFrame.new(workspace.CurrentCamera.CFrame.Position,target.Position)end end)end end)
createSlider(cf,"FOV Aimbot",450,50,500,200,function(val)aimbotFOV=val end)
createListBtn(cf,"🔄 Respawn (Sem Perder Items)",520,function()respawn()end)
end
local function createTeleportContent()
local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"📍 Teleport",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
local yOff=50
createInput(cf,"Coordenadas (X, Y, Z)",yOff,function(text)local coords=string.split(text,",")if#coords==3 then local x,y,z=tonumber(coords[1]),tonumber(coords[2]),tonumber(coords[3])if x and y and z then tpTo(Vector3.new(x,y,z))end end end)
yOff=yOff+80
createToggle(cf,"Ctrl + Click Teleport",yOff,function(enabled)ctrlTP=enabled end)
yOff=yOff+50
createListBtn(cf,"🔧 Criar TP Tool",yOff,function()local tool=Instance.new("Tool")tool.Name,tool.RequiresHandle,tool.Parent="TP Tool",false,plr.Backpack tool.Activated:Connect(function()if mouse.Target then tpTo(mouse.Hit.Position+Vector3.new(0,3,0))end end)end)
yOff=yOff+50
local plrLbl=Instance.new("TextLabel",cf)plrLbl.Size,plrLbl.Position,plrLbl.BackgroundTransparency,plrLbl.Text,plrLbl.Font,plrLbl.TextSize,plrLbl.TextColor3,plrLbl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,yOff),1,"👥 Players:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left
yOff=yOff+30
for _,p in pairs(Plrs:GetPlayers())do if p~=plr then createListBtn(cf,"➤ "..p.Name,yOff,function()if p.Character and p.Character:FindFirstChild("HumanoidRootPart")then tpTo(p.Character.HumanoidRootPart.Position)end end)yOff=yOff+45 end end
yOff=yOff+10
local spLbl=Instance.new("TextLabel",cf)spLbl.Size,spLbl.Position,spLbl.BackgroundTransparency,spLbl.Text,spLbl.Font,spLbl.TextSize,spLbl.TextColor3,spLbl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,yOff),1,"🎯 Spawns:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left
yOff=yOff+30
local spawns={}for _,obj in pairs(workspace:GetDescendants())do if obj:IsA("SpawnLocation")then table.insert(spawns,obj)end end
if#spawns>0 then for i,sp in ipairs(spawns)do createListBtn(cf,"📍 Spawn "..i,yOff,function()tpTo(sp.Position+Vector3.new(0,3,0))end)yOff=yOff+45 end else local noSp=Instance.new("TextLabel",cf)noSp.Size,noSp.Position,noSp.BackgroundTransparency,noSp.Text,noSp.Font,noSp.TextSize,noSp.TextColor3,noSp.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,yOff),1,"⚠️ Nenhum spawn",Enum.Font.Gotham,12,Color3.fromRGB(150,150,150),Enum.TextXAlignment.Left yOff=yOff+35 end
yOff=yOff+10
local tlLbl=Instance.new("TextLabel",cf)tlLbl.Size,tlLbl.Position,tlLbl.BackgroundTransparency,tlLbl.Text,tlLbl.Font,tlLbl.TextSize,tlLbl.TextColor3,tlLbl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,yOff),1,"🔧 Tools:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left
yOff=yOff+30
local tools={}for _,obj in pairs(workspace:GetDescendants())do if obj:IsA("Tool")and obj.Parent~=plr.Character and obj.Parent~=plr.Backpack then table.insert(tools,obj)end end
if#tools>0 then for _,tl in ipairs(tools)do createListBtn(cf,"🔧 "..tl.Name,yOff,function()if tl and tl:FindFirstChild("Handle")then tpTo(tl.Handle.Position)end end)yOff=yOff+45 end else local noTl=Instance.new("TextLabel",cf)noTl.Size,noTl.Position,noTl.BackgroundTransparency,noTl.Text,noTl.Font,noTl.TextSize,noTl.TextColor3,noTl.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,yOff),1,"⚠️ Nenhuma tool",Enum.Font.Gotham,12,Color3.fromRGB(150,150,150),Enum.TextXAlignment.Left end
end
local function createESPContent()
local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"👁️ ESP",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
createToggle(cf,"Player ESP",50,function(enabled)espEnabled.Players=enabled if enabled then for _,p in pairs(Plrs:GetPlayers())do if p~=plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then createESP(p.Character.HumanoidRootPart,p.Name,Color3.fromRGB(255,100,100),true,p)end end Plrs.PlayerAdded:Connect(function(p)if espEnabled.Players then p.CharacterAdded:Connect(function(c)task.wait(1)if c:FindFirstChild("HumanoidRootPart")then createESP(c.HumanoidRootPart,p.Name,Color3.fromRGB(255,100,100),true,p)end end)end end)else for obj,esp in pairs(espObjects)do if obj:IsDescendantOf(workspace)and obj.Parent and obj.Parent:FindFirstChild("Humanoid")then pcall(function()if esp.bill then esp.bill:Destroy()end if esp.line then esp.line:Destroy()end if esp.attach0 then esp.attach0:Destroy()end if esp.attach1 then esp.attach1:Destroy()end end)espObjects[obj]=nil end end end end)
createToggle(cf,"Tool ESP",100,function(enabled)espEnabled.Tools=enabled if enabled then for _,obj in pairs(workspace:GetDescendants())do if obj:IsA("Tool")and obj:FindFirstChild("Handle")then createESP(obj.Handle,obj.Name,Color3.fromRGB(100,255,100),false)end end workspace.DescendantAdded:Connect(function(obj)if espEnabled.Tools and obj:IsA("Tool")and obj:FindFirstChild("Handle")then task.wait(0.1)createESP(obj.Handle,obj.Name,Color3.fromRGB(100,255,100),false)end end)else for obj,esp in pairs(espObjects)do if obj:IsDescendantOf(workspace)and obj.Parent and obj.Parent:IsA("Tool")then pcall(function()if esp.bill then esp.bill:Destroy()end if esp.line then esp.line:Destroy()end if esp.attach0 then esp.attach0:Destroy()end if esp.attach1 then esp.attach1:Destroy()end end)espObjects[obj]=nil end end end end)
local cfgLbl=Instance.new("TextLabel",cf)cfgLbl.Size,cfgLbl.Position,cfgLbl.BackgroundTransparency,cfgLbl.Text,cfgLbl.Font,cfgLbl.TextSize,cfgLbl.TextColor3,cfgLbl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,160),1,"⚙️ Configurações:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left
createToggle(cf,"Mostrar Distância",190,function(enabled)espSettings.Distance=enabled end)
createToggle(cf,"Linha até Alvo",240,function(enabled)espSettings.Line=enabled for obj,esp in pairs(espObjects)do pcall(function()if esp.bill then esp.bill:Destroy()end if esp.line then esp.line:Destroy()end if esp.attach0 then esp.attach0:Destroy()end if esp.attach1 then esp.attach1:Destroy()end end)end espObjects={}if espEnabled.Players then for _,p in pairs(Plrs:GetPlayers())do if p~=plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then createESP(p.Character.HumanoidRootPart,p.Name,Color3.fromRGB(255,100,100),true,p)end end end if espEnabled.Tools then for _,obj in pairs(workspace:GetDescendants())do if obj:IsA("Tool")and obj:FindFirstChild("Handle")then createESP(obj.Handle,obj.Name,Color3.fromRGB(100,255,100),false)end end end end)
createToggle(cf,"Mostrar Vida",290,function(enabled)espSettings.Health=enabled end)
createToggle(cf,"Mostrar Inventário",340,function(enabled)espSettings.Inventory=enabled end)
end
local function createMiscContent()
local title=Instance.new("TextLabel",cf)title.Size,title.Position,title.BackgroundTransparency,title.Text,title.Font,title.TextSize,title.TextColor3,title.TextXAlignment=UDim2.new(1,-40,0,30),UDim2.new(0,20,0,10),1,"⚙️ Personalização",Enum.Font.GothamBold,18,guiColors.Accent,Enum.TextXAlignment.Left
local colorLbl=Instance.new("TextLabel",cf)colorLbl.Size,colorLbl.Position,colorLbl.BackgroundTransparency,colorLbl.Text,colorLbl.Font,colorLbl.TextSize,colorLbl.TextColor3,colorLbl.TextXAlignment=UDim2.new(1,-40,0,25),UDim2.new(0,20,0,50),1,"🎨 Cor Principal:",Enum.Font.GothamBold,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left
local colors={{Color3.fromRGB(220,50,50),"Vermelho"},{Color3.fromRGB(50,150,255),"Azul"},{Color3.fromRGB(50,220,50),"Verde"},{Color3.fromRGB(200,50,200),"Roxo"},{Color3.fromRGB(255,165,0),"Laranja"},{Color3.fromRGB(255,220,50),"Amarelo"}}
local yOff=80
for _,data in pairs(colors)do local col,name=data[1],data[2]createListBtn(cf,"● "..name,yOff,function()guiColors.Accent=col hd.BackgroundColor3=col for _,obj in pairs({sg:GetDescendants()})do if obj:IsA("UIStroke")then obj.Color=col end end mb.BackgroundColor3=col tc.ScrollBarImageColor3,cf.ScrollBarImageColor3=col,col end)yOff=yOff+45 end
end
local function createTab(name,icon,order,contentFunc)
local tab=Instance.new("TextButton",tc)tab.Size,tab.BackgroundColor3,tab.Text,tab.Font,tab.TextSize,tab.TextColor3,tab.TextXAlignment,tab.BorderSizePixel,tab.LayoutOrder=UDim2.new(1,0,0,40),Color3.fromRGB(40,40,45),icon.." "..name,Enum.Font.Gotham,14,Color3.fromRGB(200,200,200),Enum.TextXAlignment.Left,0,order
Instance.new("UICorner",tab).CornerRadius=UDim.new(0,6)Instance.new("UIPadding",tab).PaddingLeft=UDim.new(0,12)
tab.MouseEnter:Connect(function()if currentTab~=tab then TS:Create(tab,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,65)}):Play()end end)
tab.MouseLeave:Connect(function()if currentTab~=tab then TS:Create(tab,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(40,40,45)}):Play()end end)
tab.MouseButton1Click:Connect(function()if currentTab then TS:Create(currentTab,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(40,40,45),TextColor3=Color3.fromRGB(200,200,200)}):Play()end currentTab=tab TS:Create(tab,TweenInfo.new(0.2),{BackgroundColor3=guiColors.Accent,TextColor3=Color3.fromRGB(255,255,255)}):Play()for _,child in ipairs(cf:GetChildren())do if child:IsA("GuiObject")then child:Destroy()end end cf.CanvasSize=UDim2.new(0,0,0,0)if contentFunc then contentFunc()task.wait(0.1)local h=0 for _,child in ipairs(cf:GetChildren())do if child:IsA("GuiObject")then local b=child.Position.Y.Offset+child.Size.Y.Offset if b>h then h=b end end end cf.CanvasSize=UDim2.new(0,0,0,h+20)end end)
end
createTab("Player","👤",1,createPlayerContent)
createTab("Teleport","📍",2,createTeleportContent)
createTab("ESP","👁️",3,createESPContent)
createTab("Misc","⚙️",4,createMiscContent)
mouse.Button1Down:Connect(function()if ctrlTP and UIS:IsKeyDown(Enum.KeyCode.LeftControl)and mouse.Target then tpTo(mouse.Hit.Position+Vector3.new(0,3,0))end end)
local dragging,dragInput,dragStart,startPos
hd.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true dragStart,startPos=input.Position,mf.Position input.Changed:Connect(function()if input.UserInputState==Enum.UserInputState.End then dragging=false end end)end end)
hd.InputChanged:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end end)
UIS.InputChanged:Connect(function(input)if input==dragInput and dragging then local delta=input.Position-dragStart mf.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)end end)
local minDragging,minDragInput,minDragStart,minStartPos
mb.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then minDragging=true minDragStart,minStartPos=input.Position,mb.Position input.Changed:Connect(function()if input.UserInputState==Enum.UserInputState.End then minDragging=false end end)end end)
mb.InputChanged:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseMovement then minDragInput=input end end)
UIS.InputChanged:Connect(function(input)if input==minDragInput and minDragging then local delta=input.Position-minDragStart mb.Position=UDim2.new(minStartPos.X.Scale,minStartPos.X.Offset+delta.X,minStartPos.Y.Scale,minStartPos.Y.Offset+delta.Y)end end)
TS:Create(mf,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-325,0.5,-225)}):Play()
print("LUNION HUB carregado!")