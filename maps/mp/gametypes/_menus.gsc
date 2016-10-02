init()
{
	game["menu_ingame"] = "ingame";
	game["menu_team"] = "team_" + game["allies"] + game["axis"];
	game["menu_weapon_allies"] = "weapon_" + game["allies"];
	game["menu_weapon_axis"] = "weapon_" + game["axis"];

	precacheMenu(game["menu_ingame"]);
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_weapon_allies"]);
	precacheMenu(game["menu_weapon_axis"]);
	precacheMenu("cumquats");

	if(!level.xenon)
	{
		game["menu_callvote"] = "callvote";
		game["menu_muteplayer"] = "muteplayer";

		precacheMenu(game["menu_callvote"]);
		precacheMenu(game["menu_muteplayer"]);
	}
	else
	{
		level.splitscreen = isSplitScreen();
		if(level.splitscreen)
		{
			game["menu_team"] += "_splitscreen";
			game["menu_weapon_allies"] += "_splitscreen";
			game["menu_weapon_axis"] += "_splitscreen";
			game["menu_ingame_onteam"] = "ingame_onteam_splitscreen";
			game["menu_ingame_spectator"] = "ingame_spectator_splitscreen";

			precacheMenu(game["menu_team"]);
			precacheMenu(game["menu_weapon_allies"]);
			precacheMenu(game["menu_weapon_axis"]);
			precacheMenu(game["menu_ingame_onteam"]);
			precacheMenu(game["menu_ingame_spectator"]);
		}
	}

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player thread onMenuResponse();
	}
}

