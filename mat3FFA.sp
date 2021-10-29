#pragma semicolon 1

#define DEBUG


#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <profiler>
#include <sdkhooks>

#pragma newdecls required
#pragma semicolon 1

ConVar teamAreEnemies;
ConVar g_hFFAPlayerCount;

public Plugin myinfo = 
{
	name = "FFA",
	author = "mat3",
	description = " ",
	version = "1.0",
	url = ""
};

public void OnPluginStart()
{
	AutoExecConfig(true, "plugin.hffa", "sourcemod"); //configot loadolja
	
	g_hFFAPlayerCount = CreateConVar("sm_hFFA_playercount", "12", "Set the player count when ffa is enabled");  //beallitja x re az ff a kikapcsolasat
	

	teamAreEnemies = FindConVar("mp_teammates_are_enemies"); //convar semmi extra
	
	HookEvent("round_prestart", Event_RoundStart);  //hook
	
	
    
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	
	if(GetClientCount() < g_hFFAPlayerCount.IntValue + 1)
    {
        teamAreEnemies.BoolValue = true;
        PrintToChatAll("\x04[NightLight FFA] \x05Friendly fire is \x04activated");  //chat uzenete amikor aktiv
        
	} else if(GetClientCount() > g_hFFAPlayerCount.IntValue)
	{
   		teamAreEnemies.BoolValue = false;
   		PrintToChatAll("\x04[NightLight FFA] \x05Friendly fire is \x02deactivated"); //chat uzenete amikor inaktiv
   		
	}
}