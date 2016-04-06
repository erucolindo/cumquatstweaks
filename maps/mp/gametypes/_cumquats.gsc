
selectRandomWeapon()
{
	for(;;)
	{
		if(self.pers["team"] == "axis")
		{
			switch(randomInt(6))
			{
			case 0:
				return "mp40_mp";
			case 1:
				return "kar98k_mp";
			case 2:
				return "g43_mp";
			case 3:
				return "kar98k_sniper_mp";
			case 4:
				return "shotgun_mp";
			case 5:
				return "mp44_mp";
			}
		}
		else if(game["allies"] == "american")
		{
			switch(randomInt(7))
			{
			case 0:
				return "greasegun_mp";
			case 1:
				return "m1carbine_mp";
			case 2:
				return "m1garand_mp";
			case 3:
				return "springfield_mp";
			case 4:
				return "shotgun_mp";
			case 5:
				return "thompson_mp";
			case 6:
				return "bar_mp";
			}
		}
		else if(game["allies"] == "british")
		{
			switch(randomInt(7))
			{
			case 0:
				return "sten_mp";
			case 1:
				return "enfield_mp";
			case 2:
				return "m1garand_mp";
			case 3:
				return "enfield_scope_mp";
			case 4:
				return "shotgun_mp";
			case 5:
				return "thompson_mp";
			case 6:
				return "bren_mp";
			}
		}
		else
		{
			switch(randomInt(6))
			{
			case 0:
				return "PPS42_mp";
			case 1:
				return "mosin_nagant_mp";
			case 2:
				return "SVT40_mp";
			case 3:
				return "mosin_nagant_sniper_mp";
			case 4:
				return "shotgun_mp";
			case 5:
				return "ppsh_mp";
			}
		}
	}
}

selectRandomWeaponAll()
{
	switch(randomInt(24))
	{
	case 0:
		return "mp40_mp";
	case 1:
		return "kar98k_mp";
	case 2:
		return "g43_mp";
	case 3:
		return "kar98k_sniper_mp";
	case 4:
		return "mp44_mp";
	case 5:
		return "greasegun_mp";
	case 6:
		return "m1carbine_mp";
	case 7:
		return "m1garand_mp";
	case 8:
		return "springfield_mp";
	case 9:
		return "thompson_mp";
	case 10:
		return "bar_mp";
	case 11:
		return "sten_mp";
	case 12:
		return "enfield_mp";
	case 13:
		return "m1garand_mp";
	case 14:
		return "enfield_scope_mp";
	case 15:
		return "thompson_mp";
	case 16:
		return "bren_mp";
	case 17:
		return "PPS42_mp";
	case 18:
		return "mosin_nagant_mp";
	case 19:
		return "SVT40_mp";
	case 20:
		return "mosin_nagant_sniper_mp";
	case 21:
		return "ppsh_mp";
	default:
		return "shotgun_mp";
	}
}

giveRandomPistol(slot)
{
	pistoltype = randomPistol();

	if(slot == "primary")
		while(pistoltype == self getweaponslotweapon("primaryb"))
			pistoltype = randomPistol();
	else
		while(pistoltype == self getweaponslotweapon("primary"))
			pistoltype = randomPistol();

	self setWeaponSlotWeapon(slot, pistoltype);
	self giveMaxAmmo(pistoltype);
}

randomPistol()
{
	for(;;)
	{
		switch(randomInt(4))
		{
			case 0: return "colt_mp";
			case 1: return "webley_mp";
			case 2: return "TT30_mp";
			case 3: return "luger_mp";
		}
	}
}

randomSMG()
{
	for(;;)
	{
		switch(randomInt(6))
		{
			case 0: return "thompson_mp";
			case 1: return "greasegun_mp";
			case 2: return "sten_mp";
			case 3: return "PPS42_mp";
			case 4: return "ppsh_mp";
			case 5: return "mp40_mp";
		}
	}
}