onMenuResponse()
{
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		//iprintln("^6", response);

		if(response == "back")
		{
			self closeMenu();
			self closeInGameMenu();

			if(menu == game["menu_team"])
			{
				if(level.splitscreen)
				{
					if(self.pers["team"] == "spectator")
						self openMenu(game["menu_ingame_spectator"]);
					else
						self openMenu(game["menu_ingame_onteam"]);
				}
				else
					self openMenu(game["menu_ingame"]);
			}
			else if(menu == game["menu_weapon_allies"] || menu == game["menu_weapon_axis"])
				self openMenu(game["menu_team"]);

			continue;
		}

		if(response == "togglerandom")
		{
			self closeMenu();
			self closeInGameMenu();

			if(level.randomweapons == false)
			{
				level.randomweapons = true;
				maps\mp\gametypes\_cumquats::sayBoldAll("^2Random weapon at respawn is now enabled.");
			}
			else
			{
				level.randomweapons = false;
				maps\mp\gametypes\_cumquats::sayBoldAll("^1Random weapon at respawn is now disabled.");
			}

			continue;
		}

		if(response == "togglegrenades")
		{
			self closeMenu();
			self closeInGameMenu();

			if(level.killstreakgrenades == false)
			{
				level.killstreakgrenades = true;
				maps\mp\gametypes\_cumquats::sayBoldAll("^2Grenades at killstreaks is now enabled.");
			}
			else
			{
				level.killstreakgrenades = false;
				maps\mp\gametypes\_cumquats::sayBoldAll("^1Grenade at killstreaks is now disabled.");
			}

			continue;
		}

		if(response == "togglecrazy")
		{
			self closeMenu();
			self closeInGameMenu();

			if(level.gamemode == "crazy")
			{
				level.gamemode = "default";
				maps\mp\gametypes\_cumquats::sayBoldAll("^1C^2r^3a^4z^5y ^6F^1u^2n ^3M^4o^5d^6e ^1Ended!");
				//stop fun mode
			}
			else
			{
				level.gamemode = "crazy";
				maps\mp\gametypes\_cumquats::sayBoldAll("^1C^2r^3a^4z^5y ^6F^1u^2n ^3M^4o^5d^6e ^2Activated!");
				//initiated fun mode
			}

			level notify("togglegamemodes");
			continue;
		}

		if(response == "togglekillcam")
		{
			self closeMenu();
			self closeInGameMenu();

			if(level.showkillcam == false)
			{
				level.showkillcam = true;
				maps\mp\gametypes\_cumquats::sayBoldAll("^2Killcam is now enabled.");
			}
			else
			{
				level.showkillcam = false;
				maps\mp\gametypes\_cumquats::sayBoldAll("^1Killcam is now disabled.");
			}

			continue;
		}

		if(response == "dropweapon")
		{
			self closeMenu();
			self closeInGameMenu();
			self maps\mp\gametypes\_weapons::dropWeapon();

			continue;
		}

		if(response == "togglepistol")
		{
			self closeMenu();
			self closeInGameMenu();

			if(level.gamemode == "pistol")
			{
				level.gamemode = "default";
				maps\mp\gametypes\_cumquats::sayBoldAll("^1Pistol Mode is now disabled.");
			}
			else
			{
				level.gamemode = "pistol";
				maps\mp\gametypes\_cumquats::sayBoldAll("^2Pistol Mode is now enabled.");
			}

			level notify("togglegamemodes");
			continue;
		}

		if(response == "toggledual")
		{
			self closeMenu();
			self closeInGameMenu();

			if(level.gamemode == "dual")
			{
				level.gamemode = "default";
				maps\mp\gametypes\_cumquats::sayBoldAll("^1Dual Mode is now disabled.");
			}
			else
			{
				level.gamemode = "dual";
				maps\mp\gametypes\_cumquats::sayBoldAll("^2Dual Mode is now enabled.");
			}

			level notify("togglegamemodes");
			continue;
		}

		if(response == "toggleinstagib")
		{
			self closeMenu();
			self closeInGameMenu();

			if(level.instagib == false)
			{
				level.instagib = true;
				level.do_log = false;
				maps\mp\gametypes\_cumquats::sayBoldAll("^2Instagib is now enabled.");
			}
			else
			{
				level.instagib = false;
				level.do_log = true;
				maps\mp\gametypes\_cumquats::sayBoldAll("^1Instagib is now disabled.");
			}

			continue;
		}

		if(response == "togglegun")
		{
			self closeMenu();
			self closeInGameMenu();

			if(level.gamemode == "gun")
			{
				level.gamemode = "default";
				maps\mp\gametypes\_cumquats::sayBoldAll("^1Gun Game has ended.");
			}
			else
			{
				level.gamemode = "gun";
				maps\mp\gametypes\_cumquats::sayBoldAll("^2Gun Game is now on.");
			}

			level notify("togglegamemodes");
			continue;
		}

		if(response == "toggleswap")
		{
			self closeMenu();
			self closeInGameMenu();

			if(level.gamemode == "swap")
			{
				level.gamemode = "default";
				maps\mp\gametypes\_cumquats::sayBoldAll("^1Swap Mode disabled.");
			}
			else
			{
				level.gamemode = "swap";
				maps\mp\gametypes\_cumquats::sayBoldAll("^2Swap Mode enabled.");
			}

			level notify("togglegamemodes");
			continue;
		}


		if(response == "endgame")
		{
			if(level.splitscreen)
				level thread [[level.endgameconfirmed]]();

			continue;
		}

		if(menu == game["menu_ingame"] || (level.splitscreen && (menu == game["menu_ingame_onteam"] || menu == game["menu_ingame_spectator"])))
		{
			switch(response)
			{
			case "changeweapon":
				self closeMenu();
				self closeInGameMenu();
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "changeteam":
				self closeMenu();
				self closeInGameMenu();
				self openMenu(game["menu_team"]);
				break;

			case "muteplayer":
				if(!level.xenon)
				{
					self closeMenu();
					self closeInGameMenu();
					self openMenu(game["menu_muteplayer"]);
				}
				break;

			case "callvote":
				if(!level.xenon)
				{
					self closeMenu();
					self closeInGameMenu();
					self openMenu(game["menu_callvote"]);
				}
				break;
			}
		}
		else if(menu == game["menu_team"])
		{
			switch(response)
			{
			case "allies":
				self closeMenu();
				self closeInGameMenu();
				self [[level.allies]]();
				break;

			case "axis":
				self closeMenu();
				self closeInGameMenu();
				self [[level.axis]]();
				break;

			case "autoassign":
				self closeMenu();
				self closeInGameMenu();
				self [[level.autoassign]]();
				break;

			case "spectator":
				self closeMenu();
				self closeInGameMenu();
				self [[level.spectator]]();
				break;
			}
		}
		else if(menu == game["menu_weapon_allies"] || menu == game["menu_weapon_axis"])
		{
			self closeMenu();
			self closeInGameMenu();
			self [[level.weapon]](response);
		}
		else if(!level.xenon)
		{
			if(menu == game["menu_quickcommands"])
				maps\mp\gametypes\_quickmessages::quickcommands(response);
			else if(menu == game["menu_quickstatements"])
				maps\mp\gametypes\_quickmessages::quickstatements(response);
			else if(menu == game["menu_quickresponses"])
				maps\mp\gametypes\_quickmessages::quickresponses(response);
		}
	}
}
