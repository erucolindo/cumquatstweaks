A CoD2 mod that adds random features and gamemodes made for our private CoD2 server.

Install:

Make a zip file containing all the files. Rename the file extention to .iwd. Place the file in the main folder in the game installation directory. Make sure all the clients and the server have the mod installed. Make sure the server is set to "Pure: No"

Most of the features are accessable under the Cumquats Tweaks menu in game. There's no security implemented, so anyone on the server can change settings.

Features:
* A option to select a random weapon.
* A setting for getting a random weapon everytime you respawn.
* Forcing you to get the last kill with pistol in DM.
* Drop current weapon by pressing "r" in menu. (TODO: try to figure out a hotkey in game)
* Shows the range in the kill feed.
* Added a setting for disabling killcam.
* Added a settable respawn delay in TDM.
* Keep track of killsteaks and display messages á la Quake.
* Modifier: Getting grenades at killstreaks instead of when you spawn.
* Modifier: Instagib.
* Modifier: Pistols only.
* Modifier: Spawn with two primary weapons.
* Modifier: Swap weapon with the person you kill.
* Game Mode: Crazy. Silly modifiers that switch at least every minute.
* Game Mode: Gun Game. Loosely based on CS:GO gun game.

Server variables:

cqt_random_weapons - If true random weapons at respawn is enabled by default on new map.
cqt_tdm_respawntime - Respawn timer in ms for TDM. If set to 0 there's no respawn delay.