randomRifle()
{
	for(;;)
	{
		switch(randomInt(4))
		{
			case 0: return "SVT40_mp";
			case 1: return "g43_mp";
			case 2: return "m1carbine_mp";
			case 3: return "m1garand_mp";
		}
	}
}

randomBolt()
{
	for(;;)
	{
		switch(randomInt(3))
		{
			case 0: return "mosin_nagant_mp";
			case 1: return "kar98k_mp";
			case 2: return "enfield_mp";
		}
	}
}

randomSniper()
{
	for(;;)
	{
		switch(randomInt(4))
		{
			case 0: return "mosin_nagant_sniper_mp";
			case 1: return "springfield_mp";
			case 2: return "kar98k_sniper_mp";
			case 3: return "enfield_scope_mp";
		}
	}
}

randomMG()
{
	for(;;)
	{
		switch(randomInt(3))
		{
			case 0: return "mp44_mp";
			case 1: return "bren_mp";
			case 2: return "bar_mp";
		}
	}
}

enforcePistolRule()
{
	self endon("disconnect");
	level endon("intermission");

	self playLocalSound("ctf_touchcapture");

	sayBoldAll(self.name + " is on pistol rule!");

	self.pers["pistolrule"] = true;

	for(;;)
	{
		current = self getweaponslotweapon("primary");
		if(self maps\mp\gametypes\_weapons::isMainWeapon(current))
			self dropItem(current);

		current = self getweaponslotweapon("primaryb");
		if(self maps\mp\gametypes\_weapons::isMainWeapon(current))
			self dropItem(current);

		wait 0.05;
	}
}

initGameModes()
{
	self endon("disconnect");
	level endon("intermission");

	for(;;)
	{
		level waittill("togglegamemodes");
		level.crazymodetype = 0;

		if(level.gamemode == "crazy")
		{
			level.crazymodenext = getTime() + 10000;

			thread runCrazyMode();
		}
		else
		{
			level notify("endcrazymode");
		}

		if(level.gamemode == "pistol")
		{
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
				player dropItem(player getweaponslotweapon("primary"));
				player dropItem(player getweaponslotweapon("primaryb"));

				player giveRandomPistol("primary");
				player giveRandomPistol("primaryb");
			}

			thread runPistolMode();
		}
		else
		{
			level notify("endpistolmode");
		}

		if(level.gamemode == "gun")
		{
			initGunMode();
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
				players[i] giveGunModeWeapon();
		}
		else
		{
			level notify("endgunmode");
		}
	}
}

