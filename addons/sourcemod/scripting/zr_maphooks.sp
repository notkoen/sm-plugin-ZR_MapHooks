#pragma newdecls required
#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <zombiereloaded>

ConVar g_hCVar_ZRInfectKill;
ConVar g_hCVar_PlayerShotHook;
ConVar g_hCVar_PlayerShotCount;

int g_PlayerShotCurrent[MAXPLAYERS + 1] = {0, ...};

public Plugin myinfo =
{
    name = "ZR MapHooks",
    author = "BotoX",
    description = "Enables map interactions with Zombie:Reloaded and fixes game_playershot for trigger_brush",
    version = "0.2",
};

public void OnPluginStart()
{
    g_hCVar_ZRInfectKill    = CreateConVar("zr_shotinfectkill",  "1", "Enable the game_playerdie/kill entities to be triggered by ZR.", 0, true, 0.0, true, 1.0);
    g_hCVar_PlayerShotHook  = CreateConVar("zr_playershothook",  "1", "Enable the usage of the game_playershot entity.", 0, true, 0.0, true, 1.0);
    g_hCVar_PlayerShotCount = CreateConVar("zr_playershotcount", "1", "Bullet count required per game_playershot call.", 0, true, 1.0);
    AutoExecConfig();

    HookEvent("player_hurt", EventPlayerHurt);
}

public void ZR_OnClientInfected(int client, int attacker, bool motherInfect, bool respawnOverride, bool respawn)
{
    if (g_hCVar_ZRInfectKill.BoolValue && !motherInfect)
    {
        int entity = INVALID_ENT_REFERENCE;
        while ((entity = FindEntityByClassname(entity, "trigger_brush")) != INVALID_ENT_REFERENCE)
        {
            static char sTargetname[64];
            GetEntPropString(entity, Prop_Data, "m_iName", sTargetname, sizeof(sTargetname));

            if (client > 0 && strcmp(sTargetname, "game_playerdie", false) == 0)
                AcceptEntityInput(entity, "Use", client, client);
            else if (attacker > 0 && strcmp(sTargetname, "game_playerkill", false) == 0)
                AcceptEntityInput(entity, "Use", attacker, attacker);
        }
    }
}

public Action EventPlayerHurt(Handle event, const char[] name, bool dontBroadcast)
{
    if (g_hCVar_PlayerShotHook.BoolValue)
    {
        int attacker = GetClientOfUserId(GetEventInt(event, "attacker"));

        if (attacker <= 0)
            return Plugin_Continue;

        if (g_hCVar_PlayerShotCount.IntValue > 1)
        {
            g_PlayerShotCurrent[attacker] = g_PlayerShotCurrent[attacker] + 1;
            if (g_PlayerShotCurrent[attacker] >= g_hCVar_PlayerShotCount.IntValue)
            {
                g_PlayerShotCurrent[attacker] = 0;
                FirePlayerShot(attacker);
            }
        }
        else
        {
            FirePlayerShot(attacker);
        }
    }
    return Plugin_Continue;
}

void FirePlayerShot(int client)
{
    int entity = INVALID_ENT_REFERENCE;
    while ((entity = FindEntityByClassname(entity, "trigger_brush")) != INVALID_ENT_REFERENCE)
    {
        static char sTargetname[64];
        GetEntPropString(entity, Prop_Data, "m_iName", sTargetname, sizeof(sTargetname));

        if (strcmp(sTargetname, "game_playershot", false) == 0)
            AcceptEntityInput(entity, "Use", client, client);
    }
}