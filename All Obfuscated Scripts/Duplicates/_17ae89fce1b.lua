--[[
	id: vo1Yjh3yvpHHzc3r9fsqA
	name: 111
	description: 111
	time1: 2021-07-10 12:25:47.451702+00
	time2: 2021-07-10 12:25:47.451703+00
	uploader: BFReGeAMylciW-sUJ2Xikhpg5rRSIjKEcipYwjCe
	uploadersession: JMKjqxmXLaBiUtkFk2uJPGLwKFUSkP
	flag: f
--]]

//----------------------------------------------------------<Globals Begin>----------------------------------------------------------//
//---------------------<Var Begin>---------------------//
UI.AddCheckbox("LBY Break");
UI.AddSliderInt("LBY Break Delay Tick", 1, 100);
UI.AddCheckbox("Fake Yaw");
UI.AddSliderInt("Fake Yaw Delay Tick", 1, 100);
UI.AddHotkey("Inv");
var tickcount = 0;
//---------------------<Var End>---------------------//
//---------------------<Main Begin>---------------------//
function P(t)
{
Cheat.Print ("[Dawn] " + t + "\n");
}
//---------------------<Main End>---------------------//
//----------------------------------------------------------<Globals End>----------------------------------------------------------//





//----------------------------------------------------------<Features Begin>----------------------------------------------------------//
//---------------------<Var Begin>---------------------//
var lasttickcount1 = 0;
var lasttickcount2 = 0
var inv2 = 0
var inv2f = 2
//---------------------<Var End>---------------------//
//---------------------<Main Begin>---------------------//
function LBYBreak ()
{
	var LBY_Break_Delay_Tick = UI.GetValue("Misc", "JAVASCRIPT", "Script items", "LBY Break Delay Tick");
	var movement = UserCMD.GetMovement();
	forward = movement[0];
	side = movement[1];
	up = movement[2];
	if (forward == 0 && side == 0 && up == 0 && tickcount > lasttickcount1)
	{
		var m_fFlags = Entity.GetProp(Entity.GetLocalPlayer(), "CBasePlayer", "m_fFlags");
		if (m_fFlags != 263)
		{
			UserCMD.SetMovement( [ 1.01, 0, 0 ] );	
		}
		else
		{
			UserCMD.SetMovement( [ 2.97, 0, 0 ] );
		}	

		lasttickcount1 = tickcount + LBY_Break_Delay_Tick;
	}	
}	
//---------------------<Main End>---------------------//
//----------------------------------------------------------<Features End>----------------------------------------------------------//





//----------------------------------------------------------<Hooks Begin>----------------------------------------------------------//
//---------------------<Var Begin>---------------------//

//---------------------<Var End>---------------------//
var lasttickcount3 = 0
var inv3 = 0
//---------------------<Main Begin>---------------------//
function onCreateMove()
{	
	tickcount = Globals.Tickcount();
	//P("Ticks elapsed on server: " + tickcount);

	if (UI.GetValue("Misc", "JAVASCRIPT", "Script items", "LBY Break")) 
	{
		LBYBreak ();
	}		
	
	AntiAim.SetOverride(1);
	var invv3 = UI.IsHotkeyActive('Misc', 'JAVASCRIPT', 'Script items', "Inv")
	if (tickcount > lasttickcount3)
	{
		inv3 ++;	
		if (inv3 > 2)
		{
			inv3 = 1;
		}
		if (invv3)
		{
			if (inv3 == 1)
			{
				AntiAim.SetRealOffset(-78);
				AntiAim.SetLBYOffset(44);
			}
			else
			{
				AntiAim.SetRealOffset(-9);
				AntiAim.SetLBYOffset(-60);			
			}
		}
		else
		{
			if (inv3 == 1)
			{

				AntiAim.SetRealOffset(-9);
				AntiAim.SetLBYOffset(-60);
			}
			else
			{
				AntiAim.SetRealOffset(-78);
				AntiAim.SetLBYOffset(44);
			}
		}				
		lasttickcount3 = tickcount + UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Fake Yaw Delay Tick")
	}				
}
Cheat.RegisterCallback("CreateMove", "onCreateMove")
//---------------------<Main End>---------------------//
//----------------------------------------------------------<Hooks End>----------------------------------------------------------//