runCrazyMode()
{
	self endon("disconnect");
	level endon("intermission");
	level endon("endcrazymode");

	for(;;)
	{
		if(level.crazymodenext < getTime()) //Start next gamemode if time is up
		{
			oldgamemode = level.crazymodetype;
			while(level.crazymodetype == oldgamemode) //Randomize until new gamemode
			{
				level.crazymodetype = randomIntRange(1, 11);
			}

			timetonext = randomIntRange(20, 60);
			level.crazymodenext = getTime() + (timetonext * 1000); //Setup new time

			switch(oldgamemode) //Old gamemode cleanup
			{
				case 5:
				{
					players = getentarray("player", "classname");
					for(i = 0; i < players.size; i++)
					{
						player = players[i];
						player.pers["weapon"] = selectRandomWeaponAll();
						player giveRandomPistol("primaryb");

						player giveWeapon(player.pers["weapon"]);
						player giveMaxAmmo(player.pers["weapon"]);
						player setSpawnWeapon(player.pers["weapon"]);
					}
					break;
				}
				case 10:
				{
					players = getentarray("player", "classname");
					for(i = 0; i < players.size; i++)
					{
						player = players[i];
						player freezeControls(false);
					}
				}
			}

			switch(level.crazymodetype) //New gamemode startup code
			{
				case 1:
				{
					switch(randomInt(5))
					{
						case 0:
						{
							sayBoldAll("^4HEAD^7!");
							level.crazymodehitbox1 = "helmet";
							level.crazymodehitbox2 = "head";
							level.crazymodehitbox3 = "neck";
							break;
						}
						case 1:
						{
							sayBoldAll("^4CHEST^7!");
							level.crazymodehitbox1 = "torso_upper";
							level.crazymodehitbox2 = "torso_lower";
							level.crazymodehitbox3 = "";
							break;
						}
						case 2:
						{
							sayBoldAll("^4LEFT ARM^7!");
							level.crazymodehitbox1 = "left_arm_upper";
							level.crazymodehitbox2 = "left_arm_lower";
							level.crazymodehitbox3 = "left_hand";
							break;
						}
						case 3:
						{
							sayBoldAll("^4RIGHT ARM^7!");
							level.crazymodehitbox1 = "right_arm_upper";
							level.crazymodehitbox2 = "right_arm_lower";
							level.crazymodehitbox3 = "right_hand";
							break;
						}
						case 4:
						{
							sayBoldAll("^4LEFT LEG^7!");
							level.crazymodehitbox1 = "left_leg_upper";
							level.crazymodehitbox2 = "left_leg_lower";
							level.crazymodehitbox3 = "left_foot";
							break;
						}
						case 5:
						{
							sayBoldAll("^4RIGHT LEG^7!");
							level.crazymodehitbox1 = "right_leg_upper";
							level.crazymodehitbox2 = "right_leg_lower";
							level.crazymodehitbox3 = "right_foot";
							break;
						}
					}

					break;
				}
				case 2:
				{
					sayBoldAll("^6Double ^5Damage!");

					break;
				}
				case 3:
				{
					sayBoldAll("^1We^3apo^2n Ju^4ggl^6er");

					break;
				}
				case 4:
				{
					sayBoldAll("DRAW!");

					players = getentarray("player", "classname");
					for(i = 0; i < players.size; i++)
					{
						player = players[i];
						player dropItem(player getweaponslotweapon("primary"));
						player dropItem(player getweaponslotweapon("primaryb"));

						player giveRandomPistol("primary");
						player giveRandomPistol("primaryb");
						player setSpawnWeapon(player getweaponslotweapon("primary"));
					}

					break;
				}
				case 5:
				{
					sayBoldAll("Exp^3losi^1on Bo^3nan^7za!");

					break;
				}
				case 6:
				{
					sayBoldAll("^1Stalingrad Rush");

					break;
				}
				case 7:
				{
					sayBoldAll("^2EARTHQUAKE!");

					//earthquake( 0.3, timetonext, level.origin, 10000);

					break;
				}
				case 8:
				{
					sayBoldAll("^9Mit d^1er Pum^3pgun");

					players = getentarray("player", "classname");
					for(i = 0; i < players.size; i++)
					{
						player = players[i];
						player dropItem(player getweaponslotweapon("primary"));
						player dropItem(player getweaponslotweapon("primaryb"));

						player.pers["weapon"] = "shotgun_mp";
						player giveWeapon(player.pers["weapon"]);
						player giveMaxAmmo(player.pers["weapon"]);
						self setSpawnWeapon(self getweaponslotweapon("primary"));
					}

					break;
				}
				case 9:
				{
					sayBoldAll("JUMP!");

					break;
				}
				case 10:
				{
					sayBoldAll("Blink");

					break;
				}
			}
		}

		switch(level.crazymodetype) //Run gamecode each tick
		{
			case 4:
			{
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					current = player getweaponslotweapon("primary");
					if(player maps\mp\gametypes\_weapons::isMainWeapon(current))
						player dropItem(current);

					current = player getweaponslotweapon("primaryb");
					if(player maps\mp\gametypes\_weapons::isMainWeapon(current))
						player dropItem(current);
				}

				break;
			}
			case 5:
			{
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					player dropItem(player getweaponslotweapon("primary")); //drop weapons
					player dropItem(player getweaponslotweapon("primaryb"));

					count = player getammocount("frag_grenade_american_mp");
					count += player getammocount("frag_grenade_british_mp");
					count += player getammocount("frag_grenade_russian_mp");
					count += player getammocount("frag_grenade_german_mp");

					if(count < 1) //if no granades give a new random grenade
					{
						player takeWeapon("frag_grenade_american_mp");
						player takeWeapon("frag_grenade_british_mp");
						player takeWeapon("frag_grenade_russian_mp");
						player takeWeapon("frag_grenade_german_mp");

						grenadetype = "frag_grenade_german_mp";

						switch(randomInt(3))
						{
							case 0: grenadetype = "frag_grenade_american_mp"; break;
							case 1: grenadetype = "frag_grenade_british_mp"; break;
							case 2: grenadetype = "frag_grenade_russian_mp"; break;
							case 3: grenadetype = "frag_grenade_german_mp"; break;
						}

						player giveWeapon(grenadetype);
						player setWeaponClipAmmo(grenadetype, 1);
					}
				}

				break;
			}
			case 6:
			{
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					player setweaponslotammo("primary", 0);
					player setweaponslotammo("primaryb", 0);
					if(player getweaponslotclipammo("primary") == 0)
						player dropItem(player getweaponslotweapon("primary"));
					if(player getweaponslotclipammo("primaryb") == 0)
						player dropItem(player getweaponslotweapon("primaryb"));
				}

				break;
			}
			case 7:
			{
				if(randomInt(1000) < 5)
				{
					players = getentarray("player", "classname");
					for(i = 0; i < players.size; i++)
					{
						player = players[i];
						player thread maps\mp\gametypes\_shellshock::shellshockOnDamage("MOD_GRENADE", 30);
						player playrumble("damage_heavy");
					}
				}

				break;
			}
			case 8:
			{
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					current = player getweaponslotweapon("primary");
					if(!(current == "shotgun_mp"))
						player dropItem(current);

					current = player getweaponslotweapon("primaryb");
					if(!(current == "shotgun_mp"))
						player dropItem(current);
				}

				break;
			}
			case 10:
			{
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
					players[i].pers["frozen"] = false;

				for(i = 0; i < players.size; i++)
					for(j = 0; j < players.size; j++)
						if(players[i] isLookingAt(players[j]))
							players[j].pers["frozen"] = true;

				for(i = 0; i < players.size; i++)
					players[i] freezeControls(players[i].pers["frozen"]);

				break;
			}
		}
		wait 0.05;
	}
}

