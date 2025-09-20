
### ZR MapHooks

This plugin allows for maps to trigger the `game_playerdie`, `game_playerkill`, and `game_playershot` events for `trigger_brush` entities.

> [!CAUTION]
> The 64-bit update in February introduced the `logic_eventlistener` entity, which provides better event hooks for mappers to use. It is recommended that mappers use this entity over the plugin as it is native to the game and does not require plugins.

> [!TIP]
> [sm-plugin-zombiereloaded v3.12.7+](https://github.com/srcdslab/sm-plugin-zombiereloaded) was updated to maintain support for `trigger_brush` via cvar (`zr_infect_skip_trigger_brush`) for both `game_playershot` and `game_playerdie` events.
