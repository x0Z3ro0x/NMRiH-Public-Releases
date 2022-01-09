#include <sourcemod>
#include <sdktools>
#include <colors>

char link[] = "discord.gg/vZ7KMAe";
char autoMsg[255];
new Handle:dkaa_isRandomMsg;
//new Handle:dkaa_totalMsg;
int rollStart = 0;

public Plugin:myinfo =
{
	name = "Dark Karma Auto Announcer",
	author = "x0Z3ro0x",
	description = "A mod for automatically announcing our discord community every so often.",
	version = "1.0",
	url = "https://dkgaming.us"
};

// Events

public void OnPluginStart()
{
	// Convars
	CreateConVar("dkaa_random_msg", "false", "Sets if messages are random", FCVAR_DONTRECORD|FCVAR_NEVER_AS_STRING);
	CreateConVar("dkaa_num_of_msg", "2", "Sets how many messages to send", FCVAR_DONTRECORD|FCVAR_NEVER_AS_STRING);
	AutoExecConfig(true, "dkaa");
	
	// Timers
	CreateTimer(3.5, Timer_Loaded);
	CreateTimer(300.0, Timer_Auto, _, TIMER_REPEAT);

	// Commands
	RegAdminCmd("/ann", Announce_Command, ADMFLAG_KICK, "A command to announce a custom message");
	RegAdminCmd("/link", Link_Command, ADMFLAG_KICK, "A command to link our discord");
}

public OnAllPluginsLoaded()
{
	dkaa_isRandomMsg = FindConVar("dkaa_random_msg");
	//dkaa_totalMsg = FindConVar("dkaa_num_of_msg");
}

public OnClientPutInServer(client)
{
	CreateTimer(45.0, Timer_Join, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
}

// Command Handling

// Announce Command
public Action:Announce_Command(client, args)
{
	if (args < 1)
	{
		PrintToConsole(client, "[DKG]Proper Usage: /ann '<message>'");
		return Plugin_Handled;
	}
	new String:Arg1[255];
	GetCmdArg(1, Arg1, sizeof(Arg1));

	PrintToChatAll("%s", Arg1);
	return Plugin_Handled;
}

// Link Command
public Action:Link_Command(client, args)
{
	if (args > 0)
	{
		PrintToConsole(client, "[DKG]Proper Usage: /link");
		return Plugin_Handled;
	}

	CPrintToChatAll("Have you fine folks heard about our Discord Community? It's small, but cozy. Come check us out at \n\n{red}%s", link);
	return Plugin_Handled;
}

// Timers

// Player Loaded Timer Function
public Action:Timer_Join(Handle:timer, any:data)
{
	new client = GetClientOfUserId(data);
	if (client == 0)
	{
		return Plugin_Stop;
	}
	decl String:name[MAX_NAME_LENGTH];
	GetClientName(client, name, sizeof(name));
	CPrintToChat(client, "{default}Hello {red}%s{default}, Thanks for playing on a {red}Dark Karma {default}server! If you feel like it, come join the \
	community for more servers and a place to hang out.\n\n{red}%s", name, link);
	return Plugin_Stop;
}

// Plugin Loaded Timer Function
public Action:Timer_Loaded(Handle:timer)
{
	PrintToServer("Dark Karma Auto Announcer loaded!");
}

// Auto Announce Timer Function
#include <dkaa_autotimer>