sayBoldAll(text)
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		players[i] iprintlnbold(text);
}

runPistolMode()
{
	self endon("disconnect");
	level endon("intermission");
	level endon("endpistolmode");

	for(;;)
	{
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			current = player getweaponslotweapon("primary");
			if(player maps\mp\gametypes\_weapons::isMainWeapon(current))
				player dropItem(current);

			current = player getweaponslotweapon("primaryb");
			if(player maps\mp\gametypes\_weapons::isMainWeapon(current))
				player dropItem(current);
		}
		wait 0.05;
	}
}

initGunMode()
{
	level.gunModeWeapon = [];
	weapons = [];
	weapons[0] = randomSMG();
	weapons[1] = randomSMG();
	while(weapons[1] == weapons[0])
		weapons[1] = randomSMG();
	weapons[2] = randomRifle();
	weapons[3] = randomRifle();
	while(weapons[3] == weapons[2])
		weapons[3] = randomRifle();
	weapons[4] = "shotgun_mp";
	weapons[5] = randomSniper();
	weapons[6] = randomMG();
	weapons[7] = randomPistol();
	weapons[8] = weapons[7];

	for(i = 0; i < level.scorelimit; i++)
		level.gunModeWeapon[i] = weapons[int((weapons.size / level.scorelimit) * (i + 1))];

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		player takeWeapon("frag_grenade_american_mp");
		player takeWeapon("frag_grenade_british_mp");
		player takeWeapon("frag_grenade_russian_mp");
		player takeWeapon("frag_grenade_german_mp");
		player takeWeapon("smoke_grenade_american_mp");
		player takeWeapon("smoke_grenade_british_mp");
		player takeWeapon("smoke_grenade_russian_mp");
		player takeWeapon("smoke_grenade_german_mp");
	}

	thread runGunMode();
}

