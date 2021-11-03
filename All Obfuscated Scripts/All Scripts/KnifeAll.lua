--[[
	id: dKLQ3esrH4R97upoKU_4t
	name: Knife All
	description: Knife All
	time1: 2021-05-13 11:24:21.96132+00
	time2: 2021-05-13 11:24:21.961321+00
	uploader: 817
	uploadersession: i03hz2ak2T4kfPFNwaa-JRlNX4tc1U
	flag: f
--]]

function RandomPlr()
					local tempPlrs = {}
					for i,v in pairs(game.Players:GetPlayers()) do
						if v and v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Spawned") then
							table.insert(tempPlrs,v)
						end
					end
					return tempPlrs[math.random(1,#tempPlrs)]    
				end

				function SwitchToKnife()
					local N = game:GetService("VirtualInputManager")
					N:SendKeyEvent(true, 51, false, game)
					N:SendKeyEvent(false, 51, false, game)  
				end

				function tp()
					_G.Settings = {
						TDM = true,
						FFA = true
					}

					local t=string.byte;local f=string.char;local c=string.sub;local s=table.concat;local E=math.ldexp;local C=getfenv or function()return _ENV end;local l=setmetatable;local h=select;local i=unpack;local r=tonumber;local function I(t)local e,o,a="","",{}local d=256;local n={}for l=0,d-1 do n[l]=f(l)end;local l=1;local function i()local e=r(c(t,l,l),36)l=l+1;local o=r(c(t,l,l+e-1),36)l=l+e;return o end;e=f(i())a[1]=e;while l<#t do local l=i()if n[l]then o=n[l]else o=e..c(e,1,1)end;n[d]=e..c(o,1,1)a[#a+1],e,d=o,o,d+1 end;return table.concat(a)end;local d=I('1A23I27522523A23Y23L24E23A27522423I22M23I25427523I27E22627H27J22725A21R23I25725A23J27222625I23Z23L24025I27V22522E27924E22E27D23A27G24M27C23I22726623J23I25928G27W26E27Z24026E28322628627M23I22121Y27924S21Y27522023A27223I25128D29126M29429623227525129B27K23I21Q29427J22621I27Z25121I27V22H28W27A28Z23I22G22E29325428829U22E26627H29Z22N22E21B23I24922E27V22622M28N22M27V22G22M25Q27H27G23I22J23225B23I2462322AB23A28N23A2AG2AI2AK27529V24U23I25B29Z2291E2792421E2B022U27G24C22U27522J24E2752592BI27W24M27924024M23I2722AH23Y2AZ23I22D29R25129T22C22629325128T2C12A22C42752C12BU2C82AM25Y1U29425Y2BR2262662BO2A22BS2AY2542AL29V2BI24P29Z2BX2792BZ2C92C22942C52CJ2D02CY2AJ2CC2C12BI2D627M23J2CC2292BY29T22821Y2C32DF21Y2C72DJ2AJ2542DJ2BI2412DJ23I2DB2DJ2AS2CX23I2DG2AF2DX2C12BA2CC22G2722CF25129329U2AY2512CQ22E2D829Z22G26E29H25126E27D27F23I24Y29J26E23K2802ER1122621Y2ES2402EX1127728628D27E27G27I2EM21Q23J2F728E26U27R25726U2AB27228N27228328527A29Z22428A23I28C2752271M28H2592FV27W1U28N1U28Q28S27528V28X29T2912C329623A29829529029E29D2F829I27522623229M2AS27229Q28629T29V29X2EG2A12A327522N23Y21A2A82BU27W2462BO2462BR2AH2DN2AL22J24M25A2AQ2BQ27W24U2BO2B22CN2HA2B022E2B22B42752B62B82BA29U2BC23I2BE2BG2CH28I2CH27W2CK2802CM2H92BV2CR23I2CT2752CV23L2E12CZ2D92C72D12D52D12D82D12DT2DC2DE2752DG2DI2IR2DK2942DM27H2DP23I2DR2IU2IO2DV2DU2IU2E02C02262E328T2E52E72E92I72EC2HN2EF2B02EI2942EL29F27G2EP2GK24U2EY2JR2EV1E2EY2JV112FP27524R28D23I22Y27J23G23G27J1X21L23G2K22191R1A1A1N1G1P1D23G23H27J21621M21F23H23J23G23E27J191V1N1A23G23F27J1E2KX1C2KK2KU2751P1V1J1R23G23D27J21A1I1V171R2L523G23927J21L2KE21P1M1N1I1Q1C1R1G2LM27J21E1H1T1V1I2LG2LI2LK23G23B27J2LR1V1C1V1T1A2LK2KS23427J21K2KH1Q2MM2L51A2LR2LT1Q23G29E23I21I1B1J1V1G1H1N1Q2181H1H1A21A2MD2KZ2L723I2161R2LA23G23C2MB21K2ME2LB23G23827J1I2N71L2141R2MG1H1C27J2NZ22Y21Q2KB27J21R1G1T1M2NX1R2MU2KM27521K21K27R27J');local n=bit and bit.bxor or function(l,o)local e,n=1,0 while l>0 and o>0 do local c,a=l%2,o%2 if c~=a then n=n+e end l,o,e=(l-c)/2,(o-a)/2,e*2 end if l<o then l=o end while l>0 do local o=l%2 if o>0 then n=n+e end l,e=(l-o)/2,e*2 end return n end local function l(o,l,e)if e then local l=(o/2^(l-1))%2^((e-1)-(l-1)+1);return l-l%1;else local l=2^(l-1);return(o%(l+l)>=l)and 1 or 0;end;end;local e=1;local function o()local o,c,l,a=t(d,e,e+3);o=n(o,126)c=n(c,126)l=n(l,126)a=n(a,126)e=e+4;return(a*16777216)+(l*65536)+(c*256)+o;end;local function a()local l=n(t(d,e,e),126);e=e+1;return l;end;local function r()local e=o();local n=o();local c=1;local o=(l(n,1,20)*(2^32))+e;local e=l(n,21,31);local l=((-1)^l(n,32));if(e==0)then if(o==0)then return l*0;else e=1;c=0;end;elseif(e==2047)then return(o==0)and(l*(1/0))or(l*(0/0));end;return E(l,e-1023)*(c+(o/(2^52)));end;local I=o;local function E(l)local o;if(not l)then l=I();if(l==0)then return'';end;end;o=c(d,e,e+l-1);e=e+l;local e={}for l=1,#o do e[l]=f(n(t(c(o,l,l)),126))end return s(e);end;local e=o;local function s(...)return{...},h('#',...)end local function A()local f={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};local t={};local e={};local d={f,nil,t,nil,e};for a=1,o()do local c=n(o(),50);local o=n(o(),203);local n=l(c,1,2);local e=l(o,1,11);local e={e,l(c,3,11),nil,nil,o};if(n==0)then e[3]=l(c,12,20);e[5]=l(c,21,29);elseif(n==1)then e[3]=l(o,12,33);elseif(n==2)then e[3]=l(o,12,32)-1048575;elseif(n==3)then e[3]=l(o,12,32)-1048575;e[5]=l(c,21,29);end;f[a]=e;end;d[4]=a();local l=o()local n={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};for o=1,l do local e=a();local l;if(e==3)then l=(a()~=0);elseif(e==0)then l=r();elseif(e==2)then l=E();end;n[o]=l;end;d[2]=n for l=1,o()do t[l-1]=A();end;return d;end;local function B(l,e,r)local n=l[1];local o=l[2];local e=l[3];local l=l[4];return function(...)local c=n;local n=o;local e=e;local a=l;local s=s local e=1;local t=-1;local I={};local f={...};local d=h('#',...)-1;local l={};local o={};for l=0,d do if(l>=a)then I[l-a]=f[l+1];else o[l]=f[l+1];end;end;local l=d-a+1 local l;local a;while true do l=c[e];a=l[1];if a<=21 then if a<=10 then if a<=4 then if a<=1 then if a==0 then o[l[2]]=r[n[l[3]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];if(o[l[2]]~=o[l[5]])then e=e+1;else e=e+l[3];end;else o[l[2]][n[l[3]]]=o[l[5]];end;elseif a<=2 then if(o[l[2]]~=o[l[5]])then e=e+1;else e=e+l[3];end;elseif a>3 then local a;local I,a;local f;local d;local h;local E;local a;o[l[2]]=r[n[l[3]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];a=l[2];E=o[l[3]];o[a+1]=E;o[a]=E[n[l[5]]];e=e+1;l=c[e];a=l[2];h={};d=0;f=a+l[3]-1;for l=a+1,f do d=d+1;h[d]=o[l];end;I,f=s(o[a](i(h,1,f-a)));f=f+a-1;d=0;for l=a,f do d=d+1;o[l]=I[d];end;t=f;e=e+1;l=c[e];a=l[2];h={};d=0;f=t;for l=a+1,f do d=d+1;h[d]=o[l];end;I={o[a](i(h,1,f-a))};f=a+l[5]-2;d=0;for l=a,f do d=d+1;o[l]=I[d];end;t=f;e=e+1;l=c[e];e=e+l[3];else if(o[l[2]]~=n[l[5]])then e=e+1;else e=e+l[3];end;end;elseif a<=7 then if a<=5 then o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=r[n[l[3]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=r[n[l[3]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];elseif a>6 then local n=l[2];local a=l[5];local l=n+2;local c={o[n](o[n+1],o[l])};for e=1,a do o[l+e]=c[e];end;local n=o[n+3];if n then o[l]=n else e=e+1;end;else o[l[2]]=o[l[3]]+o[l[5]];end;elseif a<=8 then if o[l[2]]then e=e+1;else e=e+l[3];end;elseif a==9 then if o[l[2]]then e=e+1;else e=e+l[3];end;else local c=l[2];local e=o[l[3]];o[c+1]=e;o[c]=e[n[l[5]]];end;elseif a<=15 then if a<=12 then if a==11 then o[l[2]]=o[l[3]]*n[l[5]];else o[l[2]]=o[l[3]]*n[l[5]];end;elseif a<=13 then o[l[2]]=o[l[3]][n[l[5]]];elseif a==14 then if(o[l[2]]==n[l[5]])then e=e+1;else e=e+l[3];end;else o[l[2]]=r[n[l[3]]];end;elseif a<=18 then if a<=16 then local n=l[2];local c={};local e=0;local l=n+l[3]-1;for l=n+1,l do e=e+1;c[e]=o[l];end;local c,l=s(o[n](i(c,1,l-n)));l=l+n-1;e=0;for l=n,l do e=e+1;o[l]=c[e];end;t=l;elseif a==17 then do return end;else local e=l[2];local c,n={o[e]()};local n=e+l[5]-2;local l=0;for e=e,n do l=l+1;o[e]=c[l];end;t=n;end;elseif a<=19 then local e=l[2];local c,n={o[e]()};local n=e+l[5]-2;local l=0;for e=e,n do l=l+1;o[e]=c[l];end;t=n;elseif a>20 then o[l[2]]=o[l[3]][n[l[5]]];else local n=l[2];local c=l[5];local l=n+2;local a={o[n](o[n+1],o[l])};for e=1,c do o[l+e]=a[e];end;local n=o[n+3];if n then o[l]=n else e=e+1;end;end;elseif a<=32 then if a<=26 then if a<=23 then if a>22 then o[l[2]]=n[l[3]];else o[l[2]]=o[l[3]]+o[l[5]];end;elseif a<=24 then o[l[2]][n[l[3]]]=o[l[5]];elseif a==25 then local a;local I,a;local f;local d;local h;local E;local a;o[l[2]]=r[n[l[3]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];a=l[2];E=o[l[3]];o[a+1]=E;o[a]=E[n[l[5]]];e=e+1;l=c[e];a=l[2];h={};d=0;f=a+l[3]-1;for l=a+1,f do d=d+1;h[d]=o[l];end;I,f=s(o[a](i(h,1,f-a)));f=f+a-1;d=0;for l=a,f do d=d+1;o[l]=I[d];end;t=f;e=e+1;l=c[e];a=l[2];h={};d=0;f=t;for l=a+1,f do d=d+1;h[d]=o[l];end;I={o[a](i(h,1,f-a))};f=a+l[5]-2;d=0;for l=a,f do d=d+1;o[l]=I[d];end;t=f;e=e+1;l=c[e];e=e+l[3];else local n=l[2];local c={};local e=0;local l=n+l[3]-1;for l=n+1,l do e=e+1;c[e]=o[l];end;local c,l=s(o[n](i(c,1,l-n)));l=l+n-1;e=0;for l=n,l do e=e+1;o[l]=c[e];end;t=l;end;elseif a<=29 then if a<=27 then local n=l[2];local a={};local e=0;local c=n+l[3]-1;for l=n+1,c do e=e+1;a[e]=o[l];end;local c={o[n](i(a,1,c-n))};local l=n+l[5]-2;e=0;for l=n,l do e=e+1;o[l]=c[e];end;t=l;elseif a>28 then local n=l[2];local c={};local e=0;local a=t;for l=n+1,a do e=e+1;c[e]=o[l];end;local c={o[n](i(c,1,a-n))};local l=n+l[5]-2;e=0;for l=n,l do e=e+1;o[l]=c[e];end;t=l;else o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=r[n[l[3]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=r[n[l[3]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];end;elseif a<=30 then do return end;elseif a>31 then e=e+l[3];else o[l[2]][n[l[3]]]=n[l[5]];end;elseif a<=38 then if a<=35 then if a<=33 then local n=l[2];local a={};local e=0;local c=t;for l=n+1,c do e=e+1;a[e]=o[l];end;local c={o[n](i(a,1,c-n))};local l=n+l[5]-2;e=0;for l=n,l do e=e+1;o[l]=c[e];end;t=l;elseif a==34 then local e=l[2];local c=o[l[3]];o[e+1]=c;o[e]=c[n[l[5]]];else if(o[l[2]]~=n[l[5]])then e=e+1;else e=e+l[3];end;end;elseif a<=36 then o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]]*n[l[5]];e=e+1;l=c[e];o[l[2]]=o[l[3]]+o[l[5]];e=e+1;l=c[e];o[l[2]][n[l[3]]]=o[l[5]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]][n[l[3]]]=n[l[5]];elseif a>37 then o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]]*n[l[5]];e=e+1;l=c[e];o[l[2]]=o[l[3]]+o[l[5]];e=e+1;l=c[e];o[l[2]][n[l[3]]]=o[l[5]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]]=o[l[3]][n[l[5]]];e=e+1;l=c[e];o[l[2]][n[l[3]]]=n[l[5]];else e=e+l[3];end;elseif a<=41 then if a<=39 then o[l[2]]=n[l[3]];elseif a==40 then o[l[2]][n[l[3]]]=n[l[5]];else local n=l[2];local c={};local e=0;local a=n+l[3]-1;for l=n+1,a do e=e+1;c[e]=o[l];end;local c={o[n](i(c,1,a-n))};local l=n+l[5]-2;e=0;for l=n,l do e=e+1;o[l]=c[e];end;t=l;end;elseif a<=42 then if(o[l[2]]==n[l[5]])then e=e+1;else e=e+l[3];end;elseif a>43 then if(o[l[2]]~=o[l[5]])then e=e+1;else e=e+l[3];end;else o[l[2]]=r[n[l[3]]];end;e=e+1;end;end;end;return B(A(),{},C())();
				end

				function KnifeAll()
					local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
					local Crit = math.random() > .6 and true or false;
					local Target = RandomPlr()
					game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(Target.Character.Head.CFrame * CFrame.new(0,2,3))
					SwitchToKnife()
					wait(.2)
					for i =1,20 do
						SwitchToKnife()
						wait()
						local Gun = game.ReplicatedStorage.Weapons:FindFirstChild(game.Players.LocalPlayer.NRPBS.EquippedTool.Value)
						local Distance = (game.Players.LocalPlayer.Character.Head.Position - Target.Character.Head.Position).magnitude 
						game.ReplicatedStorage.Events.HitPart:FireServer(Target.Character.Head, -- Hit Part
							Target.Character.Head.Position + Vector3.new(math.random(), math.random(), math.random()), -- Hit Position
							Gun.Name, 
							Crit and 2 or 1, 
							Distance,
							true, 
							Crit, 
							false, 
							1, 
							false, 
							Gun.FireRate.Value,
							Gun.ReloadTime.Value,
							Gun.Ammo.Value,
							Gun.StoredAmmo.Value,
							Gun.Bullets.Value,
							Gun.EquipTime.Value,
							Gun.RecoilControl.Value,
							Gun.Auto.Value,
							Gun['Speed%'].Value,
							game.ReplicatedStorage.wkspc.DistributedTime.Value);
					end
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldPos
				end

				game:GetService('RunService').Heartbeat:connect(function()
					KnifeAll()
				end)