#include <sourcemod>
#include <sdktools>
#include <colors>

public Plugin:myinfo =
{
	name = "Dark Karma Health Display",
	author = "x0Z3ro0x",
	description = "A mod to toggle usernames 'health' on and off.",
	version = "1.0",
	url = "https://dkgaming.us"
};

public void OnPluginStart()
{
    CreateConVar("dkhd_toggle", "true", "Defines if health display should be toggle or always off.", FCVAR_DONTRECORD|FCVAR_NEVER_AS_STRING);
}