runGunMode()
{
	self endon("disconnect");
	level endon("intermission");
	level endon("endgunmode");

	for(;;)
	{
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			current = player getweaponslotweapon("primary");
			if(level.gunModeWeapon[player.score] != current)
				player dropItem(current);
			player dropItem(player getweaponslotweapon("primaryb"));
		}

		wait 0.05;
	}
}

giveGunModeWeapon()
{
	weapon = level.gunModeWeapon[self.score];
	if(weapon != self getweaponslotweapon("primary"))
	{
		self setWeaponSlotWeapon("primary", weapon);
		self giveMaxAmmo(weapon);
		self setSpawnWeapon(weapon);
	}
}

gameModeRespawn()
{
	switch(level.gamemode)
	{
		case "crazy":
		{
			switch(level.crazymodetype)
			{
				case 4:
				{
					self giveRandomPistol("primary");
					self giveRandomPistol("primaryb");
					maps\mp\gametypes\_weapons::giveBinoculars();

					break;
				}
				case 5:
				{
					break;
				}
				case 8:
				{
					self.pers["weapon"] = "shotgun_mp";
					self giveWeapon(self.pers["weapon"]);
					self giveMaxAmmo(self.pers["weapon"]);
					self setSpawnWeapon(self getweaponslotweapon("primary"));

					maps\mp\gametypes\_weapons::giveGrenades();
					maps\mp\gametypes\_weapons::giveBinoculars();

					break;
				}
				default:
				{
					if(level.randomweapons)
					{
						self.pers["weapon"] = selectRandomWeaponAll();
						self giveRandomPistol("primaryb");
					}
					else
					{
						maps\mp\gametypes\_weapons::givePistol();
					}

					maps\mp\gametypes\_weapons::giveGrenades();
					maps\mp\gametypes\_weapons::giveBinoculars();

					self giveWeapon(self.pers["weapon"]);
					self giveMaxAmmo(self.pers["weapon"]);
					self setSpawnWeapon(self.pers["weapon"]);
				}
			}

			break;
		}
		case "pistol":
		{
			self.pers["weapon"] = "shotgun_mp";
			self giveRandomPistol("primary");
			self giveRandomPistol("primaryb");
			self setSpawnWeapon(self getweaponslotweapon("primary"));

			maps\mp\gametypes\_weapons::giveGrenades();
			maps\mp\gametypes\_weapons::giveBinoculars();

			break;
		}
		case "dual":
		{
			weapon1 = selectRandomWeaponAll();
			weapon2 = selectRandomWeaponAll();
			self setWeaponSlotWeapon("primary", weapon1);
			self giveMaxAmmo(weapon1);
			self setWeaponSlotWeapon("primaryb", weapon2);
			self giveMaxAmmo(weapon2);
			self setSpawnWeapon(self getweaponslotweapon("primary"));

			maps\mp\gametypes\_weapons::giveGrenades();
			maps\mp\gametypes\_weapons::giveBinoculars();

			break;
		}
		case "gun":
		{
			self giveGunModeWeapon();
			break;
		}
	}
}

checkKillstreak()
{
	switch(self.killstreak)
	{
		case 5: killstreak = " is on a Killing Spree"; break;
		case 10: killstreak = " is on a Rampage"; break;
		case 15: killstreak = " is Dominating!"; break;
		case 20: killstreak = " is Unstoppable!"; break;
		case 25: killstreak = " is ^2GODLIKE"; break;
		default: killstreak = undefined; break;
	}

	if(isDefined(killstreak))
		sayBoldAll(self.name + killstreak);
}
