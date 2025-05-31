### This repository is now marked as deprecated.
With the recent 64-bit update in February, the `logic_eventlistener` entity should be used to replace `trigger_brush` entities, making this plugin unnecessary for future map updates.

### The plugin is deprecated due to the following reasons:

- The `trigger_brush` entities are being replaced by the `logic_eventlistener` entity.
- Server managers are encouraged to update their maps to utilize the new entity.

[sm-plugin-zombiereloaded v3.12.7+](https://github.com/srcdslab/sm-plugin-zombiereloaded) keep the event support from `trigger_brush` via cvar (`zr_infect_skip_trigger_brush`) for
- `game_playerdie`
- `game_playerkill`

**`game_playershot` event can (and should) be handled via vscript since its not an original event from the game engine.**
