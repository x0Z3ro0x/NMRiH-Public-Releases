#include <sourcemod>
#include <sdktools>
#include <colors>
int fuckYou;

public Plugin:myinfo =
{
	name = "Dark Karma Anti Team-Kill",
	author = "x0Z3ro0x",
	description = "A mod for punishing team killers.",
	version = "1.0",
	url = "https://dkgaming.us"
};

public OnPluginStart()
{
    HookEvent("nmrih_reset_map", Event_ResetTK);
    HookEvent("player_death", Event_PlayerDeath);
    HookEvent("player_hurt", Event_PlayerDmg);
    CreateTimer(3.5, Timer_Loaded);
}

public Event_PlayerDmg(Event event, const char[] name, bool dontBroadcast)
{
    char weapon[64];
    char vicname[64];
    char attname[64];

    int victimId = event.GetInt("userid");
    int victim = GetClientOfUserId(victimId);

    int attackerId = event.GetInt("attacker");
    int attacker = GetClientOfUserId(attackerId);

    event.GetString("weapon",  weapon, sizeof(weapon));
    GetClientName(attacker, attname, sizeof(attname));
    GetClientName(victim, vicname, sizeof(vicname));

    #include <dktk_array>

    if(attacker == 0 || attacker == victim || !attacker)
    {
        
    }
    else
    {
        SlapPlayer(attacker, 50, true);
        CPrintToChat(attacker, "You just damaged {red}%s{default} with one of your careless attacks. Be more careful \
        in the future {red}%s{default}!", vicname, attname);
    }
}

public Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
    char weapon[64];
    char vicname[64];
    char attname[64];
    int victimId = event.GetInt("userid");
    int victim = GetClientOfUserId(victimId);
    int attackerId = event.GetInt("attacker");
    int attacker = GetClientOfUserId(attackerId);

    event.GetString("weapon",  weapon, sizeof(weapon));
    GetClientName(attacker, attname, sizeof(attname));
    GetClientName(victim, vicname, sizeof(vicname));
    
    #include <dktk_array>

    if(attacker == 0)
    {
        
    }
    else if (attacker == victim)
    {
        CPrintToChatAll("{red}%s{default} has taken their own life.", vicname);
    }
    else if (!attacker)
    {

    }
    else
    {
        char kReason[275] =  "Woah chill out! You just killed %s. This is a realism server with \
        friendly fire. Continuing to TK too often will result in a ban. Be more careful or join \
        our casual server";
        char bReason[275] = "We warned you to be more careful when attacking. This is a realism \
        server. That means you can hurt your team mates. Ruining the game for others isn't cool. \
        You can appeal this ban at https://discord.gg/vZ7KMAe";

        if (fuckYou >= 2)
        {
            BanClient(attacker, 360, BANFLAG_AUTHID, "Player Killing", bReason, "" , 0);
        }
        else if (fuckYou == 1)
        {
            fuckYou++;
            KickClient(attacker, kReason, vicname);
        }
        else
        {
            fuckYou++;
            SlapPlayer(attacker, 50, true);
            CPrintToChat(attacker, "{red}You just killed %s. You need to be more careful!", vicname);
            CPrintToChat(victim, "{red}%s{default} just killed you with {red}%s{default}.", attname, weapon);
            CreateTimer(600.0, TK_Clear, attacker, TIMER_FLAG_NO_MAPCHANGE);
        }
    }
}

public void Event_ResetTK(Event event, const char[] name, bool dontBroadcast)
{
    fuckYou = 0;
}

public Action:TK_Clear(Handle:timer, any:data)
{
    fuckYou = 0;
    CPrintToChat(data, "{red}Your TK Count has been reset! Thank you for being careful.");
}

public Action:Timer_Loaded(Handle:timer)
{
    PrintToServer("Dark Karma Anti Team-Kill loaded!");
}